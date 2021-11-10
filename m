Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1068C44B9ED
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 02:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhKJBZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 20:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhKJBZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 20:25:43 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6749EC061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 17:22:56 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so397595pja.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 17:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wl7faxE53/iAzWsLqHmIEzd9rKFTjxg92eUzdY+R6V8=;
        b=cnSGLcjO+P0IuJlqxSVd//qxR28ex+f/xUcD50Hfo3tBhtFdNVeARx+mSt4ZwQw4Z1
         9zayXOejS+DWRag1WacWXrJrkekBuFL/3r8I8GfbQr9rx3FZG/HQeYy7Z0rF0mmRPs9Z
         n5kYG83103X78PkpHsOC795f+4AJcYnpcNEQ93uD5KjzzCjPHjTOadEmcF+r9lX9cT+9
         353/vd0KFW4p+BZJ9wtdic9O5TB3V1gmem0kCI+4AbnYwiOcmqiFfHDWCekLj1/pYoJn
         xCuEyNNzpODs1TQ6EcTB1qu5Lk/ryI187lEJgPMWnnDdiH4xYtoovfTyrRKVJtOT3whi
         68zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wl7faxE53/iAzWsLqHmIEzd9rKFTjxg92eUzdY+R6V8=;
        b=bGvfCKEmWOBVjJkV9Erpgi7hixyFu4cY7Yw88QGLZIkD+7AvKKJcG3HbRtbVt4FBCY
         7X4pbGdrPoRSbGR+z5/kVd0JUOTp7bckkQb0F7OzxkEf90yxorA8qYPPEL0BchzTPBPV
         biYcr9Fuy8VU1alMQB5nQru7dh64Lvlz0K1f0o2ZG6AlJCplUa7Mi/b6beTn7jE3wG0B
         4TkdMznyqtYFp+95EcVRN8xbaQZwVFQ70qRZX10U/z0pvNNoFRtDJqzsKDb2rN05sq7F
         1zIzQkmy4ORDxYI/cDpCT9/GOYc8KCzGFuPYN1/dxa2IH3VFyShbgHOQDLiPSUuHpYqx
         gslw==
X-Gm-Message-State: AOAM530UYt6T0e5Z/F917tqIq5ZqeWiq1dXCinQsZ5M8ApGv0UVV62uK
        Xom7TmJjgELBzS5dmrBvt6s=
X-Google-Smtp-Source: ABdhPJwozwn1Rl2wnLDsJ3BoIZKOVdjB/00cU5WC37kW+Efaxs4Y4iWDWMS/SWCZuTM0i/+AtJk3gQ==
X-Received: by 2002:a17:90b:1bc4:: with SMTP id oa4mr12502978pjb.179.1636507375813;
        Tue, 09 Nov 2021 17:22:55 -0800 (PST)
Received: from edumazet1.svl.corp.google.com ([2620:15c:2c4:201:362:8fd3:5950:cf6d])
        by smtp.gmail.com with ESMTPSA id h2sm3614037pjk.44.2021.11.09.17.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 17:22:55 -0800 (PST)
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
Subject: [PATCH 1/2] jump_label: use DEFINE_STATIC_KEY_FALSE_RO() where possible
Date:   Tue,  9 Nov 2021 17:09:05 -0800
Message-Id: <20211110010906.1923210-2-eric.dumazet@gmail.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
In-Reply-To: <20211110010906.1923210-1-eric.dumazet@gmail.com>
References: <20211110010906.1923210-1-eric.dumazet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

Use DEFINE_STATIC_KEY_FALSE_RO(X) instead of
__ro_after_init DEFINE_STATIC_KEY_FALSE(X)

