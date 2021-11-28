Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D30460828
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 18:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358661AbhK1Rvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 12:51:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:51007 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345801AbhK1Rtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 12:49:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="223077594"
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="223077594"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 09:46:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="608414584"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2021 09:46:33 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrOG1-000Awl-8M; Sun, 28 Nov 2021 17:46:33 +0000
Date:   Mon, 29 Nov 2021 01:45:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     kbuild-all@lists.01.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: Re: [PATCH 5/5] staging: r8188eu: remove module parameter
 rtw_rf_config
Message-ID: <202111290156.knQNxdhP-lkp@intel.com>
References: <20211128135326.9838-6-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128135326.9838-6-straube.linux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/0day-ci/linux/commits/Michael-Straube/staging-r8188eu-remove-rf_type-and-rtw_rf_config/20211128-215723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git 84c365f8ff8fc93a34d6cabe780d0b0f49c177e2
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20211129/202111290156.knQNxdhP-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/598ff48bdd977b1ec251f5b9ea41320aa5b36ef0
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michael-Straube/staging-r8188eu-remove-rf_type-and-rtw_rf_config/20211128-215723
        git checkout 598ff48bdd977b1ec251f5b9ea41320aa5b36ef0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/staging/r8188eu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c: In function 'storePwrIndexDiffRateOffset':
   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:509:29: error: 'struct hal_data_8188e' has no member named 'rf_type'
     509 |                 if (pHalData->rf_type == RF_1T1R)
         |                             ^~
>> drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:509:42: error: 'RF_1T1R' undeclared (first use in this function)
     509 |                 if (pHalData->rf_type == RF_1T1R)
         |                                          ^~~~~~~
   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:509:42: note: each undeclared identifier is reported only once for each function it appears in
   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:528:29: error: 'struct hal_data_8188e' has no member named 'rf_type'
     528 |                 if (pHalData->rf_type != RF_1T1R)
         |                             ^~
   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c: In function 'getTxPowerIndex88E':
>> drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:620:14: error: 'RF_1T2R' undeclared (first use in this function)
     620 |         if ((RF_1T2R == pHalData->rf_type) || (RF_1T1R == pHalData->rf_type))
         |              ^~~~~~~
   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:620:33: error: 'struct hal_data_8188e' has no member named 'rf_type'
     620 |         if ((RF_1T2R == pHalData->rf_type) || (RF_1T1R == pHalData->rf_type))
         |                                 ^~
   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:620:48: error: 'RF_1T1R' undeclared (first use in this function)
     620 |         if ((RF_1T2R == pHalData->rf_type) || (RF_1T1R == pHalData->rf_type))
         |                                                ^~~~~~~
   drivers/staging/r8188eu/hal/rtl8188e_phycfg.c:620:67: error: 'struct hal_data_8188e' has no member named 'rf_type'
     620 |         if ((RF_1T2R == pHalData->rf_type) || (RF_1T1R == pHalData->rf_type))
         |                                                                   ^~
--
   drivers/staging/r8188eu/core/rtw_mlme.c: In function 'rtw_update_ht_cap':
   drivers/staging/r8188eu/core/rtw_mlme.c:2004:42: error: 'HW_VAR_RF_TYPE' undeclared (first use in this function); did you mean 'HAL_RF_TYPE'?
    2004 |                 GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
         |                                          ^~~~~~~~~~~~~~
         |                                          HAL_RF_TYPE
   drivers/staging/r8188eu/core/rtw_mlme.c:2004:42: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/staging/r8188eu/core/rtw_mlme.c:2008:41: error: 'RF_1T1R' undeclared (first use in this function)
    2008 |                         if ((rf_type == RF_1T1R) || (rf_type == RF_1T2R))
         |                                         ^~~~~~~
>> drivers/staging/r8188eu/core/rtw_mlme.c:2008:65: error: 'RF_1T2R' undeclared (first use in this function)
    2008 |                         if ((rf_type == RF_1T1R) || (rf_type == RF_1T2R))
         |                                                                 ^~~~~~~
