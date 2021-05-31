Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B68639662A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234728AbhEaQ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:59:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:57252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233953AbhEaPPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:15:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BDF86124B;
        Mon, 31 May 2021 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622474051;
        bh=7cEGiLC1dUIheHTMnsQ0Dn99Yvv+qWT6ljtWpve5v44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7hByQXsEIvjBObcNI3oewdQaw0KRVlVwnpykgaooWS5fYhkDLs9Fe+nxE2tZxeQg
         glm2QuXsC1t/ur6BNqs3YkhAwAanXsIbqMY05LzzfEACvNYX76cDLPA4EypXT4OPo9
         zULOdZM5CeTeeMla1M6gsu18MMwpdsuz9HATJjBvZM+HdYEiUYFNdmplF3dE9TeiNq
         AYIYoojGVu6vRhs9KMuisflUBAXZ4d8Z89AUM6kaLPp0MU43IV9GiHxiOZVwz0Ym7i
         syx8bSaJtBUBA4RZXHX+7oGSkbesuXdE/LxOsDtOKuGFnDzZsoUsx7/SgB0Fm7YGTc
         8st4py4ER2Mhw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 3/6] habanalabs/gaudi: add ARB to QM stop on error masks
Date:   Mon, 31 May 2021 18:14:00 +0300
Message-Id: <20210531151403.12494-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210531151403.12494-1-ogabbay@kernel.org>
References: <20210531151403.12494-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

Update the QM stop on error masks to also stop on ARB errors.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c           | 17 +++++++----------
 .../misc/habanalabs/include/gaudi/gaudi_masks.h | 15 ++++++++++-----
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1c4da5aff88c..3f760b932eee 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2642,10 +2642,9 @@ static void gaudi_init_pci_dma_qman(struct hl_device *hdev, int dma_id,
 
 		/* Configure RAZWI IRQ */
 		dma_qm_err_cfg = PCI_DMA_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
-		if (hdev->stop_on_err) {
+		if (hdev->stop_on_err)
 			dma_qm_err_cfg |=
 				PCI_DMA_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK;
-		}
 
 		WREG32(mmDMA0_QM_GLBL_ERR_CFG + dma_qm_offset, dma_qm_err_cfg);
 
@@ -2822,10 +2821,10 @@ static void gaudi_init_hbm_dma_qman(struct hl_device *hdev, int dma_id,
 
 		/* Configure RAZWI IRQ */
 		dma_qm_err_cfg = HBM_DMA_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
-		if (hdev->stop_on_err) {
+		if (hdev->stop_on_err)
 			dma_qm_err_cfg |=
 				HBM_DMA_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK;
-		}
+
 		WREG32(mmDMA0_QM_GLBL_ERR_CFG + dma_qm_offset, dma_qm_err_cfg);
 
 		WREG32(mmDMA0_QM_GLBL_ERR_ADDR_LO + dma_qm_offset,
@@ -2959,10 +2958,10 @@ static void gaudi_init_mme_qman(struct hl_device *hdev, u32 mme_offset,
 				(mmMME1_QM_GLBL_CFG0 - mmMME0_QM_GLBL_CFG0) / 2;
 
 		mme_qm_err_cfg = MME_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
-		if (hdev->stop_on_err) {
+		if (hdev->stop_on_err)
 			mme_qm_err_cfg |=
 				MME_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK;
-		}
+
 		WREG32(mmMME0_QM_GLBL_ERR_CFG + mme_offset, mme_qm_err_cfg);
 
 		WREG32(mmMME0_QM_GLBL_ERR_ADDR_LO + mme_offset,
@@ -3093,10 +3092,9 @@ static void gaudi_init_tpc_qman(struct hl_device *hdev, u32 tpc_offset,
 
 		/* Configure RAZWI IRQ */
 		tpc_qm_err_cfg = TPC_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
-		if (hdev->stop_on_err) {
+		if (hdev->stop_on_err)
 			tpc_qm_err_cfg |=
 				TPC_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK;
-		}
 
 		WREG32(mmTPC0_QM_GLBL_ERR_CFG + tpc_offset, tpc_qm_err_cfg);
 
@@ -3245,10 +3243,9 @@ static void gaudi_init_nic_qman(struct hl_device *hdev, u32 nic_offset,
 
 		/* Configure RAZWI IRQ */
 		nic_qm_err_cfg = NIC_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
-		if (hdev->stop_on_err) {
+		if (hdev->stop_on_err)
 			nic_qm_err_cfg |=
 				NIC_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK;
-		}
 
 		WREG32(mmNIC0_QM0_GLBL_ERR_CFG + nic_offset, nic_qm_err_cfg);
 
diff --git a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
index b53aeda9a982..9aea7e996654 100644
--- a/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
+++ b/drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
@@ -66,7 +66,8 @@
 #define PCI_DMA_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK	(\
 	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_MASK, 0xF)) | \
 	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_MASK, 0xF)) | \
-	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0xF)))
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0xF)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_ARB_STOP_ON_ERR_MASK, 0x1)))
 
 #define HBM_DMA_QMAN_GLBL_ERR_CFG_MSG_EN_MASK	(\
 	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_PQF_ERR_MSG_EN_MASK, 0xF)) | \
