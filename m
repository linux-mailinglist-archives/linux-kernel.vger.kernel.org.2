Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE16396628
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 18:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234615AbhEaQ7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 12:59:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230104AbhEaPPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 11:15:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 076E460FE4;
        Mon, 31 May 2021 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622474048;
        bh=VOn3xU0YrtOOQJVMS8zh2btlDYzzSUoXe607lzklNFE=;
        h=From:To:Cc:Subject:Date:From;
        b=e3VB/WlT64phPH07bKbvmEruamUlEFtwbT3B8FvGfFbmEw3ZPd5WglHBeY8OHL0fS
         xyVoUXgllXMKEQ5i25pyIYNJIgfUw9XesXFQfP8df14Hew7QswELSkFql8XeUqB4nE
         HNgmyU9P/9QpX5z5QGLRWC68ccmhQHX0HBMEvWXxXFyqB9KY/7N3xrrfOD4p4tMu2E
         z3TFRBRcTJ3F9WuHyRBrQwd6lO2syhw+FyxQ6vN6HXYPlbFXqslYSyd8bNRqtgperO
         QYERX8qzsrXjV6Frjw5ol+cf+5WjAO2cjq+ZhyE9wWN3VNOfYvZEtp0yH0nFCkA8Tc
         gWXcUFacDFbXQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 1/6] habanalabs/gaudi: set the correct cpu_id on MME2_QM failure
Date:   Mon, 31 May 2021 18:13:58 +0300
Message-Id: <20210531151403.12494-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

This fix was applied since there was an incorrect reported CPU ID to GIC
such that an error in MME2 QMAN aliased to be an arriving from DMA0_QM.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 5ca4c8f86801..67c44f3fc55f 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -2956,7 +2956,7 @@ static void gaudi_init_mme_qman(struct hl_device *hdev, u32 mme_offset,
 
 		/* Configure RAZWI IRQ */
 		mme_id = mme_offset /
-				(mmMME1_QM_GLBL_CFG0 - mmMME0_QM_GLBL_CFG0);
+				(mmMME1_QM_GLBL_CFG0 - mmMME0_QM_GLBL_CFG0) / 2;
 
 		mme_qm_err_cfg = MME_QMAN_GLBL_ERR_CFG_MSG_EN_MASK;
 		if (hdev->stop_on_err) {
-- 
2.25.1

