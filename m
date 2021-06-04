Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA1B39AFC2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFDBdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:33:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:7100 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhFDBd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:33:29 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fx4t04f1tzYpXC;
        Fri,  4 Jun 2021 09:28:56 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
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
Subject: [PATCH 1/4] crypto: hisilicon/sec - add new algorithm mode for AEAD
Date:   Fri, 4 Jun 2021 09:31:26 +0800
Message-ID: <1622770289-21588-2-git-send-email-yekai13@huawei.com>
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

Add new algorithm mode for AEAD:
CCM(AES), GCM(AES), CCM(SM4), GCM(SM4).

Signed-off-by: Kai Ye <yekai13@huawei.com>
Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/crypto/hisilicon/sec2/sec.h        |   4 +
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 367 ++++++++++++++++++++++++++---
 drivers/crypto/hisilicon/sec2/sec_crypto.h |   8 +
 3 files changed, 345 insertions(+), 34 deletions(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
index 935d8d9..2960fae 100644
--- a/drivers/crypto/hisilicon/sec2/sec.h
+++ b/drivers/crypto/hisilicon/sec2/sec.h
@@ -13,6 +13,8 @@ struct sec_alg_res {
 	dma_addr_t pbuf_dma;
 	u8 *c_ivin;
 	dma_addr_t c_ivin_dma;
+	u8 *a_ivin;
+	dma_addr_t a_ivin_dma;
 	u8 *out_mac;
 	dma_addr_t out_mac_dma;
 };
@@ -33,6 +35,8 @@ struct sec_cipher_req {
 struct sec_aead_req {
 	u8 *out_mac;
 	dma_addr_t out_mac_dma;
+	u8 *a_ivin;
+	dma_addr_t a_ivin_dma;
 	struct aead_request *aead_req;
 };
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
index 5926b64..f2ab9ff 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
@@ -79,10 +79,24 @@
 #define SEC_SQE_CFLAG		2
 #define SEC_SQE_AEAD_FLAG	3
 #define SEC_SQE_DONE		0x1
+#define MIN_MAC_LEN		4
+#define MAC_LEN_MASK		0x1U
 #define MAX_INPUT_DATA_LEN	0xFFFE00
 #define BITS_MASK		0xFF
 #define BYTE_BITS		0x8
 #define SEC_XTS_NAME_SZ		0x3
+#define IV_CM_CAL_NUM		2
+#define IV_CL_MASK		0x7
+#define IV_CL_MIN		2
+#define IV_CL_MID		4
+#define IV_CL_MAX		8
+#define IV_FLAGS_OFFSET	0x6
+#define IV_CM_OFFSET		0x3
+#define IV_LAST_BYTE1		1
+#define IV_LAST_BYTE2		2
+#define IV_LAST_BYTE_MASK	0xFF
+#define IV_CTR_INIT		0x1
+#define IV_BYTE_OFFSET		0x8
 
 /* Get an en/de-cipher queue cyclically to balance load over queues of TFM */
 static inline int sec_alloc_queue_id(struct sec_ctx *ctx, struct sec_req *req)
@@ -316,6 +330,30 @@ static void sec_free_civ_resource(struct device *dev, struct sec_alg_res *res)
 				  res->c_ivin, res->c_ivin_dma);
 }
 
