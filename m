Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E28456A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 08:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbhKSHEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 02:04:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:26661 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232201AbhKSHEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 02:04:46 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="214398975"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="gz'50?scan'50,208,50";a="214398975"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 23:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="gz'50?scan'50,208,50";a="605462971"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 18 Nov 2021 23:01:42 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnxu1-0004CU-AU; Fri, 19 Nov 2021 07:01:41 +0000
Date:   Fri, 19 Nov 2021 15:01:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luben Tuikov <luben.tuikov@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:1113:25:
 warning: variable 'clk_src' set but not used
Message-ID: <202111191513.yGKzwn9H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e26dd976580a6a427c69e6116508dd3d412742e5
commit: 20f2ffe504728612d7b0c34e4f8280e34251e704 drm/amdgpu: fold CONFIG_DRM_AMD_DC_DCN3* into CONFIG_DRM_AMD_DC_DCN (v3)
date:   1 year ago
config: x86_64-randconfig-m001-20211109 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=20f2ffe504728612d7b0c34e4f8280e34251e704
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 20f2ffe504728612d7b0c34e4f8280e34251e704
        # save the attached .config to linux build tree
        make W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:96:6: warning: no previous prototype for 'vg_update_clocks' [-Wmissing-prototypes]
      96 | void vg_update_clocks(struct clk_mgr *clk_mgr_base,
         |      ^~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:375:6: warning: no previous prototype for 'vg_get_clk_states' [-Wmissing-prototypes]
     375 | void vg_get_clk_states(struct clk_mgr *clk_mgr_base, struct clk_states *s)
         |      ^~~~~~~~~~~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:393:6: warning: no previous prototype for 'vg_init_clocks' [-Wmissing-prototypes]
     393 | void vg_init_clocks(struct clk_mgr *clk_mgr)
         |      ^~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:43:
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:218:29: warning: 'VCN_BASE' defined but not used [-Wunused-const-variable=]
     218 | static const struct IP_BASE VCN_BASE = { { { { 0x00007800, 0x00007E00, 0x02403000, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:210:29: warning: 'USB_BASE' defined but not used [-Wunused-const-variable=]
     210 | static const struct IP_BASE USB_BASE = { { { { 0x0242A800, 0x05B00000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:202:29: warning: 'UMC_BASE' defined but not used [-Wunused-const-variable=]
     202 | static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0x02425800, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:194:29: warning: 'THM_BASE' defined but not used [-Wunused-const-variable=]
     194 | static const struct IP_BASE THM_BASE = { { { { 0x00016600, 0x02400C00, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:186:29: warning: 'SMUIO_BASE' defined but not used [-Wunused-const-variable=]
     186 | static const struct IP_BASE SMUIO_BASE = { { { { 0x00016800, 0x00016A00, 0x02401000, 0x00440000, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:178:29: warning: 'PCIE0_BASE' defined but not used [-Wunused-const-variable=]
     178 | static const struct IP_BASE PCIE0_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:170:29: warning: 'OSSSYS_BASE' defined but not used [-Wunused-const-variable=]
     170 | static const struct IP_BASE OSSSYS_BASE = { { { { 0x000010A0, 0x0240A000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:162:29: warning: 'NBIO_BASE' defined but not used [-Wunused-const-variable=]
     162 | static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:154:29: warning: 'MP2_BASE' defined but not used [-Wunused-const-variable=]
     154 | static const struct IP_BASE MP2_BASE = { { { { 0x00016400, 0x02400800, 0x00F40000, 0x00F80000, 0x00FC0000, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:146:29: warning: 'MP1_BASE' defined but not used [-Wunused-const-variable=]
     146 | static const struct IP_BASE MP1_BASE = { { { { 0x00016000, 0x0243FC00, 0x00DC0000, 0x00E00000, 0x00E40000, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:138:29: warning: 'MP0_BASE' defined but not used [-Wunused-const-variable=]
     138 | static const struct IP_BASE MP0_BASE = { { { { 0x00016000, 0x0243FC00, 0x00DC0000, 0x00E00000, 0x00E40000, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:130:29: warning: 'MMHUB_BASE' defined but not used [-Wunused-const-variable=]
     130 | static const struct IP_BASE MMHUB_BASE = { { { { 0x00013200, 0x0001A000, 0x02408800, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:122:29: warning: 'ISP_BASE' defined but not used [-Wunused-const-variable=]
     122 | static const struct IP_BASE ISP_BASE = { { { { 0x00018000, 0x0240B000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:114:29: warning: 'HDP_BASE' defined but not used [-Wunused-const-variable=]
     114 | static const struct IP_BASE HDP_BASE = { { { { 0x00000F20, 0x0240A400, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:106:29: warning: 'GC_BASE' defined but not used [-Wunused-const-variable=]
     106 | static const struct IP_BASE GC_BASE = { { { { 0x00001260, 0x0000A000, 0x02402C00, 0, 0, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:98:29: warning: 'FUSE_BASE' defined but not used [-Wunused-const-variable=]
      98 | static const struct IP_BASE FUSE_BASE = { { { { 0x00017400, 0x02401400, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:90:29: warning: 'FCH_BASE' defined but not used [-Wunused-const-variable=]
      90 | static const struct IP_BASE FCH_BASE = { { { { 0x0240C000, 0x00B40000, 0x11000000, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:82:29: warning: 'DPCS_BASE' defined but not used [-Wunused-const-variable=]
      82 | static const struct IP_BASE DPCS_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:74:29: warning: 'DCN_BASE' defined but not used [-Wunused-const-variable=]
      74 | static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:66:29: warning: 'DF_BASE' defined but not used [-Wunused-const-variable=]
      66 | static const struct IP_BASE DF_BASE = { { { { 0x00007000, 0x0240B800, 0, 0, 0, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:50:29: warning: 'ATHUB_BASE' defined but not used [-Wunused-const-variable=]
      50 | static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C00, 0x00013300, 0x02408C00, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:42:29: warning: 'ACP_BASE' defined but not used [-Wunused-const-variable=]
      42 | static const struct IP_BASE ACP_BASE = { { { { 0x02403800, 0x00480000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:86,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/clk_mgr_internal.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:27:
   drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/dpp.h:50:42: warning: 'dpp_input_csc_matrix' defined but not used [-Wunused-const-variable=]
      50 | static const struct dpp_input_csc_matrix dpp_input_csc_matrix[] = {
         |                                          ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/resource.h:28,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/clk_mgr_internal.h:36,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:27:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:126:22: warning: 'DP_DVI_CONVERTER_ID_5' defined but not used [-Wunused-const-variable=]
     126 | static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:125:22: warning: 'DP_DVI_CONVERTER_ID_4' defined but not used [-Wunused-const-variable=]
     125 | static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/dccg.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.c:26:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c:91:5: warning: no previous prototype for 'dcn301_smu_send_msg_with_param' [-Wmissing-prototypes]
      91 | int dcn301_smu_send_msg_with_param(
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c:33:
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:218:29: warning: 'VCN_BASE' defined but not used [-Wunused-const-variable=]
     218 | static const struct IP_BASE VCN_BASE = { { { { 0x00007800, 0x00007E00, 0x02403000, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:210:29: warning: 'USB_BASE' defined but not used [-Wunused-const-variable=]
     210 | static const struct IP_BASE USB_BASE = { { { { 0x0242A800, 0x05B00000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:202:29: warning: 'UMC_BASE' defined but not used [-Wunused-const-variable=]
     202 | static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0x02425800, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:194:29: warning: 'THM_BASE' defined but not used [-Wunused-const-variable=]
     194 | static const struct IP_BASE THM_BASE = { { { { 0x00016600, 0x02400C00, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:186:29: warning: 'SMUIO_BASE' defined but not used [-Wunused-const-variable=]
     186 | static const struct IP_BASE SMUIO_BASE = { { { { 0x00016800, 0x00016A00, 0x02401000, 0x00440000, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:178:29: warning: 'PCIE0_BASE' defined but not used [-Wunused-const-variable=]
     178 | static const struct IP_BASE PCIE0_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:170:29: warning: 'OSSSYS_BASE' defined but not used [-Wunused-const-variable=]
     170 | static const struct IP_BASE OSSSYS_BASE = { { { { 0x000010A0, 0x0240A000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:162:29: warning: 'NBIO_BASE' defined but not used [-Wunused-const-variable=]
     162 | static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:154:29: warning: 'MP2_BASE' defined but not used [-Wunused-const-variable=]
     154 | static const struct IP_BASE MP2_BASE = { { { { 0x00016400, 0x02400800, 0x00F40000, 0x00F80000, 0x00FC0000, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:146:29: warning: 'MP1_BASE' defined but not used [-Wunused-const-variable=]
     146 | static const struct IP_BASE MP1_BASE = { { { { 0x00016000, 0x0243FC00, 0x00DC0000, 0x00E00000, 0x00E40000, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:130:29: warning: 'MMHUB_BASE' defined but not used [-Wunused-const-variable=]
     130 | static const struct IP_BASE MMHUB_BASE = { { { { 0x00013200, 0x0001A000, 0x02408800, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:122:29: warning: 'ISP_BASE' defined but not used [-Wunused-const-variable=]
     122 | static const struct IP_BASE ISP_BASE = { { { { 0x00018000, 0x0240B000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:114:29: warning: 'HDP_BASE' defined but not used [-Wunused-const-variable=]
     114 | static const struct IP_BASE HDP_BASE = { { { { 0x00000F20, 0x0240A400, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:106:29: warning: 'GC_BASE' defined but not used [-Wunused-const-variable=]
     106 | static const struct IP_BASE GC_BASE = { { { { 0x00001260, 0x0000A000, 0x02402C00, 0, 0, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:98:29: warning: 'FUSE_BASE' defined but not used [-Wunused-const-variable=]
      98 | static const struct IP_BASE FUSE_BASE = { { { { 0x00017400, 0x02401400, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:90:29: warning: 'FCH_BASE' defined but not used [-Wunused-const-variable=]
      90 | static const struct IP_BASE FCH_BASE = { { { { 0x0240C000, 0x00B40000, 0x11000000, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:82:29: warning: 'DPCS_BASE' defined but not used [-Wunused-const-variable=]
      82 | static const struct IP_BASE DPCS_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:74:29: warning: 'DCN_BASE' defined but not used [-Wunused-const-variable=]
      74 | static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:66:29: warning: 'DF_BASE' defined but not used [-Wunused-const-variable=]
      66 | static const struct IP_BASE DF_BASE = { { { { 0x00007000, 0x0240B800, 0, 0, 0, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:58:29: warning: 'CLK_BASE' defined but not used [-Wunused-const-variable=]
      58 | static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:50:29: warning: 'ATHUB_BASE' defined but not used [-Wunused-const-variable=]
      50 | static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C00, 0x00013300, 0x02408C00, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/vangogh_ip_offset.h:42:29: warning: 'ACP_BASE' defined but not used [-Wunused-const-variable=]
      42 | static const struct IP_BASE ACP_BASE = { { { { 0x02403800, 0x00480000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:86,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c:26:
   drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/dpp.h:50:42: warning: 'dpp_input_csc_matrix' defined but not used [-Wunused-const-variable=]
      50 | static const struct dpp_input_csc_matrix dpp_input_csc_matrix[] = {
         |                                          ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c:26:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:126:22: warning: 'DP_DVI_CONVERTER_ID_5' defined but not used [-Wunused-const-variable=]
     126 | static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:125:22: warning: 'DP_DVI_CONVERTER_ID_4' defined but not used [-Wunused-const-variable=]
     125 | static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dc.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:29,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/dcn301_smu.c:26:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
--
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c: In function 'dcn3_get_pix_clk_dividers':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:1113:25: warning: variable 'clk_src' set but not used [-Wunused-but-set-variable]
    1113 |  struct dce110_clk_src *clk_src;
         |                         ^~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:86,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:32:
   At top level:
   drivers/gpu/drm/amd/amdgpu/../display/dc/inc/hw/dpp.h:50:42: warning: 'dpp_input_csc_matrix' defined but not used [-Wunused-const-variable=]
      50 | static const struct dpp_input_csc_matrix dpp_input_csc_matrix[] = {
         |                                          ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/inc/core_types.h:32,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:32:
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:126:22: warning: 'DP_DVI_CONVERTER_ID_5' defined but not used [-Wunused-const-variable=]
     126 | static const uint8_t DP_DVI_CONVERTER_ID_5[] = "3393N2";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:125:22: warning: 'DP_DVI_CONVERTER_ID_4' defined but not used [-Wunused-const-variable=]
     125 | static const uint8_t DP_DVI_CONVERTER_ID_4[] = "m2DVIa";
         |                      ^~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:123:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_3' defined but not used [-Wunused-const-variable=]
     123 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_3[] = "dnomlA";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/ddc_service_types.h:121:22: warning: 'DP_VGA_LVDS_CONVERTER_ID_2' defined but not used [-Wunused-const-variable=]
     121 | static const uint8_t DP_VGA_LVDS_CONVERTER_ID_2[] = "sivarT";
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c:28:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
         |                                ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
      73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
      72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
         |                                ^~~~~~~~~~~
--
>> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn30/irq_service_dcn30.c:50:20: warning: no previous prototype for 'to_dal_irq_source_dcn30' [-Wmissing-prototypes]
      50 | enum dc_irq_source to_dal_irq_source_dcn30(
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn30/irq_service_dcn30.c:34:
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:193:29: warning: 'VCN_BASE' defined but not used [-Wunused-const-variable=]
     193 | static const struct IP_BASE VCN_BASE = { { { { 0x00007800, 0x00007E00, 0x02403000, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:186:29: warning: 'USB0_BASE' defined but not used [-Wunused-const-variable=]
     186 | static const struct IP_BASE USB0_BASE = { { { { 0x0242A800, 0x05B00000, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:179:29: warning: 'UMC_BASE' defined but not used [-Wunused-const-variable=]
     179 | static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0x02425800, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:172:29: warning: 'THM_BASE' defined but not used [-Wunused-const-variable=]
     172 | static const struct IP_BASE THM_BASE = { { { { 0x00016600, 0x02400C00, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:165:29: warning: 'SMUIO_BASE' defined but not used [-Wunused-const-variable=]
     165 | static const struct IP_BASE SMUIO_BASE = { { { { 0x00016800, 0x00016A00, 0x00440000, 0x02401000, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:158:29: warning: 'SDMA1_BASE' defined but not used [-Wunused-const-variable=]
     158 | static const struct IP_BASE SDMA1_BASE = { { { { 0x00001260, 0x0000A000, 0x0001C000, 0x02402C00, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:151:29: warning: 'SDMA0_BASE' defined but not used [-Wunused-const-variable=]
     151 | static const struct IP_BASE SDMA0_BASE = { { { { 0x00001260, 0x0000A000, 0x0001C000, 0x02402C00, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:144:29: warning: 'PCIE0_BASE' defined but not used [-Wunused-const-variable=]
     144 | static const struct IP_BASE PCIE0_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:137:29: warning: 'OSSSYS_BASE' defined but not used [-Wunused-const-variable=]
     137 | static const struct IP_BASE OSSSYS_BASE = { { { { 0x000010A0, 0x0240A000, 0, 0, 0 } },
         |                             ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:130:29: warning: 'NBIO_BASE' defined but not used [-Wunused-const-variable=]
     130 | static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:123:29: warning: 'MP1_BASE' defined but not used [-Wunused-const-variable=]
     123 | static const struct IP_BASE MP1_BASE = { { { { 0x00016000, 0x00DC0000, 0x00E00000, 0x00E40000, 0x0243FC00 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:116:29: warning: 'MP0_BASE' defined but not used [-Wunused-const-variable=]
     116 | static const struct IP_BASE MP0_BASE = { { { { 0x00016000, 0x00DC0000, 0x00E00000, 0x00E40000, 0x0243FC00 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:109:29: warning: 'MMHUB_BASE' defined but not used [-Wunused-const-variable=]
     109 | static const struct IP_BASE MMHUB_BASE = { { { { 0x0001A000, 0x02408800, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:102:29: warning: 'HDP_BASE' defined but not used [-Wunused-const-variable=]
     102 | static const struct IP_BASE HDP_BASE = { { { { 0x00000F20, 0x0240A400, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:95:29: warning: 'HDA_BASE' defined but not used [-Wunused-const-variable=]
      95 | static const struct IP_BASE HDA_BASE = { { { { 0x004C0000, 0x02404800, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:88:29: warning: 'GC_BASE' defined but not used [-Wunused-const-variable=]
      88 | static const struct IP_BASE GC_BASE = { { { { 0x00001260, 0x0000A000, 0x0001C000, 0x02402C00, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:81:29: warning: 'FUSE_BASE' defined but not used [-Wunused-const-variable=]
      81 | static const struct IP_BASE FUSE_BASE = { { { { 0x00017400, 0x02401400, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:74:29: warning: 'DPCS_BASE' defined but not used [-Wunused-const-variable=]
      74 | static const struct IP_BASE DPCS_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:67:29: warning: 'DCN_BASE' defined but not used [-Wunused-const-variable=]
      67 | static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:60:29: warning: 'DIO_BASE' defined but not used [-Wunused-const-variable=]
      60 | static const struct IP_BASE DIO_BASE = { { { { 0x02404000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:53:29: warning: 'DF_BASE' defined but not used [-Wunused-const-variable=]
      53 | static const struct IP_BASE DF_BASE = { { { { 0x00007000, 0x0240B800, 0, 0, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:46:29: warning: 'CLK_BASE' defined but not used [-Wunused-const-variable=]
      46 | static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/sienna_cichlid_ip_offset.h:39:29: warning: 'ATHUB_BASE' defined but not used [-Wunused-const-variable=]
      39 | static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C00, 0x02408C00, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dc_types.h:33,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:30,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn30/irq_service_dcn30.c:27:
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:76:32: warning: 'dc_fixpt_ln2_div_2' defined but not used [-Wunused-const-variable=]
      76 | static const struct fixed31_32 dc_fixpt_ln2_div_2 = { 1488522236LL };
         |                                ^~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:75:32: warning: 'dc_fixpt_ln2' defined but not used [-Wunused-const-variable=]
      75 | static const struct fixed31_32 dc_fixpt_ln2 = { 2977044471LL };
         |                                ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:74:32: warning: 'dc_fixpt_e' defined but not used [-Wunused-const-variable=]
      74 | static const struct fixed31_32 dc_fixpt_e = { 11674931555LL };
         |                                ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:73:32: warning: 'dc_fixpt_two_pi' defined but not used [-Wunused-const-variable=]
      73 | static const struct fixed31_32 dc_fixpt_two_pi = { 26986075409LL };
         |                                ^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/include/fixed31_32.h:72:32: warning: 'dc_fixpt_pi' defined but not used [-Wunused-const-variable=]
      72 | static const struct fixed31_32 dc_fixpt_pi = { 13493037705LL };
         |                                ^~~~~~~~~~~
..


vim +/clk_src +1113 drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_clock_source.c

4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1106  
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1107  static uint32_t dcn3_get_pix_clk_dividers(
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1108  		struct clock_source *cs,
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1109  		struct pixel_clk_params *pix_clk_params,
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1110  		struct pll_settings *pll_settings)
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1111  {
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1112  	unsigned long long actual_pix_clk_100Hz = pix_clk_params->requested_pix_clk_100hz;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21 @1113  	struct dce110_clk_src *clk_src;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1114  
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1115  	clk_src = TO_DCE110_CLK_SRC(cs);
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1116  	DC_LOGGER_INIT();
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1117  
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1118  	if (pix_clk_params == NULL || pll_settings == NULL
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1119  			|| pix_clk_params->requested_pix_clk_100hz == 0) {
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1120  		DC_LOG_ERROR(
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1121  			"%s: Invalid parameters!!\n", __func__);
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1122  		return -1;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1123  	}
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1124  
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1125  	memset(pll_settings, 0, sizeof(*pll_settings));
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1126  	/* Adjust for HDMI Type A deep color */
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1127  	if (pix_clk_params->signal_type == SIGNAL_TYPE_HDMI_TYPE_A) {
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1128  		switch (pix_clk_params->color_depth) {
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1129  		case COLOR_DEPTH_101010:
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1130  			actual_pix_clk_100Hz = (actual_pix_clk_100Hz * 5) >> 2;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1131  			break;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1132  		case COLOR_DEPTH_121212:
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1133  			actual_pix_clk_100Hz = (actual_pix_clk_100Hz * 6) >> 2;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1134  			break;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1135  		case COLOR_DEPTH_161616:
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1136  			actual_pix_clk_100Hz = actual_pix_clk_100Hz * 2;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1137  			break;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1138  		default:
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1139  			break;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1140  		}
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1141  	}
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1142  	pll_settings->actual_pix_clk_100hz = (unsigned int) actual_pix_clk_100Hz;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1143  	pll_settings->adjusted_pix_clk_100hz = (unsigned int) actual_pix_clk_100Hz;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1144  	pll_settings->calculated_pix_clk_100hz = (unsigned int) actual_pix_clk_100Hz;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1145  
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1146  	return 0;
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1147  }
4d55b0dd1cdd853 Bhawanpreet Lakha 2020-05-21  1148  

:::::: The code at line 1113 was first introduced by commit
:::::: 4d55b0dd1cdd8535ffd6057f210465575117d807 drm/amd/display: Add DCN3 CLK_MGR

:::::: TO: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--EVF5PPMfhYS0aIcm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--EVF5PPMfhYS0aIcm--
