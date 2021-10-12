Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249C242A5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 15:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236932AbhJLNnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 09:43:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:60026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236394AbhJLNm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 09:42:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CE1960F3A;
        Tue, 12 Oct 2021 13:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634046058;
        bh=cHO9pRW3oc9c3ug3FVVoaeuO8WauwEX4xe4M6OGwkHM=;
        h=From:To:Cc:Subject:Date:From;
        b=pX3vntri6qE1BdbjnEuK7bNiI42tg7smNEHG+yFIPHSP9IwEiY5n+97K/VSb/oyXR
         GxlySJP4KjEv22dnLei5CMUCCNRElNdMfOHAcKKgshgC0oB9Cn28baw5W2igAIw1CJ
         3w2f/aBZ+dxfU9KDts+CBkmXVIxuczOxosc2eSQRvGK8HzSgSdHTK4jnaObKTb6Yx/
         vRPf27TZLdTtOdG/S1btgA6hnCwdrulvpR+TqZPo+LmPQcsHcyf853/VsIzRBNPibE
         9A6Ve4BwiN+IpAM75MFuCL7fT2lP5+GHAQteqdSReRHHv4vrVHwpd6BVHwtmoZnJAD
         FdGvOOL9qSHpQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Rajaravi Krishna Katta <rkatta@habana.ai>
Subject: [PATCH 1/3] habanalabs: Unify frequency set/get functionality
Date:   Tue, 12 Oct 2021 16:40:49 +0300
Message-Id: <20211012134051.73555-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajaravi Krishna Katta <rkatta@habana.ai>

Make the frequency set/get functionality common to all ASICs.
This makes more code reusable when adding support for newer ASICs.

Signed-off-by: Rajaravi Krishna Katta <rkatta@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/Makefile       |  2 +-
 drivers/misc/habanalabs/common/habanalabs.h   | 10 +++++
 .../{gaudi/gaudi_hwmgr.c => common/hwmgr.c}   | 38 +++++++++----------
 drivers/misc/habanalabs/gaudi/Makefile        |  2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c         | 11 +++---
 drivers/misc/habanalabs/gaudi/gaudiP.h        |  4 --
 drivers/misc/habanalabs/goya/goya.c           |  4 +-
 drivers/misc/habanalabs/goya/goyaP.h          |  1 -
 drivers/misc/habanalabs/goya/goya_hwmgr.c     | 31 ---------------
 9 files changed, 38 insertions(+), 65 deletions(-)
 rename drivers/misc/habanalabs/{gaudi/gaudi_hwmgr.c => common/hwmgr.c} (61%)

diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/habanalabs/common/Makefile
index 6ebe3c7001ff..82c3824cad00 100644
--- a/drivers/misc/habanalabs/common/Makefile
+++ b/drivers/misc/habanalabs/common/Makefile
@@ -11,4 +11,4 @@ HL_COMMON_FILES := common/habanalabs_drv.o common/device.o common/context.o \
 		common/command_buffer.o common/hw_queue.o common/irq.o \
 		common/sysfs.o common/hwmon.o common/memory.o \
 		common/command_submission.o common/firmware_if.o \
