Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A5C34E277
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhC3HmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:42:05 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15099 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbhC3Hls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:41:48 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8hDG3FWsz19J3j;
        Tue, 30 Mar 2021 15:39:42 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 15:41:37 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v2 5/5] crypto: hisilicon/sgl - fix the sg buf unmap
Date:   Tue, 30 Mar 2021 15:39:06 +0800
Message-ID: <1617089946-48078-6-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617089946-48078-1-git-send-email-yekai13@huawei.com>
References: <1617089946-48078-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clear data operation for sge data.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sgl.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index c618aaf..7a58ab3 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -189,6 +189,18 @@ static void update_hw_sgl_sum_sge(struct hisi_acc_hw_sgl *hw_sgl, u16 sum)
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
@@ -266,7 +278,7 @@ void hisi_acc_sg_buf_unmap(struct device *dev, struct scatterlist *sgl,
 		return;
 
 	dma_unmap_sg(dev, sgl, sg_nents(sgl), DMA_BIDIRECTIONAL);
-
+	clear_hw_sgl_sge(hw_sgl);
 	hw_sgl->entry_sum_in_chain = 0;
 	hw_sgl->entry_sum_in_sgl = 0;
 	hw_sgl->entry_length_in_sgl = 0;
-- 
2.8.1

