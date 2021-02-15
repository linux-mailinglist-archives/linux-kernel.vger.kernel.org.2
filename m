Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593C231C08A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 18:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhBOR07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 12:26:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231321AbhBOQ0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 11:26:42 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FG3nkU023768;
        Mon, 15 Feb 2021 11:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=baOpeEMF23IkwoimodDx43nuyakOTp/rJKtdx7wd9Ow=;
 b=IBovrR/kySTYpkytM+iSea3z9VvvVyKyWOvclByjlySesfB+LUJbbletJHxUm1RCsdc0
 2dH12uygYov43NQjGiE+gVIxof9OG+aVDiyEiNzqBDQa80czmEG76VBchzsIwiK9g+st
 SM4ygAYVAP93fkRpL5e2Ey5z0889GLSUl1s2TYDxUtJ+4QkklaOC2lyiTuLjqviM2gLY
 k5Enc1z4OGik2VGBcEAa547LMP3m808zJ4QqZ1NxR/s946mhKNyDrOLLP3Bx1JUIPBE7
 rKcdBhiltqk9UYToSzIzBRucNDhgbvFqTJt4qq3gnlOAAGzCsYJd7T4H9V9FxofAL/78 KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36qup4sq4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 11:25:50 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FG5t5R034021;
        Mon, 15 Feb 2021 11:25:49 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36qup4sq4e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 11:25:49 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FGLxG6023192;
        Mon, 15 Feb 2021 16:25:48 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 36p6d94b3n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 16:25:48 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FGPkSN25166308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 16:25:46 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D7496A057;
        Mon, 15 Feb 2021 16:25:46 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BC7AB6A047;
        Mon, 15 Feb 2021 16:25:45 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 15 Feb 2021 16:25:45 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v8 1/4] crypto: Add support for ECDSA signature verification
Date:   Mon, 15 Feb 2021 11:25:29 -0500
Message-Id: <20210215162532.1077098-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210215162532.1077098-1-stefanb@linux.ibm.com>
References: <20210215162532.1077098-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_11:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150124
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for parsing the parameters of a NIST P256 or NIST P192 key.
Enable signature verification using these keys. The new module is
enabled with CONFIG_ECDSA:
  Elliptic Curve Digital Signature Algorithm (NIST P192, P256 etc.)
  is A NIST cryptographic standard algorithm. Only signature verification
  is implemented.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 crypto/Kconfig               |  10 +
 crypto/Makefile              |   6 +
 crypto/ecc.c                 |  13 +-
 crypto/ecc.h                 |  28 +++
 crypto/ecdsa.c               | 361 +++++++++++++++++++++++++++++++++++
 crypto/ecdsasignature.asn1   |   4 +
 crypto/testmgr.c             |  12 ++
 crypto/testmgr.h             | 267 ++++++++++++++++++++++++++
 include/linux/oid_registry.h |   4 +
 9 files changed, 694 insertions(+), 11 deletions(-)
 create mode 100644 crypto/ecdsa.c
 create mode 100644 crypto/ecdsasignature.asn1

diff --git a/crypto/Kconfig b/crypto/Kconfig
index a367fcfeb5d4..a31df40591f5 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -247,6 +247,16 @@ config CRYPTO_ECDH
 	help
 	  Generic implementation of the ECDH algorithm
 
+config CRYPTO_ECDSA
+	tristate "ECDSA (NIST P192, P256 etc.) algorithm"
+	select CRYPTO_ECC
+	select CRYPTO_AKCIPHER
+	select ASN1
+	help
+	  Elliptic Curve Digital Signature Algorithm (NIST P192, P256 etc.)
+	  is A NIST cryptographic standard algorithm. Only signature verification
+	  is implemented.
+
 config CRYPTO_ECRDSA
 	tristate "EC-RDSA (GOST 34.10) algorithm"
 	select CRYPTO_ECC
diff --git a/crypto/Makefile b/crypto/Makefile
index b279483fba50..982066c6bdfb 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -50,6 +50,12 @@ sm2_generic-y += sm2.o
 
 obj-$(CONFIG_CRYPTO_SM2) += sm2_generic.o
 
+$(obj)/ecdsasignature.asn1.o: $(obj)/ecdsasignature.asn1.c $(obj)/ecdsasignature.asn1.h
+$(obj)/ecdsa.o: $(obj)/ecdsasignature.asn1.h
+ecdsa_generic-y += ecdsa.o
+ecdsa_generic-y += ecdsasignature.asn1.o
+obj-$(CONFIG_CRYPTO_ECDSA) += ecdsa_generic.o
+
 crypto_acompress-y := acompress.o
 crypto_acompress-y += scompress.o
 obj-$(CONFIG_CRYPTO_ACOMP2) += crypto_acompress.o
diff --git a/crypto/ecc.c b/crypto/ecc.c
index c80aa25994a0..25e79fd70566 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -42,7 +42,7 @@ typedef struct {
 	u64 m_high;
 } uint128_t;
 
