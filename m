Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07653B29FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhFXILa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:11:30 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:46307 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231849AbhFXILX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:11:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0UdVdC4i_1624522138;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UdVdC4i_1624522138)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Jun 2021 16:08:58 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Markku-Juhani O . Saarinen" <mjos@iki.fi>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v2 1/4] crypto: sm4 - create SM4 library based on sm4 generic code
Date:   Thu, 24 Jun 2021 16:08:54 +0800
Message-Id: <20210624080857.126660-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20210624080857.126660-1-tianjia.zhang@linux.alibaba.com>
References: <20210624080857.126660-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take the existing small footprint and mostly time invariant C code
and turn it into a SM4 library that can be used for non-performance
critical, casual use of SM4, and as a fallback for, e.g., SIMD code
that needs a secondary path that can be taken in contexts where the
SIMD unit is off limits.

Secondly, some codes have been optimized, such as unrolling small
times loop, removing unnecessary memory shifts, exporting sbox, fk,
ck arrays, and basic encryption and decryption functions.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/Kconfig       |   1 +
 crypto/sm4_generic.c | 153 +----------------------------------
 include/crypto/sm4.h |  28 ++++++-
 lib/crypto/Kconfig   |   3 +
 lib/crypto/Makefile  |   3 +
 lib/crypto/sm4.c     | 184 +++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 220 insertions(+), 152 deletions(-)
 create mode 100644 lib/crypto/sm4.c

diff --git a/crypto/Kconfig b/crypto/Kconfig
index ca3b02dcbbfa..4fbc9c080ca9 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1547,6 +1547,7 @@ config CRYPTO_SERPENT_AVX2_X86_64
 config CRYPTO_SM4
 	tristate "SM4 cipher algorithm"
 	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_SM4
 	help
 	  SM4 cipher algorithms (OSCCA GB/T 32907-2016).
 
diff --git a/crypto/sm4_generic.c b/crypto/sm4_generic.c
index 016dbc595705..d19d01f852a9 100644
--- a/crypto/sm4_generic.c
+++ b/crypto/sm4_generic.c
@@ -16,139 +16,13 @@
 #include <asm/byteorder.h>
 #include <asm/unaligned.h>
 
