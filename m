Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958DF39AFBF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhFDBdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:33:33 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3533 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhFDBd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:33:29 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fx4t05TVxzYs5t;
        Fri,  4 Jun 2021 09:28:56 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 09:31:42 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 4 Jun 2021
 09:31:42 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 3/4] crypto: hisilicon/sec - add hardware integrity check value process
Date:   Fri, 4 Jun 2021 09:31:28 +0800
Message-ID: <1622770289-21588-4-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622770289-21588-1-git-send-email-yekai13@huawei.com>
References: <1622770289-21588-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use hardware integrity check value process instead of soft verify
process when doing aead decryption.

Signed-off-by: Kai Ye <yekai13@huawei.com>
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 81 +++++++++++++++++-------------
 drivers/crypto/hisilicon/sec2/sec_crypto.h |  1 +
 2 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 194a9bc..75122f0 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -54,6 +54,7 @@
 #define SEC_FLAG_MASK		0x0780
 #define SEC_TYPE_MASK		0x0F
 #define SEC_DONE_MASK		0x0001
+#define SEC_ICV_MASK		0x000E
 #define SEC_SQE_LEN_RATE_MASK	0x3
 
 #define SEC_TOTAL_IV_SZ		(SEC_IV_SIZE * QM_Q_DEPTH)
@@ -80,6 +81,7 @@
 #define SEC_SQE_CFLAG		2
 #define SEC_SQE_AEAD_FLAG	3
 #define SEC_SQE_DONE		0x1
+#define SEC_ICV_ERR		0x2
 #define MIN_MAC_LEN		4
 #define MAC_LEN_MASK		0x1U
 #define MAX_INPUT_DATA_LEN	0xFFFE00
@@ -156,32 +158,12 @@ static void sec_free_req_id(struct sec_req *req)
 	mutex_unlock(&qp_ctx->req_lock);
 }
 
-static int sec_aead_verify(struct sec_req *req)
-{
-	struct aead_request *aead_req = req->aead_req.aead_req;
-	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
-	size_t authsize = crypto_aead_authsize(tfm);
-	u8 *mac_out = req->aead_req.out_mac;
-	u8 *mac = mac_out + SEC_MAX_MAC_LEN;
-	struct scatterlist *sgl = aead_req->src;
-	size_t sz;
-
-	sz = sg_pcopy_to_buffer(sgl, sg_nents(sgl), mac, authsize,
-				aead_req->cryptlen + aead_req->assoclen -
-				authsize);
-	if (unlikely(sz != authsize || memcmp(mac_out, mac, sz))) {
-		dev_err(req->ctx->dev, "aead verify failure!\n");
-		return -EBADMSG;
-	}
-
-	return 0;
-}
-
 static u8 pre_parse_finished_bd(struct bd_status *status, void *resp)
 {
 	struct sec_sqe *bd = resp;
 
 	status->done = le16_to_cpu(bd->type2.done_flag) & SEC_DONE_MASK;
+	status->icv = (le16_to_cpu(bd->type2.done_flag) & SEC_ICV_MASK) >> 1;
 	status->flag = (le16_to_cpu(bd->type2.done_flag) &
 					SEC_FLAG_MASK) >> SEC_FLAG_OFFSET;
 	status->tag = le16_to_cpu(bd->type2.tag);
@@ -195,6 +177,7 @@ static u8 pre_parse_finished_bd3(struct bd_status *status, void *resp)
 	struct sec_sqe3 *bd3 = resp;
 
 	status->done = le16_to_cpu(bd3->done_flag) & SEC_DONE_MASK;
+	status->icv = (le16_to_cpu(bd3->done_flag) & SEC_ICV_MASK) >> 1;
 	status->flag = (le16_to_cpu(bd3->done_flag) &
 					SEC_FLAG_MASK) >> SEC_FLAG_OFFSET;
 	status->tag = le64_to_cpu(bd3->tag);
@@ -220,6 +203,14 @@ static int sec_cb_status_check(struct sec_req *req,
 					    status->flag);
 			return -EIO;
 		}
+	} else if (unlikely(ctx->alg_type == SEC_AEAD)) {
+		if (unlikely(status->flag != SEC_SQE_AEAD_FLAG ||
+			     status->icv == SEC_ICV_ERR)) {
+			dev_err_ratelimited(ctx->dev,
+					    "flag[%u], icv[%u]\n",
+					    status->flag, status->icv);
+			return -EBADMSG;
+		}
 	}
 
 	return 0;
@@ -262,9 +253,6 @@ static void sec_req_cb(struct hisi_qp *qp, void *resp)
 	if (err)
 		atomic64_inc(&dfx->done_flag_cnt);
 
