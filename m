Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3428334348C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 21:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhCUUMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 16:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230355AbhCUULl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 16:11:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49B636194D;
        Sun, 21 Mar 2021 20:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616357500;
        bh=Aint24rl9lYx+DBTtXMQ2AHoEwyipXhG569nmiT5JrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDL3jSWaCp5VQybwPVrjmXXI+vDI0bB2iQk86E+G8KwjwuR4/HHUCX7Ds3tBn6Nhp
         rLV4Sqqs6qJDJMnkan/vtCuiwcbWD0n5xVKkH9eDPYJvY4Mh2v44n6Q3x4Jc9qIe5u
         ImKajbKgcWm/aZoCYmz5UB7Vg3+pLwjETs8BbAOqnCv6aqE6oe21AfwYXQycnd+C8p
         saBloc2GFKOzyRE9ZILXUwT3Y92vJd0W5bV2ylEudTOpdI2L1f+Pf/PzU7bhzaFMcf
         xJ3gQkphDQ7TRzMX4FQqT/BMjKjOyhOmDfENoFRpRgwDRTNWSJhpKSMEr9Aa/M2Eyw
         raPh1BL78lrRw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 3/3] habanalabs: improve utilization calculation
Date:   Sun, 21 Mar 2021 22:11:30 +0200
Message-Id: <20210321201130.4670-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210321201130.4670-1-ogabbay@kernel.org>
References: <20210321201130.4670-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

The new approach is based on the notion that the relative
current power consumption is in relation of proportionality
to device's true utilization.
Utilization info ranges between [0,100]%
Currently, dc_power values are hard-coded.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 .../habanalabs/common/command_submission.c    |  18 ---
 drivers/misc/habanalabs/common/device.c       | 121 ++----------------
 drivers/misc/habanalabs/common/habanalabs.h   |  25 +---
 .../misc/habanalabs/common/habanalabs_ioctl.c |  11 +-
 drivers/misc/habanalabs/common/hw_queue.c     |   8 --
 drivers/misc/habanalabs/gaudi/gaudi.c         |  20 ++-
 drivers/misc/habanalabs/gaudi/gaudiP.h        |   3 +
 drivers/misc/habanalabs/goya/goya.c           |   1 +
 drivers/misc/habanalabs/goya/goyaP.h          |   2 +
 9 files changed, 40 insertions(+), 169 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index ba6d3e317255..21a60b7c2091 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -505,24 +505,6 @@ static void cs_do_release(struct kref *ref)
 		goto out;
 	}
 
-	hdev->asic_funcs->hw_queues_lock(hdev);
-
-	hdev->cs_active_cnt--;
-	if (!hdev->cs_active_cnt) {
-		struct hl_device_idle_busy_ts *ts;
-
-		ts = &hdev->idle_busy_ts_arr[hdev->idle_busy_ts_idx++];
-		ts->busy_to_idle_ts = ktime_get();
-
-		if (hdev->idle_busy_ts_idx == HL_IDLE_BUSY_TS_ARR_SIZE)
-			hdev->idle_busy_ts_idx = 0;
-	} else if (hdev->cs_active_cnt < 0) {
-		dev_crit(hdev->dev, "CS active cnt %d is negative\n",
-			hdev->cs_active_cnt);
-	}
-
-	hdev->asic_funcs->hw_queues_unlock(hdev);
-
 	/* Need to update CI for all queue jobs that does not get completion */
 	hl_hw_queue_update_ci(cs);
 
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 53bc5ccb612f..49f0ceac4b81 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -383,17 +383,9 @@ static int device_early_init(struct hl_device *hdev)
 		goto free_sob_reset_wq;
 	}
 
-	hdev->idle_busy_ts_arr = kmalloc_array(HL_IDLE_BUSY_TS_ARR_SIZE,
-					sizeof(struct hl_device_idle_busy_ts),
-					(GFP_KERNEL | __GFP_ZERO));
-	if (!hdev->idle_busy_ts_arr) {
-		rc = -ENOMEM;
-		goto free_chip_info;
-	}
-
 	rc = hl_mmu_if_set_funcs(hdev);
 	if (rc)
