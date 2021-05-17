Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2728382AAA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 13:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbhEQLOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 07:14:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3719 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbhEQLOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 07:14:19 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FkGd50Zcbz16QQg;
        Mon, 17 May 2021 19:10:17 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 19:13:01 +0800
Received: from huawei.com (10.67.165.24) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 17 May
 2021 19:13:01 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 2/2] crypto: hisilicon/sec - driver adapt to new SQE
Date:   Mon, 17 May 2021 19:10:00 +0800
Message-ID: <1621249800-11582-3-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621249800-11582-1-git-send-email-yekai13@huawei.com>
References: <1621249800-11582-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to Kunpeng930 adds new SQE data structure, the SEC driver needs
to be upgraded. It mainly includes bd parsing process and bd filling
process.

Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h        |   1 +
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 291 ++++++++++++++++++++++++-----
 drivers/crypto/hisilicon/sec2/sec_crypto.h |   7 +
 3 files changed, 256 insertions(+), 43 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 28679cf..14ba66d 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -140,6 +140,7 @@ struct sec_ctx {
 	bool pbuf_supported;
 	struct sec_cipher_ctx c_ctx;
 	struct sec_auth_ctx a_ctx;
+	u8 type_supported;
 	struct device *dev;
 };
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 133aede..d9ab503 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -37,10 +37,22 @@
 #define SEC_AEAD_ALG_OFFSET     11
 #define SEC_AUTH_OFFSET		6
 
+#define SEC_DE_OFFSET_V3		9
+#define SEC_SCENE_OFFSET_V3	5
+#define SEC_CKEY_OFFSET_V3	13
+#define SEC_SRC_SGL_OFFSET_V3	11
+#define SEC_DST_SGL_OFFSET_V3	14
+#define SEC_CALG_OFFSET_V3	4
+#define SEC_AKEY_OFFSET_V3	9
+#define SEC_MAC_OFFSET_V3	4
+#define SEC_AUTH_ALG_OFFSET_V3	15
+#define SEC_CIPHER_AUTH_V3	0xbf
+#define SEC_AUTH_CIPHER_V3	0x40
 #define SEC_FLAG_OFFSET		7
 #define SEC_FLAG_MASK		0x0780
 #define SEC_TYPE_MASK		0x0F
 #define SEC_DONE_MASK		0x0001
+#define SEC_SQE_LEN_RATE_MASK	0x3
 
 #define SEC_TOTAL_IV_SZ		(SEC_IV_SIZE * QM_Q_DEPTH)
 #define SEC_SGL_SGE_NR		128
@@ -145,44 +157,90 @@ static int sec_aead_verify(struct sec_req *req)
 	return 0;
 }
 