-	if (ctx->alg_type == SEC_AEAD && !req->c_req.encrypt)
-		err = sec_aead_verify(req);
-
 	atomic64_inc(&dfx->recv_cnt);
 
 	ctx->req_op->buf_unmap(ctx, req);
@@ -895,7 +883,6 @@ static void sec_cipher_pbuf_unmap(struct sec_ctx *ctx, struct sec_req *req,
 	struct aead_request *aead_req = req->aead_req.aead_req;
 	struct sec_cipher_req *c_req = &req->c_req;
 	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
-	struct device *dev = ctx->dev;
 	int copy_size, pbuf_length;
 	int req_id = req->req_id;
 
@@ -905,10 +892,29 @@ static void sec_cipher_pbuf_unmap(struct sec_ctx *ctx, struct sec_req *req,
 		copy_size = c_req->c_len;
 
 	pbuf_length = sg_copy_from_buffer(dst, sg_nents(dst),
-				qp_ctx->res[req_id].pbuf,
-				copy_size);
+			qp_ctx->res[req_id].pbuf, copy_size);
 	if (unlikely(pbuf_length != copy_size))
-		dev_err(dev, "copy pbuf data to dst error!\n");
+		dev_err(ctx->dev, "copy pbuf data to dst error!\n");
+}
+
+static int sec_aead_mac_init(struct sec_aead_req *req)
+{
+	struct aead_request *aead_req = req->aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	size_t authsize = crypto_aead_authsize(tfm);
+	u8 *mac_out = req->out_mac;
+	struct scatterlist *sgl = aead_req->src;
+	size_t copy_size;
+	off_t skip_size;
+
+	/* Copy input mac */
+	skip_size = aead_req->assoclen + aead_req->cryptlen - authsize;
+	copy_size = sg_pcopy_to_buffer(sgl, sg_nents(sgl), mac_out,
+				       authsize, skip_size);
+	if (unlikely(copy_size != authsize))
+		return -EINVAL;
+
+	return 0;
 }
 
 static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
@@ -922,7 +928,6 @@ static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
 	int ret;
 
 	if (req->use_pbuf) {
-		ret = sec_cipher_pbuf_map(ctx, req, src);
 		c_req->c_ivin = res->pbuf + SEC_PBUF_IV_OFFSET;
 		c_req->c_ivin_dma = res->pbuf_dma + SEC_PBUF_IV_OFFSET;
 		if (ctx->alg_type == SEC_AEAD) {
@@ -932,6 +937,7 @@ static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
 			a_req->out_mac_dma = res->pbuf_dma +
 					SEC_PBUF_MAC_OFFSET;
 		}
+		ret = sec_cipher_pbuf_map(ctx, req, src);
 
 		return ret;
 	}
@@ -954,6 +960,13 @@ static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
 		return PTR_ERR(c_req->c_in);
 	}
 
+	if (!c_req->encrypt && ctx->alg_type == SEC_AEAD) {
+		ret = sec_aead_mac_init(a_req);
+		if (unlikely(ret)) {
+			dev_err(dev, "fail to init mac data for ICV!\n");
+			return ret;
+		}
+	}
 	if (dst == src) {
 		c_req->c_out = c_req->c_in;
 		c_req->c_out_dma = c_req->c_in_dma;
@@ -1542,13 +1555,13 @@ static void sec_auth_bd_fill_ex(struct sec_auth_ctx *ctx, int dir,
 	sec_sqe->type2.mac_key_alg |=
 			cpu_to_le32((u32)(ctx->a_alg) << SEC_AEAD_ALG_OFFSET);
 
-	sec_sqe->type_cipher_auth |= SEC_AUTH_TYPE1 << SEC_AUTH_OFFSET;
-
-	if (dir)
+	if (dir) {
+		sec_sqe->type_cipher_auth |= SEC_AUTH_TYPE1 << SEC_AUTH_OFFSET;
 		sec_sqe->sds_sa_type &= SEC_CIPHER_AUTH;
-	else
+	} else {
+		sec_sqe->type_cipher_auth |= SEC_AUTH_TYPE2 << SEC_AUTH_OFFSET;
 		sec_sqe->sds_sa_type |= SEC_AUTH_CIPHER;
-
+	}
 	sec_sqe->type2.alen_ivllen = cpu_to_le32(c_req->c_len + aq->assoclen);
 
 	sec_sqe->type2.cipher_src_offset = cpu_to_le16((u16)aq->assoclen);
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index a7bcd3e..9f71c35 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -80,6 +80,7 @@ struct bd_status {
 	u8 done;
 	u8 err_type;
 	u16 flag;
+	u16 icv;
 };
 
 enum {
-- 
2.8.1

