Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C7A3EF88F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 05:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbhHRDcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 23:32:01 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:56088 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236055AbhHRDb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 23:31:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0Ujd4Rfi_1629257478;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Ujd4Rfi_1629257478)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Aug 2021 11:31:18 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Vitaly Chikunov <vt@altlinux.org>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Markku-Juhani O . Saarinen" <mjos@iki.fi>,
        Jussi Kivilinna <jussi.kivilinna@iki.fi>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH 2/2] crypto: x86/sm4 - add AES-NI/AVX2/x86_64 implementation
Date:   Wed, 18 Aug 2021 11:31:17 +0800
Message-Id: <20210818033117.91717-3-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20210818033117.91717-1-tianjia.zhang@linux.alibaba.com>
References: <20210818033117.91717-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the implementation of AESNI/AVX, this patch adds an accelerated
implementation of AESNI/AVX2. In terms of code implementation, by
reusing AESNI/AVX mode-related codes, the amount of code is greatly
reduced. From the benchmark data, it can be seen that when the block
size is 1024, compared to AVX acceleration, the performance achieved
by AVX2 has increased by about 70%, it is also 7.7 times of the pure
software implementation of sm4-generic.

The main algorithm implementation comes from SM4 AES-NI work by
libgcrypt and Markku-Juhani O. Saarinen at:
https://github.com/mjosaarinen/sm4ni

This optimization supports the four modes of SM4, ECB, CBC, CFB,
and CTR. Since CBC and CFB do not support multiple block parallel
encryption, the optimization effect is not obvious.

Benchmark on Intel i5-6200U 2.30GHz, performance data of three
implementation methods, pure software sm4-generic, aesni/avx
acceleration, and aesni/avx2 acceleration, the data comes from
the 218 mode and 518 mode of tcrypt. The abscissas are blocks of
different lengths. The data is tabulated and the unit is Mb/s:

block-size  |    16      64     128     256    1024    1420    4096
sm4-generic
    ECB enc | 60.94   70.41   72.27   73.02   73.87   73.58   73.59
    ECB dec | 61.87   70.53   72.15   73.09   73.89   73.92   73.86
    CBC enc | 56.71   66.31   68.05   69.84   70.02   70.12   70.24
    CBC dec | 54.54   65.91   68.22   69.51   70.63   70.79   70.82
    CFB enc | 57.21   67.24   69.10   70.25   70.73   70.52   71.42
    CFB dec | 57.22   64.74   66.31   67.24   67.40   67.64   67.58
    CTR enc | 59.47   68.64   69.91   71.02   71.86   71.61   71.95
    CTR dec | 59.94   68.77   69.95   71.00   71.84   71.55   71.95
sm4-aesni-avx
    ECB enc | 44.95  177.35  292.06  316.98  339.48  322.27  330.59
    ECB dec | 45.28  178.66  292.31  317.52  339.59  322.52  331.16
    CBC enc | 57.75   67.68   69.72   70.60   71.48   71.63   71.74
    CBC dec | 44.32  176.83  284.32  307.24  328.61  312.61  325.82
    CFB enc | 57.81   67.64   69.63   70.55   71.40   71.35   71.70
    CFB dec | 43.14  167.78  282.03  307.20  328.35  318.24  325.95
    CTR enc | 42.35  163.32  279.11  302.93  320.86  310.56  317.93
    CTR dec | 42.39  162.81  278.49  302.37  321.11  310.33  318.37
sm4-aesni-avx2
    ECB enc | 45.19  177.41  292.42  316.12  339.90  322.53  330.54
    ECB dec | 44.83  178.90  291.45  317.31  339.85  322.55  331.07
    CBC enc | 57.66   67.62   69.73   70.55   71.58   71.66   71.77
    CBC dec | 44.34  176.86  286.10  501.68  559.58  483.87  527.46
    CFB enc | 57.43   67.60   69.61   70.52   71.43   71.28   71.65
    CFB dec | 43.12  167.75  268.09  499.33  558.35  490.36  524.73
    CTR enc | 42.42  163.39  256.17  493.95  552.45  481.58  517.19
    CTR dec | 42.49  163.11  256.36  493.34  552.62  481.49  516.83

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 arch/x86/crypto/Makefile                |   3 +
 arch/x86/crypto/sm4-aesni-avx2-asm_64.S | 497 ++++++++++++++++++++++++
 arch/x86/crypto/sm4_aesni_avx2_glue.c   | 169 ++++++++
 crypto/Kconfig                          |  22 ++
 4 files changed, 691 insertions(+)
 create mode 100644 arch/x86/crypto/sm4-aesni-avx2-asm_64.S
 create mode 100644 arch/x86/crypto/sm4_aesni_avx2_glue.c

diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
index 08f95d4e1e7c..f307c93fc90a 100644
--- a/arch/x86/crypto/Makefile
+++ b/arch/x86/crypto/Makefile
@@ -91,6 +91,9 @@ obj-$(CONFIG_CRYPTO_CURVE25519_X86) += curve25519-x86_64.o
 obj-$(CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64) += sm4-aesni-avx-x86_64.o
 sm4-aesni-avx-x86_64-y := sm4-aesni-avx-asm_64.o sm4_aesni_avx_glue.o
 
+obj-$(CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64) += sm4-aesni-avx2-x86_64.o
+sm4-aesni-avx2-x86_64-y := sm4-aesni-avx2-asm_64.o sm4_aesni_avx2_glue.o
+
 quiet_cmd_perlasm = PERLASM $@
       cmd_perlasm = $(PERL) $< > $@
 $(obj)/%.S: $(src)/%.pl FORCE
diff --git a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
new file mode 100644
index 000000000000..d2ffd7f76ee2
--- /dev/null
+++ b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
@@ -0,0 +1,497 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * SM4 Cipher Algorithm, AES-NI/AVX2 optimized.
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
+/* vector registers */
+#define RX0          %ymm0
+#define RX1          %ymm1
+#define MASK_4BIT    %ymm2
+#define RTMP0        %ymm3
+#define RTMP1        %ymm4
+#define RTMP2        %ymm5
+#define RTMP3        %ymm6
+#define RTMP4        %ymm7
+
+#define RA0          %ymm8
+#define RA1          %ymm9
+#define RA2          %ymm10
+#define RA3          %ymm11
+
+#define RB0          %ymm12
+#define RB1          %ymm13
+#define RB2          %ymm14
+#define RB3          %ymm15
+
+#define RNOT         %ymm0
+#define RBSWAP       %ymm1
+
+#define RX0x         %xmm0
+#define RX1x         %xmm1
+#define MASK_4BITx   %xmm2
+
+#define RNOTx        %xmm0
+#define RBSWAPx      %xmm1
+
+#define RTMP0x       %xmm3
+#define RTMP1x       %xmm4
+#define RTMP2x       %xmm5
+#define RTMP3x       %xmm6
+#define RTMP4x       %xmm7
+
+
+/* helper macros */
+
+/* Transpose four 32-bit words between 128-bit vector lanes. */
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
+/* post-SubByte transform. */
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
+ * 'vaeslastenc' instruction. */
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
+.text
+.align 16
+
+.align 8
+SYM_FUNC_START_LOCAL(__sm4_crypt_blk16)
+	/* input:
+	 *	%rdi: round key array, CTX
+	 *	RA0, RA1, RA2, RA3, RB0, RB1, RB2, RB3: sixteen parallel
+	 *						plaintext blocks
+	 * output:
+	 *	RA0, RA1, RA2, RA3, RB0, RB1, RB2, RB3: sixteen parallel
+	 * 						ciphertext blocks
+	 */
+	FRAME_BEGIN
+
+	vbroadcasti128 .Lbswap32_mask rRIP, RTMP2;
+	vpshufb RTMP2, RA0, RA0;
+	vpshufb RTMP2, RA1, RA1;
+	vpshufb RTMP2, RA2, RA2;
+	vpshufb RTMP2, RA3, RA3;
+	vpshufb RTMP2, RB0, RB0;
+	vpshufb RTMP2, RB1, RB1;
+	vpshufb RTMP2, RB2, RB2;
+	vpshufb RTMP2, RB3, RB3;
+
+	vpbroadcastd .L0f0f0f0f rRIP, MASK_4BIT;
+	transpose_4x4(RA0, RA1, RA2, RA3, RTMP0, RTMP1);
+	transpose_4x4(RB0, RB1, RB2, RB3, RTMP0, RTMP1);
+
+#define ROUND(round, s0, s1, s2, s3, r0, r1, r2, r3)                \
+	vpbroadcastd (4*(round))(%rdi), RX0;                        \
+	vbroadcasti128 .Lpre_tf_lo_s rRIP, RTMP4;                   \
+	vbroadcasti128 .Lpre_tf_hi_s rRIP, RTMP1;                   \
+	vmovdqa RX0, RX1;                                           \
+	vpxor s1, RX0, RX0;                                         \
+	vpxor s2, RX0, RX0;                                         \
+	vpxor s3, RX0, RX0; /* s1 ^ s2 ^ s3 ^ rk */                 \
+	vbroadcasti128 .Lpost_tf_lo_s rRIP, RTMP2;                  \
+	vbroadcasti128 .Lpost_tf_hi_s rRIP, RTMP3;                  \
+	vpxor r1, RX1, RX1;                                         \
+	vpxor r2, RX1, RX1;                                         \
+	vpxor r3, RX1, RX1; /* r1 ^ r2 ^ r3 ^ rk */                 \
+	                                                            \
+	/* sbox, non-linear part */                                 \
+	transform_pre(RX0, RTMP4, RTMP1, MASK_4BIT, RTMP0);         \
+	transform_pre(RX1, RTMP4, RTMP1, MASK_4BIT, RTMP0);         \
+	vextracti128 $1, RX0, RTMP4x;                               \
+	vextracti128 $1, RX1, RTMP0x;                               \
+	vaesenclast MASK_4BITx, RX0x, RX0x;                         \
+	vaesenclast MASK_4BITx, RTMP4x, RTMP4x;                     \
+	vaesenclast MASK_4BITx, RX1x, RX1x;                         \
+	vaesenclast MASK_4BITx, RTMP0x, RTMP0x;                     \
+	vinserti128 $1, RTMP4x, RX0, RX0;                           \
+	vbroadcasti128 .Linv_shift_row rRIP, RTMP4;                 \
+	vinserti128 $1, RTMP0x, RX1, RX1;                           \
+	transform_post(RX0, RTMP2, RTMP3, MASK_4BIT, RTMP0);        \
+	transform_post(RX1, RTMP2, RTMP3, MASK_4BIT, RTMP0);        \
+	                                                            \
+	/* linear part */                                           \
+	vpshufb RTMP4, RX0, RTMP0;                                  \
+	vpxor RTMP0, s0, s0; /* s0 ^ x */                           \
+	vpshufb RTMP4, RX1, RTMP2;                                  \
+	vbroadcasti128 .Linv_shift_row_rol_8 rRIP, RTMP4;           \
+	vpxor RTMP2, r0, r0; /* r0 ^ x */                           \
+	vpshufb RTMP4, RX0, RTMP1;                                  \
+	vpxor RTMP1, RTMP0, RTMP0; /* x ^ rol(x,8) */               \
+	vpshufb RTMP4, RX1, RTMP3;                                  \
+	vbroadcasti128 .Linv_shift_row_rol_16 rRIP, RTMP4;          \
+	vpxor RTMP3, RTMP2, RTMP2; /* x ^ rol(x,8) */               \
+	vpshufb RTMP4, RX0, RTMP1;                                  \
+	vpxor RTMP1, RTMP0, RTMP0; /* x ^ rol(x,8) ^ rol(x,16) */   \
+	vpshufb RTMP4, RX1, RTMP3;                                  \
+	vbroadcasti128 .Linv_shift_row_rol_24 rRIP, RTMP4;          \
+	vpxor RTMP3, RTMP2, RTMP2; /* x ^ rol(x,8) ^ rol(x,16) */   \
+	vpshufb RTMP4, RX0, RTMP1;                                  \
+	vpxor RTMP1, s0, s0; /* s0 ^ x ^ rol(x,24) */               \
+	vpslld $2, RTMP0, RTMP1;                                    \
+	vpsrld $30, RTMP0, RTMP0;                                   \
+	vpxor RTMP0, s0, s0;                                        \
+	/* s0 ^ x ^ rol(x,2) ^ rol(x,10) ^ rol(x,18) ^ rol(x,24) */ \
+	vpxor RTMP1, s0, s0;                                        \
+	vpshufb RTMP4, RX1, RTMP3;                                  \
+	vpxor RTMP3, r0, r0; /* r0 ^ x ^ rol(x,24) */               \
+	vpslld $2, RTMP2, RTMP3;                                    \
+	vpsrld $30, RTMP2, RTMP2;                                   \
+	vpxor RTMP2, r0, r0;                                        \
+	/* r0 ^ x ^ rol(x,2) ^ rol(x,10) ^ rol(x,18) ^ rol(x,24) */ \
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
+	vbroadcasti128 .Lbswap128_mask rRIP, RTMP2;
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
+SYM_FUNC_END(__sm4_crypt_blk16)
+
+#define inc_le128(x, minus_one, tmp) \
+	vpcmpeqq minus_one, x, tmp;  \
+	vpsubq minus_one, x, x;      \
+	vpslldq $8, tmp, tmp;        \
+	vpsubq tmp, x, x;
+
+/*
+ * void sm4_aesni_avx2_ctr_enc_blk16(const u32 *rk, u8 *dst,
+ *                                   const u8 *src, u8 *iv)
+ */
+.align 8
+SYM_FUNC_START(sm4_aesni_avx2_ctr_enc_blk16)
+	/* input:
+	 *	%rdi: round key array, CTX
+	 *	%rsi: dst (16 blocks)
+	 *	%rdx: src (16 blocks)
+	 *	%rcx: iv (big endian, 128bit)
+	 */
+	FRAME_BEGIN
+
+	movq 8(%rcx), %rax;
+	bswapq %rax;
+
+	vzeroupper;
+
+	vbroadcasti128 .Lbswap128_mask rRIP, RTMP3;
+	vpcmpeqd RNOT, RNOT, RNOT;
+	vpsrldq $8, RNOT, RNOT;   /* ab: -1:0 ; cd: -1:0 */
+	vpaddq RNOT, RNOT, RTMP2; /* ab: -2:0 ; cd: -2:0 */
+
+	/* load IV and byteswap */
+	vmovdqu (%rcx), RTMP4x;
+	vpshufb RTMP3x, RTMP4x, RTMP4x;
+	vmovdqa RTMP4x, RTMP0x;
+	inc_le128(RTMP4x, RNOTx, RTMP1x);
+	vinserti128 $1, RTMP4x, RTMP0, RTMP0;
+	vpshufb RTMP3, RTMP0, RA0; /* +1 ; +0 */
+
+	/* check need for handling 64-bit overflow and carry */
+	cmpq $(0xffffffffffffffff - 16), %rax;
+	ja .Lhandle_ctr_carry;
+
+	/* construct IVs */
+	vpsubq RTMP2, RTMP0, RTMP0; /* +3 ; +2 */
+	vpshufb RTMP3, RTMP0, RA1;
+	vpsubq RTMP2, RTMP0, RTMP0; /* +5 ; +4 */
+	vpshufb RTMP3, RTMP0, RA2;
+	vpsubq RTMP2, RTMP0, RTMP0; /* +7 ; +6 */
+	vpshufb RTMP3, RTMP0, RA3;
+	vpsubq RTMP2, RTMP0, RTMP0; /* +9 ; +8 */
+	vpshufb RTMP3, RTMP0, RB0;
+	vpsubq RTMP2, RTMP0, RTMP0; /* +11 ; +10 */
+	vpshufb RTMP3, RTMP0, RB1;
+	vpsubq RTMP2, RTMP0, RTMP0; /* +13 ; +12 */
+	vpshufb RTMP3, RTMP0, RB2;
+	vpsubq RTMP2, RTMP0, RTMP0; /* +15 ; +14 */
+	vpshufb RTMP3, RTMP0, RB3;
+	vpsubq RTMP2, RTMP0, RTMP0; /* +16 */
+	vpshufb RTMP3x, RTMP0x, RTMP0x;
+
+	jmp .Lctr_carry_done;
+
+.Lhandle_ctr_carry:
+	/* construct IVs */
+	inc_le128(RTMP0, RNOT, RTMP1);
+	inc_le128(RTMP0, RNOT, RTMP1);
+	vpshufb RTMP3, RTMP0, RA1; /* +3 ; +2 */
+	inc_le128(RTMP0, RNOT, RTMP1);
+	inc_le128(RTMP0, RNOT, RTMP1);
+	vpshufb RTMP3, RTMP0, RA2; /* +5 ; +4 */
+	inc_le128(RTMP0, RNOT, RTMP1);
+	inc_le128(RTMP0, RNOT, RTMP1);
+	vpshufb RTMP3, RTMP0, RA3; /* +7 ; +6 */
+	inc_le128(RTMP0, RNOT, RTMP1);
+	inc_le128(RTMP0, RNOT, RTMP1);
+	vpshufb RTMP3, RTMP0, RB0; /* +9 ; +8 */
+	inc_le128(RTMP0, RNOT, RTMP1);
+	inc_le128(RTMP0, RNOT, RTMP1);
+	vpshufb RTMP3, RTMP0, RB1; /* +11 ; +10 */
+	inc_le128(RTMP0, RNOT, RTMP1);
+	inc_le128(RTMP0, RNOT, RTMP1);
+	vpshufb RTMP3, RTMP0, RB2; /* +13 ; +12 */
+	inc_le128(RTMP0, RNOT, RTMP1);
+	inc_le128(RTMP0, RNOT, RTMP1);
+	vpshufb RTMP3, RTMP0, RB3; /* +15 ; +14 */
+	inc_le128(RTMP0, RNOT, RTMP1);
+	vextracti128 $1, RTMP0, RTMP0x;
+	vpshufb RTMP3x, RTMP0x, RTMP0x; /* +16 */
+
+.align 4
+.Lctr_carry_done:
+	/* store new IV */
+	vmovdqu RTMP0x, (%rcx);
+
+	call __sm4_crypt_blk16;
+
+	vpxor (0 * 32)(%rdx), RA0, RA0;
+	vpxor (1 * 32)(%rdx), RA1, RA1;
+	vpxor (2 * 32)(%rdx), RA2, RA2;
+	vpxor (3 * 32)(%rdx), RA3, RA3;
+	vpxor (4 * 32)(%rdx), RB0, RB0;
+	vpxor (5 * 32)(%rdx), RB1, RB1;
+	vpxor (6 * 32)(%rdx), RB2, RB2;
+	vpxor (7 * 32)(%rdx), RB3, RB3;
+
+	vmovdqu RA0, (0 * 32)(%rsi);
+	vmovdqu RA1, (1 * 32)(%rsi);
+	vmovdqu RA2, (2 * 32)(%rsi);
+	vmovdqu RA3, (3 * 32)(%rsi);
+	vmovdqu RB0, (4 * 32)(%rsi);
+	vmovdqu RB1, (5 * 32)(%rsi);
+	vmovdqu RB2, (6 * 32)(%rsi);
+	vmovdqu RB3, (7 * 32)(%rsi);
+
+	vzeroall;
+	FRAME_END
+	ret;
+SYM_FUNC_END(sm4_aesni_avx2_ctr_enc_blk16)
+
+/*
+ * void sm4_aesni_avx2_cbc_dec_blk16(const u32 *rk, u8 *dst,
+ *                                   const u8 *src, u8 *iv)
+ */
+.align 8
+SYM_FUNC_START(sm4_aesni_avx2_cbc_dec_blk16)
+	/* input:
+	 *	%rdi: round key array, CTX
+	 *	%rsi: dst (16 blocks)
+	 *	%rdx: src (16 blocks)
+	 *	%rcx: iv
+	 */
+	FRAME_BEGIN
+
+	vzeroupper;
+
+	vmovdqu (0 * 32)(%rdx), RA0;
+	vmovdqu (1 * 32)(%rdx), RA1;
+	vmovdqu (2 * 32)(%rdx), RA2;
+	vmovdqu (3 * 32)(%rdx), RA3;
+	vmovdqu (4 * 32)(%rdx), RB0;
+	vmovdqu (5 * 32)(%rdx), RB1;
+	vmovdqu (6 * 32)(%rdx), RB2;
+	vmovdqu (7 * 32)(%rdx), RB3;
+
+	call __sm4_crypt_blk16;
+
+	vmovdqu (%rcx), RNOTx;
+	vinserti128 $1, (%rdx), RNOT, RNOT;
+	vpxor RNOT, RA0, RA0;
+	vpxor (0 * 32 + 16)(%rdx), RA1, RA1;
+	vpxor (1 * 32 + 16)(%rdx), RA2, RA2;
+	vpxor (2 * 32 + 16)(%rdx), RA3, RA3;
+	vpxor (3 * 32 + 16)(%rdx), RB0, RB0;
+	vpxor (4 * 32 + 16)(%rdx), RB1, RB1;
+	vpxor (5 * 32 + 16)(%rdx), RB2, RB2;
+	vpxor (6 * 32 + 16)(%rdx), RB3, RB3;
+	vmovdqu (7 * 32 + 16)(%rdx), RNOTx;
+	vmovdqu RNOTx, (%rcx); /* store new IV */
+
+	vmovdqu RA0, (0 * 32)(%rsi);
+	vmovdqu RA1, (1 * 32)(%rsi);
+	vmovdqu RA2, (2 * 32)(%rsi);
+	vmovdqu RA3, (3 * 32)(%rsi);
+	vmovdqu RB0, (4 * 32)(%rsi);
+	vmovdqu RB1, (5 * 32)(%rsi);
+	vmovdqu RB2, (6 * 32)(%rsi);
+	vmovdqu RB3, (7 * 32)(%rsi);
+
+	vzeroall;
+	FRAME_END
+	ret;
+SYM_FUNC_END(sm4_aesni_avx2_cbc_dec_blk16)
+
+/*
+ * void sm4_aesni_avx2_cfb_dec_blk16(const u32 *rk, u8 *dst,
+ *                                   const u8 *src, u8 *iv)
+ */
+.align 8
+SYM_FUNC_START(sm4_aesni_avx2_cfb_dec_blk16)
+	/* input:
+	 *	%rdi: round key array, CTX
+	 *	%rsi: dst (16 blocks)
+	 *	%rdx: src (16 blocks)
+	 *	%rcx: iv
+	 */
+	FRAME_BEGIN
+
+	vzeroupper;
+
+	/* Load input */
+	vmovdqu (%rcx), RNOTx;
+	vinserti128 $1, (%rdx), RNOT, RA0;
+	vmovdqu (0 * 32 + 16)(%rdx), RA1;
+	vmovdqu (1 * 32 + 16)(%rdx), RA2;
+	vmovdqu (2 * 32 + 16)(%rdx), RA3;
+	vmovdqu (3 * 32 + 16)(%rdx), RB0;
+	vmovdqu (4 * 32 + 16)(%rdx), RB1;
+	vmovdqu (5 * 32 + 16)(%rdx), RB2;
+	vmovdqu (6 * 32 + 16)(%rdx), RB3;
+
+	/* Update IV */
+	vmovdqu (7 * 32 + 16)(%rdx), RNOTx;
+	vmovdqu RNOTx, (%rcx);
+
+	call __sm4_crypt_blk16;
+
+	vpxor (0 * 32)(%rdx), RA0, RA0;
+	vpxor (1 * 32)(%rdx), RA1, RA1;
+	vpxor (2 * 32)(%rdx), RA2, RA2;
+	vpxor (3 * 32)(%rdx), RA3, RA3;
+	vpxor (4 * 32)(%rdx), RB0, RB0;
+	vpxor (5 * 32)(%rdx), RB1, RB1;
+	vpxor (6 * 32)(%rdx), RB2, RB2;
+	vpxor (7 * 32)(%rdx), RB3, RB3;
+
+	vmovdqu RA0, (0 * 32)(%rsi);
+	vmovdqu RA1, (1 * 32)(%rsi);
+	vmovdqu RA2, (2 * 32)(%rsi);
+	vmovdqu RA3, (3 * 32)(%rsi);
+	vmovdqu RB0, (4 * 32)(%rsi);
+	vmovdqu RB1, (5 * 32)(%rsi);
+	vmovdqu RB2, (6 * 32)(%rsi);
+	vmovdqu RB3, (7 * 32)(%rsi);
+
+	vzeroall;
+	FRAME_END
+	ret;
+SYM_FUNC_END(sm4_aesni_avx2_cfb_dec_blk16)
diff --git a/arch/x86/crypto/sm4_aesni_avx2_glue.c b/arch/x86/crypto/sm4_aesni_avx2_glue.c
new file mode 100644
index 000000000000..84bc718f49a3
--- /dev/null
+++ b/arch/x86/crypto/sm4_aesni_avx2_glue.c
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SM4 Cipher Algorithm, AES-NI/AVX2 optimized.
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
+#include "sm4-avx.h"
+
+#define SM4_CRYPT16_BLOCK_SIZE	(SM4_BLOCK_SIZE * 16)
+
+asmlinkage void sm4_aesni_avx2_ctr_enc_blk16(const u32 *rk, u8 *dst,
+					const u8 *src, u8 *iv);
+asmlinkage void sm4_aesni_avx2_cbc_dec_blk16(const u32 *rk, u8 *dst,
+					const u8 *src, u8 *iv);
+asmlinkage void sm4_aesni_avx2_cfb_dec_blk16(const u32 *rk, u8 *dst,
+					const u8 *src, u8 *iv);
+
+static int sm4_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
+			unsigned int key_len)
+{
+	struct sm4_ctx *ctx = crypto_skcipher_ctx(tfm);
+
+	return sm4_expandkey(ctx, key, key_len);
+}
+
+static int cbc_decrypt(struct skcipher_request *req)
+{
+	return sm4_avx_cbc_decrypt(req, SM4_CRYPT16_BLOCK_SIZE,
+				sm4_aesni_avx2_cbc_dec_blk16);
+}
+
+
+static int cfb_decrypt(struct skcipher_request *req)
+{
+	return sm4_avx_cfb_decrypt(req, SM4_CRYPT16_BLOCK_SIZE,
+				sm4_aesni_avx2_cfb_dec_blk16);
+}
+
+static int ctr_crypt(struct skcipher_request *req)
+{
+	return sm4_avx_ctr_crypt(req, SM4_CRYPT16_BLOCK_SIZE,
+				sm4_aesni_avx2_ctr_enc_blk16);
+}
+
+static struct skcipher_alg sm4_aesni_avx2_skciphers[] = {
+	{
+		.base = {
+			.cra_name		= "__ecb(sm4)",
+			.cra_driver_name	= "__ecb-sm4-aesni-avx2",
+			.cra_priority		= 500,
+			.cra_flags		= CRYPTO_ALG_INTERNAL,
+			.cra_blocksize		= SM4_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.walksize	= 16 * SM4_BLOCK_SIZE,
+		.setkey		= sm4_skcipher_setkey,
+		.encrypt	= sm4_avx_ecb_encrypt,
+		.decrypt	= sm4_avx_ecb_decrypt,
+	}, {
+		.base = {
+			.cra_name		= "__cbc(sm4)",
+			.cra_driver_name	= "__cbc-sm4-aesni-avx2",
+			.cra_priority		= 500,
+			.cra_flags		= CRYPTO_ALG_INTERNAL,
+			.cra_blocksize		= SM4_BLOCK_SIZE,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.ivsize		= SM4_BLOCK_SIZE,
+		.walksize	= 16 * SM4_BLOCK_SIZE,
+		.setkey		= sm4_skcipher_setkey,
+		.encrypt	= sm4_cbc_encrypt,
+		.decrypt	= cbc_decrypt,
+	}, {
+		.base = {
+			.cra_name		= "__cfb(sm4)",
+			.cra_driver_name	= "__cfb-sm4-aesni-avx2",
+			.cra_priority		= 500,
+			.cra_flags		= CRYPTO_ALG_INTERNAL,
+			.cra_blocksize		= 1,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.ivsize		= SM4_BLOCK_SIZE,
+		.chunksize	= SM4_BLOCK_SIZE,
+		.walksize	= 16 * SM4_BLOCK_SIZE,
+		.setkey		= sm4_skcipher_setkey,
+		.encrypt	= sm4_cfb_encrypt,
+		.decrypt	= cfb_decrypt,
+	}, {
+		.base = {
+			.cra_name		= "__ctr(sm4)",
+			.cra_driver_name	= "__ctr-sm4-aesni-avx2",
+			.cra_priority		= 500,
+			.cra_flags		= CRYPTO_ALG_INTERNAL,
+			.cra_blocksize		= 1,
+			.cra_ctxsize		= sizeof(struct sm4_ctx),
+			.cra_module		= THIS_MODULE,
+		},
+		.min_keysize	= SM4_KEY_SIZE,
+		.max_keysize	= SM4_KEY_SIZE,
+		.ivsize		= SM4_BLOCK_SIZE,
+		.chunksize	= SM4_BLOCK_SIZE,
+		.walksize	= 16 * SM4_BLOCK_SIZE,
+		.setkey		= sm4_skcipher_setkey,
+		.encrypt	= ctr_crypt,
+		.decrypt	= ctr_crypt,
+	}
+};
+
+static struct simd_skcipher_alg *
+simd_sm4_aesni_avx2_skciphers[ARRAY_SIZE(sm4_aesni_avx2_skciphers)];
+
+static int __init sm4_init(void)
+{
+	const char *feature_name;
+
+	if (!boot_cpu_has(X86_FEATURE_AVX) ||
+	    !boot_cpu_has(X86_FEATURE_AVX2) ||
+	    !boot_cpu_has(X86_FEATURE_AES) ||
+	    !boot_cpu_has(X86_FEATURE_OSXSAVE)) {
+		pr_info("AVX2 or AES-NI instructions are not detected.\n");
+		return -ENODEV;
+	}
+
+	if (!cpu_has_xfeatures(XFEATURE_MASK_SSE | XFEATURE_MASK_YMM,
+				&feature_name)) {
+		pr_info("CPU feature '%s' is not supported.\n", feature_name);
+		return -ENODEV;
+	}
+
+	return simd_register_skciphers_compat(sm4_aesni_avx2_skciphers,
+					ARRAY_SIZE(sm4_aesni_avx2_skciphers),
+					simd_sm4_aesni_avx2_skciphers);
+}
+
+static void __exit sm4_exit(void)
+{
+	simd_unregister_skciphers(sm4_aesni_avx2_skciphers,
+				ARRAY_SIZE(sm4_aesni_avx2_skciphers),
+				simd_sm4_aesni_avx2_skciphers);
+}
+
+module_init(sm4_init);
+module_exit(sm4_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Tianjia Zhang <tianjia.zhang@linux.alibaba.com>");
+MODULE_DESCRIPTION("SM4 Cipher Algorithm, AES-NI/AVX2 optimized");
+MODULE_ALIAS_CRYPTO("sm4");
+MODULE_ALIAS_CRYPTO("sm4-aesni-avx2");
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 8a4010d91124..536df4b6b825 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1591,6 +1591,28 @@ config CRYPTO_SM4_AESNI_AVX_X86_64
 
 	  If unsure, say N.
 
+config CRYPTO_SM4_AESNI_AVX2_X86_64
+	tristate "SM4 cipher algorithm (x86_64/AES-NI/AVX2)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_SIMD
+	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_SM4
+	select CRYPTO_SM4_AESNI_AVX_X86_64
+	help
+	  SM4 cipher algorithms (OSCCA GB/T 32907-2016) (x86_64/AES-NI/AVX2).
+
+	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
+	  Organization of State Commercial Administration of China (OSCCA)
+	  as an authorized cryptographic algorithms for the use within China.
+
+	  This is SM4 optimized implementation using AES-NI/AVX2/x86_64
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

