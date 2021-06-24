Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1C83B29FC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbhFXILX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:11:23 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:33912 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231788AbhFXILV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:11:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0UdVaAd4_1624522139;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UdVaAd4_1624522139)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Jun 2021 16:08:59 +0800
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
Subject: [PATCH v2 3/4] crypto: x86/sm4 - add AES-NI/AVX/x86_64 implementation
Date:   Thu, 24 Jun 2021 16:08:56 +0800
Message-Id: <20210624080857.126660-4-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20210624080857.126660-1-tianjia.zhang@linux.alibaba.com>
References: <20210624080857.126660-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds AES-NI/AVX/x86_64 assembler implementation of SM4
block cipher. Through two affine transforms, we can use the AES S-Box
to simulate the SM4 S-Box to achieve the effect of instruction
acceleration.

The main algorithm implementation comes from SM4 AES-NI work by
libgcrypt and Markku-Juhani O. Saarinen at:
https://github.com/mjosaarinen/sm4ni

This optimization supports the four modes of SM4, ECB, CBC, CFB, and
CTR. Since CBC and CFB do not support multiple block parallel
encryption, the optimization effect is not obvious.

Benchmark on Intel Xeon Cascadelake, the data comes from the 218 mode
and 518 mode of tcrypt. The abscissas are blocks of different lengths.
The data is tabulated and the unit is Mb/s:

sm4-generic   |    16      64     128     256    1024    1420    4096
      ECB enc | 40.99   46.50   48.05   48.41   49.20   49.25   49.28
      ECB dec | 41.07   46.99   48.15   48.67   49.20   49.25   49.29
      CBC enc | 37.71   45.28   46.77   47.60   48.32   48.37   48.40
      CBC dec | 36.48   44.82   46.43   47.45   48.23   48.30   48.36
      CFB enc | 37.94   44.84   46.12   46.94   47.57   47.46   47.68
      CFB dec | 37.50   42.84   43.74   44.37   44.85   44.80   44.96
      CTR enc | 39.20   45.63   46.75   47.49   48.09   47.85   48.08
      CTR dec | 39.64   45.70   46.72   47.47   47.98   47.88   48.06
sm4-aesni-avx
      ECB enc | 33.75  134.47  221.64  243.43  264.05  251.58  258.13
      ECB dec | 34.02  134.92  223.11  245.14  264.12  251.04  258.33
      CBC enc | 38.85   46.18   47.67   48.34   49.00   48.96   49.14
      CBC dec | 33.54  131.29  223.88  245.27  265.50  252.41  263.78
      CFB enc | 38.70   46.10   47.58   48.29   49.01   48.94   49.19
      CFB dec | 32.79  128.40  223.23  244.87  265.77  253.31  262.79
      CTR enc | 32.58  122.23  220.29  241.16  259.57  248.32  256.69
      CTR dec | 32.81  122.47  218.99  241.54  258.42  248.58  256.61

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/x86/crypto/Makefile               |   3 +
 arch/x86/crypto/sm4-aesni-avx-asm_64.S | 684 +++++++++++++++++++++++++
 arch/x86/crypto/sm4_aesni_avx_glue.c   | 537 +++++++++++++++++++
 crypto/Kconfig                         |  21 +
 4 files changed, 1245 insertions(+)
 create mode 100644 arch/x86/crypto/sm4-aesni-avx-asm_64.S
 create mode 100644 arch/x86/crypto/sm4_aesni_avx_glue.c

diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index d0959e7b809f..08f95d4e1e7c 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -88,6 +88,9 @@ nhpoly1305-avx2-y := nh-avx2-x86_64.o nhpoly1305-avx2-glue.o
 
 obj-$(CONFIG_CRYPTO_CURVE25519_X86) += curve25519-x86_64.o
 
+obj-$(CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64) += sm4-aesni-avx-x86_64.o
+sm4-aesni-avx-x86_64-y := sm4-aesni-avx-asm_64.o sm4_aesni_avx_glue.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $< > $@
 $(obj)/%.S: $(src)/%.pl FORCE
