Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E884460744
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 16:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358095AbhK1Pvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 10:51:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:16693 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235855AbhK1Ptv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 10:49:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="223070164"
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="223070164"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 07:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="476421174"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 28 Nov 2021 07:42:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrMJy-000ApR-0T; Sun, 28 Nov 2021 15:42:30 +0000
Date:   Sun, 28 Nov 2021 23:42:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: Re: [PATCH 3/5] staging: r8188eu: remove unused HW_VAR_RF_TYPE
Message-ID: <202111282351.uz9rOZoR-lkp@intel.com>
References: <20211128135326.9838-4-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128135326.9838-4-straube.linux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Michael-Straube/staging-r8188eu-remove-rf_type-and-rtw_rf_config/20211128-215723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 84c365f8ff8fc93a34d6cabe780d0b0f49c177e2
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211128/202111282351.uz9rOZoR-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2bbed14e0a91de19b146dc8a6202e4123bb328d8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Straube/staging-r8188eu-remove-rf_type-and-rtw_rf_config/20211128-215723
        git checkout 2bbed14e0a91de19b146dc8a6202e4123bb328d8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/staging/r8188eu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/staging/r8188eu/core/rtw_mlme.c: In function 'rtw_update_ht_cap':
>> drivers/staging/r8188eu/core/rtw_mlme.c:2004:42: error: 'HW_VAR_RF_TYPE' undeclared (first use in this function); did you mean 'HAL_RF_TYPE'?
    2004 |                 GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
         |                                          ^~~~~~~~~~~~~~
         |                                          HAL_RF_TYPE
   drivers/staging/r8188eu/core/rtw_mlme.c:2004:42: note: each undeclared identifier is reported only once for each function it appears in
--
   drivers/staging/r8188eu/core/rtw_mlme_ext.c: In function 'issue_assocreq':
>> drivers/staging/r8188eu/core/rtw_mlme_ext.c:5188:50: error: 'HW_VAR_RF_TYPE' undeclared (first use in this function); did you mean 'HAL_RF_TYPE'?
    5188 |                         GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
         |                                                  ^~~~~~~~~~~~~~
         |                                                  HAL_RF_TYPE
   drivers/staging/r8188eu/core/rtw_mlme_ext.c:5188:50: note: each undeclared identifier is reported only once for each function it appears in


vim +2004 drivers/staging/r8188eu/core/rtw_mlme.c