This is in preparation for following patch,
and is a functional nop.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 arch/arm/crypto/chacha-glue.c        | 2 +-
 arch/arm/crypto/curve25519-glue.c    | 2 +-
 arch/arm/crypto/ghash-ce-glue.c      | 2 +-
 arch/arm/crypto/poly1305-glue.c      | 2 +-
 arch/arm64/crypto/chacha-neon-glue.c | 2 +-
 arch/arm64/crypto/poly1305-glue.c    | 2 +-
 arch/powerpc/mm/book3s64/slb.c       | 2 +-
 arch/riscv/kernel/cpufeature.c       | 2 +-
 arch/x86/crypto/aesni-intel_glue.c   | 4 ++--
 arch/x86/crypto/blake2s-glue.c       | 4 ++--
 arch/x86/crypto/chacha_glue.c        | 6 +++---
 arch/x86/crypto/curve25519-x86_64.c  | 2 +-
 arch/x86/crypto/poly1305_glue.c      | 6 +++---
 crypto/aegis128-core.c               | 2 +-
 14 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/crypto/chacha-glue.c b/arch/arm/crypto/chacha-glue.c
index cdde8fd01f8f9b167e9ab7a7da1d8fff595197bc..31294e28be96d1a0f5b00114efe4baabe934646f 100644
--- a/arch/arm/crypto/chacha-glue.c
+++ b/arch/arm/crypto/chacha-glue.c
@@ -30,7 +30,7 @@ asmlinkage void hchacha_block_neon(const u32 *state, u32 *out, int nrounds);
 asmlinkage void chacha_doarm(u8 *dst, const u8 *src, unsigned int bytes,
 			     const u32 *state, int nrounds);
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(use_neon);
+static DEFINE_STATIC_KEY_FALSE_RO(use_neon);
 
 static inline bool neon_usable(void)
 {
diff --git a/arch/arm/crypto/curve25519-glue.c b/arch/arm/crypto/curve25519-glue.c
index 9bdafd57888c859f580ffbcadfd3b63070e8c780..9c41ee494bf37bdf298b24e4750836409c3e37cf 100644
--- a/arch/arm/crypto/curve25519-glue.c
+++ b/arch/arm/crypto/curve25519-glue.c
@@ -23,7 +23,7 @@ asmlinkage void curve25519_neon(u8 mypublic[CURVE25519_KEY_SIZE],
 				const u8 secret[CURVE25519_KEY_SIZE],
 				const u8 basepoint[CURVE25519_KEY_SIZE]);
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
+static DEFINE_STATIC_KEY_FALSE_RO(have_neon);
 
 void curve25519_arch(u8 out[CURVE25519_KEY_SIZE],
 		     const u8 scalar[CURVE25519_KEY_SIZE],
diff --git a/arch/arm/crypto/ghash-ce-glue.c b/arch/arm/crypto/ghash-ce-glue.c
index f13401f3e6693211c95e266d9676c79710755ebf..7bcede16b770635373b4b57e2609cd95822f6c84 100644
--- a/arch/arm/crypto/ghash-ce-glue.c
+++ b/arch/arm/crypto/ghash-ce-glue.c
@@ -48,7 +48,7 @@ asmlinkage void pmull_ghash_update_p64(int blocks, u64 dg[], const char *src,
 asmlinkage void pmull_ghash_update_p8(int blocks, u64 dg[], const char *src,
 				      u64 const h[][2], const char *head);
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(use_p64);
+static DEFINE_STATIC_KEY_FALSE_RO(use_p64);
 
 static int ghash_init(struct shash_desc *desc)
 {
diff --git a/arch/arm/crypto/poly1305-glue.c b/arch/arm/crypto/poly1305-glue.c
index c31bd8f7c0927e5226984b6573c3d4d76a1d445c..6f90cb56b76233c5ebb3d86834dbd02d78243871 100644
--- a/arch/arm/crypto/poly1305-glue.c
+++ b/arch/arm/crypto/poly1305-glue.c
@@ -27,7 +27,7 @@ void __weak poly1305_blocks_neon(void *state, const u8 *src, u32 len, u32 hibit)
 {
 }
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
+static DEFINE_STATIC_KEY_FALSE_RO(have_neon);
 
 void poly1305_init_arch(struct poly1305_desc_ctx *dctx, const u8 key[POLY1305_KEY_SIZE])
 {
diff --git a/arch/arm64/crypto/chacha-neon-glue.c b/arch/arm64/crypto/chacha-neon-glue.c
index af2bbca38e70fb3514bf594cafffbf907c8eeffa..7af3bad091554fb5f40801948df62d6b4ae0ac72 100644
--- a/arch/arm64/crypto/chacha-neon-glue.c
+++ b/arch/arm64/crypto/chacha-neon-glue.c
@@ -37,7 +37,7 @@ asmlinkage void chacha_4block_xor_neon(u32 *state, u8 *dst, const u8 *src,
 				       int nrounds, int bytes);
 asmlinkage void hchacha_block_neon(const u32 *state, u32 *out, int nrounds);
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
+static DEFINE_STATIC_KEY_FALSE_RO(have_neon);
 
 static void chacha_doneon(u32 *state, u8 *dst, const u8 *src,
 			  int bytes, int nrounds)
diff --git a/arch/arm64/crypto/poly1305-glue.c b/arch/arm64/crypto/poly1305-glue.c
index 9c3d86e397bf3a1fd9302c0a3057913f9a6ed9ca..efa8a0ce3c1a4262d3910aa4a4e2823be53f5dae 100644
--- a/arch/arm64/crypto/poly1305-glue.c
+++ b/arch/arm64/crypto/poly1305-glue.c
@@ -23,7 +23,7 @@ asmlinkage void poly1305_blocks(void *state, const u8 *src, u32 len, u32 hibit);
 asmlinkage void poly1305_blocks_neon(void *state, const u8 *src, u32 len, u32 hibit);
 asmlinkage void poly1305_emit(void *state, u8 *digest, const u32 *nonce);
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_neon);
+static DEFINE_STATIC_KEY_FALSE_RO(have_neon);
 
 void poly1305_init_arch(struct poly1305_desc_ctx *dctx, const u8 key[POLY1305_KEY_SIZE])
 {
diff --git a/arch/powerpc/mm/book3s64/slb.c b/arch/powerpc/mm/book3s64/slb.c
index f0037bcc47a0eb57a6f3aaf9062fa0bb43843705..ed17fd9753532853550212289561cbabe49985ab 100644
--- a/arch/powerpc/mm/book3s64/slb.c
+++ b/arch/powerpc/mm/book3s64/slb.c
@@ -40,7 +40,7 @@ static int __init parse_stress_slb(char *p)
 }
 early_param("stress_slb", parse_stress_slb);
 
-__ro_after_init DEFINE_STATIC_KEY_FALSE(stress_slb_key);
+DEFINE_STATIC_KEY_FALSE_RO(stress_slb_key);
 
 static void assert_slb_presence(bool present, unsigned long ea)
 {
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index d959d207a40d6cbe5662833b36cf222a3a750eb6..439ef56d183d08a0f1dbccae50e928d9a2241e40 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -19,7 +19,7 @@ unsigned long elf_hwcap __read_mostly;
 static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __read_mostly;
 
 #ifdef CONFIG_FPU
-__ro_after_init DEFINE_STATIC_KEY_FALSE(cpu_hwcap_fpu);
+DEFINE_STATIC_KEY_FALSE_RO(cpu_hwcap_fpu);
 #endif
 
 /**
diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index e09f4672dd382f5ac5c6d95a80592653de072072..66e7a5cc6b61c0f783be93bf6bdb24c5acf179be 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -181,8 +181,8 @@ asmlinkage void aesni_gcm_finalize_avx_gen4(void *ctx,
 				   struct gcm_context_data *gdata,
 				   u8 *auth_tag, unsigned long auth_tag_len);
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(gcm_use_avx);
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(gcm_use_avx2);
+static DEFINE_STATIC_KEY_FALSE_RO(gcm_use_avx);
+static DEFINE_STATIC_KEY_FALSE_RO(gcm_use_avx2);
 
 static inline struct
 aesni_rfc4106_gcm_ctx *aesni_rfc4106_gcm_ctx_get(struct crypto_aead *tfm)
diff --git a/arch/x86/crypto/blake2s-glue.c b/arch/x86/crypto/blake2s-glue.c
index a40365ab301eef7ad3bb86083c02700943f0956a..cbbb3974e3e8526554f29bbed087f8663f4d7ab2 100644
--- a/arch/x86/crypto/blake2s-glue.c
+++ b/arch/x86/crypto/blake2s-glue.c
@@ -25,8 +25,8 @@ asmlinkage void blake2s_compress_avx512(struct blake2s_state *state,
 					const u8 *block, const size_t nblocks,
 					const u32 inc);
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(blake2s_use_ssse3);
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(blake2s_use_avx512);
+static DEFINE_STATIC_KEY_FALSE_RO(blake2s_use_ssse3);
+static DEFINE_STATIC_KEY_FALSE_RO(blake2s_use_avx512);
 
 void blake2s_compress_arch(struct blake2s_state *state,
 			   const u8 *block, size_t nblocks,
diff --git a/arch/x86/crypto/chacha_glue.c b/arch/x86/crypto/chacha_glue.c
index 7b3a1cf0984be3149ad9ec57b166aa9f4233a671..c2a03c6dd49b52f1b18423f63fd6bf5deca13218 100644
--- a/arch/x86/crypto/chacha_glue.c
+++ b/arch/x86/crypto/chacha_glue.c
@@ -35,9 +35,9 @@ asmlinkage void chacha_4block_xor_avx512vl(u32 *state, u8 *dst, const u8 *src,
 asmlinkage void chacha_8block_xor_avx512vl(u32 *state, u8 *dst, const u8 *src,
 					   unsigned int len, int nrounds);
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(chacha_use_simd);
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(chacha_use_avx2);
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(chacha_use_avx512vl);
+static DEFINE_STATIC_KEY_FALSE_RO(chacha_use_simd);
+static DEFINE_STATIC_KEY_FALSE_RO(chacha_use_avx2);
+static DEFINE_STATIC_KEY_FALSE_RO(chacha_use_avx512vl);
 
 static unsigned int chacha_advance(unsigned int len, unsigned int maxblocks)
 {
diff --git a/arch/x86/crypto/curve25519-x86_64.c b/arch/x86/crypto/curve25519-x86_64.c
index 38caf61cd5b7d59b0180a0260e5962b6790f29ad..2be656f0ac20363e0ed072ec5b852d6ee7fbdc1c 100644
--- a/arch/x86/crypto/curve25519-x86_64.c
+++ b/arch/x86/crypto/curve25519-x86_64.c
@@ -1378,7 +1378,7 @@ static void curve25519_ever64_base(u8 *out, const u8 *priv)
 	memzero_explicit(tmp, sizeof(tmp));
 }
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(curve25519_use_bmi2_adx);
+static DEFINE_STATIC_KEY_FALSE_RO(curve25519_use_bmi2_adx);
 
 void curve25519_arch(u8 mypublic[CURVE25519_KEY_SIZE],
 		     const u8 secret[CURVE25519_KEY_SIZE],
diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index 1dfb8af48a3caa7ae7a406b8dbf30ccabc840a20..b47568f086aef7c5e90e0a46be14569c3045a75b 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -30,9 +30,9 @@ asmlinkage void poly1305_blocks_avx2(void *ctx, const u8 *inp, const size_t len,
 asmlinkage void poly1305_blocks_avx512(void *ctx, const u8 *inp,
 				       const size_t len, const u32 padbit);
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(poly1305_use_avx);
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(poly1305_use_avx2);
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(poly1305_use_avx512);
+static DEFINE_STATIC_KEY_FALSE_RO(poly1305_use_avx);
+static DEFINE_STATIC_KEY_FALSE_RO(poly1305_use_avx2);
+static DEFINE_STATIC_KEY_FALSE_RO(poly1305_use_avx512);
 
 struct poly1305_arch_internal {
 	union {
diff --git a/crypto/aegis128-core.c b/crypto/aegis128-core.c
index c4f1bfa1d04fa9eb00fc55cfaa89ed0690a45607..60c8dfb1c736bdda9ae0eca9970218175eaf2564 100644
--- a/crypto/aegis128-core.c
+++ b/crypto/aegis128-core.c
@@ -36,7 +36,7 @@ struct aegis_ctx {
 	union aegis_block key;
 };
 
-static __ro_after_init DEFINE_STATIC_KEY_FALSE(have_simd);
+static DEFINE_STATIC_KEY_FALSE_RO(have_simd);
 
 static const union aegis_block crypto_aegis_const[2] = {
 	{ .words64 = {
-- 
2.34.0.rc0.344.g81b53c2807-goog

