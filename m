Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC51393293
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 17:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234967AbhE0PnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 11:43:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41339 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233848AbhE0PnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 11:43:18 -0400
Received: from mail-ua1-f69.google.com ([209.85.222.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lmI8l-0000W8-Az
        for linux-kernel@vger.kernel.org; Thu, 27 May 2021 15:41:43 +0000
Received: by mail-ua1-f69.google.com with SMTP id d22-20020ab031960000b0290223019877e7so341525uan.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 08:41:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jzZmi07GQPLsVv4+1HVy+Qo3u1vFEO9AI38d92C+ce4=;
        b=DZnXo0RuENAN7iB/GL3tdxIJHc/BINFP6ogZKVFlP1awaz0fWMH+mlrv6vw6WZHp92
         E3tEIdGDsow83dS76JQf0XjwsaVawhReAYry3bQpjagZKUs3sEFIDk5zFALK/1evlgd1
         hWF30hE1hv6Y/SLJrTiEf+63aNKI27EA8S6mLAVCFWMmabf0LyME7mb01SolJoM5iOTn
         3Y33tbfYYmFV1lD+dBSig3NBbwbOKnqvoEi/8mgszAZhqO2PxZxg9ZJPHrs0KaMmqqDS
         EwCT5ytIswMvY/dmb0yXWVLYQUW/4HtAFClE0ixu6qJvFe1SaZ03ri3HqmCpM4Nin2OZ
         XvtQ==
X-Gm-Message-State: AOAM533SHPaL89EuRnLite1lCvEdHfTd9YgobUYVjVzVla+QIyjMzTU2
        EHLfNzpIZhJyTJSLu6aXTyW8p3F/EGHY5NnzQ7OpgJ/oIRyBtXl4eBA1pLHJUDeHp/WYlrD9RER
        1FRHjl+xYtRXYo/8tYtlUtZ+QbR78nbVrnFLGzMBUyA==
X-Received: by 2002:a67:1ac4:: with SMTP id a187mr3150174vsa.45.1622130101939;
        Thu, 27 May 2021 08:41:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9CUvNtIQtWqfuGiBrB3TfNKsVyWGE9ETjJZw9bERx80MvLXvbIp3wMPz2DVNvSLPf3eQarA==
X-Received: by 2002:a67:1ac4:: with SMTP id a187mr3150117vsa.45.1622130101444;
        Thu, 27 May 2021 08:41:41 -0700 (PDT)
Received: from localhost.localdomain ([45.237.48.3])
        by smtp.gmail.com with ESMTPSA id 2sm394687uaj.7.2021.05.27.08.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 08:41:40 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     Aneesh V <aneesh@ti.com>
Subject: [RFC PATCH] memory: emif: remove unused frequency and voltage notifiers
Date:   Thu, 27 May 2021 11:41:01 -0400
Message-Id: <20210527154101.80556-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver defined several functions related to handling of frequency
and voltage changes:
 - freq_post_notify_handling
 - freq_pre_notify_handling
 - volt_notify_handling

All these are static, not used inside the driver or outside, and marked
with comment: "TODO: voltage notify handling should be hooked up to
regulator framework as soon as the necessary support is available in
mainline kernel. This function is un-used right now.".

These were added with commit a93de288aad3 ("memory: emif: handle
frequency and voltage change events") in 2012 and are unused since then.
Additionally mentioned regulator and clock hooking did not happen since
then.  If it did not happen for nine years, let's assume it will not
happen suddenly now.

Remove all unused functions which also allows removal of "t_ck" static
variable "t_ck" and "addressing" member of private structure.

No functionality is lost.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/memory/emif.c | 678 ------------------------------------------
 1 file changed, 678 deletions(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index f7825eef5894..762d0c0f0716 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -41,7 +41,6 @@
  * @node:			node in the device list
  * @base:			base address of memory-mapped IO registers.
  * @dev:			device pointer.
- * @addressing			table with addressing information from the spec
  * @regs_cache:			An array of 'struct emif_regs' that stores
  *				calculated register values for different
  *				frequencies, to avoid re-calculating them on
@@ -61,7 +60,6 @@ struct emif_data {
 	unsigned long			irq_state;
 	void __iomem			*base;
 	struct device			*dev;
-	const struct lpddr2_addressing	*addressing;
 	struct emif_regs		*regs_cache[EMIF_MAX_NUM_FREQUENCIES];
 	struct emif_regs		*curr_regs;
 	struct emif_platform_data	*plat_data;
@@ -72,7 +70,6 @@ struct emif_data {
 static struct emif_data *emif1;
 static DEFINE_SPINLOCK(emif_lock);
 static unsigned long	irq_state;
-static u32		t_ck; /* DDR clock period in ps */
 static LIST_HEAD(device_list);
 
 #ifdef CONFIG_DEBUG_FS
@@ -169,15 +166,6 @@ static inline void __exit emif_debugfs_exit(struct emif_data *emif)
 }
 #endif
 
-/*
- * Calculate the period of DDR clock from frequency value
- */
-static void set_ddr_clk_period(u32 freq)
-{
-	/* Divide 10^12 by frequency to get period in ps */
-	t_ck = (u32)DIV_ROUND_UP_ULL(1000000000000ull, freq);
-}
-
 /*
  * Get bus width used by EMIF. Note that this may be different from the
  * bus width of the DDR devices used. For instance two 16-bit DDR devices
@@ -196,19 +184,6 @@ static u32 get_emif_bus_width(struct emif_data *emif)
 	return width;
 }
 
-/*
- * Get the CL from SDRAM_CONFIG register
- */
-static u32 get_cl(struct emif_data *emif)
-{
-	u32		cl;
-	void __iomem	*base = emif->base;
-
-	cl = (readl(base + EMIF_SDRAM_CONFIG) & CL_MASK) >> CL_SHIFT;
-
-	return cl;
-}
-
 static void set_lpmode(struct emif_data *emif, u8 lpmode)
 {
 	u32 temp;
@@ -328,203 +303,6 @@ static const struct lpddr2_addressing *get_addressing_table(
 	return &lpddr2_jedec_addressing_table[index];
 }
 
-/*
- * Find the the right timing table from the array of timing
- * tables of the device using DDR clock frequency
- */
-static const struct lpddr2_timings *get_timings_table(struct emif_data *emif,
-		u32 freq)
-{
-	u32				i, min, max, freq_nearest;
-	const struct lpddr2_timings	*timings = NULL;
-	const struct lpddr2_timings	*timings_arr = emif->plat_data->timings;
-	struct				device *dev = emif->dev;
-
-	/* Start with a very high frequency - 1GHz */
-	freq_nearest = 1000000000;
-
-	/*
-	 * Find the timings table such that:
-	 *  1. the frequency range covers the required frequency(safe) AND
-	 *  2. the max_freq is closest to the required frequency(optimal)
-	 */
-	for (i = 0; i < emif->plat_data->timings_arr_size; i++) {
-		max = timings_arr[i].max_freq;
-		min = timings_arr[i].min_freq;
-		if ((freq >= min) && (freq <= max) && (max < freq_nearest)) {
-			freq_nearest = max;
-			timings = &timings_arr[i];
-		}
-	}
-
-	if (!timings)
-		dev_err(dev, "%s: couldn't find timings for - %dHz\n",
-			__func__, freq);
-
-	dev_dbg(dev, "%s: timings table: freq %d, speed bin freq %d\n",
-		__func__, freq, freq_nearest);
-
-	return timings;
-}
-
-static u32 get_sdram_ref_ctrl_shdw(u32 freq,
-		const struct lpddr2_addressing *addressing)
-{
-	u32 ref_ctrl_shdw = 0, val = 0, freq_khz, t_refi;
-
-	/* Scale down frequency and t_refi to avoid overflow */
-	freq_khz = freq / 1000;
-	t_refi = addressing->tREFI_ns / 100;
-
-	/*
-	 * refresh rate to be set is 'tREFI(in us) * freq in MHz
-	 * division by 10000 to account for change in units
-	 */
-	val = t_refi * freq_khz / 10000;
-	ref_ctrl_shdw |= val << REFRESH_RATE_SHIFT;
-
-	return ref_ctrl_shdw;
-}
-
-static u32 get_sdram_tim_1_shdw(const struct lpddr2_timings *timings,
-		const struct lpddr2_min_tck *min_tck,
-		const struct lpddr2_addressing *addressing)
-{
-	u32 tim1 = 0, val = 0;
-
-	val = max(min_tck->tWTR, DIV_ROUND_UP(timings->tWTR, t_ck)) - 1;
-	tim1 |= val << T_WTR_SHIFT;
-
-	if (addressing->num_banks == B8)
-		val = DIV_ROUND_UP(timings->tFAW, t_ck*4);
-	else
-		val = max(min_tck->tRRD, DIV_ROUND_UP(timings->tRRD, t_ck));
-	tim1 |= (val - 1) << T_RRD_SHIFT;
-
-	val = DIV_ROUND_UP(timings->tRAS_min + timings->tRPab, t_ck) - 1;
-	tim1 |= val << T_RC_SHIFT;
-
-	val = max(min_tck->tRASmin, DIV_ROUND_UP(timings->tRAS_min, t_ck));
-	tim1 |= (val - 1) << T_RAS_SHIFT;
-
-	val = max(min_tck->tWR, DIV_ROUND_UP(timings->tWR, t_ck)) - 1;
-	tim1 |= val << T_WR_SHIFT;
-
-	val = max(min_tck->tRCD, DIV_ROUND_UP(timings->tRCD, t_ck)) - 1;
-	tim1 |= val << T_RCD_SHIFT;
-
-	val = max(min_tck->tRPab, DIV_ROUND_UP(timings->tRPab, t_ck)) - 1;
-	tim1 |= val << T_RP_SHIFT;
-
-	return tim1;
-}
-
-static u32 get_sdram_tim_1_shdw_derated(const struct lpddr2_timings *timings,
-		const struct lpddr2_min_tck *min_tck,
-		const struct lpddr2_addressing *addressing)
-{
-	u32 tim1 = 0, val = 0;
-
-	val = max(min_tck->tWTR, DIV_ROUND_UP(timings->tWTR, t_ck)) - 1;
-	tim1 = val << T_WTR_SHIFT;
-
-	/*
-	 * tFAW is approximately 4 times tRRD. So add 1875*4 = 7500ps
-	 * to tFAW for de-rating
-	 */
-	if (addressing->num_banks == B8) {
-		val = DIV_ROUND_UP(timings->tFAW + 7500, 4 * t_ck) - 1;
-	} else {
-		val = DIV_ROUND_UP(timings->tRRD + 1875, t_ck);
-		val = max(min_tck->tRRD, val) - 1;
-	}
-	tim1 |= val << T_RRD_SHIFT;
-
-	val = DIV_ROUND_UP(timings->tRAS_min + timings->tRPab + 1875, t_ck);
-	tim1 |= (val - 1) << T_RC_SHIFT;
-
-	val = DIV_ROUND_UP(timings->tRAS_min + 1875, t_ck);
-	val = max(min_tck->tRASmin, val) - 1;
-	tim1 |= val << T_RAS_SHIFT;
-
-	val = max(min_tck->tWR, DIV_ROUND_UP(timings->tWR, t_ck)) - 1;
-	tim1 |= val << T_WR_SHIFT;
-
-	val = max(min_tck->tRCD, DIV_ROUND_UP(timings->tRCD + 1875, t_ck));
-	tim1 |= (val - 1) << T_RCD_SHIFT;
-
-	val = max(min_tck->tRPab, DIV_ROUND_UP(timings->tRPab + 1875, t_ck));
-	tim1 |= (val - 1) << T_RP_SHIFT;
-
-	return tim1;
-}
-
-static u32 get_sdram_tim_2_shdw(const struct lpddr2_timings *timings,
-		const struct lpddr2_min_tck *min_tck,
-		const struct lpddr2_addressing *addressing,
-		u32 type)
-{
-	u32 tim2 = 0, val = 0;
-
-	val = min_tck->tCKE - 1;
-	tim2 |= val << T_CKE_SHIFT;
-
-	val = max(min_tck->tRTP, DIV_ROUND_UP(timings->tRTP, t_ck)) - 1;
-	tim2 |= val << T_RTP_SHIFT;
-
-	/* tXSNR = tRFCab_ps + 10 ns(tRFCab_ps for LPDDR2). */
-	val = DIV_ROUND_UP(addressing->tRFCab_ps + 10000, t_ck) - 1;
-	tim2 |= val << T_XSNR_SHIFT;
-
-	/* XSRD same as XSNR for LPDDR2 */
-	tim2 |= val << T_XSRD_SHIFT;
-
-	val = max(min_tck->tXP, DIV_ROUND_UP(timings->tXP, t_ck)) - 1;
-	tim2 |= val << T_XP_SHIFT;
-
-	return tim2;
-}
-
-static u32 get_sdram_tim_3_shdw(const struct lpddr2_timings *timings,
-		const struct lpddr2_min_tck *min_tck,
-		const struct lpddr2_addressing *addressing,
-		u32 type, u32 ip_rev, u32 derated)
-{
-	u32 tim3 = 0, val = 0, t_dqsck;
-
-	val = timings->tRAS_max_ns / addressing->tREFI_ns - 1;
-	val = val > 0xF ? 0xF : val;
-	tim3 |= val << T_RAS_MAX_SHIFT;
-
-	val = DIV_ROUND_UP(addressing->tRFCab_ps, t_ck) - 1;
-	tim3 |= val << T_RFC_SHIFT;
-
-	t_dqsck = (derated == EMIF_DERATED_TIMINGS) ?
-		timings->tDQSCK_max_derated : timings->tDQSCK_max;
-	if (ip_rev == EMIF_4D5)
-		val = DIV_ROUND_UP(t_dqsck + 1000, t_ck) - 1;
-	else
-		val = DIV_ROUND_UP(t_dqsck, t_ck) - 1;
-
-	tim3 |= val << T_TDQSCKMAX_SHIFT;
-
-	val = DIV_ROUND_UP(timings->tZQCS, t_ck) - 1;
-	tim3 |= val << ZQ_ZQCS_SHIFT;
-
-	val = DIV_ROUND_UP(timings->tCKESR, t_ck);
-	val = max(min_tck->tCKESR, val) - 1;
-	tim3 |= val << T_CKESR_SHIFT;
-
-	if (ip_rev == EMIF_4D5) {
-		tim3 |= (EMIF_T_CSTA - 1) << T_CSTA_SHIFT;
-
-		val = DIV_ROUND_UP(EMIF_T_PDLL_UL, 128) - 1;
-		tim3 |= val << T_PDLL_UL_SHIFT;
-	}
-
-	return tim3;
-}
-
 static u32 get_zq_config_reg(const struct lpddr2_addressing *addressing,
 		bool cs1_used, bool cal_resistors_per_cs)
 {
@@ -589,117 +367,6 @@ static u32 get_temp_alert_config(const struct lpddr2_addressing *addressing,
 	return alert;
 }
 
-static u32 get_read_idle_ctrl_shdw(u8 volt_ramp)
-{
-	u32 idle = 0, val = 0;
-
-	/*
-	 * Maximum value in normal conditions and increased frequency
-	 * when voltage is ramping
-	 */
-	if (volt_ramp)
-		val = READ_IDLE_INTERVAL_DVFS / t_ck / 64 - 1;
-	else
-		val = 0x1FF;
-
-	/*
-	 * READ_IDLE_CTRL register in EMIF4D has same offset and fields
-	 * as DLL_CALIB_CTRL in EMIF4D5, so use the same shifts
-	 */
-	idle |= val << DLL_CALIB_INTERVAL_SHIFT;
-	idle |= EMIF_READ_IDLE_LEN_VAL << ACK_WAIT_SHIFT;
-
-	return idle;
-}
-
-static u32 get_dll_calib_ctrl_shdw(u8 volt_ramp)
-{
-	u32 calib = 0, val = 0;
-
-	if (volt_ramp == DDR_VOLTAGE_RAMPING)
-		val = DLL_CALIB_INTERVAL_DVFS / t_ck / 16 - 1;
-	else
-		val = 0; /* Disabled when voltage is stable */
-
-	calib |= val << DLL_CALIB_INTERVAL_SHIFT;
-	calib |= DLL_CALIB_ACK_WAIT_VAL << ACK_WAIT_SHIFT;
-
-	return calib;
-}
-
-static u32 get_ddr_phy_ctrl_1_attilaphy_4d(const struct lpddr2_timings *timings,
-	u32 freq, u8 RL)
-{
-	u32 phy = EMIF_DDR_PHY_CTRL_1_BASE_VAL_ATTILAPHY, val = 0;
-
-	val = RL + DIV_ROUND_UP(timings->tDQSCK_max, t_ck) - 1;
-	phy |= val << READ_LATENCY_SHIFT_4D;
-
-	if (freq <= 100000000)
-		val = EMIF_DLL_SLAVE_DLY_CTRL_100_MHZ_AND_LESS_ATTILAPHY;
-	else if (freq <= 200000000)
-		val = EMIF_DLL_SLAVE_DLY_CTRL_200_MHZ_ATTILAPHY;
-	else
-		val = EMIF_DLL_SLAVE_DLY_CTRL_400_MHZ_ATTILAPHY;
-
-	phy |= val << DLL_SLAVE_DLY_CTRL_SHIFT_4D;
-
-	return phy;
-}
-
-static u32 get_phy_ctrl_1_intelliphy_4d5(u32 freq, u8 cl)
-{
-	u32 phy = EMIF_DDR_PHY_CTRL_1_BASE_VAL_INTELLIPHY, half_delay;
-
-	/*
-	 * DLL operates at 266 MHz. If DDR frequency is near 266 MHz,
-	 * half-delay is not needed else set half-delay
-	 */
-	if (freq >= 265000000 && freq < 267000000)
-		half_delay = 0;
-	else
-		half_delay = 1;
-
-	phy |= half_delay << DLL_HALF_DELAY_SHIFT_4D5;
-	phy |= ((cl + DIV_ROUND_UP(EMIF_PHY_TOTAL_READ_LATENCY_INTELLIPHY_PS,
-			t_ck) - 1) << READ_LATENCY_SHIFT_4D5);
-
-	return phy;
-}
-
-static u32 get_ext_phy_ctrl_2_intelliphy_4d5(void)
-{
-	u32 fifo_we_slave_ratio;
-
-	fifo_we_slave_ratio =  DIV_ROUND_CLOSEST(
-		EMIF_INTELLI_PHY_DQS_GATE_OPENING_DELAY_PS * 256, t_ck);
-
-	return fifo_we_slave_ratio | fifo_we_slave_ratio << 11 |
-		fifo_we_slave_ratio << 22;
-}
-
-static u32 get_ext_phy_ctrl_3_intelliphy_4d5(void)
-{
-	u32 fifo_we_slave_ratio;
-
-	fifo_we_slave_ratio =  DIV_ROUND_CLOSEST(
-		EMIF_INTELLI_PHY_DQS_GATE_OPENING_DELAY_PS * 256, t_ck);
-
-	return fifo_we_slave_ratio >> 10 | fifo_we_slave_ratio << 1 |
-		fifo_we_slave_ratio << 12 | fifo_we_slave_ratio << 23;
-}
-
-static u32 get_ext_phy_ctrl_4_intelliphy_4d5(void)
-{
-	u32 fifo_we_slave_ratio;
-
-	fifo_we_slave_ratio =  DIV_ROUND_CLOSEST(
-		EMIF_INTELLI_PHY_DQS_GATE_OPENING_DELAY_PS * 256, t_ck);
-
-	return fifo_we_slave_ratio >> 9 | fifo_we_slave_ratio << 2 |
-		fifo_we_slave_ratio << 13;
-}
-
 static u32 get_pwr_mgmt_ctrl(u32 freq, struct emif_data *emif, u32 ip_rev)
 {
 	u32 pwr_mgmt_ctrl	= 0, timeout;
@@ -821,51 +488,6 @@ static void get_temperature_level(struct emif_data *emif)
 		emif->temperature_level = temperature_level;
 }
 
-/*
- * Program EMIF shadow registers that are not dependent on temperature
- * or voltage
- */
-static void setup_registers(struct emif_data *emif, struct emif_regs *regs)
-{
-	void __iomem	*base = emif->base;
-
-	writel(regs->sdram_tim2_shdw, base + EMIF_SDRAM_TIMING_2_SHDW);
-	writel(regs->phy_ctrl_1_shdw, base + EMIF_DDR_PHY_CTRL_1_SHDW);
-	writel(regs->pwr_mgmt_ctrl_shdw,
-	       base + EMIF_POWER_MANAGEMENT_CTRL_SHDW);
-
-	/* Settings specific for EMIF4D5 */
-	if (emif->plat_data->ip_rev != EMIF_4D5)
-		return;
-	writel(regs->ext_phy_ctrl_2_shdw, base + EMIF_EXT_PHY_CTRL_2_SHDW);
-	writel(regs->ext_phy_ctrl_3_shdw, base + EMIF_EXT_PHY_CTRL_3_SHDW);
-	writel(regs->ext_phy_ctrl_4_shdw, base + EMIF_EXT_PHY_CTRL_4_SHDW);
-}
-
-/*
- * When voltage ramps dll calibration and forced read idle should
- * happen more often
- */
-static void setup_volt_sensitive_regs(struct emif_data *emif,
-		struct emif_regs *regs, u32 volt_state)
-{
-	u32		calib_ctrl;
-	void __iomem	*base = emif->base;
-
-	/*
-	 * EMIF_READ_IDLE_CTRL in EMIF4D refers to the same register as
-	 * EMIF_DLL_CALIB_CTRL in EMIF4D5 and dll_calib_ctrl_shadow_*
-	 * is an alias of the respective read_idle_ctrl_shdw_* (members of
-	 * a union). So, the below code takes care of both cases
-	 */
-	if (volt_state == DDR_VOLTAGE_RAMPING)
-		calib_ctrl = regs->dll_calib_ctrl_shdw_volt_ramp;
-	else
-		calib_ctrl = regs->dll_calib_ctrl_shdw_normal;
-
-	writel(calib_ctrl, base + EMIF_DLL_CALIB_CTRL_SHDW);
-}
-
 /*
  * setup_temperature_sensitive_regs() - set the timings for temperature
  * sensitive registers. This happens once at initialisation time based
@@ -1508,7 +1130,6 @@ static int __init_or_module emif_probe(struct platform_device *pdev)
 	}
 
 	list_add(&emif->node, &device_list);
-	emif->addressing = get_addressing_table(emif->plat_data->device_info);
 
 	/* Save pointers to each other in emif and device structures */
 	emif->dev = &pdev->dev;
@@ -1563,305 +1184,6 @@ static void emif_shutdown(struct platform_device *pdev)
 	disable_and_clear_all_interrupts(emif);
 }
 
-static int get_emif_reg_values(struct emif_data *emif, u32 freq,
-		struct emif_regs *regs)
-{
-	u32				ip_rev, phy_type;
-	u32				cl, type;
-	const struct lpddr2_timings	*timings;
-	const struct lpddr2_min_tck	*min_tck;
-	const struct ddr_device_info	*device_info;
-	const struct lpddr2_addressing	*addressing;
-	struct emif_data		*emif_for_calc;
-	struct device			*dev;
-
-	dev = emif->dev;
-	/*
-	 * If the devices on this EMIF instance is duplicate of EMIF1,
-	 * use EMIF1 details for the calculation
-	 */
-	emif_for_calc	= emif->duplicate ? emif1 : emif;
-	timings		= get_timings_table(emif_for_calc, freq);
-	addressing	= emif_for_calc->addressing;
-	if (!timings || !addressing) {
-		dev_err(dev, "%s: not enough data available for %dHz",
-			__func__, freq);
-		return -1;
-	}
-
-	device_info	= emif_for_calc->plat_data->device_info;
-	type		= device_info->type;
-	ip_rev		= emif_for_calc->plat_data->ip_rev;
-	phy_type	= emif_for_calc->plat_data->phy_type;
-
-	min_tck		= emif_for_calc->plat_data->min_tck;
-
-	set_ddr_clk_period(freq);
-
-	regs->ref_ctrl_shdw = get_sdram_ref_ctrl_shdw(freq, addressing);
-	regs->sdram_tim1_shdw = get_sdram_tim_1_shdw(timings, min_tck,
-			addressing);
-	regs->sdram_tim2_shdw = get_sdram_tim_2_shdw(timings, min_tck,
-			addressing, type);
-	regs->sdram_tim3_shdw = get_sdram_tim_3_shdw(timings, min_tck,
-		addressing, type, ip_rev, EMIF_NORMAL_TIMINGS);
-
-	cl = get_cl(emif);
-
-	if (phy_type == EMIF_PHY_TYPE_ATTILAPHY && ip_rev == EMIF_4D) {
-		regs->phy_ctrl_1_shdw = get_ddr_phy_ctrl_1_attilaphy_4d(
-			timings, freq, cl);
-	} else if (phy_type == EMIF_PHY_TYPE_INTELLIPHY && ip_rev == EMIF_4D5) {
-		regs->phy_ctrl_1_shdw = get_phy_ctrl_1_intelliphy_4d5(freq, cl);
-		regs->ext_phy_ctrl_2_shdw = get_ext_phy_ctrl_2_intelliphy_4d5();
-		regs->ext_phy_ctrl_3_shdw = get_ext_phy_ctrl_3_intelliphy_4d5();
-		regs->ext_phy_ctrl_4_shdw = get_ext_phy_ctrl_4_intelliphy_4d5();
-	} else {
-		return -1;
-	}
-
-	/* Only timeout values in pwr_mgmt_ctrl_shdw register */
-	regs->pwr_mgmt_ctrl_shdw =
-		get_pwr_mgmt_ctrl(freq, emif_for_calc, ip_rev) &
-		(CS_TIM_MASK | SR_TIM_MASK | PD_TIM_MASK);
-
-	if (ip_rev & EMIF_4D) {
-		regs->read_idle_ctrl_shdw_normal =
-			get_read_idle_ctrl_shdw(DDR_VOLTAGE_STABLE);
-
-		regs->read_idle_ctrl_shdw_volt_ramp =
-			get_read_idle_ctrl_shdw(DDR_VOLTAGE_RAMPING);
-	} else if (ip_rev & EMIF_4D5) {
-		regs->dll_calib_ctrl_shdw_normal =
-			get_dll_calib_ctrl_shdw(DDR_VOLTAGE_STABLE);
-
-		regs->dll_calib_ctrl_shdw_volt_ramp =
-			get_dll_calib_ctrl_shdw(DDR_VOLTAGE_RAMPING);
-	}
-
-	if (type == DDR_TYPE_LPDDR2_S2 || type == DDR_TYPE_LPDDR2_S4) {
-		regs->ref_ctrl_shdw_derated = get_sdram_ref_ctrl_shdw(freq / 4,
-			addressing);
-
-		regs->sdram_tim1_shdw_derated =
-			get_sdram_tim_1_shdw_derated(timings, min_tck,
-				addressing);
-
-		regs->sdram_tim3_shdw_derated = get_sdram_tim_3_shdw(timings,
-			min_tck, addressing, type, ip_rev,
-			EMIF_DERATED_TIMINGS);
-	}
-
-	regs->freq = freq;
-
-	return 0;
-}
-
-/*
- * get_regs() - gets the cached emif_regs structure for a given EMIF instance
- * given frequency(freq):
- *
- * As an optimisation, every EMIF instance other than EMIF1 shares the
- * register cache with EMIF1 if the devices connected on this instance
- * are same as that on EMIF1(indicated by the duplicate flag)
- *
- * If we do not have an entry corresponding to the frequency given, we
- * allocate a new entry and calculate the values
- *
- * Upon finding the right reg dump, save it in curr_regs. It can be
- * directly used for thermal de-rating and voltage ramping changes.
- */
-static struct emif_regs *get_regs(struct emif_data *emif, u32 freq)
-{
-	int			i;
-	struct emif_regs	**regs_cache;
-	struct emif_regs	*regs = NULL;
-	struct device		*dev;
-
-	dev = emif->dev;
-	if (emif->curr_regs && emif->curr_regs->freq == freq) {
-		dev_dbg(dev, "%s: using curr_regs - %u Hz", __func__, freq);
-		return emif->curr_regs;
-	}
-
-	if (emif->duplicate)
-		regs_cache = emif1->regs_cache;
-	else
-		regs_cache = emif->regs_cache;
-
-	for (i = 0; i < EMIF_MAX_NUM_FREQUENCIES && regs_cache[i]; i++) {
-		if (regs_cache[i]->freq == freq) {
-			regs = regs_cache[i];
-			dev_dbg(dev,
-				"%s: reg dump found in reg cache for %u Hz\n",
-				__func__, freq);
-			break;
-		}
-	}
-
-	/*
-	 * If we don't have an entry for this frequency in the cache create one
-	 * and calculate the values
-	 */
-	if (!regs) {
-		regs = devm_kzalloc(emif->dev, sizeof(*regs), GFP_ATOMIC);
-		if (!regs)
-			return NULL;
-
-		if (get_emif_reg_values(emif, freq, regs)) {
-			devm_kfree(emif->dev, regs);
-			return NULL;
-		}
-
-		/*
-		 * Now look for an un-used entry in the cache and save the
-		 * newly created struct. If there are no free entries
-		 * over-write the last entry
-		 */
-		for (i = 0; i < EMIF_MAX_NUM_FREQUENCIES && regs_cache[i]; i++)
-			;
-
-		if (i >= EMIF_MAX_NUM_FREQUENCIES) {
-			dev_warn(dev, "%s: regs_cache full - reusing a slot!!\n",
-				__func__);
-			i = EMIF_MAX_NUM_FREQUENCIES - 1;
-			devm_kfree(emif->dev, regs_cache[i]);
-		}
-		regs_cache[i] = regs;
-	}
-
-	return regs;
-}
-
-static void do_volt_notify_handling(struct emif_data *emif, u32 volt_state)
-{
-	dev_dbg(emif->dev, "%s: voltage notification : %d", __func__,
-		volt_state);
-
-	if (!emif->curr_regs) {
-		dev_err(emif->dev,
-			"%s: volt-notify before registers are ready: %d\n",
-			__func__, volt_state);
-		return;
-	}
-
-	setup_volt_sensitive_regs(emif, emif->curr_regs, volt_state);
-}
-
-/*
- * TODO: voltage notify handling should be hooked up to
- * regulator framework as soon as the necessary support
- * is available in mainline kernel. This function is un-used
- * right now.
- */
-static void __attribute__((unused)) volt_notify_handling(u32 volt_state)
-{
-	struct emif_data *emif;
-
-	spin_lock_irqsave(&emif_lock, irq_state);
-
-	list_for_each_entry(emif, &device_list, node)
-		do_volt_notify_handling(emif, volt_state);
-	do_freq_update();
-
-	spin_unlock_irqrestore(&emif_lock, irq_state);
-}
-
-static void do_freq_pre_notify_handling(struct emif_data *emif, u32 new_freq)
-{
-	struct emif_regs *regs;
-
-	regs = get_regs(emif, new_freq);
-	if (!regs)
-		return;
-
-	emif->curr_regs = regs;
-
-	/*
-	 * Update the shadow registers:
-	 * Temperature and voltage-ramp sensitive settings are also configured
-	 * in terms of DDR cycles. So, we need to update them too when there
-	 * is a freq change
-	 */
-	dev_dbg(emif->dev, "%s: setting up shadow registers for %uHz",
-		__func__, new_freq);
-	setup_registers(emif, regs);
-	setup_temperature_sensitive_regs(emif, regs);
-	setup_volt_sensitive_regs(emif, regs, DDR_VOLTAGE_STABLE);
-
-	/*
-	 * Part of workaround for errata i728. See do_freq_update()
-	 * for more details
-	 */
-	if (emif->lpmode == EMIF_LP_MODE_SELF_REFRESH)
-		set_lpmode(emif, EMIF_LP_MODE_DISABLE);
-}
-
-/*
- * TODO: frequency notify handling should be hooked up to
- * clock framework as soon as the necessary support is
- * available in mainline kernel. This function is un-used
- * right now.
- */
-static void __attribute__((unused)) freq_pre_notify_handling(u32 new_freq)
-{
-	struct emif_data *emif;
-
-	/*
-	 * NOTE: we are taking the spin-lock here and releases it
-	 * only in post-notifier. This doesn't look good and
-	 * Sparse complains about it, but this seems to be
-	 * un-avoidable. We need to lock a sequence of events
-	 * that is split between EMIF and clock framework.
-	 *
-	 * 1. EMIF driver updates EMIF timings in shadow registers in the
-	 *    frequency pre-notify callback from clock framework
-	 * 2. clock framework sets up the registers for the new frequency
-	 * 3. clock framework initiates a hw-sequence that updates
-	 *    the frequency EMIF timings synchronously.
-	 *
-	 * All these 3 steps should be performed as an atomic operation
-	 * vis-a-vis similar sequence in the EMIF interrupt handler
-	 * for temperature events. Otherwise, there could be race
-	 * conditions that could result in incorrect EMIF timings for
-	 * a given frequency
-	 */
-	spin_lock_irqsave(&emif_lock, irq_state);
-
-	list_for_each_entry(emif, &device_list, node)
-		do_freq_pre_notify_handling(emif, new_freq);
-}
-
-static void do_freq_post_notify_handling(struct emif_data *emif)
-{
-	/*
-	 * Part of workaround for errata i728. See do_freq_update()
-	 * for more details
-	 */
-	if (emif->lpmode == EMIF_LP_MODE_SELF_REFRESH)
-		set_lpmode(emif, EMIF_LP_MODE_SELF_REFRESH);
-}
-
-/*
- * TODO: frequency notify handling should be hooked up to
- * clock framework as soon as the necessary support is
- * available in mainline kernel. This function is un-used
- * right now.
- */
-static void __attribute__((unused)) freq_post_notify_handling(void)
-{
-	struct emif_data *emif;
-
-	list_for_each_entry(emif, &device_list, node)
-		do_freq_post_notify_handling(emif);
-
-	/*
-	 * Lock is done in pre-notify handler. See freq_pre_notify_handling()
-	 * for more details
-	 */
-	spin_unlock_irqrestore(&emif_lock, irq_state);
-}
-
 #if defined(CONFIG_OF)
 static const struct of_device_id emif_of_match[] = {
 		{ .compatible = "ti,emif-4d" },
-- 
2.27.0

