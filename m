Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20CC0315BE5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbhBJBHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:07:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:24625 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234437AbhBIWbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 17:31:18 -0500
IronPort-SDR: ADEsIffyrU7qE3AXFgn5lE34YXpe54mqK3a02yAQ6okv+i4or/pzEc1qlq10rMONDTA/I8y9Sq
 DT1iAnD6s0Zg==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="243465015"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="gz'50?scan'50,208,50";a="243465015"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 14:30:14 -0800
IronPort-SDR: 58sYhp6FS4TpV2nxpHaBM5BOl2LaTpi2ID9Jq9qnBom2xpMcfREs53FcK/C/VIB/9y1BdbRBJj
 o8DmE7FFfauQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="gz'50?scan'50,208,50";a="585525525"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 09 Feb 2021 14:30:10 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9bWM-0002L9-88; Tue, 09 Feb 2021 22:30:10 +0000
Date:   Wed, 10 Feb 2021 06:29:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/staging/rtl8188eu 1/2]
 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:3113:30:
 warning: array subscript 4 is above array bounds of {aka 'struct
Message-ID: <202102100653.GRAqvsyj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/staging/rtl8188eu
head:   25e1a76c1c41a6d6f103b572f4f50ba30787f9ab
commit: 78d593615c6f1cd10232a34899af93d5d2696c30 [1/2] Makefile: Enable -Warray-bounds
config: microblaze-randconfig-r005-20210209 (attached as .config)
compiler: microblaze-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git/commit/?id=78d593615c6f1cd10232a34899af93d5d2696c30
        git remote add gustavoars-linux https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git
        git fetch --no-tags gustavoars-linux testing/staging/rtl8188eu
        git checkout 78d593615c6f1cd10232a34899af93d5d2696c30
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=microblaze 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c: In function 'vega10_get_pp_table_entry_callback_func':
>> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c:3113:30: warning: array subscript 4 is above array bounds of 'ATOM_Vega10_GFXCLK_Dependency_Record[1]' {aka 'struct _ATOM_Vega10_GFXCLK_Dependency_Record[1]'} [-Warray-bounds]
    3113 |     gfxclk_dep_table->entries[4].ulClk;
         |     ~~~~~~~~~~~~~~~~~~~~~~~~~^~~


vim +3113 drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/vega10_hwmgr.c

f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3023  
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3024  static int vega10_get_pp_table_entry_callback_func(struct pp_hwmgr *hwmgr,
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3025  		void *state, struct pp_power_state *power_state,
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3026  		void *pp_table, uint32_t classification_flag)
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3027  {
ebc1c9c1be5b49 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Rex Zhu     2017-06-19  3028  	ATOM_Vega10_GFXCLK_Dependency_Record_V2 *patom_record_V2;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3029  	struct vega10_power_state *vega10_power_state =
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3030  			cast_phw_vega10_power_state(&(power_state->hardware));
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3031  	struct vega10_performance_level *performance_level;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3032  	ATOM_Vega10_State *state_entry = (ATOM_Vega10_State *)state;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3033  	ATOM_Vega10_POWERPLAYTABLE *powerplay_table =
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3034  			(ATOM_Vega10_POWERPLAYTABLE *)pp_table;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3035  	ATOM_Vega10_SOCCLK_Dependency_Table *socclk_dep_table =
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3036  			(ATOM_Vega10_SOCCLK_Dependency_Table *)
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3037  			(((unsigned long)powerplay_table) +
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3038  			le16_to_cpu(powerplay_table->usSocclkDependencyTableOffset));
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3039  	ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table =
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3040  			(ATOM_Vega10_GFXCLK_Dependency_Table *)
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3041  			(((unsigned long)powerplay_table) +
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3042  			le16_to_cpu(powerplay_table->usGfxclkDependencyTableOffset));
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3043  	ATOM_Vega10_MCLK_Dependency_Table *mclk_dep_table =
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3044  			(ATOM_Vega10_MCLK_Dependency_Table *)
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3045  			(((unsigned long)powerplay_table) +
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3046  			le16_to_cpu(powerplay_table->usMclkDependencyTableOffset));
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3047  
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3048  
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3049  	/* The following fields are not initialized here:
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3050  	 * id orderedList allStatesList
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3051  	 */
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3052  	power_state->classification.ui_label =
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3053  			(le16_to_cpu(state_entry->usClassification) &
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3054  			ATOM_PPLIB_CLASSIFICATION_UI_MASK) >>
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3055  			ATOM_PPLIB_CLASSIFICATION_UI_SHIFT;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3056  	power_state->classification.flags = classification_flag;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3057  	/* NOTE: There is a classification2 flag in BIOS
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3058  	 * that is not being used right now
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3059  	 */
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3060  	power_state->classification.temporary_state = false;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3061  	power_state->classification.to_be_deleted = false;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3062  
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3063  	power_state->validation.disallowOnDC =
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3064  			((le32_to_cpu(state_entry->ulCapsAndSettings) &
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3065  					ATOM_Vega10_DISALLOW_ON_DC) != 0);
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3066  
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3067  	power_state->display.disableFrameModulation = false;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3068  	power_state->display.limitRefreshrate = false;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3069  	power_state->display.enableVariBright =
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3070  			((le32_to_cpu(state_entry->ulCapsAndSettings) &
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3071  					ATOM_Vega10_ENABLE_VARIBRIGHT) != 0);
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3072  
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3073  	power_state->validation.supportedPowerLevels = 0;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3074  	power_state->uvd_clocks.VCLK = 0;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3075  	power_state->uvd_clocks.DCLK = 0;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3076  	power_state->temperatures.min = 0;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3077  	power_state->temperatures.max = 0;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3078  
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3079  	performance_level = &(vega10_power_state->performance_levels
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3080  			[vega10_power_state->performance_level_count++]);
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3081  
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3082  	PP_ASSERT_WITH_CODE(
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3083  			(vega10_power_state->performance_level_count <
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3084  					NUM_GFXCLK_DPM_LEVELS),
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3085  			"Performance levels exceeds SMC limit!",
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3086  			return -1);
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3087  
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3088  	PP_ASSERT_WITH_CODE(
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3089  			(vega10_power_state->performance_level_count <=
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3090  					hwmgr->platform_descriptor.
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3091  					hardwareActivityPerformanceLevels),
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3092  			"Performance levels exceeds Driver limit!",
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3093  			return -1);
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3094  
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3095  	/* Performance levels are arranged from low to high. */
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3096  	performance_level->soc_clock = socclk_dep_table->entries
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3097  			[state_entry->ucSocClockIndexLow].ulClk;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3098  	performance_level->gfx_clock = gfxclk_dep_table->entries
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3099  			[state_entry->ucGfxClockIndexLow].ulClk;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3100  	performance_level->mem_clock = mclk_dep_table->entries
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3101  			[state_entry->ucMemClockIndexLow].ulMemClk;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3102  
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3103  	performance_level = &(vega10_power_state->performance_levels
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3104  				[vega10_power_state->performance_level_count++]);
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3105  	performance_level->soc_clock = socclk_dep_table->entries
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3106  				[state_entry->ucSocClockIndexHigh].ulClk;
ebc1c9c1be5b49 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Rex Zhu     2017-06-19  3107  	if (gfxclk_dep_table->ucRevId == 0) {
c9ffa427db34e6 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Yintian Tao 2019-10-30  3108  		/* under vega10 pp one vf mode, the gfx clk dpm need be lower
c9ffa427db34e6 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Yintian Tao 2019-10-30  3109  		 * to level-4 due to the limited 110w-power
c9ffa427db34e6 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Yintian Tao 2019-10-30  3110  		 */
c9ffa427db34e6 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Yintian Tao 2019-10-30  3111  		if (hwmgr->pp_one_vf && (state_entry->ucGfxClockIndexHigh > 0))
c9ffa427db34e6 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Yintian Tao 2019-10-30  3112  			performance_level->gfx_clock =
c9ffa427db34e6 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Yintian Tao 2019-10-30 @3113  				gfxclk_dep_table->entries[4].ulClk;
c9ffa427db34e6 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Yintian Tao 2019-10-30  3114  		else
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3115  			performance_level->gfx_clock = gfxclk_dep_table->entries
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3116  				[state_entry->ucGfxClockIndexHigh].ulClk;
ebc1c9c1be5b49 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Rex Zhu     2017-06-19  3117  	} else if (gfxclk_dep_table->ucRevId == 1) {
ebc1c9c1be5b49 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Rex Zhu     2017-06-19  3118  		patom_record_V2 = (ATOM_Vega10_GFXCLK_Dependency_Record_V2 *)gfxclk_dep_table->entries;
c9ffa427db34e6 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Yintian Tao 2019-10-30  3119  		if (hwmgr->pp_one_vf && (state_entry->ucGfxClockIndexHigh > 0))
c9ffa427db34e6 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Yintian Tao 2019-10-30  3120  			performance_level->gfx_clock = patom_record_V2[4].ulClk;
c9ffa427db34e6 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Yintian Tao 2019-10-30  3121  		else
c9ffa427db34e6 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Yintian Tao 2019-10-30  3122  			performance_level->gfx_clock =
c9ffa427db34e6 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Yintian Tao 2019-10-30  3123  				patom_record_V2[state_entry->ucGfxClockIndexHigh].ulClk;
ebc1c9c1be5b49 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Rex Zhu     2017-06-19  3124  	}
ebc1c9c1be5b49 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Rex Zhu     2017-06-19  3125  
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3126  	performance_level->mem_clock = mclk_dep_table->entries
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3127  			[state_entry->ucMemClockIndexHigh].ulMemClk;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3128  	return 0;
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3129  }
f83a9991648bb4 drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c Eric Huang  2017-03-06  3130  

:::::: The code at line 3113 was first introduced by commit
:::::: c9ffa427db34e6896523f0ef0c172a0bbb77c9ad drm/amd/powerplay: enable pp one vf mode for vega10

:::::: TO: Yintian Tao <yttao@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--u3/rZRmxL6MmkK24
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AA==

--u3/rZRmxL6MmkK24--