+static u8 pre_parse_finished_bd(struct bd_status *status, void *resp)
+{
+	struct sec_sqe *bd = resp;
+
+	status->done = le16_to_cpu(bd->type2.done_flag) & SEC_DONE_MASK;
+	status->flag = (le16_to_cpu(bd->type2.done_flag) &
+					SEC_FLAG_MASK) >> SEC_FLAG_OFFSET;
+	status->tag = le16_to_cpu(bd->type2.tag);
+	status->err_type = bd->type2.error_type;
+
+	return bd->type_cipher_auth & SEC_TYPE_MASK;
+}
+
+static u8 pre_parse_finished_bd3(struct bd_status *status, void *resp)
+{
+	struct sec_sqe3 *bd3 = resp;
+
+	status->done = le16_to_cpu(bd3->done_flag) & SEC_DONE_MASK;
+	status->flag = (le16_to_cpu(bd3->done_flag) &
+					SEC_FLAG_MASK) >> SEC_FLAG_OFFSET;
+	status->tag = le64_to_cpu(bd3->tag);
+	status->err_type = bd3->error_type;
+
+	return le32_to_cpu(bd3->bd_param) & SEC_TYPE_MASK;
+}
+
+static int sec_cb_status_check(struct sec_req *req,
+			       struct bd_status *status)
+{
+	struct sec_ctx *ctx = req->ctx;
+
+	if (unlikely(req->err_type || status->done != SEC_SQE_DONE)) {
+		dev_err_ratelimited(ctx->dev, "err_type[%d], done[%u]\n",
+				    req->err_type, status->done);
+		return -EIO;
+	}
+
+	if (unlikely(ctx->alg_type == SEC_SKCIPHER)) {
+		if (unlikely(status->flag != SEC_SQE_CFLAG)) {
+			dev_err_ratelimited(ctx->dev, "flag[%u]\n",
+					    status->flag);
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
 static void sec_req_cb(struct hisi_qp *qp, void *resp)
 {
 	struct sec_qp_ctx *qp_ctx = qp->qp_ctx;
 	struct sec_dfx *dfx = &qp_ctx->ctx->sec->debug.dfx;
-	struct sec_sqe *bd = resp;
+	u8 type_supported = qp_ctx->ctx->type_supported;
+	struct bd_status status;
 	struct sec_ctx *ctx;
 	struct sec_req *req;
-	u16 done, flag;
-	int err = 0;
+	int err;
 	u8 type;
 
-	type = bd->type_cipher_auth & SEC_TYPE_MASK;
-	if (unlikely(type != SEC_BD_TYPE2)) {
+	if (type_supported == SEC_BD_TYPE2) {
+		type = pre_parse_finished_bd(&status, resp);
+		req = qp_ctx->req_list[status.tag];
+	} else {
+		type = pre_parse_finished_bd3(&status, resp);
+		req = (void *)(uintptr_t)status.tag;
+	}
+
+	if (unlikely(type != type_supported)) {
 		atomic64_inc(&dfx->err_bd_cnt);
 		pr_err("err bd type [%d]\n", type);
 		return;
 	}
 
-	req = qp_ctx->req_list[le16_to_cpu(bd->type2.tag)];
 	if (unlikely(!req)) {
 		atomic64_inc(&dfx->invalid_req_cnt);
 		atomic_inc(&qp->qp_status.used);
 		return;
 	}
-	req->err_type = bd->type2.error_type;
+
+	req->err_type = status.err_type;
 	ctx = req->ctx;
-	done = le16_to_cpu(bd->type2.done_flag) & SEC_DONE_MASK;
-	flag = (le16_to_cpu(bd->type2.done_flag) &
-		SEC_FLAG_MASK) >> SEC_FLAG_OFFSET;
-	if (unlikely(req->err_type || done != SEC_SQE_DONE ||
-	    (ctx->alg_type == SEC_SKCIPHER && flag != SEC_SQE_CFLAG) ||
-	    (ctx->alg_type == SEC_AEAD && flag != SEC_SQE_AEAD_FLAG))) {
-		dev_err_ratelimited(ctx->dev,
-			"err_type[%d],done[%d],flag[%d]\n",
-			req->err_type, done, flag);
-		err = -EIO;
+	err = sec_cb_status_check(req, &status);
+	if (err)
 		atomic64_inc(&dfx->done_flag_cnt);
-	}
 
 	if (ctx->alg_type == SEC_AEAD && !req->c_req.encrypt)
 		err = sec_aead_verify(req);
@@ -382,10 +440,11 @@ static int sec_create_qp_ctx(struct hisi_qm *qm, struct sec_ctx *ctx,
 	qp = ctx->qps[qp_ctx_id];
 	qp->req_type = 0;
 	qp->qp_ctx = qp_ctx;
-	qp->req_cb = sec_req_cb;
 	qp_ctx->qp = qp;
 	qp_ctx->ctx = ctx;
 
+	qp->req_cb = sec_req_cb;
+
 	mutex_init(&qp_ctx->req_lock);
 	idr_init(&qp_ctx->req_idr);
 	INIT_LIST_HEAD(&qp_ctx->backlog);
@@ -615,19 +674,25 @@ static int sec_skcipher_aes_sm4_setkey(struct sec_cipher_ctx *c_ctx,
 			return -EINVAL;
 		}
 	} else {
-		switch (keylen) {
-		case AES_KEYSIZE_128:
-			c_ctx->c_key_len = SEC_CKEY_128BIT;
-			break;
-		case AES_KEYSIZE_192:
-			c_ctx->c_key_len = SEC_CKEY_192BIT;
-			break;
-		case AES_KEYSIZE_256:
-			c_ctx->c_key_len = SEC_CKEY_256BIT;
-			break;
-		default:
-			pr_err("hisi_sec2: aes key error!\n");
+		if (c_ctx->c_alg == SEC_CALG_SM4 &&
+		    keylen != AES_KEYSIZE_128) {
+			pr_err("hisi_sec2: sm4 key error!\n");
 			return -EINVAL;
+		} else {
+			switch (keylen) {
+			case AES_KEYSIZE_128:
+				c_ctx->c_key_len = SEC_CKEY_128BIT;
+				break;
+			case AES_KEYSIZE_192:
+				c_ctx->c_key_len = SEC_CKEY_192BIT;
+				break;
+			case AES_KEYSIZE_256:
+				c_ctx->c_key_len = SEC_CKEY_256BIT;
+				break;
+			default:
+				pr_err("hisi_sec2: aes key error!\n");
+				return -EINVAL;
+			}
 		}
 	}
 
@@ -915,6 +980,12 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 		goto bad_key;
 	}
 
+	if ((ctx->a_ctx.mac_len & SEC_SQE_LEN_RATE_MASK)  ||
+	    (ctx->a_ctx.a_key_len & SEC_SQE_LEN_RATE_MASK)) {
+		dev_err(dev, "MAC or AUTH key length error!\n");
+		goto bad_key;
+	}
+
 	return 0;
 
 bad_key:
@@ -1014,29 +1085,75 @@ static int sec_skcipher_bd_fill(struct sec_ctx *ctx, struct sec_req *req)
 		cipher = SEC_CIPHER_DEC << SEC_CIPHER_OFFSET;
 	sec_sqe->type_cipher_auth = bd_type | cipher;
 
-	if (req->use_pbuf)
+	/* Set destination and source address type */
+	if (req->use_pbuf) {
 		sa_type = SEC_PBUF << SEC_SRC_SGL_OFFSET;
-	else
+		da_type = SEC_PBUF << SEC_DST_SGL_OFFSET;
+	} else {
 		sa_type = SEC_SGL << SEC_SRC_SGL_OFFSET;
+		da_type = SEC_SGL << SEC_DST_SGL_OFFSET;
+	}
+
+	sec_sqe->sdm_addr_type |= da_type;
 	scene = SEC_COMM_SCENE << SEC_SCENE_OFFSET;
 	if (c_req->c_in_dma != c_req->c_out_dma)
 		de = 0x1 << SEC_DE_OFFSET;
 
 	sec_sqe->sds_sa_type = (de | scene | sa_type);
 
-	/* Just set DST address type */
-	if (req->use_pbuf)
-		da_type = SEC_PBUF << SEC_DST_SGL_OFFSET;
-	else
-		da_type = SEC_SGL << SEC_DST_SGL_OFFSET;
-	sec_sqe->sdm_addr_type |= da_type;
-
 	sec_sqe->type2.clen_ivhlen |= cpu_to_le32(c_req->c_len);
 	sec_sqe->type2.tag = cpu_to_le16((u16)req->req_id);
 
 	return 0;
 }
 
+static int sec_skcipher_bd_fill_v3(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct sec_sqe3 *sec_sqe3 = &req->sec_sqe3;
+	struct sec_cipher_ctx *c_ctx = &ctx->c_ctx;
+	struct sec_cipher_req *c_req = &req->c_req;
+	u32 bd_param = 0;
+	u16 cipher;
+
+	memset(sec_sqe3, 0, sizeof(struct sec_sqe3));
+
+	sec_sqe3->c_key_addr = cpu_to_le64(c_ctx->c_key_dma);
+	sec_sqe3->no_scene.c_ivin_addr = cpu_to_le64(c_req->c_ivin_dma);
+	sec_sqe3->data_src_addr = cpu_to_le64(c_req->c_in_dma);
+	sec_sqe3->data_dst_addr = cpu_to_le64(c_req->c_out_dma);
+
+	sec_sqe3->c_mode_alg = ((u8)c_ctx->c_alg << SEC_CALG_OFFSET_V3) |
+						c_ctx->c_mode;
+	sec_sqe3->c_icv_key |= cpu_to_le16(((u16)c_ctx->c_key_len) <<
+						SEC_CKEY_OFFSET_V3);
+
+	if (c_req->encrypt)
+		cipher = SEC_CIPHER_ENC;
+	else
+		cipher = SEC_CIPHER_DEC;
+	sec_sqe3->c_icv_key |= cpu_to_le16(cipher);
+
+	if (req->use_pbuf) {
+		bd_param |= SEC_PBUF << SEC_SRC_SGL_OFFSET_V3;
+		bd_param |= SEC_PBUF << SEC_DST_SGL_OFFSET_V3;
+	} else {
+		bd_param |= SEC_SGL << SEC_SRC_SGL_OFFSET_V3;
+		bd_param |= SEC_SGL << SEC_DST_SGL_OFFSET_V3;
+	}
+
+	bd_param |= SEC_COMM_SCENE << SEC_SCENE_OFFSET_V3;
+	if (c_req->c_in_dma != c_req->c_out_dma)
+		bd_param |= 0x1 << SEC_DE_OFFSET_V3;
+
+	bd_param |= SEC_BD_TYPE3;
+	sec_sqe3->bd_param = cpu_to_le32(bd_param);
+
+	sec_sqe3->c_len_ivin |= cpu_to_le32(c_req->c_len);
+	sec_sqe3->tag = cpu_to_le64(req);
+
+	return 0;
+}
+
 static void sec_update_iv(struct sec_req *req, enum sec_alg_type alg_type)
 {
 	struct aead_request *aead_req = req->aead_req.aead_req;
@@ -1170,6 +1287,57 @@ static int sec_aead_bd_fill(struct sec_ctx *ctx, struct sec_req *req)
 	return 0;
 }
 
+static void sec_auth_bd_fill_ex_v3(struct sec_auth_ctx *ctx, int dir,
+				   struct sec_req *req, struct sec_sqe3 *sqe3)
+{
+	struct sec_aead_req *a_req = &req->aead_req;
+	struct sec_cipher_req *c_req = &req->c_req;
+	struct aead_request *aq = a_req->aead_req;
+
+	sqe3->a_key_addr = cpu_to_le64(ctx->a_key_dma);
+
+	sqe3->auth_mac_key |=
+			cpu_to_le32((u32)(ctx->mac_len /
+			SEC_SQE_LEN_RATE) << SEC_MAC_OFFSET_V3);
+
+	sqe3->auth_mac_key |=
+			cpu_to_le32((u32)(ctx->a_key_len /
+			SEC_SQE_LEN_RATE) << SEC_AKEY_OFFSET_V3);
+
+	sqe3->auth_mac_key |=
+			cpu_to_le32((u32)(ctx->a_alg) << SEC_AUTH_ALG_OFFSET_V3);
+
+	if (dir) {
+		sqe3->auth_mac_key |= SEC_AUTH_TYPE1;
+		sqe3->huk_iv_seq &= SEC_CIPHER_AUTH_V3;
+	} else {
+		sqe3->auth_mac_key |= SEC_AUTH_TYPE2;
+		sqe3->huk_iv_seq |= SEC_AUTH_CIPHER_V3;
+	}
+	sqe3->a_len_key = cpu_to_le32(c_req->c_len + aq->assoclen);
+
+	sqe3->cipher_src_offset = cpu_to_le16((u16)aq->assoclen);
+
+	sqe3->mac_addr = cpu_to_le64(a_req->out_mac_dma);
+}
+
+static int sec_aead_bd_fill_v3(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct sec_auth_ctx *auth_ctx = &ctx->a_ctx;
+	struct sec_sqe3 *sec_sqe3 = &req->sec_sqe3;
+	int ret;
+
+	ret = sec_skcipher_bd_fill_v3(ctx, req);
+	if (unlikely(ret)) {
+		dev_err(ctx->dev, "skcipher bd3 fill is error!\n");
+		return ret;
+	}
+
+	sec_auth_bd_fill_ex_v3(auth_ctx, req->c_req.encrypt, req, sec_sqe3);
+
+	return 0;
+}
+
 static void sec_aead_callback(struct sec_ctx *c, struct sec_req *req, int err)
 {
 	struct aead_request *a_req = req->aead_req.aead_req;
@@ -1303,13 +1471,44 @@ static const struct sec_req_op sec_aead_req_ops = {
 	.process	= sec_process,
 };
 
+static const struct sec_req_op sec_skcipher_req_ops_v3 = {
+	.buf_map	= sec_skcipher_sgl_map,
+	.buf_unmap	= sec_skcipher_sgl_unmap,
+	.do_transfer	= sec_skcipher_copy_iv,
+	.bd_fill	= sec_skcipher_bd_fill_v3,
+	.bd_send	= sec_bd_send,
+	.callback	= sec_skcipher_callback,
+	.process	= sec_process,
+};
+
+static const struct sec_req_op sec_aead_req_ops_v3 = {
+	.buf_map	= sec_aead_sgl_map,
+	.buf_unmap	= sec_aead_sgl_unmap,
+	.do_transfer	= sec_aead_copy_iv,
+	.bd_fill	= sec_aead_bd_fill_v3,
+	.bd_send	= sec_bd_send,
+	.callback	= sec_aead_callback,
+	.process	= sec_process,
+};
+
 static int sec_skcipher_ctx_init(struct crypto_skcipher *tfm)
 {
 	struct sec_ctx *ctx = crypto_skcipher_ctx(tfm);
+	int ret;
 
-	ctx->req_op = &sec_skcipher_req_ops;
+	ret = sec_skcipher_init(tfm);
+	if (ret)
+		return ret;
+
+	if (ctx->sec->qm.ver < QM_HW_V3) {
+		ctx->type_supported = SEC_BD_TYPE2;
+		ctx->req_op = &sec_skcipher_req_ops;
+	} else {
+		ctx->type_supported = SEC_BD_TYPE3;
+		ctx->req_op = &sec_skcipher_req_ops_v3;
+	}
 
-	return sec_skcipher_init(tfm);
+	return ret;
 }
 
 static void sec_skcipher_ctx_exit(struct crypto_skcipher *tfm)
@@ -1330,10 +1529,16 @@ static int sec_aead_init(struct crypto_aead *tfm)
 		return -EINVAL;
 	}
 
-	ctx->req_op = &sec_aead_req_ops;
 	ret = sec_ctx_base_init(ctx);
 	if (ret)
 		return ret;
+	if (ctx->sec->qm.ver < QM_HW_V3) {
+		ctx->type_supported = SEC_BD_TYPE2;
+		ctx->req_op = &sec_aead_req_ops;
+	} else {
+		ctx->type_supported = SEC_BD_TYPE3;
+		ctx->req_op = &sec_aead_req_ops_v3;
+	}
 
 	ret = sec_auth_init(ctx);
 	if (ret)
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index 3b64e17..163e813 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -64,6 +64,13 @@ enum sec_addr_type {
 	SEC_PRP  = 0x2,
 };
 
+struct bd_status {
+	u64 tag;
+	u8 done;
+	u8 err_type;
+	u16 flag;
+};
+
 enum {
 	AUTHPAD_PAD,
 	AUTHPAD_NOPAD,
-- 
2.8.1