-static const u32 fk[4] = {
-	0xa3b1bac6, 0x56aa3350, 0x677d9197, 0xb27022dc
-};
-
-static const u8 sbox[256] = {
-	0xd6, 0x90, 0xe9, 0xfe, 0xcc, 0xe1, 0x3d, 0xb7,
-	0x16, 0xb6, 0x14, 0xc2, 0x28, 0xfb, 0x2c, 0x05,
-	0x2b, 0x67, 0x9a, 0x76, 0x2a, 0xbe, 0x04, 0xc3,
-	0xaa, 0x44, 0x13, 0x26, 0x49, 0x86, 0x06, 0x99,
-	0x9c, 0x42, 0x50, 0xf4, 0x91, 0xef, 0x98, 0x7a,
-	0x33, 0x54, 0x0b, 0x43, 0xed, 0xcf, 0xac, 0x62,
-	0xe4, 0xb3, 0x1c, 0xa9, 0xc9, 0x08, 0xe8, 0x95,
-	0x80, 0xdf, 0x94, 0xfa, 0x75, 0x8f, 0x3f, 0xa6,
-	0x47, 0x07, 0xa7, 0xfc, 0xf3, 0x73, 0x17, 0xba,
-	0x83, 0x59, 0x3c, 0x19, 0xe6, 0x85, 0x4f, 0xa8,
-	0x68, 0x6b, 0x81, 0xb2, 0x71, 0x64, 0xda, 0x8b,
-	0xf8, 0xeb, 0x0f, 0x4b, 0x70, 0x56, 0x9d, 0x35,
-	0x1e, 0x24, 0x0e, 0x5e, 0x63, 0x58, 0xd1, 0xa2,
-	0x25, 0x22, 0x7c, 0x3b, 0x01, 0x21, 0x78, 0x87,
-	0xd4, 0x00, 0x46, 0x57, 0x9f, 0xd3, 0x27, 0x52,
-	0x4c, 0x36, 0x02, 0xe7, 0xa0, 0xc4, 0xc8, 0x9e,
-	0xea, 0xbf, 0x8a, 0xd2, 0x40, 0xc7, 0x38, 0xb5,
-	0xa3, 0xf7, 0xf2, 0xce, 0xf9, 0x61, 0x15, 0xa1,
-	0xe0, 0xae, 0x5d, 0xa4, 0x9b, 0x34, 0x1a, 0x55,
-	0xad, 0x93, 0x32, 0x30, 0xf5, 0x8c, 0xb1, 0xe3,
-	0x1d, 0xf6, 0xe2, 0x2e, 0x82, 0x66, 0xca, 0x60,
-	0xc0, 0x29, 0x23, 0xab, 0x0d, 0x53, 0x4e, 0x6f,
-	0xd5, 0xdb, 0x37, 0x45, 0xde, 0xfd, 0x8e, 0x2f,
-	0x03, 0xff, 0x6a, 0x72, 0x6d, 0x6c, 0x5b, 0x51,
-	0x8d, 0x1b, 0xaf, 0x92, 0xbb, 0xdd, 0xbc, 0x7f,
-	0x11, 0xd9, 0x5c, 0x41, 0x1f, 0x10, 0x5a, 0xd8,
-	0x0a, 0xc1, 0x31, 0x88, 0xa5, 0xcd, 0x7b, 0xbd,
-	0x2d, 0x74, 0xd0, 0x12, 0xb8, 0xe5, 0xb4, 0xb0,
-	0x89, 0x69, 0x97, 0x4a, 0x0c, 0x96, 0x77, 0x7e,
-	0x65, 0xb9, 0xf1, 0x09, 0xc5, 0x6e, 0xc6, 0x84,
-	0x18, 0xf0, 0x7d, 0xec, 0x3a, 0xdc, 0x4d, 0x20,
-	0x79, 0xee, 0x5f, 0x3e, 0xd7, 0xcb, 0x39, 0x48
-};
-
-static const u32 ck[] = {
-	0x00070e15, 0x1c232a31, 0x383f464d, 0x545b6269,
-	0x70777e85, 0x8c939aa1, 0xa8afb6bd, 0xc4cbd2d9,
-	0xe0e7eef5, 0xfc030a11, 0x181f262d, 0x343b4249,
-	0x50575e65, 0x6c737a81, 0x888f969d, 0xa4abb2b9,
-	0xc0c7ced5, 0xdce3eaf1, 0xf8ff060d, 0x141b2229,
-	0x30373e45, 0x4c535a61, 0x686f767d, 0x848b9299,
-	0xa0a7aeb5, 0xbcc3cad1, 0xd8dfe6ed, 0xf4fb0209,
-	0x10171e25, 0x2c333a41, 0x484f565d, 0x646b7279
-};
-
-static u32 sm4_t_non_lin_sub(u32 x)
-{
-	int i;
-	u8 *b = (u8 *)&x;
-
-	for (i = 0; i < 4; ++i)
-		b[i] = sbox[b[i]];
-
-	return x;
-}
-
-static u32 sm4_key_lin_sub(u32 x)
-{
-	return x ^ rol32(x, 13) ^ rol32(x, 23);
-
-}
-
-static u32 sm4_enc_lin_sub(u32 x)
-{
-	return x ^ rol32(x, 2) ^ rol32(x, 10) ^ rol32(x, 18) ^ rol32(x, 24);
-}
-
-static u32 sm4_key_sub(u32 x)
-{
-	return sm4_key_lin_sub(sm4_t_non_lin_sub(x));
-}
-
-static u32 sm4_enc_sub(u32 x)
-{
-	return sm4_enc_lin_sub(sm4_t_non_lin_sub(x));
-}
-
-static u32 sm4_round(const u32 *x, const u32 rk)
-{
-	return x[0] ^ sm4_enc_sub(x[1] ^ x[2] ^ x[3] ^ rk);
-}
-
-
-/**
- * crypto_sm4_expand_key - Expands the SM4 key as described in GB/T 32907-2016
- * @ctx:	The location where the computed key will be stored.
- * @in_key:	The supplied key.
- * @key_len:	The length of the supplied key.
- *
- * Returns 0 on success. The function fails only if an invalid key size (or
- * pointer) is supplied.
- */
-int crypto_sm4_expand_key(struct crypto_sm4_ctx *ctx, const u8 *in_key,
-			  unsigned int key_len)
-{
-	u32 rk[4], t;
-	const u32 *key = (u32 *)in_key;
-	int i;
-
-	if (key_len != SM4_KEY_SIZE)
-		return -EINVAL;
-
-	for (i = 0; i < 4; ++i)
-		rk[i] = get_unaligned_be32(&key[i]) ^ fk[i];
-
-	for (i = 0; i < 32; ++i) {
-		t = rk[0] ^ sm4_key_sub(rk[1] ^ rk[2] ^ rk[3] ^ ck[i]);
-		ctx->rkey_enc[i] = t;
-		rk[0] = rk[1];
-		rk[1] = rk[2];
-		rk[2] = rk[3];
-		rk[3] = t;
-	}
-
-	for (i = 0; i < 32; ++i)
-		ctx->rkey_dec[i] = ctx->rkey_enc[31 - i];
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(crypto_sm4_expand_key);
-
 /**
  * crypto_sm4_set_key - Set the SM4 key.
  * @tfm:	The %crypto_tfm that is used in the context.
  * @in_key:	The input key.
  * @key_len:	The size of the key.
  *
- * This function uses crypto_sm4_expand_key() to expand the key.
+ * This function uses sm4_expandkey() to expand the key.
  * &crypto_sm4_ctx _must_ be the private data embedded in @tfm which is
  * retrieved with crypto_tfm_ctx().
  *
@@ -159,36 +33,17 @@ int crypto_sm4_set_key(struct crypto_tfm *tfm, const u8 *in_key,
 {
 	struct crypto_sm4_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	return crypto_sm4_expand_key(ctx, in_key, key_len);
+	return sm4_expandkey(ctx, in_key, key_len);
 }
 EXPORT_SYMBOL_GPL(crypto_sm4_set_key);
 
-static void sm4_do_crypt(const u32 *rk, u32 *out, const u32 *in)
-{
-	u32 x[4], i, t;
-
-	for (i = 0; i < 4; ++i)
-		x[i] = get_unaligned_be32(&in[i]);
-
-	for (i = 0; i < 32; ++i) {
-		t = sm4_round(x, rk[i]);
-		x[0] = x[1];
-		x[1] = x[2];
-		x[2] = x[3];
-		x[3] = t;
-	}
-
-	for (i = 0; i < 4; ++i)
-		put_unaligned_be32(x[3 - i], &out[i]);
-}
-
 /* encrypt a block of text */
 
 void crypto_sm4_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
 	const struct crypto_sm4_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	sm4_do_crypt(ctx->rkey_enc, (u32 *)out, (u32 *)in);
+	sm4_crypt_block(ctx->rkey_enc, out, in);
 }
 EXPORT_SYMBOL_GPL(crypto_sm4_encrypt);
 