-		goto free_idle_busy_ts_arr;
+		goto free_chip_info;
 
 	hl_cb_mgr_init(&hdev->kernel_cb_mgr);
 
@@ -422,8 +414,6 @@ static int device_early_init(struct hl_device *hdev)
 
 free_cb_mgr:
 	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
-free_idle_busy_ts_arr:
-	kfree(hdev->idle_busy_ts_arr);
 free_chip_info:
 	kfree(hdev->hl_chip_info);
 free_sob_reset_wq:
@@ -461,7 +451,6 @@ static void device_early_fini(struct hl_device *hdev)
 
 	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
 
-	kfree(hdev->idle_busy_ts_arr);
 	kfree(hdev->hl_chip_info);
 
 	destroy_workqueue(hdev->sob_reset_wq);
@@ -582,100 +571,24 @@ static void device_late_fini(struct hl_device *hdev)
 	hdev->late_init_done = false;
 }
 
-uint32_t hl_device_utilization(struct hl_device *hdev, uint32_t period_ms)
+int hl_device_utilization(struct hl_device *hdev, u32 *utilization)
 {
-	struct hl_device_idle_busy_ts *ts;
-	ktime_t zero_ktime, curr = ktime_get();
-	u32 overlap_cnt = 0, last_index = hdev->idle_busy_ts_idx;
-	s64 period_us, last_start_us, last_end_us, last_busy_time_us,
-		total_busy_time_us = 0, total_busy_time_ms;
-
-	zero_ktime = ktime_set(0, 0);
-	period_us = period_ms * USEC_PER_MSEC;
-	ts = &hdev->idle_busy_ts_arr[last_index];
-
-	/* check case that device is currently in idle */
-	if (!ktime_compare(ts->busy_to_idle_ts, zero_ktime) &&
-			!ktime_compare(ts->idle_to_busy_ts, zero_ktime)) {
-
-		last_index--;
-		/* Handle case idle_busy_ts_idx was 0 */
-		if (last_index > HL_IDLE_BUSY_TS_ARR_SIZE)
-			last_index = HL_IDLE_BUSY_TS_ARR_SIZE - 1;
-
-		ts = &hdev->idle_busy_ts_arr[last_index];
-	}
-
-	while (overlap_cnt < HL_IDLE_BUSY_TS_ARR_SIZE) {
-		/* Check if we are in last sample case. i.e. if the sample
-		 * begun before the sampling period. This could be a real
-		 * sample or 0 so need to handle both cases
-		 */
-		last_start_us = ktime_to_us(
-				ktime_sub(curr, ts->idle_to_busy_ts));
-
-		if (last_start_us > period_us) {
-
-			/* First check two cases:
-			 * 1. If the device is currently busy
-			 * 2. If the device was idle during the whole sampling
-			 *    period
-			 */
-
-			if (!ktime_compare(ts->busy_to_idle_ts, zero_ktime)) {
-				/* Check if the device is currently busy */
-				if (ktime_compare(ts->idle_to_busy_ts,
-						zero_ktime))
-					return 100;
-
-				/* We either didn't have any activity or we
-				 * reached an entry which is 0. Either way,
-				 * exit and return what was accumulated so far
-				 */
-				break;
-			}
-
-			/* If sample has finished, check it is relevant */
-			last_end_us = ktime_to_us(
-					ktime_sub(curr, ts->busy_to_idle_ts));
-
-			if (last_end_us > period_us)
-				break;
-
-			/* It is relevant so add it but with adjustment */
-			last_busy_time_us = ktime_to_us(
-						ktime_sub(ts->busy_to_idle_ts,
-						ts->idle_to_busy_ts));
-			total_busy_time_us += last_busy_time_us -
-					(last_start_us - period_us);
-			break;
-		}
-
-		/* Check if the sample is finished or still open */
-		if (ktime_compare(ts->busy_to_idle_ts, zero_ktime))
-			last_busy_time_us = ktime_to_us(
-						ktime_sub(ts->busy_to_idle_ts,
-						ts->idle_to_busy_ts));
-		else
-			last_busy_time_us = ktime_to_us(
-					ktime_sub(curr, ts->idle_to_busy_ts));
-
-		total_busy_time_us += last_busy_time_us;
+	u64 max_power, curr_power, dc_power;
+	int rc;
 
-		last_index--;
-		/* Handle case idle_busy_ts_idx was 0 */
-		if (last_index > HL_IDLE_BUSY_TS_ARR_SIZE)
-			last_index = HL_IDLE_BUSY_TS_ARR_SIZE - 1;
+	max_power = hdev->asic_prop.max_power_default;
+	dc_power = hdev->asic_prop.dc_power_default;
+	rc = hl_fw_cpucp_power_get(hdev, &curr_power);
 
-		ts = &hdev->idle_busy_ts_arr[last_index];
+	if (rc)
+		return rc;
 
-		overlap_cnt++;
-	}
+	curr_power = clamp(curr_power, dc_power, max_power);
 
-	total_busy_time_ms = DIV_ROUND_UP_ULL(total_busy_time_us,
-						USEC_PER_MSEC);
+	*utilization = (u32)(((curr_power - dc_power) * 100) /
+			     (max_power - dc_power));
 
-	return DIV_ROUND_UP_ULL(total_busy_time_ms * 100, period_ms);
+	return 0;
 }
 
 /*
@@ -1110,14 +1023,6 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 	for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++)
 		hl_cq_reset(hdev, &hdev->completion_queue[i]);
 
-	hdev->idle_busy_ts_idx = 0;
-	hdev->idle_busy_ts_arr[0].busy_to_idle_ts = ktime_set(0, 0);
-	hdev->idle_busy_ts_arr[0].idle_to_busy_ts = ktime_set(0, 0);
-
-	if (hdev->cs_active_cnt)
-		dev_crit(hdev->dev, "CS active cnt %d is not 0 during reset\n",
-			hdev->cs_active_cnt);
-
 	mutex_lock(&hdev->fpriv_list_lock);
 
 	/* Make sure the context switch phase will run again */
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index dc8126b270d1..ddb65639f518 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -61,8 +61,6 @@
 
 #define HL_SIM_MAX_TIMEOUT_US		10000000 /* 10s */
 
