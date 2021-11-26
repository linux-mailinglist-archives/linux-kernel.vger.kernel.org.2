Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F104445E6E7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 05:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346550AbhKZEkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 23:40:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:10278 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242891AbhKZEiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 23:38:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="216315890"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="216315890"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 20:33:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="498270927"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2021 20:33:07 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqSv5-0007UF-7y; Fri, 26 Nov 2021 04:33:07 +0000
Date:   Fri, 26 Nov 2021 12:32:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:1845:1:
 warning: the frame size of 1088 bytes is larger than 1024 bytes
Message-ID: <202111261241.qKpYXCZk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: 8fe44c080a53ac0ccbe88053a2e40f9acca33091 drm/amdgpu/display: fold DRM_AMD_DC_DCN3_1 into DRM_AMD_DC_DCN
date:   5 months ago
config: i386-randconfig-a005-20211117 (https://download.01.org/0day-ci/archive/20211126/202111261241.qKpYXCZk-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8fe44c080a53ac0ccbe88053a2e40f9acca33091
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8fe44c080a53ac0ccbe88053a2e40f9acca33091
        # save the config file to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

    5675 | #define DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:642:28: note: in expansion of macro 'DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     642 |  .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                            ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:824:2: note: in expansion of macro 'HWS_SF'
     824 |  HWS_SF(, DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |  ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:838:3: note: in expansion of macro 'HWSEQ_DCN31_MASK_SH_LIST'
     838 |   HWSEQ_DCN31_MASK_SH_LIST(_MASK)
         |   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/asic_reg/dcn/dcn_3_1_2_sh_mask.h:5675:111: note: (near initialization for 'hwseq_mask.DOMAIN_PGFSM_PWR_STATUS')
    5675 | #define DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK                                                      0xC0000000L
         |                                                                                                               ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dce/dce_hwseq.h:642:28: note: in expansion of macro 'DOMAIN18_PG_STATUS__DOMAIN_PGFSM_PWR_STATUS_MASK'
     642 |  .field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
         |                            ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:824:2: note: in expansion of macro 'HWS_SF'
     824 |  HWS_SF(, DOMAIN18_PG_STATUS, DOMAIN_PGFSM_PWR_STATUS, mask_sh), \
         |  ^~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:838:3: note: in expansion of macro 'HWSEQ_DCN31_MASK_SH_LIST'
     838 |   HWSEQ_DCN31_MASK_SH_LIST(_MASK)
         |   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:1197:20: warning: no previous prototype for 'dcn31_panel_cntl_create' [-Wmissing-prototypes]
    1197 | struct panel_cntl *dcn31_panel_cntl_create(const struct panel_cntl_init_data *init_data)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:71:
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:181:29: warning: 'VCN_BASE' defined but not used [-Wunused-const-variable=]
     181 | static const struct IP_BASE VCN_BASE = { { { { 0x00007800, 0x00007E00, 0x02403000, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:174:29: warning: 'UMC_BASE' defined but not used [-Wunused-const-variable=]
     174 | static const struct IP_BASE UMC_BASE = { { { { 0x00014000, 0x00054000, 0x02425800, 0x02425C00, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:167:29: warning: 'THM_BASE' defined but not used [-Wunused-const-variable=]
     167 | static const struct IP_BASE THM_BASE = { { { { 0x00016600, 0x02400C00, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:160:29: warning: 'SMUIO_BASE' defined but not used [-Wunused-const-variable=]
     160 | static const struct IP_BASE SMUIO_BASE = { { { { 0x00016800, 0x00016A00, 0x02401000, 0x00440000, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:153:29: warning: 'SDMA0_BASE' defined but not used [-Wunused-const-variable=]
     153 | static const struct IP_BASE SDMA0_BASE = { { { { 0x00001260, 0x0000A000, 0x02402C00, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:146:29: warning: 'PCIE_BASE' defined but not used [-Wunused-const-variable=]
     146 | static const struct IP_BASE PCIE_BASE = { { { { 0x02411800, 0x04440000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:139:29: warning: 'OSSSYS_BASE' defined but not used [-Wunused-const-variable=]
     139 | static const struct IP_BASE OSSSYS_BASE = { { { { 0x000010A0, 0x0240A000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:132:29: warning: 'NBIO_BASE' defined but not used [-Wunused-const-variable=]
     132 | static const struct IP_BASE NBIO_BASE = { { { { 0x00000000, 0x00000014, 0x00000D20, 0x00010400, 0x0241B000, 0x04040000 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:125:29: warning: 'MP2_BASE' defined but not used [-Wunused-const-variable=]
     125 | static const struct IP_BASE MP2_BASE = { { { { 0x00016000, 0x0243FC00, 0x00DC0000, 0x00E00000, 0x00E40000, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:118:29: warning: 'MP1_BASE' defined but not used [-Wunused-const-variable=]
     118 | static const struct IP_BASE MP1_BASE = { { { { 0x00016000, 0x0243FC00, 0x00DC0000, 0x00E00000, 0x00E40000, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:111:29: warning: 'MP0_BASE' defined but not used [-Wunused-const-variable=]
     111 | static const struct IP_BASE MP0_BASE = { { { { 0x00016000, 0x0243FC00, 0x00DC0000, 0x00E00000, 0x00E40000, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:104:29: warning: 'MMHUB_BASE' defined but not used [-Wunused-const-variable=]
     104 | static const struct IP_BASE MMHUB_BASE = { { { { 0x00013200, 0x0001A000, 0x02408800, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:97:29: warning: 'IOHC0_BASE' defined but not used [-Wunused-const-variable=]
      97 | static const struct IP_BASE IOHC0_BASE = { { { { 0x00010000, 0x02406000, 0x04EC0000, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:90:29: warning: 'HDP_BASE' defined but not used [-Wunused-const-variable=]
      90 | static const struct IP_BASE HDP_BASE = { { { { 0x00000F20, 0x0240A400, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:83:29: warning: 'GC_BASE' defined but not used [-Wunused-const-variable=]
      83 | static const struct IP_BASE GC_BASE = { { { { 0x00001260, 0x0000A000, 0x02402C00, 0, 0, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:76:29: warning: 'FUSE_BASE' defined but not used [-Wunused-const-variable=]
      76 | static const struct IP_BASE FUSE_BASE = { { { { 0x00017400, 0x02401400, 0, 0, 0, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:69:29: warning: 'FCH_BASE' defined but not used [-Wunused-const-variable=]
      69 | static const struct IP_BASE FCH_BASE = { { { { 0x0240C000, 0x00B40000, 0x11000000, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:62:29: warning: 'DF_BASE' defined but not used [-Wunused-const-variable=]
      62 | static const struct IP_BASE DF_BASE = { { { { 0x00007000, 0x0240B800, 0x02447800, 0x00C00000, 0x03640000, 0 } },
         |                             ^~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:55:29: warning: 'DPCS_BASE' defined but not used [-Wunused-const-variable=]
      55 | static const struct IP_BASE DPCS_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
         |                             ^~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:48:29: warning: 'DCN_BASE' defined but not used [-Wunused-const-variable=]
      48 | static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C0, 0x00009000, 0x02403C00, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:41:29: warning: 'DBGU_IO_BASE' defined but not used [-Wunused-const-variable=]
      41 | static const struct IP_BASE DBGU_IO_BASE = { { { { 0x000001E0, 0x00000260, 0x00000280, 0x0240B400, 0x02413C00, 0x02416000 } },
         |                             ^~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:34:29: warning: 'CLK_BASE' defined but not used [-Wunused-const-variable=]
      34 | static const struct IP_BASE CLK_BASE = { { { { 0x00016C00, 0x02401800, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:27:29: warning: 'ATHUB_BASE' defined but not used [-Wunused-const-variable=]
      27 | static const struct IP_BASE ATHUB_BASE = { { { { 0x00000C00, 0x00013300, 0x02408C00, 0, 0, 0 } },
         |                             ^~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../include/yellow_carp_offset.h:20:29: warning: 'ACP_BASE' defined but not used [-Wunused-const-variable=]
      20 | static const struct IP_BASE ACP_BASE = { { { { 0x02403800, 0x00480000, 0, 0, 0, 0 } },
         |                             ^~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c: In function 'dcn31_update_bw_bounding_box':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c:1845:1: warning: the frame size of 1088 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1845 | }
         | ^


vim +1845 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn31/dcn31_resource.c

2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1775  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1776  static void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1777  {
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1778  	struct clk_limit_table *clk_table = &bw_params->clk_table;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1779  	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1780  	unsigned int i, closest_clk_lvl;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1781  	int j;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1782  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1783  	// Default clock levels are used for diags, which may lead to overclocking.
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1784  	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1785  		int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1786  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1787  		dcn3_1_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1788  		dcn3_1_ip.max_num_dpp = dc->res_pool->pipe_count;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1789  		dcn3_1_soc.num_chans = bw_params->num_channels;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1790  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1791  		ASSERT(clk_table->num_entries);
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1792  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1793  		/* Prepass to find max clocks independent of voltage level. */
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1794  		for (i = 0; i < clk_table->num_entries; ++i) {
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1795  			if (clk_table->entries[i].dispclk_mhz > max_dispclk_mhz)
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1796  				max_dispclk_mhz = clk_table->entries[i].dispclk_mhz;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1797  			if (clk_table->entries[i].dppclk_mhz > max_dppclk_mhz)
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1798  				max_dppclk_mhz = clk_table->entries[i].dppclk_mhz;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1799  		}
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1800  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1801  		for (i = 0; i < clk_table->num_entries; i++) {
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1802  			/* loop backwards*/
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1803  			for (closest_clk_lvl = 0, j = dcn3_1_soc.num_states - 1; j >= 0; j--) {
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1804  				if ((unsigned int) dcn3_1_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1805  					closest_clk_lvl = j;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1806  					break;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1807  				}
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1808  			}
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1809  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1810  			clock_limits[i].state = i;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1811  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1812  			/* Clocks dependent on voltage level. */
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1813  			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1814  			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1815  			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1816  			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1817  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1818  			/* Clocks independent of voltage level. */
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1819  			clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1820  				dcn3_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1821  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1822  			clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1823  				dcn3_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1824  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1825  			clock_limits[i].dram_bw_per_chan_gbps = dcn3_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1826  			clock_limits[i].dscclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1827  			clock_limits[i].dtbclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1828  			clock_limits[i].phyclk_d18_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1829  			clock_limits[i].phyclk_mhz = dcn3_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1830  		}
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1831  		for (i = 0; i < clk_table->num_entries; i++)
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1832  			dcn3_1_soc.clock_limits[i] = clock_limits[i];
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1833  		if (clk_table->num_entries) {
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1834  			dcn3_1_soc.num_states = clk_table->num_entries;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1835  		}
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1836  	}
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1837  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1838  	dcn3_1_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1839  	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1840  
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1841  	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1842  		dml_init_instance(&dc->dml, &dcn3_1_soc, &dcn3_1_ip, DML_PROJECT_DCN31);
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1843  	else
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1844  		dml_init_instance(&dc->dml, &dcn3_1_soc, &dcn3_1_ip, DML_PROJECT_DCN31_FPGA);
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19 @1845  }
2083640f0d5bf9b Nicholas Kazlauskas 2021-05-19  1846  

:::::: The code at line 1845 was first introduced by commit
:::::: 2083640f0d5bf9b3c4432b6dae9885a3bd604ce6 drm/amd/display: Add DCN3.1 Resource

:::::: TO: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
