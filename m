Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2E4322646
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 08:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhBWHPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 02:15:45 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12990 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbhBWHNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 02:13:31 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dl9FV1qzWzjR1c;
        Tue, 23 Feb 2021 15:11:10 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Tue, 23 Feb 2021 15:12:34 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <tudor.ambarus@microchip.com>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <yumeng18@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 7/7] crypto: hisilicon/hpre - add 'CURVE25519' algorithm
Date:   Tue, 23 Feb 2021 15:10:19 +0800
Message-ID: <1614064219-40701-8-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614064219-40701-1-git-send-email-yumeng18@huawei.com>
References: <1614064219-40701-1-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable 'CURVE25519' algorithm in Kunpeng 930.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
Reviewed-by: Zaibo Xu <xuzaibo@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/crypto/hisilicon/Kconfig            |   1 +
 drivers/crypto/hisilicon/hpre/hpre.h        |   2 +
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 366 +++++++++++++++++++++++++++-
 3 files changed, 361 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 8431926..c45adb1 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -65,6 +65,7 @@ config CRYPTO_DEV_HISI_HPRE
 	depends on UACCE || UACCE=n
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
 	depends on ACPI
+	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_DEV_HISI_QM
 	select CRYPTO_DH
 	select CRYPTO_RSA
diff --git a/drivers/crypto/hisilicon/hpre/hpre.h b/drivers/crypto/hisilicon/hpre/hpre.h
index 50e6b2e..92892e3 100644
--- a/drivers/crypto/hisilicon/hpre/hpre.h
+++ b/drivers/crypto/hisilicon/hpre/hpre.h
@@ -84,6 +84,8 @@ enum hpre_alg_type {
 	HPRE_ALG_DH_G2 = 0x4,
 	HPRE_ALG_DH = 0x5,
 	HPRE_ALG_ECC_MUL = 0xD,
+	/* shared by x25519 and x448, but x448 is not supported now */
+	HPRE_ALG_CURVE25519_MUL = 0x10,
 };
 
 struct hpre_sqe {
diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index a6010b1..53068d2 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright (c) 2019 HiSilicon Limited. */
 #include <crypto/akcipher.h>
+#include <crypto/curve25519.h>
 #include <crypto/dh.h>
 #include <crypto/ecc_curve.h>
 #include <crypto/ecdh.h>
@@ -89,6 +90,16 @@ struct hpre_ecdh_ctx {
 	dma_addr_t dma_g;
 };
 
+struct hpre_curve25519_ctx {
+	/* low address: p->a->k */
+	unsigned char *p;
+	dma_addr_t dma_p;
+
+	/* gx coordinate */
+	unsigned char *g;
+	dma_addr_t dma_g;
+};
+
 struct hpre_ctx {
 	struct hisi_qp *qp;
 	struct hpre_asym_request **req_list;
@@ -101,6 +112,7 @@ struct hpre_ctx {
 		struct hpre_rsa_ctx rsa;
 		struct hpre_dh_ctx dh;
 		struct hpre_ecdh_ctx ecdh;
+		struct hpre_curve25519_ctx curve25519;
 	};
 	/* for ecc algorithms */
 	unsigned int curve_id;
@@ -115,6 +127,7 @@ struct hpre_asym_request {
 		struct akcipher_request *rsa;
 		struct kpp_request *dh;
 		struct kpp_request *ecdh;
+		struct kpp_request *curve25519;
 	} areq;
 	int err;
 	int req_id;
@@ -437,7 +450,6 @@ static void hpre_alg_cb(struct hisi_qp *qp, void *resp)
 	struct hpre_sqe *sqe = resp;
 	struct hpre_asym_request *req = ctx->req_list[le16_to_cpu(sqe->tag)];
 
-
 	if (unlikely(!req)) {
 		atomic64_inc(&dfx[HPRE_INVALID_REQ_CNT].value);
 		return;
@@ -1167,6 +1179,12 @@ static void hpre_ecc_clear_ctx(struct hpre_ctx *ctx, bool is_clear_all,
 		memzero_explicit(ctx->ecdh.p + shift, sz);
 		dma_free_coherent(dev, sz << 3, ctx->ecdh.p, ctx->ecdh.dma_p);
 		ctx->ecdh.p = NULL;
+	} else if (!is_ecdh && ctx->curve25519.p) {
+		/* curve25519: p->a->k */
+		memzero_explicit(ctx->curve25519.p + shift, sz);
+		dma_free_coherent(dev, sz << 2, ctx->curve25519.p,
+				  ctx->curve25519.dma_p);
+		ctx->curve25519.p = NULL;
 	}
 
 	hpre_ctx_clear(ctx, is_clear_all);
@@ -1549,6 +1567,312 @@ static void hpre_ecdh_exit_tfm(struct crypto_kpp *tfm)
 	hpre_ecc_clear_ctx(ctx, true, true);
 }
 
+static void hpre_curve25519_fill_curve(struct hpre_ctx *ctx, const void *buf,
+				       unsigned int len)
+{
+	u8 secret[CURVE25519_KEY_SIZE] = { 0 };
+	unsigned int sz = ctx->key_sz;
+	const struct ecc_curve *curve;
+	unsigned int shift = sz << 1;
+	void *p;
+
+	/*
+	 * The key from 'buf' is in little-endian, we should preprocess it as
+	 * the description in rfc7748: "k[0] &= 248, k[31] &= 127, k[31] |= 64",
+	 * then convert it to big endian. Only in this way, the result can be
+	 * the same as the software curve-25519 that exists in crypto.
+	 */
+	memcpy(secret, buf, len);
+	curve25519_clamp_secret(secret);
+	hpre_key_to_big_end(secret, CURVE25519_KEY_SIZE);
+
+	p = ctx->curve25519.p + sz - len;
+
+	curve = ecc_get_curve25519();
+
+	/* fill curve parameters */
+	fill_curve_param(p, curve->p, len, curve->g.ndigits);
+	fill_curve_param(p + sz, curve->a, len, curve->g.ndigits);
+	memcpy(p + shift, secret, len);
+	fill_curve_param(p + shift + sz, curve->g.x, len, curve->g.ndigits);
+	memzero_explicit(secret, CURVE25519_KEY_SIZE);
+}
+
+static int hpre_curve25519_set_param(struct hpre_ctx *ctx, const void *buf,
+				     unsigned int len)
+{
+	struct device *dev = HPRE_DEV(ctx);
+	unsigned int sz = ctx->key_sz;
+	unsigned int shift = sz << 1;
+
+	/* p->a->k->gx */
+	if (!ctx->curve25519.p) {
+		ctx->curve25519.p = dma_alloc_coherent(dev, sz << 2,
+						       &ctx->curve25519.dma_p,
+						       GFP_KERNEL);
+		if (!ctx->curve25519.p)
+			return -ENOMEM;
+	}
+
+	ctx->curve25519.g = ctx->curve25519.p + shift + sz;
+	ctx->curve25519.dma_g = ctx->curve25519.dma_p + shift + sz;
+
+	hpre_curve25519_fill_curve(ctx, buf, len);
+
+	return 0;
+}
+
+static int hpre_curve25519_set_secret(struct crypto_kpp *tfm, const void *buf,
+				      unsigned int len)
+{
+	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
+	struct device *dev = HPRE_DEV(ctx);
+	int ret = -EINVAL;
+
+	if (len != CURVE25519_KEY_SIZE ||
+	    !crypto_memneq(buf, curve25519_null_point, CURVE25519_KEY_SIZE)) {
+		dev_err(dev, "key is null or key len is not 32bytes!\n");
+		return ret;
+	}
+
+	/* Free old secret if any */
+	hpre_ecc_clear_ctx(ctx, false, false);
+
+	ctx->key_sz = CURVE25519_KEY_SIZE;
+	ret = hpre_curve25519_set_param(ctx, buf, CURVE25519_KEY_SIZE);
+	if (ret) {
+		dev_err(dev, "failed to set curve25519 param, ret = %d!\n", ret);
+		hpre_ecc_clear_ctx(ctx, false, false);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void hpre_curve25519_hw_data_clr_all(struct hpre_ctx *ctx,
+					    struct hpre_asym_request *req,
+					    struct scatterlist *dst,
+					    struct scatterlist *src)
+{
+	struct device *dev = HPRE_DEV(ctx);
+	struct hpre_sqe *sqe = &req->req;
+	dma_addr_t dma;
+
+	dma = le64_to_cpu(sqe->in);
+	if (unlikely(!dma))
+		return;
+
+	if (src && req->src)
+		dma_free_coherent(dev, ctx->key_sz, req->src, dma);
+
+	dma = le64_to_cpu(sqe->out);
+	if (unlikely(!dma))
+		return;
+
+	if (req->dst)
+		dma_free_coherent(dev, ctx->key_sz, req->dst, dma);
+	if (dst)
+		dma_unmap_single(dev, dma, ctx->key_sz, DMA_FROM_DEVICE);
+}
+
+static void hpre_curve25519_cb(struct hpre_ctx *ctx, void *resp)
+{
+	struct hpre_dfx *dfx = ctx->hpre->debug.dfx;
+	struct hpre_asym_request *req = NULL;
+	struct kpp_request *areq;
+	u64 overtime_thrhld;
+	int ret;
+
+	ret = hpre_alg_res_post_hf(ctx, resp, (void **)&req);
+	areq = req->areq.curve25519;
+	areq->dst_len = ctx->key_sz;
+
+	overtime_thrhld = atomic64_read(&dfx[HPRE_OVERTIME_THRHLD].value);
+	if (overtime_thrhld && hpre_is_bd_timeout(req, overtime_thrhld))
+		atomic64_inc(&dfx[HPRE_OVER_THRHLD_CNT].value);
+
+	hpre_key_to_big_end(sg_virt(areq->dst), CURVE25519_KEY_SIZE);
+
+	hpre_curve25519_hw_data_clr_all(ctx, req, areq->dst, areq->src);
+	kpp_request_complete(areq, ret);
+
+	atomic64_inc(&dfx[HPRE_RECV_CNT].value);
+}
+
+static int hpre_curve25519_msg_request_set(struct hpre_ctx *ctx,
+					   struct kpp_request *req)
+{
+	struct hpre_asym_request *h_req;
+	struct hpre_sqe *msg;
+	int req_id;
+	void *tmp;
+
+	if (unlikely(req->dst_len < ctx->key_sz)) {
+		req->dst_len = ctx->key_sz;
+		return -EINVAL;
+	}
+
+	tmp = kpp_request_ctx(req);
+	h_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+	h_req->cb = hpre_curve25519_cb;
+	h_req->areq.curve25519 = req;
+	msg = &h_req->req;
+	memset(msg, 0, sizeof(*msg));
+	msg->key = cpu_to_le64(ctx->curve25519.dma_p);
+
+	msg->dw0 |= cpu_to_le32(0x1U << HPRE_SQE_DONE_SHIFT);
+	msg->task_len1 = (ctx->key_sz >> HPRE_BITS_2_BYTES_SHIFT) - 1;
+	h_req->ctx = ctx;
+
+	req_id = hpre_add_req_to_ctx(h_req);
+	if (req_id < 0)
+		return -EBUSY;
+
+	msg->tag = cpu_to_le16((u16)req_id);
+	return 0;
+}
+
+static int hpre_curve25519_src_init(struct hpre_asym_request *hpre_req,
+				    struct scatterlist *data, unsigned int len)
+{
+	struct hpre_sqe *msg = &hpre_req->req;
+	struct hpre_ctx *ctx = hpre_req->ctx;
+	struct device *dev = HPRE_DEV(ctx);
+	u8 p[CURVE25519_KEY_SIZE] = { 0 };
+	const struct ecc_curve *curve;
+	dma_addr_t dma = 0;
+	u8 *ptr;
+
+	if (len != CURVE25519_KEY_SIZE) {
+		dev_err(dev, "sourc_data len is not 32bytes, len = %u!\n", len);
+		return -EINVAL;
+	}
+
+	ptr = dma_alloc_coherent(dev, ctx->key_sz, &dma, GFP_KERNEL);
+	if (unlikely(!ptr))
+		return -ENOMEM;
+
+	scatterwalk_map_and_copy(ptr, data, 0, len, 0);
+
+	if (!crypto_memneq(ptr, curve25519_null_point, CURVE25519_KEY_SIZE)) {
+		dev_err(dev, "gx is null!\n");
+		goto err;
+	}
+
+	/*
+	 * Src_data(gx) is in little-endian order, MSB in the final byte should
+	 * be masked as discribed in RFC7748, then transform it to big-endian
+	 * form, then hisi_hpre can use the data.
+	 */
+	ptr[31] &= 0x7f;
+	hpre_key_to_big_end(ptr, CURVE25519_KEY_SIZE);
+
+	curve = ecc_get_curve25519();
+
+	fill_curve_param(p, curve->p, CURVE25519_KEY_SIZE, curve->g.ndigits);
+	if (memcmp(ptr, p, ctx->key_sz) >= 0) {
+		dev_err(dev, "gx is out of p!\n");
+		goto err;
+	}
+
+	hpre_req->src = ptr;
+	msg->in = cpu_to_le64(dma);
+	return 0;
+
+err:
+	dma_free_coherent(dev, ctx->key_sz, ptr, dma);
+	return -EINVAL;
+}
+
+static int hpre_curve25519_dst_init(struct hpre_asym_request *hpre_req,
+				    struct scatterlist *data, unsigned int len)
+{
+	struct hpre_sqe *msg = &hpre_req->req;
+	struct hpre_ctx *ctx = hpre_req->ctx;
+	struct device *dev = HPRE_DEV(ctx);
+	dma_addr_t dma = 0;
+
+	if (!data || !sg_is_last(data) || len != ctx->key_sz) {
+		dev_err(dev, "data or data length is illegal!\n");
+		return -EINVAL;
+	}
+
+	hpre_req->dst = NULL;
+	dma = dma_map_single(dev, sg_virt(data), len, DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(dev, dma))) {
+		dev_err(dev, "dma map data err!\n");
+		return -ENOMEM;
+	}
+
+	msg->out = cpu_to_le64(dma);
+	return 0;
+}
+
+static int hpre_curve25519_compute_value(struct kpp_request *req)
+{
+	struct crypto_kpp *tfm = crypto_kpp_reqtfm(req);
+	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
+	struct device *dev = HPRE_DEV(ctx);
+	void *tmp = kpp_request_ctx(req);
+	struct hpre_asym_request *hpre_req = PTR_ALIGN(tmp, HPRE_ALIGN_SZ);
+	struct hpre_sqe *msg = &hpre_req->req;
+	int ret;
+
+	ret = hpre_curve25519_msg_request_set(ctx, req);
+	if (unlikely(ret)) {
+		dev_err(dev, "failed to set curve25519 request, ret = %d!\n", ret);
+		return ret;
+	}
+
+	if (req->src) {
+		ret = hpre_curve25519_src_init(hpre_req, req->src, req->src_len);
+		if (unlikely(ret)) {
+			dev_err(dev, "failed to init src data, ret = %d!\n",
+				ret);
+			goto clear_all;
+		}
+	} else {
+		msg->in = cpu_to_le64(ctx->curve25519.dma_g);
+	}
+
+	ret = hpre_curve25519_dst_init(hpre_req, req->dst, req->dst_len);
+	if (unlikely(ret)) {
+		dev_err(dev, "failed to init dst data, ret = %d!\n", ret);
+		goto clear_all;
+	}
+
+	msg->dw0 = cpu_to_le32(le32_to_cpu(msg->dw0) | HPRE_ALG_CURVE25519_MUL);
+	ret = hpre_send(ctx, msg);
+	if (likely(!ret))
+		return -EINPROGRESS;
+
+clear_all:
+	hpre_rm_req_from_ctx(hpre_req);
+	hpre_curve25519_hw_data_clr_all(ctx, hpre_req, req->dst, req->src);
+	return ret;
+}
+
+static unsigned int hpre_curve25519_max_size(struct crypto_kpp *tfm)
+{
+	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
+
+	return ctx->key_sz;
+}
+
+static int hpre_curve25519_init_tfm(struct crypto_kpp *tfm)
+{
+	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
+
+	return hpre_ctx_init(ctx, HPRE_V3_ECC_ALG_TYPE);
+}
+
+static void hpre_curve25519_exit_tfm(struct crypto_kpp *tfm)
+{
+	struct hpre_ctx *ctx = kpp_tfm_ctx(tfm);
+
+	hpre_ecc_clear_ctx(ctx, true, false);
+}
+
 static struct akcipher_alg rsa = {
 	.sign = hpre_rsa_dec,
 	.verify = hpre_rsa_enc,
@@ -1622,6 +1946,24 @@ static struct kpp_alg ecdh_nist_p256 = {
 	},
 };
 
+static struct kpp_alg curve25519_alg = {
+	.set_secret = hpre_curve25519_set_secret,
+	.generate_public_key = hpre_curve25519_compute_value,
+	.compute_shared_secret = hpre_curve25519_compute_value,
+	.max_size = hpre_curve25519_max_size,
+	.init = hpre_curve25519_init_tfm,
+	.exit = hpre_curve25519_exit_tfm,
+	.reqsize = sizeof(struct hpre_asym_request) + HPRE_ALIGN_SZ,
+	.base = {
+		.cra_ctxsize = sizeof(struct hpre_ctx),
+		.cra_priority = HPRE_CRYPTO_ALG_PRI,
+		.cra_name = "curve25519",
+		.cra_driver_name = "hpre-curve25519",
+		.cra_module = THIS_MODULE,
+	},
+};
+
+
 static int hpre_register_ecdh(void)
 {
 	int ret;
@@ -1663,22 +2005,30 @@ int hpre_algs_register(struct hisi_qm *qm)
 
 	if (qm->ver >= QM_HW_V3) {
 		ret = hpre_register_ecdh();
+		if (ret)
+			goto reg_err;
+		ret = crypto_register_kpp(&curve25519_alg);
 		if (ret) {
-#ifdef CONFIG_CRYPTO_DH
-			crypto_unregister_kpp(&dh);
-#endif
-			crypto_unregister_akcipher(&rsa);
-			return ret;
+			hpre_unregister_ecdh();
+			goto reg_err;
 		}
 	}
-
 	return 0;
+
+reg_err:
+#ifdef CONFIG_CRYPTO_DH
+	crypto_unregister_kpp(&dh);
+#endif
+	crypto_unregister_akcipher(&rsa);
+	return ret;
 }
 
 void hpre_algs_unregister(struct hisi_qm *qm)
 {
-	if (qm->ver >= QM_HW_V3)
+	if (qm->ver >= QM_HW_V3) {
+		crypto_unregister_kpp(&curve25519_alg);
 		hpre_unregister_ecdh();
+	}
 
 #ifdef CONFIG_CRYPTO_DH
 	crypto_unregister_kpp(&dh);
-- 
2.8.1

