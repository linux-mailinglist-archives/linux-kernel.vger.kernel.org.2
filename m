Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61DF94475F1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 21:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236566AbhKGUyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 15:54:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:56380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235747AbhKGUyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 15:54:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FB2361458;
        Sun,  7 Nov 2021 20:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636318310;
        bh=nHhGrYlm87kwraSUBgjRv0fPiG6yk+Oxp9I9qEUlBWw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RsFoNHyZOurGXnate7aFfyR6fPTbRs08xScZn0ZIFTuW+oYZrLYx/+IYJb95dsIlF
         2ZWJGjJOkKMS9lgO6ygCsjT1HKpSVewTIn8whof0IL4RSgOUGfbJmlwXLFS89hSu5o
         gMt2NYixjrRXAItLJ03Mtfktn2ggcs5kUT5DSKD1M/eMj3pMiGYa8DwMBGTSDxZ++3
         8/nnTXxqYJWVoQQq/YvrjtBYEU7d7a6lJFvpZgYQo2Brq2QJX1j3pwGY/QJJQBMvTT
         8aJIVIjfPzFpMdP9w4jRTGDqjcL5ka6NaqCl4BwSnd0yaqeCPR1FObhrqSEd13IA8s
         XeGBJeIHYq16w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 06/10] habanalabs: expand clock throttling information uAPI
Date:   Sun,  7 Nov 2021 22:51:32 +0200
Message-Id: <20211107205136.2329007-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211107205136.2329007-1-ogabbay@kernel.org>
References: <20211107205136.2329007-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

In addition to the clock throttling reason, user should be able
to obtain also the start time and the duration of the throttling
event.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c       |  3 ++
 drivers/misc/habanalabs/common/habanalabs.h   | 31 +++++++++++++++++--
 .../misc/habanalabs/common/habanalabs_ioctl.c | 27 ++++++++++++++--
 drivers/misc/habanalabs/gaudi/gaudi.c         | 22 ++++++++++---
 drivers/misc/habanalabs/goya/goya.c           | 25 ++++++++++++---
 include/uapi/misc/habanalabs.h                | 16 ++++++++--
 6 files changed, 110 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index eb5800b403b6..0da5a55490ff 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -455,6 +455,7 @@ static int device_early_init(struct hl_device *hdev)
 	INIT_LIST_HEAD(&hdev->fpriv_list);
 	mutex_init(&hdev->fpriv_list_lock);
 	atomic_set(&hdev->in_reset, 0);
+	mutex_init(&hdev->clk_throttling.lock);
 
 	return 0;
 
@@ -495,6 +496,8 @@ static void device_early_fini(struct hl_device *hdev)
 
 	mutex_destroy(&hdev->fpriv_list_lock);
 
+	mutex_destroy(&hdev->clk_throttling.lock);
+
 	hl_cb_mgr_fini(hdev, &hdev->kernel_cb_mgr);
 
 	kfree(hdev->hl_chip_info);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 92d12c8ba569..fc201537f7a9 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -2378,6 +2378,32 @@ struct multi_cs_data {
 	u8		update_ts;
 };
 
