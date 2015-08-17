require 'spec_helper'

describe CampusSolutions::NameType do

  shared_examples 'a proxy that gets data' do
    subject { proxy.get }
    it_should_behave_like 'a simple proxy that returns errors'

    it 'returns JSON fixture data by default' do
      expect(subject[:feed][:nameTypes]).to be
    end
  end

  context 'mock proxy' do
    let(:proxy) { CampusSolutions::NameType.new(fake: true) }
    it_should_behave_like 'a proxy that gets data'
  end

  context 'real proxy', testext: true do
    let(:proxy) { CampusSolutions::NameType.new(fake: false) }
    it_should_behave_like 'a proxy that gets data'
  end

end
