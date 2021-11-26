Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D79C45E870
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359159AbhKZH07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:26:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:54438 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346206AbhKZHY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:24:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="222846987"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="222846987"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 23:15:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="457584805"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 25 Nov 2021 23:15:18 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqVS1-0007ku-Ub; Fri, 26 Nov 2021 07:15:17 +0000
Date:   Fri, 26 Nov 2021 15:15:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c:304:1:
 warning: the frame size of 1080 bytes is larger than 1024 bytes
Message-ID: <202111261520.euS99l9U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qingqing,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: 31484207feb23e6cdb12827560442ab294855923 drm/amd/display: move FPU associated DCN301 code to DML folder
date:   4 weeks ago
config: i386-randconfig-r026-20211116 (https://download.01.org/0day-ci/archive/20211126/202111261520.euS99l9U-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=31484207feb23e6cdb12827560442ab294855923
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 31484207feb23e6cdb12827560442ab294855923
        # save the config file to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c: In function 'dcn301_update_bw_bounding_box':
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c:304:1: warning: the frame size of 1080 bytes is larger than 1024 bytes [-Wframe-larger-than=]
     304 | }
         | ^


vim +304 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c

   247	
   248	void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
   249	{
   250		struct dcn301_resource_pool *pool = TO_DCN301_RES_POOL(dc->res_pool);
   251		struct clk_limit_table *clk_table = &bw_params->clk_table;
   252		struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
   253		unsigned int i, closest_clk_lvl;
   254		int j;
   255	
   256		dc_assert_fp_enabled();
   257	
   258		/* Default clock levels are used for diags, which may lead to overclocking. */
   259		if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
   260			dcn3_01_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
   261			dcn3_01_ip.max_num_dpp = pool->base.pipe_count;
   262			dcn3_01_soc.num_chans = bw_params->num_channels;
   263	
   264			ASSERT(clk_table->num_entries);
   265			for (i = 0; i < clk_table->num_entries; i++) {
   266				/* loop backwards*/
   267				for (closest_clk_lvl = 0, j = dcn3_01_soc.num_states - 1; j >= 0; j--) {
   268					if ((unsigned int) dcn3_01_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
   269						closest_clk_lvl = j;
   270						break;
   271					}
   272				}
   273	
   274				clock_limits[i].state = i;
   275				clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
   276				clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
   277				clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
   278				clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
   279	
   280				clock_limits[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
   281				clock_limits[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
   282				clock_limits[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
   283				clock_limits[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
   284				clock_limits[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
   285				clock_limits[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
   286				clock_limits[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
   287			}
   288	
   289			for (i = 0; i < clk_table->num_entries; i++)
   290				dcn3_01_soc.clock_limits[i] = clock_limits[i];
   291	
   292			if (clk_table->num_entries) {
   293				dcn3_01_soc.num_states = clk_table->num_entries;
   294				/* duplicate last level */
   295				dcn3_01_soc.clock_limits[dcn3_01_soc.num_states] = dcn3_01_soc.clock_limits[dcn3_01_soc.num_states - 1];
   296				dcn3_01_soc.clock_limits[dcn3_01_soc.num_states].state = dcn3_01_soc.num_states;
   297			}
   298		}
   299	
   300		dcn3_01_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
   301		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
   302	
   303		dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, DML_PROJECT_DCN30);
 > 304	}
   305	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