@@ -198,7 +53,7 @@ void crypto_sm4_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
 	const struct crypto_sm4_ctx *ctx = crypto_tfm_ctx(tfm);
 
-	sm4_do_crypt(ctx->rkey_dec, (u32 *)out, (u32 *)in);
+	sm4_crypt_block(ctx->rkey_dec, out, in);
 }
 EXPORT_SYMBOL_GPL(crypto_sm4_decrypt);
 
diff --git a/include/crypto/sm4.h b/include/crypto/sm4.h
index 7afd730d16ff..bef92bcb286c 100644
--- a/include/crypto/sm4.h
+++ b/include/crypto/sm4.h
@@ -3,6 +3,7 @@
 /*
  * Common values for the SM4 algorithm
  * Copyright (C) 2018 ARM Limited or its affiliates.
+ * Copyright (c) 2021 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
  */
 
 #ifndef _CRYPTO_SM4_H
@@ -20,11 +21,32 @@ struct crypto_sm4_ctx {
 	u32 rkey_dec[SM4_RKEY_WORDS];
 };
 
-int crypto_sm4_set_key(struct crypto_tfm *tfm, const u8 *in_key,
-		       unsigned int key_len);
-int crypto_sm4_expand_key(struct crypto_sm4_ctx *ctx, const u8 *in_key,
+extern const u32 sm4_fk[];
+extern const u32 sm4_ck[];
+extern const u8 sm4_sbox[];
+
+/**
+ * sm4_expandkey - Expands the SM4 key as described in GB/T 32907-2016
+ * @ctx:	The location where the computed key will be stored.
+ * @in_key:	The supplied key.
+ * @key_len:	The length of the supplied key.
+ *
+ * Returns 0 on success. The function fails only if an invalid key size (or
+ * pointer) is supplied.
+ */
+int sm4_expandkey(struct crypto_sm4_ctx *ctx, const u8 *in_key,
 			  unsigned int key_len);
 
+/**
+ * sm4_crypt_block - Encrypt or decrypt a single SM4 block
+ * @rk:		The rkey_enc for encrypt or rkey_dec for decrypt
+ * @out:	Buffer to store output data
+ * @in: 	Buffer containing the input data
+ */
+void sm4_crypt_block(const u32 *rk, u8 *out, const u8 *in);
+
+int crypto_sm4_set_key(struct crypto_tfm *tfm, const u8 *in_key,
+		       unsigned int key_len);
 void crypto_sm4_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in);
 void crypto_sm4_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in);
 
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 14c032de276e..545ccbddf6a1 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -128,3 +128,6 @@ config CRYPTO_LIB_CHACHA20POLY1305
 
 config CRYPTO_LIB_SHA256
 	tristate
