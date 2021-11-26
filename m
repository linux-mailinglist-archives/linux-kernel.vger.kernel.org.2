Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B585945EBD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 11:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377012AbhKZKmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 05:42:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:37659 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231465AbhKZKkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 05:40:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="234376762"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="234376762"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 02:26:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="598479317"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 26 Nov 2021 02:26:25 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqYQy-0007xh-8E; Fri, 26 Nov 2021 10:26:24 +0000
Date:   Fri, 26 Nov 2021 18:25:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Zhan Liu <zhan.liu@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c:79:6:
 warning: no previous prototype for 'dcn201_update_clocks_vbios'
Message-ID: <202111261849.eWkLFshd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: 519607a2f7798decb9c891a4f706aaf780f5a677 drm/amdgpu/display: fold DRM_AMD_DC_DCN201 into DRM_AMD_DC_DCN
date:   8 weeks ago
config: powerpc64-buildonly-randconfig-r004-20211026 (https://download.01.org/0day-ci/archive/20211126/202111261849.eWkLFshd-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=519607a2f7798decb9c891a4f706aaf780f5a677
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 519607a2f7798decb9c891a4f706aaf780f5a677
        # save the config file to linux build tree
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
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:14888:111: warning: initialized field overwritten [-Woverride-init]
   14888 | #define OTG0_OTG_VUPDATE_KEEPOUT__OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN_MASK                              0x80000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.h:45:23: note: in expansion of macro 'OTG0_OTG_VUPDATE_KEEPOUT__OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN_MASK'
      45 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:55:9: note: in expansion of macro 'SF'
      55 |         SF(OTG0_OTG_VUPDATE_KEEPOUT, OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, mask_sh), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:14888:111: note: (near initialization for 'tg_mask.OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN')
   14888 | #define OTG0_OTG_VUPDATE_KEEPOUT__OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN_MASK                              0x80000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.h:45:23: note: in expansion of macro 'OTG0_OTG_VUPDATE_KEEPOUT__OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN_MASK'
      45 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:55:9: note: in expansion of macro 'SF'
      55 |         SF(OTG0_OTG_VUPDATE_KEEPOUT, OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, mask_sh), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:14886:111: warning: initialized field overwritten [-Woverride-init]
   14886 | #define OTG0_OTG_VUPDATE_KEEPOUT__MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET_MASK                        0x0000FFFFL
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.h:45:23: note: in expansion of macro 'OTG0_OTG_VUPDATE_KEEPOUT__MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET_MASK'
      45 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:56:9: note: in expansion of macro 'SF'
      56 |         SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, mask_sh), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:14886:111: note: (near initialization for 'tg_mask.MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET')
   14886 | #define OTG0_OTG_VUPDATE_KEEPOUT__MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET_MASK                        0x0000FFFFL
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.h:45:23: note: in expansion of macro 'OTG0_OTG_VUPDATE_KEEPOUT__MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET_MASK'
      45 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:56:9: note: in expansion of macro 'SF'
      56 |         SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, mask_sh), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:14887:111: warning: initialized field overwritten [-Woverride-init]
   14887 | #define OTG0_OTG_VUPDATE_KEEPOUT__MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET_MASK                          0x03FF0000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.h:45:23: note: in expansion of macro 'OTG0_OTG_VUPDATE_KEEPOUT__MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET_MASK'
      45 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:57:9: note: in expansion of macro 'SF'
      57 |         SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, mask_sh), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:14887:111: note: (near initialization for 'tg_mask.MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET')
   14887 | #define OTG0_OTG_VUPDATE_KEEPOUT__MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET_MASK                          0x03FF0000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.h:45:23: note: in expansion of macro 'OTG0_OTG_VUPDATE_KEEPOUT__MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET_MASK'
      45 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:57:9: note: in expansion of macro 'SF'
      57 |         SF(OTG0_OTG_VUPDATE_KEEPOUT, MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, mask_sh), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:15730:111: warning: initialized field overwritten [-Woverride-init]
   15730 | #define DWB_SOURCE_SELECT__OPTC_DWB1_SOURCE_SELECT_MASK                                                       0x00000038L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.h:45:23: note: in expansion of macro 'DWB_SOURCE_SELECT__OPTC_DWB1_SOURCE_SELECT_MASK'
      45 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:68:9: note: in expansion of macro 'SF'
      68 |         SF(DWB_SOURCE_SELECT, OPTC_DWB1_SOURCE_SELECT, mask_sh)
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_2_0_3_sh_mask.h:15730:111: note: (near initialization for 'tg_mask.OPTC_DWB1_SOURCE_SELECT')
   15730 | #define DWB_SOURCE_SELECT__OPTC_DWB1_SOURCE_SELECT_MASK                                                       0x00000038L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_audio.h:45:23: note: in expansion of macro 'DWB_SOURCE_SELECT__OPTC_DWB1_SOURCE_SELECT_MASK'
      45 |         .field_name = reg_name ## __ ## field_name ## post_fix
         |                       ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_optc.h:68:9: note: in expansion of macro 'SF'
      68 |         SF(DWB_SOURCE_SELECT, OPTC_DWB1_SOURCE_SELECT, mask_sh)
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:514:9: note: in expansion of macro 'TG_COMMON_MASK_SH_LIST_DCN201'
     514 |         TG_COMMON_MASK_SH_LIST_DCN201(_MASK)
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:675:17: warning: no previous prototype for 'dcn201_aux_engine_create' [-Wmissing-prototypes]
     675 | struct dce_aux *dcn201_aux_engine_create(
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:709:20: warning: no previous prototype for 'dcn201_i2c_hw_create' [-Wmissing-prototypes]
     709 | struct dce_i2c_hw *dcn201_i2c_hw_create(
         |                    ^~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:792:22: warning: no previous prototype for 'dcn201_link_encoder_create' [-Wmissing-prototypes]
     792 | struct link_encoder *dcn201_link_encoder_create(
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:814:22: warning: no previous prototype for 'dcn201_clock_source_create' [-Wmissing-prototypes]
     814 | struct clock_source *dcn201_clock_source_create(
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:61:
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: warning: initialized field overwritten [-Woverride-init]
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:252:29: note: in expansion of macro 'BASE'
     252 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:178:9: note: in expansion of macro 'SR'
     178 |         SR(DCFCLK_CNTL), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:349:9: note: in expansion of macro 'HWSEQ_DCN_REG_LIST'
     349 |         HWSEQ_DCN_REG_LIST(), \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:870:17: note: in expansion of macro 'HWSEQ_DCN201_REG_LIST'
     870 |                 HWSEQ_DCN201_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/cyan_skillfish_ip_offset.h:247:52: note: (near initialization for 'hwseq_reg.DCFCLK_CNTL')
     247 | #define DMU_BASE__INST0_SEG2                       0x000034C0
         |                                                    ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:247:25: note: in expansion of macro 'DMU_BASE__INST0_SEG2'
     247 | #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
         |                         ^~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:249:19: note: in expansion of macro 'BASE_INNER'
     249 | #define BASE(seg) BASE_INNER(seg)
         |                   ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:252:29: note: in expansion of macro 'BASE'
     252 |                 .reg_name = BASE(mm ## reg_name ## _BASE_IDX) +  \
         |                             ^~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:178:9: note: in expansion of macro 'SR'
     178 |         SR(DCFCLK_CNTL), \
         |         ^~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:349:9: note: in expansion of macro 'HWSEQ_DCN_REG_LIST'
     349 |         HWSEQ_DCN_REG_LIST(), \
         |         ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:870:17: note: in expansion of macro 'HWSEQ_DCN201_REG_LIST'
     870 |                 HWSEQ_DCN201_REG_LIST()
         |                 ^~~~~~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:909:6: warning: no previous prototype for 'dcn201_clock_source_destroy' [-Wmissing-prototypes]
     909 | void dcn201_clock_source_destroy(struct clock_source **clk_src)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.c:61:
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
..


vim +/dcn201_update_clocks_vbios +79 drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn201/dcn201_clk_mgr.c

3f68c01be9a222 Zhan Liu 2021-09-25   78  
3f68c01be9a222 Zhan Liu 2021-09-25  @79  void dcn201_update_clocks_vbios(struct clk_mgr *clk_mgr,
3f68c01be9a222 Zhan Liu 2021-09-25   80  			struct dc_state *context,
3f68c01be9a222 Zhan Liu 2021-09-25   81  			bool safe_to_lower)
3f68c01be9a222 Zhan Liu 2021-09-25   82  {
3f68c01be9a222 Zhan Liu 2021-09-25   83  	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
3f68c01be9a222 Zhan Liu 2021-09-25   84  
3f68c01be9a222 Zhan Liu 2021-09-25   85  	bool update_dppclk = false;
3f68c01be9a222 Zhan Liu 2021-09-25   86  	bool update_dispclk = false;
3f68c01be9a222 Zhan Liu 2021-09-25   87  
3f68c01be9a222 Zhan Liu 2021-09-25   88  	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr->clks.dppclk_khz)) {
3f68c01be9a222 Zhan Liu 2021-09-25   89  		clk_mgr->clks.dppclk_khz = new_clocks->dppclk_khz;
3f68c01be9a222 Zhan Liu 2021-09-25   90  		update_dppclk = true;
3f68c01be9a222 Zhan Liu 2021-09-25   91  	}
3f68c01be9a222 Zhan Liu 2021-09-25   92  
3f68c01be9a222 Zhan Liu 2021-09-25   93  	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr->clks.dispclk_khz)) {
3f68c01be9a222 Zhan Liu 2021-09-25   94  		clk_mgr->clks.dispclk_khz = new_clocks->dispclk_khz;
3f68c01be9a222 Zhan Liu 2021-09-25   95  		update_dispclk = true;
3f68c01be9a222 Zhan Liu 2021-09-25   96  	}
3f68c01be9a222 Zhan Liu 2021-09-25   97  
3f68c01be9a222 Zhan Liu 2021-09-25   98  	if (update_dppclk || update_dispclk) {
3f68c01be9a222 Zhan Liu 2021-09-25   99  		struct bp_set_dce_clock_parameters dce_clk_params;
3f68c01be9a222 Zhan Liu 2021-09-25  100  		struct dc_bios *bp = clk_mgr->ctx->dc_bios;
3f68c01be9a222 Zhan Liu 2021-09-25  101  
3f68c01be9a222 Zhan Liu 2021-09-25  102  		if (update_dispclk) {
3f68c01be9a222 Zhan Liu 2021-09-25  103  			memset(&dce_clk_params, 0, sizeof(dce_clk_params));
3f68c01be9a222 Zhan Liu 2021-09-25  104  			dce_clk_params.target_clock_frequency = new_clocks->dispclk_khz;
3f68c01be9a222 Zhan Liu 2021-09-25  105  			dce_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
3f68c01be9a222 Zhan Liu 2021-09-25  106  			dce_clk_params.clock_type = DCECLOCK_TYPE_DISPLAY_CLOCK;
3f68c01be9a222 Zhan Liu 2021-09-25  107  			bp->funcs->set_dce_clock(bp, &dce_clk_params);
3f68c01be9a222 Zhan Liu 2021-09-25  108  		}
3f68c01be9a222 Zhan Liu 2021-09-25  109  		/* currently there is no DCECLOCK_TYPE_DPPCLK type defined in VBIOS interface.
3f68c01be9a222 Zhan Liu 2021-09-25  110  		 * vbios program DPPCLK to the same DispCLK limitation
3f68c01be9a222 Zhan Liu 2021-09-25  111  		 */
3f68c01be9a222 Zhan Liu 2021-09-25  112  	}
3f68c01be9a222 Zhan Liu 2021-09-25  113  }
3f68c01be9a222 Zhan Liu 2021-09-25  114  

:::::: The code at line 79 was first introduced by commit
:::::: 3f68c01be9a2227de1e190317fe34a6fb835a094 drm/amd/display: add cyan_skillfish display support

:::::: TO: Zhan Liu <zhan.liu@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
