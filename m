Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5034607B6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 17:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353115AbhK1Qyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 11:54:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:37348 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234295AbhK1Qwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 11:52:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="234573783"
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="234573783"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 08:44:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="676060167"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 28 Nov 2021 08:44:31 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrNHz-000AsO-0N; Sun, 28 Nov 2021 16:44:31 +0000
Date:   Mon, 29 Nov 2021 00:43:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: Re: [PATCH 4/5] staging: r8188eu: remove rf_type from struct
 hal_data_8188e
Message-ID: <202111290017.K4fY1Rzb-lkp@intel.com>
References: <20211128135326.9838-5-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128135326.9838-5-straube.linux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Michael-Straube/staging-r8188eu-remove-rf_type-and-rtw_rf_config/20211128-215723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 84c365f8ff8fc93a34d6cabe780d0b0f49c177e2
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211129/202111290017.K4fY1Rzb-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/24ae4273c618f09d6a87c4c86b67a18a8fbacc59
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Straube/staging-r8188eu-remove-rf_type-and-rtw_rf_config/20211128-215723
        git checkout 24ae4273c618f09d6a87c4c86b67a18a8fbacc59
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/staging/r8188eu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c: In function 'storePwrIndexDiffRateOffset':
>> drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:509:29: error: 'struct hal_data_8188e' has no member named 'rf_type'
     509 |                 if (pHalData->rf_type == RF_1T1R)
         |                             ^~
   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:528:29: error: 'struct hal_data_8188e' has no member named 'rf_type'
     528 |                 if (pHalData->rf_type != RF_1T1R)
         |                             ^~
   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c: In function 'getTxPowerIndex88E':
   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:620:33: error: 'struct hal_data_8188e' has no member named 'rf_type'
     620 |         if ((RF_1T2R == pHalData->rf_type) || (RF_1T1R == pHalData->rf_type))
         |                                 ^~
   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:620:67: error: 'struct hal_data_8188e' has no member named 'rf_type'
     620 |         if ((RF_1T2R == pHalData->rf_type) || (RF_1T1R == pHalData->rf_type))
         |                                                                   ^~


vim +509 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c

8cd574e6af5463 Phillip Potter 2021-07-28  488  
8cd574e6af5463 Phillip Potter 2021-07-28  489  void storePwrIndexDiffRateOffset(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u32 Data)
8cd574e6af5463 Phillip Potter 2021-07-28  490  {
8cd574e6af5463 Phillip Potter 2021-07-28  491  	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
8cd574e6af5463 Phillip Potter 2021-07-28  492  
8cd574e6af5463 Phillip Potter 2021-07-28  493  	if (RegAddr == rTxAGC_A_Rate18_06)
8cd574e6af5463 Phillip Potter 2021-07-28  494  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][0] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  495  	if (RegAddr == rTxAGC_A_Rate54_24)
8cd574e6af5463 Phillip Potter 2021-07-28  496  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][1] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  497  	if (RegAddr == rTxAGC_A_CCK1_Mcs32)
8cd574e6af5463 Phillip Potter 2021-07-28  498  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][6] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  499  	if (RegAddr == rTxAGC_B_CCK11_A_CCK2_11 && BitMask == 0xffffff00)
8cd574e6af5463 Phillip Potter 2021-07-28  500  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][7] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  501  	if (RegAddr == rTxAGC_A_Mcs03_Mcs00)
8cd574e6af5463 Phillip Potter 2021-07-28  502  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][2] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  503  	if (RegAddr == rTxAGC_A_Mcs07_Mcs04)
8cd574e6af5463 Phillip Potter 2021-07-28  504  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][3] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  505  	if (RegAddr == rTxAGC_A_Mcs11_Mcs08)
8cd574e6af5463 Phillip Potter 2021-07-28  506  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][4] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  507  	if (RegAddr == rTxAGC_A_Mcs15_Mcs12) {
8cd574e6af5463 Phillip Potter 2021-07-28  508  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][5] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28 @509  		if (pHalData->rf_type == RF_1T1R)
8cd574e6af5463 Phillip Potter 2021-07-28  510  			pHalData->pwrGroupCnt++;
8cd574e6af5463 Phillip Potter 2021-07-28  511  	}
8cd574e6af5463 Phillip Potter 2021-07-28  512  	if (RegAddr == rTxAGC_B_Rate18_06)
8cd574e6af5463 Phillip Potter 2021-07-28  513  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][8] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  514  	if (RegAddr == rTxAGC_B_Rate54_24)
8cd574e6af5463 Phillip Potter 2021-07-28  515  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][9] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  516  	if (RegAddr == rTxAGC_B_CCK1_55_Mcs32)
8cd574e6af5463 Phillip Potter 2021-07-28  517  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][14] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  518  	if (RegAddr == rTxAGC_B_CCK11_A_CCK2_11 && BitMask == 0x000000ff)
8cd574e6af5463 Phillip Potter 2021-07-28  519  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][15] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  520  	if (RegAddr == rTxAGC_B_Mcs03_Mcs00)
8cd574e6af5463 Phillip Potter 2021-07-28  521  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][10] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  522  	if (RegAddr == rTxAGC_B_Mcs07_Mcs04)
8cd574e6af5463 Phillip Potter 2021-07-28  523  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][11] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  524  	if (RegAddr == rTxAGC_B_Mcs11_Mcs08)
8cd574e6af5463 Phillip Potter 2021-07-28  525  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][12] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  526  	if (RegAddr == rTxAGC_B_Mcs15_Mcs12) {
8cd574e6af5463 Phillip Potter 2021-07-28  527  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][13] = Data;
8cd574e6af5463 Phillip Potter 2021-07-28  528  		if (pHalData->rf_type != RF_1T1R)
8cd574e6af5463 Phillip Potter 2021-07-28  529  			pHalData->pwrGroupCnt++;
8cd574e6af5463 Phillip Potter 2021-07-28  530  	}
8cd574e6af5463 Phillip Potter 2021-07-28  531  }
8cd574e6af5463 Phillip Potter 2021-07-28  532  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