+/**
+ * struct hl_clk_throttle_timestamp - current/last clock throttling timestamp
+ * @start: timestamp taken when 'start' event is received in driver
+ * @end: timestamp taken when 'end' event is received in driver
+ */
+struct hl_clk_throttle_timestamp {
+	ktime_t		start;
+	ktime_t		end;
+};
+
+/**
+ * struct hl_clk_throttle - keeps current/last clock throttling timestamps
+ * @timestamp: timestamp taken by driver and firmware, index 0 refers to POWER
+ *             index 1 refers to THERMAL
+ * @lock: protects this structure as it can be accessed from both event queue
+ *        context and info_ioctl context
+ * @current_reason: bitmask represents the current clk throttling reasons
+ * @aggregated_reason: bitmask represents aggregated clk throttling reasons since driver load
+ */
+struct hl_clk_throttle {
+	struct hl_clk_throttle_timestamp timestamp[HL_CLK_THROTTLE_TYPE_MAX];
+	struct mutex	lock;
+	u32		current_reason;
+	u32		aggregated_reason;
+};
+
 /**
  * struct hl_device - habanalabs device structure.
  * @pdev: pointer to PCI device, can be NULL in case of simulator device.
@@ -2445,6 +2471,7 @@ struct multi_cs_data {
  * @pci_mem_region: array of memory regions in the PCI
  * @state_dump_specs: constants and dictionaries needed to dump system state.
  * @multi_cs_completion: array of multi-CS completion.
+ * @clk_throttling: holds information about current/previous clock throttling events
  * @dram_used_mem: current DRAM memory consumption.
  * @timeout_jiffies: device CS timeout value.
  * @max_power: the max power of the device, as configured by the sysadmin. This
@@ -2474,7 +2501,6 @@ struct multi_cs_data {
  * @high_pll: high PLL profile frequency.
  * @soft_reset_cnt: number of soft reset since the driver was loaded.
  * @hard_reset_cnt: number of hard reset since the driver was loaded.
- * @clk_throttling_reason: bitmask represents the current clk throttling reasons
  * @id: device minor.
  * @id_control: minor of the control device
  * @cpu_pci_msb_addr: 50-bit extension bits for the device CPU's 40-bit
@@ -2604,6 +2630,8 @@ struct hl_device {
 
 	struct multi_cs_completion	multi_cs_completion[
 							MULTI_CS_MAX_USER_CTX];
+	struct hl_clk_throttle		clk_throttling;
+
 	u32				*stream_master_qid_arr;
 	atomic64_t			dram_used_mem;
 	u64				timeout_jiffies;
@@ -2622,7 +2650,6 @@ struct hl_device {
 	u32				high_pll;
 	u32				soft_reset_cnt;
 	u32				hard_reset_cnt;
-	u32				clk_throttling_reason;
 	u16				id;
 	u16				id_control;
 	u16				cpu_pci_msb_addr;
diff --git a/drivers/misc/habanalabs/common/habanalabs_ioctl.c b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
index 86c3257d9ae1..19726c6b642a 100644
--- a/drivers/misc/habanalabs/common/habanalabs_ioctl.c
+++ b/drivers/misc/habanalabs/common/habanalabs_ioctl.c
@@ -313,15 +313,38 @@ static int pci_counters_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 
 static int clk_throttle_info(struct hl_fpriv *hpriv, struct hl_info_args *args)
 {
+	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_info_clk_throttle clk_throttle = {0};
+	ktime_t end_time, zero_time = ktime_set(0, 0);
 	u32 max_size = args->return_size;
-	void __user *out = (void __user *) (uintptr_t) args->return_pointer;
+	int i;
 
 	if ((!max_size) || (!out))
 		return -EINVAL;
 
-	clk_throttle.clk_throttling_reason = hdev->clk_throttling_reason;
+	mutex_lock(&hdev->clk_throttling.lock);
+
+	clk_throttle.clk_throttling_reason = hdev->clk_throttling.current_reason;
+
+	for (i = 0 ; i < HL_CLK_THROTTLE_TYPE_MAX ; i++) {
+		if (!(hdev->clk_throttling.aggregated_reason & BIT(i)))
+			continue;
+
+		clk_throttle.clk_throttling_timestamp_us[i] =
+			ktime_to_us(hdev->clk_throttling.timestamp[i].start);
+
+		if (ktime_compare(hdev->clk_throttling.timestamp[i].end, zero_time))
+			end_time = ktime_get();
+		else
+			end_time = hdev->clk_throttling.timestamp[i].end;
+
+		clk_throttle.clk_throttling_duration_ns[i] =
+			ktime_to_ns(ktime_sub(end_time,
+				hdev->clk_throttling.timestamp[i].start));
+
+	}
+	mutex_unlock(&hdev->clk_throttling.lock);
 
 	return copy_to_user(out, &clk_throttle,
 		min((size_t) max_size, sizeof(clk_throttle))) ? -EFAULT : 0;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 2724ab3747f2..b4814369062e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7925,27 +7925,39 @@ static int tpc_krn_event_to_tpc_id(u16 tpc_dec_event_type)
 static void gaudi_print_clk_change_info(struct hl_device *hdev,
 					u16 event_type)
 {
+	ktime_t zero_time = ktime_set(0, 0);
+
+	mutex_lock(&hdev->clk_throttling.lock);
+
 	switch (event_type) {
 	case GAUDI_EVENT_FIX_POWER_ENV_S:
-		hdev->clk_throttling_reason |= HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.current_reason |= HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.aggregated_reason |= HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_POWER].start = ktime_get();
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_POWER].end = zero_time;
 		dev_info_ratelimited(hdev->dev,
 			"Clock throttling due to power consumption\n");
 		break;
 
 	case GAUDI_EVENT_FIX_POWER_ENV_E:
-		hdev->clk_throttling_reason &= ~HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.current_reason &= ~HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_POWER].end = ktime_get();
 		dev_info_ratelimited(hdev->dev,
 			"Power envelop is safe, back to optimal clock\n");
 		break;
 
 	case GAUDI_EVENT_FIX_THERMAL_ENV_S:
-		hdev->clk_throttling_reason |= HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.current_reason |= HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.aggregated_reason |= HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].start = ktime_get();
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].end = zero_time;
 		dev_info_ratelimited(hdev->dev,
 			"Clock throttling due to overheating\n");
 		break;
 
 	case GAUDI_EVENT_FIX_THERMAL_ENV_E:
-		hdev->clk_throttling_reason &= ~HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.current_reason &= ~HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].end = ktime_get();
 		dev_info_ratelimited(hdev->dev,
 			"Thermal envelop is safe, back to optimal clock\n");
 		break;
@@ -7955,6 +7967,8 @@ static void gaudi_print_clk_change_info(struct hl_device *hdev,
 			event_type);
 		break;
 	}
+
+	mutex_unlock(&hdev->clk_throttling.lock);
 }
 
 static void gaudi_handle_eqe(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 3bbcab7da25e..7b3683f2a6dc 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4768,24 +4768,39 @@ static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
 
 static void goya_print_clk_change_info(struct hl_device *hdev, u16 event_type)
 {
+	ktime_t zero_time = ktime_set(0, 0);
+
+	mutex_lock(&hdev->clk_throttling.lock);
+
 	switch (event_type) {
 	case GOYA_ASYNC_EVENT_ID_FIX_POWER_ENV_S:
-		hdev->clk_throttling_reason |= HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.current_reason |= HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.aggregated_reason |= HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_POWER].start = ktime_get();
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_POWER].end = zero_time;
 		dev_info_ratelimited(hdev->dev,
 			"Clock throttling due to power consumption\n");
 		break;
+
 	case GOYA_ASYNC_EVENT_ID_FIX_POWER_ENV_E:
-		hdev->clk_throttling_reason &= ~HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.current_reason &= ~HL_CLK_THROTTLE_POWER;
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_POWER].end = ktime_get();
 		dev_info_ratelimited(hdev->dev,
 			"Power envelop is safe, back to optimal clock\n");
 		break;
+
 	case GOYA_ASYNC_EVENT_ID_FIX_THERMAL_ENV_S:
-		hdev->clk_throttling_reason |= HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.current_reason |= HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.aggregated_reason |= HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].start = ktime_get();
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].end = zero_time;
 		dev_info_ratelimited(hdev->dev,
 			"Clock throttling due to overheating\n");
 		break;
+
 	case GOYA_ASYNC_EVENT_ID_FIX_THERMAL_ENV_E:
-		hdev->clk_throttling_reason &= ~HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.current_reason &= ~HL_CLK_THROTTLE_THERMAL;
+		hdev->clk_throttling.timestamp[HL_CLK_THROTTLE_TYPE_THERMAL].end = ktime_get();
 		dev_info_ratelimited(hdev->dev,
 			"Thermal envelop is safe, back to optimal clock\n");
 		break;
@@ -4795,6 +4810,8 @@ static void goya_print_clk_change_info(struct hl_device *hdev, u16 event_type)
 			event_type);
 		break;
 	}
+
+	mutex_unlock(&hdev->clk_throttling.lock);
 }
 
 void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry)
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index c5760acebdd1..257b9630773e 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -473,15 +473,27 @@ struct hl_info_pci_counters {
 	__u64 replay_cnt;
 };
 
-#define HL_CLK_THROTTLE_POWER	0x1
-#define HL_CLK_THROTTLE_THERMAL	0x2
+enum hl_clk_throttling_type {
+	HL_CLK_THROTTLE_TYPE_POWER,
+	HL_CLK_THROTTLE_TYPE_THERMAL,
+	HL_CLK_THROTTLE_TYPE_MAX
+};
+
+/* clk_throttling_reason masks */
+#define HL_CLK_THROTTLE_POWER		(1 << HL_CLK_THROTTLE_TYPE_POWER)
+#define HL_CLK_THROTTLE_THERMAL		(1 << HL_CLK_THROTTLE_TYPE_THERMAL)
 
 /**
  * struct hl_info_clk_throttle - clock throttling reason
  * @clk_throttling_reason: each bit represents a clk throttling reason
+ * @clk_throttling_timestamp_us: represents CPU timestamp in microseconds of the start-event
+ * @clk_throttling_duration_ns: the clock throttle time in nanosec
  */
 struct hl_info_clk_throttle {
 	__u32 clk_throttling_reason;
+	__u32 pad;
+	__u64 clk_throttling_timestamp_us[HL_CLK_THROTTLE_TYPE_MAX];
+	__u64 clk_throttling_duration_ns[HL_CLK_THROTTLE_TYPE_MAX];
 };
 
 /**
-- 
2.25.1