-static inline const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
+const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
 {
 	switch (curve_id) {
 	/* In FIPS mode only allow P256 and higher */
@@ -54,6 +54,7 @@ static inline const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
 		return NULL;
 	}
 }
+EXPORT_SYMBOL(ecc_get_curve);
 
 static u64 *ecc_alloc_digits_space(unsigned int ndigits)
 {
@@ -1281,16 +1282,6 @@ void ecc_point_mult_shamir(const struct ecc_point *result,
 }
 EXPORT_SYMBOL(ecc_point_mult_shamir);
 
-static inline void ecc_swap_digits(const u64 *in, u64 *out,
-				   unsigned int ndigits)
-{
-	const __be64 *src = (__force __be64 *)in;
-	int i;
-
-	for (i = 0; i < ndigits; i++)
-		out[i] = be64_to_cpu(src[ndigits - 1 - i]);
-}
-
 static int __ecc_is_key_valid(const struct ecc_curve *curve,
 			      const u64 *private_key, unsigned int ndigits)
 {
diff --git a/crypto/ecc.h b/crypto/ecc.h
index d4e546b9ad79..2ea86dfb5cf7 100644
--- a/crypto/ecc.h
+++ b/crypto/ecc.h
@@ -33,6 +33,8 @@
 
 #define ECC_DIGITS_TO_BYTES_SHIFT 3
 
+#define ECC_MAX_BYTES (ECC_MAX_DIGITS << ECC_DIGITS_TO_BYTES_SHIFT)
+
 /**
  * struct ecc_point - elliptic curve point in affine coordinates
  *
@@ -70,6 +72,32 @@ struct ecc_curve {
 	u64 *b;
 };
 
+/**
+ * ecc_swap_digits() - Copy ndigits from big endian array to native array
+ *
+ * @in:       input array
+ * @out:      output array
+ * @ndigits:  number of digits to copy
+ */
+static inline void ecc_swap_digits(const u64 *in, u64 *out,
+				   unsigned int ndigits)
+{
+	const __be64 *src = (__force __be64 *)in;
+	int i;
+
+	for (i = 0; i < ndigits; i++)
+		out[i] = be64_to_cpu(src[ndigits - 1 - i]);
+}
+
+/**
+ * ecc_get_curve()  - Get a curve given its curve_id
+ *
+ * @curve_id:  Id of the curve
+ *
+ * Returns pointer to the curve data, NULL if curve is not available
+ */
+const struct ecc_curve *ecc_get_curve(unsigned int curve_id);
+
 /**
  * ecc_is_key_valid() - Validate a given ECDH private key
  *
diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
new file mode 100644
index 000000000000..4b45230276b3
--- /dev/null
+++ b/crypto/ecdsa.c
@@ -0,0 +1,361 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2021 IBM Corporation
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are
+ * met:
+ *  * Redistributions of source code must retain the above copyright
+ *   notice, this list of conditions and the following disclaimer.
+ *  * Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include <linux/module.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/akcipher.h>
+#include <crypto/ecdh.h>
+#include <linux/asn1_decoder.h>
+#include <linux/scatterlist.h>
+
+#include "ecc.h"
+#include "ecdsasignature.asn1.h"
+
+struct ecc_ctx {
+	unsigned int curve_id;
+	const struct ecc_curve *curve;
+
+	bool pub_key_set;
+	u64 x[ECC_MAX_DIGITS]; /* pub key x and y coordinates */
+	u64 y[ECC_MAX_DIGITS];
+	struct ecc_point pub_key;
+};
+
+struct ecdsa_signature_ctx {
+	const struct ecc_curve *curve;
+	u64 r[ECC_MAX_DIGITS];
+	u64 s[ECC_MAX_DIGITS];
+};
+
+/*
+ * Get the r and s components of a signature from the X509 certificate.
+ */
+static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
+				  const void *value, size_t vlen,
+				  unsigned int ndigits)
+{
+	size_t keylen = ndigits * sizeof(u64);
+	ssize_t diff = vlen - keylen;
+	const char *d = value;
+	u8 rs[ECC_MAX_BYTES];
+
+	if (!value || !vlen)
+		return -EINVAL;
+
+	/* diff = 0: 'value' has exacly the right size
+	 * diff > 0: 'value' has too many bytes; one leading zero is allowed that
+	 *           makes the value a positive integer; error on more
+	 * diff < 0: 'value' is missing leading zeros, which we add
+	 */
+	if (diff > 0) {
+		/* skip over leading zeros that make 'value' a positive int */
+		if (*d == 0) {
+			vlen -= 1;
+			diff--;
+			d++;
+		}
+		if (diff)
+			return -EINVAL;
+	}
+	if (-diff >= keylen)
+		return -EINVAL;
+
+	if (diff) {
+		/* leading zeros not given in 'value' */
+		memset(rs, 0, -diff);
+	}
+
+	memcpy(&rs[-diff], d, vlen);
+
+	ecc_swap_digits((u64 *)rs, dest, ndigits);
+
+	return 0;
+}
+
+int ecdsa_get_signature_r(void *context, size_t hdrlen, unsigned char tag,
+			const void *value, size_t vlen)
+{
+	struct ecdsa_signature_ctx *sig = context;
+
+	return ecdsa_get_signature_rs(sig->r, hdrlen, tag, value, vlen,
+				      sig->curve->g.ndigits);
+}
+
+int ecdsa_get_signature_s(void *context, size_t hdrlen, unsigned char tag,
+			  const void *value, size_t vlen)
+{
+	struct ecdsa_signature_ctx *sig = context;
+
+	return ecdsa_get_signature_rs(sig->s, hdrlen, tag, value, vlen,
+				      sig->curve->g.ndigits);
+}
+
+static int _ecdsa_verify(struct ecc_ctx *ctx, const u64 *hash,
+			 const u64 *r, const u64 *s)
+{
+	const struct ecc_curve *curve = ctx->curve;
+	unsigned int ndigits = curve->g.ndigits;
+	u64 s1[ECC_MAX_DIGITS];
+	u64 u1[ECC_MAX_DIGITS];
+	u64 u2[ECC_MAX_DIGITS];
+	u64 x1[ECC_MAX_DIGITS];
+	u64 y1[ECC_MAX_DIGITS];
+	struct ecc_point res = ECC_POINT_INIT(x1, y1, ndigits);
+
+	/* 0 < r < n  and 0 < s < n */
+	if (vli_is_zero(r, ndigits) || vli_cmp(r, curve->n, ndigits) >= 0 ||
+	    vli_is_zero(s, ndigits) || vli_cmp(s, curve->n, ndigits) >= 0)
+		return -EBADMSG;
+
+	/* hash is given */
+	pr_devel("hash : %016llx %016llx ... %016llx\n",
+		 hash[ndigits - 1], hash[ndigits - 2], hash[0]);
+
+	/* s1 = (s^-1) mod n */
+	vli_mod_inv(s1, s, curve->n, ndigits);
+	/* u1 = (hash * s1) mod n */
+	vli_mod_mult_slow(u1, hash, s1, curve->n, ndigits);
+	/* u2 = (r * s1) mod n */
+	vli_mod_mult_slow(u2, r, s1, curve->n, ndigits);
+	/* res = u1*G + u2 * pub_key */
+	ecc_point_mult_shamir(&res, u1, &curve->g, u2, &ctx->pub_key, curve);
+
+	/* res.x = res.x mod n (if res.x > order) */
+	if (unlikely(vli_cmp(res.x, curve->n, ndigits) == 1))
+		/* faster alternative for NIST p256 & p192 */
+		vli_sub(res.x, res.x, curve->n, ndigits);
+
+	if (!vli_cmp(res.x, r, ndigits))
+		return 0;
+
+	return -EKEYREJECTED;
+}
+
+/*
+ * Verify an ECDSA signature.
+ */
+static int ecdsa_verify(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	size_t keylen = ctx->curve->g.ndigits * sizeof(u64);
+	struct ecdsa_signature_ctx sig_ctx = {
+		.curve = ctx->curve,
+	};
+	u8 rawhash[ECC_MAX_BYTES];
+	u64 hash[ECC_MAX_DIGITS];
+	unsigned char *buffer;
+	ssize_t diff;
+	int ret;
+
+	if (unlikely(!ctx->pub_key_set))
+		return -EINVAL;
+
+	buffer = kmalloc(req->src_len + req->dst_len, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	sg_pcopy_to_buffer(req->src,
+		sg_nents_for_len(req->src, req->src_len + req->dst_len),
+		buffer, req->src_len + req->dst_len, 0);
+
+	ret = asn1_ber_decoder(&ecdsasignature_decoder, &sig_ctx,
+			       buffer, req->src_len);
+	if (ret < 0)
+		goto error;
+
+	/* if the hash is shorter then we will add leading zeros to fit to ndigits */
+	diff = keylen - req->dst_len;
+	if (diff >= 0) {
+		if (diff)
+			memset(rawhash, 0, diff);
+		memcpy(&rawhash[diff], buffer + req->src_len, req->dst_len);
+	} else if (diff < 0) {
+		/* given hash is longer, we take the left-most bytes */
+		memcpy(&rawhash, buffer + req->src_len, keylen);
+	}
+
+	ecc_swap_digits((u64 *)rawhash, hash, ctx->curve->g.ndigits);
+
+	ret = _ecdsa_verify(ctx, hash, sig_ctx.r, sig_ctx.s);
+
+error:
+	kfree(buffer);
+
+	return ret;
+}
+
+static int ecdsa_ecc_ctx_init(struct ecc_ctx *ctx, unsigned int curve_id)
+{
+	ctx->curve_id = curve_id;
+	ctx->curve = ecc_get_curve(curve_id);
+	if (!ctx->curve)
+		return -EINVAL;
+
+	return 0;
+}
+
+
+static void ecdsa_ecc_ctx_deinit(struct ecc_ctx *ctx)
+{
+	ctx->pub_key_set = false;
+}
+
+static int ecdsa_ecc_ctx_reset(struct ecc_ctx *ctx)
+{
+	unsigned int curve_id = ctx->curve_id;
+	int ret;
+
+	ecdsa_ecc_ctx_deinit(ctx);
+	ret = ecdsa_ecc_ctx_init(ctx, curve_id);
+	if (ret == 0)
+		ctx->pub_key = ECC_POINT_INIT(ctx->x, ctx->y,
+					      ctx->curve->g.ndigits);
+	return ret;
+}
+
+/*
+ * Set the public key given the raw uncompressed key data from an X509
+ * certificate. The key data contain the concatenated X and Y coordinates of
+ * the public key.
+ */
+static int ecdsa_set_pub_key(struct crypto_akcipher *tfm,
+			     const void *key, unsigned int keylen)
+{
+	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	const unsigned char *d = key;
+	const u64 *digits = (const u64 *)&d[1];
+	unsigned int ndigits;
+	int ret;
+
+	ret = ecdsa_ecc_ctx_reset(ctx);
+	if (ret < 0)
+		return ret;
+
+	if (keylen < 1 || (((keylen - 1) >> 1) % sizeof(u64)) != 0)
+		return -EINVAL;
+	/* we only accept uncompressed format */
+	if (d[0] != 4)
+		return -EINVAL;
+
+	keylen--;
+	ndigits = (keylen >> 1) / sizeof(u64);
+	if (ndigits != ctx->curve->g.ndigits)
+		return -EINVAL;
+
+	ecc_swap_digits(digits, ctx->pub_key.x, ndigits);
+	ecc_swap_digits(&digits[ndigits], ctx->pub_key.y, ndigits);
+	ret = ecc_is_pubkey_valid_full(ctx->curve, &ctx->pub_key);
+
+	ctx->pub_key_set = ret == 0;
+
+	return ret;
+}
+
+static void ecdsa_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	ecdsa_ecc_ctx_deinit(ctx);
+}
+
+static unsigned int ecdsa_max_size(struct crypto_akcipher *tfm)
+{
+	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	return ctx->pub_key.ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
+}
+
+static int ecdsa_nist_p256_init_tfm(struct crypto_akcipher *tfm)
+{
+	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	return ecdsa_ecc_ctx_init(ctx, ECC_CURVE_NIST_P256);
+}
+
+static struct akcipher_alg ecdsa_nist_p256 = {
+	.verify = ecdsa_verify,
+	.set_pub_key = ecdsa_set_pub_key,
+	.max_size = ecdsa_max_size,
+	.init = ecdsa_nist_p256_init_tfm,
+	.exit = ecdsa_exit_tfm,
+	.base = {
+		.cra_name = "ecdsa-nist-p256",
+		.cra_driver_name = "ecdsa-nist-p256-generic",
+		.cra_priority = 100,
+		.cra_module = THIS_MODULE,
+		.cra_ctxsize = sizeof(struct ecc_ctx),
+	},
+};
+
+static int ecdsa_nist_p192_init_tfm(struct crypto_akcipher *tfm)
+{
+	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	return ecdsa_ecc_ctx_init(ctx, ECC_CURVE_NIST_P192);
+}
+
+static struct akcipher_alg ecdsa_nist_p192 = {
+	.verify = ecdsa_verify,
+	.set_pub_key = ecdsa_set_pub_key,
+	.max_size = ecdsa_max_size,
+	.init = ecdsa_nist_p192_init_tfm,
+	.exit = ecdsa_exit_tfm,
+	.base = {
+		.cra_name = "ecdsa-nist-p192",
+		.cra_driver_name = "ecdsa-nist-p192-generic",
+		.cra_priority = 100,
+		.cra_module = THIS_MODULE,
+		.cra_ctxsize = sizeof(struct ecc_ctx),
+	},
+};
+static bool ecdsa_nist_p192_registered;
+
+static int ecdsa_init(void)
+{
+	int ret;
+
+	/* NIST p192 may not be available in FIPS mode */
+	ret = crypto_register_akcipher(&ecdsa_nist_p192);
+	ecdsa_nist_p192_registered = ret == 0;
+
+	return crypto_register_akcipher(&ecdsa_nist_p256);
+}
+
+static void ecdsa_exit(void)
+{
+	if (ecdsa_nist_p192_registered)
+		crypto_unregister_akcipher(&ecdsa_nist_p192);
+	crypto_unregister_akcipher(&ecdsa_nist_p256);
+}
+
+subsys_initcall(ecdsa_init);
+module_exit(ecdsa_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Stefan Berger <stefanb@linux.ibm.com>");
+MODULE_DESCRIPTION("ECDSA generic algorithm");
+MODULE_ALIAS_CRYPTO("ecdsa-generic");
diff --git a/crypto/ecdsasignature.asn1 b/crypto/ecdsasignature.asn1
new file mode 100644
index 000000000000..621ab754fb9f
--- /dev/null
+++ b/crypto/ecdsasignature.asn1
@@ -0,0 +1,4 @@
+ECDSASignature ::= SEQUENCE {
+	r	INTEGER ({ ecdsa_get_signature_r }),
+	s	INTEGER ({ ecdsa_get_signature_s })
+}
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 321e38eef51b..2607602f9de5 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4913,6 +4913,18 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.kpp = __VECS(ecdh_tv_template)
 		}
