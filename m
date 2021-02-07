Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E0B31235C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 11:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhBGKHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 05:07:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12476 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbhBGKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 05:07:44 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYPtC56ggzjKgX;
        Sun,  7 Feb 2021 18:05:39 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Sun, 7 Feb 2021
 18:06:55 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>, <wangzhou1@hisilicon.com>,
        <xuzaibo@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] crypto: hisilicon/sec - fixes some log printing style
Date:   Sun, 7 Feb 2021 18:04:38 +0800
Message-ID: <1612692280-11386-2-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612692280-11386-1-git-send-email-liulongfang@huawei.com>
References: <1612692280-11386-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Fix a problem of error log printing
2. Modify error log printing style

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h        |  5 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 82 +++++++++++++++---------------
 drivers/crypto/hisilicon/sec2/sec_crypto.h |  2 -
 3 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 0849191..a8c10e3 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -4,8 +4,6 @@
 #ifndef __HISI_SEC_V2_H
 #define __HISI_SEC_V2_H
 
-#include <linux/list.h>
-
 #include "../qm.h"
 #include "sec_crypto.h"
 
@@ -50,7 +48,7 @@ struct sec_req {
 
 	int err_type;
 	int req_id;
-	int flag;
+	u32 flag;
 
 	/* Status of the SEC request */
 	bool fake_busy;
@@ -139,6 +137,7 @@ struct sec_ctx {
 	bool pbuf_supported;
 	struct sec_cipher_ctx c_ctx;
 	struct sec_auth_ctx a_ctx;
+	struct device *dev;
 };
 
 enum sec_endian {
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 2eaa516..d2c4a2c 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -43,7 +43,6 @@
 
 #define SEC_TOTAL_IV_SZ		(SEC_IV_SIZE * QM_Q_DEPTH)
 #define SEC_SGL_SGE_NR		128
-#define SEC_CTX_DEV(ctx)	(&(ctx)->sec->qm.pdev->dev)
 #define SEC_CIPHER_AUTH		0xfe
 #define SEC_AUTH_CIPHER		0x1
 #define SEC_MAX_MAC_LEN		64
@@ -96,7 +95,7 @@ static int sec_alloc_req_id(struct sec_req *req, struct sec_qp_ctx *qp_ctx)
 				  0, QM_Q_DEPTH, GFP_ATOMIC);
 	mutex_unlock(&qp_ctx->req_lock);
 	if (unlikely(req_id < 0)) {
-		dev_err(SEC_CTX_DEV(req->ctx), "alloc req id fail!\n");
+		dev_err(req->ctx->dev, "alloc req id fail!\n");
 		return req_id;
 	}
 
@@ -112,7 +111,7 @@ static void sec_free_req_id(struct sec_req *req)
 	int req_id = req->req_id;
 
 	if (unlikely(req_id < 0 || req_id >= QM_Q_DEPTH)) {
-		dev_err(SEC_CTX_DEV(req->ctx), "free request id invalid!\n");
+		dev_err(req->ctx->dev, "free request id invalid!\n");
 		return;
 	}
 
@@ -138,7 +137,7 @@ static int sec_aead_verify(struct sec_req *req)
 				aead_req->cryptlen + aead_req->assoclen -
 				authsize);
 	if (unlikely(sz != authsize || memcmp(mac_out, mac, sz))) {
-		dev_err(SEC_CTX_DEV(req->ctx), "aead verify failure!\n");
+		dev_err(req->ctx->dev, "aead verify failure!\n");
 		return -EBADMSG;
 	}
 
