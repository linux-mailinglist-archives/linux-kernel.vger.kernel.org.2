Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB5D43966E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbhJYMjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:39:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233165AbhJYMjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:39:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AA2460EFF;
        Mon, 25 Oct 2021 12:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635165403;
        bh=NojdZxJQSdv4EsgGUcoRpFuNGLAOmuRTyXghkIQPa9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ohAvYrqhhD9aorZed9Ko/deBeTzbhUZ9T2ULxB22TJ8lxFMil5EJZ9RALYvemRtld
         9KMY2+qi3rITd0qsrj9gLDfr6ymyYWALwUKOA44rxG+sNSrGD5x0I/JoG+0J0kBGLH
         Rg5mJmABzpW3pFDKVTrdtRVL1Fokp5sbYt5yNafsLytJaHCewDyBqOPdmcuulgOyL+
         IaMOfoVC4J87kAfOPE5JbgRujf+NbmejhpWulqfcY8Cj6A0LvD753m1WSyLbVPkWk4
         zUgp33MCPxBbjDUUsGkMa1wJtFBKt/uHJ2MDhdQn/8SuG2+/+JDgKGO9ZTlSvrfXgG
         +929DGmcRq5iQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Guy Zadicario <gzadicario@habana.ai>
Subject: [PATCH 3/4] habanalabs/gaudi: fix debugfs dma channel selection
Date:   Mon, 25 Oct 2021 15:36:35 +0300
Message-Id: <20211025123636.2842618-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025123636.2842618-1-ogabbay@kernel.org>
References: <20211025123636.2842618-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guy Zadicario <gzadicario@habana.ai>

Do not use a dma channel for debugfs requested transfer if it's
QM is not idle.

Signed-off-by: Guy Zadicario <gzadicario@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index d2b7ecb45497..92d55a0a10c1 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6430,6 +6430,7 @@ static int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
 {
 	u32 dma_core_sts0, err_cause, cfg1, size_left, pos, size_to_dma;
 	struct gaudi_device *gaudi = hdev->asic_specific;
+	u32 qm_glbl_sts0, qm_cgm_sts;
 	u64 dma_offset, qm_offset;
 	dma_addr_t dma_addr;
 	void *kernel_addr;
@@ -6454,14 +6455,20 @@ static int gaudi_debugfs_read_dma(struct hl_device *hdev, u64 addr, u32 size,
 	dma_offset = dma_id * DMA_CORE_OFFSET;
 	qm_offset = dma_id * DMA_QMAN_OFFSET;
 	dma_core_sts0 = RREG32(mmDMA0_CORE_STS0 + dma_offset);
-	is_eng_idle = IS_DMA_IDLE(dma_core_sts0);
+	qm_glbl_sts0 = RREG32(mmDMA0_QM_GLBL_STS0 + qm_offset);
+	qm_cgm_sts = RREG32(mmDMA0_QM_CGM_STS + qm_offset);
+	is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_cgm_sts) &&
+		      IS_DMA_IDLE(dma_core_sts0);
 
 	if (!is_eng_idle) {
 		dma_id = gaudi_dma_assignment[GAUDI_PCI_DMA_2];
 		dma_offset = dma_id * DMA_CORE_OFFSET;
 		qm_offset = dma_id * DMA_QMAN_OFFSET;
 		dma_core_sts0 = RREG32(mmDMA0_CORE_STS0 + dma_offset);
-		is_eng_idle = IS_DMA_IDLE(dma_core_sts0);
+		qm_glbl_sts0 = RREG32(mmDMA0_QM_GLBL_STS0 + qm_offset);
+		qm_cgm_sts = RREG32(mmDMA0_QM_CGM_STS + qm_offset);
+		is_eng_idle = IS_QM_IDLE(qm_glbl_sts0, qm_cgm_sts) &&
+			      IS_DMA_IDLE(dma_core_sts0);
 
 		if (!is_eng_idle) {
 			dev_err_ratelimited(hdev->dev,
-- 
2.25.1

