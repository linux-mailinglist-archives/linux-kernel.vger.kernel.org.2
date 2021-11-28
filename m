Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 189F446097A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359297AbhK1Tk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbhK1TiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:38:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C289C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 11:34:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4877CB80D63
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2777CC004E1;
        Sun, 28 Nov 2021 19:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638128093;
        bh=veudWGF53U2FVmhKaDgqSuU/txGuYwWBiT1CAhAmvms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CmZnQoU51Dgtb/1RiNHDO8gn+2bPakRq6VFXDSsyp0QDduyLrXJt3jukaakVc3xUu
         hJiS1gdSMUtLwdavNHMzhei1peqbTDFYHUYG3LzO7clYbU+jQbkQfQn1ec4cep3zyK
         +kbtpZUl7tE3FHEDO85yf1qRexN2qeNPjCLQqcB5iEXlRjlRzcIX2OPPKUL5R3l8Nz
         CKtvEkj7b90tU3nZoQCDYliRhFZzHz4kh3z5Yq+l2KyBBJtTNpDHeB63brfM0NtxjU
         ptJhIOUxdmci/4TuKT3frTi8Jbfh8hgXIDkhKYGfIiaVxB5BSmjvsW0W2eAL4KSwzv
         ZQWpWkYxf270w==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 10/12] habanalabs: skip read fw errors if dynamic descriptor invalid
Date:   Sun, 28 Nov 2021 21:34:33 +0200
Message-Id: <20211128193435.266534-10-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128193435.266534-1-ogabbay@kernel.org>
References: <20211128193435.266534-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

Reporting FW errors involves reading of the error registers.

In case we have a corrupted FW descriptor we cannot do that since the
dynamic scratchpad is potentially corrupted as well and may cause kernel
crush when attempting access to a corrupted register offset.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 17 +++++++++++++++--
 drivers/misc/habanalabs/common/habanalabs.h  |  2 ++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index bafadcc65497..760ca139d5cf 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1772,6 +1772,9 @@ static int hl_fw_dynamic_validate_descriptor(struct hl_device *hdev,
 		return rc;
 	}
 
+	/* here we can mark the descriptor as valid as the content has been validated */
+	fw_loader->dynamic_loader.fw_desc_valid = true;
+
 	return 0;
 }
 
@@ -1828,7 +1831,13 @@ static int hl_fw_dynamic_read_and_validate_descriptor(struct hl_device *hdev,
 		return rc;
 	}
 
-	/* extract address copy the descriptor from */
+	/*
+	 * extract address to copy the descriptor from
+	 * in addition, as the descriptor value is going to be over-ridden by new data- we mark it
+	 * as invalid.
+	 * it will be marked again as valid once validated
+	 */
+	fw_loader->dynamic_loader.fw_desc_valid = false;
 	src = hdev->pcie_bar[region->bar_id] + region->offset_in_bar +
 							response->ram_offset;
 	memcpy_fromio(fw_desc, src, sizeof(struct lkd_fw_comms_desc));
@@ -2317,6 +2326,9 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	dev_info(hdev->dev,
 		"Loading firmware to device, may take some time...\n");
 
+	/* initialize FW descriptor as invalid */
+	fw_loader->dynamic_loader.fw_desc_valid = false;
+
 	/*
 	 * In this stage, "cpu_dyn_regs" contains only LKD's hard coded values!
 	 * It will be updated from FW after hl_fw_dynamic_request_descriptor().
@@ -2412,7 +2424,8 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 	return 0;
 
 protocol_err:
-	fw_read_errors(hdev, le32_to_cpu(dyn_regs->cpu_boot_err0),
+	if (fw_loader->dynamic_loader.fw_desc_valid)
+		fw_read_errors(hdev, le32_to_cpu(dyn_regs->cpu_boot_err0),
 				le32_to_cpu(dyn_regs->cpu_boot_err1),
 				le32_to_cpu(dyn_regs->cpu_boot_dev_sts0),
 				le32_to_cpu(dyn_regs->cpu_boot_dev_sts1));
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index c2129c9fe9e4..77ac4bb98137 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1034,6 +1034,7 @@ struct fw_response {
  * @image_region: region to copy the FW image to
  * @fw_image_size: size of FW image to load
  * @wait_for_bl_timeout: timeout for waiting for boot loader to respond
+ * @fw_desc_valid: true if FW descriptor has been validated and hence the data can be used
  */
 struct dynamic_fw_load_mgr {
 	struct fw_response response;
@@ -1041,6 +1042,7 @@ struct dynamic_fw_load_mgr {
 	struct pci_mem_region *image_region;
 	size_t fw_image_size;
 	u32 wait_for_bl_timeout;
+	bool fw_desc_valid;
 };
 
 /**
-- 
2.25.1

