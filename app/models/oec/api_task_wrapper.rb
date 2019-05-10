module Oec
  class ApiTaskWrapper
    include BackgroundThread
    include ClassLogger

    TASK_LIST = [
      {
        name: 'TermSetupTask',
        friendlyName: 'Term setup',
        htmlDescription: 'Create a Google Drive folder under a new term code (e.g., <strong>2017-D</strong>) and populate it with initial folders and files.'
      },
      {
        name: 'SisImportTask',
        friendlyName: 'SIS data import',
        htmlDescription: "Import course and instructor data for one or more campus departments. Imported data will appear in a new, timestamped subfolder of the <strong>#{Oec::Folder.sis_imports}</strong> folder.",
        departmentOptions: 'single'
      },
      {
        name: 'CreateConfirmationSheetsTask',
        friendlyName: 'Create confirmation sheets',
        htmlDescription: "Create confirmation sheets for review and edits by department administrators. Sheets will appear under the <strong>#{Oec::Folder.confirmations}</strong> folder. If that folder contains a sheet named <strong>TEMPLATE</strong>, it will be used as a model for the confirmation sheets.",
        departmentOptions: 'single'
      },
      {
        name: 'ReportDiffTask',
        friendlyName: 'Diff confirmation sheets',
        htmlDescription: "Compare department confirmation sheets to the most recent SIS import data and report on differences. The diff report will appear as a new sheet in the <strong>#{Oec::Folder.confirmations}</strong> folder, and will replace any previous diff report.",
        departmentOptions: 'single'
      },
      {
        name: 'MergeConfirmationSheetsTask',
        friendlyName: 'Merge confirmation sheets',
        htmlDescription: "Merge confirmation sheets from participating departments into master sheets for preflight review. Two new sheets will be created in the <strong>#{Oec::Folder.merged_confirmations}</strong> folder: <strong>Merged course confirmations</strong> and <strong>Merged supervisor confirmations</strong>.",
        departmentOptions: 'multiple'
      },
      {
        name: 'ValidationTask',
        friendlyName: 'Validate confirmed data',
        htmlDescription: "Run a validation report on merged confirmation sheets. Validation results will appear in a dated subfolder of the <strong>#{Oec::Folder.logs}</strong> folder."
      },
      {
        name: 'PublishTask',
        friendlyName: 'Publish confirmed data to Explorance',
        htmlDescription: "Validate and export merged confirmation sheets. Files will be uploaded to the vendor only if validation passes. A copy of the uploaded data will appear in a timestamped subfolder of the <strong>#{Oec::Folder.published}</strong> folder."
      }
    ]

    def self.department_list
      participating_department_codes = Oec::CourseCode.participating_dept_codes
      departments = Berkeley::Departments.department_map.map do |k,v|
        {
          code: k,
          name: Berkeley::Departments.shortened(v),
          participating: participating_department_codes.include?(k)
        }
      end
      departments.sort_by { |dept| dept[:name] }
    end

    def self.generate_task_id
      [Time.now.to_f.to_s.gsub('.', ''), SecureRandom.hex(8)].join '-'
    end

    def initialize(task_class, params)
      @task_class = task_class
      @params = translate_params(params)
    end

    def run(task_id)
      task = @task_class.new @params.merge(api_task_id: task_id, log_to_cache: true, allow_past_term: true)
      task.run
    end

    def start_in_background
      task_id = self.class.generate_task_id
      # Ensure that a Task Status entry will be found in the cache even before the queued
      # background job starts.
      @task_class.write_cache(
        {status: 'In progress', log: []},
        task_id
      )
      self.background(future_ttl: 5000).run(task_id)
      {
        id: task_id,
        status: 'In progress'
      }
    end

    private

    def translate_params(params)
      term_code = Berkeley::TermCodes.from_english params['term']
      translated_params = {
        term_code: "#{term_code[:term_yr]}-#{term_code[:term_cd]}"
      }
      if params['departmentCode'].present?
        translated_params.merge!({
          dept_codes: Array.wrap(params['departmentCode']).join(' ')
        })
      end
      translated_params
    end

  end
end
