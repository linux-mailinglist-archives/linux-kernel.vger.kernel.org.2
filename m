Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690EA44F9C9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 18:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbhKNR3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 12:29:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:3073 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhKNR3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 12:29:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="319542313"
X-IronPort-AV: E=Sophos;i="5.87,234,1631602800"; 
   d="gz'50?scan'50,208,50";a="319542313"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 09:26:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,234,1631602800"; 
   d="gz'50?scan'50,208,50";a="671263510"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 14 Nov 2021 09:26:45 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mmJHA-000LaI-SM; Sun, 14 Nov 2021 17:26:44 +0000
Date:   Mon, 15 Nov 2021 01:26:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Zhan Liu <zhan.liu@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c:79:6:
 warning: no previous prototype for 'dcn201_update_clocks_vbios'
Message-ID: <202111150122.7rM2YHzo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c8c109546a19613d323a319d0c921cb1f317e629
commit: 519607a2f7798decb9c891a4f706aaf780f5a677 drm/amdgpu/display: fold DRM_AMD_DC_DCN201 into DRM_AMD_DC_DCN
date:   6 weeks ago
config: powerpc64-buildonly-randconfig-r004-20211026 (attached as .config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=519607a2f7798decb9c891a4f706aaf780f5a677
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 519607a2f7798decb9c891a4f706aaf780f5a677
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c:79:6: warning: no previous prototype for 'dcn201_update_clocks_vbios' [-Wmissing-prototypes]
      79 | void dcn201_update_clocks_vbios(struct clk_mgr *clk_mgr,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c: In function 'dcn201_update_clocks':
   drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c:134:14: warning: variable 'enter_display_off' set but not used [-Wunused-but-set-variable]
     134 |         bool enter_display_off = false;
         |              ^~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c:38:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:129:29: warning: 'UVD0_BASE' defined but not used [-Wunused-const-variable=]
     129 | static const struct IP_BASE UVD0_BASE            ={ { { { 0x00007800, 0x00007E00, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:123:29: warning: 'UMC0_BASE' defined but not used [-Wunused-const-variable=]
     123 | static const struct IP_BASE UMC0_BASE            ={ { { { 0x00014000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:117:29: warning: 'THM_BASE' defined but not used [-Wunused-const-variable=]
     117 | static const struct IP_BASE THM_BASE            ={ { { { 0x00016600, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:111:29: warning: 'SMUIO_BASE' defined but not used [-Wunused-const-variable=]
     111 | static const struct IP_BASE SMUIO_BASE            ={ { { { 0x00016800, 0x00016A00, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:105:29: warning: 'OSSSYS_BASE' defined but not used [-Wunused-const-variable=]
     105 | static const struct IP_BASE OSSSYS_BASE            ={ { { { 0x000010A0, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:99:29: warning: 'NBIO_BASE' defined but not used [-Wunused-const-variable=]
      99 | static const struct IP_BASE NBIO_BASE            ={ { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:93:29: warning: 'MP1_BASE' defined but not used [-Wunused-const-variable=]
      93 | static const struct IP_BASE MP1_BASE            ={ { { { 0x00016000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:87:29: warning: 'MP0_BASE' defined but not used [-Wunused-const-variable=]
      87 | static const struct IP_BASE MP0_BASE            ={ { { { 0x00016000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:81:29: warning: 'MMHUB_BASE' defined but not used [-Wunused-const-variable=]
      81 | static const struct IP_BASE MMHUB_BASE            ={ { { { 0x0001A000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:75:29: warning: 'HDP_BASE' defined but not used [-Wunused-const-variable=]
      75 | static const struct IP_BASE HDP_BASE            ={ { { { 0x00000F20, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:69:29: warning: 'GC_BASE' defined but not used [-Wunused-const-variable=]
      69 | static const struct IP_BASE GC_BASE            ={ { { { 0x00001260, 0x0000A000, 0, 0, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:63:29: warning: 'FUSE_BASE' defined but not used [-Wunused-const-variable=]
      63 | static const struct IP_BASE FUSE_BASE            ={ { { { 0x00017400, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:57:29: warning: 'DMU_BASE' defined but not used [-Wunused-const-variable=]
      57 | static const struct IP_BASE DMU_BASE            ={ { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:51:29: warning: 'DF_BASE' defined but not used [-Wunused-const-variable=]
      51 | static const struct IP_BASE DF_BASE            ={ { { { 0x00007000, 0, 0, 0, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:45:29: warning: 'CLK_BASE' defined but not used [-Wunused-const-variable=]
      45 | static const struct IP_BASE CLK_BASE            ={ { { { 0x00016C00, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:39:29: warning: 'ATHUB_BASE' defined but not used [-Wunused-const-variable=]
      39 | static const struct IP_BASE ATHUB_BASE            ={ { { { 0x00000C00, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn201/irq_service_dcn201.c:42:20: warning: no previous prototype for 'to_dal_irq_source_dcn201' [-Wmissing-prototypes]
      42 | enum dc_irq_source to_dal_irq_source_dcn201(
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn201/irq_service_dcn201.c:142:43: warning: 'dmub_outbox_irq_info_funcs' defined but not used [-Wunused-const-variable=]
     142 | static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs = {
         |                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn201/irq_service_dcn201.c:35:
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:129:29: warning: 'UVD0_BASE' defined but not used [-Wunused-const-variable=]
     129 | static const struct IP_BASE UVD0_BASE            ={ { { { 0x00007800, 0x00007E00, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:123:29: warning: 'UMC0_BASE' defined but not used [-Wunused-const-variable=]
     123 | static const struct IP_BASE UMC0_BASE            ={ { { { 0x00014000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:117:29: warning: 'THM_BASE' defined but not used [-Wunused-const-variable=]
     117 | static const struct IP_BASE THM_BASE            ={ { { { 0x00016600, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:111:29: warning: 'SMUIO_BASE' defined but not used [-Wunused-const-variable=]
     111 | static const struct IP_BASE SMUIO_BASE            ={ { { { 0x00016800, 0x00016A00, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:105:29: warning: 'OSSSYS_BASE' defined but not used [-Wunused-const-variable=]
     105 | static const struct IP_BASE OSSSYS_BASE            ={ { { { 0x000010A0, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:99:29: warning: 'NBIO_BASE' defined but not used [-Wunused-const-variable=]
      99 | static const struct IP_BASE NBIO_BASE            ={ { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:93:29: warning: 'MP1_BASE' defined but not used [-Wunused-const-variable=]
      93 | static const struct IP_BASE MP1_BASE            ={ { { { 0x00016000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:87:29: warning: 'MP0_BASE' defined but not used [-Wunused-const-variable=]
      87 | static const struct IP_BASE MP0_BASE            ={ { { { 0x00016000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:81:29: warning: 'MMHUB_BASE' defined but not used [-Wunused-const-variable=]
      81 | static const struct IP_BASE MMHUB_BASE            ={ { { { 0x0001A000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:75:29: warning: 'HDP_BASE' defined but not used [-Wunused-const-variable=]
      75 | static const struct IP_BASE HDP_BASE            ={ { { { 0x00000F20, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:69:29: warning: 'GC_BASE' defined but not used [-Wunused-const-variable=]
      69 | static const struct IP_BASE GC_BASE            ={ { { { 0x00001260, 0x0000A000, 0, 0, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:63:29: warning: 'FUSE_BASE' defined but not used [-Wunused-const-variable=]
      63 | static const struct IP_BASE FUSE_BASE            ={ { { { 0x00017400, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:57:29: warning: 'DMU_BASE' defined but not used [-Wunused-const-variable=]
      57 | static const struct IP_BASE DMU_BASE            ={ { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:51:29: warning: 'DF_BASE' defined but not used [-Wunused-const-variable=]
      51 | static const struct IP_BASE DF_BASE            ={ { { { 0x00007000, 0, 0, 0, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:45:29: warning: 'CLK_BASE' defined but not used [-Wunused-const-variable=]
      45 | static const struct IP_BASE CLK_BASE            ={ { { { 0x00016C00, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:39:29: warning: 'ATHUB_BASE' defined but not used [-Wunused-const-variable=]
      39 | static const struct IP_BASE ATHUB_BASE            ={ { { { 0x00000C00, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_init.c:127:6: warning: no previous prototype for 'dcn201_hw_sequencer_construct' [-Wmissing-prototypes]
     127 | void dcn201_hw_sequencer_construct(struct dc *dc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:64:
>> drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:16515:111: warning: initialized field overwritten [-Woverride-init]
   16515 | #define DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT                                              0x1f
         |                                                                                                               ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:213:23: note: in expansion of macro 'DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT'
     213 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:203:9: note: in expansion of macro 'AUX_SF'
     203 |         AUX_SF(DP_AUX0_AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:365:9: note: in expansion of macro 'DCN_AUX_MASK_SH_LIST'
     365 |         DCN_AUX_MASK_SH_LIST(__SHIFT)
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:16515:111: note: (near initialization for 'aux_shift.AUX_SW_AUTOINCREMENT_DISABLE')
   16515 | #define DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT                                              0x1f
         |                                                                                                               ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:213:23: note: in expansion of macro 'DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE__SHIFT'
     213 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:203:9: note: in expansion of macro 'AUX_SF'
     203 |         AUX_SF(DP_AUX0_AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:365:9: note: in expansion of macro 'DCN_AUX_MASK_SH_LIST'
     365 |         DCN_AUX_MASK_SH_LIST(__SHIFT)
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:16519:111: warning: initialized field overwritten [-Woverride-init]
   16519 | #define DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK                                                0x80000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:213:23: note: in expansion of macro 'DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK'
     213 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:203:9: note: in expansion of macro 'AUX_SF'
     203 |         AUX_SF(DP_AUX0_AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:369:9: note: in expansion of macro 'DCN_AUX_MASK_SH_LIST'
     369 |         DCN_AUX_MASK_SH_LIST(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:16519:111: note: (near initialization for 'aux_mask.AUX_SW_AUTOINCREMENT_DISABLE')
   16519 | #define DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK                                                0x80000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:213:23: note: in expansion of macro 'DP_AUX0_AUX_SW_DATA__AUX_SW_AUTOINCREMENT_DISABLE_MASK'
     213 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_aux.h:203:9: note: in expansion of macro 'AUX_SF'
     203 |         AUX_SF(DP_AUX0_AUX_SW_DATA, AUX_SW_AUTOINCREMENT_DISABLE, mask_sh),\
         |         ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:369:9: note: in expansion of macro 'DCN_AUX_MASK_SH_LIST'
     369 |         DCN_AUX_MASK_SH_LIST(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:17500:111: warning: initialized field overwritten [-Woverride-init]
   17500 | #define DIG0_TMDS_CTL_BITS__TMDS_CTL0__SHIFT                                                                  0x0
         |                                                                                                               ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.h:173:23: note: in expansion of macro 'DIG0_TMDS_CTL_BITS__TMDS_CTL0__SHIFT'
     173 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_link_encoder.h:184:9: note: in expansion of macro 'LE_SF'
     184 |         LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
         |         ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:404:9: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN20'
     404 |         LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:407:17: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN201'
     407 |                 LINK_ENCODER_MASK_SH_LIST_DCN201(__SHIFT)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:17500:111: note: (near initialization for 'le_shift.TMDS_CTL0')
   17500 | #define DIG0_TMDS_CTL_BITS__TMDS_CTL0__SHIFT                                                                  0x0
         |                                                                                                               ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.h:173:23: note: in expansion of macro 'DIG0_TMDS_CTL_BITS__TMDS_CTL0__SHIFT'
     173 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_link_encoder.h:184:9: note: in expansion of macro 'LE_SF'
     184 |         LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
         |         ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:404:9: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN20'
     404 |         LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:407:17: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN201'
     407 |                 LINK_ENCODER_MASK_SH_LIST_DCN201(__SHIFT)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:17504:111: warning: initialized field overwritten [-Woverride-init]
   17504 | #define DIG0_TMDS_CTL_BITS__TMDS_CTL0_MASK                                                                    0x00000001L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.h:173:23: note: in expansion of macro 'DIG0_TMDS_CTL_BITS__TMDS_CTL0_MASK'
     173 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_link_encoder.h:184:9: note: in expansion of macro 'LE_SF'
     184 |         LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
         |         ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:404:9: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN20'
     404 |         LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:411:17: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN201'
     411 |                 LINK_ENCODER_MASK_SH_LIST_DCN201(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:17504:111: note: (near initialization for 'le_mask.TMDS_CTL0')
   17504 | #define DIG0_TMDS_CTL_BITS__TMDS_CTL0_MASK                                                                    0x00000001L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_link_encoder.h:173:23: note: in expansion of macro 'DIG0_TMDS_CTL_BITS__TMDS_CTL0_MASK'
     173 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_link_encoder.h:184:9: note: in expansion of macro 'LE_SF'
     184 |         LE_SF(DIG0_TMDS_CTL_BITS, TMDS_CTL0, mask_sh), \
         |         ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:404:9: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN20'
     404 |         LINK_ENCODER_MASK_SH_LIST_DCN20(mask_sh)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:411:17: note: in expansion of macro 'LINK_ENCODER_MASK_SH_LIST_DCN201'
     411 |                 LINK_ENCODER_MASK_SH_LIST_DCN201(_MASK)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:61:
>> drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: warning: initialized field overwritten [-Woverride-init]
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:181:9: note: in expansion of macro 'SRI'
     181 |         SRI(CURSOR_CONTROL, CURSOR0_, id),\
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:469:9: note: in expansion of macro 'tf_regs'
     469 |         tf_regs(0),
         |         ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: note: (near initialization for 'tf_regs[0].CURSOR_CONTROL')
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:181:9: note: in expansion of macro 'SRI'
     181 |         SRI(CURSOR_CONTROL, CURSOR0_, id),\
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:469:9: note: in expansion of macro 'tf_regs'
     469 |         tf_regs(0),
         |         ^~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: warning: initialized field overwritten [-Woverride-init]
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:183:9: note: in expansion of macro 'SRI'
     183 |         SRI(DSCL_MEM_PWR_CTRL, DSCL, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:469:9: note: in expansion of macro 'tf_regs'
     469 |         tf_regs(0),
         |         ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: note: (near initialization for 'tf_regs[0].DSCL_MEM_PWR_CTRL')
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:183:9: note: in expansion of macro 'SRI'
     183 |         SRI(DSCL_MEM_PWR_CTRL, DSCL, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:469:9: note: in expansion of macro 'tf_regs'
     469 |         tf_regs(0),
         |         ^~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: warning: initialized field overwritten [-Woverride-init]
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:181:9: note: in expansion of macro 'SRI'
     181 |         SRI(CURSOR_CONTROL, CURSOR0_, id),\
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:470:9: note: in expansion of macro 'tf_regs'
     470 |         tf_regs(1),
         |         ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: note: (near initialization for 'tf_regs[1].CURSOR_CONTROL')
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:181:9: note: in expansion of macro 'SRI'
     181 |         SRI(CURSOR_CONTROL, CURSOR0_, id),\
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:470:9: note: in expansion of macro 'tf_regs'
     470 |         tf_regs(1),
         |         ^~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: warning: initialized field overwritten [-Woverride-init]
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:183:9: note: in expansion of macro 'SRI'
     183 |         SRI(DSCL_MEM_PWR_CTRL, DSCL, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:470:9: note: in expansion of macro 'tf_regs'
     470 |         tf_regs(1),
         |         ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: note: (near initialization for 'tf_regs[1].DSCL_MEM_PWR_CTRL')
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:183:9: note: in expansion of macro 'SRI'
     183 |         SRI(DSCL_MEM_PWR_CTRL, DSCL, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:470:9: note: in expansion of macro 'tf_regs'
     470 |         tf_regs(1),
         |         ^~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: warning: initialized field overwritten [-Woverride-init]
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:181:9: note: in expansion of macro 'SRI'
     181 |         SRI(CURSOR_CONTROL, CURSOR0_, id),\
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:471:9: note: in expansion of macro 'tf_regs'
     471 |         tf_regs(2),
         |         ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: note: (near initialization for 'tf_regs[2].CURSOR_CONTROL')
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:181:9: note: in expansion of macro 'SRI'
     181 |         SRI(CURSOR_CONTROL, CURSOR0_, id),\
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:471:9: note: in expansion of macro 'tf_regs'
     471 |         tf_regs(2),
         |         ^~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: warning: initialized field overwritten [-Woverride-init]
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:183:9: note: in expansion of macro 'SRI'
     183 |         SRI(DSCL_MEM_PWR_CTRL, DSCL, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:471:9: note: in expansion of macro 'tf_regs'
     471 |         tf_regs(2),
         |         ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: note: (near initialization for 'tf_regs[2].DSCL_MEM_PWR_CTRL')
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:183:9: note: in expansion of macro 'SRI'
     183 |         SRI(DSCL_MEM_PWR_CTRL, DSCL, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:471:9: note: in expansion of macro 'tf_regs'
     471 |         tf_regs(2),
         |         ^~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: warning: initialized field overwritten [-Woverride-init]
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:181:9: note: in expansion of macro 'SRI'
     181 |         SRI(CURSOR_CONTROL, CURSOR0_, id),\
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:472:9: note: in expansion of macro 'tf_regs'
     472 |         tf_regs(3),
         |         ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: note: (near initialization for 'tf_regs[3].CURSOR_CONTROL')
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:181:9: note: in expansion of macro 'SRI'
     181 |         SRI(CURSOR_CONTROL, CURSOR0_, id),\
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:472:9: note: in expansion of macro 'tf_regs'
     472 |         tf_regs(3),
         |         ^~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: warning: initialized field overwritten [-Woverride-init]
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:183:9: note: in expansion of macro 'SRI'
     183 |         SRI(DSCL_MEM_PWR_CTRL, DSCL, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:472:9: note: in expansion of macro 'tf_regs'
     472 |         tf_regs(3),
         |         ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: note: (near initialization for 'tf_regs[3].DSCL_MEM_PWR_CTRL')
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:256:21: note: in expansion of macro 'BASE'
     256 |         .reg_name = BASE(mm ## block ## id ## _ ## reg_name ## _BASE_IDX) + \
         |                     ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:183:9: note: in expansion of macro 'SRI'
     183 |         SRI(DSCL_MEM_PWR_CTRL, DSCL, id)
         |         ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:34:9: note: in expansion of macro 'TF_REG_LIST_DCN20'
      34 |         TF_REG_LIST_DCN20(id)
         |         ^~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:465:9: note: in expansion of macro 'TF_REG_LIST_DCN201'
     465 |         TF_REG_LIST_DCN201(id),\
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:472:9: note: in expansion of macro 'tf_regs'
     472 |         tf_regs(3),
         |         ^~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:64:
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:5596:111: warning: initialized field overwritten [-Woverride-init]
    5596 | #define CM0_CM_3DLUT_MODE__CM_3DLUT_MODE__SHIFT                                                               0x0
         |                                                                                                               ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.h:38:23: note: in expansion of macro 'CM0_CM_3DLUT_MODE__CM_3DLUT_MODE__SHIFT'
      38 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:368:9: note: in expansion of macro 'TF_SF'
     368 |         TF_SF(CM0_CM_3DLUT_MODE, CM_3DLUT_MODE, mask_sh), \
         |         ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:547:9: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20_COMMON'
     547 |         TF_REG_LIST_SH_MASK_DCN20_COMMON(mask_sh), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:37:9: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20'
      37 |         TF_REG_LIST_SH_MASK_DCN20(mask_sh)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:476:17: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN201'
     476 |                 TF_REG_LIST_SH_MASK_DCN201(__SHIFT)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:5596:111: note: (near initialization for 'tf_shift.CM_3DLUT_MODE')
    5596 | #define CM0_CM_3DLUT_MODE__CM_3DLUT_MODE__SHIFT                                                               0x0
         |                                                                                                               ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.h:38:23: note: in expansion of macro 'CM0_CM_3DLUT_MODE__CM_3DLUT_MODE__SHIFT'
      38 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:368:9: note: in expansion of macro 'TF_SF'
     368 |         TF_SF(CM0_CM_3DLUT_MODE, CM_3DLUT_MODE, mask_sh), \
         |         ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:547:9: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20_COMMON'
     547 |         TF_REG_LIST_SH_MASK_DCN20_COMMON(mask_sh), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:37:9: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20'
      37 |         TF_REG_LIST_SH_MASK_DCN20(mask_sh)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:476:17: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN201'
     476 |                 TF_REG_LIST_SH_MASK_DCN201(__SHIFT)
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:5183:111: warning: initialized field overwritten [-Woverride-init]
    5183 | #define CM0_CM_SHAPER_CONTROL__CM_SHAPER_LUT_MODE__SHIFT                                                      0x0
         |                                                                                                               ^~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.h:38:23: note: in expansion of macro 'CM0_CM_SHAPER_CONTROL__CM_SHAPER_LUT_MODE__SHIFT'
      38 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:206:9: note: in expansion of macro 'TF_SF'
     206 |         TF_SF(CM0_CM_SHAPER_CONTROL, CM_SHAPER_LUT_MODE, mask_sh)
         |         ^~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_dpp.h:548:9: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20_UPDATED'
     548 |         TF_REG_LIST_SH_MASK_DCN20_UPDATED(mask_sh), \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_dpp.h:37:9: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN20'
      37 |         TF_REG_LIST_SH_MASK_DCN20(mask_sh)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:476:17: note: in expansion of macro 'TF_REG_LIST_SH_MASK_DCN201'
..


vim +/dcn201_update_clocks_vbios +79 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c

3f68c01be9a2227 Zhan Liu 2021-09-25   78  
3f68c01be9a2227 Zhan Liu 2021-09-25  @79  void dcn201_update_clocks_vbios(struct clk_mgr *clk_mgr,
3f68c01be9a2227 Zhan Liu 2021-09-25   80  			struct dc_state *context,
3f68c01be9a2227 Zhan Liu 2021-09-25   81  			bool safe_to_lower)
3f68c01be9a2227 Zhan Liu 2021-09-25   82  {
3f68c01be9a2227 Zhan Liu 2021-09-25   83  	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
3f68c01be9a2227 Zhan Liu 2021-09-25   84  
3f68c01be9a2227 Zhan Liu 2021-09-25   85  	bool update_dppclk = false;
3f68c01be9a2227 Zhan Liu 2021-09-25   86  	bool update_dispclk = false;
3f68c01be9a2227 Zhan Liu 2021-09-25   87  
3f68c01be9a2227 Zhan Liu 2021-09-25   88  	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->clks.dppclk_khz)) {
3f68c01be9a2227 Zhan Liu 2021-09-25   89  		clk_mgr->clks.dppclk_khz = new_clocks->dppclk_khz;
3f68c01be9a2227 Zhan Liu 2021-09-25   90  		update_dppclk = true;
3f68c01be9a2227 Zhan Liu 2021-09-25   91  	}
3f68c01be9a2227 Zhan Liu 2021-09-25   92  
3f68c01be9a2227 Zhan Liu 2021-09-25   93  	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr->clks.dispclk_khz)) {
3f68c01be9a2227 Zhan Liu 2021-09-25   94  		clk_mgr->clks.dispclk_khz = new_clocks->dispclk_khz;
3f68c01be9a2227 Zhan Liu 2021-09-25   95  		update_dispclk = true;
3f68c01be9a2227 Zhan Liu 2021-09-25   96  	}
3f68c01be9a2227 Zhan Liu 2021-09-25   97  
3f68c01be9a2227 Zhan Liu 2021-09-25   98  	if (update_dppclk || update_dispclk) {
3f68c01be9a2227 Zhan Liu 2021-09-25   99  		struct bp_set_dce_clock_parameters dce_clk_params;
3f68c01be9a2227 Zhan Liu 2021-09-25  100  		struct dc_bios *bp = clk_mgr->ctx->dc_bios;
3f68c01be9a2227 Zhan Liu 2021-09-25  101  
3f68c01be9a2227 Zhan Liu 2021-09-25  102  		if (update_dispclk) {
3f68c01be9a2227 Zhan Liu 2021-09-25  103  			memset(&dce_clk_params, 0, sizeof(dce_clk_params));
3f68c01be9a2227 Zhan Liu 2021-09-25  104  			dce_clk_params.target_clock_frequency = new_clocks->dispclk_khz;
3f68c01be9a2227 Zhan Liu 2021-09-25  105  			dce_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
3f68c01be9a2227 Zhan Liu 2021-09-25  106  			dce_clk_params.clock_type = DCECLOCK_TYPE_DISPLAY_CLOCK;
3f68c01be9a2227 Zhan Liu 2021-09-25  107  			bp->funcs->set_dce_clock(bp, &dce_clk_params);
3f68c01be9a2227 Zhan Liu 2021-09-25  108  		}
3f68c01be9a2227 Zhan Liu 2021-09-25  109  		/* currently there is no DCECLOCK_TYPE_DPPCLK type defined in VBIOS interface.
3f68c01be9a2227 Zhan Liu 2021-09-25  110  		 * vbios program DPPCLK to the same DispCLK limitation
3f68c01be9a2227 Zhan Liu 2021-09-25  111  		 */
3f68c01be9a2227 Zhan Liu 2021-09-25  112  	}
3f68c01be9a2227 Zhan Liu 2021-09-25  113  }
3f68c01be9a2227 Zhan Liu 2021-09-25  114  

:::::: The code at line 79 was first introduced by commit
:::::: 3f68c01be9a2227de1e190317fe34a6fb835a094 drm/amd/display: add cyan_skillfish display support

:::::: TO: Zhan Liu <zhan.liu@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VbJkn9YxBvnuCH5J
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--VbJkn9YxBvnuCH5J--
