Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D57234E274
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhC3HmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:42:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15101 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbhC3Hls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:41:48 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F8hDG3mWfz19Jgd;
        Tue, 30 Mar 2021 15:39:42 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 15:41:37 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v2 3/5] crypto: hisilicon/sgl - add some dfx logs
Date:   Tue, 30 Mar 2021 15:39:04 +0800
Message-ID: <1617089946-48078-4-git-send-email-yekai13@huawei.com>
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

Add some dfx logs in some abnormal exit situations.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sgl.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/hisilicon/sgl.c b/drivers/crypto/hisilicon/sgl.c
index b816e74..4bece3d 100644
--- a/drivers/crypto/hisilicon/sgl.c
+++ b/drivers/crypto/hisilicon/sgl.c
@@ -87,8 +87,10 @@ struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
 		block[i].sgl = dma_alloc_coherent(dev, block_size,
 						  &block[i].sgl_dma,
 						  GFP_KERNEL);
-		if (!block[i].sgl)
+		if (!block[i].sgl) {
+			dev_err(dev, "Fail to allocate hw SG buffer!\n");
 			goto err_free_mem;
+		}
 
 		block[i].size = block_size;
 	}
@@ -97,8 +99,10 @@ struct hisi_acc_sgl_pool *hisi_acc_create_sgl_pool(struct device *dev,
 		block[i].sgl = dma_alloc_coherent(dev, remain_sgl * sgl_size,
 						  &block[i].sgl_dma,
 						  GFP_KERNEL);
-		if (!block[i].sgl)
+		if (!block[i].sgl) {
+			dev_err(dev, "Fail to allocate remained hw SG buffer!\n");
 			goto err_free_mem;
+		}
 
 		block[i].size = remain_sgl * sgl_size;
 	}
@@ -213,16 +217,19 @@ hisi_acc_sg_buf_map_to_hw_sgl(struct device *dev,
 	sg_n = sg_nents(sgl);
 
 	sg_n_mapped = dma_map_sg(dev, sgl, sg_n, DMA_BIDIRECTIONAL);
-	if (!sg_n_mapped)
+	if (!sg_n_mapped) {
+		dev_err(dev, "DMA mapping for SG error!\n");
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (sg_n_mapped > pool->sge_nr) {
-		dma_unmap_sg(dev, sgl, sg_n, DMA_BIDIRECTIONAL);
+		dev_err(dev, "the number of entries in input scatterlist is bigger than SGL pool setting.\n");
 		return ERR_PTR(-EINVAL);
 	}
 
 	curr_hw_sgl = acc_get_sgl(pool, index, &curr_sgl_dma);
 	if (IS_ERR(curr_hw_sgl)) {
+		dev_err(dev, "Get SGL error!\n");
 		dma_unmap_sg(dev, sgl, sg_n, DMA_BIDIRECTIONAL);
 		return ERR_PTR(-ENOMEM);
 
-- 
2.8.1