+static int sec_alloc_aiv_resource(struct device *dev, struct sec_alg_res *res)
+{
+	int i;
+
+	res->a_ivin = dma_alloc_coherent(dev, SEC_TOTAL_IV_SZ,
+					 &res->a_ivin_dma, GFP_KERNEL);
+	if (!res->a_ivin)
+		return -ENOMEM;
+
+	for (i = 1; i < QM_Q_DEPTH; i++) {
+		res[i].a_ivin_dma = res->a_ivin_dma + i * SEC_IV_SIZE;
+		res[i].a_ivin = res->a_ivin + i * SEC_IV_SIZE;
+	}
+
+	return 0;
+}
+
+static void sec_free_aiv_resource(struct device *dev, struct sec_alg_res *res)
+{
+	if (res->a_ivin)
+		dma_free_coherent(dev, SEC_TOTAL_IV_SZ,
+				  res->a_ivin, res->a_ivin_dma);
+}
+
 static int sec_alloc_mac_resource(struct device *dev, struct sec_alg_res *res)
 {
 	int i;
@@ -398,9 +436,13 @@ static int sec_alg_resource_alloc(struct sec_ctx *ctx,
 		return ret;
 
 	if (ctx->alg_type == SEC_AEAD) {
+		ret = sec_alloc_aiv_resource(dev, res);
+		if (ret)
+			goto alloc_aiv_fail;
+
 		ret = sec_alloc_mac_resource(dev, res);
 		if (ret)
-			goto alloc_fail;
+			goto alloc_mac_fail;
 	}
 	if (ctx->pbuf_supported) {
 		ret = sec_alloc_pbuf_resource(dev, res);
@@ -415,7 +457,10 @@ static int sec_alg_resource_alloc(struct sec_ctx *ctx,
 alloc_pbuf_fail:
 	if (ctx->alg_type == SEC_AEAD)
 		sec_free_mac_resource(dev, qp_ctx->res);
-alloc_fail:
+alloc_mac_fail:
+	if (ctx->alg_type == SEC_AEAD)
+		sec_free_aiv_resource(dev, res);
+alloc_aiv_fail:
 	sec_free_civ_resource(dev, res);
 	return ret;
 }
@@ -871,6 +916,8 @@ static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
 		c_req->c_ivin = res->pbuf + SEC_PBUF_IV_OFFSET;
 		c_req->c_ivin_dma = res->pbuf_dma + SEC_PBUF_IV_OFFSET;
 		if (ctx->alg_type == SEC_AEAD) {
+			a_req->a_ivin = res->a_ivin;
+			a_req->a_ivin_dma = res->a_ivin_dma;
 			a_req->out_mac = res->pbuf + SEC_PBUF_MAC_OFFSET;
 			a_req->out_mac_dma = res->pbuf_dma +
 					SEC_PBUF_MAC_OFFSET;
@@ -881,6 +928,8 @@ static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
 	c_req->c_ivin = res->c_ivin;
 	c_req->c_ivin_dma = res->c_ivin_dma;
 	if (ctx->alg_type == SEC_AEAD) {
+		a_req->a_ivin = res->a_ivin;
+		a_req->a_ivin_dma = res->a_ivin_dma;
 		a_req->out_mac = res->out_mac;
 		a_req->out_mac_dma = res->out_mac_dma;
 	}
@@ -1012,6 +1061,17 @@ static int sec_aead_setkey(struct crypto_aead *tfm, const u8 *key,
 	ctx->a_ctx.mac_len = mac_len;
 	c_ctx->c_mode = c_mode;
 
+	if (c_mode == SEC_CMODE_CCM || c_mode == SEC_CMODE_GCM) {
+		ret = sec_skcipher_aes_sm4_setkey(c_ctx, keylen, c_mode);
+		if (ret) {
+			dev_err(dev, "set sec aes ccm cipher key err!\n");
+			return ret;
+		}
+		memcpy(c_ctx->c_key, key, keylen);
+
+		return 0;
+	}
+
 	if (crypto_authenc_extractkeys(&keys, key, keylen))
 		goto bad_key;
 
@@ -1054,6 +1114,14 @@ GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha256, SEC_A_HMAC_SHA256,
 			 SEC_CALG_AES, SEC_HMAC_SHA256_MAC, SEC_CMODE_CBC)
 GEN_SEC_AEAD_SETKEY_FUNC(aes_cbc_sha512, SEC_A_HMAC_SHA512,
 			 SEC_CALG_AES, SEC_HMAC_SHA512_MAC, SEC_CMODE_CBC)
+GEN_SEC_AEAD_SETKEY_FUNC(aes_ccm, 0, SEC_CALG_AES,
+			 SEC_HMAC_CCM_MAC, SEC_CMODE_CCM)
+GEN_SEC_AEAD_SETKEY_FUNC(aes_gcm, 0, SEC_CALG_AES,
+			 SEC_HMAC_GCM_MAC, SEC_CMODE_GCM)
+GEN_SEC_AEAD_SETKEY_FUNC(sm4_ccm, 0, SEC_CALG_SM4,
+			 SEC_HMAC_CCM_MAC, SEC_CMODE_CCM)
+GEN_SEC_AEAD_SETKEY_FUNC(sm4_gcm, 0, SEC_CALG_SM4,
+			 SEC_HMAC_GCM_MAC, SEC_CMODE_GCM)
 
 static int sec_aead_sgl_map(struct sec_ctx *ctx, struct sec_req *req)
 {
@@ -1295,12 +1363,125 @@ static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req,
 	sk_req->base.complete(&sk_req->base, err);
 }
 
-static void sec_aead_copy_iv(struct sec_ctx *ctx, struct sec_req *req)
+static void set_aead_auth_iv(struct sec_ctx *ctx, struct sec_req *req)
 {
 	struct aead_request *aead_req = req->aead_req.aead_req;
 	struct sec_cipher_req *c_req = &req->c_req;
+	struct sec_aead_req *a_req = &req->aead_req;
+	size_t authsize = ctx->a_ctx.mac_len;
+	u32 data_size = aead_req->cryptlen;
+	u8 flage = 0;
+	u8 cm, cl;
+
+	/* the specification has been checked in aead_iv_demension_check() */
+	cl = c_req->c_ivin[0] + 1;
+	c_req->c_ivin[ctx->c_ctx.ivsize - cl] = 0x00;
+	memset(&c_req->c_ivin[ctx->c_ctx.ivsize - cl], 0, cl);
+	c_req->c_ivin[ctx->c_ctx.ivsize - IV_LAST_BYTE1] = IV_CTR_INIT;
+
+	/* the last 3bit is L' */
+	flage |= c_req->c_ivin[0] & IV_CL_MASK;
+
+	/* the M' is bit3~bit5, the Flags is bit6 */
+	cm = (authsize - IV_CM_CAL_NUM) / IV_CM_CAL_NUM;
+	flage |= cm << IV_CM_OFFSET;
+	if (aead_req->assoclen)
+		flage |= 0x01 << IV_FLAGS_OFFSET;
+
+	memcpy(a_req->a_ivin, c_req->c_ivin, ctx->c_ctx.ivsize);
+	a_req->a_ivin[0] = flage;
+
+	/*
+	 * the last 32bit is counter's initial number,
+	 * but the nonce uses the first 16bit
+	 * the tail 16bit fill with the cipher length
+	 */
+	if (!c_req->encrypt)
+		data_size = aead_req->cryptlen - authsize;
+
+	a_req->a_ivin[ctx->c_ctx.ivsize - IV_LAST_BYTE1] =
+			data_size & IV_LAST_BYTE_MASK;
+	data_size >>= IV_BYTE_OFFSET;
+	a_req->a_ivin[ctx->c_ctx.ivsize - IV_LAST_BYTE2] =
+			data_size & IV_LAST_BYTE_MASK;
+}
+
+static void sec_aead_set_iv(struct sec_ctx *ctx, struct sec_req *req)
+{
+	struct aead_request *aead_req = req->aead_req.aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
+	size_t authsize = crypto_aead_authsize(tfm);
+	struct sec_cipher_req *c_req = &req->c_req;
+	struct sec_aead_req *a_req = &req->aead_req;
 
 	memcpy(c_req->c_ivin, aead_req->iv, ctx->c_ctx.ivsize);
+
+	if (ctx->c_ctx.c_mode == SEC_CMODE_CCM) {
+		/*
+		 * CCM 16Byte Cipher_IV: {1B_Flage,13B_IV,2B_counter},
+		 * the  counter must set to 0x01
+		 */
+		ctx->a_ctx.mac_len = authsize;
+		/* CCM 16Byte Auth_IV: {1B_AFlage,13B_IV,2B_Ptext_length} */
+		set_aead_auth_iv(ctx, req);
+	}
+
+	/* GCM 12Byte Cipher_IV == Auth_IV */
+	if (ctx->c_ctx.c_mode == SEC_CMODE_GCM) {
+		ctx->a_ctx.mac_len = authsize;
+		memcpy(a_req->a_ivin, c_req->c_ivin, SEC_AIV_SIZE);
+	}
+}
+
+static void sec_auth_bd_fill_xcm(struct sec_auth_ctx *ctx, int dir,
+				 struct sec_req *req, struct sec_sqe *sec_sqe)
+{
+	struct sec_aead_req *a_req = &req->aead_req;
+	struct aead_request *aq = a_req->aead_req;
+
+	/* C_ICV_Len is MAC size, 0x4 ~ 0x10 */
+	sec_sqe->type2.icvw_kmode |= cpu_to_le16((u16)ctx->mac_len);
+
+	/* mode set to CCM/GCM, don't set {A_Alg, AKey_Len, MAC_Len} */
+	sec_sqe->type2.a_key_addr = sec_sqe->type2.c_key_addr;
+	sec_sqe->type2.a_ivin_addr = cpu_to_le64(a_req->a_ivin_dma);
+	sec_sqe->type_cipher_auth |= SEC_NO_AUTH << SEC_AUTH_OFFSET;
+
+	if (dir)
+		sec_sqe->sds_sa_type &= SEC_CIPHER_AUTH;
+	else
+		sec_sqe->sds_sa_type |= SEC_AUTH_CIPHER;
+
+	sec_sqe->type2.alen_ivllen = cpu_to_le32(aq->assoclen);
+	sec_sqe->type2.auth_src_offset = cpu_to_le16(0x0);
+	sec_sqe->type2.cipher_src_offset = cpu_to_le16((u16)aq->assoclen);
+
+	sec_sqe->type2.mac_addr = cpu_to_le64(a_req->out_mac_dma);
+}
+
+static void sec_auth_bd_fill_xcm_v3(struct sec_auth_ctx *ctx, int dir,
+				    struct sec_req *req, struct sec_sqe3 *sqe3)
+{
+	struct sec_aead_req *a_req = &req->aead_req;
+	struct aead_request *aq = a_req->aead_req;
+
+	/* C_ICV_Len is MAC size, 0x4 ~ 0x10 */
+	sqe3->c_icv_key |= cpu_to_le16((u16)ctx->mac_len << SEC_MAC_OFFSET_V3);
+
+	/* mode set to CCM/GCM, don't set {A_Alg, AKey_Len, MAC_Len} */
+	sqe3->a_key_addr = sqe3->c_key_addr;
+	sqe3->auth_ivin.a_ivin_addr = cpu_to_le64(a_req->a_ivin_dma);
+	sqe3->auth_mac_key |= SEC_NO_AUTH;
+
+	if (dir)
+		sqe3->huk_iv_seq &= SEC_CIPHER_AUTH_V3;
+	else
+		sqe3->huk_iv_seq |= SEC_AUTH_CIPHER_V3;
+
+	sqe3->a_len_key = cpu_to_le32(aq->assoclen);
+	sqe3->auth_src_offset = cpu_to_le16(0x0);
+	sqe3->cipher_src_offset = cpu_to_le16((u16)aq->assoclen);
+	sqe3->mac_addr = cpu_to_le64(a_req->out_mac_dma);
 }
 
 static void sec_auth_bd_fill_ex(struct sec_auth_ctx *ctx, int dir,
@@ -1348,7 +1529,11 @@ static int sec_aead_bd_fill(struct sec_ctx *ctx, struct sec_req *req)
 		return ret;
 	}
 
-	sec_auth_bd_fill_ex(auth_ctx, req->c_req.encrypt, req, sec_sqe);
+	if (ctx->c_ctx.c_mode == SEC_CMODE_CCM ||
+	    ctx->c_ctx.c_mode == SEC_CMODE_GCM)
+		sec_auth_bd_fill_xcm(auth_ctx, req->c_req.encrypt, req, sec_sqe);
+	else
+		sec_auth_bd_fill_ex(auth_ctx, req->c_req.encrypt, req, sec_sqe);
 
 	return 0;
 }
@@ -1399,7 +1584,13 @@ static int sec_aead_bd_fill_v3(struct sec_ctx *ctx, struct sec_req *req)
 		return ret;
 	}
 
-	sec_auth_bd_fill_ex_v3(auth_ctx, req->c_req.encrypt, req, sec_sqe3);
+	if (ctx->c_ctx.c_mode == SEC_CMODE_CCM ||
+	    ctx->c_ctx.c_mode == SEC_CMODE_GCM)
+		sec_auth_bd_fill_xcm_v3(auth_ctx, req->c_req.encrypt,
+					req, sec_sqe3);
+	else
+		sec_auth_bd_fill_ex_v3(auth_ctx, req->c_req.encrypt,
+				       req, sec_sqe3);
 
 	return 0;
 }
@@ -1531,7 +1722,7 @@ static const struct sec_req_op sec_skcipher_req_ops = {
 static const struct sec_req_op sec_aead_req_ops = {
 	.buf_map	= sec_aead_sgl_map,
 	.buf_unmap	= sec_aead_sgl_unmap,
-	.do_transfer	= sec_aead_copy_iv,
+	.do_transfer	= sec_aead_set_iv,
 	.bd_fill	= sec_aead_bd_fill,
 	.bd_send	= sec_bd_send,
 	.callback	= sec_aead_callback,
@@ -1551,7 +1742,7 @@ static const struct sec_req_op sec_skcipher_req_ops_v3 = {
 static const struct sec_req_op sec_aead_req_ops_v3 = {
 	.buf_map	= sec_aead_sgl_map,
 	.buf_unmap	= sec_aead_sgl_unmap,
-	.do_transfer	= sec_aead_copy_iv,
+	.do_transfer	= sec_aead_set_iv,
 	.bd_fill	= sec_aead_bd_fill_v3,
 	.bd_send	= sec_bd_send,
 	.callback	= sec_aead_callback,
@@ -1591,8 +1782,9 @@ static int sec_aead_init(struct crypto_aead *tfm)
 	crypto_aead_set_reqsize(tfm, sizeof(struct sec_req));
 	ctx->alg_type = SEC_AEAD;
 	ctx->c_ctx.ivsize = crypto_aead_ivsize(tfm);
-	if (ctx->c_ctx.ivsize > SEC_IV_SIZE) {
-		dev_err(ctx->dev, "get error aead iv size!\n");
+	if (ctx->c_ctx.ivsize < SEC_AIV_SIZE ||
+	    ctx->c_ctx.ivsize > SEC_IV_SIZE) {
+		pr_err("get error aead iv size!\n");
 		return -EINVAL;
 	}
 
@@ -1663,6 +1855,25 @@ static void sec_aead_ctx_exit(struct crypto_aead *tfm)
 	sec_aead_exit(tfm);
 }
 
+static int sec_aead_xcm_ctx_init(struct crypto_aead *tfm)
+{
+	struct sec_ctx *ctx = crypto_aead_ctx(tfm);
+	int ret;
+
+	ret = sec_aead_init(tfm);
+	if (ret) {
+		dev_err(ctx->dev, "hisi_sec2: aead xcm init error!\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void sec_aead_xcm_ctx_exit(struct crypto_aead *tfm)
+{
+	sec_aead_exit(tfm);
+}
+
 static int sec_aead_sha1_ctx_init(struct crypto_aead *tfm)
 {
 	return sec_aead_ctx_init(tfm, "sha1");
@@ -1903,41 +2114,100 @@ static struct skcipher_alg sec_skciphers_v3[] = {
 			 SEC_MIN_BLOCK_SZ, AES_BLOCK_SIZE)
 };
 
-static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
+static int aead_iv_demension_check(struct aead_request *aead_req)
+{
+	u8 cl;
+
+	cl = aead_req->iv[0] + 1;
+	if (cl < IV_CL_MIN || cl > IV_CL_MAX)
+		return -EINVAL;
+
+	if (cl < IV_CL_MID && aead_req->cryptlen >> (BYTE_BITS * cl))
+		return -EOVERFLOW;
+
+	return 0;
+}
+
+static int sec_aead_spec_check(struct sec_ctx *ctx, struct sec_req *sreq)
 {
 	struct aead_request *req = sreq->aead_req.aead_req;
 	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
 	size_t authsize = crypto_aead_authsize(tfm);
+	u8 c_mode = ctx->c_ctx.c_mode;
 	struct device *dev = ctx->dev;
-	u8 c_alg = ctx->c_ctx.c_alg;
+	int ret;
 
-	if (unlikely(!req->src || !req->dst || !req->cryptlen ||
-		req->assoclen > SEC_MAX_AAD_LEN)) {
-		dev_err(dev, "aead input param error!\n");
+	if (unlikely(req->cryptlen + req->assoclen > MAX_INPUT_DATA_LEN ||
+	    req->assoclen > SEC_MAX_AAD_LEN)) {
+		dev_err(dev, "aead input spec error!\n");
 		return -EINVAL;
 	}
 
-	if (ctx->pbuf_supported && (req->cryptlen + req->assoclen) <=
-		SEC_PBUF_SZ)
-		sreq->use_pbuf = true;
-	else
-		sreq->use_pbuf = false;
-
-	/* Support AES only */
-	if (unlikely(c_alg != SEC_CALG_AES)) {
-		dev_err(dev, "aead crypto alg error!\n");
+	if (unlikely((c_mode == SEC_CMODE_GCM && authsize < DES_BLOCK_SIZE) ||
+	   (c_mode == SEC_CMODE_CCM && (authsize < MIN_MAC_LEN ||
+		authsize & MAC_LEN_MASK)))) {
+		dev_err(dev, "aead input mac length error!\n");
 		return -EINVAL;
 	}
+
+	if (c_mode == SEC_CMODE_CCM) {
+		ret = aead_iv_demension_check(req);
+		if (ret) {
+			dev_err(dev, "aead input iv param error!\n");
+			return ret;
+		}
+	}
+
 	if (sreq->c_req.encrypt)
 		sreq->c_req.c_len = req->cryptlen;
 	else
 		sreq->c_req.c_len = req->cryptlen - authsize;
+	if (c_mode == SEC_CMODE_CBC) {
+		if (unlikely(sreq->c_req.c_len & (AES_BLOCK_SIZE - 1))) {
+			dev_err(dev, "aead crypto length error!\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
 
-	if (unlikely(sreq->c_req.c_len & (AES_BLOCK_SIZE - 1))) {
-		dev_err(dev, "aead crypto length error!\n");
+static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
+{
+	struct aead_request *req = sreq->aead_req.aead_req;
+	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
+	size_t authsize = crypto_aead_authsize(tfm);
+	struct device *dev = ctx->dev;
+	u8 c_alg = ctx->c_ctx.c_alg;
+
+	if (unlikely(!req->src || !req->dst)) {
+		dev_err(dev, "aead input param error!\n");
 		return -EINVAL;
 	}
 
+	if (ctx->sec->qm.ver == QM_HW_V2) {
+		if (unlikely(!req->cryptlen || (!sreq->c_req.encrypt &&
+		    req->cryptlen <= authsize))) {
+			dev_err(dev, "Kunpeng920 not support 0 length!\n");
+			return -EINVAL;
+		}
+	}
+
+	/* Support AES or SM4 */
+	if (unlikely(c_alg != SEC_CALG_AES && c_alg != SEC_CALG_SM4)) {
+		dev_err(dev, "aead crypto alg error!\n");
+		return -EINVAL;
+	}
+
+	if (unlikely(sec_aead_spec_check(ctx, sreq)))
+		return -EINVAL;
+
+	if (ctx->pbuf_supported && (req->cryptlen + req->assoclen) <=
+		SEC_PBUF_SZ)
+		sreq->use_pbuf = true;
+	else
+		sreq->use_pbuf = false;
+
 	return 0;
 }
 
@@ -1970,7 +2240,7 @@ static int sec_aead_decrypt(struct aead_request *a_req)
 	return sec_aead_crypto(a_req, false);
 }
 
-#define SEC_AEAD_GEN_ALG(sec_cra_name, sec_set_key, ctx_init,\
+#define SEC_AEAD_ALG(sec_cra_name, sec_set_key, ctx_init,\
 			 ctx_exit, blk_size, iv_size, max_authsize)\
 {\
 	.base = {\
@@ -1991,22 +2261,39 @@ static int sec_aead_decrypt(struct aead_request *a_req)
 	.maxauthsize = max_authsize,\
 }
 
-#define SEC_AEAD_ALG(algname, keyfunc, aead_init, blksize, ivsize, authsize)\
-	SEC_AEAD_GEN_ALG(algname, keyfunc, aead_init,\
-			sec_aead_ctx_exit, blksize, ivsize, authsize)
-
 static struct aead_alg sec_aeads[] = {
 	SEC_AEAD_ALG("authenc(hmac(sha1),cbc(aes))",
 		     sec_setkey_aes_cbc_sha1, sec_aead_sha1_ctx_init,
-		     AES_BLOCK_SIZE, AES_BLOCK_SIZE, SHA1_DIGEST_SIZE),
+		     sec_aead_ctx_exit, AES_BLOCK_SIZE,
+		     AES_BLOCK_SIZE, SHA1_DIGEST_SIZE),
 
 	SEC_AEAD_ALG("authenc(hmac(sha256),cbc(aes))",
 		     sec_setkey_aes_cbc_sha256, sec_aead_sha256_ctx_init,
-		     AES_BLOCK_SIZE, AES_BLOCK_SIZE, SHA256_DIGEST_SIZE),
+		     sec_aead_ctx_exit, AES_BLOCK_SIZE,
+		     AES_BLOCK_SIZE, SHA256_DIGEST_SIZE),
 
 	SEC_AEAD_ALG("authenc(hmac(sha512),cbc(aes))",
 		     sec_setkey_aes_cbc_sha512, sec_aead_sha512_ctx_init,
-		     AES_BLOCK_SIZE, AES_BLOCK_SIZE, SHA512_DIGEST_SIZE),
+		     sec_aead_ctx_exit, AES_BLOCK_SIZE,
+		     AES_BLOCK_SIZE, SHA512_DIGEST_SIZE),
+
+	SEC_AEAD_ALG("ccm(aes)", sec_setkey_aes_ccm, sec_aead_xcm_ctx_init,
+		     sec_aead_xcm_ctx_exit, SEC_MIN_BLOCK_SZ,
+		     AES_BLOCK_SIZE, AES_BLOCK_SIZE),
+
+	SEC_AEAD_ALG("gcm(aes)", sec_setkey_aes_gcm, sec_aead_xcm_ctx_init,
+		     sec_aead_xcm_ctx_exit, SEC_MIN_BLOCK_SZ,
+		     SEC_AIV_SIZE, AES_BLOCK_SIZE)
+};
+
+static struct aead_alg sec_aeads_v3[] = {
+	SEC_AEAD_ALG("ccm(sm4)", sec_setkey_sm4_ccm, sec_aead_xcm_ctx_init,
+		     sec_aead_xcm_ctx_exit, SEC_MIN_BLOCK_SZ,
+		     AES_BLOCK_SIZE, AES_BLOCK_SIZE),
+
+	SEC_AEAD_ALG("gcm(sm4)", sec_setkey_sm4_gcm, sec_aead_xcm_ctx_init,
+		     sec_aead_xcm_ctx_exit, SEC_MIN_BLOCK_SZ,
+		     SEC_AIV_SIZE, AES_BLOCK_SIZE)
 };
 
 int sec_register_to_crypto(struct hisi_qm *qm)
@@ -2025,11 +2312,19 @@ int sec_register_to_crypto(struct hisi_qm *qm)
 		if (ret)
 			goto reg_skcipher_fail;
 	}
+
 	ret = crypto_register_aeads(sec_aeads, ARRAY_SIZE(sec_aeads));
 	if (ret)
 		goto reg_aead_fail;
+	if (qm->ver > QM_HW_V2) {
+		ret = crypto_register_aeads(sec_aeads_v3, ARRAY_SIZE(sec_aeads_v3));
+		if (ret)
+			goto reg_aead_v3_fail;
+	}
 	return ret;
 
+reg_aead_v3_fail:
+	crypto_unregister_aeads(sec_aeads, ARRAY_SIZE(sec_aeads));
 reg_aead_fail:
 	if (qm->ver > QM_HW_V2)
 		crypto_unregister_skciphers(sec_skciphers_v3,
@@ -2043,9 +2338,13 @@ int sec_register_to_crypto(struct hisi_qm *qm)
 void sec_unregister_from_crypto(struct hisi_qm *qm)
 {
 	if (qm->ver > QM_HW_V2)
+		crypto_unregister_aeads(sec_aeads_v3,
+					ARRAY_SIZE(sec_aeads_v3));
+	crypto_unregister_aeads(sec_aeads, ARRAY_SIZE(sec_aeads));
+
+	if (qm->ver > QM_HW_V2)
 		crypto_unregister_skciphers(sec_skciphers_v3,
 					    ARRAY_SIZE(sec_skciphers_v3));
 	crypto_unregister_skciphers(sec_skciphers,
 				    ARRAY_SIZE(sec_skciphers));
-	crypto_unregister_aeads(sec_aeads, ARRAY_SIZE(sec_aeads));
 }
diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.h b/drivers/crypto/hisilicon/sec2/sec_crypto.h
index c9bfe75..a7bcd3e 100644
--- a/drivers/crypto/hisilicon/sec2/sec_crypto.h
+++ b/drivers/crypto/hisilicon/sec2/sec_crypto.h
@@ -4,6 +4,7 @@
 #ifndef __HISI_SEC_V2_CRYPTO_H
 #define __HISI_SEC_V2_CRYPTO_H
 
+#define SEC_AIV_SIZE		12
 #define SEC_IV_SIZE		24
 #define SEC_MAX_KEY_SIZE	64
 #define SEC_COMM_SCENE		0
@@ -22,6 +23,11 @@ enum sec_hash_alg {
 };
 
 enum sec_mac_len {
+	SEC_HMAC_CCM_MAC   = 16,
+	SEC_HMAC_GCM_MAC   = 16,
+	SEC_SM3_MAC        = 32,
+	SEC_HMAC_SM3_MAC   = 32,
+	SEC_HMAC_MD5_MAC   = 16,
 	SEC_HMAC_SHA1_MAC   = 20,
 	SEC_HMAC_SHA256_MAC = 32,
 	SEC_HMAC_SHA512_MAC = 64,
@@ -33,6 +39,8 @@ enum sec_cmode {
 	SEC_CMODE_CFB    = 0x2,
 	SEC_CMODE_OFB    = 0x3,
 	SEC_CMODE_CTR    = 0x4,
+	SEC_CMODE_CCM    = 0x5,
+	SEC_CMODE_GCM    = 0x6,
 	SEC_CMODE_XTS    = 0x7,
 };
 
-- 
2.8.1

