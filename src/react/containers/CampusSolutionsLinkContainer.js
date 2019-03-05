import React from 'react';
import PropTypes from 'prop-types';
import _ from 'lodash';

import { fixLastQuestionMark, updateQueryStringParameter } from '../helpers/linkHelper';
import CampusSolutionsLink from '../components/base/link/CampusSolutionsLink';
import CampusSolutionsOutboundLink from '../components/base/link/CampusSolutionsOutboundLink';
import CampusSolutionsHigherDegreeCommitteeFormLink from '../components/base/link/CampusSolutionsHigherDegreeCommitteeFormLink';

class CampusSolutionsLinkContainer extends React.Component {
  constructor(props) {
    super(props);
    this.decorateLinkUrl = this.decorateLinkUrl.bind(this);
    this.getLinkConfig = this.getLinkConfig.bind(this);
    this.getUcFromParamConfig = this.getUcFromParamConfig.bind(this);
  }
  decorateLinkUrl(linkUrl, includeUcFrom, includeUcFromLink, includeUcFromText, ccCacheString, ccPageName, ccPageUrl) {
    if (/^http/.test(linkUrl) && includeUcFrom === true) {
      linkUrl = fixLastQuestionMark(linkUrl);

      if (includeUcFrom) {
        linkUrl = updateQueryStringParameter(linkUrl, 'ucFrom', 'CalCentral');
      }
      if (includeUcFromText) {
        const urlEncodedCcPageText = encodeURIComponent(ccPageName);
        linkUrl = updateQueryStringParameter(linkUrl, 'ucFromText', urlEncodedCcPageText);
      }
      if (includeUcFromLink) {
        if (ccCacheString) {
          ccPageUrl = updateQueryStringParameter(ccPageUrl, 'ucUpdateCache', ccCacheString);
        }
        var urlEncodedCcPageUrl = encodeURIComponent(ccPageUrl);
        linkUrl = updateQueryStringParameter(linkUrl, 'ucFromLink', urlEncodedCcPageUrl);
      }
    }
    return linkUrl;
  }
  getLinkConfig(linkObj) {
    const ccCacheString = _.get(linkObj, 'ccCache');
    const ccPageName = _.get(linkObj, 'ccPageName') || 'CalCentral';
    const ccPageUrl = _.get(linkObj, 'ccPageUrl');
    const ucFromParamsConfig = this.getUcFromParamConfig(linkObj);
    const linkId = _.get(linkObj, 'urlId');
    const linkUrl = this.decorateLinkUrl(linkObj.url,
      ucFromParamsConfig.includeUcFrom,
      ucFromParamsConfig.includeUcFromLink,
      ucFromParamsConfig.includeUcFromText,
      ccCacheString,
      ccPageName,
      ccPageUrl);
    const showNewWindow = _.get(linkObj, 'shownewwindow') || _.get(linkObj, 'showNewWindow') || false;
    const linkBody = _.get(linkObj, 'name');
    const linkHoverText = _.get(linkObj, 'title') || false;
    return { linkBody, linkHoverText, linkUrl, linkId, showNewWindow };
  }
  getUcFromParamConfig(linkObj) {
    const includeUcFrom = !!(_.get(linkObj, 'ucfrom') || _.get(linkObj, 'ucFrom')) || false;
    const includeUcFromLink = !!(_.get(linkObj, 'ucfromlink') || _.get(linkObj, 'ucFromLink')) || false;
    const includeUcFromText = !!(_.get(linkObj, 'ucfromtext') || _.get(linkObj, 'ucFromText')) || false;
    return { includeUcFrom, includeUcFromLink, includeUcFromText };
  }
  render() {
    const linkConfig = this.getLinkConfig(this.props.linkObj);
    if (linkConfig.linkId === 'UC_CX_GT_AAQEAPPLIC_ADD') {
      return (<CampusSolutionsHigherDegreeCommitteeFormLink linkConfig={linkConfig} />);
    }
    if (linkConfig.showNewWindow) {
      return (<CampusSolutionsOutboundLink linkConfig={linkConfig} />);
    } else {
      return (<CampusSolutionsLink linkConfig={linkConfig} />);
    }
  }
}
CampusSolutionsLinkContainer.propTypes = {
  linkObj: PropTypes.object.isRequired
};

export default CampusSolutionsLinkContainer;