--
   drivers/staging/r8188eu/core/rtw_mlme_ext.c: In function 'issue_assocreq':
   drivers/staging/r8188eu/core/rtw_mlme_ext.c:5188:50: error: 'HW_VAR_RF_TYPE' undeclared (first use in this function); did you mean 'HAL_RF_TYPE'?
    5188 |                         GetHwReg8188EU(padapter, HW_VAR_RF_TYPE, (u8 *)(&rf_type));
         |                                                  ^~~~~~~~~~~~~~
         |                                                  HAL_RF_TYPE
   drivers/staging/r8188eu/core/rtw_mlme_ext.c:5188:50: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/staging/r8188eu/core/rtw_mlme_ext.c:5190:30: error: 'RF_1T1R' undeclared (first use in this function)
    5190 |                         case RF_1T1R:
         |                              ^~~~~~~
>> drivers/staging/r8188eu/core/rtw_mlme_ext.c:5195:30: error: 'RF_2T2R' undeclared (first use in this function)
    5195 |                         case RF_2T2R:
         |                              ^~~~~~~
>> drivers/staging/r8188eu/core/rtw_mlme_ext.c:5196:30: error: 'RF_1T2R' undeclared (first use in this function)
    5196 |                         case RF_1T2R:
         |                              ^~~~~~~


vim +/RF_1T1R +509 drivers/staging/r8188eu/hal/rtl8188e_phycfg.c