-#define HL_IDLE_BUSY_TS_ARR_SIZE	4096
-
 #define HL_COMMON_USER_INTERRUPT_ID	0xFFF
 
 /* Memory */
@@ -391,6 +389,7 @@ struct hl_mmu_properties {
  * @dram_size: DRAM total size.
  * @dram_pci_bar_size: size of PCI bar towards DRAM.
  * @max_power_default: max power of the device after reset
+ * @dc_power_default: power consumed by the device in mode idle.
  * @dram_size_for_default_page_mapping: DRAM size needed to map to avoid page
  *                                      fault.
  * @pcie_dbi_base_address: Base address of the PCIE_DBI block.
@@ -463,6 +462,7 @@ struct asic_fixed_properties {
 	u64				dram_size;
 	u64				dram_pci_bar_size;
 	u64				max_power_default;
+	u64				dc_power_default;
 	u64				dram_size_for_default_page_mapping;
 	u64				pcie_dbi_base_address;
 	u64				pcie_aux_dbi_reg_addr;
@@ -1760,16 +1760,6 @@ struct hl_device_reset_work {
 	struct hl_device		*hdev;
 };
 
-/**
- * struct hl_device_idle_busy_ts - used for calculating device utilization rate.
- * @idle_to_busy_ts: timestamp where device changed from idle to busy.
- * @busy_to_idle_ts: timestamp where device changed from busy to idle.
- */
-struct hl_device_idle_busy_ts {
-	ktime_t				idle_to_busy_ts;
-	ktime_t				busy_to_idle_ts;
-};
-
 /**
  * struct hr_mmu_hop_addrs - used for holding per-device host-resident mmu hop
  * information.
@@ -1941,8 +1931,6 @@ struct hl_mmu_funcs {
  *              when a user opens the device
  * @fpriv_list_lock: protects the fpriv_list
  * @compute_ctx: current compute context executing.
- * @idle_busy_ts_arr: array to hold time stamps of transitions from idle to busy
- *                    and vice-versa
  * @aggregated_cs_counters: aggregated cs counters among all contexts
  * @mmu_priv: device-specific MMU data.
  * @mmu_func: device-related MMU functions.
@@ -1960,13 +1948,10 @@ struct hl_mmu_funcs {
  * @curr_pll_profile: current PLL profile.
  * @card_type: Various ASICs have several card types. This indicates the card
  *             type of the current device.
- * @cs_active_cnt: number of active command submissions on this device (active
- *                 means already in H/W queues)
  * @major: habanalabs kernel driver major.
  * @high_pll: high PLL profile frequency.
  * @soft_reset_cnt: number of soft reset since the driver was loaded.
  * @hard_reset_cnt: number of hard reset since the driver was loaded.
- * @idle_busy_ts_idx: index of current entry in idle_busy_ts_arr
  * @clk_throttling_reason: bitmask represents the current clk throttling reasons
  * @id: device minor.
  * @id_control: minor of the control device
@@ -2065,8 +2050,6 @@ struct hl_device {
 
 	struct hl_ctx			*compute_ctx;
 
-	struct hl_device_idle_busy_ts	*idle_busy_ts_arr;
-
 	struct hl_cs_counters_atomic	aggregated_cs_counters;
 
 	struct hl_mmu_priv		mmu_priv;
@@ -2081,12 +2064,10 @@ struct hl_device {
 	atomic_t			in_reset;
 	enum hl_pll_frequency		curr_pll_profile;
 	enum cpucp_card_types		card_type;
-	int				cs_active_cnt;
 	u32				major;
 	u32				high_pll;
 	u32				soft_reset_cnt;
 	u32				hard_reset_cnt;
-	u32				idle_busy_ts_idx;
 	u32				clk_throttling_reason;
 	u16				id;
 	u16				id_control;
@@ -2275,7 +2256,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags);
 void hl_hpriv_get(struct hl_fpriv *hpriv);
 int hl_hpriv_put(struct hl_fpriv *hpriv);
 int hl_device_set_frequency(struct hl_device *hdev, enum hl_pll_frequency freq);
-uint32_t hl_device_utilization(struct hl_device *hdev, uint32_t period_ms);
+int hl_device_utilization(struct hl_device *hdev, u32 *utilization);
 
 int hl_build_hwmon_channel_info(struct hl_device *hdev,
 		struct cpucp_sensor *sensors_arr);
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 9fc429b82a92..33841c272eb6 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -226,19 +226,14 @@ static int device_utilization(struct hl_device *hdev, struct hl_info_args *args)
 	struct hl_info_device_utilization device_util = {0};
 	u32 max_size = args->return_size;
 	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	int rc;
 
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	if ((args->period_ms < 100) || (args->period_ms > 1000) ||
-		(args->period_ms % 100)) {
-		dev_err(hdev->dev,
-			"period %u must be between 100 - 1000 and must be divisible by 100\n",
-			args->period_ms);
+	rc = hl_device_utilization(hdev, &device_util.utilization);
+	if (rc)
 		return -EINVAL;
-	}
-
-	device_util.utilization = hl_device_utilization(hdev, args->period_ms);
 
 	return copy_to_user(out, &device_util,
 		min((size_t) max_size, sizeof(device_util))) ? -EFAULT : 0;
diff --git a/drivers/misc/habanalabs/common/hw_queue.c b/drivers/misc/habanalabs/common/hw_queue.c
index 0f335182267f..4acc25dccad3 100644
--- a/drivers/misc/habanalabs/common/hw_queue.c
+++ b/drivers/misc/habanalabs/common/hw_queue.c
@@ -635,14 +635,6 @@ int hl_hw_queue_schedule_cs(struct hl_cs *cs)
 
 	spin_unlock(&hdev->cs_mirror_lock);
 
-	if (!hdev->cs_active_cnt++) {
-		struct hl_device_idle_busy_ts *ts;
-
-		ts = &hdev->idle_busy_ts_arr[hdev->idle_busy_ts_idx];
-		ts->busy_to_idle_ts = ktime_set(0, 0);
-		ts->idle_to_busy_ts = ktime_get();
-	}
-
 	list_for_each_entry_safe(job, tmp, &cs->job_list, cs_node)
 		switch (job->queue_type) {
 		case QUEUE_TYPE_EXT:
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 8fa190fde462..f273b792bc5d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -426,6 +426,19 @@ get_collective_mode(struct hl_device *hdev, u32 queue_id)
 	return HL_COLLECTIVE_NOT_SUPPORTED;
 }
 
+static inline void set_default_power_values(struct hl_device *hdev)
+{
+	struct asic_fixed_properties *prop = &hdev->asic_prop;
+
+	if (hdev->card_type == cpucp_card_type_pmc) {
+		prop->max_power_default = MAX_POWER_DEFAULT_PMC;
+		prop->dc_power_default = DC_POWER_DEFAULT_PMC;
+	} else {
+		prop->max_power_default = MAX_POWER_DEFAULT_PCI;
+		prop->dc_power_default = DC_POWER_DEFAULT_PCI;
+	}
+}
+
 static int gaudi_get_fixed_properties(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
@@ -537,7 +550,7 @@ static int gaudi_get_fixed_properties(struct hl_device *hdev)
 	prop->num_of_events = GAUDI_EVENT_SIZE;
 	prop->tpc_enabled_mask = TPC_ENABLED_MASK;
 
-	prop->max_power_default = MAX_POWER_DEFAULT_PCI;
+	set_default_power_values(hdev);
 
 	prop->cb_pool_cb_cnt = GAUDI_CB_POOL_CB_CNT;
 	prop->cb_pool_cb_size = GAUDI_CB_POOL_CB_SIZE;
@@ -7796,10 +7809,7 @@ static int gaudi_cpucp_info_get(struct hl_device *hdev)
 
 	hdev->card_type = le32_to_cpu(hdev->asic_prop.cpucp_info.card_type);
 
-	if (hdev->card_type == cpucp_card_type_pci)
-		prop->max_power_default = MAX_POWER_DEFAULT_PCI;
-	else if (hdev->card_type == cpucp_card_type_pmc)
-		prop->max_power_default = MAX_POWER_DEFAULT_PMC;
+	set_default_power_values(hdev);
 
 	hdev->max_power = prop->max_power_default;
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 50bb4ad570fd..5929be81ec23 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -47,6 +47,9 @@
 #define MAX_POWER_DEFAULT_PCI		200000		/* 200W */
 #define MAX_POWER_DEFAULT_PMC		350000		/* 350W */
 
+#define DC_POWER_DEFAULT_PCI		60000		/* 60W */
+#define DC_POWER_DEFAULT_PMC		60000		/* 60W */
+
 #define GAUDI_CPU_TIMEOUT_USEC		30000000	/* 30s */
 
 #define TPC_ENABLED_MASK		0xFF
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index f3b3145b206f..09b423455439 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -469,6 +469,7 @@ int goya_get_fixed_properties(struct hl_device *hdev)
 	prop->cb_pool_cb_cnt = GOYA_CB_POOL_CB_CNT;
 	prop->cb_pool_cb_size = GOYA_CB_POOL_CB_SIZE;
 	prop->max_power_default = MAX_POWER_DEFAULT;
+	prop->dc_power_default = DC_POWER_DEFAULT;
 	prop->tpc_enabled_mask = TPC_ENABLED_MASK;
 	prop->pcie_dbi_base_address = mmPCIE_DBI_BASE;
 	prop->pcie_aux_dbi_reg_addr = CFG_BASE + mmPCIE_AUX_DBI;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 23fe099ed218..ef8c6c8b5c8d 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -49,6 +49,8 @@
 
 #define MAX_POWER_DEFAULT		200000		/* 200W */
 
+#define DC_POWER_DEFAULT		20000		/* 20W */
+
 #define DRAM_PHYS_DEFAULT_SIZE		0x100000000ull	/* 4GB */
 
 #define GOYA_DEFAULT_CARD_NAME		"HL1000"
-- 
2.25.1