+	}, {
+		.alg = "ecdsa-nist-p192",
+		.test = alg_test_akcipher,
+		.suite = {
+			.akcipher = __VECS(ecdsa_nist_p192_tv_template)
+		}
+	}, {
+		.alg = "ecdsa-nist-p256",
+		.test = alg_test_akcipher,
+		.suite = {
+			.akcipher = __VECS(ecdsa_nist_p256_tv_template)
+		}
 	}, {
 		.alg = "ecrdsa",
 		.test = alg_test_akcipher,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 8c83811c0e35..2adcc0dc0bdd 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -566,6 +566,273 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	}
 };
 
+/*
+ * ECDSA test vectors.
+ */
+static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
+	{
+	.key =
+	"\x04\xf7\x46\xf8\x2f\x15\xf6\x22\x8e\xd7\x57\x4f\xcc\xe7\xbb\xc1"
+	"\xd4\x09\x73\xcf\xea\xd0\x15\x07\x3d\xa5\x8a\x8a\x95\x43\xe4\x68"
+	"\xea\xc6\x25\xc1\xc1\x01\x25\x4c\x7e\xc3\x3c\xa6\x04\x0a\xe7\x08"
+	"\x98",
+	.key_len = 49,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x01",
+	.param_len = 21,
+	.m =
+	"\xcd\xb9\xd2\x1c\xb7\x6f\xcd\x44\xb3\xfd\x63\xea\xa3\x66\x7f\xae"
+	"\x63\x85\xe7\x82",
+	.m_size = 20,
+	.algo = OID_id_ecdsa_with_sha1,
+	.c =
+	"\x30\x35\x02\x19\x00\xba\xe5\x93\x83\x6e\xb6\x3b\x63\xa0\x27\x91"
+	"\xc6\xf6\x7f\xc3\x09\xad\x59\xad\x88\x27\xd6\x92\x6b\x02\x18\x10"
+	"\x68\x01\x9d\xba\xce\x83\x08\xef\x95\x52\x7b\xa0\x0f\xe4\x18\x86"
+	"\x80\x6f\xa5\x79\x77\xda\xd0",
+	.c_size = 55,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\xb6\x4b\xb1\xd1\xac\xba\x24\x8f\x65\xb2\x60\x00\x90\xbf\xbd"
+	"\x78\x05\x73\xe9\x79\x1d\x6f\x7c\x0b\xd2\xc3\x93\xa7\x28\xe1\x75"
+	"\xf7\xd5\x95\x1d\x28\x10\xc0\x75\x50\x5c\x1a\x4f\x3f\x8f\xa5\xee"
+	"\xa3",
+	.key_len = 49,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x01",
+	.param_len = 21,
+	.m =
+	"\x8d\xd6\xb8\x3e\xe5\xff\x23\xf6\x25\xa2\x43\x42\x74\x45\xa7\x40"
+	"\x3a\xff\x2f\xe1\xd3\xf6\x9f\xe8\x33\xcb\x12\x11",
+	.m_size = 28,
+	.algo = OID_id_ecdsa_with_sha224,
+	.c =
+	"\x30\x34\x02\x18\x5a\x8b\x82\x69\x7e\x8a\x0a\x09\x14\xf8\x11\x2b"
+	"\x55\xdc\xae\x37\x83\x7b\x12\xe6\xb6\x5b\xcb\xd4\x02\x18\x6a\x14"
+	"\x4f\x53\x75\xc8\x02\x48\xeb\xc3\x92\x0f\x1e\x72\xee\xc4\xa3\xe3"
+	"\x5c\x99\xdb\x92\x5b\x36",
+	.c_size = 54,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\xe2\x51\x24\x9b\xf7\xb6\x32\x82\x39\x66\x3d\x5b\xec\x3b\xae"
+	"\x0c\xd5\xf2\x67\xd1\xc7\xe1\x02\xe4\xbf\x90\x62\xb8\x55\x75\x56"
+	"\x69\x20\x5e\xcb\x4e\xca\x33\xd6\xcb\x62\x6b\x94\xa9\xa2\xe9\x58"
+	"\x91",
+	.key_len = 49,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x01",
+	.param_len = 21,
+	.m =
+	"\x35\xec\xa1\xa0\x9e\x14\xde\x33\x03\xb6\xf6\xbd\x0c\x2f\xb2\xfd"
+	"\x1f\x27\x82\xa5\xd7\x70\x3f\xef\xa0\x82\x69\x8e\x73\x31\x8e\xd7",
+	.m_size = 32,
+	.algo = OID_id_ecdsa_with_sha256,
+	.c =
+	"\x30\x35\x02\x18\x3f\x72\x3f\x1f\x42\xd2\x3f\x1d\x6b\x1a\x58\x56"
+	"\xf1\x8f\xf7\xfd\x01\x48\xfb\x5f\x72\x2a\xd4\x8f\x02\x19\x00\xb3"
+	"\x69\x43\xfd\x48\x19\x86\xcf\x32\xdd\x41\x74\x6a\x51\xc7\xd9\x7d"
+	"\x3a\x97\xd9\xcd\x1a\x6a\x49",
+	.c_size = 55,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\x5a\x13\xfe\x68\x86\x4d\xf4\x17\xc7\xa4\xe5\x8c\x65\x57\xb7"
+	"\x03\x73\x26\x57\xfb\xe5\x58\x40\xd8\xfd\x49\x05\xab\xf1\x66\x1f"
+	"\xe2\x9d\x93\x9e\xc2\x22\x5a\x8b\x4f\xf3\x77\x22\x59\x7e\xa6\x4e"
+	"\x8b",
+	.key_len = 49,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x01",
+	.param_len = 21,
+	.m =
+	"\x9d\x2e\x1a\x8f\xed\x6c\x4b\x61\xae\xac\xd5\x19\x79\xce\x67\xf9"
+	"\xa0\x34\xeb\xb0\x81\xf9\xd9\xdc\x6e\xb3\x5c\xa8\x69\xfc\x8a\x61"
+	"\x39\x81\xfb\xfd\x5c\x30\x6b\xa8\xee\xed\x89\xaf\xa3\x05\xe4\x78",
+	.m_size = 48,
+	.algo = OID_id_ecdsa_with_sha384,
+	.c =
+	"\x30\x35\x02\x19\x00\xf0\xa3\x38\xce\x2b\xf8\x9d\x1a\xcf\x7f\x34"
+	"\xb4\xb4\xe5\xc5\x00\xdd\x15\xbb\xd6\x8c\xa7\x03\x78\x02\x18\x64"
+	"\xbc\x5a\x1f\x82\x96\x61\xd7\xd1\x01\x77\x44\x5d\x53\xa4\x7c\x93"
+	"\x12\x3b\x3b\x28\xfb\x6d\xe1",
+	.c_size = 55,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\xd5\xf2\x6e\xc3\x94\x5c\x52\xbc\xdf\x86\x6c\x14\xd1\xca\xea"
+	"\xcc\x72\x3a\x8a\xf6\x7a\x3a\x56\x36\x3b\xca\xc6\x94\x0e\x17\x1d"
+	"\x9e\xa0\x58\x28\xf9\x4b\xe6\xd1\xa5\x44\x91\x35\x0d\xe7\xf5\x11"
+	"\x57",
+	.key_len = 49,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x01",
+	.param_len = 21,
+	.m =
+	"\xd5\x4b\xe9\x36\xda\xd8\x6e\xc0\x50\x03\xbe\x00\x43\xff\xf0\x23"
+	"\xac\xa2\x42\xe7\x37\x77\x79\x52\x8f\x3e\xc0\x16\xc1\xfc\x8c\x67"
+	"\x16\xbc\x8a\x5d\x3b\xd3\x13\xbb\xb6\xc0\x26\x1b\xeb\x33\xcc\x70"
+	"\x4a\xf2\x11\x37\xe8\x1b\xba\x55\xac\x69\xe1\x74\x62\x7c\x6e\xb5",
+	.m_size = 64,
+	.algo = OID_id_ecdsa_with_sha512,
+	.c =
+	"\x30\x35\x02\x19\x00\x88\x5b\x8f\x59\x43\xbf\xcf\xc6\xdd\x3f\x07"
+	"\x87\x12\xa0\xd4\xac\x2b\x11\x2d\x1c\xb6\x06\xc9\x6c\x02\x18\x73"
+	"\xb4\x22\x9a\x98\x73\x3c\x83\xa9\x14\x2a\x5e\xf5\xe5\xfb\x72\x28"
+	"\x6a\xdf\x97\xfd\x82\x76\x24",
+	.c_size = 55,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	},
+};
+
+static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
+	{
+	.key =
+	"\x04\xb9\x7b\xbb\xd7\x17\x64\xd2\x7e\xfc\x81\x5d\x87\x06\x83\x41"
+	"\x22\xd6\x9a\xaa\x87\x17\xec\x4f\x63\x55\x2f\x94\xba\xdd\x83\xe9"
+	"\x34\x4b\xf3\xe9\x91\x13\x50\xb6\xcb\xca\x62\x08\xe7\x3b\x09\xdc"
+	"\xc3\x63\x4b\x2d\xb9\x73\x53\xe4\x45\xe6\x7c\xad\xe7\x6b\xb0\xe8"
+	"\xaf",
+	.key_len = 65,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x07",
+	.param_len = 21,
+	.m =
+	"\xc2\x2b\x5f\x91\x78\x34\x26\x09\x42\x8d\x6f\x51\xb2\xc5\xaf\x4c"
+	"\x0b\xde\x6a\x42",
+	.m_size = 20,
+	.algo = OID_id_ecdsa_with_sha1,
+	.c =
+	"\x30\x46\x02\x21\x00\xf9\x25\xce\x9f\x3a\xa6\x35\x81\xcf\xd4\xe7"
+	"\xb7\xf0\x82\x56\x41\xf7\xd4\xad\x8d\x94\x5a\x69\x89\xee\xca\x6a"
+	"\x52\x0e\x48\x4d\xcc\x02\x21\x00\xd7\xe4\xef\x52\x66\xd3\x5b\x9d"
+	"\x8a\xfa\x54\x93\x29\xa7\x70\x86\xf1\x03\x03\xf3\x3b\xe2\x73\xf7"
+	"\xfb\x9d\x8b\xde\xd4\x8d\x6f\xad",
+	.c_size = 72,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\x8b\x6d\xc0\x33\x8e\x2d\x8b\x67\xf5\xeb\xc4\x7f\xa0\xf5\xd9"
+	"\x7b\x03\xa5\x78\x9a\xb5\xea\x14\xe4\x23\xd0\xaf\xd7\x0e\x2e\xa0"
+	"\xc9\x8b\xdb\x95\xf8\xb3\xaf\xac\x00\x2c\x2c\x1f\x7a\xfd\x95\x88"
+	"\x43\x13\xbf\xf3\x1c\x05\x1a\x14\x18\x09\x3f\xd6\x28\x3e\xc5\xa0"
+	"\xd4",
+	.key_len = 65,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x07",
+	.param_len = 21,
+	.m =
+	"\x1a\x15\xbc\xa3\xe4\xed\x3a\xb8\x23\x67\xc6\xc4\x34\xf8\x6c\x41"
+	"\x04\x0b\xda\xc5\x77\xfa\x1c\x2d\xe6\x2c\x3b\xe0",
+	.m_size = 28,
+	.algo = OID_id_ecdsa_with_sha224,
+	.c =
+	"\x30\x44\x02\x20\x20\x43\xfa\xc0\x9f\x9d\x7b\xe7\xae\xce\x77\x59"
+	"\x1a\xdb\x59\xd5\x34\x62\x79\xcb\x6a\x91\x67\x2e\x7d\x25\xd8\x25"
+	"\xf5\x81\xd2\x1e\x02\x20\x5f\xf8\x74\xf8\x57\xd0\x5e\x54\x76\x20"
+	"\x4a\x77\x22\xec\xc8\x66\xbf\x50\x05\x58\x39\x0e\x26\x92\xce\xd5"
+	"\x2e\x8b\xde\x5a\x04\x0e",
+	.c_size = 70,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\xf1\xea\xc4\x53\xf3\xb9\x0e\x9f\x7e\xad\xe3\xea\xd7\x0e\x0f"
+	"\xd6\x98\x9a\xca\x92\x4d\x0a\x80\xdb\x2d\x45\xc7\xec\x4b\x97\x00"
+	"\x2f\xe9\x42\x6c\x29\xdc\x55\x0e\x0b\x53\x12\x9b\x2b\xad\x2c\xe9"
+	"\x80\xe6\xc5\x43\xc2\x1d\x5e\xbb\x65\x21\x50\xb6\x37\xb0\x03\x8e"
+	"\xb8",
+	.key_len = 65,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x07",
+	.param_len = 21,
+	.m =
+	"\x8f\x43\x43\x46\x64\x8f\x6b\x96\xdf\x89\xdd\xa9\x01\xc5\x17\x6b"
+	"\x10\xa6\xd8\x39\x61\xdd\x3c\x1a\xc8\x8b\x59\xb2\xdc\x32\x7a\xa4",
+	.m_size = 32,
+	.algo = OID_id_ecdsa_with_sha256,
+	.c =
+	"\x30\x45\x02\x20\x08\x31\xfa\x74\x0d\x1d\x21\x5d\x09\xdc\x29\x63"
+	"\xa8\x1a\xad\xfc\xac\x44\xc3\xe8\x24\x11\x2d\xa4\x91\xdc\x02\x67"
+	"\xdc\x0c\xd0\x82\x02\x21\x00\xbd\xff\xce\xee\x42\xc3\x97\xff\xf9"
+	"\xa9\x81\xac\x4a\x50\xd0\x91\x0a\x6e\x1b\xc4\xaf\xe1\x83\xc3\x4f"
+	"\x2a\x65\x35\x23\xe3\x1d\xfa",
+	.c_size = 71,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\xc5\xc6\xea\x60\xc9\xce\xad\x02\x8d\xf5\x3e\x24\xe3\x52\x1d"
+	"\x28\x47\x3b\xc3\x6b\xa4\x99\x35\x99\x11\x88\x88\xc8\xf4\xee\x7e"
+	"\x8c\x33\x8f\x41\x03\x24\x46\x2b\x1a\x82\xf9\x9f\xe1\x97\x1b\x00"
+	"\xda\x3b\x24\x41\xf7\x66\x33\x58\x3d\x3a\x81\xad\xcf\x16\xe9\xe2"
+	"\x7c",
+	.key_len = 65,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x07",
+	.param_len = 21,
+	.m =
+	"\x3e\x78\x70\xfb\xcd\x66\xba\x91\xa1\x79\xff\x1e\x1c\x6b\x78\xe6"
+	"\xc0\x81\x3a\x65\x97\x14\x84\x36\x14\x1a\x9a\xb7\xc5\xab\x84\x94"
+	"\x5e\xbb\x1b\x34\x71\xcb\x41\xe1\xf6\xfc\x92\x7b\x34\xbb\x86\xbb",
+	.m_size = 48,
+	.algo = OID_id_ecdsa_with_sha384,
+	.c =
+	"\x30\x46\x02\x21\x00\x8e\xf3\x6f\xdc\xf8\x69\xa6\x2e\xd0\x2e\x95"
+	"\x54\xd1\x95\x64\x93\x08\xb2\x6b\x24\x94\x48\x46\x5e\xf2\xe4\x6c"
+	"\xc7\x94\xb1\xd5\xfe\x02\x21\x00\xeb\xa7\x80\x26\xdc\xf9\x3a\x44"
+	"\x19\xfb\x5f\x92\xf4\xc9\x23\x37\x69\xf4\x3b\x4f\x47\xcf\x9b\x16"
+	"\xc0\x60\x11\x92\xdc\x17\x89\x12",
+	.c_size = 72,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\xd7\x27\x46\x49\xf6\x26\x85\x12\x40\x76\x8e\xe2\xe6\x2a\x7a"
+	"\x83\xb1\x4e\x7a\xeb\x3b\x5c\x67\x4a\xb5\xa4\x92\x8c\x69\xff\x38"
+	"\xee\xd9\x4e\x13\x29\x59\xad\xde\x6b\xbb\x45\x31\xee\xfd\xd1\x1b"
+	"\x64\xd3\xb5\xfc\xaf\x9b\x4b\x88\x3b\x0e\xb7\xd6\xdf\xf1\xd5\x92"
+	"\xbf",
+	.key_len = 65,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x07",
+	.param_len = 21,
+	.m =
+	"\x57\xb7\x9e\xe9\x05\x0a\x8c\x1b\xc9\x13\xe5\x4a\x24\xc7\xe2\xe9"
+	"\x43\xc3\xd1\x76\x62\xf4\x98\x1a\x9c\x13\xb0\x20\x1b\xe5\x39\xca"
+	"\x4f\xd9\x85\x34\x95\xa2\x31\xbc\xbb\xde\xdd\x76\xbb\x61\xe3\xcf"
+	"\x9d\xc0\x49\x7a\xf3\x7a\xc4\x7d\xa8\x04\x4b\x8d\xb4\x4d\x5b\xd6",
+	.m_size = 64,
+	.algo = OID_id_ecdsa_with_sha512,
+	.c =
+	"\x30\x45\x02\x21\x00\xb8\x6d\x87\x81\x43\xdf\xfb\x9f\x40\xea\x44"
+	"\x81\x00\x4e\x29\x08\xed\x8c\x73\x30\x6c\x22\xb3\x97\x76\xf6\x04"
+	"\x99\x09\x37\x4d\xfa\x02\x20\x1e\xb9\x75\x31\xf6\x04\xa5\x4d\xf8"
+	"\x00\xdd\xab\xd4\xc0\x2b\xe6\x5c\xad\xc3\x78\x1c\xc2\xc1\x19\x76"
+	"\x31\x79\x4a\xe9\x81\x6a\xee",
+	.c_size = 71,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	},
+};
+
 /*
  * EC-RDSA test vectors are generated by gost-engine.
  */
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 4462ed2c18cd..59ad6109f918 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -21,6 +21,10 @@ enum OID {
 	OID_id_dsa,			/* 1.2.840.10040.4.1 */
 	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
 	OID_id_ecPublicKey,		/* 1.2.840.10045.2.1 */
+	OID_id_ecdsa_with_sha224,	/* 1.2.840.10045.4.3.1 */
+	OID_id_ecdsa_with_sha256,	/* 1.2.840.10045.4.3.2 */
+	OID_id_ecdsa_with_sha384,	/* 1.2.840.10045.4.3.3 */
+	OID_id_ecdsa_with_sha512,	/* 1.2.840.10045.4.3.4 */
 
 	/* PKCS#1 {iso(1) member-body(2) us(840) rsadsi(113549) pkcs(1) pkcs-1(1)} */
 	OID_rsaEncryption,		/* 1.2.840.113549.1.1.1 */
-- 
2.29.2

