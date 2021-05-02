Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC97370DB8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 17:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbhEBPwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 11:52:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232358AbhEBPwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 11:52:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 553D6611CA;
        Sun,  2 May 2021 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619970709;
        bh=aFtXlZsRPiwVYYvNWx3HFKTutPP3K3zQCwO/Pso2xfI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S/zKSzCnhvlaDPEGDejFmNqGmwLnV6U3hwJVzAcQnV9Jeg47k379GiCzEaZM9CjW2
         IBGPkurNKkgsA/LKfFggn4ZtTLuXgXIL86nH/ylsP0Ex/X/BomGjaDLn7Xq66oFdkM
         ct1ed6dQRX1dps06IaQFpDEX/rFopvM2zryP3BjncVWkmbdoBygikQPgkm7CQn7OEI
         R0KApVb/GK+kGxgg5DFdr/pe22NbgbpV0C4+WuEi2dVnlKl65NK5wGkZDPXyISPSav
         TCEL4oBdC7/GcxH02C/tIkPpDe5DB8pa+PwrOnGfL/yDXV9FpvMQvj1PPn3LXOaNay
         st16bkC+vpVSg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 4/4] habanalabs: set dma mask from fw once fw done iatu config
Date:   Sun,  2 May 2021 18:51:40 +0300
Message-Id: <20210502155140.4359-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502155140.4359-1-ogabbay@kernel.org>
References: <20210502155140.4359-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

When setting "DMA mask from FW" we are reading PSOC_GLOBAL_CONF register
which is allowed only once FW has done it's iATU configuration.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/pci/pci.c | 10 ++++++----
 drivers/misc/habanalabs/gaudi/gaudi.c    |  4 +---
 drivers/misc/habanalabs/goya/goya.c      |  4 +---
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/pci/pci.c b/drivers/misc/habanalabs/common/pci/pci.c
index 8e7982be6191..d5bedf5ba011 100644
--- a/drivers/misc/habanalabs/common/pci/pci.c
+++ b/drivers/misc/habanalabs/common/pci/pci.c
@@ -421,6 +421,12 @@ int hl_pci_init(struct hl_device *hdev)
 		goto unmap_pci_bars;
 	}
 
+	/* Driver must sleep in order for FW to finish the iATU configuration */
+	if (hdev->asic_prop.iatu_done_by_fw) {
+		usleep_range(2000, 3000);
+		hdev->asic_funcs->set_dma_mask_from_fw(hdev);
+	}
+
 	rc = dma_set_mask_and_coherent(&pdev->dev,
 					DMA_BIT_MASK(hdev->dma_mask));
 	if (rc) {
@@ -430,10 +436,6 @@ int hl_pci_init(struct hl_device *hdev)
 		goto unmap_pci_bars;
 	}
 
-	/* Driver must sleep in order for FW to finish the iATU configuration */
-	if (hdev->asic_prop.iatu_done_by_fw)
-		usleep_range(2000, 3000);
-
 	return 0;
 
 unmap_pci_bars:
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 683793c68e83..6c38009d6db7 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -600,10 +600,8 @@ static int gaudi_init_iatu(struct hl_device *hdev)
 	struct hl_outbound_pci_region outbound_region;
 	int rc;
 
-	if (hdev->asic_prop.iatu_done_by_fw) {
-		hdev->asic_funcs->set_dma_mask_from_fw(hdev);
+	if (hdev->asic_prop.iatu_done_by_fw)
 		return 0;
-	}
 
 	/* Inbound Region 0 - Bar 0 - Point to SRAM + CFG */
 	inbound_region.mode = PCI_BAR_MATCH_MODE;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index ef0e3f7965cd..3b995e354c50 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -532,10 +532,8 @@ static int goya_init_iatu(struct hl_device *hdev)
 	struct hl_outbound_pci_region outbound_region;
 	int rc;
 
-	if (hdev->asic_prop.iatu_done_by_fw) {
-		hdev->asic_funcs->set_dma_mask_from_fw(hdev);
+	if (hdev->asic_prop.iatu_done_by_fw)
 		return 0;
-	}
 
 	/* Inbound Region 0 - Bar 0 - Point to SRAM and CFG */
 	inbound_region.mode = PCI_BAR_MATCH_MODE;
-- 
2.25.1

