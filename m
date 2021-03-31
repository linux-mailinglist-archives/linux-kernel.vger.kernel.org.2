Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0639A34FCF5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234784AbhCaJdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:33:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:15834 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbhCaJdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:33:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F9LfP0p38z9v3K;
        Wed, 31 Mar 2021 17:31:09 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 17:33:03 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v2 5/5] crypto: hisilicon/sgl - fix the sg buf unmap
Date:   Wed, 31 Mar 2021 17:30:32 +0800
Message-ID: <1617183032-30983-6-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617183032-30983-1-git-send-email-yekai13@huawei.com>
References: <1617183032-30983-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add data cleared operation for sge data.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sgl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index 7f11e41..101456b 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -192,6 +192,18 @@ static void update_hw_sgl_sum_sge(struct hisi_acc_hw_sgl *hw_sgl, u16 sum)
 	hw_sgl->entry_sum_in_chain = cpu_to_le16(sum);
 }
 
+static void clear_hw_sgl_sge(struct hisi_acc_hw_sgl *hw_sgl)
+{
+	struct acc_hw_sge *hw_sge = hw_sgl->sge_entries;
+	int i;
+
+	for (i = 0; i < hw_sgl->entry_sum_in_sgl; i++) {
+		hw_sge[i].page_ctrl = NULL;
+		hw_sge[i].buf = 0;
+		hw_sge[i].len = 0;
+	}
+}
+
 /**
  * hisi_acc_sg_buf_map_to_hw_sgl - Map a scatterlist to a hw sgl.
  * @dev: The device which hw sgl belongs to.
@@ -269,7 +281,7 @@ void hisi_acc_sg_buf_unmap(struct device *dev, struct scatterlist *sgl,
 		return;
 
 	dma_unmap_sg(dev, sgl, sg_nents(sgl), DMA_BIDIRECTIONAL);
-
+	clear_hw_sgl_sge(hw_sgl);
 	hw_sgl->entry_sum_in_chain = 0;
 	hw_sgl->entry_sum_in_sgl = 0;
 	hw_sgl->entry_length_in_sgl = 0;
-- 
2.8.1

