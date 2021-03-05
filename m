Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D5E32E252
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 07:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhCEGhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 01:37:33 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13437 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbhCEGha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 01:37:30 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DsJ0N2vvSzjVjr;
        Fri,  5 Mar 2021 14:36:04 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Fri, 5 Mar 2021 14:37:18 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <marco.chiappero@intel.com>, <ebiggers@google.com>,
        <tomaszx.kowalik@intel.com>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] crypto: qat - fix use of 'dma_map_single'
Date:   Fri, 5 Mar 2021 14:35:02 +0800
Message-ID: <1614926102-44388-3-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614926102-44388-1-git-send-email-tanghui20@huawei.com>
References: <1614926102-44388-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA_TO_DEVICE synchronisation must be done after the last modification
of the memory region by the software and before it is handed off to
the device.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/crypto/qat/qat_common/qat_algs.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/crypto/qat/qat_common/qat_algs.c b/drivers/crypto/qat/qat_common/qat_algs.c
index ea1c689..f998ed5 100644
--- a/drivers/crypto/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/qat/qat_common/qat_algs.c
@@ -718,8 +718,8 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 	int n = sg_nents(sgl);
 	struct qat_alg_buf_list *bufl;
 	struct qat_alg_buf_list *buflout = NULL;
-	dma_addr_t blp;
-	dma_addr_t bloutp;
+	dma_addr_t blp = DMA_MAPPING_ERROR;
+	dma_addr_t bloutp = DMA_MAPPING_ERROR;
 	struct scatterlist *sg;
 	size_t sz_out, sz = struct_size(bufl, bufers, n + 1);

@@ -734,10 +734,6 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 	for_each_sg(sgl, sg, n, i)
 		bufl->bufers[i].addr = DMA_MAPPING_ERROR;

-	blp = dma_map_single(dev, bufl, sz, DMA_TO_DEVICE);
-	if (unlikely(dma_mapping_error(dev, blp)))
-		goto err_in;
-
 	for_each_sg(sgl, sg, n, i) {
 		int y = sg_nctr;

@@ -753,6 +749,9 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 		sg_nctr++;
 	}
 	bufl->num_bufs = sg_nctr;
+	blp = dma_map_single(dev, bufl, sz, DMA_TO_DEVICE);
+	if (unlikely(dma_mapping_error(dev, blp)))
+		goto err_in;
 	qat_req->buf.bl = bufl;
 	qat_req->buf.blp = blp;
 	qat_req->buf.sz = sz;
@@ -772,9 +771,6 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 		for_each_sg(sglout, sg, n, i)
 			bufers[i].addr = DMA_MAPPING_ERROR;

-		bloutp = dma_map_single(dev, buflout, sz_out, DMA_TO_DEVICE);
-		if (unlikely(dma_mapping_error(dev, bloutp)))
-			goto err_out;
 		for_each_sg(sglout, sg, n, i) {
 			int y = sg_nctr;

@@ -791,6 +787,9 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 		}
 		buflout->num_bufs = sg_nctr;
 		buflout->num_mapped_bufs = sg_nctr;
+		bloutp = dma_map_single(dev, buflout, sz_out, DMA_TO_DEVICE);
+		if (unlikely(dma_mapping_error(dev, bloutp)))
+			goto err_out;
 		qat_req->buf.blout = buflout;
 		qat_req->buf.bloutp = bloutp;
 		qat_req->buf.sz_out = sz_out;
@@ -802,17 +801,21 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 	return 0;

 err_out:
+	if (!dma_mapping_error(dev, bloutp))
+		dma_unmap_single(dev, bloutp, sz_out, DMA_TO_DEVICE);
+
 	n = sg_nents(sglout);
 	for (i = 0; i < n; i++)
 		if (!dma_mapping_error(dev, buflout->bufers[i].addr))
 			dma_unmap_single(dev, buflout->bufers[i].addr,
 					 buflout->bufers[i].len,
 					 DMA_BIDIRECTIONAL);
-	if (!dma_mapping_error(dev, bloutp))
-		dma_unmap_single(dev, bloutp, sz_out, DMA_TO_DEVICE);
 	kfree(buflout);

 err_in:
+	if (!dma_mapping_error(dev, blp))
+		dma_unmap_single(dev, blp, sz, DMA_TO_DEVICE);
+
 	n = sg_nents(sgl);
 	for (i = 0; i < n; i++)
 		if (!dma_mapping_error(dev, bufl->bufers[i].addr))
@@ -820,8 +823,6 @@ static int qat_alg_sgl_to_bufl(struct qat_crypto_instance *inst,
 					 bufl->bufers[i].len,
 					 DMA_BIDIRECTIONAL);

-	if (!dma_mapping_error(dev, blp))
-		dma_unmap_single(dev, blp, sz, DMA_TO_DEVICE);
 	kfree(bufl);

 	dev_err(dev, "Failed to map buf for dma\n");
--
2.8.1

