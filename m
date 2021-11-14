Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF6A44F65F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 04:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhKNDxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Nov 2021 22:53:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:52422 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230441AbhKNDxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Nov 2021 22:53:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10167"; a="220186537"
X-IronPort-AV: E=Sophos;i="5.87,233,1631602800"; 
   d="scan'208";a="220186537"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2021 19:50:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,233,1631602800"; 
   d="scan'208";a="535153178"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Nov 2021 19:50:26 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mm6XB-000Kuw-Qd; Sun, 14 Nov 2021 03:50:25 +0000
Date:   Sun, 14 Nov 2021 11:49:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Thierry Reding <treding@nvidia.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: drivers/memory/tegra/tegra210-emc-cc-r21021.c:1035:44: warning:
 Logical conjunction always evaluates to false: !opt_cc_short_zcal &&
 opt_short_zcal. [incorrectLogicOperator]
Message-ID: <202111141114.HpLSpSDA-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ccfff0a2bd2a30de130b5623d242ddecd0272bc2
commit: 56ebc9b0d77e0406aba2d900c82e79204cc7dc32 memory: tegra: Enable compile testing for all drivers
date:   5 months ago
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)
>> drivers/memory/tegra/tegra210-emc-cc-r21021.c:1035:44: warning: Logical conjunction always evaluates to false: !opt_cc_short_zcal && opt_short_zcal. [incorrectLogicOperator]
         opt_zcal_en_cc && !opt_cc_short_zcal &&
                                              ^
   drivers/memory/tegra/tegra210-emc-cc-r21021.c:1043:26: warning: Logical conjunction always evaluates to false: !opt_cc_short_zcal && opt_short_zcal. [incorrectLogicOperator]
         !opt_cc_short_zcal && opt_short_zcal) {
                            ^
>> drivers/memory/tegra/tegra210-emc-cc-r21021.c:1688:22: warning: Logical conjunction always evaluates to false: !opt_short_zcal && opt_cc_short_zcal. [incorrectLogicOperator]
        !opt_short_zcal && opt_cc_short_zcal) {
                        ^

vim +1035 drivers/memory/tegra/tegra210-emc-cc-r21021.c

9b9d8632f51f360 Joseph Lo      2019-05-29   581  
9b9d8632f51f360 Joseph Lo      2019-05-29   582  /*
9b9d8632f51f360 Joseph Lo      2019-05-29   583   * Do the clock change sequence.
9b9d8632f51f360 Joseph Lo      2019-05-29   584   */
9b9d8632f51f360 Joseph Lo      2019-05-29   585  static void tegra210_emc_r21021_set_clock(struct tegra210_emc *emc, u32 clksrc)
9b9d8632f51f360 Joseph Lo      2019-05-29   586  {
9b9d8632f51f360 Joseph Lo      2019-05-29   587  	/* state variables */
9b9d8632f51f360 Joseph Lo      2019-05-29   588  	static bool fsp_for_next_freq;
9b9d8632f51f360 Joseph Lo      2019-05-29   589  	/* constant configuration parameters */
9b9d8632f51f360 Joseph Lo      2019-05-29   590  	const bool save_restore_clkstop_pd = true;
9b9d8632f51f360 Joseph Lo      2019-05-29   591  	const u32 zqcal_before_cc_cutoff = 2400;
9b9d8632f51f360 Joseph Lo      2019-05-29   592  	const bool cya_allow_ref_cc = false;
9b9d8632f51f360 Joseph Lo      2019-05-29   593  	const bool cya_issue_pc_ref = false;
9b9d8632f51f360 Joseph Lo      2019-05-29   594  	const bool opt_cc_short_zcal = true;
9b9d8632f51f360 Joseph Lo      2019-05-29   595  	const bool ref_b4_sref_en = false;
9b9d8632f51f360 Joseph Lo      2019-05-29   596  	const u32 tZQCAL_lpddr4 = 1000000;
9b9d8632f51f360 Joseph Lo      2019-05-29   597  	const bool opt_short_zcal = true;
9b9d8632f51f360 Joseph Lo      2019-05-29   598  	const bool opt_do_sw_qrst = true;
9b9d8632f51f360 Joseph Lo      2019-05-29   599  	const u32 opt_dvfs_mode = MAN_SR;
9b9d8632f51f360 Joseph Lo      2019-05-29   600  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29   601  	 * This is the timing table for the source frequency. It does _not_
9b9d8632f51f360 Joseph Lo      2019-05-29   602  	 * necessarily correspond to the actual timing values in the EMC at the
9b9d8632f51f360 Joseph Lo      2019-05-29   603  	 * moment. If the boot BCT differs from the table then this can happen.
9b9d8632f51f360 Joseph Lo      2019-05-29   604  	 * However, we need it for accessing the dram_timings (which are not
9b9d8632f51f360 Joseph Lo      2019-05-29   605  	 * really registers) array for the current frequency.
9b9d8632f51f360 Joseph Lo      2019-05-29   606  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29   607  	struct tegra210_emc_timing *fake, *last = emc->last, *next = emc->next;
9b9d8632f51f360 Joseph Lo      2019-05-29   608  	u32 tRTM, RP_war, R2P_war, TRPab_war, deltaTWATM, W2P_war, tRPST;
9b9d8632f51f360 Joseph Lo      2019-05-29   609  	u32 mr13_flip_fspwr, mr13_flip_fspop, ramp_up_wait, ramp_down_wait;
9b9d8632f51f360 Joseph Lo      2019-05-29   610  	u32 zq_wait_long, zq_latch_dvfs_wait_time, tZQCAL_lpddr4_fc_adj;
9b9d8632f51f360 Joseph Lo      2019-05-29   611  	u32 emc_auto_cal_config, auto_cal_en, emc_cfg, emc_sel_dpd_ctrl;
9b9d8632f51f360 Joseph Lo      2019-05-29   612  	u32 tFC_lpddr4 = 1000 * next->dram_timings[T_FC_LPDDR4];
9b9d8632f51f360 Joseph Lo      2019-05-29   613  	u32 bg_reg_mode_change, enable_bglp_reg, enable_bg_reg;
9b9d8632f51f360 Joseph Lo      2019-05-29   614  	bool opt_zcal_en_cc = false, is_lpddr3 = false;
9b9d8632f51f360 Joseph Lo      2019-05-29   615  	bool compensate_trimmer_applicable = false;
9b9d8632f51f360 Joseph Lo      2019-05-29   616  	u32 emc_dbg, emc_cfg_pipe_clk, emc_pin;
9b9d8632f51f360 Joseph Lo      2019-05-29   617  	u32 src_clk_period, dst_clk_period; /* in picoseconds */
9b9d8632f51f360 Joseph Lo      2019-05-29   618  	bool shared_zq_resistor = false;
9b9d8632f51f360 Joseph Lo      2019-05-29   619  	u32 value, dram_type;
9b9d8632f51f360 Joseph Lo      2019-05-29   620  	u32 opt_dll_mode = 0;
9b9d8632f51f360 Joseph Lo      2019-05-29   621  	unsigned long delay;
9b9d8632f51f360 Joseph Lo      2019-05-29   622  	unsigned int i;
9b9d8632f51f360 Joseph Lo      2019-05-29   623  
9b9d8632f51f360 Joseph Lo      2019-05-29   624  	emc_dbg(emc, INFO, "Running clock change.\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   625  
9b9d8632f51f360 Joseph Lo      2019-05-29   626  	/* XXX fake == last */
9b9d8632f51f360 Joseph Lo      2019-05-29   627  	fake = tegra210_emc_find_timing(emc, last->rate * 1000UL);
9b9d8632f51f360 Joseph Lo      2019-05-29   628  	fsp_for_next_freq = !fsp_for_next_freq;
9b9d8632f51f360 Joseph Lo      2019-05-29   629  
9b9d8632f51f360 Joseph Lo      2019-05-29   630  	value = emc_readl(emc, EMC_FBIO_CFG5) & EMC_FBIO_CFG5_DRAM_TYPE_MASK;
9b9d8632f51f360 Joseph Lo      2019-05-29   631  	dram_type = value >> EMC_FBIO_CFG5_DRAM_TYPE_SHIFT;
9b9d8632f51f360 Joseph Lo      2019-05-29   632  
9b9d8632f51f360 Joseph Lo      2019-05-29   633  	if (last->burst_regs[EMC_ZCAL_WAIT_CNT_INDEX] & BIT(31))
9b9d8632f51f360 Joseph Lo      2019-05-29   634  		shared_zq_resistor = true;
9b9d8632f51f360 Joseph Lo      2019-05-29   635  
9b9d8632f51f360 Joseph Lo      2019-05-29   636  	if ((next->burst_regs[EMC_ZCAL_INTERVAL_INDEX] != 0 &&
9b9d8632f51f360 Joseph Lo      2019-05-29   637  	     last->burst_regs[EMC_ZCAL_INTERVAL_INDEX] == 0) ||
9b9d8632f51f360 Joseph Lo      2019-05-29   638  	    dram_type == DRAM_TYPE_LPDDR4)
9b9d8632f51f360 Joseph Lo      2019-05-29   639  		opt_zcal_en_cc = true;
9b9d8632f51f360 Joseph Lo      2019-05-29   640  
9b9d8632f51f360 Joseph Lo      2019-05-29   641  	if (dram_type == DRAM_TYPE_DDR3)
9b9d8632f51f360 Joseph Lo      2019-05-29   642  		opt_dll_mode = tegra210_emc_get_dll_state(next);
9b9d8632f51f360 Joseph Lo      2019-05-29   643  
9b9d8632f51f360 Joseph Lo      2019-05-29   644  	if ((next->burst_regs[EMC_FBIO_CFG5_INDEX] & BIT(25)) &&
9b9d8632f51f360 Joseph Lo      2019-05-29   645  	    (dram_type == DRAM_TYPE_LPDDR2))
9b9d8632f51f360 Joseph Lo      2019-05-29   646  		is_lpddr3 = true;
9b9d8632f51f360 Joseph Lo      2019-05-29   647  
9b9d8632f51f360 Joseph Lo      2019-05-29   648  	emc_readl(emc, EMC_CFG);
9b9d8632f51f360 Joseph Lo      2019-05-29   649  	emc_readl(emc, EMC_AUTO_CAL_CONFIG);
9b9d8632f51f360 Joseph Lo      2019-05-29   650  
9b9d8632f51f360 Joseph Lo      2019-05-29   651  	src_clk_period = 1000000000 / last->rate;
9b9d8632f51f360 Joseph Lo      2019-05-29   652  	dst_clk_period = 1000000000 / next->rate;
9b9d8632f51f360 Joseph Lo      2019-05-29   653  
9b9d8632f51f360 Joseph Lo      2019-05-29   654  	if (dst_clk_period <= zqcal_before_cc_cutoff)
9b9d8632f51f360 Joseph Lo      2019-05-29   655  		tZQCAL_lpddr4_fc_adj = tZQCAL_lpddr4 - tFC_lpddr4;
9b9d8632f51f360 Joseph Lo      2019-05-29   656  	else
9b9d8632f51f360 Joseph Lo      2019-05-29   657  		tZQCAL_lpddr4_fc_adj = tZQCAL_lpddr4;
9b9d8632f51f360 Joseph Lo      2019-05-29   658  
9b9d8632f51f360 Joseph Lo      2019-05-29   659  	tZQCAL_lpddr4_fc_adj /= dst_clk_period;
9b9d8632f51f360 Joseph Lo      2019-05-29   660  
9b9d8632f51f360 Joseph Lo      2019-05-29   661  	emc_dbg = emc_readl(emc, EMC_DBG);
9b9d8632f51f360 Joseph Lo      2019-05-29   662  	emc_pin = emc_readl(emc, EMC_PIN);
9b9d8632f51f360 Joseph Lo      2019-05-29   663  	emc_cfg_pipe_clk = emc_readl(emc, EMC_CFG_PIPE_CLK);
9b9d8632f51f360 Joseph Lo      2019-05-29   664  
9b9d8632f51f360 Joseph Lo      2019-05-29   665  	emc_cfg = next->burst_regs[EMC_CFG_INDEX];
9b9d8632f51f360 Joseph Lo      2019-05-29   666  	emc_cfg &= ~(EMC_CFG_DYN_SELF_REF | EMC_CFG_DRAM_ACPD |
9b9d8632f51f360 Joseph Lo      2019-05-29   667  		     EMC_CFG_DRAM_CLKSTOP_SR | EMC_CFG_DRAM_CLKSTOP_PD);
9b9d8632f51f360 Joseph Lo      2019-05-29   668  	emc_sel_dpd_ctrl = next->emc_sel_dpd_ctrl;
9b9d8632f51f360 Joseph Lo      2019-05-29   669  	emc_sel_dpd_ctrl &= ~(EMC_SEL_DPD_CTRL_CLK_SEL_DPD_EN |
9b9d8632f51f360 Joseph Lo      2019-05-29   670  			      EMC_SEL_DPD_CTRL_CA_SEL_DPD_EN |
9b9d8632f51f360 Joseph Lo      2019-05-29   671  			      EMC_SEL_DPD_CTRL_RESET_SEL_DPD_EN |
9b9d8632f51f360 Joseph Lo      2019-05-29   672  			      EMC_SEL_DPD_CTRL_ODT_SEL_DPD_EN |
9b9d8632f51f360 Joseph Lo      2019-05-29   673  			      EMC_SEL_DPD_CTRL_DATA_SEL_DPD_EN);
9b9d8632f51f360 Joseph Lo      2019-05-29   674  
9b9d8632f51f360 Joseph Lo      2019-05-29   675  	emc_dbg(emc, INFO, "Clock change version: %d\n",
9b9d8632f51f360 Joseph Lo      2019-05-29   676  		DVFS_CLOCK_CHANGE_VERSION);
9b9d8632f51f360 Joseph Lo      2019-05-29   677  	emc_dbg(emc, INFO, "DRAM type = %d\n", dram_type);
9b9d8632f51f360 Joseph Lo      2019-05-29   678  	emc_dbg(emc, INFO, "DRAM dev #: %u\n", emc->num_devices);
9b9d8632f51f360 Joseph Lo      2019-05-29   679  	emc_dbg(emc, INFO, "Next EMC clksrc: 0x%08x\n", clksrc);
9b9d8632f51f360 Joseph Lo      2019-05-29   680  	emc_dbg(emc, INFO, "DLL clksrc:      0x%08x\n", next->dll_clk_src);
9b9d8632f51f360 Joseph Lo      2019-05-29   681  	emc_dbg(emc, INFO, "last rate: %u, next rate %u\n", last->rate,
9b9d8632f51f360 Joseph Lo      2019-05-29   682  		next->rate);
9b9d8632f51f360 Joseph Lo      2019-05-29   683  	emc_dbg(emc, INFO, "last period: %u, next period: %u\n",
9b9d8632f51f360 Joseph Lo      2019-05-29   684  		src_clk_period, dst_clk_period);
9b9d8632f51f360 Joseph Lo      2019-05-29   685  	emc_dbg(emc, INFO, "  shared_zq_resistor: %d\n", !!shared_zq_resistor);
9b9d8632f51f360 Joseph Lo      2019-05-29   686  	emc_dbg(emc, INFO, "  num_channels: %u\n", emc->num_channels);
9b9d8632f51f360 Joseph Lo      2019-05-29   687  	emc_dbg(emc, INFO, "  opt_dll_mode: %d\n", opt_dll_mode);
9b9d8632f51f360 Joseph Lo      2019-05-29   688  
9b9d8632f51f360 Joseph Lo      2019-05-29   689  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29   690  	 * Step 1:
9b9d8632f51f360 Joseph Lo      2019-05-29   691  	 *   Pre DVFS SW sequence.
9b9d8632f51f360 Joseph Lo      2019-05-29   692  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29   693  	emc_dbg(emc, STEPS, "Step 1\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   694  	emc_dbg(emc, STEPS, "Step 1.1: Disable DLL temporarily.\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   695  
9b9d8632f51f360 Joseph Lo      2019-05-29   696  	value = emc_readl(emc, EMC_CFG_DIG_DLL);
9b9d8632f51f360 Joseph Lo      2019-05-29   697  	value &= ~EMC_CFG_DIG_DLL_CFG_DLL_EN;
9b9d8632f51f360 Joseph Lo      2019-05-29   698  	emc_writel(emc, value, EMC_CFG_DIG_DLL);
9b9d8632f51f360 Joseph Lo      2019-05-29   699  
9b9d8632f51f360 Joseph Lo      2019-05-29   700  	tegra210_emc_timing_update(emc);
9b9d8632f51f360 Joseph Lo      2019-05-29   701  
9b9d8632f51f360 Joseph Lo      2019-05-29   702  	for (i = 0; i < emc->num_channels; i++)
9b9d8632f51f360 Joseph Lo      2019-05-29   703  		tegra210_emc_wait_for_update(emc, i, EMC_CFG_DIG_DLL,
9b9d8632f51f360 Joseph Lo      2019-05-29   704  					     EMC_CFG_DIG_DLL_CFG_DLL_EN, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29   705  
9b9d8632f51f360 Joseph Lo      2019-05-29   706  	emc_dbg(emc, STEPS, "Step 1.2: Disable AUTOCAL temporarily.\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   707  
9b9d8632f51f360 Joseph Lo      2019-05-29   708  	emc_auto_cal_config = next->emc_auto_cal_config;
9b9d8632f51f360 Joseph Lo      2019-05-29   709  	auto_cal_en = emc_auto_cal_config & EMC_AUTO_CAL_CONFIG_AUTO_CAL_ENABLE;
9b9d8632f51f360 Joseph Lo      2019-05-29   710  	emc_auto_cal_config &= ~EMC_AUTO_CAL_CONFIG_AUTO_CAL_START;
9b9d8632f51f360 Joseph Lo      2019-05-29   711  	emc_auto_cal_config |= EMC_AUTO_CAL_CONFIG_AUTO_CAL_MEASURE_STALL;
9b9d8632f51f360 Joseph Lo      2019-05-29   712  	emc_auto_cal_config |= EMC_AUTO_CAL_CONFIG_AUTO_CAL_UPDATE_STALL;
9b9d8632f51f360 Joseph Lo      2019-05-29   713  	emc_auto_cal_config |= auto_cal_en;
9b9d8632f51f360 Joseph Lo      2019-05-29   714  	emc_writel(emc, emc_auto_cal_config, EMC_AUTO_CAL_CONFIG);
9b9d8632f51f360 Joseph Lo      2019-05-29   715  	emc_readl(emc, EMC_AUTO_CAL_CONFIG); /* Flush write. */
9b9d8632f51f360 Joseph Lo      2019-05-29   716  
9b9d8632f51f360 Joseph Lo      2019-05-29   717  	emc_dbg(emc, STEPS, "Step 1.3: Disable other power features.\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   718  
9b9d8632f51f360 Joseph Lo      2019-05-29   719  	tegra210_emc_set_shadow_bypass(emc, ACTIVE);
9b9d8632f51f360 Joseph Lo      2019-05-29   720  	emc_writel(emc, emc_cfg, EMC_CFG);
9b9d8632f51f360 Joseph Lo      2019-05-29   721  	emc_writel(emc, emc_sel_dpd_ctrl, EMC_SEL_DPD_CTRL);
9b9d8632f51f360 Joseph Lo      2019-05-29   722  	tegra210_emc_set_shadow_bypass(emc, ASSEMBLY);
9b9d8632f51f360 Joseph Lo      2019-05-29   723  
9b9d8632f51f360 Joseph Lo      2019-05-29   724  	if (next->periodic_training) {
9b9d8632f51f360 Joseph Lo      2019-05-29   725  		tegra210_emc_reset_dram_clktree_values(next);
9b9d8632f51f360 Joseph Lo      2019-05-29   726  
9b9d8632f51f360 Joseph Lo      2019-05-29   727  		for (i = 0; i < emc->num_channels; i++)
9b9d8632f51f360 Joseph Lo      2019-05-29   728  			tegra210_emc_wait_for_update(emc, i, EMC_EMC_STATUS,
9b9d8632f51f360 Joseph Lo      2019-05-29   729  						     EMC_EMC_STATUS_DRAM_IN_POWERDOWN_MASK,
9b9d8632f51f360 Joseph Lo      2019-05-29   730  						     0);
9b9d8632f51f360 Joseph Lo      2019-05-29   731  
9b9d8632f51f360 Joseph Lo      2019-05-29   732  		for (i = 0; i < emc->num_channels; i++)
9b9d8632f51f360 Joseph Lo      2019-05-29   733  			tegra210_emc_wait_for_update(emc, i, EMC_EMC_STATUS,
9b9d8632f51f360 Joseph Lo      2019-05-29   734  						     EMC_EMC_STATUS_DRAM_IN_SELF_REFRESH_MASK,
9b9d8632f51f360 Joseph Lo      2019-05-29   735  						     0);
9b9d8632f51f360 Joseph Lo      2019-05-29   736  
9b9d8632f51f360 Joseph Lo      2019-05-29   737  		tegra210_emc_start_periodic_compensation(emc);
9b9d8632f51f360 Joseph Lo      2019-05-29   738  
9b9d8632f51f360 Joseph Lo      2019-05-29   739  		delay = 1000 * tegra210_emc_actual_osc_clocks(last->run_clocks);
9b9d8632f51f360 Joseph Lo      2019-05-29   740  		udelay((delay / last->rate) + 2);
9b9d8632f51f360 Joseph Lo      2019-05-29   741  
9b9d8632f51f360 Joseph Lo      2019-05-29   742  		value = periodic_compensation_handler(emc, DVFS_SEQUENCE, fake,
9b9d8632f51f360 Joseph Lo      2019-05-29   743  						      next);
9b9d8632f51f360 Joseph Lo      2019-05-29   744  		value = (value * 128 * next->rate / 1000) / 1000000;
9b9d8632f51f360 Joseph Lo      2019-05-29   745  
9b9d8632f51f360 Joseph Lo      2019-05-29   746  		if (next->periodic_training && value > next->tree_margin)
9b9d8632f51f360 Joseph Lo      2019-05-29   747  			compensate_trimmer_applicable = true;
9b9d8632f51f360 Joseph Lo      2019-05-29   748  	}
9b9d8632f51f360 Joseph Lo      2019-05-29   749  
9b9d8632f51f360 Joseph Lo      2019-05-29   750  	emc_writel(emc, EMC_INTSTATUS_CLKCHANGE_COMPLETE, EMC_INTSTATUS);
9b9d8632f51f360 Joseph Lo      2019-05-29   751  	tegra210_emc_set_shadow_bypass(emc, ACTIVE);
9b9d8632f51f360 Joseph Lo      2019-05-29   752  	emc_writel(emc, emc_cfg, EMC_CFG);
9b9d8632f51f360 Joseph Lo      2019-05-29   753  	emc_writel(emc, emc_sel_dpd_ctrl, EMC_SEL_DPD_CTRL);
9b9d8632f51f360 Joseph Lo      2019-05-29   754  	emc_writel(emc, emc_cfg_pipe_clk | EMC_CFG_PIPE_CLK_CLK_ALWAYS_ON,
9b9d8632f51f360 Joseph Lo      2019-05-29   755  		   EMC_CFG_PIPE_CLK);
9b9d8632f51f360 Joseph Lo      2019-05-29   756  	emc_writel(emc, next->emc_fdpd_ctrl_cmd_no_ramp &
9b9d8632f51f360 Joseph Lo      2019-05-29   757  			~EMC_FDPD_CTRL_CMD_NO_RAMP_CMD_DPD_NO_RAMP_ENABLE,
9b9d8632f51f360 Joseph Lo      2019-05-29   758  		   EMC_FDPD_CTRL_CMD_NO_RAMP);
9b9d8632f51f360 Joseph Lo      2019-05-29   759  
9b9d8632f51f360 Joseph Lo      2019-05-29   760  	bg_reg_mode_change =
9b9d8632f51f360 Joseph Lo      2019-05-29   761  		((next->burst_regs[EMC_PMACRO_BG_BIAS_CTRL_0_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   762  		  EMC_PMACRO_BG_BIAS_CTRL_0_BGLP_E_PWRD) ^
9b9d8632f51f360 Joseph Lo      2019-05-29   763  		 (last->burst_regs[EMC_PMACRO_BG_BIAS_CTRL_0_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   764  		  EMC_PMACRO_BG_BIAS_CTRL_0_BGLP_E_PWRD)) ||
9b9d8632f51f360 Joseph Lo      2019-05-29   765  		((next->burst_regs[EMC_PMACRO_BG_BIAS_CTRL_0_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   766  		  EMC_PMACRO_BG_BIAS_CTRL_0_BG_E_PWRD) ^
9b9d8632f51f360 Joseph Lo      2019-05-29   767  		 (last->burst_regs[EMC_PMACRO_BG_BIAS_CTRL_0_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   768  		  EMC_PMACRO_BG_BIAS_CTRL_0_BG_E_PWRD));
9b9d8632f51f360 Joseph Lo      2019-05-29   769  	enable_bglp_reg =
9b9d8632f51f360 Joseph Lo      2019-05-29   770  		(next->burst_regs[EMC_PMACRO_BG_BIAS_CTRL_0_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   771  		 EMC_PMACRO_BG_BIAS_CTRL_0_BGLP_E_PWRD) == 0;
9b9d8632f51f360 Joseph Lo      2019-05-29   772  	enable_bg_reg =
9b9d8632f51f360 Joseph Lo      2019-05-29   773  		(next->burst_regs[EMC_PMACRO_BG_BIAS_CTRL_0_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   774  		 EMC_PMACRO_BG_BIAS_CTRL_0_BG_E_PWRD) == 0;
9b9d8632f51f360 Joseph Lo      2019-05-29   775  
9b9d8632f51f360 Joseph Lo      2019-05-29   776  	if (bg_reg_mode_change) {
9b9d8632f51f360 Joseph Lo      2019-05-29   777  		if (enable_bg_reg)
9b9d8632f51f360 Joseph Lo      2019-05-29   778  			emc_writel(emc, last->burst_regs
9b9d8632f51f360 Joseph Lo      2019-05-29   779  				   [EMC_PMACRO_BG_BIAS_CTRL_0_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   780  				   ~EMC_PMACRO_BG_BIAS_CTRL_0_BG_E_PWRD,
9b9d8632f51f360 Joseph Lo      2019-05-29   781  				   EMC_PMACRO_BG_BIAS_CTRL_0);
9b9d8632f51f360 Joseph Lo      2019-05-29   782  
9b9d8632f51f360 Joseph Lo      2019-05-29   783  		if (enable_bglp_reg)
9b9d8632f51f360 Joseph Lo      2019-05-29   784  			emc_writel(emc, last->burst_regs
9b9d8632f51f360 Joseph Lo      2019-05-29   785  				   [EMC_PMACRO_BG_BIAS_CTRL_0_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   786  				   ~EMC_PMACRO_BG_BIAS_CTRL_0_BGLP_E_PWRD,
9b9d8632f51f360 Joseph Lo      2019-05-29   787  				   EMC_PMACRO_BG_BIAS_CTRL_0);
9b9d8632f51f360 Joseph Lo      2019-05-29   788  	}
9b9d8632f51f360 Joseph Lo      2019-05-29   789  
9b9d8632f51f360 Joseph Lo      2019-05-29   790  	/* Check if we need to turn on VREF generator. */
9b9d8632f51f360 Joseph Lo      2019-05-29   791  	if ((((last->burst_regs[EMC_PMACRO_DATA_PAD_TX_CTRL_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   792  	       EMC_PMACRO_DATA_PAD_TX_CTRL_DATA_DQ_E_IVREF) == 0) &&
9b9d8632f51f360 Joseph Lo      2019-05-29   793  	     ((next->burst_regs[EMC_PMACRO_DATA_PAD_TX_CTRL_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   794  	       EMC_PMACRO_DATA_PAD_TX_CTRL_DATA_DQ_E_IVREF) == 1)) ||
9b9d8632f51f360 Joseph Lo      2019-05-29   795  	    (((last->burst_regs[EMC_PMACRO_DATA_PAD_TX_CTRL_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   796  	       EMC_PMACRO_DATA_PAD_TX_CTRL_DATA_DQS_E_IVREF) == 0) &&
9b9d8632f51f360 Joseph Lo      2019-05-29   797  	     ((next->burst_regs[EMC_PMACRO_DATA_PAD_TX_CTRL_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   798  	       EMC_PMACRO_DATA_PAD_TX_CTRL_DATA_DQS_E_IVREF) != 0))) {
9b9d8632f51f360 Joseph Lo      2019-05-29   799  		u32 pad_tx_ctrl =
9b9d8632f51f360 Joseph Lo      2019-05-29   800  		    next->burst_regs[EMC_PMACRO_DATA_PAD_TX_CTRL_INDEX];
9b9d8632f51f360 Joseph Lo      2019-05-29   801  		u32 last_pad_tx_ctrl =
9b9d8632f51f360 Joseph Lo      2019-05-29   802  		    last->burst_regs[EMC_PMACRO_DATA_PAD_TX_CTRL_INDEX];
9b9d8632f51f360 Joseph Lo      2019-05-29   803  		u32 next_dq_e_ivref, next_dqs_e_ivref;
9b9d8632f51f360 Joseph Lo      2019-05-29   804  
9b9d8632f51f360 Joseph Lo      2019-05-29   805  		next_dqs_e_ivref = pad_tx_ctrl &
9b9d8632f51f360 Joseph Lo      2019-05-29   806  				   EMC_PMACRO_DATA_PAD_TX_CTRL_DATA_DQS_E_IVREF;
9b9d8632f51f360 Joseph Lo      2019-05-29   807  		next_dq_e_ivref = pad_tx_ctrl &
9b9d8632f51f360 Joseph Lo      2019-05-29   808  				  EMC_PMACRO_DATA_PAD_TX_CTRL_DATA_DQ_E_IVREF;
9b9d8632f51f360 Joseph Lo      2019-05-29   809  		value = (last_pad_tx_ctrl &
9b9d8632f51f360 Joseph Lo      2019-05-29   810  				~EMC_PMACRO_DATA_PAD_TX_CTRL_DATA_DQ_E_IVREF &
9b9d8632f51f360 Joseph Lo      2019-05-29   811  				~EMC_PMACRO_DATA_PAD_TX_CTRL_DATA_DQS_E_IVREF) |
9b9d8632f51f360 Joseph Lo      2019-05-29   812  			next_dq_e_ivref | next_dqs_e_ivref;
9b9d8632f51f360 Joseph Lo      2019-05-29   813  		emc_writel(emc, value, EMC_PMACRO_DATA_PAD_TX_CTRL);
9b9d8632f51f360 Joseph Lo      2019-05-29   814  		udelay(1);
9b9d8632f51f360 Joseph Lo      2019-05-29   815  	} else if (bg_reg_mode_change) {
9b9d8632f51f360 Joseph Lo      2019-05-29   816  		udelay(1);
9b9d8632f51f360 Joseph Lo      2019-05-29   817  	}
9b9d8632f51f360 Joseph Lo      2019-05-29   818  
9b9d8632f51f360 Joseph Lo      2019-05-29   819  	tegra210_emc_set_shadow_bypass(emc, ASSEMBLY);
9b9d8632f51f360 Joseph Lo      2019-05-29   820  
9b9d8632f51f360 Joseph Lo      2019-05-29   821  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29   822  	 * Step 2:
9b9d8632f51f360 Joseph Lo      2019-05-29   823  	 *   Prelock the DLL.
9b9d8632f51f360 Joseph Lo      2019-05-29   824  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29   825  	emc_dbg(emc, STEPS, "Step 2\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   826  
9b9d8632f51f360 Joseph Lo      2019-05-29   827  	if (next->burst_regs[EMC_CFG_DIG_DLL_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29   828  	    EMC_CFG_DIG_DLL_CFG_DLL_EN) {
9b9d8632f51f360 Joseph Lo      2019-05-29   829  		emc_dbg(emc, INFO, "Prelock enabled for target frequency.\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   830  		value = tegra210_emc_dll_prelock(emc, clksrc);
9b9d8632f51f360 Joseph Lo      2019-05-29   831  		emc_dbg(emc, INFO, "DLL out: 0x%03x\n", value);
9b9d8632f51f360 Joseph Lo      2019-05-29   832  	} else {
9b9d8632f51f360 Joseph Lo      2019-05-29   833  		emc_dbg(emc, INFO, "Disabling DLL for target frequency.\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   834  		tegra210_emc_dll_disable(emc);
9b9d8632f51f360 Joseph Lo      2019-05-29   835  	}
9b9d8632f51f360 Joseph Lo      2019-05-29   836  
9b9d8632f51f360 Joseph Lo      2019-05-29   837  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29   838  	 * Step 3:
9b9d8632f51f360 Joseph Lo      2019-05-29   839  	 *   Prepare autocal for the clock change.
9b9d8632f51f360 Joseph Lo      2019-05-29   840  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29   841  	emc_dbg(emc, STEPS, "Step 3\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   842  
9b9d8632f51f360 Joseph Lo      2019-05-29   843  	tegra210_emc_set_shadow_bypass(emc, ACTIVE);
9b9d8632f51f360 Joseph Lo      2019-05-29   844  	emc_writel(emc, next->emc_auto_cal_config2, EMC_AUTO_CAL_CONFIG2);
9b9d8632f51f360 Joseph Lo      2019-05-29   845  	emc_writel(emc, next->emc_auto_cal_config3, EMC_AUTO_CAL_CONFIG3);
9b9d8632f51f360 Joseph Lo      2019-05-29   846  	emc_writel(emc, next->emc_auto_cal_config4, EMC_AUTO_CAL_CONFIG4);
9b9d8632f51f360 Joseph Lo      2019-05-29   847  	emc_writel(emc, next->emc_auto_cal_config5, EMC_AUTO_CAL_CONFIG5);
9b9d8632f51f360 Joseph Lo      2019-05-29   848  	emc_writel(emc, next->emc_auto_cal_config6, EMC_AUTO_CAL_CONFIG6);
9b9d8632f51f360 Joseph Lo      2019-05-29   849  	emc_writel(emc, next->emc_auto_cal_config7, EMC_AUTO_CAL_CONFIG7);
9b9d8632f51f360 Joseph Lo      2019-05-29   850  	emc_writel(emc, next->emc_auto_cal_config8, EMC_AUTO_CAL_CONFIG8);
9b9d8632f51f360 Joseph Lo      2019-05-29   851  	tegra210_emc_set_shadow_bypass(emc, ASSEMBLY);
9b9d8632f51f360 Joseph Lo      2019-05-29   852  
9b9d8632f51f360 Joseph Lo      2019-05-29   853  	emc_auto_cal_config |= (EMC_AUTO_CAL_CONFIG_AUTO_CAL_COMPUTE_START |
9b9d8632f51f360 Joseph Lo      2019-05-29   854  				auto_cal_en);
9b9d8632f51f360 Joseph Lo      2019-05-29   855  	emc_writel(emc, emc_auto_cal_config, EMC_AUTO_CAL_CONFIG);
9b9d8632f51f360 Joseph Lo      2019-05-29   856  
9b9d8632f51f360 Joseph Lo      2019-05-29   857  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29   858  	 * Step 4:
9b9d8632f51f360 Joseph Lo      2019-05-29   859  	 *   Update EMC_CFG. (??)
9b9d8632f51f360 Joseph Lo      2019-05-29   860  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29   861  	emc_dbg(emc, STEPS, "Step 4\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   862  
9b9d8632f51f360 Joseph Lo      2019-05-29   863  	if (src_clk_period > 50000 && dram_type == DRAM_TYPE_LPDDR4)
9b9d8632f51f360 Joseph Lo      2019-05-29   864  		ccfifo_writel(emc, 1, EMC_SELF_REF, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29   865  	else
9b9d8632f51f360 Joseph Lo      2019-05-29   866  		emc_writel(emc, next->emc_cfg_2, EMC_CFG_2);
9b9d8632f51f360 Joseph Lo      2019-05-29   867  
9b9d8632f51f360 Joseph Lo      2019-05-29   868  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29   869  	 * Step 5:
9b9d8632f51f360 Joseph Lo      2019-05-29   870  	 *   Prepare reference variables for ZQCAL regs.
9b9d8632f51f360 Joseph Lo      2019-05-29   871  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29   872  	emc_dbg(emc, STEPS, "Step 5\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   873  
9b9d8632f51f360 Joseph Lo      2019-05-29   874  	if (dram_type == DRAM_TYPE_LPDDR4)
9b9d8632f51f360 Joseph Lo      2019-05-29   875  		zq_wait_long = max((u32)1, div_o3(1000000, dst_clk_period));
9b9d8632f51f360 Joseph Lo      2019-05-29   876  	else if (dram_type == DRAM_TYPE_LPDDR2 || is_lpddr3)
9b9d8632f51f360 Joseph Lo      2019-05-29   877  		zq_wait_long = max(next->min_mrs_wait,
9b9d8632f51f360 Joseph Lo      2019-05-29   878  				   div_o3(360000, dst_clk_period)) + 4;
9b9d8632f51f360 Joseph Lo      2019-05-29   879  	else if (dram_type == DRAM_TYPE_DDR3)
9b9d8632f51f360 Joseph Lo      2019-05-29   880  		zq_wait_long = max((u32)256,
9b9d8632f51f360 Joseph Lo      2019-05-29   881  				   div_o3(320000, dst_clk_period) + 2);
9b9d8632f51f360 Joseph Lo      2019-05-29   882  	else
9b9d8632f51f360 Joseph Lo      2019-05-29   883  		zq_wait_long = 0;
9b9d8632f51f360 Joseph Lo      2019-05-29   884  
9b9d8632f51f360 Joseph Lo      2019-05-29   885  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29   886  	 * Step 6:
9b9d8632f51f360 Joseph Lo      2019-05-29   887  	 *   Training code - removed.
9b9d8632f51f360 Joseph Lo      2019-05-29   888  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29   889  	emc_dbg(emc, STEPS, "Step 6\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   890  
9b9d8632f51f360 Joseph Lo      2019-05-29   891  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29   892  	 * Step 7:
9b9d8632f51f360 Joseph Lo      2019-05-29   893  	 *   Program FSP reference registers and send MRWs to new FSPWR.
9b9d8632f51f360 Joseph Lo      2019-05-29   894  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29   895  	emc_dbg(emc, STEPS, "Step 7\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   896  	emc_dbg(emc, SUB_STEPS, "Step 7.1: Bug 200024907 - Patch RP R2P");
9b9d8632f51f360 Joseph Lo      2019-05-29   897  
9b9d8632f51f360 Joseph Lo      2019-05-29   898  	/* WAR 200024907 */
9b9d8632f51f360 Joseph Lo      2019-05-29   899  	if (dram_type == DRAM_TYPE_LPDDR4) {
9b9d8632f51f360 Joseph Lo      2019-05-29   900  		u32 nRTP = 16;
9b9d8632f51f360 Joseph Lo      2019-05-29   901  
9b9d8632f51f360 Joseph Lo      2019-05-29   902  		if (src_clk_period >= 1000000 / 1866) /* 535.91 ps */
9b9d8632f51f360 Joseph Lo      2019-05-29   903  			nRTP = 14;
9b9d8632f51f360 Joseph Lo      2019-05-29   904  
9b9d8632f51f360 Joseph Lo      2019-05-29   905  		if (src_clk_period >= 1000000 / 1600) /* 625.00 ps */
9b9d8632f51f360 Joseph Lo      2019-05-29   906  			nRTP = 12;
9b9d8632f51f360 Joseph Lo      2019-05-29   907  
9b9d8632f51f360 Joseph Lo      2019-05-29   908  		if (src_clk_period >= 1000000 / 1333) /* 750.19 ps */
9b9d8632f51f360 Joseph Lo      2019-05-29   909  			nRTP = 10;
9b9d8632f51f360 Joseph Lo      2019-05-29   910  
9b9d8632f51f360 Joseph Lo      2019-05-29   911  		if (src_clk_period >= 1000000 / 1066) /* 938.09 ps */
9b9d8632f51f360 Joseph Lo      2019-05-29   912  			nRTP = 8;
9b9d8632f51f360 Joseph Lo      2019-05-29   913  
9b9d8632f51f360 Joseph Lo      2019-05-29   914  		deltaTWATM = max_t(u32, div_o3(7500, src_clk_period), 8);
9b9d8632f51f360 Joseph Lo      2019-05-29   915  
9b9d8632f51f360 Joseph Lo      2019-05-29   916  		/*
9b9d8632f51f360 Joseph Lo      2019-05-29   917  		 * Originally there was a + .5 in the tRPST calculation.
9b9d8632f51f360 Joseph Lo      2019-05-29   918  		 * However since we can't do FP in the kernel and the tRTM
9b9d8632f51f360 Joseph Lo      2019-05-29   919  		 * computation was in a floating point ceiling function, adding
9b9d8632f51f360 Joseph Lo      2019-05-29   920  		 * one to tRTP should be ok. There is no other source of non
9b9d8632f51f360 Joseph Lo      2019-05-29   921  		 * integer values, so the result was always going to be
9b9d8632f51f360 Joseph Lo      2019-05-29   922  		 * something for the form: f_ceil(N + .5) = N + 1;
9b9d8632f51f360 Joseph Lo      2019-05-29   923  		 */
9b9d8632f51f360 Joseph Lo      2019-05-29   924  		tRPST = (last->emc_mrw & 0x80) >> 7;
9b9d8632f51f360 Joseph Lo      2019-05-29   925  		tRTM = fake->dram_timings[RL] + div_o3(3600, src_clk_period) +
9b9d8632f51f360 Joseph Lo      2019-05-29   926  			max_t(u32, div_o3(7500, src_clk_period), 8) + tRPST +
9b9d8632f51f360 Joseph Lo      2019-05-29   927  			1 + nRTP;
9b9d8632f51f360 Joseph Lo      2019-05-29   928  
9b9d8632f51f360 Joseph Lo      2019-05-29   929  		emc_dbg(emc, INFO, "tRTM = %u, EMC_RP = %u\n", tRTM,
9b9d8632f51f360 Joseph Lo      2019-05-29   930  			next->burst_regs[EMC_RP_INDEX]);
9b9d8632f51f360 Joseph Lo      2019-05-29   931  
9b9d8632f51f360 Joseph Lo      2019-05-29   932  		if (last->burst_regs[EMC_RP_INDEX] < tRTM) {
9b9d8632f51f360 Joseph Lo      2019-05-29   933  			if (tRTM > (last->burst_regs[EMC_R2P_INDEX] +
9b9d8632f51f360 Joseph Lo      2019-05-29   934  				    last->burst_regs[EMC_RP_INDEX])) {
9b9d8632f51f360 Joseph Lo      2019-05-29   935  				R2P_war = tRTM - last->burst_regs[EMC_RP_INDEX];
9b9d8632f51f360 Joseph Lo      2019-05-29   936  				RP_war = last->burst_regs[EMC_RP_INDEX];
9b9d8632f51f360 Joseph Lo      2019-05-29   937  				TRPab_war = last->burst_regs[EMC_TRPAB_INDEX];
9b9d8632f51f360 Joseph Lo      2019-05-29   938  
9b9d8632f51f360 Joseph Lo      2019-05-29   939  				if (R2P_war > 63) {
9b9d8632f51f360 Joseph Lo      2019-05-29   940  					RP_war = R2P_war +
9b9d8632f51f360 Joseph Lo      2019-05-29   941  						 last->burst_regs[EMC_RP_INDEX] - 63;
9b9d8632f51f360 Joseph Lo      2019-05-29   942  
9b9d8632f51f360 Joseph Lo      2019-05-29   943  					if (TRPab_war < RP_war)
9b9d8632f51f360 Joseph Lo      2019-05-29   944  						TRPab_war = RP_war;
9b9d8632f51f360 Joseph Lo      2019-05-29   945  
9b9d8632f51f360 Joseph Lo      2019-05-29   946  					R2P_war = 63;
9b9d8632f51f360 Joseph Lo      2019-05-29   947  				}
9b9d8632f51f360 Joseph Lo      2019-05-29   948  			} else {
9b9d8632f51f360 Joseph Lo      2019-05-29   949  				R2P_war = last->burst_regs[EMC_R2P_INDEX];
9b9d8632f51f360 Joseph Lo      2019-05-29   950  				RP_war = last->burst_regs[EMC_RP_INDEX];
9b9d8632f51f360 Joseph Lo      2019-05-29   951  				TRPab_war = last->burst_regs[EMC_TRPAB_INDEX];
9b9d8632f51f360 Joseph Lo      2019-05-29   952  			}
9b9d8632f51f360 Joseph Lo      2019-05-29   953  
9b9d8632f51f360 Joseph Lo      2019-05-29   954  			if (RP_war < deltaTWATM) {
9b9d8632f51f360 Joseph Lo      2019-05-29   955  				W2P_war = last->burst_regs[EMC_W2P_INDEX]
9b9d8632f51f360 Joseph Lo      2019-05-29   956  					  + deltaTWATM - RP_war;
9b9d8632f51f360 Joseph Lo      2019-05-29   957  				if (W2P_war > 63) {
9b9d8632f51f360 Joseph Lo      2019-05-29   958  					RP_war = RP_war + W2P_war - 63;
9b9d8632f51f360 Joseph Lo      2019-05-29   959  					if (TRPab_war < RP_war)
9b9d8632f51f360 Joseph Lo      2019-05-29   960  						TRPab_war = RP_war;
9b9d8632f51f360 Joseph Lo      2019-05-29   961  					W2P_war = 63;
9b9d8632f51f360 Joseph Lo      2019-05-29   962  				}
9b9d8632f51f360 Joseph Lo      2019-05-29   963  			} else {
9b9d8632f51f360 Joseph Lo      2019-05-29   964  				W2P_war = last->burst_regs[
9b9d8632f51f360 Joseph Lo      2019-05-29   965  					  EMC_W2P_INDEX];
9b9d8632f51f360 Joseph Lo      2019-05-29   966  			}
9b9d8632f51f360 Joseph Lo      2019-05-29   967  
9b9d8632f51f360 Joseph Lo      2019-05-29   968  			if ((last->burst_regs[EMC_W2P_INDEX] ^ W2P_war) ||
9b9d8632f51f360 Joseph Lo      2019-05-29   969  			    (last->burst_regs[EMC_R2P_INDEX] ^ R2P_war) ||
9b9d8632f51f360 Joseph Lo      2019-05-29   970  			    (last->burst_regs[EMC_RP_INDEX] ^ RP_war) ||
9b9d8632f51f360 Joseph Lo      2019-05-29   971  			    (last->burst_regs[EMC_TRPAB_INDEX] ^ TRPab_war)) {
9b9d8632f51f360 Joseph Lo      2019-05-29   972  				emc_writel(emc, RP_war, EMC_RP);
9b9d8632f51f360 Joseph Lo      2019-05-29   973  				emc_writel(emc, R2P_war, EMC_R2P);
9b9d8632f51f360 Joseph Lo      2019-05-29   974  				emc_writel(emc, W2P_war, EMC_W2P);
9b9d8632f51f360 Joseph Lo      2019-05-29   975  				emc_writel(emc, TRPab_war, EMC_TRPAB);
9b9d8632f51f360 Joseph Lo      2019-05-29   976  			}
9b9d8632f51f360 Joseph Lo      2019-05-29   977  
9b9d8632f51f360 Joseph Lo      2019-05-29   978  			tegra210_emc_timing_update(emc);
9b9d8632f51f360 Joseph Lo      2019-05-29   979  		} else {
9b9d8632f51f360 Joseph Lo      2019-05-29   980  			emc_dbg(emc, INFO, "Skipped WAR\n");
9b9d8632f51f360 Joseph Lo      2019-05-29   981  		}
9b9d8632f51f360 Joseph Lo      2019-05-29   982  	}
9b9d8632f51f360 Joseph Lo      2019-05-29   983  
9b9d8632f51f360 Joseph Lo      2019-05-29   984  	if (!fsp_for_next_freq) {
9b9d8632f51f360 Joseph Lo      2019-05-29   985  		mr13_flip_fspwr = (next->emc_mrw3 & 0xffffff3f) | 0x80;
9b9d8632f51f360 Joseph Lo      2019-05-29   986  		mr13_flip_fspop = (next->emc_mrw3 & 0xffffff3f) | 0x00;
9b9d8632f51f360 Joseph Lo      2019-05-29   987  	} else {
9b9d8632f51f360 Joseph Lo      2019-05-29   988  		mr13_flip_fspwr = (next->emc_mrw3 & 0xffffff3f) | 0x40;
9b9d8632f51f360 Joseph Lo      2019-05-29   989  		mr13_flip_fspop = (next->emc_mrw3 & 0xffffff3f) | 0xc0;
9b9d8632f51f360 Joseph Lo      2019-05-29   990  	}
9b9d8632f51f360 Joseph Lo      2019-05-29   991  
9b9d8632f51f360 Joseph Lo      2019-05-29   992  	if (dram_type == DRAM_TYPE_LPDDR4) {
9b9d8632f51f360 Joseph Lo      2019-05-29   993  		emc_writel(emc, mr13_flip_fspwr, EMC_MRW3);
9b9d8632f51f360 Joseph Lo      2019-05-29   994  		emc_writel(emc, next->emc_mrw, EMC_MRW);
9b9d8632f51f360 Joseph Lo      2019-05-29   995  		emc_writel(emc, next->emc_mrw2, EMC_MRW2);
9b9d8632f51f360 Joseph Lo      2019-05-29   996  	}
9b9d8632f51f360 Joseph Lo      2019-05-29   997  
9b9d8632f51f360 Joseph Lo      2019-05-29   998  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29   999  	 * Step 8:
9b9d8632f51f360 Joseph Lo      2019-05-29  1000  	 *   Program the shadow registers.
9b9d8632f51f360 Joseph Lo      2019-05-29  1001  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1002  	emc_dbg(emc, STEPS, "Step 8\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1003  	emc_dbg(emc, SUB_STEPS, "Writing burst_regs\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1004  
9b9d8632f51f360 Joseph Lo      2019-05-29  1005  	for (i = 0; i < next->num_burst; i++) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1006  		const u16 *offsets = emc->offsets->burst;
9b9d8632f51f360 Joseph Lo      2019-05-29  1007  		u16 offset;
9b9d8632f51f360 Joseph Lo      2019-05-29  1008  
9b9d8632f51f360 Joseph Lo      2019-05-29  1009  		if (!offsets[i])
9b9d8632f51f360 Joseph Lo      2019-05-29  1010  			continue;
9b9d8632f51f360 Joseph Lo      2019-05-29  1011  
9b9d8632f51f360 Joseph Lo      2019-05-29  1012  		value = next->burst_regs[i];
9b9d8632f51f360 Joseph Lo      2019-05-29  1013  		offset = offsets[i];
9b9d8632f51f360 Joseph Lo      2019-05-29  1014  
9b9d8632f51f360 Joseph Lo      2019-05-29  1015  		if (dram_type != DRAM_TYPE_LPDDR4 &&
9b9d8632f51f360 Joseph Lo      2019-05-29  1016  		    (offset == EMC_MRW6 || offset == EMC_MRW7 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1017  		     offset == EMC_MRW8 || offset == EMC_MRW9 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1018  		     offset == EMC_MRW10 || offset == EMC_MRW11 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1019  		     offset == EMC_MRW12 || offset == EMC_MRW13 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1020  		     offset == EMC_MRW14 || offset == EMC_MRW15 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1021  		     offset == EMC_TRAINING_CTRL))
9b9d8632f51f360 Joseph Lo      2019-05-29  1022  			continue;
9b9d8632f51f360 Joseph Lo      2019-05-29  1023  
9b9d8632f51f360 Joseph Lo      2019-05-29  1024  		/* Pain... And suffering. */
9b9d8632f51f360 Joseph Lo      2019-05-29  1025  		if (offset == EMC_CFG) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1026  			value &= ~EMC_CFG_DRAM_ACPD;
9b9d8632f51f360 Joseph Lo      2019-05-29  1027  			value &= ~EMC_CFG_DYN_SELF_REF;
9b9d8632f51f360 Joseph Lo      2019-05-29  1028  
9b9d8632f51f360 Joseph Lo      2019-05-29  1029  			if (dram_type == DRAM_TYPE_LPDDR4) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1030  				value &= ~EMC_CFG_DRAM_CLKSTOP_SR;
9b9d8632f51f360 Joseph Lo      2019-05-29  1031  				value &= ~EMC_CFG_DRAM_CLKSTOP_PD;
9b9d8632f51f360 Joseph Lo      2019-05-29  1032  			}
9b9d8632f51f360 Joseph Lo      2019-05-29  1033  		} else if (offset == EMC_MRS_WAIT_CNT &&
9b9d8632f51f360 Joseph Lo      2019-05-29  1034  			   dram_type == DRAM_TYPE_LPDDR2 &&
9b9d8632f51f360 Joseph Lo      2019-05-29 @1035  			   opt_zcal_en_cc && !opt_cc_short_zcal &&
9b9d8632f51f360 Joseph Lo      2019-05-29  1036  			   opt_short_zcal) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1037  			value = (value & ~(EMC_MRS_WAIT_CNT_SHORT_WAIT_MASK <<
9b9d8632f51f360 Joseph Lo      2019-05-29  1038  					   EMC_MRS_WAIT_CNT_SHORT_WAIT_SHIFT)) |
9b9d8632f51f360 Joseph Lo      2019-05-29  1039  				((zq_wait_long & EMC_MRS_WAIT_CNT_SHORT_WAIT_MASK) <<
9b9d8632f51f360 Joseph Lo      2019-05-29  1040  						 EMC_MRS_WAIT_CNT_SHORT_WAIT_SHIFT);
9b9d8632f51f360 Joseph Lo      2019-05-29  1041  		} else if (offset == EMC_ZCAL_WAIT_CNT &&
9b9d8632f51f360 Joseph Lo      2019-05-29  1042  			   dram_type == DRAM_TYPE_DDR3 && opt_zcal_en_cc &&
9b9d8632f51f360 Joseph Lo      2019-05-29  1043  			   !opt_cc_short_zcal && opt_short_zcal) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1044  			value = (value & ~(EMC_ZCAL_WAIT_CNT_ZCAL_WAIT_CNT_MASK <<
9b9d8632f51f360 Joseph Lo      2019-05-29  1045  					   EMC_ZCAL_WAIT_CNT_ZCAL_WAIT_CNT_SHIFT)) |
9b9d8632f51f360 Joseph Lo      2019-05-29  1046  				((zq_wait_long & EMC_ZCAL_WAIT_CNT_ZCAL_WAIT_CNT_MASK) <<
9b9d8632f51f360 Joseph Lo      2019-05-29  1047  						 EMC_MRS_WAIT_CNT_SHORT_WAIT_SHIFT);
9b9d8632f51f360 Joseph Lo      2019-05-29  1048  		} else if (offset == EMC_ZCAL_INTERVAL && opt_zcal_en_cc) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1049  			value = 0; /* EMC_ZCAL_INTERVAL reset value. */
9b9d8632f51f360 Joseph Lo      2019-05-29  1050  		} else if (offset == EMC_PMACRO_AUTOCAL_CFG_COMMON) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1051  			value |= EMC_PMACRO_AUTOCAL_CFG_COMMON_E_CAL_BYPASS_DVFS;
9b9d8632f51f360 Joseph Lo      2019-05-29  1052  		} else if (offset == EMC_PMACRO_DATA_PAD_TX_CTRL) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1053  			value &= ~(EMC_PMACRO_DATA_PAD_TX_CTRL_DATA_DQSP_TX_E_DCC |
9b9d8632f51f360 Joseph Lo      2019-05-29  1054  				   EMC_PMACRO_DATA_PAD_TX_CTRL_DATA_DQSN_TX_E_DCC |
9b9d8632f51f360 Joseph Lo      2019-05-29  1055  				   EMC_PMACRO_DATA_PAD_TX_CTRL_DATA_DQ_TX_E_DCC |
9b9d8632f51f360 Joseph Lo      2019-05-29  1056  				   EMC_PMACRO_DATA_PAD_TX_CTRL_DATA_CMD_TX_E_DCC);
9b9d8632f51f360 Joseph Lo      2019-05-29  1057  		} else if (offset == EMC_PMACRO_CMD_PAD_TX_CTRL) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1058  			value |= EMC_PMACRO_CMD_PAD_TX_CTRL_CMD_DQ_TX_DRVFORCEON;
9b9d8632f51f360 Joseph Lo      2019-05-29  1059  			value &= ~(EMC_PMACRO_CMD_PAD_TX_CTRL_CMD_DQSP_TX_E_DCC |
9b9d8632f51f360 Joseph Lo      2019-05-29  1060  				   EMC_PMACRO_CMD_PAD_TX_CTRL_CMD_DQSN_TX_E_DCC |
9b9d8632f51f360 Joseph Lo      2019-05-29  1061  				   EMC_PMACRO_CMD_PAD_TX_CTRL_CMD_DQ_TX_E_DCC |
9b9d8632f51f360 Joseph Lo      2019-05-29  1062  				   EMC_PMACRO_CMD_PAD_TX_CTRL_CMD_CMD_TX_E_DCC);
9b9d8632f51f360 Joseph Lo      2019-05-29  1063  		} else if (offset == EMC_PMACRO_BRICK_CTRL_RFU1) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1064  			value &= 0xf800f800;
9b9d8632f51f360 Joseph Lo      2019-05-29  1065  		} else if (offset == EMC_PMACRO_COMMON_PAD_TX_CTRL) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1066  			value &= 0xfffffff0;
9b9d8632f51f360 Joseph Lo      2019-05-29  1067  		}
9b9d8632f51f360 Joseph Lo      2019-05-29  1068  
9b9d8632f51f360 Joseph Lo      2019-05-29  1069  		emc_writel(emc, value, offset);
9b9d8632f51f360 Joseph Lo      2019-05-29  1070  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1071  
0553d7b204ef480 Thierry Reding 2020-04-03  1072  	/* SW addition: do EMC refresh adjustment here. */
0553d7b204ef480 Thierry Reding 2020-04-03  1073  	tegra210_emc_adjust_timing(emc, next);
0553d7b204ef480 Thierry Reding 2020-04-03  1074  
9b9d8632f51f360 Joseph Lo      2019-05-29  1075  	if (dram_type == DRAM_TYPE_LPDDR4) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1076  		value = (23 << EMC_MRW_MRW_MA_SHIFT) |
9b9d8632f51f360 Joseph Lo      2019-05-29  1077  			(next->run_clocks & EMC_MRW_MRW_OP_MASK);
9b9d8632f51f360 Joseph Lo      2019-05-29  1078  		emc_writel(emc, value, EMC_MRW);
9b9d8632f51f360 Joseph Lo      2019-05-29  1079  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1080  
9b9d8632f51f360 Joseph Lo      2019-05-29  1081  	/* Per channel burst registers. */
9b9d8632f51f360 Joseph Lo      2019-05-29  1082  	emc_dbg(emc, SUB_STEPS, "Writing burst_regs_per_ch\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1083  
9b9d8632f51f360 Joseph Lo      2019-05-29  1084  	for (i = 0; i < next->num_burst_per_ch; i++) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1085  		const struct tegra210_emc_per_channel_regs *burst =
9b9d8632f51f360 Joseph Lo      2019-05-29  1086  				emc->offsets->burst_per_channel;
9b9d8632f51f360 Joseph Lo      2019-05-29  1087  
9b9d8632f51f360 Joseph Lo      2019-05-29  1088  		if (!burst[i].offset)
9b9d8632f51f360 Joseph Lo      2019-05-29  1089  			continue;
9b9d8632f51f360 Joseph Lo      2019-05-29  1090  
9b9d8632f51f360 Joseph Lo      2019-05-29  1091  		if (dram_type != DRAM_TYPE_LPDDR4 &&
9b9d8632f51f360 Joseph Lo      2019-05-29  1092  		    (burst[i].offset == EMC_MRW6 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1093  		     burst[i].offset == EMC_MRW7 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1094  		     burst[i].offset == EMC_MRW8 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1095  		     burst[i].offset == EMC_MRW9 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1096  		     burst[i].offset == EMC_MRW10 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1097  		     burst[i].offset == EMC_MRW11 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1098  		     burst[i].offset == EMC_MRW12 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1099  		     burst[i].offset == EMC_MRW13 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1100  		     burst[i].offset == EMC_MRW14 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1101  		     burst[i].offset == EMC_MRW15))
9b9d8632f51f360 Joseph Lo      2019-05-29  1102  			continue;
9b9d8632f51f360 Joseph Lo      2019-05-29  1103  
9b9d8632f51f360 Joseph Lo      2019-05-29  1104  		/* Filter out second channel if not in DUAL_CHANNEL mode. */
9b9d8632f51f360 Joseph Lo      2019-05-29  1105  		if (emc->num_channels < 2 && burst[i].bank >= 1)
9b9d8632f51f360 Joseph Lo      2019-05-29  1106  			continue;
9b9d8632f51f360 Joseph Lo      2019-05-29  1107  
9b9d8632f51f360 Joseph Lo      2019-05-29  1108  		emc_dbg(emc, REG_LISTS, "(%u) 0x%08x => 0x%08x\n", i,
9b9d8632f51f360 Joseph Lo      2019-05-29  1109  			next->burst_reg_per_ch[i], burst[i].offset);
9b9d8632f51f360 Joseph Lo      2019-05-29  1110  		emc_channel_writel(emc, burst[i].bank,
9b9d8632f51f360 Joseph Lo      2019-05-29  1111  				   next->burst_reg_per_ch[i],
9b9d8632f51f360 Joseph Lo      2019-05-29  1112  				   burst[i].offset);
9b9d8632f51f360 Joseph Lo      2019-05-29  1113  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1114  
9b9d8632f51f360 Joseph Lo      2019-05-29  1115  	/* Vref regs. */
9b9d8632f51f360 Joseph Lo      2019-05-29  1116  	emc_dbg(emc, SUB_STEPS, "Writing vref_regs\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1117  
9b9d8632f51f360 Joseph Lo      2019-05-29  1118  	for (i = 0; i < next->vref_num; i++) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1119  		const struct tegra210_emc_per_channel_regs *vref =
9b9d8632f51f360 Joseph Lo      2019-05-29  1120  					emc->offsets->vref_per_channel;
9b9d8632f51f360 Joseph Lo      2019-05-29  1121  
9b9d8632f51f360 Joseph Lo      2019-05-29  1122  		if (!vref[i].offset)
9b9d8632f51f360 Joseph Lo      2019-05-29  1123  			continue;
9b9d8632f51f360 Joseph Lo      2019-05-29  1124  
9b9d8632f51f360 Joseph Lo      2019-05-29  1125  		if (emc->num_channels < 2 && vref[i].bank >= 1)
9b9d8632f51f360 Joseph Lo      2019-05-29  1126  			continue;
9b9d8632f51f360 Joseph Lo      2019-05-29  1127  
9b9d8632f51f360 Joseph Lo      2019-05-29  1128  		emc_dbg(emc, REG_LISTS, "(%u) 0x%08x => 0x%08x\n", i,
9b9d8632f51f360 Joseph Lo      2019-05-29  1129  			next->vref_perch_regs[i], vref[i].offset);
9b9d8632f51f360 Joseph Lo      2019-05-29  1130  		emc_channel_writel(emc, vref[i].bank, next->vref_perch_regs[i],
9b9d8632f51f360 Joseph Lo      2019-05-29  1131  				   vref[i].offset);
9b9d8632f51f360 Joseph Lo      2019-05-29  1132  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1133  
9b9d8632f51f360 Joseph Lo      2019-05-29  1134  	/* Trimmers. */
9b9d8632f51f360 Joseph Lo      2019-05-29  1135  	emc_dbg(emc, SUB_STEPS, "Writing trim_regs\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1136  
9b9d8632f51f360 Joseph Lo      2019-05-29  1137  	for (i = 0; i < next->num_trim; i++) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1138  		const u16 *offsets = emc->offsets->trim;
9b9d8632f51f360 Joseph Lo      2019-05-29  1139  
9b9d8632f51f360 Joseph Lo      2019-05-29  1140  		if (!offsets[i])
9b9d8632f51f360 Joseph Lo      2019-05-29  1141  			continue;
9b9d8632f51f360 Joseph Lo      2019-05-29  1142  
9b9d8632f51f360 Joseph Lo      2019-05-29  1143  		if (compensate_trimmer_applicable &&
9b9d8632f51f360 Joseph Lo      2019-05-29  1144  		    (offsets[i] == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK0_0 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1145  		     offsets[i] == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK0_1 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1146  		     offsets[i] == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK0_2 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1147  		     offsets[i] == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK0_3 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1148  		     offsets[i] == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK1_0 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1149  		     offsets[i] == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK1_1 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1150  		     offsets[i] == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK1_2 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1151  		     offsets[i] == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK1_3 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1152  		     offsets[i] == EMC_DATA_BRLSHFT_0 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1153  		     offsets[i] == EMC_DATA_BRLSHFT_1)) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1154  			value = tegra210_emc_compensate(next, offsets[i]);
9b9d8632f51f360 Joseph Lo      2019-05-29  1155  			emc_dbg(emc, REG_LISTS, "(%u) 0x%08x => 0x%08x\n", i,
9b9d8632f51f360 Joseph Lo      2019-05-29  1156  				value, offsets[i]);
9b9d8632f51f360 Joseph Lo      2019-05-29  1157  			emc_dbg(emc, EMA_WRITES, "0x%08x <= 0x%08x\n",
9b9d8632f51f360 Joseph Lo      2019-05-29  1158  				(u32)(u64)offsets[i], value);
9b9d8632f51f360 Joseph Lo      2019-05-29  1159  			emc_writel(emc, value, offsets[i]);
9b9d8632f51f360 Joseph Lo      2019-05-29  1160  		} else {
9b9d8632f51f360 Joseph Lo      2019-05-29  1161  			emc_dbg(emc, REG_LISTS, "(%u) 0x%08x => 0x%08x\n", i,
9b9d8632f51f360 Joseph Lo      2019-05-29  1162  				next->trim_regs[i], offsets[i]);
9b9d8632f51f360 Joseph Lo      2019-05-29  1163  			emc_writel(emc, next->trim_regs[i], offsets[i]);
9b9d8632f51f360 Joseph Lo      2019-05-29  1164  		}
9b9d8632f51f360 Joseph Lo      2019-05-29  1165  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1166  
9b9d8632f51f360 Joseph Lo      2019-05-29  1167  	/* Per channel trimmers. */
9b9d8632f51f360 Joseph Lo      2019-05-29  1168  	emc_dbg(emc, SUB_STEPS, "Writing trim_regs_per_ch\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1169  
9b9d8632f51f360 Joseph Lo      2019-05-29  1170  	for (i = 0; i < next->num_trim_per_ch; i++) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1171  		const struct tegra210_emc_per_channel_regs *trim =
9b9d8632f51f360 Joseph Lo      2019-05-29  1172  				&emc->offsets->trim_per_channel[0];
9b9d8632f51f360 Joseph Lo      2019-05-29  1173  		unsigned int offset;
9b9d8632f51f360 Joseph Lo      2019-05-29  1174  
9b9d8632f51f360 Joseph Lo      2019-05-29  1175  		if (!trim[i].offset)
9b9d8632f51f360 Joseph Lo      2019-05-29  1176  			continue;
9b9d8632f51f360 Joseph Lo      2019-05-29  1177  
9b9d8632f51f360 Joseph Lo      2019-05-29  1178  		if (emc->num_channels < 2 && trim[i].bank >= 1)
9b9d8632f51f360 Joseph Lo      2019-05-29  1179  			continue;
9b9d8632f51f360 Joseph Lo      2019-05-29  1180  
9b9d8632f51f360 Joseph Lo      2019-05-29  1181  		offset = trim[i].offset;
9b9d8632f51f360 Joseph Lo      2019-05-29  1182  
9b9d8632f51f360 Joseph Lo      2019-05-29  1183  		if (compensate_trimmer_applicable &&
9b9d8632f51f360 Joseph Lo      2019-05-29  1184  		    (offset == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK0_0 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1185  		     offset == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK0_1 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1186  		     offset == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK0_2 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1187  		     offset == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK0_3 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1188  		     offset == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK1_0 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1189  		     offset == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK1_1 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1190  		     offset == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK1_2 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1191  		     offset == EMC_PMACRO_OB_DDLL_LONG_DQ_RANK1_3 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1192  		     offset == EMC_DATA_BRLSHFT_0 ||
9b9d8632f51f360 Joseph Lo      2019-05-29  1193  		     offset == EMC_DATA_BRLSHFT_1)) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1194  			value = tegra210_emc_compensate(next, offset);
9b9d8632f51f360 Joseph Lo      2019-05-29  1195  			emc_dbg(emc, REG_LISTS, "(%u) 0x%08x => 0x%08x\n", i,
9b9d8632f51f360 Joseph Lo      2019-05-29  1196  				value, offset);
9b9d8632f51f360 Joseph Lo      2019-05-29  1197  			emc_dbg(emc, EMA_WRITES, "0x%08x <= 0x%08x\n", offset,
9b9d8632f51f360 Joseph Lo      2019-05-29  1198  				value);
9b9d8632f51f360 Joseph Lo      2019-05-29  1199  			emc_channel_writel(emc, trim[i].bank, value, offset);
9b9d8632f51f360 Joseph Lo      2019-05-29  1200  		} else {
9b9d8632f51f360 Joseph Lo      2019-05-29  1201  			emc_dbg(emc, REG_LISTS, "(%u) 0x%08x => 0x%08x\n", i,
9b9d8632f51f360 Joseph Lo      2019-05-29  1202  				next->trim_perch_regs[i], offset);
9b9d8632f51f360 Joseph Lo      2019-05-29  1203  			emc_channel_writel(emc, trim[i].bank,
9b9d8632f51f360 Joseph Lo      2019-05-29  1204  					   next->trim_perch_regs[i], offset);
9b9d8632f51f360 Joseph Lo      2019-05-29  1205  		}
9b9d8632f51f360 Joseph Lo      2019-05-29  1206  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1207  
9b9d8632f51f360 Joseph Lo      2019-05-29  1208  	emc_dbg(emc, SUB_STEPS, "Writing burst_mc_regs\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1209  
9b9d8632f51f360 Joseph Lo      2019-05-29  1210  	for (i = 0; i < next->num_mc_regs; i++) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1211  		const u16 *offsets = emc->offsets->burst_mc;
9b9d8632f51f360 Joseph Lo      2019-05-29  1212  		u32 *values = next->burst_mc_regs;
9b9d8632f51f360 Joseph Lo      2019-05-29  1213  
9b9d8632f51f360 Joseph Lo      2019-05-29  1214  		emc_dbg(emc, REG_LISTS, "(%u) 0x%08x => 0x%08x\n", i,
9b9d8632f51f360 Joseph Lo      2019-05-29  1215  			values[i], offsets[i]);
9b9d8632f51f360 Joseph Lo      2019-05-29  1216  		mc_writel(emc->mc, values[i], offsets[i]);
9b9d8632f51f360 Joseph Lo      2019-05-29  1217  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1218  
9b9d8632f51f360 Joseph Lo      2019-05-29  1219  	/* Registers to be programmed on the faster clock. */
9b9d8632f51f360 Joseph Lo      2019-05-29  1220  	if (next->rate < last->rate) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1221  		const u16 *la = emc->offsets->la_scale;
9b9d8632f51f360 Joseph Lo      2019-05-29  1222  
9b9d8632f51f360 Joseph Lo      2019-05-29  1223  		emc_dbg(emc, SUB_STEPS, "Writing la_scale_regs\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1224  
9b9d8632f51f360 Joseph Lo      2019-05-29  1225  		for (i = 0; i < next->num_up_down; i++) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1226  			emc_dbg(emc, REG_LISTS, "(%u) 0x%08x => 0x%08x\n", i,
9b9d8632f51f360 Joseph Lo      2019-05-29  1227  				next->la_scale_regs[i], la[i]);
9b9d8632f51f360 Joseph Lo      2019-05-29  1228  			mc_writel(emc->mc, next->la_scale_regs[i], la[i]);
9b9d8632f51f360 Joseph Lo      2019-05-29  1229  		}
9b9d8632f51f360 Joseph Lo      2019-05-29  1230  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1231  
9b9d8632f51f360 Joseph Lo      2019-05-29  1232  	/* Flush all the burst register writes. */
9b9d8632f51f360 Joseph Lo      2019-05-29  1233  	mc_readl(emc->mc, MC_EMEM_ADR_CFG);
9b9d8632f51f360 Joseph Lo      2019-05-29  1234  
9b9d8632f51f360 Joseph Lo      2019-05-29  1235  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1236  	 * Step 9:
9b9d8632f51f360 Joseph Lo      2019-05-29  1237  	 *   LPDDR4 section A.
9b9d8632f51f360 Joseph Lo      2019-05-29  1238  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1239  	emc_dbg(emc, STEPS, "Step 9\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1240  
9b9d8632f51f360 Joseph Lo      2019-05-29  1241  	value = next->burst_regs[EMC_ZCAL_WAIT_CNT_INDEX];
9b9d8632f51f360 Joseph Lo      2019-05-29  1242  	value &= ~EMC_ZCAL_WAIT_CNT_ZCAL_WAIT_CNT_MASK;
9b9d8632f51f360 Joseph Lo      2019-05-29  1243  
9b9d8632f51f360 Joseph Lo      2019-05-29  1244  	if (dram_type == DRAM_TYPE_LPDDR4) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1245  		emc_writel(emc, 0, EMC_ZCAL_INTERVAL);
9b9d8632f51f360 Joseph Lo      2019-05-29  1246  		emc_writel(emc, value, EMC_ZCAL_WAIT_CNT);
9b9d8632f51f360 Joseph Lo      2019-05-29  1247  
9b9d8632f51f360 Joseph Lo      2019-05-29  1248  		value = emc_dbg | (EMC_DBG_WRITE_MUX_ACTIVE |
9b9d8632f51f360 Joseph Lo      2019-05-29  1249  				   EMC_DBG_WRITE_ACTIVE_ONLY);
9b9d8632f51f360 Joseph Lo      2019-05-29  1250  
9b9d8632f51f360 Joseph Lo      2019-05-29  1251  		emc_writel(emc, value, EMC_DBG);
9b9d8632f51f360 Joseph Lo      2019-05-29  1252  		emc_writel(emc, 0, EMC_ZCAL_INTERVAL);
9b9d8632f51f360 Joseph Lo      2019-05-29  1253  		emc_writel(emc, emc_dbg, EMC_DBG);
9b9d8632f51f360 Joseph Lo      2019-05-29  1254  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1255  
9b9d8632f51f360 Joseph Lo      2019-05-29  1256  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1257  	 * Step 10:
9b9d8632f51f360 Joseph Lo      2019-05-29  1258  	 *   LPDDR4 and DDR3 common section.
9b9d8632f51f360 Joseph Lo      2019-05-29  1259  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1260  	emc_dbg(emc, STEPS, "Step 10\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1261  
9b9d8632f51f360 Joseph Lo      2019-05-29  1262  	if (opt_dvfs_mode == MAN_SR || dram_type == DRAM_TYPE_LPDDR4) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1263  		if (dram_type == DRAM_TYPE_LPDDR4)
9b9d8632f51f360 Joseph Lo      2019-05-29  1264  			ccfifo_writel(emc, 0x101, EMC_SELF_REF, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1265  		else
9b9d8632f51f360 Joseph Lo      2019-05-29  1266  			ccfifo_writel(emc, 0x1, EMC_SELF_REF, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1267  
9b9d8632f51f360 Joseph Lo      2019-05-29  1268  		if (dram_type == DRAM_TYPE_LPDDR4 &&
9b9d8632f51f360 Joseph Lo      2019-05-29  1269  		    dst_clk_period <= zqcal_before_cc_cutoff) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1270  			ccfifo_writel(emc, mr13_flip_fspwr ^ 0x40, EMC_MRW3, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1271  			ccfifo_writel(emc, (next->burst_regs[EMC_MRW6_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29  1272  						0xFFFF3F3F) |
9b9d8632f51f360 Joseph Lo      2019-05-29  1273  					   (last->burst_regs[EMC_MRW6_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29  1274  						0x0000C0C0), EMC_MRW6, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1275  			ccfifo_writel(emc, (next->burst_regs[EMC_MRW14_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29  1276  						0xFFFF0707) |
9b9d8632f51f360 Joseph Lo      2019-05-29  1277  					   (last->burst_regs[EMC_MRW14_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29  1278  						0x00003838), EMC_MRW14, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1279  
9b9d8632f51f360 Joseph Lo      2019-05-29  1280  			if (emc->num_devices > 1) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1281  				ccfifo_writel(emc,
9b9d8632f51f360 Joseph Lo      2019-05-29  1282  				      (next->burst_regs[EMC_MRW7_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29  1283  				       0xFFFF3F3F) |
9b9d8632f51f360 Joseph Lo      2019-05-29  1284  				      (last->burst_regs[EMC_MRW7_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29  1285  				       0x0000C0C0), EMC_MRW7, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1286  				ccfifo_writel(emc,
9b9d8632f51f360 Joseph Lo      2019-05-29  1287  				     (next->burst_regs[EMC_MRW15_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29  1288  				      0xFFFF0707) |
9b9d8632f51f360 Joseph Lo      2019-05-29  1289  				     (last->burst_regs[EMC_MRW15_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29  1290  				      0x00003838), EMC_MRW15, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1291  			}
9b9d8632f51f360 Joseph Lo      2019-05-29  1292  
9b9d8632f51f360 Joseph Lo      2019-05-29  1293  			if (opt_zcal_en_cc) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1294  				if (emc->num_devices < 2)
9b9d8632f51f360 Joseph Lo      2019-05-29  1295  					ccfifo_writel(emc,
9b9d8632f51f360 Joseph Lo      2019-05-29  1296  						2UL << EMC_ZQ_CAL_DEV_SEL_SHIFT
9b9d8632f51f360 Joseph Lo      2019-05-29  1297  						| EMC_ZQ_CAL_ZQ_CAL_CMD,
9b9d8632f51f360 Joseph Lo      2019-05-29  1298  						EMC_ZQ_CAL, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1299  				else if (shared_zq_resistor)
9b9d8632f51f360 Joseph Lo      2019-05-29  1300  					ccfifo_writel(emc,
9b9d8632f51f360 Joseph Lo      2019-05-29  1301  						2UL << EMC_ZQ_CAL_DEV_SEL_SHIFT
9b9d8632f51f360 Joseph Lo      2019-05-29  1302  						| EMC_ZQ_CAL_ZQ_CAL_CMD,
9b9d8632f51f360 Joseph Lo      2019-05-29  1303  						EMC_ZQ_CAL, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1304  				else
9b9d8632f51f360 Joseph Lo      2019-05-29  1305  					ccfifo_writel(emc,
9b9d8632f51f360 Joseph Lo      2019-05-29  1306  						      EMC_ZQ_CAL_ZQ_CAL_CMD,
9b9d8632f51f360 Joseph Lo      2019-05-29  1307  						      EMC_ZQ_CAL, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1308  			}
9b9d8632f51f360 Joseph Lo      2019-05-29  1309  		}
9b9d8632f51f360 Joseph Lo      2019-05-29  1310  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1311  
9b9d8632f51f360 Joseph Lo      2019-05-29  1312  	if (dram_type == DRAM_TYPE_LPDDR4) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1313  		value = (1000 * fake->dram_timings[T_RP]) / src_clk_period;
9b9d8632f51f360 Joseph Lo      2019-05-29  1314  		ccfifo_writel(emc, mr13_flip_fspop | 0x8, EMC_MRW3, value);
9b9d8632f51f360 Joseph Lo      2019-05-29  1315  		ccfifo_writel(emc, 0, 0, tFC_lpddr4 / src_clk_period);
9b9d8632f51f360 Joseph Lo      2019-05-29  1316  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1317  
9b9d8632f51f360 Joseph Lo      2019-05-29  1318  	if (dram_type == DRAM_TYPE_LPDDR4 || opt_dvfs_mode != MAN_SR) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1319  		delay = 30;
9b9d8632f51f360 Joseph Lo      2019-05-29  1320  
9b9d8632f51f360 Joseph Lo      2019-05-29  1321  		if (cya_allow_ref_cc) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1322  			delay += (1000 * fake->dram_timings[T_RP]) /
9b9d8632f51f360 Joseph Lo      2019-05-29  1323  					src_clk_period;
9b9d8632f51f360 Joseph Lo      2019-05-29  1324  			delay += 4000 * fake->dram_timings[T_RFC];
9b9d8632f51f360 Joseph Lo      2019-05-29  1325  		}
9b9d8632f51f360 Joseph Lo      2019-05-29  1326  
9b9d8632f51f360 Joseph Lo      2019-05-29  1327  		ccfifo_writel(emc, emc_pin & ~(EMC_PIN_PIN_CKE_PER_DEV |
9b9d8632f51f360 Joseph Lo      2019-05-29  1328  					       EMC_PIN_PIN_CKEB |
9b9d8632f51f360 Joseph Lo      2019-05-29  1329  					       EMC_PIN_PIN_CKE),
9b9d8632f51f360 Joseph Lo      2019-05-29  1330  			      EMC_PIN, delay);
9b9d8632f51f360 Joseph Lo      2019-05-29  1331  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1332  
9b9d8632f51f360 Joseph Lo      2019-05-29  1333  	/* calculate reference delay multiplier */
9b9d8632f51f360 Joseph Lo      2019-05-29  1334  	value = 1;
9b9d8632f51f360 Joseph Lo      2019-05-29  1335  
9b9d8632f51f360 Joseph Lo      2019-05-29  1336  	if (ref_b4_sref_en)
9b9d8632f51f360 Joseph Lo      2019-05-29  1337  		value++;
9b9d8632f51f360 Joseph Lo      2019-05-29  1338  
9b9d8632f51f360 Joseph Lo      2019-05-29  1339  	if (cya_allow_ref_cc)
9b9d8632f51f360 Joseph Lo      2019-05-29  1340  		value++;
9b9d8632f51f360 Joseph Lo      2019-05-29  1341  
9b9d8632f51f360 Joseph Lo      2019-05-29  1342  	if (cya_issue_pc_ref)
9b9d8632f51f360 Joseph Lo      2019-05-29  1343  		value++;
9b9d8632f51f360 Joseph Lo      2019-05-29  1344  
9b9d8632f51f360 Joseph Lo      2019-05-29  1345  	if (dram_type != DRAM_TYPE_LPDDR4) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1346  		delay = ((1000 * fake->dram_timings[T_RP] / src_clk_period) +
9b9d8632f51f360 Joseph Lo      2019-05-29  1347  			 (1000 * fake->dram_timings[T_RFC] / src_clk_period));
9b9d8632f51f360 Joseph Lo      2019-05-29  1348  		delay = value * delay + 20;
9b9d8632f51f360 Joseph Lo      2019-05-29  1349  	} else {
9b9d8632f51f360 Joseph Lo      2019-05-29  1350  		delay = 0;
9b9d8632f51f360 Joseph Lo      2019-05-29  1351  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1352  
9b9d8632f51f360 Joseph Lo      2019-05-29  1353  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1354  	 * Step 11:
9b9d8632f51f360 Joseph Lo      2019-05-29  1355  	 *   Ramp down.
9b9d8632f51f360 Joseph Lo      2019-05-29  1356  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1357  	emc_dbg(emc, STEPS, "Step 11\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1358  
9b9d8632f51f360 Joseph Lo      2019-05-29  1359  	ccfifo_writel(emc, 0x0, EMC_CFG_SYNC, delay);
9b9d8632f51f360 Joseph Lo      2019-05-29  1360  
9b9d8632f51f360 Joseph Lo      2019-05-29  1361  	value = emc_dbg | EMC_DBG_WRITE_MUX_ACTIVE | EMC_DBG_WRITE_ACTIVE_ONLY;
9b9d8632f51f360 Joseph Lo      2019-05-29  1362  	ccfifo_writel(emc, value, EMC_DBG, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1363  
9b9d8632f51f360 Joseph Lo      2019-05-29  1364  	ramp_down_wait = tegra210_emc_dvfs_power_ramp_down(emc, src_clk_period,
9b9d8632f51f360 Joseph Lo      2019-05-29  1365  							   0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1366  
9b9d8632f51f360 Joseph Lo      2019-05-29  1367  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1368  	 * Step 12:
9b9d8632f51f360 Joseph Lo      2019-05-29  1369  	 *   And finally - trigger the clock change.
9b9d8632f51f360 Joseph Lo      2019-05-29  1370  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1371  	emc_dbg(emc, STEPS, "Step 12\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1372  
9b9d8632f51f360 Joseph Lo      2019-05-29  1373  	ccfifo_writel(emc, 1, EMC_STALL_THEN_EXE_AFTER_CLKCHANGE, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1374  	value &= ~EMC_DBG_WRITE_ACTIVE_ONLY;
9b9d8632f51f360 Joseph Lo      2019-05-29  1375  	ccfifo_writel(emc, value, EMC_DBG, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1376  
9b9d8632f51f360 Joseph Lo      2019-05-29  1377  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1378  	 * Step 13:
9b9d8632f51f360 Joseph Lo      2019-05-29  1379  	 *   Ramp up.
9b9d8632f51f360 Joseph Lo      2019-05-29  1380  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1381  	emc_dbg(emc, STEPS, "Step 13\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1382  
9b9d8632f51f360 Joseph Lo      2019-05-29  1383  	ramp_up_wait = tegra210_emc_dvfs_power_ramp_up(emc, dst_clk_period, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1384  	ccfifo_writel(emc, emc_dbg, EMC_DBG, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1385  
9b9d8632f51f360 Joseph Lo      2019-05-29  1386  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1387  	 * Step 14:
9b9d8632f51f360 Joseph Lo      2019-05-29  1388  	 *   Bringup CKE pins.
9b9d8632f51f360 Joseph Lo      2019-05-29  1389  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1390  	emc_dbg(emc, STEPS, "Step 14\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1391  
9b9d8632f51f360 Joseph Lo      2019-05-29  1392  	if (dram_type == DRAM_TYPE_LPDDR4) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1393  		value = emc_pin | EMC_PIN_PIN_CKE;
9b9d8632f51f360 Joseph Lo      2019-05-29  1394  
9b9d8632f51f360 Joseph Lo      2019-05-29  1395  		if (emc->num_devices <= 1)
9b9d8632f51f360 Joseph Lo      2019-05-29  1396  			value &= ~(EMC_PIN_PIN_CKEB | EMC_PIN_PIN_CKE_PER_DEV);
9b9d8632f51f360 Joseph Lo      2019-05-29  1397  		else
9b9d8632f51f360 Joseph Lo      2019-05-29  1398  			value |= EMC_PIN_PIN_CKEB | EMC_PIN_PIN_CKE_PER_DEV;
9b9d8632f51f360 Joseph Lo      2019-05-29  1399  
9b9d8632f51f360 Joseph Lo      2019-05-29  1400  		ccfifo_writel(emc, value, EMC_PIN, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1401  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1402  
9b9d8632f51f360 Joseph Lo      2019-05-29  1403  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1404  	 * Step 15: (two step 15s ??)
9b9d8632f51f360 Joseph Lo      2019-05-29  1405  	 *   Calculate zqlatch wait time; has dependency on ramping times.
9b9d8632f51f360 Joseph Lo      2019-05-29  1406  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1407  	emc_dbg(emc, STEPS, "Step 15\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1408  
9b9d8632f51f360 Joseph Lo      2019-05-29  1409  	if (dst_clk_period <= zqcal_before_cc_cutoff) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1410  		s32 t = (s32)(ramp_up_wait + ramp_down_wait) /
9b9d8632f51f360 Joseph Lo      2019-05-29  1411  			(s32)dst_clk_period;
9b9d8632f51f360 Joseph Lo      2019-05-29  1412  		zq_latch_dvfs_wait_time = (s32)tZQCAL_lpddr4_fc_adj - t;
9b9d8632f51f360 Joseph Lo      2019-05-29  1413  	} else {
9b9d8632f51f360 Joseph Lo      2019-05-29  1414  		zq_latch_dvfs_wait_time = tZQCAL_lpddr4_fc_adj -
9b9d8632f51f360 Joseph Lo      2019-05-29  1415  			div_o3(1000 * next->dram_timings[T_PDEX],
9b9d8632f51f360 Joseph Lo      2019-05-29  1416  			       dst_clk_period);
9b9d8632f51f360 Joseph Lo      2019-05-29  1417  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1418  
9b9d8632f51f360 Joseph Lo      2019-05-29  1419  	emc_dbg(emc, INFO, "tZQCAL_lpddr4_fc_adj = %u\n", tZQCAL_lpddr4_fc_adj);
9b9d8632f51f360 Joseph Lo      2019-05-29  1420  	emc_dbg(emc, INFO, "dst_clk_period = %u\n",
9b9d8632f51f360 Joseph Lo      2019-05-29  1421  		dst_clk_period);
9b9d8632f51f360 Joseph Lo      2019-05-29  1422  	emc_dbg(emc, INFO, "next->dram_timings[T_PDEX] = %u\n",
9b9d8632f51f360 Joseph Lo      2019-05-29  1423  		next->dram_timings[T_PDEX]);
9b9d8632f51f360 Joseph Lo      2019-05-29  1424  	emc_dbg(emc, INFO, "zq_latch_dvfs_wait_time = %d\n",
9b9d8632f51f360 Joseph Lo      2019-05-29  1425  		max_t(s32, 0, zq_latch_dvfs_wait_time));
9b9d8632f51f360 Joseph Lo      2019-05-29  1426  
9b9d8632f51f360 Joseph Lo      2019-05-29  1427  	if (dram_type == DRAM_TYPE_LPDDR4 && opt_zcal_en_cc) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1428  		delay = div_o3(1000 * next->dram_timings[T_PDEX],
9b9d8632f51f360 Joseph Lo      2019-05-29  1429  			       dst_clk_period);
9b9d8632f51f360 Joseph Lo      2019-05-29  1430  
9b9d8632f51f360 Joseph Lo      2019-05-29  1431  		if (emc->num_devices < 2) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1432  			if (dst_clk_period > zqcal_before_cc_cutoff)
9b9d8632f51f360 Joseph Lo      2019-05-29  1433  				ccfifo_writel(emc,
9b9d8632f51f360 Joseph Lo      2019-05-29  1434  					      2UL << EMC_ZQ_CAL_DEV_SEL_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1435  					      EMC_ZQ_CAL_ZQ_CAL_CMD, EMC_ZQ_CAL,
9b9d8632f51f360 Joseph Lo      2019-05-29  1436  					      delay);
9b9d8632f51f360 Joseph Lo      2019-05-29  1437  
9b9d8632f51f360 Joseph Lo      2019-05-29  1438  			value = (mr13_flip_fspop & 0xfffffff7) | 0x0c000000;
9b9d8632f51f360 Joseph Lo      2019-05-29  1439  			ccfifo_writel(emc, value, EMC_MRW3, delay);
9b9d8632f51f360 Joseph Lo      2019-05-29  1440  			ccfifo_writel(emc, 0, EMC_SELF_REF, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1441  			ccfifo_writel(emc, 0, EMC_REF, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1442  			ccfifo_writel(emc, 2UL << EMC_ZQ_CAL_DEV_SEL_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1443  				      EMC_ZQ_CAL_ZQ_LATCH_CMD,
9b9d8632f51f360 Joseph Lo      2019-05-29  1444  				      EMC_ZQ_CAL,
9b9d8632f51f360 Joseph Lo      2019-05-29  1445  				      max_t(s32, 0, zq_latch_dvfs_wait_time));
9b9d8632f51f360 Joseph Lo      2019-05-29  1446  		} else if (shared_zq_resistor) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1447  			if (dst_clk_period > zqcal_before_cc_cutoff)
9b9d8632f51f360 Joseph Lo      2019-05-29  1448  				ccfifo_writel(emc,
9b9d8632f51f360 Joseph Lo      2019-05-29  1449  					      2UL << EMC_ZQ_CAL_DEV_SEL_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1450  					      EMC_ZQ_CAL_ZQ_CAL_CMD, EMC_ZQ_CAL,
9b9d8632f51f360 Joseph Lo      2019-05-29  1451  					      delay);
9b9d8632f51f360 Joseph Lo      2019-05-29  1452  
9b9d8632f51f360 Joseph Lo      2019-05-29  1453  			ccfifo_writel(emc, 2UL << EMC_ZQ_CAL_DEV_SEL_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1454  				      EMC_ZQ_CAL_ZQ_LATCH_CMD, EMC_ZQ_CAL,
9b9d8632f51f360 Joseph Lo      2019-05-29  1455  				      max_t(s32, 0, zq_latch_dvfs_wait_time) +
9b9d8632f51f360 Joseph Lo      2019-05-29  1456  					delay);
9b9d8632f51f360 Joseph Lo      2019-05-29  1457  			ccfifo_writel(emc, 1UL << EMC_ZQ_CAL_DEV_SEL_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1458  				      EMC_ZQ_CAL_ZQ_LATCH_CMD,
9b9d8632f51f360 Joseph Lo      2019-05-29  1459  				      EMC_ZQ_CAL, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1460  
9b9d8632f51f360 Joseph Lo      2019-05-29  1461  			value = (mr13_flip_fspop & 0xfffffff7) | 0x0c000000;
9b9d8632f51f360 Joseph Lo      2019-05-29  1462  			ccfifo_writel(emc, value, EMC_MRW3, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1463  			ccfifo_writel(emc, 0, EMC_SELF_REF, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1464  			ccfifo_writel(emc, 0, EMC_REF, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1465  
9b9d8632f51f360 Joseph Lo      2019-05-29  1466  			ccfifo_writel(emc, 1UL << EMC_ZQ_CAL_DEV_SEL_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1467  				      EMC_ZQ_CAL_ZQ_LATCH_CMD, EMC_ZQ_CAL,
9b9d8632f51f360 Joseph Lo      2019-05-29  1468  				      tZQCAL_lpddr4 / dst_clk_period);
9b9d8632f51f360 Joseph Lo      2019-05-29  1469  		} else {
9b9d8632f51f360 Joseph Lo      2019-05-29  1470  			if (dst_clk_period > zqcal_before_cc_cutoff)
9b9d8632f51f360 Joseph Lo      2019-05-29  1471  				ccfifo_writel(emc, EMC_ZQ_CAL_ZQ_CAL_CMD,
9b9d8632f51f360 Joseph Lo      2019-05-29  1472  					      EMC_ZQ_CAL, delay);
9b9d8632f51f360 Joseph Lo      2019-05-29  1473  
9b9d8632f51f360 Joseph Lo      2019-05-29  1474  			value = (mr13_flip_fspop & 0xfffffff7) | 0x0c000000;
9b9d8632f51f360 Joseph Lo      2019-05-29  1475  			ccfifo_writel(emc, value, EMC_MRW3, delay);
9b9d8632f51f360 Joseph Lo      2019-05-29  1476  			ccfifo_writel(emc, 0, EMC_SELF_REF, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1477  			ccfifo_writel(emc, 0, EMC_REF, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1478  
9b9d8632f51f360 Joseph Lo      2019-05-29  1479  			ccfifo_writel(emc, EMC_ZQ_CAL_ZQ_LATCH_CMD, EMC_ZQ_CAL,
9b9d8632f51f360 Joseph Lo      2019-05-29  1480  				      max_t(s32, 0, zq_latch_dvfs_wait_time));
9b9d8632f51f360 Joseph Lo      2019-05-29  1481  		}
9b9d8632f51f360 Joseph Lo      2019-05-29  1482  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1483  
9b9d8632f51f360 Joseph Lo      2019-05-29  1484  	/* WAR: delay for zqlatch */
9b9d8632f51f360 Joseph Lo      2019-05-29  1485  	ccfifo_writel(emc, 0, 0, 10);
9b9d8632f51f360 Joseph Lo      2019-05-29  1486  
9b9d8632f51f360 Joseph Lo      2019-05-29  1487  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1488  	 * Step 16:
9b9d8632f51f360 Joseph Lo      2019-05-29  1489  	 *   LPDDR4 Conditional Training Kickoff. Removed.
9b9d8632f51f360 Joseph Lo      2019-05-29  1490  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1491  
9b9d8632f51f360 Joseph Lo      2019-05-29  1492  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1493  	 * Step 17:
9b9d8632f51f360 Joseph Lo      2019-05-29  1494  	 *   MANSR exit self refresh.
9b9d8632f51f360 Joseph Lo      2019-05-29  1495  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1496  	emc_dbg(emc, STEPS, "Step 17\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1497  
9b9d8632f51f360 Joseph Lo      2019-05-29  1498  	if (opt_dvfs_mode == MAN_SR && dram_type != DRAM_TYPE_LPDDR4)
9b9d8632f51f360 Joseph Lo      2019-05-29  1499  		ccfifo_writel(emc, 0, EMC_SELF_REF, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1500  
9b9d8632f51f360 Joseph Lo      2019-05-29  1501  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1502  	 * Step 18:
9b9d8632f51f360 Joseph Lo      2019-05-29  1503  	 *   Send MRWs to LPDDR3/DDR3.
9b9d8632f51f360 Joseph Lo      2019-05-29  1504  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1505  	emc_dbg(emc, STEPS, "Step 18\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1506  
9b9d8632f51f360 Joseph Lo      2019-05-29  1507  	if (dram_type == DRAM_TYPE_LPDDR2) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1508  		ccfifo_writel(emc, next->emc_mrw2, EMC_MRW2, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1509  		ccfifo_writel(emc, next->emc_mrw,  EMC_MRW,  0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1510  		if (is_lpddr3)
9b9d8632f51f360 Joseph Lo      2019-05-29  1511  			ccfifo_writel(emc, next->emc_mrw4, EMC_MRW4, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1512  	} else if (dram_type == DRAM_TYPE_DDR3) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1513  		if (opt_dll_mode)
9b9d8632f51f360 Joseph Lo      2019-05-29  1514  			ccfifo_writel(emc, next->emc_emrs &
9b9d8632f51f360 Joseph Lo      2019-05-29  1515  				      ~EMC_EMRS_USE_EMRS_LONG_CNT, EMC_EMRS, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1516  		ccfifo_writel(emc, next->emc_emrs2 &
9b9d8632f51f360 Joseph Lo      2019-05-29  1517  			      ~EMC_EMRS2_USE_EMRS2_LONG_CNT, EMC_EMRS2, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1518  		ccfifo_writel(emc, next->emc_mrs |
9b9d8632f51f360 Joseph Lo      2019-05-29  1519  			      EMC_EMRS_USE_EMRS_LONG_CNT, EMC_MRS, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1520  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1521  
9b9d8632f51f360 Joseph Lo      2019-05-29  1522  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1523  	 * Step 19:
9b9d8632f51f360 Joseph Lo      2019-05-29  1524  	 *   ZQCAL for LPDDR3/DDR3
9b9d8632f51f360 Joseph Lo      2019-05-29  1525  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1526  	emc_dbg(emc, STEPS, "Step 19\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1527  
9b9d8632f51f360 Joseph Lo      2019-05-29  1528  	if (opt_zcal_en_cc) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1529  		if (dram_type == DRAM_TYPE_LPDDR2) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1530  			value = opt_cc_short_zcal ? 90000 : 360000;
9b9d8632f51f360 Joseph Lo      2019-05-29  1531  			value = div_o3(value, dst_clk_period);
9b9d8632f51f360 Joseph Lo      2019-05-29  1532  			value = value <<
9b9d8632f51f360 Joseph Lo      2019-05-29  1533  				EMC_MRS_WAIT_CNT2_MRS_EXT2_WAIT_CNT_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1534  				value <<
9b9d8632f51f360 Joseph Lo      2019-05-29  1535  				EMC_MRS_WAIT_CNT2_MRS_EXT1_WAIT_CNT_SHIFT;
9b9d8632f51f360 Joseph Lo      2019-05-29  1536  			ccfifo_writel(emc, value, EMC_MRS_WAIT_CNT2, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1537  
9b9d8632f51f360 Joseph Lo      2019-05-29  1538  			value = opt_cc_short_zcal ? 0x56 : 0xab;
9b9d8632f51f360 Joseph Lo      2019-05-29  1539  			ccfifo_writel(emc, 2 << EMC_MRW_MRW_DEV_SELECTN_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1540  					   EMC_MRW_USE_MRW_EXT_CNT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1541  					   10 << EMC_MRW_MRW_MA_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1542  					   value << EMC_MRW_MRW_OP_SHIFT,
9b9d8632f51f360 Joseph Lo      2019-05-29  1543  				      EMC_MRW, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1544  
9b9d8632f51f360 Joseph Lo      2019-05-29  1545  			if (emc->num_devices > 1) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1546  				value = 1 << EMC_MRW_MRW_DEV_SELECTN_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1547  					EMC_MRW_USE_MRW_EXT_CNT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1548  					10 << EMC_MRW_MRW_MA_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1549  					value << EMC_MRW_MRW_OP_SHIFT;
9b9d8632f51f360 Joseph Lo      2019-05-29  1550  				ccfifo_writel(emc, value, EMC_MRW, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1551  			}
9b9d8632f51f360 Joseph Lo      2019-05-29  1552  		} else if (dram_type == DRAM_TYPE_DDR3) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1553  			value = opt_cc_short_zcal ? 0 : EMC_ZQ_CAL_LONG;
9b9d8632f51f360 Joseph Lo      2019-05-29  1554  
9b9d8632f51f360 Joseph Lo      2019-05-29  1555  			ccfifo_writel(emc, value |
9b9d8632f51f360 Joseph Lo      2019-05-29  1556  					   2 << EMC_ZQ_CAL_DEV_SEL_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1557  					   EMC_ZQ_CAL_ZQ_CAL_CMD, EMC_ZQ_CAL,
9b9d8632f51f360 Joseph Lo      2019-05-29  1558  					   0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1559  
9b9d8632f51f360 Joseph Lo      2019-05-29  1560  			if (emc->num_devices > 1) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1561  				value = value | 1 << EMC_ZQ_CAL_DEV_SEL_SHIFT |
9b9d8632f51f360 Joseph Lo      2019-05-29  1562  						EMC_ZQ_CAL_ZQ_CAL_CMD;
9b9d8632f51f360 Joseph Lo      2019-05-29  1563  				ccfifo_writel(emc, value, EMC_ZQ_CAL, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1564  			}
9b9d8632f51f360 Joseph Lo      2019-05-29  1565  		}
9b9d8632f51f360 Joseph Lo      2019-05-29  1566  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1567  
9b9d8632f51f360 Joseph Lo      2019-05-29  1568  	if (bg_reg_mode_change) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1569  		tegra210_emc_set_shadow_bypass(emc, ACTIVE);
9b9d8632f51f360 Joseph Lo      2019-05-29  1570  
9b9d8632f51f360 Joseph Lo      2019-05-29  1571  		if (ramp_up_wait <= 1250000)
9b9d8632f51f360 Joseph Lo      2019-05-29  1572  			delay = (1250000 - ramp_up_wait) / dst_clk_period;
9b9d8632f51f360 Joseph Lo      2019-05-29  1573  		else
9b9d8632f51f360 Joseph Lo      2019-05-29  1574  			delay = 0;
9b9d8632f51f360 Joseph Lo      2019-05-29  1575  
9b9d8632f51f360 Joseph Lo      2019-05-29  1576  		ccfifo_writel(emc,
9b9d8632f51f360 Joseph Lo      2019-05-29  1577  			      next->burst_regs[EMC_PMACRO_BG_BIAS_CTRL_0_INDEX],
9b9d8632f51f360 Joseph Lo      2019-05-29  1578  			      EMC_PMACRO_BG_BIAS_CTRL_0, delay);
9b9d8632f51f360 Joseph Lo      2019-05-29  1579  		tegra210_emc_set_shadow_bypass(emc, ASSEMBLY);
9b9d8632f51f360 Joseph Lo      2019-05-29  1580  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1581  
9b9d8632f51f360 Joseph Lo      2019-05-29  1582  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1583  	 * Step 20:
9b9d8632f51f360 Joseph Lo      2019-05-29  1584  	 *   Issue ref and optional QRST.
9b9d8632f51f360 Joseph Lo      2019-05-29  1585  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1586  	emc_dbg(emc, STEPS, "Step 20\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1587  
9b9d8632f51f360 Joseph Lo      2019-05-29  1588  	if (dram_type != DRAM_TYPE_LPDDR4)
9b9d8632f51f360 Joseph Lo      2019-05-29  1589  		ccfifo_writel(emc, 0, EMC_REF, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1590  
9b9d8632f51f360 Joseph Lo      2019-05-29  1591  	if (opt_do_sw_qrst) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1592  		ccfifo_writel(emc, 1, EMC_ISSUE_QRST, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1593  		ccfifo_writel(emc, 0, EMC_ISSUE_QRST, 2);
9b9d8632f51f360 Joseph Lo      2019-05-29  1594  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1595  
9b9d8632f51f360 Joseph Lo      2019-05-29  1596  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1597  	 * Step 21:
9b9d8632f51f360 Joseph Lo      2019-05-29  1598  	 *   Restore ZCAL and ZCAL interval.
9b9d8632f51f360 Joseph Lo      2019-05-29  1599  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1600  	emc_dbg(emc, STEPS, "Step 21\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1601  
9b9d8632f51f360 Joseph Lo      2019-05-29  1602  	if (save_restore_clkstop_pd || opt_zcal_en_cc) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1603  		ccfifo_writel(emc, emc_dbg | EMC_DBG_WRITE_MUX_ACTIVE,
9b9d8632f51f360 Joseph Lo      2019-05-29  1604  			      EMC_DBG, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1605  		if (opt_zcal_en_cc && dram_type != DRAM_TYPE_LPDDR4)
9b9d8632f51f360 Joseph Lo      2019-05-29  1606  			ccfifo_writel(emc, next->burst_regs[EMC_ZCAL_INTERVAL_INDEX],
9b9d8632f51f360 Joseph Lo      2019-05-29  1607  				      EMC_ZCAL_INTERVAL, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1608  
9b9d8632f51f360 Joseph Lo      2019-05-29  1609  		if (save_restore_clkstop_pd)
9b9d8632f51f360 Joseph Lo      2019-05-29  1610  			ccfifo_writel(emc, next->burst_regs[EMC_CFG_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29  1611  						~EMC_CFG_DYN_SELF_REF,
9b9d8632f51f360 Joseph Lo      2019-05-29  1612  				      EMC_CFG, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1613  		ccfifo_writel(emc, emc_dbg, EMC_DBG, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1614  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1615  
9b9d8632f51f360 Joseph Lo      2019-05-29  1616  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1617  	 * Step 22:
9b9d8632f51f360 Joseph Lo      2019-05-29  1618  	 *   Restore EMC_CFG_PIPE_CLK.
9b9d8632f51f360 Joseph Lo      2019-05-29  1619  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1620  	emc_dbg(emc, STEPS, "Step 22\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1621  
9b9d8632f51f360 Joseph Lo      2019-05-29  1622  	ccfifo_writel(emc, emc_cfg_pipe_clk, EMC_CFG_PIPE_CLK, 0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1623  
9b9d8632f51f360 Joseph Lo      2019-05-29  1624  	if (bg_reg_mode_change) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1625  		if (enable_bg_reg)
9b9d8632f51f360 Joseph Lo      2019-05-29  1626  			emc_writel(emc,
9b9d8632f51f360 Joseph Lo      2019-05-29  1627  				   next->burst_regs[EMC_PMACRO_BG_BIAS_CTRL_0_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29  1628  					~EMC_PMACRO_BG_BIAS_CTRL_0_BGLP_E_PWRD,
9b9d8632f51f360 Joseph Lo      2019-05-29  1629  				   EMC_PMACRO_BG_BIAS_CTRL_0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1630  		else
9b9d8632f51f360 Joseph Lo      2019-05-29  1631  			emc_writel(emc,
9b9d8632f51f360 Joseph Lo      2019-05-29  1632  				   next->burst_regs[EMC_PMACRO_BG_BIAS_CTRL_0_INDEX] &
9b9d8632f51f360 Joseph Lo      2019-05-29  1633  					~EMC_PMACRO_BG_BIAS_CTRL_0_BG_E_PWRD,
9b9d8632f51f360 Joseph Lo      2019-05-29  1634  				   EMC_PMACRO_BG_BIAS_CTRL_0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1635  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1636  
9b9d8632f51f360 Joseph Lo      2019-05-29  1637  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1638  	 * Step 23:
9b9d8632f51f360 Joseph Lo      2019-05-29  1639  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1640  	emc_dbg(emc, STEPS, "Step 23\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1641  
9b9d8632f51f360 Joseph Lo      2019-05-29  1642  	value = emc_readl(emc, EMC_CFG_DIG_DLL);
9b9d8632f51f360 Joseph Lo      2019-05-29  1643  	value |= EMC_CFG_DIG_DLL_CFG_DLL_STALL_ALL_TRAFFIC;
9b9d8632f51f360 Joseph Lo      2019-05-29  1644  	value &= ~EMC_CFG_DIG_DLL_CFG_DLL_STALL_RW_UNTIL_LOCK;
9b9d8632f51f360 Joseph Lo      2019-05-29  1645  	value &= ~EMC_CFG_DIG_DLL_CFG_DLL_STALL_ALL_UNTIL_LOCK;
9b9d8632f51f360 Joseph Lo      2019-05-29  1646  	value &= ~EMC_CFG_DIG_DLL_CFG_DLL_EN;
9b9d8632f51f360 Joseph Lo      2019-05-29  1647  	value = (value & ~EMC_CFG_DIG_DLL_CFG_DLL_MODE_MASK) |
9b9d8632f51f360 Joseph Lo      2019-05-29  1648  		(2 << EMC_CFG_DIG_DLL_CFG_DLL_MODE_SHIFT);
9b9d8632f51f360 Joseph Lo      2019-05-29  1649  	emc_writel(emc, value, EMC_CFG_DIG_DLL);
9b9d8632f51f360 Joseph Lo      2019-05-29  1650  
9b9d8632f51f360 Joseph Lo      2019-05-29  1651  	tegra210_emc_do_clock_change(emc, clksrc);
9b9d8632f51f360 Joseph Lo      2019-05-29  1652  
9b9d8632f51f360 Joseph Lo      2019-05-29  1653  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1654  	 * Step 24:
9b9d8632f51f360 Joseph Lo      2019-05-29  1655  	 *   Save training results. Removed.
9b9d8632f51f360 Joseph Lo      2019-05-29  1656  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1657  
9b9d8632f51f360 Joseph Lo      2019-05-29  1658  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1659  	 * Step 25:
9b9d8632f51f360 Joseph Lo      2019-05-29  1660  	 *   Program MC updown registers.
9b9d8632f51f360 Joseph Lo      2019-05-29  1661  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1662  	emc_dbg(emc, STEPS, "Step 25\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1663  
9b9d8632f51f360 Joseph Lo      2019-05-29  1664  	if (next->rate > last->rate) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1665  		for (i = 0; i < next->num_up_down; i++)
9b9d8632f51f360 Joseph Lo      2019-05-29  1666  			mc_writel(emc->mc, next->la_scale_regs[i],
9b9d8632f51f360 Joseph Lo      2019-05-29  1667  				  emc->offsets->la_scale[i]);
9b9d8632f51f360 Joseph Lo      2019-05-29  1668  
9b9d8632f51f360 Joseph Lo      2019-05-29  1669  		tegra210_emc_timing_update(emc);
9b9d8632f51f360 Joseph Lo      2019-05-29  1670  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1671  
9b9d8632f51f360 Joseph Lo      2019-05-29  1672  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1673  	 * Step 26:
9b9d8632f51f360 Joseph Lo      2019-05-29  1674  	 *   Restore ZCAL registers.
9b9d8632f51f360 Joseph Lo      2019-05-29  1675  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1676  	emc_dbg(emc, STEPS, "Step 26\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1677  
9b9d8632f51f360 Joseph Lo      2019-05-29  1678  	if (dram_type == DRAM_TYPE_LPDDR4) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1679  		tegra210_emc_set_shadow_bypass(emc, ACTIVE);
9b9d8632f51f360 Joseph Lo      2019-05-29  1680  		emc_writel(emc, next->burst_regs[EMC_ZCAL_WAIT_CNT_INDEX],
9b9d8632f51f360 Joseph Lo      2019-05-29  1681  			   EMC_ZCAL_WAIT_CNT);
9b9d8632f51f360 Joseph Lo      2019-05-29  1682  		emc_writel(emc, next->burst_regs[EMC_ZCAL_INTERVAL_INDEX],
9b9d8632f51f360 Joseph Lo      2019-05-29  1683  			   EMC_ZCAL_INTERVAL);
9b9d8632f51f360 Joseph Lo      2019-05-29  1684  		tegra210_emc_set_shadow_bypass(emc, ASSEMBLY);
9b9d8632f51f360 Joseph Lo      2019-05-29  1685  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1686  
9b9d8632f51f360 Joseph Lo      2019-05-29  1687  	if (dram_type != DRAM_TYPE_LPDDR4 && opt_zcal_en_cc &&
9b9d8632f51f360 Joseph Lo      2019-05-29  1688  	    !opt_short_zcal && opt_cc_short_zcal) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1689  		udelay(2);
9b9d8632f51f360 Joseph Lo      2019-05-29  1690  
9b9d8632f51f360 Joseph Lo      2019-05-29  1691  		tegra210_emc_set_shadow_bypass(emc, ACTIVE);
9b9d8632f51f360 Joseph Lo      2019-05-29  1692  		if (dram_type == DRAM_TYPE_LPDDR2)
9b9d8632f51f360 Joseph Lo      2019-05-29  1693  			emc_writel(emc, next->burst_regs[EMC_MRS_WAIT_CNT_INDEX],
9b9d8632f51f360 Joseph Lo      2019-05-29  1694  				   EMC_MRS_WAIT_CNT);
9b9d8632f51f360 Joseph Lo      2019-05-29  1695  		else if (dram_type == DRAM_TYPE_DDR3)
9b9d8632f51f360 Joseph Lo      2019-05-29  1696  			emc_writel(emc, next->burst_regs[EMC_ZCAL_WAIT_CNT_INDEX],
9b9d8632f51f360 Joseph Lo      2019-05-29  1697  				   EMC_ZCAL_WAIT_CNT);
9b9d8632f51f360 Joseph Lo      2019-05-29  1698  		tegra210_emc_set_shadow_bypass(emc, ASSEMBLY);
9b9d8632f51f360 Joseph Lo      2019-05-29  1699  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1700  
9b9d8632f51f360 Joseph Lo      2019-05-29  1701  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1702  	 * Step 27:
9b9d8632f51f360 Joseph Lo      2019-05-29  1703  	 *   Restore EMC_CFG, FDPD registers.
9b9d8632f51f360 Joseph Lo      2019-05-29  1704  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1705  	emc_dbg(emc, STEPS, "Step 27\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1706  
9b9d8632f51f360 Joseph Lo      2019-05-29  1707  	tegra210_emc_set_shadow_bypass(emc, ACTIVE);
9b9d8632f51f360 Joseph Lo      2019-05-29  1708  	emc_writel(emc, next->burst_regs[EMC_CFG_INDEX], EMC_CFG);
9b9d8632f51f360 Joseph Lo      2019-05-29  1709  	tegra210_emc_set_shadow_bypass(emc, ASSEMBLY);
9b9d8632f51f360 Joseph Lo      2019-05-29  1710  	emc_writel(emc, next->emc_fdpd_ctrl_cmd_no_ramp,
9b9d8632f51f360 Joseph Lo      2019-05-29  1711  		   EMC_FDPD_CTRL_CMD_NO_RAMP);
9b9d8632f51f360 Joseph Lo      2019-05-29  1712  	emc_writel(emc, next->emc_sel_dpd_ctrl, EMC_SEL_DPD_CTRL);
9b9d8632f51f360 Joseph Lo      2019-05-29  1713  
9b9d8632f51f360 Joseph Lo      2019-05-29  1714  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1715  	 * Step 28:
9b9d8632f51f360 Joseph Lo      2019-05-29  1716  	 *   Training recover. Removed.
9b9d8632f51f360 Joseph Lo      2019-05-29  1717  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1718  	emc_dbg(emc, STEPS, "Step 28\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1719  
9b9d8632f51f360 Joseph Lo      2019-05-29  1720  	tegra210_emc_set_shadow_bypass(emc, ACTIVE);
9b9d8632f51f360 Joseph Lo      2019-05-29  1721  	emc_writel(emc,
9b9d8632f51f360 Joseph Lo      2019-05-29  1722  		   next->burst_regs[EMC_PMACRO_AUTOCAL_CFG_COMMON_INDEX],
9b9d8632f51f360 Joseph Lo      2019-05-29  1723  		   EMC_PMACRO_AUTOCAL_CFG_COMMON);
9b9d8632f51f360 Joseph Lo      2019-05-29  1724  	tegra210_emc_set_shadow_bypass(emc, ASSEMBLY);
9b9d8632f51f360 Joseph Lo      2019-05-29  1725  
9b9d8632f51f360 Joseph Lo      2019-05-29  1726  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1727  	 * Step 29:
9b9d8632f51f360 Joseph Lo      2019-05-29  1728  	 *   Power fix WAR.
9b9d8632f51f360 Joseph Lo      2019-05-29  1729  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1730  	emc_dbg(emc, STEPS, "Step 29\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1731  
9b9d8632f51f360 Joseph Lo      2019-05-29  1732  	emc_writel(emc, EMC_PMACRO_CFG_PM_GLOBAL_0_DISABLE_CFG_BYTE0 |
9b9d8632f51f360 Joseph Lo      2019-05-29  1733  		   EMC_PMACRO_CFG_PM_GLOBAL_0_DISABLE_CFG_BYTE1 |
9b9d8632f51f360 Joseph Lo      2019-05-29  1734  		   EMC_PMACRO_CFG_PM_GLOBAL_0_DISABLE_CFG_BYTE2 |
9b9d8632f51f360 Joseph Lo      2019-05-29  1735  		   EMC_PMACRO_CFG_PM_GLOBAL_0_DISABLE_CFG_BYTE3 |
9b9d8632f51f360 Joseph Lo      2019-05-29  1736  		   EMC_PMACRO_CFG_PM_GLOBAL_0_DISABLE_CFG_BYTE4 |
9b9d8632f51f360 Joseph Lo      2019-05-29  1737  		   EMC_PMACRO_CFG_PM_GLOBAL_0_DISABLE_CFG_BYTE5 |
9b9d8632f51f360 Joseph Lo      2019-05-29  1738  		   EMC_PMACRO_CFG_PM_GLOBAL_0_DISABLE_CFG_BYTE6 |
9b9d8632f51f360 Joseph Lo      2019-05-29  1739  		   EMC_PMACRO_CFG_PM_GLOBAL_0_DISABLE_CFG_BYTE7,
9b9d8632f51f360 Joseph Lo      2019-05-29  1740  		   EMC_PMACRO_CFG_PM_GLOBAL_0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1741  	emc_writel(emc, EMC_PMACRO_TRAINING_CTRL_0_CH0_TRAINING_E_WRPTR,
9b9d8632f51f360 Joseph Lo      2019-05-29  1742  		   EMC_PMACRO_TRAINING_CTRL_0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1743  	emc_writel(emc, EMC_PMACRO_TRAINING_CTRL_1_CH1_TRAINING_E_WRPTR,
9b9d8632f51f360 Joseph Lo      2019-05-29  1744  		   EMC_PMACRO_TRAINING_CTRL_1);
9b9d8632f51f360 Joseph Lo      2019-05-29  1745  	emc_writel(emc, 0, EMC_PMACRO_CFG_PM_GLOBAL_0);
9b9d8632f51f360 Joseph Lo      2019-05-29  1746  
9b9d8632f51f360 Joseph Lo      2019-05-29  1747  	/*
9b9d8632f51f360 Joseph Lo      2019-05-29  1748  	 * Step 30:
9b9d8632f51f360 Joseph Lo      2019-05-29  1749  	 *   Re-enable autocal.
9b9d8632f51f360 Joseph Lo      2019-05-29  1750  	 */
9b9d8632f51f360 Joseph Lo      2019-05-29  1751  	emc_dbg(emc, STEPS, "Step 30: Re-enable DLL and AUTOCAL\n");
9b9d8632f51f360 Joseph Lo      2019-05-29  1752  
9b9d8632f51f360 Joseph Lo      2019-05-29  1753  	if (next->burst_regs[EMC_CFG_DIG_DLL_INDEX] & EMC_CFG_DIG_DLL_CFG_DLL_EN) {
9b9d8632f51f360 Joseph Lo      2019-05-29  1754  		value = emc_readl(emc, EMC_CFG_DIG_DLL);
9b9d8632f51f360 Joseph Lo      2019-05-29  1755  		value |=  EMC_CFG_DIG_DLL_CFG_DLL_STALL_ALL_TRAFFIC;
9b9d8632f51f360 Joseph Lo      2019-05-29  1756  		value |=  EMC_CFG_DIG_DLL_CFG_DLL_EN;
9b9d8632f51f360 Joseph Lo      2019-05-29  1757  		value &= ~EMC_CFG_DIG_DLL_CFG_DLL_STALL_RW_UNTIL_LOCK;
9b9d8632f51f360 Joseph Lo      2019-05-29  1758  		value &= ~EMC_CFG_DIG_DLL_CFG_DLL_STALL_ALL_UNTIL_LOCK;
9b9d8632f51f360 Joseph Lo      2019-05-29  1759  		value = (value & ~EMC_CFG_DIG_DLL_CFG_DLL_MODE_MASK) |
9b9d8632f51f360 Joseph Lo      2019-05-29  1760  			(2 << EMC_CFG_DIG_DLL_CFG_DLL_MODE_SHIFT);
9b9d8632f51f360 Joseph Lo      2019-05-29  1761  		emc_writel(emc, value, EMC_CFG_DIG_DLL);
9b9d8632f51f360 Joseph Lo      2019-05-29  1762  		tegra210_emc_timing_update(emc);
9b9d8632f51f360 Joseph Lo      2019-05-29  1763  	}
9b9d8632f51f360 Joseph Lo      2019-05-29  1764  
9b9d8632f51f360 Joseph Lo      2019-05-29  1765  	emc_writel(emc, next->emc_auto_cal_config, EMC_AUTO_CAL_CONFIG);
9b9d8632f51f360 Joseph Lo      2019-05-29  1766  
9b9d8632f51f360 Joseph Lo      2019-05-29  1767  	/* Done! Yay. */
9b9d8632f51f360 Joseph Lo      2019-05-29  1768  }
9b9d8632f51f360 Joseph Lo      2019-05-29  1769  

:::::: The code at line 1035 was first introduced by commit
:::::: 9b9d8632f51f3609dfdfe8efc3c1e4e773c6c385 memory: tegra: Add EMC scaling sequence code for Tegra210

:::::: TO: Joseph Lo <josephl@nvidia.com>
:::::: CC: Thierry Reding <treding@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
