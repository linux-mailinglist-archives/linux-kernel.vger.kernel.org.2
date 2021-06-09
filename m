Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D863A187F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbhFIPGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:06:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238798AbhFIPFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:05:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C43C613B9;
        Wed,  9 Jun 2021 15:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623251032;
        bh=Y00nCLibqex476y9E75GfJ4aXGu45gvhofEgrxpCkns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKrbxqSCkmOG0EfPsYl9jjinAzYE5xMoGmaaLJWvaZxYLOWWUj8GQfN9w2dFe0jAH
         n3r2W+LhZ1QHEOOuFU0ipikC+NVPxNk0szzoL3AogEw63Amd+tWztggnZ4IsoxkHuv
         YvUnExOOYGu+Nn48e6lw9fOLsZnbErDYj3lAF4fV9FySrykVbElnrJ2KIffX1xhUGx
         s6UZtmwpnkhlxBLVh7bV6uoJSZbE+RiGBqTudjZITo6kO3ljvqyGKtxZ+Ka7BZRN3u
         jdGYuCTn83moOu72P1GO1VX7n5RPPqo91frNM+C72aAJUVpCcHp94r+s3ILs0sHhbs
         8abXtCjPjG7Fw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Bharat Jauhari <bjauhari@habana.ai>
Subject: [PATCH 5/7] habanalabs: enable dram scramble before linux f/w
Date:   Wed,  9 Jun 2021 18:03:41 +0300
Message-Id: <20210609150343.4712-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609150343.4712-1-ogabbay@kernel.org>
References: <20210609150343.4712-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Jauhari <bjauhari@habana.ai>

In current code, for dynamic f/w loading flow, DRAM scrambling is
enabled post Linux fit image is loaded to the card. This can cause the
device CPU to go into reset state.

The correct sequence should be:
1. Load boot fit image
2. Enable scrambling
3. Load Linux fit image

This commit aligns the DRAM scrambling enabling with the static f/w load
flow.

Signed-off-by: Bharat Jauhari <bjauhari@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 10 ++++++++++
 drivers/misc/habanalabs/common/habanalabs.h  |  4 +++-
 drivers/misc/habanalabs/gaudi/gaudi.c        |  4 +---
 drivers/misc/habanalabs/goya/goya.c          |  8 +++++++-
 4 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index d5a3c786d4c9..2bb2a4145640 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2149,6 +2149,11 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	if (rc)
 		goto protocol_err;
 
+	/* Enable DRAM scrambling before Linux boot and after successful
+	 *  UBoot
+	 */
+	hdev->asic_funcs->init_cpu_scrambler_dram(hdev);
+
 	if (!(hdev->fw_components & FW_TYPE_LINUX)) {
 		dev_info(hdev->dev, "Skip loading Linux F/W\n");
 		return 0;
@@ -2295,6 +2300,11 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 		goto out;
 	}
 
+	/* Enable DRAM scrambling before Linux boot and after successful
+	 *  UBoot
+	 */
+	hdev->asic_funcs->init_cpu_scrambler_dram(hdev);
+
 	if (!(hdev->fw_components & FW_TYPE_LINUX)) {
 		dev_info(hdev->dev, "Skip loading Linux F/W\n");
 		goto out;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index bcb5bfdd7f20..bc5a1b45270f 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1092,7 +1092,8 @@ struct fw_load_mgr {
  * @get_msi_info: Retrieve asic-specific MSI ID of the f/w async event
  * @map_pll_idx_to_fw_idx: convert driver specific per asic PLL index to
  *                         generic f/w compatible PLL Indexes
- *@init_firmware_loader: initialize data for FW loader.
+ * @init_firmware_loader: initialize data for FW loader.
+ * @init_cpu_scrambler_dram: Enable CPU specific DRAM scrambling
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -1217,6 +1218,7 @@ struct hl_asic_funcs {
 	void (*get_msi_info)(__le32 *table);
 	int (*map_pll_idx_to_fw_idx)(u32 pll_idx);
 	void (*init_firmware_loader)(struct hl_device *hdev);
+	void (*init_cpu_scrambler_dram)(struct hl_device *hdev);
 };
 
 
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index f8bf30e48bba..ca1a8ca24d4a 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3804,9 +3804,6 @@ static int gaudi_load_firmware_to_device(struct hl_device *hdev)
 {
 	void __iomem *dst;
 
-	/* HBM scrambler must be initialized before pushing F/W to HBM */
-	gaudi_init_scrambler_hbm(hdev);
-
 	dst = hdev->pcie_bar[HBM_BAR_ID] + LINUX_FW_OFFSET;
 
 	return hl_fw_load_fw_to_device(hdev, GAUDI_LINUX_FW_FILE, dst, 0, 0);
@@ -8949,6 +8946,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
 	.enable_events_from_fw = gaudi_enable_events_from_fw,
 	.map_pll_idx_to_fw_idx = gaudi_map_pll_idx_to_fw_idx,
 	.init_firmware_loader = gaudi_init_firmware_loader,
+	.init_cpu_scrambler_dram = gaudi_init_scrambler_hbm
 };
 
 /**
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 6d63930b7a10..2a9b91d5c6ff 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5402,6 +5402,11 @@ static int goya_get_eeprom_data(struct hl_device *hdev, void *data,
 	return hl_fw_get_eeprom_data(hdev, data, max_size);
 }
 
+static void goya_cpu_init_scrambler_dram(struct hl_device *hdev)
+{
+
+}
+
 static int goya_ctx_init(struct hl_ctx *ctx)
 {
 	if (ctx->asid != HL_KERNEL_ASID_ID)
@@ -5601,7 +5606,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.hw_block_mmap = goya_block_mmap,
 	.enable_events_from_fw = goya_enable_events_from_fw,
 	.map_pll_idx_to_fw_idx = goya_map_pll_idx_to_fw_idx,
-	.init_firmware_loader = goya_init_firmware_loader
+	.init_firmware_loader = goya_init_firmware_loader,
+	.init_cpu_scrambler_dram = goya_cpu_init_scrambler_dram
 };
 
 /*
-- 
2.25.1