@@ -76,7 +77,8 @@
 #define HBM_DMA_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK	(\
 	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_MASK, 0xF)) | \
 	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_MASK, 0x1F)) | \
-	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0x1F)))
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0x1F)) | \
+	(FIELD_PREP(DMA0_QM_GLBL_ERR_CFG_ARB_STOP_ON_ERR_MASK, 0x1)))
 
 #define TPC_QMAN_GLBL_ERR_CFG_MSG_EN_MASK	(\
 	(FIELD_PREP(TPC0_QM_GLBL_ERR_CFG_PQF_ERR_MSG_EN_MASK, 0xF)) | \
@@ -86,7 +88,8 @@
 #define TPC_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK	(\
 	(FIELD_PREP(TPC0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_MASK, 0xF)) | \
 	(FIELD_PREP(TPC0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_MASK, 0x1F)) | \
-	(FIELD_PREP(TPC0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0x1F)))
+	(FIELD_PREP(TPC0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0x1F)) | \
+	(FIELD_PREP(TPC0_QM_GLBL_ERR_CFG_ARB_STOP_ON_ERR_MASK, 0x1)))
 
 #define MME_QMAN_GLBL_ERR_CFG_MSG_EN_MASK	(\
 	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_PQF_ERR_MSG_EN_MASK, 0xF)) | \
@@ -96,7 +99,8 @@
 #define MME_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK	(\
 	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_PQF_STOP_ON_ERR_MASK, 0xF)) | \
 	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_CQF_STOP_ON_ERR_MASK, 0x1F)) | \
-	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0x1F)))
+	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0x1F)) | \
+	(FIELD_PREP(MME0_QM_GLBL_ERR_CFG_ARB_STOP_ON_ERR_MASK, 0x1)))
 
 #define NIC_QMAN_GLBL_ERR_CFG_MSG_EN_MASK	(\
 	(FIELD_PREP(NIC0_QM0_GLBL_ERR_CFG_PQF_ERR_MSG_EN_MASK, 0xF)) | \
@@ -106,7 +110,8 @@
 #define NIC_QMAN_GLBL_ERR_CFG_STOP_ON_ERR_EN_MASK	(\
 	(FIELD_PREP(NIC0_QM0_GLBL_ERR_CFG_PQF_STOP_ON_ERR_MASK, 0xF)) | \
 	(FIELD_PREP(NIC0_QM0_GLBL_ERR_CFG_CQF_STOP_ON_ERR_MASK, 0xF)) | \
-	(FIELD_PREP(NIC0_QM0_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0xF)))
+	(FIELD_PREP(NIC0_QM0_GLBL_ERR_CFG_CP_STOP_ON_ERR_MASK, 0xF)) | \
+	(FIELD_PREP(NIC0_QM0_GLBL_ERR_CFG_ARB_STOP_ON_ERR_MASK, 0x1)))
 
 #define QMAN_CGM1_PWR_GATE_EN	(FIELD_PREP(DMA0_QM_CGM_CFG1_MASK_TH_MASK, 0xA))
 
-- 
2.25.1