diff --git a/arch/x86/crypto/sm4-aesni-avx-asm_64.S b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
new file mode 100644
index 000000000000..27316cb3f7d8
--- /dev/null
+++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
@@ -0,0 +1,684 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM4 Cipher Algorithm, AES-NI/AVX optimized.
+ * as specified in
+ * https://tools.ietf.org/id/draft-ribose-cfrg-sm4-10.html
+ *
+ * Copyright (C) 2018 Markku-Juhani O. Saarinen <mjos@iki.fi>
+ * Copyright (C) 2020 Jussi Kivilinna <jussi.kivilinna@iki.fi>
+ * Copyright (c) 2021 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+/* Based on SM4 AES-NI work by libgcrypt and Markku-Juhani O. Saarinen at:
+ *  https://github.com/mjosaarinen/sm4ni
+ */
+
+#include <linux/linkage.h>
+#include <asm/frame.h>
+
+#define rRIP         (%rip)
+
+#define RX0          %xmm0
+#define RX1          %xmm1
+#define MASK_4BIT    %xmm2
+#define RTMP0        %xmm3
+#define RTMP1        %xmm4
+#define RTMP2        %xmm5
+#define RTMP3        %xmm6
+#define RTMP4        %xmm7
+
+#define RA0          %xmm8
+#define RA1          %xmm9
+#define RA2          %xmm10
+#define RA3          %xmm11
+
+#define RB0          %xmm12
+#define RB1          %xmm13
+#define RB2          %xmm14
+#define RB3          %xmm15
+
+#define RNOT         %xmm0
+#define RBSWAP       %xmm1
+
+
+/* Transpose four 32-bit words between 128-bit vectors. */
+#define transpose_4x4(x0, x1, x2, x3, t1, t2) \
+	vpunpckhdq x1, x0, t2;                \
+	vpunpckldq x1, x0, x0;                \
+	                                      \
+	vpunpckldq x3, x2, t1;                \
+	vpunpckhdq x3, x2, x2;                \
+	                                      \
+	vpunpckhqdq t1, x0, x1;               \
+	vpunpcklqdq t1, x0, x0;               \
+	                                      \
+	vpunpckhqdq x2, t2, x3;               \
+	vpunpcklqdq x2, t2, x2;
+
+/* pre-SubByte transform. */
+#define transform_pre(x, lo_t, hi_t, mask4bit, tmp0) \
+	vpand x, mask4bit, tmp0;                     \
+	vpandn x, mask4bit, x;                       \
+	vpsrld $4, x, x;                             \
+	                                             \
+	vpshufb tmp0, lo_t, tmp0;                    \
+	vpshufb x, hi_t, x;                          \
+	vpxor tmp0, x, x;
+
+/* post-SubByte transform. Note: x has been XOR'ed with mask4bit by
+ * 'vaeslastenc' instruction.
+ */
+#define transform_post(x, lo_t, hi_t, mask4bit, tmp0) \
+	vpandn mask4bit, x, tmp0;                     \
+	vpsrld $4, x, x;                              \
+	vpand x, mask4bit, x;                         \
+	                                              \
+	vpshufb tmp0, lo_t, tmp0;                     \
+	vpshufb x, hi_t, x;                           \
+	vpxor tmp0, x, x;
+
+
+.section	.rodata.cst164, "aM", @progbits, 164
+.align 16
+
+/*
+ * Following four affine transform look-up tables are from work by
+ * Markku-Juhani O. Saarinen, at https://github.com/mjosaarinen/sm4ni
+ *
+ * These allow exposing SM4 S-Box from AES SubByte.
+ */
+
+/* pre-SubByte affine transform, from SM4 field to AES field. */
+.Lpre_tf_lo_s:
+	.quad 0x9197E2E474720701, 0xC7C1B4B222245157
+.Lpre_tf_hi_s:
+	.quad 0xE240AB09EB49A200, 0xF052B91BF95BB012
+
+/* post-SubByte affine transform, from AES field to SM4 field. */
+.Lpost_tf_lo_s:
+	.quad 0x5B67F2CEA19D0834, 0xEDD14478172BBE82
+.Lpost_tf_hi_s:
+	.quad 0xAE7201DD73AFDC00, 0x11CDBE62CC1063BF
+
+/* For isolating SubBytes from AESENCLAST, inverse shift row */
+.Linv_shift_row:
+	.byte 0x00, 0x0d, 0x0a, 0x07, 0x04, 0x01, 0x0e, 0x0b
+	.byte 0x08, 0x05, 0x02, 0x0f, 0x0c, 0x09, 0x06, 0x03
+
+/* Inverse shift row + Rotate left by 8 bits on 32-bit words with vpshufb */
+.Linv_shift_row_rol_8:
+	.byte 0x07, 0x00, 0x0d, 0x0a, 0x0b, 0x04, 0x01, 0x0e
+	.byte 0x0f, 0x08, 0x05, 0x02, 0x03, 0x0c, 0x09, 0x06
+
+/* Inverse shift row + Rotate left by 16 bits on 32-bit words with vpshufb */
+.Linv_shift_row_rol_16:
+	.byte 0x0a, 0x07, 0x00, 0x0d, 0x0e, 0x0b, 0x04, 0x01
+	.byte 0x02, 0x0f, 0x08, 0x05, 0x06, 0x03, 0x0c, 0x09
+
+/* Inverse shift row + Rotate left by 24 bits on 32-bit words with vpshufb */
+.Linv_shift_row_rol_24:
+	.byte 0x0d, 0x0a, 0x07, 0x00, 0x01, 0x0e, 0x0b, 0x04
+	.byte 0x05, 0x02, 0x0f, 0x08, 0x09, 0x06, 0x03, 0x0c
+
+/* For CTR-mode IV byteswap */
+.Lbswap128_mask:
+	.byte 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0
+
+/* For input word byte-swap */
+.Lbswap32_mask:
+	.byte 3, 2, 1, 0, 7, 6, 5, 4, 11, 10, 9, 8, 15, 14, 13, 12
+
+.align 4
+/* 4-bit mask */
+.L0f0f0f0f:
+	.long 0x0f0f0f0f
+
+
+.text
+.align 16
+
+/*
+ * void sm4_aesni_avx_expand_key(const u8 *key, u32 *rk_enc,
+ *                  u32 *rk_dec, const u32 *fk, const u32 *ck);
+ */
+.align 8
+SYM_FUNC_START(sm4_aesni_avx_expand_key)
+	/* input:
+	 *	%rdi: 128-bit key
+	 *	%rsi: rkey_enc
+	 *	%rdx: rkey_dec
+	 *	%rcx: fk array
+	 *	%r8: ck array
+	 */
+	FRAME_BEGIN
+
+	vmovd 0*4(%rdi), RA0;
+	vmovd 1*4(%rdi), RA1;
+	vmovd 2*4(%rdi), RA2;
+	vmovd 3*4(%rdi), RA3;
+
+	vmovdqa .Lbswap32_mask rRIP, RTMP2;
+	vpshufb RTMP2, RA0, RA0;
+	vpshufb RTMP2, RA1, RA1;
+	vpshufb RTMP2, RA2, RA2;
+	vpshufb RTMP2, RA3, RA3;
+
+	vmovd 0*4(%rcx), RB0;
+	vmovd 1*4(%rcx), RB1;
+	vmovd 2*4(%rcx), RB2;
+	vmovd 3*4(%rcx), RB3;
+	vpxor RB0, RA0, RA0;
+	vpxor RB1, RA1, RA1;
+	vpxor RB2, RA2, RA2;
+	vpxor RB3, RA3, RA3;
+
+	vbroadcastss .L0f0f0f0f rRIP, MASK_4BIT;
+	vmovdqa .Lpre_tf_lo_s rRIP, RTMP4;
+	vmovdqa .Lpre_tf_hi_s rRIP, RB0;
+	vmovdqa .Lpost_tf_lo_s rRIP, RB1;
+	vmovdqa .Lpost_tf_hi_s rRIP, RB2;
+	vmovdqa .Linv_shift_row rRIP, RB3;
+
+#define ROUND(round, s0, s1, s2, s3)                              \
+	vbroadcastss (4*(round))(%r8), RX0;                       \
+	vpxor s1, RX0, RX0;                                       \
+	vpxor s2, RX0, RX0;                                       \
+	vpxor s3, RX0, RX0; /* s1 ^ s2 ^ s3 ^ rk */               \
+	                                                          \
+	/* sbox, non-linear part */                               \
+	transform_pre(RX0, RTMP4, RB0, MASK_4BIT, RTMP0);         \
+	vaesenclast MASK_4BIT, RX0, RX0;                          \
+	transform_post(RX0, RB1, RB2, MASK_4BIT, RTMP0);          \
+	                                                          \
+	/* linear part */                                         \
+	vpshufb RB3, RX0, RX0;                                    \
+	vpxor RX0, s0, s0; /* s0 ^ x */                           \
+	vpslld $13, RX0, RTMP0;                                   \
+	vpsrld $19, RX0, RTMP1;                                   \
+	vpslld $23, RX0, RTMP2;                                   \
+	vpsrld $9, RX0, RTMP3;                                    \
+	vpxor RTMP0, RTMP1, RTMP1;                                \
+	vpxor RTMP2, RTMP3, RTMP3;                                \
+	vpxor RTMP1, s0, s0; /* s0 ^ x ^ rol(x,13) */             \
+	vpxor RTMP3, s0, s0; /* s0 ^ x ^ rol(x,13) ^ rol(x,23) */
+
+	leaq (32*4)(%r8), %rax;
+	leaq (32*4)(%rdx), %rdx;
+.align 16
+.Lroundloop_expand_key:
+	leaq (-4*4)(%rdx), %rdx;
+	ROUND(0, RA0, RA1, RA2, RA3);
+	ROUND(1, RA1, RA2, RA3, RA0);
+	ROUND(2, RA2, RA3, RA0, RA1);
+	ROUND(3, RA3, RA0, RA1, RA2);
+	leaq (4*4)(%r8), %r8;
+	vmovd RA0, (0*4)(%rsi);
+	vmovd RA1, (1*4)(%rsi);
+	vmovd RA2, (2*4)(%rsi);
+	vmovd RA3, (3*4)(%rsi);
+	vmovd RA0, (3*4)(%rdx);
+	vmovd RA1, (2*4)(%rdx);
+	vmovd RA2, (1*4)(%rdx);
+	vmovd RA3, (0*4)(%rdx);
+	leaq (4*4)(%rsi), %rsi;
+	cmpq %rax, %r8;
+	jne .Lroundloop_expand_key;
+
+#undef ROUND
+
+	vzeroall;
+	FRAME_END
+	ret;
+SYM_FUNC_END(sm4_aesni_avx_expand_key)
+
+
+/*
+ * void sm4_aesni_avx_crypt4(const u32 *rk, u8 *dst,
+ *                           const u8 *src, int nblocks)
+ */
+.align 8
+SYM_FUNC_START(sm4_aesni_avx_crypt4)
+	/* input:
+	 *	%rdi: round key array, CTX
+	 *	%rsi: dst (1..4 blocks)
+	 *	%rdx: src (1..4 blocks)
+	 *	%rcx: num blocks (1..4)
+	 */
+	FRAME_BEGIN
+
+	vmovdqu 0*16(%rdx), RA0;
+	vmovdqa RA0, RA1;
+	vmovdqa RA0, RA2;
+	vmovdqa RA0, RA3;
+	cmpq $2, %rcx;
+	jb .Lblk4_load_input_done;
+	vmovdqu 1*16(%rdx), RA1;
+	je .Lblk4_load_input_done;
+	vmovdqu 2*16(%rdx), RA2;
+	cmpq $3, %rcx;
+	je .Lblk4_load_input_done;
+	vmovdqu 3*16(%rdx), RA3;
+
+.Lblk4_load_input_done:
+
+	vmovdqa .Lbswap32_mask rRIP, RTMP2;
+	vpshufb RTMP2, RA0, RA0;
+	vpshufb RTMP2, RA1, RA1;
+	vpshufb RTMP2, RA2, RA2;
+	vpshufb RTMP2, RA3, RA3;
+
+	vbroadcastss .L0f0f0f0f rRIP, MASK_4BIT;
+	vmovdqa .Lpre_tf_lo_s rRIP, RTMP4;
+	vmovdqa .Lpre_tf_hi_s rRIP, RB0;
+	vmovdqa .Lpost_tf_lo_s rRIP, RB1;
+	vmovdqa .Lpost_tf_hi_s rRIP, RB2;
+	vmovdqa .Linv_shift_row rRIP, RB3;
+	vmovdqa .Linv_shift_row_rol_8 rRIP, RTMP2;
+	vmovdqa .Linv_shift_row_rol_16 rRIP, RTMP3;
+	transpose_4x4(RA0, RA1, RA2, RA3, RTMP0, RTMP1);
+
+#define ROUND(round, s0, s1, s2, s3)                                \
+	vbroadcastss (4*(round))(%rdi), RX0;                        \
+	vpxor s1, RX0, RX0;                                         \
+	vpxor s2, RX0, RX0;                                         \
+	vpxor s3, RX0, RX0; /* s1 ^ s2 ^ s3 ^ rk */                 \
+	                                                            \
+	/* sbox, non-linear part */                                 \
+	transform_pre(RX0, RTMP4, RB0, MASK_4BIT, RTMP0);           \
+	vaesenclast MASK_4BIT, RX0, RX0;                            \
+	transform_post(RX0, RB1, RB2, MASK_4BIT, RTMP0);            \
+	                                                            \
+	/* linear part */                                           \
+	vpshufb RB3, RX0, RTMP0;                                    \
+	vpxor RTMP0, s0, s0; /* s0 ^ x */                           \
+	vpshufb RTMP2, RX0, RTMP1;                                  \
+	vpxor RTMP1, RTMP0, RTMP0; /* x ^ rol(x,8) */               \
+	vpshufb RTMP3, RX0, RTMP1;                                  \
+	vpxor RTMP1, RTMP0, RTMP0; /* x ^ rol(x,8) ^ rol(x,16) */   \
+	vpshufb .Linv_shift_row_rol_24 rRIP, RX0, RTMP1;            \
+	vpxor RTMP1, s0, s0; /* s0 ^ x ^ rol(x,24) */               \
+	vpslld $2, RTMP0, RTMP1;                                    \
+	vpsrld $30, RTMP0, RTMP0;                                   \
+	vpxor RTMP0, s0, s0;                                        \
+	/* s0 ^ x ^ rol(x,2) ^ rol(x,10) ^ rol(x,18) ^ rol(x,24) */ \
+	vpxor RTMP1, s0, s0;
+
+	leaq (32*4)(%rdi), %rax;
+.align 16
+.Lroundloop_blk4:
+	ROUND(0, RA0, RA1, RA2, RA3);
+	ROUND(1, RA1, RA2, RA3, RA0);
+	ROUND(2, RA2, RA3, RA0, RA1);
+	ROUND(3, RA3, RA0, RA1, RA2);
+	leaq (4*4)(%rdi), %rdi;
+	cmpq %rax, %rdi;
+	jne .Lroundloop_blk4;
+
+#undef ROUND
+
+	vmovdqa .Lbswap128_mask rRIP, RTMP2;
+
+	transpose_4x4(RA0, RA1, RA2, RA3, RTMP0, RTMP1);
+	vpshufb RTMP2, RA0, RA0;
+	vpshufb RTMP2, RA1, RA1;
+	vpshufb RTMP2, RA2, RA2;
+	vpshufb RTMP2, RA3, RA3;
+
+	vmovdqu RA0, 0*16(%rsi);
+	cmpq $2, %rcx;
+	jb .Lblk4_store_output_done;
+	vmovdqu RA1, 1*16(%rsi);
+	je .Lblk4_store_output_done;
+	vmovdqu RA2, 2*16(%rsi);
+	cmpq $3, %rcx;
+	je .Lblk4_store_output_done;
+	vmovdqu RA3, 3*16(%rsi);
+
+.Lblk4_store_output_done:
+	vzeroall;
+	FRAME_END
+	ret;
+SYM_FUNC_END(sm4_aesni_avx_crypt4)
+
+.align 8
+SYM_FUNC_START_LOCAL(__sm4_crypt_blk8)
+	/* input:
+	 *	%rdi: round key array, CTX
+	 *	RA0, RA1, RA2, RA3, RB0, RB1, RB2, RB3: eight parallel
+	 *						plaintext blocks
+	 * output:
+	 *	RA0, RA1, RA2, RA3, RB0, RB1, RB2, RB3: eight parallel
+	 * 						ciphertext blocks
+	 */
+	FRAME_BEGIN
+
+	vmovdqa .Lbswap32_mask rRIP, RTMP2;
+	vpshufb RTMP2, RA0, RA0;
+	vpshufb RTMP2, RA1, RA1;
+	vpshufb RTMP2, RA2, RA2;
+	vpshufb RTMP2, RA3, RA3;
+	vpshufb RTMP2, RB0, RB0;
+	vpshufb RTMP2, RB1, RB1;
+	vpshufb RTMP2, RB2, RB2;
+	vpshufb RTMP2, RB3, RB3;
+
+	vbroadcastss .L0f0f0f0f rRIP, MASK_4BIT;
+	transpose_4x4(RA0, RA1, RA2, RA3, RTMP0, RTMP1);
+	transpose_4x4(RB0, RB1, RB2, RB3, RTMP0, RTMP1);
+
+#define ROUND(round, s0, s1, s2, s3, r0, r1, r2, r3)                \
+	vbroadcastss (4*(round))(%rdi), RX0;                        \
+	vmovdqa .Lpre_tf_lo_s rRIP, RTMP4;                          \
+	vmovdqa .Lpre_tf_hi_s rRIP, RTMP1;                          \
+	vmovdqa RX0, RX1;                                           \
+	vpxor s1, RX0, RX0;                                         \
+	vpxor s2, RX0, RX0;                                         \
+	vpxor s3, RX0, RX0; /* s1 ^ s2 ^ s3 ^ rk */                 \
+	vmovdqa .Lpost_tf_lo_s rRIP, RTMP2;                         \
+	vmovdqa .Lpost_tf_hi_s rRIP, RTMP3;                         \
+	vpxor r1, RX1, RX1;                                         \
+	vpxor r2, RX1, RX1;                                         \
+	vpxor r3, RX1, RX1; /* r1 ^ r2 ^ r3 ^ rk */                 \
+                                                                    \
+	/* sbox, non-linear part */                                 \
+	transform_pre(RX0, RTMP4, RTMP1, MASK_4BIT, RTMP0);         \
+	transform_pre(RX1, RTMP4, RTMP1, MASK_4BIT, RTMP0);         \
+	vmovdqa .Linv_shift_row rRIP, RTMP4;                        \
+	vaesenclast MASK_4BIT, RX0, RX0;                            \
+	vaesenclast MASK_4BIT, RX1, RX1;                            \
+	transform_post(RX0, RTMP2, RTMP3, MASK_4BIT, RTMP0);        \
+	transform_post(RX1, RTMP2, RTMP3, MASK_4BIT, RTMP0);        \
+                                                                    \
+	/* linear part */                                           \
+	vpshufb RTMP4, RX0, RTMP0;                                  \
+	vpxor RTMP0, s0, s0; /* s0 ^ x */                           \
+	vpshufb RTMP4, RX1, RTMP2;                                  \
+	vmovdqa .Linv_shift_row_rol_8 rRIP, RTMP4;                  \
+	vpxor RTMP2, r0, r0; /* r0 ^ x */                           \
+	vpshufb RTMP4, RX0, RTMP1;                                  \
+	vpxor RTMP1, RTMP0, RTMP0; /* x ^ rol(x,8) */               \
+	vpshufb RTMP4, RX1, RTMP3;                                  \
+	vmovdqa .Linv_shift_row_rol_16 rRIP, RTMP4;                 \
+	vpxor RTMP3, RTMP2, RTMP2; /* x ^ rol(x,8) */               \
+	vpshufb RTMP4, RX0, RTMP1;                                  \
+	vpxor RTMP1, RTMP0, RTMP0; /* x ^ rol(x,8) ^ rol(x,16) */   \
+	vpshufb RTMP4, RX1, RTMP3;                                  \
+	vmovdqa .Linv_shift_row_rol_24 rRIP, RTMP4;                 \
+	vpxor RTMP3, RTMP2, RTMP2; /* x ^ rol(x,8) ^ rol(x,16) */   \
+	vpshufb RTMP4, RX0, RTMP1;                                  \
+	vpxor RTMP1, s0, s0; /* s0 ^ x ^ rol(x,24) */               \
+	/* s0 ^ x ^ rol(x,2) ^ rol(x,10) ^ rol(x,18) ^ rol(x,24) */ \
+	vpslld $2, RTMP0, RTMP1;                                    \
+	vpsrld $30, RTMP0, RTMP0;                                   \
+	vpxor RTMP0, s0, s0;                                        \
+	vpxor RTMP1, s0, s0;                                        \
+	vpshufb RTMP4, RX1, RTMP3;                                  \
+	vpxor RTMP3, r0, r0; /* r0 ^ x ^ rol(x,24) */               \
+	/* r0 ^ x ^ rol(x,2) ^ rol(x,10) ^ rol(x,18) ^ rol(x,24) */ \
+	vpslld $2, RTMP2, RTMP3;                                    \
+	vpsrld $30, RTMP2, RTMP2;                                   \
+	vpxor RTMP2, r0, r0;                                        \
+	vpxor RTMP3, r0, r0;
+
+	leaq (32*4)(%rdi), %rax;
+.align 16
+.Lroundloop_blk8:
+	ROUND(0, RA0, RA1, RA2, RA3, RB0, RB1, RB2, RB3);
+	ROUND(1, RA1, RA2, RA3, RA0, RB1, RB2, RB3, RB0);
+	ROUND(2, RA2, RA3, RA0, RA1, RB2, RB3, RB0, RB1);
+	ROUND(3, RA3, RA0, RA1, RA2, RB3, RB0, RB1, RB2);
+	leaq (4*4)(%rdi), %rdi;
+	cmpq %rax, %rdi;
+	jne .Lroundloop_blk8;
+
+#undef ROUND
+
+	vmovdqa .Lbswap128_mask rRIP, RTMP2;
+
+	transpose_4x4(RA0, RA1, RA2, RA3, RTMP0, RTMP1);
+	transpose_4x4(RB0, RB1, RB2, RB3, RTMP0, RTMP1);
+	vpshufb RTMP2, RA0, RA0;
+	vpshufb RTMP2, RA1, RA1;
+	vpshufb RTMP2, RA2, RA2;
+	vpshufb RTMP2, RA3, RA3;
+	vpshufb RTMP2, RB0, RB0;
+	vpshufb RTMP2, RB1, RB1;
+	vpshufb RTMP2, RB2, RB2;
+	vpshufb RTMP2, RB3, RB3;
+
+	FRAME_END
+	ret;
+SYM_FUNC_END(__sm4_crypt_blk8)
+
+/*
+ * void sm4_aesni_avx_crypt8(const u32 *rk, u8 *dst,
+ *                           const u8 *src, int nblocks)
+ */
+.align 8
+SYM_FUNC_START(sm4_aesni_avx_crypt8)
+	/* input:
+	 *	%rdi: round key array, CTX
+	 *	%rsi: dst (1..8 blocks)
+	 *	%rdx: src (1..8 blocks)
+	 *	%rcx: num blocks (1..8)
+	 */
+	FRAME_BEGIN
+
+	cmpq $5, %rcx;
+	jb sm4_aesni_avx_crypt4;
+	vmovdqu (0 * 16)(%rdx), RA0;
+	vmovdqu (1 * 16)(%rdx), RA1;
+	vmovdqu (2 * 16)(%rdx), RA2;
+	vmovdqu (3 * 16)(%rdx), RA3;
+	vmovdqu (4 * 16)(%rdx), RB0;
+	vmovdqa RB0, RB1;
+	vmovdqa RB0, RB2;
+	vmovdqa RB0, RB3;
+	je .Lblk8_load_input_done;
+	vmovdqu (5 * 16)(%rdx), RB1;
+	cmpq $7, %rcx;
+	jb .Lblk8_load_input_done;
+	vmovdqu (6 * 16)(%rdx), RB2;
+	je .Lblk8_load_input_done;
+	vmovdqu (7 * 16)(%rdx), RB3;
+
+.Lblk8_load_input_done:
+	call __sm4_crypt_blk8;
+
+	cmpq $6, %rcx;
+	vmovdqu RA0, (0 * 16)(%rsi);
+	vmovdqu RA1, (1 * 16)(%rsi);
+	vmovdqu RA2, (2 * 16)(%rsi);
+	vmovdqu RA3, (3 * 16)(%rsi);
+	vmovdqu RB0, (4 * 16)(%rsi);
+	jb .Lblk8_store_output_done;
+	vmovdqu RB1, (5 * 16)(%rsi);
+	je .Lblk8_store_output_done;
+	vmovdqu RB2, (6 * 16)(%rsi);
+	cmpq $7, %rcx;
+	je .Lblk8_store_output_done;
+	vmovdqu RB3, (7 * 16)(%rsi);
+
+.Lblk8_store_output_done:
+	vzeroall;
+	FRAME_END
+	ret;
+SYM_FUNC_END(sm4_aesni_avx_crypt8)
+
+/*
+ * void sm4_aesni_avx_ctr_enc_blk8(const u32 *rk, u8 *dst,
+ *                                 const u8 *src, u8 *iv)
+ */
+.align 8
+SYM_FUNC_START(sm4_aesni_avx_ctr_enc_blk8)
+	/* input:
+	 *	%rdi: round key array, CTX
+	 *	%rsi: dst (8 blocks)
+	 *	%rdx: src (8 blocks)
+	 *	%rcx: iv (big endian, 128bit)
+	 */
+	FRAME_BEGIN
+
+	/* load IV and byteswap */
+	vmovdqu (%rcx), RA0;
+
+	vmovdqa .Lbswap128_mask rRIP, RBSWAP;
+	vpshufb RBSWAP, RA0, RTMP0; /* be => le */
+
+	vpcmpeqd RNOT, RNOT, RNOT;
+	vpsrldq $8, RNOT, RNOT; /* low: -1, high: 0 */
+
+#define inc_le128(x, minus_one, tmp) \
+	vpcmpeqq minus_one, x, tmp;  \
+	vpsubq minus_one, x, x;      \
+	vpslldq $8, tmp, tmp;        \
+	vpsubq tmp, x, x;
+
+	/* construct IVs */
+	inc_le128(RTMP0, RNOT, RTMP2); /* +1 */
+	vpshufb RBSWAP, RTMP0, RA1;
+	inc_le128(RTMP0, RNOT, RTMP2); /* +2 */
+	vpshufb RBSWAP, RTMP0, RA2;
+	inc_le128(RTMP0, RNOT, RTMP2); /* +3 */
+	vpshufb RBSWAP, RTMP0, RA3;
+	inc_le128(RTMP0, RNOT, RTMP2); /* +4 */
+	vpshufb RBSWAP, RTMP0, RB0;
+	inc_le128(RTMP0, RNOT, RTMP2); /* +5 */
+	vpshufb RBSWAP, RTMP0, RB1;
+	inc_le128(RTMP0, RNOT, RTMP2); /* +6 */
+	vpshufb RBSWAP, RTMP0, RB2;
+	inc_le128(RTMP0, RNOT, RTMP2); /* +7 */
+	vpshufb RBSWAP, RTMP0, RB3;
+	inc_le128(RTMP0, RNOT, RTMP2); /* +8 */
+	vpshufb RBSWAP, RTMP0, RTMP1;
+
+	/* store new IV */
+	vmovdqu RTMP1, (%rcx);
+
+	call __sm4_crypt_blk8;
+
+	vpxor (0 * 16)(%rdx), RA0, RA0;
+	vpxor (1 * 16)(%rdx), RA1, RA1;
+	vpxor (2 * 16)(%rdx), RA2, RA2;
+	vpxor (3 * 16)(%rdx), RA3, RA3;
+	vpxor (4 * 16)(%rdx), RB0, RB0;
+	vpxor (5 * 16)(%rdx), RB1, RB1;
+	vpxor (6 * 16)(%rdx), RB2, RB2;
+	vpxor (7 * 16)(%rdx), RB3, RB3;
+
+	vmovdqu RA0, (0 * 16)(%rsi);
+	vmovdqu RA1, (1 * 16)(%rsi);
+	vmovdqu RA2, (2 * 16)(%rsi);
+	vmovdqu RA3, (3 * 16)(%rsi);
+	vmovdqu RB0, (4 * 16)(%rsi);
+	vmovdqu RB1, (5 * 16)(%rsi);
+	vmovdqu RB2, (6 * 16)(%rsi);
+	vmovdqu RB3, (7 * 16)(%rsi);
+
+	vzeroall;
+	FRAME_END
+	ret;
+SYM_FUNC_END(sm4_aesni_avx_ctr_enc_blk8)
+
+/*
+ * void sm4_aesni_avx_cbc_dec_blk8(const u32 *rk, u8 *dst,
+ *                                 const u8 *src, u8 *iv)
+ */
+.align 8
+SYM_FUNC_START(sm4_aesni_avx_cbc_dec_blk8)
+	/* input:
+	 *	%rdi: round key array, CTX
+	 *	%rsi: dst (8 blocks)
+	 *	%rdx: src (8 blocks)
+	 *	%rcx: iv
+	 */
+	FRAME_BEGIN
+
+	vmovdqu (0 * 16)(%rdx), RA0;
+	vmovdqu (1 * 16)(%rdx), RA1;
+	vmovdqu (2 * 16)(%rdx), RA2;
+	vmovdqu (3 * 16)(%rdx), RA3;
+	vmovdqu (4 * 16)(%rdx), RB0;
+	vmovdqu (5 * 16)(%rdx), RB1;
+	vmovdqu (6 * 16)(%rdx), RB2;
+	vmovdqu (7 * 16)(%rdx), RB3;
+
+	call __sm4_crypt_blk8;
+
+	vmovdqu (7 * 16)(%rdx), RNOT;
+	vpxor (%rcx), RA0, RA0;
+	vpxor (0 * 16)(%rdx), RA1, RA1;
+	vpxor (1 * 16)(%rdx), RA2, RA2;
+	vpxor (2 * 16)(%rdx), RA3, RA3;
+	vpxor (3 * 16)(%rdx), RB0, RB0;
+	vpxor (4 * 16)(%rdx), RB1, RB1;
+	vpxor (5 * 16)(%rdx), RB2, RB2;
+	vpxor (6 * 16)(%rdx), RB3, RB3;
+	vmovdqu RNOT, (%rcx); /* store new IV */
+
+	vmovdqu RA0, (0 * 16)(%rsi);
+	vmovdqu RA1, (1 * 16)(%rsi);
+	vmovdqu RA2, (2 * 16)(%rsi);
+	vmovdqu RA3, (3 * 16)(%rsi);
+	vmovdqu RB0, (4 * 16)(%rsi);
+	vmovdqu RB1, (5 * 16)(%rsi);
+	vmovdqu RB2, (6 * 16)(%rsi);
+	vmovdqu RB3, (7 * 16)(%rsi);
+
+	vzeroall;
+	FRAME_END
+	ret;
+SYM_FUNC_END(sm4_aesni_avx_cbc_dec_blk8)
+
+/*
+ * void sm4_aesni_avx_cfb_dec_blk8(const u32 *rk, u8 *dst,
+ *                                 const u8 *src, u8 *iv)
+ */
+.align 8
+SYM_FUNC_START(sm4_aesni_avx_cfb_dec_blk8)
+	/* input:
+	 *	%rdi: round key array, CTX
+	 *	%rsi: dst (8 blocks)
+	 *	%rdx: src (8 blocks)
+	 *	%rcx: iv
+	 */
+	FRAME_BEGIN
+
+	/* Load input */
+	vmovdqu (%rcx), RA0;
+	vmovdqu 0 * 16(%rdx), RA1;
+	vmovdqu 1 * 16(%rdx), RA2;
+	vmovdqu 2 * 16(%rdx), RA3;
+	vmovdqu 3 * 16(%rdx), RB0;
+	vmovdqu 4 * 16(%rdx), RB1;
+	vmovdqu 5 * 16(%rdx), RB2;
+	vmovdqu 6 * 16(%rdx), RB3;
+
+	/* Update IV */
+	vmovdqu 7 * 16(%rdx), RNOT;
+	vmovdqu RNOT, (%rcx);
+
+	call __sm4_crypt_blk8;
+
+	vpxor (0 * 16)(%rdx), RA0, RA0;
+	vpxor (1 * 16)(%rdx), RA1, RA1;
+	vpxor (2 * 16)(%rdx), RA2, RA2;
+	vpxor (3 * 16)(%rdx), RA3, RA3;
+	vpxor (4 * 16)(%rdx), RB0, RB0;
+	vpxor (5 * 16)(%rdx), RB1, RB1;
+	vpxor (6 * 16)(%rdx), RB2, RB2;
+	vpxor (7 * 16)(%rdx), RB3, RB3;
+
+	vmovdqu RA0, (0 * 16)(%rsi);
+	vmovdqu RA1, (1 * 16)(%rsi);
+	vmovdqu RA2, (2 * 16)(%rsi);
+	vmovdqu RA3, (3 * 16)(%rsi);
+	vmovdqu RB0, (4 * 16)(%rsi);
+	vmovdqu RB1, (5 * 16)(%rsi);
+	vmovdqu RB2, (6 * 16)(%rsi);
+	vmovdqu RB3, (7 * 16)(%rsi);
+
+	vzeroall;
+	FRAME_END
+	ret;
+SYM_FUNC_END(sm4_aesni_avx_cfb_dec_blk8)
diff --git a/arch/x86/crypto/sm4_aesni_avx_glue.c b/arch/x86/crypto/sm4_aesni_avx_glue.c
new file mode 100644
index 000000000000..8f7c15f84828
--- /dev/null
+++ b/arch/x86/crypto/sm4_aesni_avx_glue.c
@@ -0,0 +1,537 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM4 Cipher Algorithm, AES-NI/AVX optimized.
+ * as specified in
+ * https://tools.ietf.org/id/draft-ribose-cfrg-sm4-10.html
+ *
+ * Copyright (c) 2021, Alibaba Group.
+ * Copyright (c) 2021 Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+#include <linux/module.h>
+#include <linux/crypto.h>
+#include <linux/kernel.h>
+#include <asm/simd.h>
+#include <crypto/internal/simd.h>
+#include <crypto/internal/skcipher.h>
+#include <crypto/sm4.h>
+
+#define SM4_CRYPT8_BLOCK_SIZE	(SM4_BLOCK_SIZE * 8)
+
+asmlinkage void sm4_aesni_avx_expand_key(const u8 *key, u32 *rk_enc,
+				u32 *rk_dec, const u32 *fk, const u32 *ck);
+asmlinkage void sm4_aesni_avx_crypt4(const u32 *rk, u8 *dst,
+				const u8 *src, int nblocks);
+asmlinkage void sm4_aesni_avx_crypt8(const u32 *rk, u8 *dst,
+				const u8 *src, int nblocks);
+asmlinkage void sm4_aesni_avx_ctr_enc_blk8(const u32 *rk, u8 *dst,
+				const u8 *src, u8 *iv);
+asmlinkage void sm4_aesni_avx_cbc_dec_blk8(const u32 *rk, u8 *dst,
+				const u8 *src, u8 *iv);
+asmlinkage void sm4_aesni_avx_cfb_dec_blk8(const u32 *rk, u8 *dst,
+				const u8 *src, u8 *iv);
+
+static int sm4_setkey(struct crypto_tfm *tfm, const u8 *in_key,
+			unsigned int key_len)
+{
+	struct sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (key_len != SM4_KEY_SIZE)
+		return -EINVAL;
+
+	if (crypto_simd_usable()) {
+		kernel_fpu_begin();
+		sm4_aesni_avx_expand_key(in_key, ctx->rkey_enc,
+				ctx->rkey_dec, sm4_fk, sm4_ck);
+		kernel_fpu_end();
+	} else
+		sm4_expandkey(ctx, in_key, key_len);
+
+	return 0;
+}
+
+static void sm4_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
+{
+	const struct sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (crypto_simd_usable()) {
+		kernel_fpu_begin();
+		sm4_aesni_avx_crypt4(ctx->rkey_enc, out, in, 1);
+		kernel_fpu_end();
+	} else
+		sm4_crypt_block(ctx->rkey_enc, out, in);
+}
+
+static void sm4_decrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
+{
+	const struct sm4_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	if (crypto_simd_usable()) {
+		kernel_fpu_begin();
+		sm4_aesni_avx_crypt4(ctx->rkey_dec, out, in, 1);
+		kernel_fpu_end();
+	} else
+		sm4_crypt_block(ctx->rkey_dec, out, in);
+}
+
+static struct crypto_alg sm4_aesni_avx_alg = {
+	.cra_name		= "sm4",
+	.cra_driver_name	= "sm4-aesni-avx",
+	.cra_priority		= 200,
+	.cra_flags		= CRYPTO_ALG_TYPE_CIPHER,
+	.cra_blocksize		= SM4_BLOCK_SIZE,
+	.cra_ctxsize		= sizeof(struct sm4_ctx),
+	.cra_module		= THIS_MODULE,
+	.cra_u			= {
+		.cipher = {
+			.cia_min_keysize	= SM4_KEY_SIZE,
+			.cia_max_keysize	= SM4_KEY_SIZE,
+			.cia_setkey		= sm4_setkey,
+			.cia_encrypt		= sm4_encrypt,
+			.cia_decrypt		= sm4_decrypt
+		}
+	}
+};
+
+static int sm4_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			unsigned int key_len)
+{
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return sm4_expandkey(ctx, key, key_len);
+}
+
+static int ecb_do_crypt(struct skcipher_request *req, const u32 *rkey)
+{
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) > 0) {
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+
+		kernel_fpu_begin();
+		while (nbytes >= SM4_CRYPT8_BLOCK_SIZE) {
+			sm4_aesni_avx_crypt8(rkey, dst, src, 8);
+			dst += SM4_CRYPT8_BLOCK_SIZE;
+			src += SM4_CRYPT8_BLOCK_SIZE;
+			nbytes -= SM4_CRYPT8_BLOCK_SIZE;
+		}
+		while (nbytes >= SM4_BLOCK_SIZE) {
+			unsigned int nblocks = min(nbytes >> 4, 4u);
+			sm4_aesni_avx_crypt4(rkey, dst, src, nblocks);
+			dst += nblocks * SM4_BLOCK_SIZE;
+			src += nblocks * SM4_BLOCK_SIZE;
+			nbytes -= nblocks * SM4_BLOCK_SIZE;
+		}
+		kernel_fpu_end();
+
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+
+static int ecb_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return ecb_do_crypt(req, ctx->rkey_enc);
+}
+
+static int ecb_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return ecb_do_crypt(req, ctx->rkey_dec);
+}
+
+static int cbc_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) > 0) {
+		const u8 *iv = walk.iv;
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+
+		while (nbytes >= SM4_BLOCK_SIZE) {
+			crypto_xor_cpy(dst, src, iv, SM4_BLOCK_SIZE);
+			sm4_crypt_block(ctx->rkey_enc, dst, dst);
+			iv = dst;
+			src += SM4_BLOCK_SIZE;
+			dst += SM4_BLOCK_SIZE;
+			nbytes -= SM4_BLOCK_SIZE;
+		}
+		if (iv != walk.iv)
+			memcpy(walk.iv, iv, SM4_BLOCK_SIZE);
+
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+
+static int cbc_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) > 0) {
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+
+		kernel_fpu_begin();
+
+		while (nbytes >= SM4_CRYPT8_BLOCK_SIZE) {
+			sm4_aesni_avx_cbc_dec_blk8(ctx->rkey_dec, dst,
+						src, walk.iv);
+			dst += SM4_CRYPT8_BLOCK_SIZE;
+			src += SM4_CRYPT8_BLOCK_SIZE;
+			nbytes -= SM4_CRYPT8_BLOCK_SIZE;
+		}
+
+		if (nbytes >= SM4_BLOCK_SIZE) {
+			u8 keystream[SM4_BLOCK_SIZE * 8];
+			u8 iv[SM4_BLOCK_SIZE];
+			unsigned int nblocks = min(nbytes >> 4, 8u);
+			int i;
+
+			sm4_aesni_avx_crypt8(ctx->rkey_dec, keystream,
+						src, nblocks);
+
+			src += ((int)nblocks - 2) * SM4_BLOCK_SIZE;
+			dst += (nblocks - 1) * SM4_BLOCK_SIZE;
+			memcpy(iv, src + SM4_BLOCK_SIZE, SM4_BLOCK_SIZE);
+
+			for (i = nblocks - 1; i > 0; i--) {
+				crypto_xor_cpy(dst, src,
+					&keystream[i * SM4_BLOCK_SIZE],
+					SM4_BLOCK_SIZE);
+				src -= SM4_BLOCK_SIZE;
+				dst -= SM4_BLOCK_SIZE;
+			}
+			crypto_xor_cpy(dst, walk.iv, keystream, SM4_BLOCK_SIZE);
+			memcpy(walk.iv, iv, SM4_BLOCK_SIZE);
+			nbytes -= nblocks * SM4_BLOCK_SIZE;
+		}
+
+		kernel_fpu_end();
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+
+static int cfb_encrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) > 0) {
+		u8 keystream[SM4_BLOCK_SIZE];
+		const u8 *iv = walk.iv;
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+
+		while (nbytes >= SM4_BLOCK_SIZE) {
+			sm4_crypt_block(ctx->rkey_enc, keystream, iv);
+			crypto_xor_cpy(dst, src, keystream, SM4_BLOCK_SIZE);
+			iv = dst;
+			src += SM4_BLOCK_SIZE;
+			dst += SM4_BLOCK_SIZE;
+			nbytes -= SM4_BLOCK_SIZE;
+		}
+		if (iv != walk.iv)
+			memcpy(walk.iv, iv, SM4_BLOCK_SIZE);
+
+		/* tail */
+		if (walk.nbytes == walk.total && nbytes > 0) {
+			sm4_crypt_block(ctx->rkey_enc, keystream, walk.iv);
+			crypto_xor_cpy(dst, src, keystream, nbytes);
+			nbytes = 0;
+		}
+
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+
+static int cfb_decrypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) > 0) {
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+
+		kernel_fpu_begin();
+
+		while (nbytes >= SM4_CRYPT8_BLOCK_SIZE) {
+			sm4_aesni_avx_cfb_dec_blk8(ctx->rkey_enc, dst,
+						src, walk.iv);
+			dst += SM4_CRYPT8_BLOCK_SIZE;
+			src += SM4_CRYPT8_BLOCK_SIZE;
+			nbytes -= SM4_CRYPT8_BLOCK_SIZE;
+		}
+
+		if (nbytes >= SM4_BLOCK_SIZE) {
+			u8 keystream[SM4_BLOCK_SIZE * 8];
+			unsigned int nblocks = min(nbytes >> 4, 8u);
+
+			memcpy(keystream, walk.iv, SM4_BLOCK_SIZE);
+			if (nblocks > 1)
+				memcpy(&keystream[SM4_BLOCK_SIZE], src,
+					(nblocks - 1) * SM4_BLOCK_SIZE);
+			memcpy(walk.iv, src + (nblocks - 1) * SM4_BLOCK_SIZE,
+				SM4_BLOCK_SIZE);
+
+			sm4_aesni_avx_crypt8(ctx->rkey_enc, keystream,
+						keystream, nblocks);
+
+			crypto_xor_cpy(dst, src, keystream,
+					nblocks * SM4_BLOCK_SIZE);
+			dst += nblocks * SM4_BLOCK_SIZE;
+			src += nblocks * SM4_BLOCK_SIZE;
+			nbytes -= nblocks * SM4_BLOCK_SIZE;
+		}
+
+		kernel_fpu_end();
+
+		/* tail */
+		if (walk.nbytes == walk.total && nbytes > 0) {
+			u8 keystream[SM4_BLOCK_SIZE];
+
+			sm4_crypt_block(ctx->rkey_enc, keystream, walk.iv);
+			crypto_xor_cpy(dst, src, keystream, nbytes);
+			nbytes = 0;
+		}
+
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+
+static int ctr_crypt(struct skcipher_request *req)
+{
+	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+	struct skcipher_walk walk;
+	unsigned int nbytes;
+	int err;
+
+	err = skcipher_walk_virt(&walk, req, false);
+
+	while ((nbytes = walk.nbytes) > 0) {
+		const u8 *src = walk.src.virt.addr;
+		u8 *dst = walk.dst.virt.addr;
+
+		kernel_fpu_begin();
+
+		while (nbytes >= SM4_CRYPT8_BLOCK_SIZE) {
+			sm4_aesni_avx_ctr_enc_blk8(ctx->rkey_enc, dst,
+						src, walk.iv);
+			dst += SM4_CRYPT8_BLOCK_SIZE;
+			src += SM4_CRYPT8_BLOCK_SIZE;
+			nbytes -= SM4_CRYPT8_BLOCK_SIZE;
+		}
+
+		if (nbytes >= SM4_BLOCK_SIZE) {
+			u8 keystream[SM4_BLOCK_SIZE * 8];
+			unsigned int nblocks = min(nbytes >> 4, 8u);
+			int i;
+
+			for (i = 0; i < nblocks; i++) {
+				memcpy(&keystream[i * SM4_BLOCK_SIZE],
+					walk.iv, SM4_BLOCK_SIZE);
+				crypto_inc(walk.iv, SM4_BLOCK_SIZE);
+			}
+			sm4_aesni_avx_crypt8(ctx->rkey_enc, keystream,
+					keystream, nblocks);
+
+			crypto_xor_cpy(dst, src, keystream,
+					nblocks * SM4_BLOCK_SIZE);
+			dst += nblocks * SM4_BLOCK_SIZE;
+			src += nblocks * SM4_BLOCK_SIZE;
+			nbytes -= nblocks * SM4_BLOCK_SIZE;
+		}
+
+		kernel_fpu_end();
+
+		/* tail */
+		if (walk.nbytes == walk.total && nbytes > 0) {
+			u8 keystream[SM4_BLOCK_SIZE];
+
+			memcpy(keystream, walk.iv, SM4_BLOCK_SIZE);
+			crypto_inc(walk.iv, SM4_BLOCK_SIZE);
+
+			sm4_crypt_block(ctx->rkey_enc, keystream, keystream);
+
+			crypto_xor_cpy(dst, src, keystream, nbytes);
+			dst += nbytes;
+			src += nbytes;
+			nbytes = 0;
+		}
+
+		err = skcipher_walk_done(&walk, nbytes);
+	}
+
+	return err;
+}
+
+static struct skcipher_alg sm4_aesni_avx_skciphers[] = {
+	{
+		.base = {
+			.cra_name		= "__ecb(sm4)",
+			.cra_driver_name	= "__ecb-sm4-aesni-avx",
+			.cra_priority		= 400,
+			.cra_flags		= CRYPTO_ALG_INTERNAL,
+			.cra_blocksize		= SM4_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.walksize	= 8 * SM4_BLOCK_SIZE,
+		.setkey		= sm4_skcipher_setkey,
+		.encrypt	= ecb_encrypt,
+		.decrypt	= ecb_decrypt,
+	}, {
+		.base = {
+			.cra_name		= "__cbc(sm4)",
+			.cra_driver_name	= "__cbc-sm4-aesni-avx",
+			.cra_priority		= 400,
+			.cra_flags		= CRYPTO_ALG_INTERNAL,
+			.cra_blocksize		= SM4_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.ivsize		= SM4_BLOCK_SIZE,
+		.walksize	= 8 * SM4_BLOCK_SIZE,
+		.setkey		= sm4_skcipher_setkey,
+		.encrypt	= cbc_encrypt,
+		.decrypt	= cbc_decrypt,
+	}, {
+		.base = {
+			.cra_name		= "__cfb(sm4)",
+			.cra_driver_name	= "__cfb-sm4-aesni-avx",
+			.cra_priority		= 400,
+			.cra_flags		= CRYPTO_ALG_INTERNAL,
+			.cra_blocksize		= 1,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.ivsize		= SM4_BLOCK_SIZE,
+		.chunksize	= SM4_BLOCK_SIZE,
+		.walksize	= 8 * SM4_BLOCK_SIZE,
+		.setkey		= sm4_skcipher_setkey,
+		.encrypt	= cfb_encrypt,
+		.decrypt	= cfb_decrypt,
+	}, {
+		.base = {
+			.cra_name		= "__ctr(sm4)",
+			.cra_driver_name	= "__ctr-sm4-aesni-avx",
+			.cra_priority		= 400,
+			.cra_flags		= CRYPTO_ALG_INTERNAL,
+			.cra_blocksize		= 1,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.ivsize		= SM4_BLOCK_SIZE,
+		.chunksize	= SM4_BLOCK_SIZE,
+		.walksize	= 8 * SM4_BLOCK_SIZE,
+		.setkey		= sm4_skcipher_setkey,
+		.encrypt	= ctr_crypt,
+		.decrypt	= ctr_crypt,
+	}
+};
+
+static struct simd_skcipher_alg *
+simd_sm4_aesni_avx_skciphers[ARRAY_SIZE(sm4_aesni_avx_skciphers)];
+
+static int __init sm4_init(void)
+{
+	const char *feature_name;
+	int err;
+
+	if (!boot_cpu_has(X86_FEATURE_AVX) ||
+	    !boot_cpu_has(X86_FEATURE_AES) ||
+	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+		pr_info("AVX or AES-NI instructions are not detected.\n");
+		return -ENODEV;
+	}
+
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
+				&feature_name)) {
+		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		return -ENODEV;
+	}
+
+	err = crypto_register_alg(&sm4_aesni_avx_alg);
+	if (err)
+		return err;
+
+	err = simd_register_skciphers_compat(sm4_aesni_avx_skciphers,
+					ARRAY_SIZE(sm4_aesni_avx_skciphers),
+					simd_sm4_aesni_avx_skciphers);
+	if (err)
+		goto unregister_alg;
+
+	return 0;
+
+unregister_alg:
+	crypto_unregister_alg(&sm4_aesni_avx_alg);
+	return err;
+}
+
+static void __exit sm4_exit(void)
+{
+	simd_unregister_skciphers(sm4_aesni_avx_skciphers,
+					ARRAY_SIZE(sm4_aesni_avx_skciphers),
+					simd_sm4_aesni_avx_skciphers);
+	crypto_unregister_alg(&sm4_aesni_avx_alg);
+}
+
+module_init(sm4_init);
+module_exit(sm4_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
+MODULE_DESCRIPTION("SM4 Cipher Algorithm, AES-NI/AVX optimized");
+MODULE_ALIAS_CRYPTO("sm4");
+MODULE_ALIAS_CRYPTO("sm4-aesni-avx");
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 4fbc9c080ca9..ec2aee998444 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1570,6 +1570,27 @@ config CRYPTO_SM4
 
 	  If unsure, say N.
 
+config CRYPTO_SM4_AESNI_AVX_X86_64
+	tristate "SM4 cipher algorithm (x86_64/AES-NI/AVX)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_SIMD
+	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_SM4
+	help
+	  SM4 cipher algorithms (OSCCA GB/T 32907-2016) (x86_64/AES-NI/AVX).
+
+	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
+	  Organization of State Commercial Administration of China (OSCCA)
+	  as an authorized cryptographic algorithms for the use within China.
+
+	  This is SM4 optimized implementation using AES-NI/AVX/x86_64
+	  instruction set for block cipher. Through two affine transforms,
+	  we can use the AES S-Box to simulate the SM4 S-Box to achieve the
+	  effect of instruction acceleration.
+
+	  If unsure, say N.
+
 config CRYPTO_TEA
 	tristate "TEA, XTEA and XETA cipher algorithms"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
-- 
2.19.1.3.ge56e4f7