8cd574e6af5463 Phillip Potter  2021-07-28  488  
8cd574e6af5463 Phillip Potter  2021-07-28  489  void storePwrIndexDiffRateOffset(struct adapter *Adapter, u32 RegAddr, u32 BitMask, u32 Data)
8cd574e6af5463 Phillip Potter  2021-07-28  490  {
8cd574e6af5463 Phillip Potter  2021-07-28  491  	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
8cd574e6af5463 Phillip Potter  2021-07-28  492  
8cd574e6af5463 Phillip Potter  2021-07-28  493  	if (RegAddr == rTxAGC_A_Rate18_06)
8cd574e6af5463 Phillip Potter  2021-07-28  494  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][0] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  495  	if (RegAddr == rTxAGC_A_Rate54_24)
8cd574e6af5463 Phillip Potter  2021-07-28  496  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][1] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  497  	if (RegAddr == rTxAGC_A_CCK1_Mcs32)
8cd574e6af5463 Phillip Potter  2021-07-28  498  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][6] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  499  	if (RegAddr == rTxAGC_B_CCK11_A_CCK2_11 && BitMask == 0xffffff00)
8cd574e6af5463 Phillip Potter  2021-07-28  500  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][7] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  501  	if (RegAddr == rTxAGC_A_Mcs03_Mcs00)
8cd574e6af5463 Phillip Potter  2021-07-28  502  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][2] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  503  	if (RegAddr == rTxAGC_A_Mcs07_Mcs04)
8cd574e6af5463 Phillip Potter  2021-07-28  504  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][3] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  505  	if (RegAddr == rTxAGC_A_Mcs11_Mcs08)
8cd574e6af5463 Phillip Potter  2021-07-28  506  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][4] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  507  	if (RegAddr == rTxAGC_A_Mcs15_Mcs12) {
8cd574e6af5463 Phillip Potter  2021-07-28  508  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][5] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28 @509  		if (pHalData->rf_type == RF_1T1R)
8cd574e6af5463 Phillip Potter  2021-07-28  510  			pHalData->pwrGroupCnt++;
8cd574e6af5463 Phillip Potter  2021-07-28  511  	}
8cd574e6af5463 Phillip Potter  2021-07-28  512  	if (RegAddr == rTxAGC_B_Rate18_06)
8cd574e6af5463 Phillip Potter  2021-07-28  513  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][8] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  514  	if (RegAddr == rTxAGC_B_Rate54_24)
8cd574e6af5463 Phillip Potter  2021-07-28  515  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][9] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  516  	if (RegAddr == rTxAGC_B_CCK1_55_Mcs32)
8cd574e6af5463 Phillip Potter  2021-07-28  517  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][14] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  518  	if (RegAddr == rTxAGC_B_CCK11_A_CCK2_11 && BitMask == 0x000000ff)
8cd574e6af5463 Phillip Potter  2021-07-28  519  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][15] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  520  	if (RegAddr == rTxAGC_B_Mcs03_Mcs00)
8cd574e6af5463 Phillip Potter  2021-07-28  521  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][10] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  522  	if (RegAddr == rTxAGC_B_Mcs07_Mcs04)
8cd574e6af5463 Phillip Potter  2021-07-28  523  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][11] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  524  	if (RegAddr == rTxAGC_B_Mcs11_Mcs08)
8cd574e6af5463 Phillip Potter  2021-07-28  525  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][12] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  526  	if (RegAddr == rTxAGC_B_Mcs15_Mcs12) {
8cd574e6af5463 Phillip Potter  2021-07-28  527  		pHalData->MCSTxPowerLevelOriginalOffset[pHalData->pwrGroupCnt][13] = Data;
8cd574e6af5463 Phillip Potter  2021-07-28  528  		if (pHalData->rf_type != RF_1T1R)
8cd574e6af5463 Phillip Potter  2021-07-28  529  			pHalData->pwrGroupCnt++;
8cd574e6af5463 Phillip Potter  2021-07-28  530  	}
8cd574e6af5463 Phillip Potter  2021-07-28  531  }
8cd574e6af5463 Phillip Potter  2021-07-28  532  
8cd574e6af5463 Phillip Potter  2021-07-28  533  static	int phy_BB8188E_Config_ParaFile(struct adapter *Adapter)
8cd574e6af5463 Phillip Potter  2021-07-28  534  {
2f4b652d744fa6 Michael Straube 2021-09-12  535  	struct eeprom_priv *pEEPROM = &Adapter->eeprompriv;
8cd574e6af5463 Phillip Potter  2021-07-28  536  	struct hal_data_8188e		*pHalData = GET_HAL_DATA(Adapter);
8cd574e6af5463 Phillip Potter  2021-07-28  537  	int			rtStatus = _SUCCESS;
8cd574e6af5463 Phillip Potter  2021-07-28  538  
8cd574e6af5463 Phillip Potter  2021-07-28  539  	/*  */
8cd574e6af5463 Phillip Potter  2021-07-28  540  	/*  1. Read PHY_REG.TXT BB INIT!! */
8cd574e6af5463 Phillip Potter  2021-07-28  541  	/*  We will separate as 88C / 92C according to chip version */
8cd574e6af5463 Phillip Potter  2021-07-28  542  	/*  */
8cd574e6af5463 Phillip Potter  2021-07-28  543  	if (HAL_STATUS_FAILURE == ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv, CONFIG_BB_PHY_REG))
8cd574e6af5463 Phillip Potter  2021-07-28  544  		rtStatus = _FAIL;
8cd574e6af5463 Phillip Potter  2021-07-28  545  	if (rtStatus != _SUCCESS)
8cd574e6af5463 Phillip Potter  2021-07-28  546  		goto phy_BB8190_Config_ParaFile_Fail;
8cd574e6af5463 Phillip Potter  2021-07-28  547  
8cd574e6af5463 Phillip Potter  2021-07-28  548  	/*  2. If EEPROM or EFUSE autoload OK, We must config by PHY_REG_PG.txt */
8cd574e6af5463 Phillip Potter  2021-07-28  549  	if (!pEEPROM->bautoload_fail_flag) {
8cd574e6af5463 Phillip Potter  2021-07-28  550  		pHalData->pwrGroupCnt = 0;
8cd574e6af5463 Phillip Potter  2021-07-28  551  
8cd574e6af5463 Phillip Potter  2021-07-28  552  		if (HAL_STATUS_FAILURE == ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv, CONFIG_BB_PHY_REG_PG))
8cd574e6af5463 Phillip Potter  2021-07-28  553  			rtStatus = _FAIL;
8cd574e6af5463 Phillip Potter  2021-07-28  554  	}
8cd574e6af5463 Phillip Potter  2021-07-28  555  
8cd574e6af5463 Phillip Potter  2021-07-28  556  	if (rtStatus != _SUCCESS)
8cd574e6af5463 Phillip Potter  2021-07-28  557  		goto phy_BB8190_Config_ParaFile_Fail;
8cd574e6af5463 Phillip Potter  2021-07-28  558  
8cd574e6af5463 Phillip Potter  2021-07-28  559  	/*  3. BB AGC table Initialization */
8cd574e6af5463 Phillip Potter  2021-07-28  560  	if (HAL_STATUS_FAILURE == ODM_ConfigBBWithHeaderFile(&pHalData->odmpriv,  CONFIG_BB_AGC_TAB))
8cd574e6af5463 Phillip Potter  2021-07-28  561  		rtStatus = _FAIL;
8cd574e6af5463 Phillip Potter  2021-07-28  562  
8cd574e6af5463 Phillip Potter  2021-07-28  563  	if (rtStatus != _SUCCESS)
8cd574e6af5463 Phillip Potter  2021-07-28  564  		goto phy_BB8190_Config_ParaFile_Fail;
8cd574e6af5463 Phillip Potter  2021-07-28  565  
8cd574e6af5463 Phillip Potter  2021-07-28  566  phy_BB8190_Config_ParaFile_Fail:
8cd574e6af5463 Phillip Potter  2021-07-28  567  
8cd574e6af5463 Phillip Potter  2021-07-28  568  	return rtStatus;
8cd574e6af5463 Phillip Potter  2021-07-28  569  }
8cd574e6af5463 Phillip Potter  2021-07-28  570  
8cd574e6af5463 Phillip Potter  2021-07-28  571  int
8cd574e6af5463 Phillip Potter  2021-07-28  572  PHY_BBConfig8188E(
8cd574e6af5463 Phillip Potter  2021-07-28  573  		struct adapter *Adapter
8cd574e6af5463 Phillip Potter  2021-07-28  574  	)
8cd574e6af5463 Phillip Potter  2021-07-28  575  {
8cd574e6af5463 Phillip Potter  2021-07-28  576  	int	rtStatus = _SUCCESS;
8cd574e6af5463 Phillip Potter  2021-07-28  577  	struct hal_data_8188e	*pHalData = GET_HAL_DATA(Adapter);
8cd574e6af5463 Phillip Potter  2021-07-28  578  	u32 RegVal;
8cd574e6af5463 Phillip Potter  2021-07-28  579  	u8 CrystalCap;
8cd574e6af5463 Phillip Potter  2021-07-28  580  
8cd574e6af5463 Phillip Potter  2021-07-28  581  	phy_InitBBRFRegisterDefinition(Adapter);
8cd574e6af5463 Phillip Potter  2021-07-28  582  
8cd574e6af5463 Phillip Potter  2021-07-28  583  	/*  Enable BB and RF */
8cd574e6af5463 Phillip Potter  2021-07-28  584  	RegVal = rtw_read16(Adapter, REG_SYS_FUNC_EN);
dcda94c9412a07 Larry Finger    2021-08-10  585  	rtw_write16(Adapter, REG_SYS_FUNC_EN, (u16)(RegVal | BIT(13) | BIT(0) | BIT(1)));
8cd574e6af5463 Phillip Potter  2021-07-28  586  
8cd574e6af5463 Phillip Potter  2021-07-28  587  	/*  20090923 Joseph: Advised by Steven and Jenyu. Power sequence before init RF. */
8cd574e6af5463 Phillip Potter  2021-07-28  588  
8cd574e6af5463 Phillip Potter  2021-07-28  589  	rtw_write8(Adapter, REG_RF_CTRL, RF_EN | RF_RSTB | RF_SDMRSTB);
8cd574e6af5463 Phillip Potter  2021-07-28  590  
8cd574e6af5463 Phillip Potter  2021-07-28  591  	rtw_write8(Adapter, REG_SYS_FUNC_EN, FEN_USBA | FEN_USBD | FEN_BB_GLB_RSTn | FEN_BBRSTB);
8cd574e6af5463 Phillip Potter  2021-07-28  592  
8cd574e6af5463 Phillip Potter  2021-07-28  593  	/*  Config BB and AGC */
8cd574e6af5463 Phillip Potter  2021-07-28  594  	rtStatus = phy_BB8188E_Config_ParaFile(Adapter);
8cd574e6af5463 Phillip Potter  2021-07-28  595  
8cd574e6af5463 Phillip Potter  2021-07-28  596  	/*  write 0x24[16:11] = 0x24[22:17] = CrystalCap */
8cd574e6af5463 Phillip Potter  2021-07-28  597  	CrystalCap = pHalData->CrystalCap & 0x3F;
8cd574e6af5463 Phillip Potter  2021-07-28  598  	PHY_SetBBReg(Adapter, REG_AFE_XTAL_CTRL, 0x7ff800, (CrystalCap | (CrystalCap << 6)));
8cd574e6af5463 Phillip Potter  2021-07-28  599  
8cd574e6af5463 Phillip Potter  2021-07-28  600  	return rtStatus;
8cd574e6af5463 Phillip Potter  2021-07-28  601  }
8cd574e6af5463 Phillip Potter  2021-07-28  602  
8cd574e6af5463 Phillip Potter  2021-07-28  603  int PHY_RFConfig8188E(struct adapter *Adapter)
8cd574e6af5463 Phillip Potter  2021-07-28  604  {
8cd574e6af5463 Phillip Potter  2021-07-28  605  	int		rtStatus = _SUCCESS;
8cd574e6af5463 Phillip Potter  2021-07-28  606  
8cd574e6af5463 Phillip Potter  2021-07-28  607  	/*  RF config */
8cd574e6af5463 Phillip Potter  2021-07-28  608  	rtStatus = PHY_RF6052_Config8188E(Adapter);
8cd574e6af5463 Phillip Potter  2021-07-28  609  	return rtStatus;
8cd574e6af5463 Phillip Potter  2021-07-28  610  }
8cd574e6af5463 Phillip Potter  2021-07-28  611  
8cd574e6af5463 Phillip Potter  2021-07-28  612  static void getTxPowerIndex88E(struct adapter *Adapter, u8 channel, u8 *cckPowerLevel,
8cd574e6af5463 Phillip Potter  2021-07-28  613  			       u8 *ofdmPowerLevel, u8 *BW20PowerLevel,
8cd574e6af5463 Phillip Potter  2021-07-28  614  			       u8 *BW40PowerLevel)
8cd574e6af5463 Phillip Potter  2021-07-28  615  {
8cd574e6af5463 Phillip Potter  2021-07-28  616  	struct hal_data_8188e *pHalData = GET_HAL_DATA(Adapter);
8cd574e6af5463 Phillip Potter  2021-07-28  617  	u8 index = (channel - 1);
8cd574e6af5463 Phillip Potter  2021-07-28  618  	u8 TxCount = 0, path_nums;
8cd574e6af5463 Phillip Potter  2021-07-28  619  
8cd574e6af5463 Phillip Potter  2021-07-28 @620  	if ((RF_1T2R == pHalData->rf_type) || (RF_1T1R == pHalData->rf_type))
8cd574e6af5463 Phillip Potter  2021-07-28  621  		path_nums = 1;
8cd574e6af5463 Phillip Potter  2021-07-28  622  	else
8cd574e6af5463 Phillip Potter  2021-07-28  623  		path_nums = 2;
8cd574e6af5463 Phillip Potter  2021-07-28  624  
8cd574e6af5463 Phillip Potter  2021-07-28  625  	for (TxCount = 0; TxCount < path_nums; TxCount++) {
8cd574e6af5463 Phillip Potter  2021-07-28  626  		if (TxCount == RF_PATH_A) {
8cd574e6af5463 Phillip Potter  2021-07-28  627  			/*  1. CCK */
8cd574e6af5463 Phillip Potter  2021-07-28  628  			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  629  			/* 2. OFDM */
8cd574e6af5463 Phillip Potter  2021-07-28  630  			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  631  				pHalData->OFDM_24G_Diff[TxCount][RF_PATH_A];
8cd574e6af5463 Phillip Potter  2021-07-28  632  			/*  1. BW20 */
8cd574e6af5463 Phillip Potter  2021-07-28  633  			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  634  				pHalData->BW20_24G_Diff[TxCount][RF_PATH_A];
8cd574e6af5463 Phillip Potter  2021-07-28  635  			/* 2. BW40 */
8cd574e6af5463 Phillip Potter  2021-07-28  636  			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  637  		} else if (TxCount == RF_PATH_B) {
8cd574e6af5463 Phillip Potter  2021-07-28  638  			/*  1. CCK */
8cd574e6af5463 Phillip Potter  2021-07-28  639  			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  640  			/* 2. OFDM */
8cd574e6af5463 Phillip Potter  2021-07-28  641  			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  642  			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  643  			pHalData->BW20_24G_Diff[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  644  			/*  1. BW20 */
8cd574e6af5463 Phillip Potter  2021-07-28  645  			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  646  			pHalData->BW20_24G_Diff[TxCount][RF_PATH_A] +
8cd574e6af5463 Phillip Potter  2021-07-28  647  			pHalData->BW20_24G_Diff[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  648  			/* 2. BW40 */
8cd574e6af5463 Phillip Potter  2021-07-28  649  			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  650  		} else if (TxCount == RF_PATH_C) {
8cd574e6af5463 Phillip Potter  2021-07-28  651  			/*  1. CCK */
8cd574e6af5463 Phillip Potter  2021-07-28  652  			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  653  			/* 2. OFDM */
8cd574e6af5463 Phillip Potter  2021-07-28  654  			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  655  			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  656  			pHalData->BW20_24G_Diff[RF_PATH_B][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  657  			pHalData->BW20_24G_Diff[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  658  			/*  1. BW20 */
8cd574e6af5463 Phillip Potter  2021-07-28  659  			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  660  			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  661  			pHalData->BW20_24G_Diff[RF_PATH_B][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  662  			pHalData->BW20_24G_Diff[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  663  			/* 2. BW40 */
8cd574e6af5463 Phillip Potter  2021-07-28  664  			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  665  		} else if (TxCount == RF_PATH_D) {
8cd574e6af5463 Phillip Potter  2021-07-28  666  			/*  1. CCK */
8cd574e6af5463 Phillip Potter  2021-07-28  667  			cckPowerLevel[TxCount]	= pHalData->Index24G_CCK_Base[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  668  			/* 2. OFDM */
8cd574e6af5463 Phillip Potter  2021-07-28  669  			ofdmPowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  670  			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  671  			pHalData->BW20_24G_Diff[RF_PATH_B][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  672  			pHalData->BW20_24G_Diff[RF_PATH_C][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  673  			pHalData->BW20_24G_Diff[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  674  
8cd574e6af5463 Phillip Potter  2021-07-28  675  			/*  1. BW20 */
8cd574e6af5463 Phillip Potter  2021-07-28  676  			BW20PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  677  			pHalData->BW20_24G_Diff[RF_PATH_A][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  678  			pHalData->BW20_24G_Diff[RF_PATH_B][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  679  			pHalData->BW20_24G_Diff[RF_PATH_C][index] +
8cd574e6af5463 Phillip Potter  2021-07-28  680  			pHalData->BW20_24G_Diff[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  681  
8cd574e6af5463 Phillip Potter  2021-07-28  682  			/* 2. BW40 */
8cd574e6af5463 Phillip Potter  2021-07-28  683  			BW40PowerLevel[TxCount]	= pHalData->Index24G_BW40_Base[TxCount][index];
8cd574e6af5463 Phillip Potter  2021-07-28  684  		}
8cd574e6af5463 Phillip Potter  2021-07-28  685  	}
8cd574e6af5463 Phillip Potter  2021-07-28  686  }
8cd574e6af5463 Phillip Potter  2021-07-28  687  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
