Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BB5311F2A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 18:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhBFRkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 12:40:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230261AbhBFRkm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 12:40:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 391D164E85
        for <linux-kernel@vger.kernel.org>; Sat,  6 Feb 2021 17:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612633201;
        bh=BV/OFUakTiHq8xAQyY0URE5Yj6utelRSRjwQXxOhok8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rGXsytCTtl/Q+hybptlWfyozklih0bn1vEN7a5Lq8AiwPxZl9a0WDsqlYTJucwz6l
         PDPorJ+akX3z6iaK5ndN/BLs2A52PInaw9wC7Kmw3nqANZszkuN0N+/TqCah/dzpi/
         8XqAgb08BIGkrgqPAFUuSC6HgMZ4AKU3ybdPbJQG+wtFuBdrhFgcZ/opMxrOJy83sT
         11eOGabpShCc8PMpYCXtBvGX5EU+LJG6XSdXIOfKP3Z0qEq29UiUtzyDYykGoDZ3So
         CyRNBVLoEaQRCJjppcdDmTRBOg5JpYdnprDsWd452vEEufQAZOw0Uk5t8vUBGXoYGG
         J5Za9fwMkh18A==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] habanalabs/gaudi: don't enable clock gating on DMA5
Date:   Sat,  6 Feb 2021 19:39:54 +0200
Message-Id: <20210206173954.4662-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210206173954.4662-1-ogabbay@kernel.org>
References: <20210206173954.4662-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Graph Compiler uses DMA5 in a non-standard way and it requires the
driver to disable clock gating on that DMA.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 35342edd4a02..9152242778f5 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3460,6 +3460,12 @@ static void gaudi_set_clock_gating(struct hl_device *hdev)
 		enable = !!(hdev->clock_gating_mask &
 				(BIT_ULL(gaudi_dma_assignment[i])));
 
+		/* GC sends work to DMA engine through Upper CP in DMA5 so
+		 * we need to not enable clock gating in that DMA
+		 */
+		if (i == GAUDI_HBM_DMA_4)
+			enable = 0;
+
 		qman_offset = gaudi_dma_assignment[i] * DMA_QMAN_OFFSET;
 		WREG32(mmDMA0_QM_CGM_CFG1 + qman_offset,
 				enable ? QMAN_CGM1_PWR_GATE_EN : 0);
-- 
2.25.1