+
+config CRYPTO_LIB_SM4
+	tristate
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 3a435629d9ce..73205ed269ba 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -38,6 +38,9 @@ libpoly1305-y					+= poly1305.o
 obj-$(CONFIG_CRYPTO_LIB_SHA256)			+= libsha256.o
 libsha256-y					:= sha256.o
 
+obj-$(CONFIG_CRYPTO_LIB_SM4)			+= libsm4.o
+libsm4-y					:= sm4.o
+
 ifneq ($(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS),y)
 libblake2s-y					+= blake2s-selftest.o
 libchacha20poly1305-y				+= chacha20poly1305-selftest.o
diff --git a/lib/crypto/sm4.c b/lib/crypto/sm4.c
new file mode 100644
index 000000000000..b2ade92bc4db
--- /dev/null
+++ b/lib/crypto/sm4.c
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM4, as specified in
+ * https://tools.ietf.org/id/draft-ribose-cfrg-sm4-10.html
+ *
+ * Copyright (C) 2018 ARM Limited or its affiliates.
+ * Copyright (c) 2021 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+#include <linux/module.h>
+#include <asm/unaligned.h>
+#include <crypto/sm4.h>
+
+static const u32 fk[4] = {
+	0xa3b1bac6, 0x56aa3350, 0x677d9197, 0xb27022dc
+};
+
+static const u32 __cacheline_aligned ck[32] = {
+	0x00070e15, 0x1c232a31, 0x383f464d, 0x545b6269,
+	0x70777e85, 0x8c939aa1, 0xa8afb6bd, 0xc4cbd2d9,
+	0xe0e7eef5, 0xfc030a11, 0x181f262d, 0x343b4249,
+	0x50575e65, 0x6c737a81, 0x888f969d, 0xa4abb2b9,
+	0xc0c7ced5, 0xdce3eaf1, 0xf8ff060d, 0x141b2229,
+	0x30373e45, 0x4c535a61, 0x686f767d, 0x848b9299,
+	0xa0a7aeb5, 0xbcc3cad1, 0xd8dfe6ed, 0xf4fb0209,
+	0x10171e25, 0x2c333a41, 0x484f565d, 0x646b7279
+};
+
+static const u8 __cacheline_aligned sbox[256] = {
+	0xd6, 0x90, 0xe9, 0xfe, 0xcc, 0xe1, 0x3d, 0xb7,
+	0x16, 0xb6, 0x14, 0xc2, 0x28, 0xfb, 0x2c, 0x05,
+	0x2b, 0x67, 0x9a, 0x76, 0x2a, 0xbe, 0x04, 0xc3,
+	0xaa, 0x44, 0x13, 0x26, 0x49, 0x86, 0x06, 0x99,
+	0x9c, 0x42, 0x50, 0xf4, 0x91, 0xef, 0x98, 0x7a,
+	0x33, 0x54, 0x0b, 0x43, 0xed, 0xcf, 0xac, 0x62,
+	0xe4, 0xb3, 0x1c, 0xa9, 0xc9, 0x08, 0xe8, 0x95,
+	0x80, 0xdf, 0x94, 0xfa, 0x75, 0x8f, 0x3f, 0xa6,
+	0x47, 0x07, 0xa7, 0xfc, 0xf3, 0x73, 0x17, 0xba,
+	0x83, 0x59, 0x3c, 0x19, 0xe6, 0x85, 0x4f, 0xa8,
+	0x68, 0x6b, 0x81, 0xb2, 0x71, 0x64, 0xda, 0x8b,
+	0xf8, 0xeb, 0x0f, 0x4b, 0x70, 0x56, 0x9d, 0x35,
+	0x1e, 0x24, 0x0e, 0x5e, 0x63, 0x58, 0xd1, 0xa2,
+	0x25, 0x22, 0x7c, 0x3b, 0x01, 0x21, 0x78, 0x87,
+	0xd4, 0x00, 0x46, 0x57, 0x9f, 0xd3, 0x27, 0x52,
+	0x4c, 0x36, 0x02, 0xe7, 0xa0, 0xc4, 0xc8, 0x9e,
+	0xea, 0xbf, 0x8a, 0xd2, 0x40, 0xc7, 0x38, 0xb5,
+	0xa3, 0xf7, 0xf2, 0xce, 0xf9, 0x61, 0x15, 0xa1,
+	0xe0, 0xae, 0x5d, 0xa4, 0x9b, 0x34, 0x1a, 0x55,
+	0xad, 0x93, 0x32, 0x30, 0xf5, 0x8c, 0xb1, 0xe3,
+	0x1d, 0xf6, 0xe2, 0x2e, 0x82, 0x66, 0xca, 0x60,
+	0xc0, 0x29, 0x23, 0xab, 0x0d, 0x53, 0x4e, 0x6f,
+	0xd5, 0xdb, 0x37, 0x45, 0xde, 0xfd, 0x8e, 0x2f,
+	0x03, 0xff, 0x6a, 0x72, 0x6d, 0x6c, 0x5b, 0x51,
+	0x8d, 0x1b, 0xaf, 0x92, 0xbb, 0xdd, 0xbc, 0x7f,
+	0x11, 0xd9, 0x5c, 0x41, 0x1f, 0x10, 0x5a, 0xd8,
+	0x0a, 0xc1, 0x31, 0x88, 0xa5, 0xcd, 0x7b, 0xbd,
+	0x2d, 0x74, 0xd0, 0x12, 0xb8, 0xe5, 0xb4, 0xb0,
+	0x89, 0x69, 0x97, 0x4a, 0x0c, 0x96, 0x77, 0x7e,
+	0x65, 0xb9, 0xf1, 0x09, 0xc5, 0x6e, 0xc6, 0x84,
+	0x18, 0xf0, 0x7d, 0xec, 0x3a, 0xdc, 0x4d, 0x20,
+	0x79, 0xee, 0x5f, 0x3e, 0xd7, 0xcb, 0x39, 0x48
+};
+
+extern const u32 sm4_fk[4] __alias(fk);
+extern const u32 sm4_ck[32] __alias(ck);
+extern const u8 sm4_sbox[256] __alias(sbox);
+
+EXPORT_SYMBOL(sm4_fk);
+EXPORT_SYMBOL(sm4_ck);
+EXPORT_SYMBOL(sm4_sbox);
+
+static inline u32 sm4_t_non_lin_sub(u32 x)
+{
+	u32 out;
+
+	out  = (u32)sbox[x & 0xff];
+	out |= (u32)sbox[(x >> 8) & 0xff] << 8;
+	out |= (u32)sbox[(x >> 16) & 0xff] << 16;
+	out |= (u32)sbox[(x >> 24) & 0xff] << 24;
+
+	return out;
+}
+
+static inline u32 sm4_key_lin_sub(u32 x)
+{
+	return x ^ rol32(x, 13) ^ rol32(x, 23);
+}
+
+static inline u32 sm4_enc_lin_sub(u32 x)
+{
+	return x ^ rol32(x, 2) ^ rol32(x, 10) ^ rol32(x, 18) ^ rol32(x, 24);
+}
+
+static inline u32 sm4_key_sub(u32 x)
+{
+	return sm4_key_lin_sub(sm4_t_non_lin_sub(x));
+}
+
+static inline u32 sm4_enc_sub(u32 x)
+{
+	return sm4_enc_lin_sub(sm4_t_non_lin_sub(x));
+}
+
+static inline u32 sm4_round(u32 x0, u32 x1, u32 x2, u32 x3, u32 rk)
+{
+	return x0 ^ sm4_enc_sub(x1 ^ x2 ^ x3 ^ rk);
+}
+
+
+/**
+ * sm4_expandkey - Expands the SM4 key as described in GB/T 32907-2016
+ * @ctx:	The location where the computed key will be stored.
+ * @in_key:	The supplied key.
+ * @key_len:	The length of the supplied key.
+ *
+ * Returns 0 on success. The function fails only if an invalid key size (or
+ * pointer) is supplied.
+ */
+int sm4_expandkey(struct crypto_sm4_ctx *ctx, const u8 *in_key,
+			  unsigned int key_len)
+{
+	u32 rk[4];
+	const u32 *key = (u32 *)in_key;
+	int i;
+
+	if (key_len != SM4_KEY_SIZE)
+		return -EINVAL;
+
+	rk[0] = get_unaligned_be32(&key[0]) ^ fk[0];
+	rk[1] = get_unaligned_be32(&key[1]) ^ fk[1];
+	rk[2] = get_unaligned_be32(&key[2]) ^ fk[2];
+	rk[3] = get_unaligned_be32(&key[3]) ^ fk[3];
+
+	for (i = 0; i < 32; i += 4) {
+		rk[0] ^= sm4_key_sub(rk[1] ^ rk[2] ^ rk[3] ^ ck[i + 0]);
+		rk[1] ^= sm4_key_sub(rk[2] ^ rk[3] ^ rk[0] ^ ck[i + 1]);
+		rk[2] ^= sm4_key_sub(rk[3] ^ rk[0] ^ rk[1] ^ ck[i + 2]);
+		rk[3] ^= sm4_key_sub(rk[0] ^ rk[1] ^ rk[2] ^ ck[i + 3]);
+
+		ctx->rkey_enc[i + 0] = rk[0];
+		ctx->rkey_enc[i + 1] = rk[1];
+		ctx->rkey_enc[i + 2] = rk[2];
+		ctx->rkey_enc[i + 3] = rk[3];
+		ctx->rkey_dec[31 - 0 - i] = rk[0];
+		ctx->rkey_dec[31 - 1 - i] = rk[1];
+		ctx->rkey_dec[31 - 2 - i] = rk[2];
+		ctx->rkey_dec[31 - 3 - i] = rk[3];
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(sm4_expandkey);
+
+/**
+ * sm4_crypt_block - Encrypt or decrypt a single SM4 block
+ * @rk:		The rkey_enc for encrypt or rkey_dec for decrypt
+ * @out:	Buffer to store output data
+ * @in: 	Buffer containing the input data
+ */
+void sm4_crypt_block(const u32 *rk, u8 *out, const u8 *in)
+{
+	u32 x[4], i;
+
+	x[0] = get_unaligned_be32(in + 0 * 4);
+	x[1] = get_unaligned_be32(in + 1 * 4);
+	x[2] = get_unaligned_be32(in + 2 * 4);
+	x[3] = get_unaligned_be32(in + 3 * 4);
+
+	for (i = 0; i < 32; i += 4) {
+		x[0] = sm4_round(x[0], x[1], x[2], x[3], rk[i + 0]);
+		x[1] = sm4_round(x[1], x[2], x[3], x[0], rk[i + 1]);
+		x[2] = sm4_round(x[2], x[3], x[0], x[1], rk[i + 2]);
+		x[3] = sm4_round(x[3], x[0], x[1], x[2], rk[i + 3]);
+	}
+
+	put_unaligned_be32(x[3 - 0], out + 0 * 4);
+	put_unaligned_be32(x[3 - 1], out + 1 * 4);
+	put_unaligned_be32(x[3 - 2], out + 2 * 4);
+	put_unaligned_be32(x[3 - 3], out + 3 * 4);
+}
+EXPORT_SYMBOL_GPL(sm4_crypt_block);
+
+MODULE_DESCRIPTION("Generic SM4 library");
+MODULE_LICENSE("GPL v2");
-- 
2.19.1.3.ge56e4f7