-		common/state_dump.o
+		common/state_dump.o common/hwmgr.o
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index eb1ccb5d3ce3..e7b3b121f24d 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -456,6 +456,9 @@ struct hl_hints_range {
  *                  for hints validity check.
  * device_dma_offset_for_host_access: the offset to add to host DMA addresses
  *                                    to enable the device to access them.
+ * @max_freq_value: current max clk frequency.
+ * @clk_pll_index: clock PLL index that specify which PLL determines the clock
+ *                 we display to the user
  * @mmu_pgt_size: MMU page tables total size.
  * @mmu_pte_size: PTE size in MMU page tables.
  * @mmu_hop_table_size: MMU hop table size.
@@ -552,6 +555,8 @@ struct asic_fixed_properties {
 	u64				cb_va_end_addr;
 	u64				dram_hints_align_mask;
 	u64				device_dma_offset_for_host_access;
+	u64				max_freq_value;
+	u32				clk_pll_index;
 	u32				mmu_pgt_size;
 	u32				mmu_pte_size;
 	u32				mmu_hop_table_size;
@@ -3006,6 +3011,11 @@ int hl_set_power(struct hl_device *hdev,
 			int sensor_index, u32 attr, long value);
 int hl_get_power(struct hl_device *hdev,
 			int sensor_index, u32 attr, long *value);
+int hl_get_clk_rate(struct hl_device *hdev,
+			u32 *cur_clk, u32 *max_clk);
+void hl_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
+void hl_add_device_attr(struct hl_device *hdev,
+			struct attribute_group *dev_attr_grp);
 void hw_sob_get(struct hl_hw_sob *hw_sob);
 void hw_sob_put(struct hl_hw_sob *hw_sob);
 void hl_encaps_handle_do_release(struct kref *ref);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c b/drivers/misc/habanalabs/common/hwmgr.c
similarity index 61%
rename from drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
rename to drivers/misc/habanalabs/common/hwmgr.c
index 9b60eadd4c35..5451019f143f 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
+++ b/drivers/misc/habanalabs/common/hwmgr.c
@@ -1,29 +1,26 @@
 // SPDX-License-Identifier: GPL-2.0
 
 /*
- * Copyright 2016-2018 HabanaLabs, Ltd.
+ * Copyright 2019-2021 HabanaLabs, Ltd.
  * All Rights Reserved.
  */
 
-#include "gaudiP.h"
-#include "../include/gaudi/gaudi_fw_if.h"
+#include "habanalabs.h"
 
-void gaudi_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
+void hl_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
 {
-	struct gaudi_device *gaudi = hdev->asic_specific;
-
-	if (freq == PLL_LAST)
-		hl_set_frequency(hdev, HL_GAUDI_MME_PLL, gaudi->max_freq_value);
+	hl_set_frequency(hdev, hdev->asic_prop.clk_pll_index,
+			hdev->asic_prop.max_freq_value);
 }
 
-int gaudi_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
+int hl_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 {
 	long value;
 
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, HL_GAUDI_MME_PLL, false);
+	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, false);
 
 	if (value < 0) {
 		dev_err(hdev->dev, "Failed to retrieve device max clock %ld\n",
@@ -33,7 +30,7 @@ int gaudi_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
 
 	*max_clk = (value / 1000 / 1000);
 
-	value = hl_get_frequency(hdev, HL_GAUDI_MME_PLL, true);
+	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, true);
 
 	if (value < 0) {
 		dev_err(hdev->dev,
@@ -51,15 +48,14 @@ static ssize_t clk_max_freq_mhz_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	long value;
 
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, HL_GAUDI_MME_PLL, false);
+	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, false);
 
-	gaudi->max_freq_value = value;
+	hdev->asic_prop.max_freq_value = value;
 
 	return sprintf(buf, "%lu\n", (value / 1000 / 1000));
 }
@@ -68,7 +64,6 @@ static ssize_t clk_max_freq_mhz_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
-	struct gaudi_device *gaudi = hdev->asic_specific;
 	int rc;
 	u64 value;
 
@@ -83,9 +78,10 @@ static ssize_t clk_max_freq_mhz_store(struct device *dev,
 		goto fail;
 	}
 
-	gaudi->max_freq_value = value * 1000 * 1000;
+	hdev->asic_prop.max_freq_value = value * 1000 * 1000;
 
-	hl_set_frequency(hdev, HL_GAUDI_MME_PLL, gaudi->max_freq_value);
+	hl_set_frequency(hdev, hdev->asic_prop.clk_pll_index,
+			hdev->asic_prop.max_freq_value);
 
 fail:
 	return count;
@@ -100,7 +96,7 @@ static ssize_t clk_cur_freq_mhz_show(struct device *dev,
 	if (!hl_device_operational(hdev, NULL))
 		return -ENODEV;
 
-	value = hl_get_frequency(hdev, HL_GAUDI_MME_PLL, true);
+	value = hl_get_frequency(hdev, hdev->asic_prop.clk_pll_index, true);
 
 	return sprintf(buf, "%lu\n", (value / 1000 / 1000));
 }
@@ -108,14 +104,14 @@ static ssize_t clk_cur_freq_mhz_show(struct device *dev,
 static DEVICE_ATTR_RW(clk_max_freq_mhz);
 static DEVICE_ATTR_RO(clk_cur_freq_mhz);
 
-static struct attribute *gaudi_dev_attrs[] = {
+static struct attribute *hl_dev_attrs[] = {
 	&dev_attr_clk_max_freq_mhz.attr,
 	&dev_attr_clk_cur_freq_mhz.attr,
 	NULL,
 };
 
-void gaudi_add_device_attr(struct hl_device *hdev,
+void hl_add_device_attr(struct hl_device *hdev,
 			struct attribute_group *dev_attr_grp)
 {
-	dev_attr_grp->attrs = gaudi_dev_attrs;
+	dev_attr_grp->attrs = hl_dev_attrs;
 }
diff --git a/drivers/misc/habanalabs/gaudi/Makefile b/drivers/misc/habanalabs/gaudi/Makefile
index c9f4703cff24..10577c33a816 100644
--- a/drivers/misc/habanalabs/gaudi/Makefile
+++ b/drivers/misc/habanalabs/gaudi/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-HL_GAUDI_FILES := gaudi/gaudi.o gaudi/gaudi_hwmgr.o gaudi/gaudi_security.o \
+HL_GAUDI_FILES := gaudi/gaudi.o gaudi/gaudi_security.o \
 	gaudi/gaudi_coresight.o
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 7a5bcc81f653..825737dfe381 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -661,6 +661,9 @@ static int gaudi_set_fixed_properties(struct hl_device *hdev)
 
 	prop->server_type = HL_SERVER_TYPE_UNKNOWN;
 
+	prop->clk_pll_index = HL_GAUDI_MME_PLL;
+	prop->max_freq_value = GAUDI_MAX_CLK_FREQ;
+
 	return 0;
 }
 
@@ -1838,8 +1841,6 @@ static int gaudi_sw_init(struct hl_device *hdev)
 
 	gaudi->cpucp_info_get = gaudi_cpucp_info_get;
 
-	gaudi->max_freq_value = GAUDI_MAX_CLK_FREQ;
-
 	hdev->asic_specific = gaudi;
 
 	/* Create DMA pool for small allocations */
@@ -9444,9 +9445,9 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.debugfs_read64 = gaudi_debugfs_read64,
 	.debugfs_write64 = gaudi_debugfs_write64,
 	.debugfs_read_dma = gaudi_debugfs_read_dma,
-	.add_device_attr = gaudi_add_device_attr,
+	.add_device_attr = hl_add_device_attr,
 	.handle_eqe = gaudi_handle_eqe,
-	.set_pll_profile = gaudi_set_pll_profile,
+	.set_pll_profile = hl_set_pll_profile,
 	.get_events_stat = gaudi_get_events_stat,
 	.read_pte = gaudi_read_pte,
 	.write_pte = gaudi_write_pte,
@@ -9470,7 +9471,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.halt_coresight = gaudi_halt_coresight,
 	.ctx_init = gaudi_ctx_init,
 	.ctx_fini = gaudi_ctx_fini,
-	.get_clk_rate = gaudi_get_clk_rate,
+	.get_clk_rate = hl_get_clk_rate,
 	.get_queue_id_for_cq = gaudi_get_queue_id_for_cq,
 	.load_firmware_to_device = gaudi_load_firmware_to_device,
 	.load_boot_fit_to_device = gaudi_load_boot_fit_to_device,
diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index bbbf1c343e75..f325e36a71e6 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -319,7 +319,6 @@ struct gaudi_internal_qman_info {
  *                  the actual number of internal queues because they are not in
  *                  consecutive order.
  * @hbm_bar_cur_addr: current address of HBM PCI bar.
- * @max_freq_value: current max clk frequency.
  * @events: array that holds all event id's
  * @events_stat: array that holds histogram of all received events.
  * @events_stat_aggregate: same as events_stat but doesn't get cleared on reset
@@ -345,7 +344,6 @@ struct gaudi_device {
 	struct gaudi_collective_properties collective_props;
 
 	u64				hbm_bar_cur_addr;
-	u64				max_freq_value;
 
 	u32				events[GAUDI_EVENT_SIZE];
 	u32				events_stat[GAUDI_EVENT_SIZE];
@@ -359,10 +357,8 @@ void gaudi_init_security(struct hl_device *hdev);
 void gaudi_ack_protection_bits_errors(struct hl_device *hdev);
 void gaudi_add_device_attr(struct hl_device *hdev,
 			struct attribute_group *dev_attr_grp);
-void gaudi_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq);
 int gaudi_debug_coresight(struct hl_device *hdev, void *data);
 void gaudi_halt_coresight(struct hl_device *hdev);
-int gaudi_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 void gaudi_mmu_prepare_reg(struct hl_device *hdev, u64 reg, u32 asid);
 
 #endif /* GAUDIP_H_ */
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ad00789348d9..5536e8c27bd5 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -471,6 +471,8 @@ int goya_set_fixed_properties(struct hl_device *hdev)
 
 	prop->server_type = HL_SERVER_TYPE_UNKNOWN;
 
+	prop->clk_pll_index = HL_GOYA_MME_PLL;
+
 	return 0;
 }
 
@@ -5656,7 +5658,7 @@ static const struct hl_asic_funcs goya_funcs = {
 	.halt_coresight = goya_halt_coresight,
 	.ctx_init = goya_ctx_init,
 	.ctx_fini = goya_ctx_fini,
-	.get_clk_rate = goya_get_clk_rate,
+	.get_clk_rate = hl_get_clk_rate,
 	.get_queue_id_for_cq = goya_get_queue_id_for_cq,
 	.load_firmware_to_device = goya_load_firmware_to_device,
 	.load_boot_fit_to_device = goya_load_boot_fit_to_device,
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 0b05da614729..97add7b04f82 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -235,7 +235,6 @@ void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 					void *vaddr);
 void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev);
 
-int goya_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
 u32 goya_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx);
 u64 goya_get_device_time(struct hl_device *hdev);
 
diff --git a/drivers/misc/habanalabs/goya/goya_hwmgr.c b/drivers/misc/habanalabs/goya/goya_hwmgr.c
index 7d007125727f..59b2624ff81a 100644
--- a/drivers/misc/habanalabs/goya/goya_hwmgr.c
+++ b/drivers/misc/habanalabs/goya/goya_hwmgr.c
@@ -32,37 +32,6 @@ void goya_set_pll_profile(struct hl_device *hdev, enum hl_pll_frequency freq)
 	}
 }
 
-int goya_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk)
-{
-	long value;
-
-	if (!hl_device_operational(hdev, NULL))
-		return -ENODEV;
-
-	value = hl_get_frequency(hdev, HL_GOYA_MME_PLL, false);
-
-	if (value < 0) {
-		dev_err(hdev->dev, "Failed to retrieve device max clock %ld\n",
-			value);
-		return value;
-	}
-
-	*max_clk = (value / 1000 / 1000);
-
-	value = hl_get_frequency(hdev, HL_GOYA_MME_PLL, true);
-
-	if (value < 0) {
-		dev_err(hdev->dev,
-			"Failed to retrieve device current clock %ld\n",
-			value);
-		return value;
-	}
-
-	*cur_clk = (value / 1000 / 1000);
-
-	return 0;
-}
-
 static ssize_t mme_clk_show(struct device *dev, struct device_attribute *attr,
 				char *buf)
 {
-- 
2.17.1