15865124feed88 Phillip Potter  2021-07-28  1954  
15865124feed88 Phillip Potter  2021-07-28  1955  /* the function is > passive_level (in critical_section) */
15865124feed88 Phillip Potter  2021-07-28  1956  void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len)
15865124feed88 Phillip Potter  2021-07-28  1957  {
15865124feed88 Phillip Potter  2021-07-28  1958  	u8 *p, max_ampdu_sz;
15865124feed88 Phillip Potter  2021-07-28  1959  	int len;
15865124feed88 Phillip Potter  2021-07-28  1960  	struct ieee80211_ht_cap *pht_capie;
15865124feed88 Phillip Potter  2021-07-28  1961  	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
15865124feed88 Phillip Potter  2021-07-28  1962  	struct ht_priv		*phtpriv = &pmlmepriv->htpriv;
15865124feed88 Phillip Potter  2021-07-28  1963  	struct registry_priv *pregistrypriv = &padapter->registrypriv;
15865124feed88 Phillip Potter  2021-07-28  1964  	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
a8962b247ae37c Michael Straube 2021-08-09  1965  	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
15865124feed88 Phillip Potter  2021-07-28  1966  
15865124feed88 Phillip Potter  2021-07-28  1967  	if (!phtpriv->ht_option)
15865124feed88 Phillip Potter  2021-07-28  1968  		return;
15865124feed88 Phillip Potter  2021-07-28  1969  
15865124feed88 Phillip Potter  2021-07-28  1970  	if ((!pmlmeinfo->HT_info_enable) || (!pmlmeinfo->HT_caps_enable))
15865124feed88 Phillip Potter  2021-07-28  1971  		return;
15865124feed88 Phillip Potter  2021-07-28  1972  
15865124feed88 Phillip Potter  2021-07-28  1973  	DBG_88E("+rtw_update_ht_cap()\n");
15865124feed88 Phillip Potter  2021-07-28  1974  
15865124feed88 Phillip Potter  2021-07-28  1975  	/* maybe needs check if ap supports rx ampdu. */
15865124feed88 Phillip Potter  2021-07-28  1976  	if ((!phtpriv->ampdu_enable) && (pregistrypriv->ampdu_enable == 1)) {
15865124feed88 Phillip Potter  2021-07-28  1977  		if (pregistrypriv->wifi_spec == 1)
15865124feed88 Phillip Potter  2021-07-28  1978  			phtpriv->ampdu_enable = false;
15865124feed88 Phillip Potter  2021-07-28  1979  		else
15865124feed88 Phillip Potter  2021-07-28  1980  			phtpriv->ampdu_enable = true;
15865124feed88 Phillip Potter  2021-07-28  1981  	} else if (pregistrypriv->ampdu_enable == 2) {
15865124feed88 Phillip Potter  2021-07-28  1982  		phtpriv->ampdu_enable = true;
15865124feed88 Phillip Potter  2021-07-28  1983  	}
15865124feed88 Phillip Potter  2021-07-28  1984  
15865124feed88 Phillip Potter  2021-07-28  1985  	/* check Max Rx A-MPDU Size */
15865124feed88 Phillip Potter  2021-07-28  1986  	len = 0;
15865124feed88 Phillip Potter  2021-07-28  1987  	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fixed_ie), _HT_CAPABILITY_IE_, &len, ie_len - sizeof(struct ndis_802_11_fixed_ie));
15865124feed88 Phillip Potter  2021-07-28  1988  	if (p && len > 0) {
15865124feed88 Phillip Potter  2021-07-28  1989  		pht_capie = (struct ieee80211_ht_cap *)(p + 2);
f33ce7100b6b18 Michael Straube 2021-08-14  1990  		max_ampdu_sz = (pht_capie->ampdu_params_info & IEEE80211_HT_AMPDU_PARM_FACTOR);
15865124feed88 Phillip Potter  2021-07-28  1991  		max_ampdu_sz = 1 << (max_ampdu_sz + 3); /*  max_ampdu_sz (kbytes); */
15865124feed88 Phillip Potter  2021-07-28  1992  		phtpriv->rx_ampdu_maxlen = max_ampdu_sz;
15865124feed88 Phillip Potter  2021-07-28  1993  	}
15865124feed88 Phillip Potter  2021-07-28  1994  	len = 0;
15865124feed88 Phillip Potter  2021-07-28  1995  	p = rtw_get_ie(pie + sizeof(struct ndis_802_11_fixed_ie), _HT_ADD_INFO_IE_, &len, ie_len - sizeof(struct ndis_802_11_fixed_ie));
15865124feed88 Phillip Potter  2021-07-28  1996  
15865124feed88 Phillip Potter  2021-07-28  1997  	/* update cur_bwmode & cur_ch_offset */
15865124feed88 Phillip Potter  2021-07-28  1998  	if ((pregistrypriv->cbw40_enable) &&
15865124feed88 Phillip Potter  2021-07-28  1999  	    (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) & BIT(1)) &&
15865124feed88 Phillip Potter  2021-07-28  2000  	    (pmlmeinfo->HT_info.infos[0] & BIT(2))) {
15865124feed88 Phillip Potter  2021-07-28  2001  		int i;
15865124feed88 Phillip Potter  2021-07-28  2002  		u8	rf_type;
15865124feed88 Phillip Potter  2021-07-28  2003  
9c44c0f6da146f Michael Straube 2021-10-07 @2004  		GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
15865124feed88 Phillip Potter  2021-07-28  2005  
15865124feed88 Phillip Potter  2021-07-28  2006  		/* update the MCS rates */
15865124feed88 Phillip Potter  2021-07-28  2007  		for (i = 0; i < 16; i++) {
15865124feed88 Phillip Potter  2021-07-28  2008  			if ((rf_type == RF_1T1R) || (rf_type == RF_1T2R))
15865124feed88 Phillip Potter  2021-07-28  2009  				pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= MCS_rate_1R[i];
15865124feed88 Phillip Potter  2021-07-28  2010  			else
15865124feed88 Phillip Potter  2021-07-28  2011  				pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate[i] &= MCS_rate_2R[i];
15865124feed88 Phillip Potter  2021-07-28  2012  		}
15865124feed88 Phillip Potter  2021-07-28  2013  		/* switch to the 40M Hz mode according to the AP */
15865124feed88 Phillip Potter  2021-07-28  2014  		pmlmeext->cur_bwmode = HT_CHANNEL_WIDTH_40;
15865124feed88 Phillip Potter  2021-07-28  2015  		switch ((pmlmeinfo->HT_info.infos[0] & 0x3)) {
15865124feed88 Phillip Potter  2021-07-28  2016  		case HT_EXTCHNL_OFFSET_UPPER:
15865124feed88 Phillip Potter  2021-07-28  2017  			pmlmeext->cur_ch_offset = HAL_PRIME_CHNL_OFFSET_LOWER;
15865124feed88 Phillip Potter  2021-07-28  2018  			break;
15865124feed88 Phillip Potter  2021-07-28  2019  		case HT_EXTCHNL_OFFSET_LOWER:
15865124feed88 Phillip Potter  2021-07-28  2020  			pmlmeext->cur_ch_offset = HAL_PRIME_CHNL_OFFSET_UPPER;
15865124feed88 Phillip Potter  2021-07-28  2021  			break;
15865124feed88 Phillip Potter  2021-07-28  2022  		default:
15865124feed88 Phillip Potter  2021-07-28  2023  			pmlmeext->cur_ch_offset = HAL_PRIME_CHNL_OFFSET_DONT_CARE;
15865124feed88 Phillip Potter  2021-07-28  2024  			break;
15865124feed88 Phillip Potter  2021-07-28  2025  		}
15865124feed88 Phillip Potter  2021-07-28  2026  	}
15865124feed88 Phillip Potter  2021-07-28  2027  
15865124feed88 Phillip Potter  2021-07-28  2028  	/*  Config SM Power Save setting */
15865124feed88 Phillip Potter  2021-07-28  2029  	pmlmeinfo->SM_PS = (le16_to_cpu(pmlmeinfo->HT_caps.u.HT_cap_element.HT_caps_info) & 0x0C) >> 2;
15865124feed88 Phillip Potter  2021-07-28  2030  	if (pmlmeinfo->SM_PS == WLAN_HT_CAP_SM_PS_STATIC)
15865124feed88 Phillip Potter  2021-07-28  2031  		DBG_88E("%s(): WLAN_HT_CAP_SM_PS_STATIC\n", __func__);
15865124feed88 Phillip Potter  2021-07-28  2032  
15865124feed88 Phillip Potter  2021-07-28  2033  	/*  Config current HT Protection mode. */
15865124feed88 Phillip Potter  2021-07-28  2034  	pmlmeinfo->HT_protection = pmlmeinfo->HT_info.infos[1] & 0x3;
15865124feed88 Phillip Potter  2021-07-28  2035  }
15865124feed88 Phillip Potter  2021-07-28  2036  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
