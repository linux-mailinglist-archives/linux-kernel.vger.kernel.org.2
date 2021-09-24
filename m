Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A279416EE5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 11:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244987AbhIXJa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 05:30:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:9920 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244970AbhIXJaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 05:30:23 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HG66k1Yhwz8yfQ;
        Fri, 24 Sep 2021 17:24:14 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 24 Sep 2021 17:28:48 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 17:28:48 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v2 3/6] crypto: hisilicon/sec - support the larger packets for digest mode
Date:   Fri, 24 Sep 2021 17:27:13 +0800
Message-ID: <20210924092716.12848-4-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924092716.12848-1-yekai13@huawei.com>
References: <20210924092716.12848-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support the larger packets inputing for digest mode. By split the larger
packet, the driver input one block size packet to the hardware every time.
Setting one block size is PAGE_SIZE(4K). Based on the long hash feature,
the soft waits until the previous packet is complete and then sends the
next packet.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index c6c680b834e0..a13df2bb5654 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -2719,6 +2719,80 @@ static int sec_ahash_finup(struct ahash_request *req)
 	return sec_ahash_process(req);
 }
 
+static int digest_hardware_update(struct sec_req *sreq, struct scatterlist *src,
+				  u32 start, u32 nbytes)
+{
+	struct sec_ahash_req *sareq = &sreq->hash_req;
+	struct scatterlist *pingpong_sg;
+	struct sec_ctx *ctx = sreq->ctx;
+	int nents = sg_nents(src);
+	int sid = sareq->sid;
+	u8 idx;
+
+	idx = ctx->pingpong_idx[sid];
+	pingpong_sg = &ctx->pingpong_sg[sid][idx];
+
+	sareq->op = SEC_SHA_UPDATE;
+	sareq->pp_sg = pingpong_sg;
+
+	/* The pingpong buffer can hold the one block input of this request */
+	sg_pcopy_to_buffer(src, nents, sg_virt(pingpong_sg), nbytes, start);
+	ctx->pp_data_len[sid][idx] = nbytes;
+
+	sareq->req_data_len = 0;
+	sareq->pp_data_len = nbytes;
+	sareq->block_data_len = nbytes;
+	sareq->total_data_len += nbytes;
+
+	return ctx->req_op->process(ctx, sreq);
+}
+
+static int sec_ahash_larger_digest(struct ahash_request *req)
+{
+	struct sec_req *sreq = ahash_request_ctx(req);
+	struct sec_ahash_req *sareq = &sreq->hash_req;
+	u32 input_len = req->nbytes;
+	struct scatterlist *pingpong_sg;
+	struct sec_ctx *ctx = sreq->ctx;
+	u32 sid = sareq->sid;
+	u8 idx = ctx->pingpong_idx[sid];
+	u32 start = 0;
+	int ret;
+
+	while (input_len > SEC_SID_BUF_LEN) {
+		/* Setting one block size is PAGE_SIZE */
+		req->nbytes = SEC_SID_BUF_LEN;
+		input_len -= SEC_SID_BUF_LEN;
+
+		ret = digest_hardware_update(sreq, req->src, start,
+					     req->nbytes);
+		if (unlikely(ret == -EINVAL)) {
+			pr_err("ahash digest: hardware update process is error!\n");
+			return ret;
+		}
+
+		stream_hash_wait(sareq);
+
+		start += SEC_SID_BUF_LEN;
+	}
+
+	/* Last packet send to the hardware */
+	req->nbytes = input_len;
+	sareq->req_data_len = 0;
+
+	pingpong_sg = &ctx->pingpong_sg[sid][idx];
+	sg_pcopy_to_buffer(req->src, sg_nents(req->src), sg_virt(pingpong_sg),
+			   input_len, start);
+	ctx->pp_data_len[sid][idx] = input_len;
+	sareq->pp_data_len = input_len;
+	sareq->block_data_len = input_len;
+	sareq->total_data_len += input_len;
+
+	sareq->op = SEC_SHA_FINAL;
+
+	return ctx->req_op->process(ctx, sreq);
+}
+
 static int sec_ahash_digest(struct ahash_request *req)
 {
 	struct sec_req *sreq = ahash_request_ctx(req);
@@ -2735,6 +2809,8 @@ static int sec_ahash_digest(struct ahash_request *req)
 
 	ctx = sreq->ctx;
 	a_ctx = &ctx->a_ctx;
+	if (req->nbytes > SEC_HW_MAX_LEN)
+		return sec_ahash_larger_digest(req);
 
 	sareq->op = SEC_SHA_DIGEST;
 
-- 
2.33.0