@@ -177,7 +176,7 @@ static void sec_req_cb(struct hisi_qp *qp, void *resp)
 	if (unlikely(req->err_type || done != SEC_SQE_DONE ||
 	    (ctx->alg_type == SEC_SKCIPHER && flag != SEC_SQE_CFLAG) ||
 	    (ctx->alg_type == SEC_AEAD && flag != SEC_SQE_AEAD_FLAG))) {
-		dev_err(SEC_CTX_DEV(ctx),
+		dev_err_ratelimited(ctx->dev,
 			"err_type[%d],done[%d],flag[%d]\n",
 			req->err_type, done, flag);
 		err = -EIO;
@@ -326,8 +325,8 @@ static int sec_alloc_pbuf_resource(struct device *dev, struct sec_alg_res *res)
 static int sec_alg_resource_alloc(struct sec_ctx *ctx,
 				  struct sec_qp_ctx *qp_ctx)
 {
-	struct device *dev = SEC_CTX_DEV(ctx);
 	struct sec_alg_res *res = qp_ctx->res;
+	struct device *dev = ctx->dev;
 	int ret;
 
 	ret = sec_alloc_civ_resource(dev, res);
@@ -360,7 +359,7 @@ static int sec_alg_resource_alloc(struct sec_ctx *ctx,
 static void sec_alg_resource_free(struct sec_ctx *ctx,
 				  struct sec_qp_ctx *qp_ctx)
 {
-	struct device *dev = SEC_CTX_DEV(ctx);
+	struct device *dev = ctx->dev;
 
 	sec_free_civ_resource(dev, qp_ctx->res);
 
@@ -373,7 +372,7 @@ static void sec_alg_resource_free(struct sec_ctx *ctx,
 static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
 			     int qp_ctx_id, int alg_type)
 {
-	struct device *dev = SEC_CTX_DEV(ctx);
+	struct device *dev = ctx->dev;
 	struct sec_qp_ctx *qp_ctx;
 	struct hisi_qp *qp;
 	int ret = -ENOMEM;
@@ -428,7 +427,7 @@ static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
 static void sec_release_qp_ctx(struct sec_ctx *ctx,
 			       struct sec_qp_ctx *qp_ctx)
 {
-	struct device *dev = SEC_CTX_DEV(ctx);
+	struct device *dev = ctx->dev;
 
 	hisi_qm_stop_qp(qp_ctx->qp);
 	sec_alg_resource_free(ctx, qp_ctx);
@@ -452,6 +451,7 @@ static int sec_ctx_base_init(struct sec_ctx *ctx)
 
 	sec = container_of(ctx->qps[0]->qm, struct sec_dev, qm);
 	ctx->sec = sec;
+	ctx->dev = &sec->qm.pdev->dev;
 	ctx->hlf_q_num = sec->ctx_q_num >> 1;
 
 	ctx->pbuf_supported = ctx->sec->iommu_used;
@@ -476,11 +476,9 @@ static int sec_ctx_base_init(struct sec_ctx *ctx)
 err_sec_release_qp_ctx:
 	for (i = i - 1; i >= 0; i--)
 		sec_release_qp_ctx(ctx, &ctx->qp_ctx[i]);
-
 	kfree(ctx->qp_ctx);
 err_destroy_qps:
 	sec_destroy_qps(ctx->qps, sec->ctx_q_num);
-
 	return ret;
 }
 
@@ -499,7 +497,7 @@ static int sec_cipher_init(struct sec_ctx *ctx)
 {
 	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
 
-	c_ctx->c_key = dma_alloc_coherent(SEC_CTX_DEV(ctx), SEC_MAX_KEY_SIZE,
+	c_ctx->c_key = dma_alloc_coherent(ctx->dev, SEC_MAX_KEY_SIZE,
 					  &c_ctx->c_key_dma, GFP_KERNEL);
 	if (!c_ctx->c_key)
 		return -ENOMEM;
@@ -512,7 +510,7 @@ static void sec_cipher_uninit(struct sec_ctx *ctx)
 	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
 
 	memzero_explicit(c_ctx->c_key, SEC_MAX_KEY_SIZE);
-	dma_free_coherent(SEC_CTX_DEV(ctx), SEC_MAX_KEY_SIZE,
+	dma_free_coherent(ctx->dev, SEC_MAX_KEY_SIZE,
 			  c_ctx->c_key, c_ctx->c_key_dma);
 }
 
@@ -520,7 +518,7 @@ static int sec_auth_init(struct sec_ctx *ctx)
 {
 	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
 
-	a_ctx->a_key = dma_alloc_coherent(SEC_CTX_DEV(ctx), SEC_MAX_KEY_SIZE,
+	a_ctx->a_key = dma_alloc_coherent(ctx->dev, SEC_MAX_KEY_SIZE,
 					  &a_ctx->a_key_dma, GFP_KERNEL);
 	if (!a_ctx->a_key)
 		return -ENOMEM;
@@ -533,7 +531,7 @@ static void sec_auth_uninit(struct sec_ctx *ctx)
 	struct sec_auth_ctx *a_ctx = &ctx->a_ctx;
 
 	memzero_explicit(a_ctx->a_key, SEC_MAX_KEY_SIZE);
-	dma_free_coherent(SEC_CTX_DEV(ctx), SEC_MAX_KEY_SIZE,
+	dma_free_coherent(ctx->dev, SEC_MAX_KEY_SIZE,
 			  a_ctx->a_key, a_ctx->a_key_dma);
 }
 
@@ -546,7 +544,7 @@ static int sec_skcipher_init(struct crypto_skcipher *tfm)
 	crypto_skcipher_set_reqsize(tfm, sizeof(struct sec_req));
 	ctx->c_ctx.ivsize = crypto_skcipher_ivsize(tfm);
 	if (ctx->c_ctx.ivsize > SEC_IV_SIZE) {
-		dev_err(SEC_CTX_DEV(ctx), "get error skcipher iv size!\n");
+		pr_err("get error skcipher iv size!\n");
 		return -EINVAL;
 	}
 
@@ -633,12 +631,13 @@ static int sec_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 {
 	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
 	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
+	struct device *dev = ctx->dev;
 	int ret;
 
 	if (c_mode == SEC_CMODE_XTS) {
 		ret = xts_verify_key(tfm, key, keylen);
 		if (ret) {
-			dev_err(SEC_CTX_DEV(ctx), "xts mode key err!\n");
+			dev_err(dev, "xts mode key err!\n");
 			return ret;
 		}
 	}
@@ -659,7 +658,7 @@ static int sec_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
 	}
 
 	if (ret) {
-		dev_err(SEC_CTX_DEV(ctx), "set sec key err!\n");
+		dev_err(dev, "set sec key err!\n");
 		return ret;
 	}
 
@@ -691,7 +690,7 @@ static int sec_cipher_pbuf_map(struct sec_ctx *ctx, struct sec_req *req,
 	struct aead_request *aead_req = req->aead_req.aead_req;
 	struct sec_cipher_req *c_req = &req->c_req;
 	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
-	struct device *dev = SEC_CTX_DEV(ctx);
+	struct device *dev = ctx->dev;
 	int copy_size, pbuf_length;
 	int req_id = req->req_id;
 
@@ -701,9 +700,8 @@ static int sec_cipher_pbuf_map(struct sec_ctx *ctx, struct sec_req *req,
 		copy_size = c_req->c_len;
 
 	pbuf_length = sg_copy_to_buffer(src, sg_nents(src),
-				qp_ctx->res[req_id].pbuf,
-				copy_size);
-
+							qp_ctx->res[req_id].pbuf,
+							copy_size);
 	if (unlikely(pbuf_length != copy_size)) {
 		dev_err(dev, "copy src data to pbuf error!\n");
 		return -EINVAL;
@@ -727,7 +725,7 @@ static void sec_cipher_pbuf_unmap(struct sec_ctx *ctx, struct sec_req *req,
 	struct aead_request *aead_req = req->aead_req.aead_req;
 	struct sec_cipher_req *c_req = &req->c_req;
 	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
-	struct device *dev = SEC_CTX_DEV(ctx);
+	struct device *dev = ctx->dev;
 	int copy_size, pbuf_length;
 	int req_id = req->req_id;
 
@@ -737,11 +735,9 @@ static void sec_cipher_pbuf_unmap(struct sec_ctx *ctx, struct sec_req *req,
 		copy_size = c_req->c_len;
 
 	pbuf_length = sg_copy_from_buffer(dst, sg_nents(dst),
-				qp_ctx->res[req_id].pbuf,
-				copy_size);
-
+			qp_ctx->res[req_id].pbuf, copy_size);
 	if (unlikely(pbuf_length != copy_size))
-		dev_err(dev, "copy pbuf data to dst error!\n");
+		dev_err(ctx->dev, "copy pbuf data to dst error!\n");
 }
 
 static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
@@ -751,7 +747,7 @@ static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
 	struct sec_aead_req *a_req = &req->aead_req;
 	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
 	struct sec_alg_res *res = &qp_ctx->res[req->req_id];
-	struct device *dev = SEC_CTX_DEV(ctx);
+	struct device *dev = ctx->dev;
 	int ret;
 
 	if (req->use_pbuf) {
@@ -806,7 +802,7 @@ static void sec_cipher_unmap(struct sec_ctx *ctx, struct sec_req *req,
 			     struct scatterlist *src, struct scatterlist *dst)
 {
 	struct sec_cipher_req *c_req = &req->c_req;
-	struct device *dev = SEC_CTX_DEV(ctx);
+	struct device *dev = ctx->dev;
 
 	if (req->use_pbuf) {
 		sec_cipher_pbuf_unmap(ctx, req, dst);
@@ -891,6 +887,7 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 {
 	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
 	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
+	struct device *dev = ctx->dev;
 	struct crypto_authenc_keys keys;
 	int ret;
 
@@ -904,13 +901,13 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 
 	ret = sec_aead_aes_set_key(c_ctx, &keys);
 	if (ret) {
-		dev_err(SEC_CTX_DEV(ctx), "set sec cipher key err!\n");
+		dev_err(dev, "set sec cipher key err!\n");
 		goto bad_key;
 	}
 
 	ret = sec_aead_auth_set_key(&ctx->a_ctx, &keys);
 	if (ret) {
-		dev_err(SEC_CTX_DEV(ctx), "set sec auth key err!\n");
+		dev_err(dev, "set sec auth key err!\n");
 		goto bad_key;
 	}
 
@@ -1062,7 +1059,7 @@ static void sec_update_iv(struct sec_req *req, enum sec_alg_type alg_type)
 	sz = sg_pcopy_to_buffer(sgl, sg_nents(sgl), iv, iv_size,
 				cryptlen - iv_size);
 	if (unlikely(sz != iv_size))
-		dev_err(SEC_CTX_DEV(req->ctx), "copy output iv error!\n");
+		dev_err(req->ctx->dev, "copy output iv error!\n");
 }
 
 static struct sec_req *sec_back_req_clear(struct sec_ctx *ctx,
@@ -1160,7 +1157,7 @@ static int sec_aead_bd_fill(struct sec_ctx *ctx, struct sec_req *req)
 
 	ret = sec_skcipher_bd_fill(ctx, req);
 	if (unlikely(ret)) {
-		dev_err(SEC_CTX_DEV(ctx), "skcipher bd fill is error!\n");
+		dev_err(ctx->dev, "skcipher bd fill is error!\n");
 		return ret;
 	}
 
@@ -1194,7 +1191,7 @@ static void sec_aead_callback(struct sec_ctx *c, struct sec_req *req, int err)
 					  a_req->assoclen);
 
 		if (unlikely(sz != authsize)) {
-			dev_err(SEC_CTX_DEV(req->ctx), "copy out mac err!\n");
+			dev_err(c->dev, "copy out mac err!\n");
 			err = -EINVAL;
 		}
 	}
@@ -1259,7 +1256,7 @@ static int sec_process(struct sec_ctx *ctx, struct sec_req *req)
 	ret = ctx->req_op->bd_send(ctx, req);
 	if (unlikely((ret != -EBUSY && ret != -EINPROGRESS) ||
 		(ret == -EBUSY && !(req->flag & CRYPTO_TFM_REQ_MAY_BACKLOG)))) {
-		dev_err_ratelimited(SEC_CTX_DEV(ctx), "send sec request failed!\n");
+		dev_err_ratelimited(ctx->dev, "send sec request failed!\n");
 		goto err_send_req;
 	}
 
@@ -1325,7 +1322,7 @@ static int sec_aead_init(struct crypto_aead *tfm)
 	ctx->alg_type = SEC_AEAD;
 	ctx->c_ctx.ivsize = crypto_aead_ivsize(tfm);
 	if (ctx->c_ctx.ivsize > SEC_IV_SIZE) {
-		dev_err(SEC_CTX_DEV(ctx), "get error aead iv size!\n");
+		dev_err(ctx->dev, "get error aead iv size!\n");
 		return -EINVAL;
 	}
 
@@ -1374,7 +1371,7 @@ static int sec_aead_ctx_init(struct crypto_aead *tfm, const char *hash_name)
 
 	auth_ctx->hash_tfm = crypto_alloc_shash(hash_name, 0, 0);
 	if (IS_ERR(auth_ctx->hash_tfm)) {
-		dev_err(SEC_CTX_DEV(ctx), "aead alloc shash error!\n");
+		dev_err(ctx->dev, "aead alloc shash error!\n");
 		sec_aead_exit(tfm);
 		return PTR_ERR(auth_ctx->hash_tfm);
 	}
@@ -1408,7 +1405,7 @@ static int sec_aead_sha512_ctx_init(struct crypto_aead *tfm)
 static int sec_skcipher_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 {
 	struct skcipher_request *sk_req = sreq->c_req.sk_req;
-	struct device *dev = SEC_CTX_DEV(ctx);
+	struct device *dev = ctx->dev;
 	u8 c_alg = ctx->c_ctx.c_alg;
 
 	if (unlikely(!sk_req->src || !sk_req->dst)) {
@@ -1531,14 +1528,15 @@ static struct skcipher_alg sec_skciphers[] = {
 
 static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 {
-	u8 c_alg = ctx->c_ctx.c_alg;
 	struct aead_request *req = sreq->aead_req.aead_req;
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	size_t authsize = crypto_aead_authsize(tfm);
+	struct device *dev = ctx->dev;
+	u8 c_alg = ctx->c_ctx.c_alg;
 
 	if (unlikely(!req->src || !req->dst || !req->cryptlen ||
 		req->assoclen > SEC_MAX_AAD_LEN)) {
-		dev_err(SEC_CTX_DEV(ctx), "aead input param error!\n");
+		dev_err(dev, "aead input param error!\n");
 		return -EINVAL;
 	}
 
@@ -1550,7 +1548,7 @@ static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 
 	/* Support AES only */
 	if (unlikely(c_alg != SEC_CALG_AES)) {
-		dev_err(SEC_CTX_DEV(ctx), "aead crypto alg error!\n");
+		dev_err(dev, "aead crypto alg error!\n");
 		return -EINVAL;
 	}
 	if (sreq->c_req.encrypt)
@@ -1559,7 +1557,7 @@ static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
 		sreq->c_req.c_len = req->cryptlen - authsize;
 
 	if (unlikely(sreq->c_req.c_len & (AES_BLOCK_SIZE - 1))) {
-		dev_err(SEC_CTX_DEV(ctx), "aead crypto length error!\n");
+		dev_err(dev, "aead crypto length error!\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index b2786e1..1db2ae4 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -64,7 +64,6 @@ enum sec_addr_type {
 };
 
 struct sec_sqe_type2 {
-
 	/*
 	 * mac_len: 0~4 bits
 	 * a_key_len: 5~10 bits
@@ -120,7 +119,6 @@ struct sec_sqe_type2 {
 	/* c_pad_len_field: 0~1 bits */
 	__le16 c_pad_len_field;
 
-
 	__le64 long_a_data_len;
 	__le64 a_ivin_addr;
 	__le64 a_key_addr;
-- 
2.8.1

