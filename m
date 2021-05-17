Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0073823E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 07:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhEQF7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 01:59:41 -0400
Received: from smtp21.cstnet.cn ([159.226.251.21]:34440 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231417AbhEQF73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 01:59:29 -0400
Received: from localhost.localdomain (unknown [121.232.13.213])
        by APP-01 (Coremail) with SMTP id qwCowAB3MIyuBaJgYcEJAA--.16203S2;
        Mon, 17 May 2021 13:57:03 +0800 (CST)
From:   Wang Junqiang <wangjunqiang@iscas.ac.cn>
To:     guoren@kernel.org
Cc:     guoren@linux.alibaba.com, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Li Weiwei <liweiwei@iscas.ac.cn>
Subject: [PATCH v3 1/2] csky: add CSKY 810/860 FPU instruction simulation
Date:   Mon, 17 May 2021 13:57:15 +0800
Message-Id: <20210517055716.26144-1-wangjunqiang@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowAB3MIyuBaJgYcEJAA--.16203S2
X-Coremail-Antispam: 1UD129KBjvAXoWkGr4UCr1xXw17CF1kXr17Awb_yoWfWry5Wo
        WDKF45J3y8Z34qyw45GayIgF1Ikr4kJr18Kay8ZrWxXFZ3Cr1SgrWrJr1jkF9Fqry5tryx
        uFZFqF1IqrW5XrZ3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5h7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
        xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8WwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
        AF67kF1VAFwI0_JF0_Jw1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67
        AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x
        0JUP-B_UUUUU=
X-Originating-IP: [121.232.13.213]
X-CM-SenderInfo: pzdqwy5xqtxt1qj6x2xfdvhtffof0/1tbiCwgEAFz4kEqkUwAAsO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is the implementation code of CSKY 810/860 FPU instruction
simulation based on the math-emu of kernel and glibc softfp:

sfp-machine.h: contains the migrated code and FMA support
sfp-fixs.h: contains the code that fix the origin math-emu library
            to CSKY 810/860 instruction function
fp810.c/fp860.c: contain the implementation of ck810 and ck860
                 FPU 32/64 instruction simulation
math.c: contains the function call interface

origin math-emu fixs:
    fix by #undef to replace macro in sfp-fixs.h
    typo 2->1 in _FP_FRAC_CLZ_4 macro
    exception flag setting in _FP_TO_INT_ROUND and _FP_PACK_CANONICAL macro
    calculation error in __FP_FRAC_SUB_3 and __FP_FRAC_SUB_4 macro

Change in v2:
 - Update description by Guo Ren review

Signed-off-by: Wang Junqiang <wangjunqiang@iscas.ac.cn>
Signed-off-by: Li Weiwei <liweiwei@iscas.ac.cn>
---
 arch/csky/include/asm/sfp-machine.h  |  441 ++++
 arch/csky/include/uapi/asm/siginfo.h |   10 +
 arch/csky/math-emu/Makefile          |   13 +
 arch/csky/math-emu/fp810.c           | 2254 ++++++++++++++++++++
 arch/csky/math-emu/fp810.h           |  164 ++
 arch/csky/math-emu/fp860.c           | 2936 ++++++++++++++++++++++++++
 arch/csky/math-emu/fp860.h           |  248 +++
 arch/csky/math-emu/math.c            |  481 +++++
 arch/csky/math-emu/math.h            |  168 ++
 arch/csky/math-emu/sfp-fixs.h        |  214 ++
 arch/csky/math-emu/sfp-util.h        |   99 +
 11 files changed, 7028 insertions(+)
 create mode 100644 arch/csky/include/asm/sfp-machine.h
 create mode 100644 arch/csky/include/uapi/asm/siginfo.h
 create mode 100644 arch/csky/math-emu/Makefile
 create mode 100644 arch/csky/math-emu/fp810.c
 create mode 100644 arch/csky/math-emu/fp810.h
 create mode 100644 arch/csky/math-emu/fp860.c
 create mode 100644 arch/csky/math-emu/fp860.h
 create mode 100644 arch/csky/math-emu/math.c
 create mode 100644 arch/csky/math-emu/math.h
 create mode 100644 arch/csky/math-emu/sfp-fixs.h
 create mode 100644 arch/csky/math-emu/sfp-util.h

diff --git a/arch/csky/include/asm/sfp-machine.h b/arch/csky/include/asm/sfp-machine.h
new file mode 100644
index 000000000000..1f6dfad701f1
--- /dev/null
+++ b/arch/csky/include/asm/sfp-machine.h
@@ -0,0 +1,441 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#define _FP_W_TYPE_SIZE 32
+#define _FP_W_TYPE unsigned long
+#define _FP_WS_TYPE signed long
+#define _FP_I_TYPE long
+
+#define _FP_MUL_MEAT_S(R, X, Y)                                                \
+	_FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S, R, X, Y, umul_ppmm)
+#define _FP_MUL_MEAT_D(R, X, Y)                                                \
+	_FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D, R, X, Y, umul_ppmm)
+#define _FP_MUL_MEAT_Q(R, X, Y)                                                \
+	_FP_MUL_MEAT_4_wide(_FP_WFRACBITS_Q, R, X, Y, umul_ppmm)
+
+#define _FP_MUL_MEAT_DW_S(R, X, Y)                                             \
+	_FP_MUL_MEAT_DW_1_wide(_FP_WFRACBITS_S, R, X, Y, umul_ppmm)
+#define _FP_MUL_MEAT_DW_D(R, X, Y)                                             \
+	_FP_MUL_MEAT_DW_2_wide(_FP_WFRACBITS_D, R, X, Y, umul_ppmm)
+#define _FP_MUL_MEAT_DW_Q(R, X, Y)                                             \
+	_FP_MUL_MEAT_DW_4_wide(_FP_WFRACBITS_Q, R, X, Y, umul_ppmm)
+
+#define _FP_DIV_MEAT_S(R, X, Y) _FP_DIV_MEAT_1_udiv_norm(S, R, X, Y)
+#define _FP_DIV_MEAT_D(R, X, Y) _FP_DIV_MEAT_2_udiv(D, R, X, Y)
+#define _FP_DIV_MEAT_Q(R, X, Y) _FP_DIV_MEAT_4_udiv(Q, R, X, Y)
+
+#define _FP_NANFRAC_S _FP_QNANBIT_S
+#define _FP_NANFRAC_D _FP_QNANBIT_D, 0
+#define _FP_NANFRAC_Q _FP_QNANBIT_Q, 0, 0, 0
+#define _FP_NANSIGN_S (0)
+#define _FP_NANSIGN_D (0)
+#define _FP_NANSIGN_Q (0)
+
+#define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
+
+#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)                                     \
+	do {                                                                   \
+		if ((_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs) &&          \
+		    !(_FP_FRAC_HIGH_RAW_##fs(Y) & _FP_QNANBIT_##fs)) {         \
+			R##_s = Y##_s;                                         \
+			_FP_FRAC_COPY_##wc(R, Y);                              \
+		} else {                                                       \
+			R##_s = X##_s;                                         \
+			_FP_FRAC_COPY_##wc(R, X);                              \
+		}                                                              \
+		R##_c = FP_CLS_NAN;                                            \
+	} while (0)
+
+#define __FPU_FPCSR (current->thread.user_fp.fcr)
+#define __FPU_FPCSR_RM (get_round_mode())
+#define _FP_TININESS_AFTER_ROUNDING (0)
+
+/* Obtain the current rounding mode. */
+#define FP_ROUNDMODE ({ (__FPU_FPCSR_RM & 0x3000000) >> 24; })
+
+#define FP_RND_NEAREST 0
+#define FP_RND_ZERO 1
+#define FP_RND_PINF 2
+#define FP_RND_MINF 3
+
+#define FP_EX_INVALID (1 << 0)
+#define FP_EX_DIVZERO (1 << 1)
+#define FP_EX_OVERFLOW (1 << 2)
+#define FP_EX_UNDERFLOW (1 << 3)
+#define FP_EX_INEXACT (1 << 4)
+#define FP_EX_DENORM (1 << 5)
+
+#define SF_CEQ 2
+#define SF_CLT 1
+#define SF_CGT 3
+#define SF_CUN 4
+
+#include <asm/byteorder.h>
+
+#ifdef __BIG_ENDIAN__
+#define __BYTE_ORDER __BIG_ENDIAN
+#define __LITTLE_ENDIAN 0
+#else
+#define __BYTE_ORDER __LITTLE_ENDIAN
+#define __BIG_ENDIAN 0
+#endif
+
+#if _FP_W_TYPE_SIZE < 64
+#define _FP_FRACTBITS_DW_D (4 * _FP_W_TYPE_SIZE)
+#define _FP_FRACTBITS_DW_S (2 * _FP_W_TYPE_SIZE)
+#define _FP_FRAC_LOW_D(X) _FP_FRAC_LOW_2(X)
+#define _FP_FRAC_HIGH_DW_D(X) _FP_FRAC_HIGH_4(X)
+#define _FP_FRAC_HIGH_DW_S(X) _FP_FRAC_HIGH_2(X)
+#else
+#define _FP_FRACTBITS_DW_D (2 * _FP_W_TYPE_SIZE)
+#define _FP_FRACTBITS_DW_S _FP_W_TYPE_SIZE
+#define _FP_FRAC_LOW_D(X) _FP_FRAC_LOW_1(X)
+#define _FP_FRAC_HIGH_DW_D(X) _FP_FRAC_HIGH_2(X)
+#define _FP_FRAC_HIGH_DW_S(X) _FP_FRAC_HIGH_1(X)
+#endif
+
+#define _FP_FRAC_LOW_S(X) _FP_FRAC_LOW_1(X)
+
+#define _FP_FRAC_HIGHBIT_DW_1(fs, X) (X##_f & _FP_HIGHBIT_DW_##fs)
+#define _FP_FRAC_HIGHBIT_DW_2(fs, X)                                           \
+	(_FP_FRAC_HIGH_DW_##fs(X) & _FP_HIGHBIT_DW_##fs)
+#define _FP_FRAC_HIGHBIT_DW_4(fs, X)                                           \
+	(_FP_FRAC_HIGH_DW_##fs(X) & _FP_HIGHBIT_DW_##fs)
+
+#define _FP_QNANBIT_SH_D                                                       \
+	((_FP_W_TYPE)1 << (_FP_FRACBITS_D - 2 + _FP_WORKBITS) % _FP_W_TYPE_SIZE)
+
+#define _FP_IMPLBIT_SH_D                                                       \
+	((_FP_W_TYPE)1 << (_FP_FRACBITS_D - 1 + _FP_WORKBITS) % _FP_W_TYPE_SIZE)
+
+#define _FP_WFRACBITS_DW_D (2 * _FP_WFRACBITS_D)
+#define _FP_WFRACXBITS_DW_D (_FP_FRACTBITS_DW_D - _FP_WFRACBITS_DW_D)
+#define _FP_HIGHBIT_DW_D                                                       \
+	((_FP_W_TYPE)1 << (_FP_WFRACBITS_DW_D - 1) % _FP_W_TYPE_SIZE)
+
+#define _FP_WFRACBITS_DW_S (2 * _FP_WFRACBITS_S)
+#define _FP_WFRACXBITS_DW_S (_FP_FRACTBITS_DW_S - _FP_WFRACBITS_DW_S)
+#define _FP_HIGHBIT_DW_S                                                       \
+	((_FP_W_TYPE)1 << (_FP_WFRACBITS_DW_S - 1) % _FP_W_TYPE_SIZE)
+
+#define _FP_MUL_MEAT_DW_1_wide(wfracbits, R, X, Y, doit)                       \
+	do {                                                                   \
+		doit(R##_f1, R##_f0, X##_f, Y##_f);                            \
+	} while (0)
+
+#define _FP_MUL_MEAT_DW_2_wide(wfracbits, R, X, Y, doit)                       \
+	do {                                                                   \
+		_FP_FRAC_DECL_2(_FP_MUL_MEAT_DW_2_wide_b);                     \
+		_FP_FRAC_DECL_2(_FP_MUL_MEAT_DW_2_wide_c);                     \
+		doit(_FP_FRAC_WORD_4(R, 1), _FP_FRAC_WORD_4(R, 0), X##_f0,     \
+		     Y##_f0);                                                  \
+		doit(_FP_MUL_MEAT_DW_2_wide_b_f1, _FP_MUL_MEAT_DW_2_wide_b_f0, \
+		     X##_f0, Y##_f1);                                          \
+		doit(_FP_MUL_MEAT_DW_2_wide_c_f1, _FP_MUL_MEAT_DW_2_wide_c_f0, \
+		     X##_f1, Y##_f0);                                          \
+		doit(_FP_FRAC_WORD_4(R, 3), _FP_FRAC_WORD_4(R, 2), X##_f1,     \
+		     Y##_f1);                                                  \
+		__FP_FRAC_ADD_3(_FP_FRAC_WORD_4(R, 3), _FP_FRAC_WORD_4(R, 2),  \
+				_FP_FRAC_WORD_4(R, 1), 0,                      \
+				_FP_MUL_MEAT_DW_2_wide_b_f1,                   \
+				_FP_MUL_MEAT_DW_2_wide_b_f0,                   \
+				_FP_FRAC_WORD_4(R, 3), _FP_FRAC_WORD_4(R, 2),  \
+				_FP_FRAC_WORD_4(R, 1));                        \
+		__FP_FRAC_ADD_3(_FP_FRAC_WORD_4(R, 3), _FP_FRAC_WORD_4(R, 2),  \
+				_FP_FRAC_WORD_4(R, 1), 0,                      \
+				_FP_MUL_MEAT_DW_2_wide_c_f1,                   \
+				_FP_MUL_MEAT_DW_2_wide_c_f0,                   \
+				_FP_FRAC_WORD_4(R, 3), _FP_FRAC_WORD_4(R, 2),  \
+				_FP_FRAC_WORD_4(R, 1));                        \
+	} while (0)
+
+#define _FP_FRAC_COPY_1_2(D, S) (D##_f = S##_f0)
+#define _FP_FRAC_COPY_2_1(D, S) ((D##_f0 = S##_f), (D##_f1 = 0))
+#define _FP_FRAC_COPY_2_2(D, S) _FP_FRAC_COPY_2(D, S)
+#define _FP_FRAC_COPY_1_4(D, S) (D##_f = S##_f[0])
+#define _FP_FRAC_COPY_2_4(D, S)                                                \
+	do {                                                                   \
+		D##_f0 = S##_f[0];                                             \
+		D##_f1 = S##_f[1];                                             \
+	} while (0)
+#define _FP_FRAC_COPY_4_1(D, S)                                                \
+	do {                                                                   \
+		D##_f[0] = S##_f;                                              \
+		D##_f[1] = D##_f[2] = D##_f[3] = 0;                            \
+	} while (0)
+#define _FP_FRAC_COPY_4_2(D, S)                                                \
+	do {                                                                   \
+		D##_f[0] = S##_f0;                                             \
+		D##_f[1] = S##_f1;                                             \
+		D##_f[2] = D##_f[3] = 0;                                       \
+	} while (0)
+#define _FP_FRAC_COPY_4_4(D, S) _FP_FRAC_COPY_4(D, S)
+
+/* fma (Inf, 0, c).  */
+#ifndef FP_EX_INVALID_IMZ_FMA
+#define FP_EX_INVALID_IMZ_FMA 0
+#endif
+
+#define __FP_FRAC_SUB_3(r2, r1, r0, x2, x1, x0, y2, y1, y0)                    \
+	do {                                                                   \
+		int _c1, _c2;                                                  \
+		r0 = x0 - y0;                                                  \
+		_c1 = r0 > x0;                                                 \
+		r1 = x1 - y1;                                                  \
+		_c2 = r1 > x1;                                                 \
+		r1 -= _c1;                                                     \
+		_c2 |= _c1 && (y1 == x1);                                      \
+		r2 = x2 - y2 - _c2;                                            \
+	} while (0)
+
+#define __FP_FRAC_SUB_4(r3, r2, r1, r0, x3, x2, x1, x0, y3, y2, y1, y0)        \
+	do {                                                                   \
+		int _c1, _c2, _c3;                                             \
+		r0 = x0 - y0;                                                  \
+		_c1 = r0 > x0;                                                 \
+		r1 = x1 - y1;                                                  \
+		_c2 = r1 > x1;                                                 \
+		r1 -= _c1;                                                     \
+		_c2 |= _c1 && (y1 == x1);                                      \
+		r2 = x2 - y2;                                                  \
+		_c3 = r2 > x2;                                                 \
+		r2 -= _c2;                                                     \
+		_c3 |= _c2 && (y2 == x2);                                      \
+		r3 = x3 - y3 - _c3;                                            \
+	} while (0)
+
+#define _FP_FMA(fs, wc, dwc, R, X, Y, Z)                                                \
+	do {                                                                            \
+		__label__ done_fma;                                                     \
+		FP_DECL_##fs(_FP_FMA_T);                                                \
+		_FP_FMA_T##_s = X##_s ^ Y##_s;                                          \
+		_FP_FMA_T##_e = X##_e + Y##_e + 1;                                      \
+		switch (_FP_CLS_COMBINE(X##_c, Y##_c)) {                                \
+		case _FP_CLS_COMBINE(FP_CLS_NORMAL, FP_CLS_NORMAL):                     \
+			switch (Z##_c) {                                                \
+			case FP_CLS_INF:                                                \
+			case FP_CLS_NAN:                                                \
+				R##_s = Z##_s;                                          \
+				_FP_FRAC_COPY_##wc(R, Z);                               \
+				R##_c = Z##_c;                                          \
+				break;                                                  \
+			case FP_CLS_ZERO:                                               \
+				R##_c = FP_CLS_NORMAL;                                  \
+				R##_s = _FP_FMA_T##_s;                                  \
+				R##_e = _FP_FMA_T##_e;                                  \
+				_FP_MUL_MEAT_##fs(R, X, Y);                             \
+				if (_FP_FRAC_OVERP_##wc(fs, R))                         \
+					_FP_FRAC_SRS_##wc(R, 1,                         \
+							  _FP_WFRACBITS_##fs);          \
+				else                                                    \
+					R##_e--;                                        \
+				break;                                                  \
+			case FP_CLS_NORMAL:;                                            \
+				_FP_FRAC_DECL_##dwc(_FP_FMA_TD);                        \
+				_FP_FRAC_DECL_##dwc(_FP_FMA_ZD);                        \
+				_FP_FRAC_DECL_##dwc(_FP_FMA_RD);                        \
+				_FP_MUL_MEAT_DW_##fs(_FP_FMA_TD, X, Y);                 \
+				R##_e = _FP_FMA_T##_e;                                  \
+				int _FP_FMA_tsh =                                       \
+					_FP_FRAC_HIGHBIT_DW_##dwc(                      \
+						fs, _FP_FMA_TD) == 0;                   \
+				_FP_FMA_T##_e -= _FP_FMA_tsh;                           \
+				int _FP_FMA_ediff = _FP_FMA_T##_e - Z##_e;              \
+				if (_FP_FMA_ediff >= 0) {                               \
+					int _FP_FMA_shift =                             \
+						_FP_WFRACBITS_##fs -                    \
+						_FP_FMA_tsh - _FP_FMA_ediff;            \
+					if (_FP_FMA_shift <=                            \
+					    -_FP_WFRACBITS_##fs)                        \
+						_FP_FRAC_SET_##dwc(                     \
+							_FP_FMA_ZD,                     \
+							_FP_MINFRAC_##dwc);             \
+					else {                                          \
+						_FP_FRAC_COPY_##dwc##_##wc(             \
+							_FP_FMA_ZD, Z);                 \
+						if (_FP_FMA_shift < 0)                  \
+							_FP_FRAC_SRS_##dwc(             \
+								_FP_FMA_ZD,             \
+								-_FP_FMA_shift,         \
+								_FP_WFRACBITS_DW_##fs); \
+						else if (_FP_FMA_shift > 0)             \
+							_FP_FRAC_SLL_##dwc(             \
+								_FP_FMA_ZD,             \
+								_FP_FMA_shift);         \
+					}                                               \
+					R##_s = _FP_FMA_T##_s;                          \
+					if (_FP_FMA_T##_s == Z##_s)                     \
+						_FP_FRAC_ADD_##dwc(                     \
+							_FP_FMA_RD,                     \
+							_FP_FMA_TD,                     \
+							_FP_FMA_ZD);                    \
+					else {                                          \
+						_FP_FRAC_SUB_##dwc(                     \
+							_FP_FMA_RD,                     \
+							_FP_FMA_TD,                     \
+							_FP_FMA_ZD);                    \
+						if (_FP_FRAC_NEGP_##dwc(                \
+							    _FP_FMA_RD)) {              \
+							R##_s = Z##_s;                  \
+							_FP_FRAC_SUB_##dwc(             \
+								_FP_FMA_RD,             \
+								_FP_FMA_ZD,             \
+								_FP_FMA_TD);            \
+						}                                       \
+					}                                               \
+				} else {                                                \
+					R##_e = Z##_e;                                  \
+					R##_s = Z##_s;                                  \
+					_FP_FRAC_COPY_##dwc##_##wc(_FP_FMA_ZD,          \
+								   Z);                  \
+					_FP_FRAC_SLL_##dwc(                             \
+						_FP_FMA_ZD,                             \
+						_FP_WFRACBITS_##fs);                    \
+					int _FP_FMA_shift =                             \
+						-_FP_FMA_ediff - _FP_FMA_tsh;           \
+					if (_FP_FMA_shift >=                            \
+					    _FP_WFRACBITS_DW_##fs)                      \
+						_FP_FRAC_SET_##dwc(                     \
+							_FP_FMA_TD,                     \
+							_FP_MINFRAC_##dwc);             \
+					else if (_FP_FMA_shift > 0)                     \
+						_FP_FRAC_SRS_##dwc(                     \
+							_FP_FMA_TD,                     \
+							_FP_FMA_shift,                  \
+							_FP_WFRACBITS_DW_##fs);         \
+					if (Z##_s == _FP_FMA_T##_s)                     \
+						_FP_FRAC_ADD_##dwc(                     \
+							_FP_FMA_RD,                     \
+							_FP_FMA_ZD,                     \
+							_FP_FMA_TD);                    \
+					else                                            \
+						_FP_FRAC_SUB_##dwc(                     \
+							_FP_FMA_RD,                     \
+							_FP_FMA_ZD,                     \
+							_FP_FMA_TD);                    \
+				}                                                       \
+				if (_FP_FRAC_ZEROP_##dwc(_FP_FMA_RD)) {                 \
+					if (_FP_FMA_T##_s == Z##_s)                     \
+						R##_s = Z##_s;                          \
+					else                                            \
+						R##_s = (FP_ROUNDMODE ==                \
+							 FP_RND_MINF);                  \
+					_FP_FRAC_SET_##wc(R,                            \
+							  _FP_ZEROFRAC_##wc);           \
+					R##_c = FP_CLS_ZERO;                            \
+				} else {                                                \
+					int _FP_FMA_rlz;                                \
+					_FP_FRAC_CLZ_##dwc(_FP_FMA_rlz,                 \
+							   _FP_FMA_RD);                 \
+					_FP_FMA_rlz -= _FP_WFRACXBITS_DW_##fs;          \
+					R##_e -= _FP_FMA_rlz;                           \
+					int _FP_FMA_shift =                             \
+						_FP_WFRACBITS_##fs -                    \
+						_FP_FMA_rlz;                            \
+					if (_FP_FMA_shift > 0)                          \
+						_FP_FRAC_SRS_##dwc(                     \
+							_FP_FMA_RD,                     \
+							_FP_FMA_shift,                  \
+							_FP_WFRACBITS_DW_##fs);         \
+					else if (_FP_FMA_shift < 0)                     \
+						_FP_FRAC_SLL_##dwc(                     \
+							_FP_FMA_RD,                     \
+							-_FP_FMA_shift);                \
+					_FP_FRAC_COPY_##wc##_##dwc(                     \
+						R, _FP_FMA_RD);                         \
+					R##_c = FP_CLS_NORMAL;                          \
+				}                                                       \
+				break;                                                  \
+			}                                                               \
+			goto done_fma;                                                  \
+		case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_NAN):                           \
+			_FP_CHOOSENAN(fs, wc, _FP_FMA_T, X, Y, '*');                    \
+			break;                                                          \
+		case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_NORMAL):                        \
+		case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_INF):                           \
+		case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_ZERO):                          \
+			_FP_FMA_T##_s = X##_s;                                          \
+		case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_INF):                           \
+		case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_NORMAL):                        \
+		case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_NORMAL):                       \
+		case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_ZERO):                         \
+			_FP_FRAC_COPY_##wc(_FP_FMA_T, X);                               \
+			_FP_FMA_T##_c = X##_c;                                          \
+			break;                                                          \
+		case _FP_CLS_COMBINE(FP_CLS_NORMAL, FP_CLS_NAN):                        \
+		case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_NAN):                           \
+		case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_NAN):                          \
+			_FP_FMA_T##_s = Y##_s;                                          \
+		case _FP_CLS_COMBINE(FP_CLS_NORMAL, FP_CLS_INF):                        \
+		case _FP_CLS_COMBINE(FP_CLS_NORMAL, FP_CLS_ZERO):                       \
+			_FP_FRAC_COPY_##wc(_FP_FMA_T, Y);                               \
+			_FP_FMA_T##_c = Y##_c;                                          \
+			break;                                                          \
+		case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_ZERO):                          \
+		case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_INF):                          \
+			_FP_FMA_T##_s = _FP_NANSIGN_##fs;                               \
+			_FP_FMA_T##_c = FP_CLS_NAN;                                     \
+			_FP_FRAC_SET_##wc(_FP_FMA_T, _FP_NANFRAC_##fs);                 \
+			FP_SET_EXCEPTION(FP_EX_INVALID |                                \
+					 FP_EX_INVALID_IMZ_FMA);                        \
+			break;                                                          \
+		default:                                                                \
+			abort();                                                        \
+		}                                                                       \
+		/* T = X * Y is zero, infinity or NaN.  */                              \
+		switch (_FP_CLS_COMBINE(_FP_FMA_T##_c, Z##_c)) {                        \
+		case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_NAN):                           \
+			_FP_CHOOSENAN(fs, wc, R, _FP_FMA_T, Z, '+');                    \
+			break;                                                          \
+		case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_NORMAL):                        \
+		case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_INF):                           \
+		case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_ZERO):                          \
+		case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_NORMAL):                        \
+		case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_ZERO):                          \
+			R##_s = _FP_FMA_T##_s;                                          \
+			_FP_FRAC_COPY_##wc(R, _FP_FMA_T);                               \
+			R##_c = _FP_FMA_T##_c;                                          \
+			break;                                                          \
+		case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_NAN):                           \
+		case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_NAN):                          \
+		case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_NORMAL):                       \
+		case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_INF):                          \
+			R##_s = Z##_s;                                                  \
+			_FP_FRAC_COPY_##wc(R, Z);                                       \
+			R##_c = Z##_c;                                                  \
+			R##_e = Z##_e;                                                  \
+			break;                                                          \
+		case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_INF):                           \
+			if (_FP_FMA_T##_s == Z##_s) {                                   \
+				R##_s = Z##_s;                                          \
+				_FP_FRAC_COPY_##wc(R, Z);                               \
+				R##_c = Z##_c;                                          \
+			} else {                                                        \
+				R##_s = _FP_NANSIGN_##fs;                               \
+				R##_c = FP_CLS_NAN;                                     \
+				_FP_FRAC_SET_##wc(R, _FP_NANFRAC_##fs);                 \
+				FP_SET_EXCEPTION(FP_EX_INVALID |                        \
+						 FP_EX_INVALID_ISI);                    \
+			}                                                               \
+			break;                                                          \
+		case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_ZERO):                         \
+			if (_FP_FMA_T##_s == Z##_s)                                     \
+				R##_s = Z##_s;                                          \
+			else                                                            \
+				R##_s = (FP_ROUNDMODE == FP_RND_MINF);                  \
+			_FP_FRAC_COPY_##wc(R, Z);                                       \
+			R##_c = Z##_c;                                                  \
+			break;                                                          \
+		default:                                                                \
+			abort();                                                        \
+		}                                                                       \
+	done_fma:;                                                                      \
+	} while (0)
+
+#if _FP_W_TYPE_SIZE < 64
+#define FP_FMA_S(R, X, Y, Z) _FP_FMA(S, 1, 2, R, X, Y, Z)
+#define FP_FMA_D(R, X, Y, Z) _FP_FMA(D, 2, 4, R, X, Y, Z)
+#else
+#define FP_FMA_S(R, X, Y, Z) _FP_FMA(S, 1, 1, R, X, Y, Z)
+#define FP_FMA_D(R, X, Y, Z) _FP_FMA(D, 1, 2, R, X, Y, Z)
+#endif
diff --git a/arch/csky/include/uapi/asm/siginfo.h b/arch/csky/include/uapi/asm/siginfo.h
new file mode 100644
index 000000000000..b822b6f8d0e7
--- /dev/null
+++ b/arch/csky/include/uapi/asm/siginfo.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _CSKY_SIGINFO_H
+#define _CSKY_SIGINFO_H
+
+#include <asm-generic/siginfo.h>
+
+#undef __SI_FAULT
+#define __SI_FAULT	-2
+
+#endif
diff --git a/arch/csky/math-emu/Makefile b/arch/csky/math-emu/Makefile
new file mode 100644
index 000000000000..9fea02749367
--- /dev/null
+++ b/arch/csky/math-emu/Makefile
@@ -0,0 +1,13 @@
+#
+# Makefile for csky-specific math emulate.
+#
+
+ccflags-y := -w
+
+obj-$(CONFIG_CPU_HAS_MATHEMU)		+= math-emu.o
+
+ifneq ($(CONFIG_CPU_CK860),y)
+math-emu-y			+= math.o fp810.o
+else
+math-emu-y			+= math.o fp860.o
+endif
diff --git a/arch/csky/math-emu/fp810.c b/arch/csky/math-emu/fp810.c
new file mode 100644
index 000000000000..f35ae8ba5374
--- /dev/null
+++ b/arch/csky/math-emu/fp810.c
@@ -0,0 +1,2254 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/uaccess.h>
+#include "sfp-util.h"
+#include <math-emu/soft-fp.h>
+#include "sfp-fixs.h"
+#include <math-emu/single.h>
+#include <math-emu/double.h>
+#include "fp810.h"
+
+/*
+ * z = |x|
+ */
+void
+FPUV2_OP_FUNC(fabsd)
+{
+	union float64_components u;
+
+	u.f64 = get_float64(x);
+#ifdef __CSKYBE__
+	u.i[0] &= 0x7fffffff;
+#else
+	u.i[1] &= 0x7fffffff;
+#endif
+	set_float64(u.f64, z);
+}
+
+void
+FPUV2_OP_FUNC(fabsm)
+{
+	union float64_components u;
+
+	u.f64 = get_float64(x);
+	u.i[0] &= 0x7fffffff;
+	u.i[1] &= 0x7fffffff;
+	set_float64(u.f64, z);
+}
+
+void
+FPUV2_OP_FUNC(fabss)
+{
+	unsigned int result;
+
+	result = get_float32(x) & 0x7fffffff;
+	set_float32(result, z);
+}
+
+/*
+ * z = x + y
+ */
+void
+FPUV2_OP_FUNC(faddd)
+{
+	FPU_INSN_START(DR, DR, DI);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_ADD_D(R, A, B);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(faddm)
+{
+	FPU_INSN_START(DR, DR, DI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_ADD_S(R, A, B);
+	FP_PACK_SP(vrz, R);
+
+	FP_UNPACK_SP(A, vrx + 4);
+	FP_UNPACK_SP(B, vry + 4);
+
+	FP_ADD_S(R, A, B);
+
+	FP_PACK_SP(vrz + 4, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fadds)
+{
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_ADD_S(R, A, B);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * fpsr.c = (x >= y) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmphsd)
+{
+	int result;
+
+	FPU_INSN_START(DR, DR, DN);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_CMP_D(result, A, B, 3);
+	if  ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	    result = 0;
+	} else
+		result = ((result == 0) || (result == 1)) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x >= y) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmphss)
+{
+	int result;
+
+	FPU_INSN_START(SR, SR, SN);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_CMP_S(result, A, B, 3);
+	if  ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	    result = 0;
+	} else
+		result = ((result == 0) || (result == 1)) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x < y) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmpltd)
+{
+	int result;
+
+	FPU_INSN_START(DR, DR, DN);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_CMP_D(result, A, B, 3);
+	if  ((result == 3) && (((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN)))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	    result = 0;
+	} else
+		result = (result == -1) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x < y) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmplts)
+{
+	int result;
+
+	FPU_INSN_START(SR, SR, SN);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_CMP_S(result, A, B, 3);
+	if  ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	    result = 0;
+	} else
+		result = (result == -1) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x == y) ? 0 : 1
+ */
+void
+FPUV2_OP_FUNC(fcmpned)
+{
+	int result;
+
+	FPU_INSN_START(DR, DR, DN);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_CMP_D(result, A, B, 3);
+	if  ((result == 3) && (FP_ISSIGNAN_D(A) || FP_ISSIGNAN_D(B))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	    result = 1;
+	} else
+		result = (result != 0) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x == y) ? 0 : 1
+ */
+void
+FPUV2_OP_FUNC(fcmpnes)
+{
+	int result;
+
+	FPU_INSN_START(SR, SR, SN);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_CMP_S(result, A, B, 3);
+	if ((result == 3) && (FP_ISSIGNAN_S(A) || FP_ISSIGNAN_S(B))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	    result = 1;
+	} else
+		result = (result != 0) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x == NaN || y == NaN) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmpuod)
+{
+	int result;
+
+	FPU_INSN_START(DR, DR, DN);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	result = (A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x == NaN || y == NaN) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmpuos)
+{
+	int result;
+
+	FPU_INSN_START(SR, SR, SN);
+
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	result = (A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x >= 0) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmpzhsd)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(DR, DN, DN);
+	DP_CONST_DATA(constant, 0);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, constant);
+
+	FP_CMP_D(result, A, B, 3);
+	if ((result == 3) && (A_c == FP_CLS_NAN)) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	    result = 0;
+	} else
+		result = ((result == 0) || (result == 1)) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x >= 0) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmpzhss)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(SR, SN, SN);
+	SP_CONST_DATA(constant, 0);
+
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, constant);
+
+	FP_CMP_S(result, A, B, 3);
+	if  ((result == 3) && (A_c == FP_CLS_NAN)) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	    result = 0;
+	} else
+		result = ((result == 0) || (result == 1)) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x <= 0) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmpzlsd)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(DR, DN, DN);
+	DP_CONST_DATA(constant, 0);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, constant);
+
+	FP_CMP_D(result, A, B, 3);
+	if  ((result == 3) && (FP_ISSIGNAN_D(A))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	    result = 0;
+	} else
+		result = ((result == 0) || (result == -1)) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x <= 0) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmpzlss)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(SR, SN, SN);
+	SP_CONST_DATA(constant, 0);
+
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, constant);
+
+	FP_CMP_S(result, A, B, 3);
+	if  ((result == 3) && (A_c == FP_CLS_NAN)) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	    result = 0;
+	} else
+		result = ((result == 0) || (result == -1)) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x != 0) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmpzned)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(DR, DN, DN);
+	DP_CONST_DATA(constant, 0);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, constant);
+
+	FP_CMP_D(result, A, B, 3);
+	if  ((result == 3) && (FP_ISSIGNAN_D(A))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	    result = 1;
+	} else
+		result = (result != 0) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x != 0) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmpznes)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(SR, SN, SN);
+	SP_CONST_DATA(constant, 0);
+
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, constant);
+
+	FP_CMP_S(result, A, B, 3);
+	if  ((result == 3) && (FP_ISSIGNAN_S(A))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	    result = 1;
+	} else
+		result = (result != 0) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x == NaN) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmpzuod)
+{
+	int result;
+
+	FPU_INSN_START(DR, DN, DN);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+
+	result = (A_c == FP_CLS_NAN) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * fpsr.c = (x == NaN) ? 1 : 0
+ */
+void
+FPUV2_OP_FUNC(fcmpzuos)
+{
+	int result;
+
+	FPU_INSN_START(SR, SN, SN);
+
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+
+	result = (A_c == FP_CLS_NAN) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+/*
+ * z = x / y
+ */
+void
+FPUV2_OP_FUNC(fdivd)
+{
+	FPU_INSN_START(DR, DR, DI);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_DIV_D(R, A, B);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fdivs)
+{
+	FPU_INSN_START(SR, SR, SI);
+
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_DIV_S(R, A, B);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = (float)x
+ */
+void
+FPUV2_OP_FUNC(fdtos)
+{
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+
+	FP_CONV(S, D, 1, 2, R, A);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = (int)x
+ */
+void
+FPUV2_OP_FUNC(fdtosi_rn)
+{
+	int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_NEAREST);
+	if  (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if  (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+
+	FPU_INSN_SP_END;
+}
+
+void
+FPUV2_OP_FUNC(fdtosi_rz)
+{
+	int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_ZERO);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if  (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+
+	FPU_INSN_SP_END;
+}
+
+void
+FPUV2_OP_FUNC(fdtosi_rpi)
+{
+	int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_PINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void
+FPUV2_OP_FUNC(fdtosi_rni)
+{
+	int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_MINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = (unsigned int)x
+ */
+void
+FPUV2_OP_FUNC(fdtoui_rn)
+{
+	unsigned int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_NEAREST);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void
+FPUV2_OP_FUNC(fdtoui_rz)
+{
+	unsigned int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_ZERO);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void
+FPUV2_OP_FUNC(fdtoui_rpi)
+{
+	unsigned int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_PINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void
+FPUV2_OP_FUNC(fdtoui_rni)
+{
+	unsigned int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_MINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z += x * y
+ */
+void
+FPUV2_OP_FUNC(fmacd)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(C);
+	FP_DECL_D(T);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+	FP_UNPACK_DP(C, vrz);
+
+	FP_MUL_D(T, A, B);
+	MAC_INTERNAL_ROUND_DP;
+	FP_ADD_D(R, T, C);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fmacm)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+	FP_UNPACK_SP(C, vrz);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_ADD_S(R, T, C);
+
+	FP_PACK_SP(vrz, R);
+
+	FP_UNPACK_SP(A, vrx + 4);
+	FP_UNPACK_SP(B, vry + 4);
+	FP_UNPACK_SP(C, vrz + 4);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_ADD_S(R, T, C);
+
+	FP_PACK_SP(vrz + 4, R);
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fmacs)
+{
+	FPU_INSN_START(SR, SR, SR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+	FP_UNPACK_SP(C, vrz);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_ADD_S(R, T, C);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = x[63:32]
+ */
+void
+FPUV2_OP_FUNC(fmfvrh)
+{
+	union float64_components op_val1;
+	unsigned int result;
+
+	z = inst_data->inst & 0x1f;
+	x = CSKY_INSN_RX(inst_data->inst);
+	op_val1.f64 = get_float64(x);
+
+#ifdef __CSKYBE__
+	result = (unsigned int)op_val1.i[0];
+#else
+	result = (unsigned int)op_val1.i[1];
+#endif
+
+	set_uint32(result, z, inst_data);
+}
+
+/*
+ * z = x[31:0]
+ */
+void
+FPUV2_OP_FUNC(fmfvrl)
+{
+	union float64_components op_val1;
+	unsigned int result;
+
+	z = inst_data->inst & 0x1f;
+	x = CSKY_INSN_RX(inst_data->inst);
+	op_val1.f64 = get_float64(x);
+
+#ifdef __CSKYBE__
+	result = (unsigned int)op_val1.i[1];
+#else
+	result = (unsigned int)op_val1.i[0];
+#endif
+
+	set_uint32(result, z, inst_data);
+}
+
+/*
+ * z = x
+ */
+void
+FPUV2_OP_FUNC(fmovd)
+{
+	unsigned long long result;
+
+	result = get_float64(x);
+
+	set_float64(result, z);
+}
+
+void
+FPUV2_OP_FUNC(fmovm)
+{
+	unsigned long long result;
+
+	result = get_float64(x);
+
+	set_float64(result, z);
+}
+
+void
+FPUV2_OP_FUNC(fmovs)
+{
+	unsigned int result;
+
+	result = get_float32(x);
+
+	set_float32(result, z);
+}
+
+/*
+ * z = x * y - z
+ */
+void
+FPUV2_OP_FUNC(fmscd)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(C);
+	FP_DECL_D(T);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+	FP_UNPACK_DP(C, vrz);
+
+	FP_MUL_D(T, A, B);
+	MAC_INTERNAL_ROUND_DP;
+	FP_SUB_D(R, T, C);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fmscm)
+{
+	FPU_INSN_START(DR, DR, DI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+	FP_UNPACK_SP(C, vrz);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_SUB_S(R, T, C);
+
+	FP_PACK_SP(vrz, R);
+
+	FP_UNPACK_SP(A, vrx + 4);
+	FP_UNPACK_SP(B, vry + 4);
+	FP_UNPACK_SP(C, vrz + 4);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_SUB_S(R, T, C);
+
+	FP_PACK_SP(vrz + 4, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fmscs)
+{
+	FPU_INSN_START(SR, SR, SR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+	FP_UNPACK_SP(C, vrz);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_SUB_S(R, T, C);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z[63:32] = x
+ */
+void
+FPUV2_OP_FUNC(fmtvrh)
+{
+	union float64_components result;
+
+	x = CSKY_INSN_RX(inst_data->inst);
+#ifdef __CSKYBE__
+	result.i[0] = (unsigned int)get_uint32(x, inst_data);
+	set_float32h(result.i[0], z);
+#else
+	result.i[1] = (unsigned int)get_uint32(x, inst_data);
+	set_float32h(result.i[1], z);
+#endif
+}
+
+/*
+ * z[31:0] = x
+ */
+void
+FPUV2_OP_FUNC(fmtvrl)
+{
+	union float64_components result;
+
+	x = CSKY_INSN_RX(inst_data->inst);
+#ifdef __CSKYBE__
+	result.i[1] = (unsigned int)get_uint32(x, inst_data);
+	set_float32(result.i[1], z);
+#else
+	result.i[0] = (unsigned int)get_uint32(x, inst_data);
+	set_float32(result.i[0], z);
+#endif
+}
+
+/*
+ * z = x * y
+ */
+void
+FPUV2_OP_FUNC(fmuld)
+{
+	FPU_INSN_START(DR, DR, DI);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_MUL_D(R, A, B);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fmulm)
+{
+	FPU_INSN_START(DR, DR, DI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_MUL_S(R, A, B);
+
+	FP_PACK_SP(vrz, R);
+
+	FP_UNPACK_SP(A, vrx + 4);
+	FP_UNPACK_SP(B, vry + 4);
+
+	FP_MUL_S(R, A, B);
+
+	FP_PACK_SP(vrz + 4, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fmuls)
+{
+
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_MUL_S(R, A, B);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = -x
+ */
+void
+FPUV2_OP_FUNC(fnegd)
+{
+	union float64_components u;
+
+	u.f64 = get_float64(x);
+#ifdef __CSKYBE__
+	u.i[0] ^= 0x80000000;
+#else
+	u.i[1] ^= 0x80000000;
+#endif
+	set_float64(u.f64, z);
+}
+
+void
+FPUV2_OP_FUNC(fnegm)
+{
+	union float64_components u;
+
+	u.f64 = get_float64(x);
+	u.i[0] ^= 0x80000000;
+	u.i[1] ^= 0x80000000;
+	set_float64(u.f64, z);
+}
+
+void
+FPUV2_OP_FUNC(fnegs)
+{
+	unsigned int result;
+
+	result = get_float32(x) ^ 0x80000000;
+	set_float32(result, z);
+}
+
+/*
+ * z -= x * y
+ */
+void
+FPUV2_OP_FUNC(fnmacd)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(C);
+	FP_DECL_D(T);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+	FP_UNPACK_DP(C, vrz);
+
+	FP_MUL_D(T, A, B);
+	MAC_INTERNAL_ROUND_DP;
+	FP_SUB_D(R, C, T);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fnmacm)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+	FP_UNPACK_SP(C, vrz);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_SUB_S(R, C, T);
+
+	FP_PACK_SP(vrz, R);
+
+	FP_UNPACK_SP(A, vrx + 4);
+	FP_UNPACK_SP(B, vry + 4);
+	FP_UNPACK_SP(C, vrz + 4);
+
+	FP_MUL_S(T, A, B);
+
+	FP_SUB_S(R, C, T);
+
+	FP_PACK_SP(vrz + 4, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fnmacs)
+{
+	FPU_INSN_START(SR, SR, SR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+	FP_UNPACK_SP(C, vrz);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_SUB_S(R, C, T);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = -z -x * y
+ */
+void
+FPUV2_OP_FUNC(fnmscd)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(C);
+	FP_DECL_D(T);
+	FP_DECL_D(N);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+	FP_UNPACK_DP(C, vrz);
+
+	FP_MUL_D(T, A, B);
+	MAC_INTERNAL_ROUND_DP;
+	FP_NEG_D(N, C);
+	FP_SUB_D(R, N, T);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fnmscm)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(N);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+	FP_UNPACK_SP(C, vrz);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_NEG_S(N, C);
+	FP_SUB_S(R, N, T);
+
+	FP_PACK_SP(vrz, R);
+
+	FP_UNPACK_SP(A, vrx + 4);
+	FP_UNPACK_SP(B, vry + 4);
+	FP_UNPACK_SP(C, vrz + 4);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_NEG_S(N, C);
+	FP_SUB_S(R, N, T);
+
+	FP_PACK_SP(vrz + 4, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fnmscs)
+{
+	FPU_INSN_START(SR, SR, SR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(N);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+	FP_UNPACK_SP(C, vrz);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_NEG_S(N, C);
+	FP_SUB_S(R, N, T);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = -x * y
+ */
+void
+FPUV2_OP_FUNC(fnmuld)
+{
+	FPU_INSN_START(DR, DR, DI);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(T);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_MUL_D(T, A, B);
+	FP_NEG_D(R, T);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fnmulm)
+{
+	FPU_INSN_START(DR, DR, DI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_MUL_S(T, A, B);
+	FP_NEG_S(R, T);
+
+	FP_PACK_SP(vrz, R);
+
+	FP_UNPACK_SP(A, vrx + 4);
+	FP_UNPACK_SP(B, vry + 4);
+
+	FP_MUL_S(T, A, B);
+	FP_NEG_S(R, T);
+
+	FP_PACK_SP(vrz + 4, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fnmuls)
+{
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_MUL_S(T, A, B);
+	FP_NEG_S(R, T);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = 1 / x
+ */
+void
+FPUV2_OP_FUNC(frecipd)
+{
+	void *constant;
+
+	FPU_INSN_START(DR, DN, DI);
+	DP_CONST_DATA(constant, 1);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, constant);
+
+	FP_DIV_D(R, B, A);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(frecips)
+{
+	void *constant;
+	unsigned int constant_val;
+
+	FPU_INSN_START(SR, SN, SI);
+	constant_val = get_single_constant(1);
+	constant = &constant_val;
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, constant);
+
+	FP_DIV_S(R, B, A);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = (double)x
+ */
+void
+FPUV2_OP_FUNC(fsitod)
+{
+	FPU_INSN_START(SR, DN, DI);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_D(R, *(int *)vrx, 32, int);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+
+}
+
+/*
+ * z = (float)x
+ */
+void
+FPUV2_OP_FUNC(fsitos)
+{
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_S(R, *(int *)vrx, 32, int);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = x ^ 1/2
+ */
+void
+FPUV2_OP_FUNC(fsqrtd)
+{
+	FPU_INSN_START(DR, DN, DI);
+	FP_DECL_D(A);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+
+	FP_SQRT_D(R, A);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fsqrts)
+{
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+
+	FP_SQRT_S(R, A);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = (double)x
+ */
+void
+FPUV2_OP_FUNC(fstod)
+{
+	FPU_INSN_START(SR, DN, DI);
+	FP_DECL_S(A);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+
+	FP_CONV(D, S, 2, 1, R, A);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+/*
+ * z = (int)x
+ */
+void
+FPUV2_OP_FUNC(fstosi_rn)
+{
+	int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_NEAREST);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		FP_SET_EXCEPTION(FP_CUR_EXCEPTIONS);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void
+FPUV2_OP_FUNC(fstosi_rz)
+{
+	int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_ZERO);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void
+FPUV2_OP_FUNC(fstosi_rpi)
+{
+	int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_PINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void
+FPUV2_OP_FUNC(fstosi_rni)
+{
+	int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_MINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = (unsigned int)x
+ */
+void
+FPUV2_OP_FUNC(fstoui_rn)
+{
+	unsigned int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_NEAREST);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void
+FPUV2_OP_FUNC(fstoui_rz)
+{
+	unsigned int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_ZERO);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void
+FPUV2_OP_FUNC(fstoui_rpi)
+{
+	unsigned int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_PINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void
+FPUV2_OP_FUNC(fstoui_rni)
+{
+	unsigned int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_MINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = x - y
+ */
+void
+FPUV2_OP_FUNC(fsubd)
+{
+	FPU_INSN_START(DR, DR, DI);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_SUB_D(R, A, B);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fsubm)
+{
+	FPU_INSN_START(DR, DR, DI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_SUB_S(R, A, B);
+
+	FP_PACK_SP(vrz, R);
+
+	FP_UNPACK_SP(A, vrx + 4);
+	FP_UNPACK_SP(B, vry + 4);
+
+	FP_SUB_S(R, A, B);
+
+	FP_PACK_SP(vrz + 4, R);
+
+	FPU_INSN_DP_END;
+}
+
+void
+FPUV2_OP_FUNC(fsubs)
+{
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_SUB_S(R, A, B);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = (double)x
+ */
+void
+FPUV2_OP_FUNC(fuitod)
+{
+	FPU_INSN_START(SR, DN, DI);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_D(R, *(unsigned int *)vrx, 32, int);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+
+}
+
+/*
+ * z = (float)x
+ */
+void
+FPUV2_OP_FUNC(fuitos)
+{
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_S(R, *(unsigned int *)vrx, 32, int);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+/*
+ * z = *(x + imm * 4)
+ */
+void
+FPUV2_OP_FUNC(fldd)
+{
+	unsigned long long result;
+	unsigned int imm;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	imm = FPUV2_LDST_IMM8(inst_data->inst);
+	result = get_float64_from_memory(op_val1 + imm * 4);
+
+	set_float64(result, z);
+}
+
+void
+FPUV2_OP_FUNC(fldm)
+{
+	unsigned long long result;
+	unsigned int imm;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	imm = FPUV2_LDST_IMM8(inst_data->inst);
+	result = get_float64_from_memory(op_val1 + imm * 8);
+
+	set_float64(result, z);
+}
+
+void
+FPUV2_OP_FUNC(flds)
+{
+	unsigned int result;
+	unsigned int imm;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	imm = FPUV2_LDST_IMM8(inst_data->inst);
+	result = get_float32_from_memory(op_val1 + imm * 4);
+
+	set_float32(result, z);
+}
+
+/*
+ * z = *(x)  ...
+ */
+void
+FPUV2_OP_FUNC(fldmd)
+{
+	unsigned long long result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float64_from_memory(op_val1 + i * 8);
+		set_float64(result, z + i);
+	}
+}
+
+void
+FPUV2_OP_FUNC(fldmm)
+{
+	unsigned long long result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float64_from_memory(op_val1 + i * 8);
+		set_float64(result, z + i);
+	}
+}
+
+void
+FPUV2_OP_FUNC(fldms)
+{
+	unsigned int result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float32_from_memory(op_val1 + i * 4);
+		set_float32(result, z + i);
+	}
+}
+
+/*
+ * z = *(x + y * imm)
+ */
+void
+FPUV2_OP_FUNC(fldrd)
+{
+	unsigned long long result;
+	unsigned int imm, op_val1, op_val2;
+
+	imm = FPUV2_LDST_R_IMM2(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	op_val2 = get_uint32(y, inst_data);
+	result = get_float64_from_memory(op_val1 + (op_val2 << imm));
+
+	set_float64(result, z);
+}
+
+void
+FPUV2_OP_FUNC(fldrm)
+{
+	unsigned long long result;
+	unsigned int imm, op_val1, op_val2;
+
+	imm =  FPUV2_LDST_R_IMM2(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	op_val2 = get_uint32(y, inst_data);
+	result = get_float64_from_memory(op_val1 + (op_val2 << imm));
+
+	set_float64(result, z);
+}
+
+void
+FPUV2_OP_FUNC(fldrs)
+{
+	unsigned int result;
+	unsigned int imm, op_val1, op_val2;
+
+	imm =  FPUV2_LDST_R_IMM2(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	op_val2 = get_uint32(y, inst_data);
+	result = get_float32_from_memory(op_val1 + (op_val2 << imm));
+
+	set_float32(result, z);
+}
+
+/*
+ * *(x + imm * 4) = z
+ */
+void
+FPUV2_OP_FUNC(fstd)
+{
+	unsigned long long result;
+	unsigned int imm, op_val1;
+
+	imm = FPUV2_LDST_IMM8(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	result = get_float64(z);
+
+	set_float64_to_memory(result, op_val1 + imm * 4);
+}
+
+void
+FPUV2_OP_FUNC(fstm)
+{
+	unsigned long long result;
+	unsigned int imm, op_val1;
+
+	imm = FPUV2_LDST_IMM8(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	result = get_float64(z);
+
+	set_float64_to_memory(result, op_val1 + imm * 8);
+}
+
+void
+FPUV2_OP_FUNC(fsts)
+{
+	unsigned int result;
+	unsigned int imm, op_val1;
+
+	imm = FPUV2_LDST_IMM8(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	result = get_float32(z);
+
+	set_float32_to_memory(result, op_val1 + imm * 4);
+}
+
+/*
+ * z = *(x)  ...
+ */
+void
+FPUV2_OP_FUNC(fstmd)
+{
+	unsigned long long result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float64(z + i);
+		set_float64_to_memory(result, op_val1 + i * 8);
+	}
+}
+
+void
+FPUV2_OP_FUNC(fstmm)
+{
+	unsigned long long result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float64(z + i);
+		set_float64_to_memory(result, op_val1 + i * 8);
+	}
+}
+
+void
+FPUV2_OP_FUNC(fstms)
+{
+	unsigned int result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float32(z + i);
+		set_float32_to_memory(result, op_val1 + i * 4);
+	}
+}
+
+/*
+ * *(x + y * imm) = z
+ */
+void
+FPUV2_OP_FUNC(fstrd)
+{
+	unsigned long long result;
+	unsigned int imm, op_val1, op_val2;
+
+	imm =  FPUV2_LDST_R_IMM2(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	op_val2 = get_uint32(y, inst_data);
+	result = get_float64(z);
+
+	set_float64_to_memory(result, op_val1 + (op_val2 << imm));
+}
+
+void
+FPUV2_OP_FUNC(fstrm)
+{
+	unsigned long long result;
+	unsigned int imm, op_val1, op_val2;
+
+	imm =  FPUV2_LDST_R_IMM2(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	op_val2 = get_uint32(y, inst_data);
+	result = get_float64(z);
+
+	set_float64_to_memory(result, op_val1 + (op_val2 << imm));
+}
+
+void
+FPUV2_OP_FUNC(fstrs)
+{
+	unsigned int result;
+	unsigned int imm, op_val1, op_val2;
+
+	imm =  FPUV2_LDST_R_IMM2(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	op_val2 = get_uint32(y, inst_data);
+	result = get_float32(z);
+
+	set_float32_to_memory(result, op_val1 + (op_val2 << imm));
+}
+
+#define SOP_MAP(id, insn)                                                  \
+	[id] = { FPU_OP_NAME(insn) }
+
+struct instruction_op_array inst_op1[0xff] = {
+	SOP_MAP(FPUV2_FABSD, fabsd),
+	SOP_MAP(FPUV2_FABSM, fabsm),
+	SOP_MAP(FPUV2_FABSS, fabss),
+	SOP_MAP(FPUV2_FADDD, faddd),
+	SOP_MAP(FPUV2_FADDM, faddm),
+	SOP_MAP(FPUV2_FADDS, fadds),
+	SOP_MAP(FPUV2_FCMPHSD, fcmphsd),
+	SOP_MAP(FPUV2_FCMPHSS, fcmphss),
+	SOP_MAP(FPUV2_FCMPLTD, fcmpltd),
+	SOP_MAP(FPUV2_FCMPLTS, fcmplts),
+	SOP_MAP(FPUV2_FCMPNED, fcmpned),
+	SOP_MAP(FPUV2_FCMPNES, fcmpnes),
+	SOP_MAP(FPUV2_FCMPUOD, fcmpuod),
+	SOP_MAP(FPUV2_FCMPUOS, fcmpuos),
+	SOP_MAP(FPUV2_FCMPZHSD, fcmpzhsd),
+	SOP_MAP(FPUV2_FCMPZHSS, fcmpzhss),
+	SOP_MAP(FPUV2_FCMPZLSD, fcmpzlsd),
+	SOP_MAP(FPUV2_FCMPZLSS, fcmpzlss),
+	SOP_MAP(FPUV2_FCMPZNED, fcmpzned),
+	SOP_MAP(FPUV2_FCMPZNES, fcmpznes),
+	SOP_MAP(FPUV2_FCMPZUOD, fcmpzuod),
+	SOP_MAP(FPUV2_FCMPZUOS, fcmpzuos),
+	SOP_MAP(FPUV2_FDIVD, fdivd),
+	SOP_MAP(FPUV2_FDIVS, fdivs),
+	SOP_MAP(FPUV2_FDTOS, fdtos),
+	SOP_MAP(FPUV2_FDTOSI_RN, fdtosi_rn),
+	SOP_MAP(FPUV2_FDTOSI_RZ, fdtosi_rz),
+	SOP_MAP(FPUV2_FDTOSI_RPI, fdtosi_rpi),
+	SOP_MAP(FPUV2_FDTOSI_RNI, fdtosi_rni),
+	SOP_MAP(FPUV2_FDTOUI_RN, fdtoui_rn),
+	SOP_MAP(FPUV2_FDTOUI_RZ, fdtoui_rz),
+	SOP_MAP(FPUV2_FDTOUI_RPI, fdtoui_rpi),
+	SOP_MAP(FPUV2_FDTOUI_RNI, fdtoui_rni),
+	SOP_MAP(FPUV2_FMACD, fmacd),
+	SOP_MAP(FPUV2_FMACM, fmacm),
+	SOP_MAP(FPUV2_FMACS, fmacs),
+	SOP_MAP(FPUV2_FMFVRH, fmfvrh),
+	SOP_MAP(FPUV2_FMFVRL, fmfvrl),
+	SOP_MAP(FPUV2_FMOVD, fmovd),
+	SOP_MAP(FPUV2_FMOVM, fmovm),
+	SOP_MAP(FPUV2_FMOVS, fmovs),
+	SOP_MAP(FPUV2_FMSCD, fmscd),
+	SOP_MAP(FPUV2_FMSCM, fmscm),
+	SOP_MAP(FPUV2_FMSCS, fmscs),
+	SOP_MAP(FPUV2_FMTVRH, fmtvrh),
+	SOP_MAP(FPUV2_FMTVRL, fmtvrl),
+	SOP_MAP(FPUV2_FMULD, fmuld),
+	SOP_MAP(FPUV2_FMULM, fmulm),
+	SOP_MAP(FPUV2_FMULS, fmuls),
+	SOP_MAP(FPUV2_FNEGD, fnegd),
+	SOP_MAP(FPUV2_FNEGM, fnegm),
+	SOP_MAP(FPUV2_FNEGS, fnegs),
+	SOP_MAP(FPUV2_FNMACD, fnmacd),
+	SOP_MAP(FPUV2_FNMACM, fnmacm),
+	SOP_MAP(FPUV2_FNMACS, fnmacs),
+	SOP_MAP(FPUV2_FNMSCD, fnmscd),
+	SOP_MAP(FPUV2_FNMSCM, fnmscm),
+	SOP_MAP(FPUV2_FNMSCS, fnmscs),
+	SOP_MAP(FPUV2_FNMULD, fnmuld),
+	SOP_MAP(FPUV2_FNMULM, fnmulm),
+	SOP_MAP(FPUV2_FNMULS, fnmuls),
+	SOP_MAP(FPUV2_FRECIPD, frecipd),
+	SOP_MAP(FPUV2_FRECIPS, frecips),
+	SOP_MAP(FPUV2_FSITOD, fsitod),
+	SOP_MAP(FPUV2_FSITOS, fsitos),
+	SOP_MAP(FPUV2_FSQRTD, fsqrtd),
+	SOP_MAP(FPUV2_FSQRTS, fsqrts),
+	SOP_MAP(FPUV2_FSTOD, fstod),
+	SOP_MAP(FPUV2_FSTOSI_RN, fstosi_rn),
+	SOP_MAP(FPUV2_FSTOSI_RZ, fstosi_rz),
+	SOP_MAP(FPUV2_FSTOSI_RPI, fstosi_rpi),
+	SOP_MAP(FPUV2_FSTOSI_RNI, fstosi_rni),
+	SOP_MAP(FPUV2_FSTOUI_RN, fstoui_rn),
+	SOP_MAP(FPUV2_FSTOUI_RZ, fstoui_rz),
+	SOP_MAP(FPUV2_FSTOUI_RPI, fstoui_rpi),
+	SOP_MAP(FPUV2_FSTOUI_RNI, fstoui_rni),
+	SOP_MAP(FPUV2_FSUBD, fsubd),
+	SOP_MAP(FPUV2_FSUBM, fsubm),
+	SOP_MAP(FPUV2_FSUBS, fsubs),
+	SOP_MAP(FPUV2_FUITOD, fuitod),
+	SOP_MAP(FPUV2_FUITOS, fuitos),
+};
+
+struct instruction_op_array inst_op2[0x1f] = {
+	SOP_MAP(FPUV2_FLDD, fldd),
+	SOP_MAP(FPUV2_FLDM, fldm),
+	SOP_MAP(FPUV2_FLDMD, fldmd),
+	SOP_MAP(FPUV2_FLDMM, fldmm),
+	SOP_MAP(FPUV2_FLDMS, fldms),
+	SOP_MAP(FPUV2_FLDRD, fldrd),
+	SOP_MAP(FPUV2_FLDRM, fldrm),
+	SOP_MAP(FPUV2_FLDRS, fldrs),
+	SOP_MAP(FPUV2_FLDS, flds),
+	SOP_MAP(FPUV2_FSTD, fstd),
+	SOP_MAP(FPUV2_FSTM, fstm),
+	SOP_MAP(FPUV2_FSTMD, fstmd),
+	SOP_MAP(FPUV2_FSTMM, fstmm),
+	SOP_MAP(FPUV2_FSTMS, fstms),
+	SOP_MAP(FPUV2_FSTRD, fstrd),
+	SOP_MAP(FPUV2_FSTRM, fstrm),
+	SOP_MAP(FPUV2_FSTRS, fstrs),
+	SOP_MAP(FPUV2_FSTS, fsts),
+};
diff --git a/arch/csky/math-emu/fp810.h b/arch/csky/math-emu/fp810.h
new file mode 100644
index 000000000000..8a3360965f0d
--- /dev/null
+++ b/arch/csky/math-emu/fp810.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CSKY_FP810_H__
+#define __CSKY_FP810_H__
+
+#include "math.h"
+/*
+ * 5 - 12 bits in SOP.
+ */
+#define FPUV2_FABSD 0x46
+#define FPUV2_FABSM 0x86
+#define FPUV2_FABSS 0x6
+#define FPUV2_FADDD 0x40
+#define FPUV2_FADDM 0x80
+#define FPUV2_FADDS 0x0
+#define FPUV2_FCMPHSD 0x4c
+#define FPUV2_FCMPHSS 0xc
+#define FPUV2_FCMPLTD 0x4d
+#define FPUV2_FCMPLTS 0xd
+#define FPUV2_FCMPNED 0x4e
+#define FPUV2_FCMPNES 0xe
+#define FPUV2_FCMPUOD 0x4f
+#define FPUV2_FCMPUOS 0xf
+#define FPUV2_FCMPZHSD 0x48
+#define FPUV2_FCMPZHSS 0x8
+#define FPUV2_FCMPZLSD 0x49
+#define FPUV2_FCMPZLSS 0x9
+#define FPUV2_FCMPZNED 0x4a
+#define FPUV2_FCMPZNES 0xa
+#define FPUV2_FCMPZUOD 0x4b
+#define FPUV2_FCMPZUOS 0xb
+#define FPUV2_FDIVD 0x58
+#define FPUV2_FDIVS 0x18
+#define FPUV2_FDTOS 0xd6
+#define FPUV2_FDTOSI_RN 0xc8
+#define FPUV2_FDTOSI_RZ 0xc9
+#define FPUV2_FDTOSI_RPI 0xca
+#define FPUV2_FDTOSI_RNI 0xcb
+#define FPUV2_FDTOUI_RN 0xcc
+#define FPUV2_FDTOUI_RZ 0xcd
+#define FPUV2_FDTOUI_RPI 0xce
+#define FPUV2_FDTOUI_RNI 0xcf
+#define FPUV2_FMACD 0x54
+#define FPUV2_FMACM 0x94
+#define FPUV2_FMACS 0x14
+#define FPUV2_FMFVRH 0xd8
+#define FPUV2_FMFVRL 0xd9
+#define FPUV2_FMOVD 0x44
+#define FPUV2_FMOVM 0x84
+#define FPUV2_FMOVS 0x4
+#define FPUV2_FMSCD 0x55
+#define FPUV2_FMSCM 0x95
+#define FPUV2_FMSCS 0x15
+#define FPUV2_FMTVRH 0xda
+#define FPUV2_FMTVRL 0xdb
+#define FPUV2_FMULD 0x50
+#define FPUV2_FMULM 0x90
+#define FPUV2_FMULS 0x10
+#define FPUV2_FNEGD 0x47
+#define FPUV2_FNEGM 0x87
+#define FPUV2_FNEGS 0x7
+#define FPUV2_FNMACD 0x56
+#define FPUV2_FNMACM 0x96
+#define FPUV2_FNMACS 0x16
+#define FPUV2_FNMSCD 0x57
+#define FPUV2_FNMSCM 0x97
+#define FPUV2_FNMSCS 0x17
+#define FPUV2_FNMULD 0x51
+#define FPUV2_FNMULM 0x91
+#define FPUV2_FNMULS 0x11
+#define FPUV2_FRECIPD 0x59
+#define FPUV2_FRECIPS 0x19
+#define FPUV2_FSITOD 0xd4
+#define FPUV2_FSITOS 0xd0
+#define FPUV2_FSQRTD 0x5a
+#define FPUV2_FSQRTS 0x1a
+#define FPUV2_FSTOD 0xd7
+#define FPUV2_FSTOSI_RN 0xc0
+#define FPUV2_FSTOSI_RZ 0xc1
+#define FPUV2_FSTOSI_RPI 0xc2
+#define FPUV2_FSTOSI_RNI 0xc3
+#define FPUV2_FSTOUI_RN 0xc4
+#define FPUV2_FSTOUI_RZ 0xc5
+#define FPUV2_FSTOUI_RPI 0xc6
+#define FPUV2_FSTOUI_RNI 0xc7
+#define FPUV2_FSUBD 0x41
+#define FPUV2_FSUBM 0x81
+#define FPUV2_FSUBS 0x1
+#define FPUV2_FUITOD 0xd5
+#define FPUV2_FUITOS 0xd1
+
+/*
+ * 8 - 12 bits in SOP.
+ */
+#define FPUV2_FLDD 0x1
+#define FPUV2_FLDM 0x2
+#define FPUV2_FLDMD 0x11
+#define FPUV2_FLDMM 0x12
+#define FPUV2_FLDMS 0x10
+#define FPUV2_FLDRD 0x9
+#define FPUV2_FLDRM 0xa
+#define FPUV2_FLDRS 0x8
+#define FPUV2_FLDS 0x0
+#define FPUV2_FSTD 0x5
+#define FPUV2_FSTM 0x6
+#define FPUV2_FSTMD 0x15
+#define FPUV2_FSTMM 0x16
+#define FPUV2_FSTMS 0x14
+#define FPUV2_FSTRD 0xd
+#define FPUV2_FSTRM 0xe
+#define FPUV2_FSTRS 0xc
+#define FPUV2_FSTS 0x4
+
+#define FPUV2_REG_MASK 0x1f
+#define FPUV2_REG_SHI_RX 16
+
+#define FPUV2_VREG_MASK 0xf
+#define FPUV2_VREG_SHI_VRX 16
+#define FPUV2_VREG_SHI_VRY 21
+#define FPUV2_VREG_SHI_VRZ 0
+
+#define CSKY_INSN_RX(x) ((x >> FPUV2_REG_SHI_RX) & FPUV2_REG_MASK)
+#define CSKY_INSN_VRX(x) ((x >> FPUV2_VREG_SHI_VRX) & FPUV2_VREG_MASK)
+#define CSKY_INSN_VRY(x) ((x >> FPUV2_VREG_SHI_VRY) & FPUV2_VREG_MASK)
+#define CSKY_INSN_VRZ(x) ((x >> FPUV2_VREG_SHI_VRZ) & FPUV2_VREG_MASK)
+
+#define FPUV2_LDST_MASK (1 << 13)
+#define FPUV2_SOP_MASK (0xff)
+#define FPUV2_SOP_SHIFT (0x5)
+#define FPUV2_LDST_SOP_MASK (0x1f)
+#define FPUV2_LDST_SOP_SHIFT (0x8)
+
+#define FPUV2_LDST_INSN_INDEX(x)                                               \
+	((x >> FPUV2_LDST_SOP_SHIFT) & FPUV2_LDST_SOP_MASK)
+#define FPUV2_INSN_INDEX(x) ((x >> FPUV2_SOP_SHIFT) & FPUV2_SOP_MASK)
+
+#define FPUV2_IMM2_MASK 0x3
+#define FPUV2_IMM2 0x5
+#define FPUV2_IMM4_MASK 0xf
+#define FPUV2_IMM4H 0x11
+#define FPUV2_IMM4L 0x4
+
+#define FPUV2_IMM8L_MASK (FPUV2_IMM4_MASK)
+#define FPUV2_IMM8H_MASK (FPUV2_IMM4_MASK << FPUV2_IMM4L)
+#define FPUV2_IMM8L(x) ((x >> FPUV2_IMM4L) & FPUV2_IMM8L_MASK)
+#define FPUV2_IMM8H(x) ((x >> FPUV2_IMM4H) & FPUV2_IMM8H_MASK)
+
+#define FPUV2_LDST_R_IMM2(x) ((x >> FPUV2_IMM2) & FPUV2_IMM2_MASK)
+#define FPUV2_LDST_IMM8(x) (FPUV2_IMM8H(x) | FPUV2_IMM8L(x))
+
+#define FPU_OP_NAME(name) fp810_##name
+
+struct instruction_op_array {
+	void (*const fn)(int vrx, int vry, int vrz,
+			 struct inst_data *inst_data);
+};
+
+extern struct instruction_op_array inst_op1[];
+extern struct instruction_op_array inst_op2[];
+
+#define FPUV2_OP_FUNC(insn)                                                    \
+	FPU_OP_NAME(insn)(int x, int y, int z, struct inst_data *inst_data)
+
+#endif
diff --git a/arch/csky/math-emu/fp860.c b/arch/csky/math-emu/fp860.c
new file mode 100644
index 000000000000..d27bc9613a69
--- /dev/null
+++ b/arch/csky/math-emu/fp860.c
@@ -0,0 +1,2936 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/uaccess.h>
+#include "sfp-util.h"
+#include <math-emu/soft-fp.h>
+#include "sfp-fixs.h"
+#include <math-emu/single.h>
+#include <math-emu/double.h>
+#include "fp860.h"
+
+void FPUV3_OP_FUNC(fadds)
+{
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_ADD_S(R, A, B);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fsubs)
+{
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_SUB_S(R, A, B);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fmovs)
+{
+	unsigned int result;
+
+	result = get_float32(x);
+	set_float32(result, z);
+}
+
+void FPUV3_OP_FUNC(fabss)
+{
+	unsigned int result;
+
+	result = get_float32(x) & 0x7fffffff;
+	set_float32(result, z);
+}
+
+void FPUV3_OP_FUNC(fnegs)
+{
+	unsigned int result;
+
+	result = get_float32(x) ^ 0x80000000;
+	set_float32(result, z);
+}
+
+void FPUV3_OP_FUNC(fcmpzhss)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(SR, SN, SN);
+	SP_CONST_DATA(constant, 0);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, constant);
+
+	FP_CMP_S(result, A, B, 3);
+	if ((result == 3) && (A_c == FP_CLS_NAN)) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 0;
+	} else
+		result = ((result == 0) || (result == 1)) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmpzlts)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(SR, SN, SN);
+	SP_CONST_DATA(constant, 0);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, constant);
+
+	FP_CMP_S(result, A, B, 3);
+	if ((result == 3) && (A_c == FP_CLS_NAN)) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 0;
+	} else
+		result = (result == -1) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fmuls)
+{
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_MUL_S(R, A, B);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fnmuls)
+{
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_MUL_S(T, A, B);
+	FP_NEG_S(R, T);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fmacs)
+{
+	FPU_INSN_START(SR, SR, SR);
+
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+	FP_UNPACK_SP(C, vrz);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_ADD_S(R, T, C);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fmscs)
+{
+	FPU_INSN_START(SR, SR, SR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+	FP_UNPACK_SP(C, vrz);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_SUB_S(R, T, C);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fnmacs)
+{
+	FPU_INSN_START(SR, SR, SR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+	FP_UNPACK_SP(C, vrz);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_SUB_S(R, C, T);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fnmscs)
+{
+	FPU_INSN_START(SR, SR, SR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(N);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+	FP_UNPACK_SP(C, vrz);
+
+	FP_NEG_S(C, C);
+
+	FP_MUL_S(T, A, B);
+	MAC_INTERNAL_ROUND_SP;
+	FP_NEG_S(N, C);
+	FP_SUB_S(R, N, T);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fdivs)
+{
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_DIV_S(R, A, B);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(frecips)
+{
+	void *constant;
+
+	FPU_INSN_START(SR, SN, SI);
+	SP_CONST_DATA(constant, 1);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, constant);
+
+	FP_DIV_S(R, B, A);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fsqrts)
+{
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+
+	FP_SQRT_S(R, A);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(finss)
+{
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, (vrz || (vrx || 0xFFFF) << 16));
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fcmpnezs)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(SR, SN, SN);
+	SP_CONST_DATA(constant, 0);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, constant);
+
+	FP_CMP_S(result, A, B, 3);
+	if ((result == 3) && (FP_ISSIGNAN_S(A))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 1;
+	} else
+		result = (result != 0) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmpzuos)
+{
+	int result;
+
+	FPU_INSN_START(SR, SN, SN);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+
+	result = (A_c == FP_CLS_NAN) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmphss)
+{
+	int result;
+
+	FPU_INSN_START(SR, SR, SN);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_CMP_S(result, A, B, 3);
+	if ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 0;
+	} else
+		result = ((result == 0) || (result == 1)) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmplts)
+{
+	int result;
+
+	FPU_INSN_START(SR, SR, SN);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_CMP_S(result, A, B, 3);
+	if ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 0;
+	} else
+		result = (result == -1) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmpnes)
+{
+	int result;
+
+	FPU_INSN_START(SR, SR, SN);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_CMP_S(result, A, B, 3);
+	if ((result == 3) && (FP_ISSIGNAN_S(A) || FP_ISSIGNAN_S(B))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 1;
+	} else
+		result = (result != 0) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmpuos)
+{
+	int result;
+
+	FPU_INSN_START(SR, SR, SN);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	result = (A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmphzs)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(SR, SN, SN);
+	SP_CONST_DATA(constant, 0);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, constant);
+
+	FP_CMP_S(result, A, B, 3);
+	if ((result == 3) && (A_c == FP_CLS_NAN)) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 0;
+	} else
+		result = (result == 1) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmplszs)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(SR, SN, SN);
+	SP_CONST_DATA(constant, 0);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, constant);
+
+	FP_CMP_S(result, A, B, 3);
+	if ((result == 3) && (A_c == FP_CLS_NAN)) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 0;
+	} else
+		result = ((result == 0) || (result == -1)) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fmaxnms)
+{
+	long result;
+
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_CMP_S(result, A, B, 3);
+	if ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		if (result == -1)
+			FP_PACK_SP(vrz, B);
+		else
+			FP_PACK_SP(vrz, A);
+	}
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fminnms)
+{
+	long result;
+
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_CMP_S(result, A, B, 3);
+	if ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		if (result == -1 || result == 0)
+			FP_PACK_SP(vrz, A);
+		else
+			FP_PACK_SP(vrz, B);
+	}
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fsels)
+{
+	char cmp;
+
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	cmp = get_fsr_c(inst_data->regs);
+	if (cmp)
+		FP_PACK_SP(vrz, B);
+	else
+		FP_PACK_SP(vrz, A);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(ffmulas)
+{
+	union fs_data a, b, c;
+
+	FPU_INSN_START(SR, SR, SR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	a.n = x_val;
+	b.n = y_val;
+	c.n = z_val;
+
+	FP_UNPACK_SP(A, &a.f);
+	FP_UNPACK_SP(B, &b.f);
+	FP_UNPACK_SP(C, &c.f);
+
+	FP_FMA_S(R, A, B, C);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(ffmulss)
+{
+	union fs_data a, b, c;
+
+	FPU_INSN_START(SR, SR, SR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	a.n = x_val;
+	b.n = y_val;
+	c.n = z_val;
+
+	FP_UNPACK_SP(A, &a.f);
+	FP_UNPACK_SP(B, &b.f);
+	FP_UNPACK_SP(C, &c.f);
+
+	FP_NEG_S(A, A);
+	FP_FMA_S(R, A, B, C);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(ffnmulas)
+{
+	union fs_data a, b, c;
+
+	FPU_INSN_START(SR, SR, SR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(N);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	a.n = x_val;
+	b.n = y_val;
+	c.n = z_val;
+
+	FP_UNPACK_SP(A, &a.f);
+	FP_UNPACK_SP(B, &b.f);
+	FP_UNPACK_SP(C, &c.f);
+
+	FP_FMA_S(R, A, B, C);
+	FP_NEG_S(R, R);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(ffnmulss)
+{
+	union fs_data a, b, c;
+
+	FPU_INSN_START(SR, SR, SR);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_S(C);
+	FP_DECL_S(T);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	a.n = x_val;
+	b.n = y_val;
+	c.n = z_val;
+
+	FP_UNPACK_SP(A, &a.f);
+	FP_UNPACK_SP(B, &b.f);
+	FP_UNPACK_SP(C, &c.f);
+
+	FP_NEG_S(C, C);
+	FP_FMA_S(R, A, B, C);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(faddd)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_ADD_D(R, A, B);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fsubd)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_SUB_D(R, A, B);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fcmphsd)
+{
+	int result;
+
+	FPU_INSN_START(DR, DR, DN);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_CMP_D(result, A, B, 3);
+	if ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 0;
+	} else
+		result = ((result == 0) || (result == 1)) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmpzhsd)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(DR, DN, DN);
+	DP_CONST_DATA(constant, 0);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, constant);
+
+	FP_CMP_D(result, A, B, 3);
+	if ((result == 3) && (A_c == FP_CLS_NAN)) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 0;
+	} else
+		result = ((result == 0) || (result == 1)) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmpltd)
+{
+	int result;
+
+	FPU_INSN_START(DR, DR, DN);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_CMP_D(result, A, B, 3);
+	if ((result == 3) && (((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN)))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 0;
+	} else
+		result = (result == -1) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmpzltd)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(DR, DN, DN);
+	DP_CONST_DATA(constant, 0);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, constant);
+
+	FP_CMP_D(result, A, B, 3);
+	if ((result == 3) && (A_c == FP_CLS_NAN)) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 0;
+	} else
+		result = (result == -1) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmpned)
+{
+	int result;
+
+	FPU_INSN_START(DR, DR, DN);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_CMP_D(result, A, B, 3);
+	if ((result == 3) && (FP_ISSIGNAN_D(A) || FP_ISSIGNAN_D(B))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 1;
+	} else
+		result = (result != 0) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmpzned)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(DR, DN, DN);
+	DP_CONST_DATA(constant, 0);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, constant);
+
+	FP_CMP_D(result, A, B, 3);
+	if ((result == 3) && (FP_ISSIGNAN_D(A))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 1;
+	} else
+		result = (result != 0) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmpuod)
+{
+	int result;
+
+	FPU_INSN_START(DR, DR, DN);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	result = (A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmpzuod)
+{
+	int result;
+
+	FPU_INSN_START(DR, DN, DN);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+
+	result = (A_c == FP_CLS_NAN) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fmovd)
+{
+	unsigned long long result;
+
+	result = get_float64(x);
+	set_float64(result, z);
+}
+
+void FPUV3_OP_FUNC(fmovxs)
+{
+	unsigned int result;
+
+	result = get_float32(x) & 0xFF00;
+	set_float32(result, z);
+}
+
+void FPUV3_OP_FUNC(fabsd)
+{
+	union float64_components u;
+
+	u.f64 = get_float64(x);
+#ifdef __CSKYBE__
+	u.i[0] &= 0x7fffffff;
+#else
+	u.i[1] &= 0x7fffffff;
+#endif
+	set_float64(u.f64, z);
+}
+
+void FPUV3_OP_FUNC(fnegd)
+{
+	union float64_components u;
+
+	u.f64 = get_float64(x);
+#ifdef __CSKYBE__
+	u.i[0] ^= 0x80000000;
+#else
+	u.i[1] ^= 0x80000000;
+#endif
+	set_float64(u.f64, z);
+}
+
+void FPUV3_OP_FUNC(fmuld)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_MUL_D(R, A, B);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fdivd)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_DIV_D(R, A, B);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fnmuld)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_MUL_D(R, A, B);
+	FP_NEG_D(R, R);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fmacd)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(C);
+	FP_DECL_D(T);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+	FP_UNPACK_DP(C, vrz);
+
+	FP_MUL_D(T, A, B);
+	MAC_INTERNAL_ROUND_DP;
+	FP_ADD_D(R, T, C);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fnmacd)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(C);
+	FP_DECL_D(T);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+	FP_UNPACK_DP(C, vrz);
+
+	FP_MUL_D(T, A, B);
+	MAC_INTERNAL_ROUND_DP;
+	FP_SUB_D(R, C, T);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fnmscd)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(C);
+	FP_DECL_D(T);
+	FP_DECL_D(N);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+	FP_UNPACK_DP(C, vrz);
+
+	FP_MUL_D(T, A, B);
+	MAC_INTERNAL_ROUND_DP;
+	FP_NEG_D(N, C);
+	FP_SUB_D(R, N, T);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fmscd)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(C);
+	FP_DECL_D(T);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+	FP_UNPACK_DP(C, vrz);
+
+	FP_MUL_D(T, A, B);
+	MAC_INTERNAL_ROUND_DP;
+	FP_SUB_D(R, T, C);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(frecipd)
+{
+	void *constant;
+
+	FPU_INSN_START(DR, DN, DI);
+	DP_CONST_DATA(constant, 1);
+
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, constant);
+
+	FP_DIV_D(R, B, A);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fsqrtd)
+{
+	FPU_INSN_START(DR, DN, DI);
+	FP_DECL_D(A);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+
+	FP_SQRT_D(R, A);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fcmphzd)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(DR, DN, DN);
+	DP_CONST_DATA(constant, 0);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, constant);
+
+	FP_CMP_D(result, A, B, 3);
+	if ((result == 3) && (A_c == FP_CLS_NAN)) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 0;
+	} else
+		result = (result == 1) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fcmplszd)
+{
+	int result;
+	void *constant;
+
+	FPU_INSN_START(DR, DN, DN);
+	DP_CONST_DATA(constant, 0);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, constant);
+
+	FP_CMP_D(result, A, B, 3);
+	if ((result == 3) && (FP_ISSIGNAN_D(A))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+		result = 0;
+	} else
+		result = ((result == 0) || (result == -1)) ? 1 : 0;
+
+	SET_FLAG_END;
+}
+
+void FPUV3_OP_FUNC(fmaxnmd)
+{
+	long result;
+
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_CMP_D(result, A, B, 3);
+	if ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		if (result == -1)
+			FP_PACK_DP(vrz, B);
+		else
+			FP_PACK_DP(vrz, A);
+	}
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fminnmd)
+{
+	long result;
+
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	FP_CMP_D(result, A, B, 3);
+	if ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		if (result == -1 || result == 0)
+			FP_PACK_DP(vrz, A);
+		else
+			FP_PACK_DP(vrz, B);
+	}
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fseld)
+{
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_EX;
+	char cmp;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_UNPACK_DP(B, vry);
+
+	cmp = get_fsr_c(inst_data->regs);
+	if (cmp)
+		FP_PACK_DP(vrz, B);
+	else
+		FP_PACK_DP(vrz, A);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(ffmulad)
+{
+	union fd_data a, b, c;
+
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(C);
+	FP_DECL_D(T);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	a.n = x_val;
+	b.n = y_val;
+	c.n = z_val;
+
+	FP_UNPACK_DP(A, &a.d);
+	FP_UNPACK_DP(B, &b.d);
+	FP_UNPACK_DP(C, &c.d);
+
+	FP_FMA_D(R, A, B, C);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(ffmulsd)
+{
+	union fd_data a, b, c;
+
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(C);
+	FP_DECL_D(T);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	a.n = x_val;
+	b.n = y_val;
+	c.n = z_val;
+
+	FP_UNPACK_DP(A, &a.d);
+	FP_UNPACK_DP(B, &b.d);
+	FP_UNPACK_DP(C, &c.d);
+
+	FP_NEG_D(A, A);
+	FP_FMA_D(R, A, B, C);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(ffnmulad)
+{
+	union fd_data a, b, c;
+
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(C);
+	FP_DECL_D(T);
+	FP_DECL_D(N);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	a.n = x_val;
+	b.n = y_val;
+	c.n = z_val;
+
+	FP_UNPACK_DP(A, &a.d);
+	FP_UNPACK_DP(B, &b.d);
+	FP_UNPACK_DP(C, &c.d);
+
+	FP_FMA_D(R, A, B, C);
+	FP_NEG_D(R, R);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(ffnmulsd)
+{
+	union fd_data a, b, c;
+
+	FPU_INSN_START(DR, DR, DR);
+
+	a.n = x_val;
+	b.n = y_val;
+	c.n = z_val;
+
+	FP_DECL_D(A);
+	FP_DECL_D(B);
+	FP_DECL_D(C);
+	FP_DECL_D(T);
+	FP_DECL_D(N);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, &a.d);
+	FP_UNPACK_DP(B, &b.d);
+	FP_UNPACK_DP(C, &c.d);
+
+	FP_NEG_D(C, C);
+	FP_FMA_D(R, A, B, C);
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fsitos)
+{
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_S(R, *(int *)vrx, 32, int);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fuitos)
+{
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_S(R, *(unsigned int *)vrx, 32, int);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fsitod)
+{
+	FPU_INSN_START(SR, SN, DI);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_D(R, *(int *)vrx, 32, int);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fuitod)
+{
+	FPU_INSN_START(SR, SN, DI);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_D(R, *(unsigned int *)vrx, 32, int);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fstod)
+{
+	FPU_INSN_START(SR, SN, DI);
+	FP_DECL_S(A);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	x_val = x_val & 0xffffffff;
+	FP_UNPACK_SP(A, vrx);
+
+	FP_CONV(D, S, 2, 1, R, A);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fdtos)
+{
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	FP_CONV(S, D, 1, 2, R, A);
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fstosi_rn)
+{
+	int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_NEAREST);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		FP_SET_EXCEPTION(FP_CUR_EXCEPTIONS);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fstosi_rz)
+{
+	int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_ZERO);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fstosi_rpi)
+{
+	int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_PINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fstosi_rni)
+{
+	int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_MINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fstoui_rn)
+{
+	unsigned int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_NEAREST);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fstoui_rz)
+{
+	unsigned int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_ZERO);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fstoui_rpi)
+{
+	unsigned int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_PINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fstoui_rni)
+{
+	unsigned int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_MINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fdtosi_rn)
+{
+	int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_NEAREST);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fdtosi_rz)
+{
+	int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_ZERO);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fdtosi_rpi)
+{
+	int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_PINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fdtosi_rni)
+{
+	int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_MINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fdtoui_rn)
+{
+	unsigned int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_NEAREST);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fdtoui_rz)
+{
+	unsigned int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_ZERO);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fdtoui_rpi)
+{
+	unsigned int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_PINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fdtoui_rni)
+{
+	unsigned int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_MINF);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	RESTORE_ROUND_MODE;
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fmtvrl)
+{
+	union float64_components result;
+
+	x = (inst_data->inst >> 16) & 0x1f;
+#ifdef __CSKYBE__
+	result.i[1] = (unsigned int)get_uint32(x, inst_data);
+	set_float32(result.i[1], z);
+#else
+	result.i[0] = (unsigned int)get_uint32(x, inst_data);
+	set_float32(result.i[0], z);
+#endif
+}
+
+void FPUV3_OP_FUNC(fmfvrl)
+{
+	union float64_components op_val1;
+	unsigned int result;
+
+	x = inst_data->inst & 0x1f;
+	z = (inst_data->inst >> 16) & 0x1f;
+	op_val1.f64 = get_float64(z);
+
+#ifdef __CSKYBE__
+	result = (unsigned int)op_val1.i[1];
+#else
+	result = (unsigned int)op_val1.i[0];
+#endif
+
+	set_uint32(result, x, inst_data);
+}
+
+void FPUV3_OP_FUNC(fmfvrh)
+{
+	union float64_components op_val1;
+	unsigned int result;
+
+	z = inst_data->inst & 0x1f;
+	x = (inst_data->inst >> 16) & 0x1f;
+	op_val1.f64 = get_float64(x);
+
+#ifdef __CSKYBE__
+	result = (unsigned int)op_val1.i[0];
+#else
+	result = (unsigned int)op_val1.i[1];
+#endif
+
+	set_uint32(result, z, inst_data);
+}
+
+void FPUV3_OP_FUNC(fmtvrh)
+{
+	union float64_components result;
+
+	x = (inst_data->inst >> 16) & 0x1f;
+#ifdef __CSKYBE__
+	result.i[0] = (unsigned int)get_uint32(x, inst_data);
+	set_float32h(result.i[0], z);
+#else
+	result.i[1] = (unsigned int)get_uint32(x, inst_data);
+	set_float32h(result.i[1], z);
+#endif
+}
+
+void FPUV3_OP_FUNC(fmtvrd)
+{
+	union float64_components result;
+
+#ifdef __CSKYBE__
+	result.i[0] = (unsigned int)get_uint32(y, inst_data);
+	result.i[1] = (unsigned int)get_uint32(x, inst_data);
+#else
+	result.i[0] = (unsigned int)get_uint32(x, inst_data);
+	result.i[1] = (unsigned int)get_uint32(y, inst_data);
+#endif
+
+	set_float64(result.f64, z);
+}
+
+void FPUV3_OP_FUNC(fmtvrl2)
+{
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	FP_UNPACK_SP(B, vry);
+
+	FP_PACK_SP(vrz, A);
+	FP_PACK_SP(vrz + 4, B);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fmfvrd)
+{
+	union float64_components op_val;
+	unsigned int result;
+
+	x = inst_data->inst & 0x1f;
+	y = (inst_data->inst >> 21) & 0x1f;
+	z = (inst_data->inst >> 16) & 0x1f;
+	op_val.f64 = get_float64(z);
+
+#ifdef __CSKYBE__
+	result = (unsigned int)op_val.i[0];
+	set_uint32(result, x, inst_data);
+	result = (unsigned int)op_val.i[1];
+	set_uint32(result, y, inst_data);
+#else
+	result = (unsigned int)op_val.i[0];
+	set_uint32(result, x, inst_data);
+	result = (unsigned int)op_val.i[1];
+	set_uint32(result, y, inst_data);
+#endif
+}
+
+void FPUV3_OP_FUNC(fmfvrl2)
+{
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(B);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrz);
+	FP_UNPACK_SP(B, vrz + 4);
+
+	FP_PACK_SP(vrx, A);
+	FP_PACK_SP(vry, B);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fldrs)
+{
+	unsigned int result;
+	unsigned int imm, op_val1, op_val2;
+
+	imm = FPUV3_IMM2(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	op_val2 = get_uint32(y, inst_data);
+	result = get_float32_from_memory(op_val1 + (op_val2 << imm));
+
+	set_float32(result, z);
+}
+
+void FPUV3_OP_FUNC(fldrd)
+{
+	unsigned long long result;
+	unsigned int imm, op_val1, op_val2;
+
+	imm = FPUV3_IMM2(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	op_val2 = get_uint32(y, inst_data);
+	result = get_float64_from_memory(op_val1 + (op_val2 << imm));
+
+	set_float64(result, z);
+}
+
+void FPUV3_OP_FUNC(fstrs)
+{
+	unsigned int result;
+	unsigned int imm, op_val1, op_val2;
+
+	imm = FPUV3_IMM2(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	op_val2 = get_uint32(y, inst_data);
+	result = get_float32(z);
+
+	set_float32_to_memory(result, op_val1 + (op_val2 << imm));
+}
+
+void FPUV3_OP_FUNC(fstrd)
+{
+	unsigned long long result;
+	unsigned int imm, op_val1, op_val2;
+
+	imm = FPUV3_IMM2(inst_data->inst);
+	op_val1 = get_uint32(x, inst_data);
+	op_val2 = get_uint32(y, inst_data);
+	result = get_float64(z);
+
+	set_float64_to_memory(result, op_val1 + (op_val2 << imm));
+}
+
+void FPUV3_OP_FUNC(fldms)
+{
+	unsigned int result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float32_from_memory(op_val1 + i * 4);
+		set_float32(result, z + i);
+	}
+}
+
+void FPUV3_OP_FUNC(fldmd)
+{
+	unsigned long long result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float64_from_memory(op_val1 + i * 8);
+		set_float64(result, z + i);
+	}
+}
+
+void FPUV3_OP_FUNC(fldmus)
+{
+	unsigned int result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float32_from_memory(op_val1 + i * 4);
+		set_float32(result, z + i);
+	}
+}
+
+void FPUV3_OP_FUNC(fldmud)
+{
+	unsigned long long result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float64_from_memory(op_val1 + i * 8);
+		set_float64(result, z + i);
+	}
+}
+
+void FPUV3_OP_FUNC(fstms)
+{
+	unsigned int result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float32(z + i);
+		set_float32_to_memory(result, op_val1 + i * 4);
+	}
+}
+
+void FPUV3_OP_FUNC(fstmd)
+{
+	unsigned long long result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float64(z + i);
+		set_float64_to_memory(result, op_val1 + i * 8);
+	}
+}
+
+void FPUV3_OP_FUNC(fstmus)
+{
+	unsigned int result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float32(z + i);
+		set_float32_to_memory(result, op_val1 + i * 4);
+	}
+}
+
+void FPUV3_OP_FUNC(fstmud)
+{
+	unsigned long long result;
+	int i;
+	unsigned int op_val1;
+
+	op_val1 = get_uint32(x, inst_data);
+	for (i = 0; i < y; i++) {
+		result = get_float64(z + i);
+		set_float64_to_memory(result, op_val1 + i * 8);
+	}
+}
+
+void FPUV3_OP_FUNC(fftox_f32s32)
+{
+	int r;
+
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+
+	if (A_c == FP_CLS_INF) {
+		*(int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_S(r, A, 32, 1);
+		*(int *)vrz = r;
+	}
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fftox_f32u32)
+{
+	unsigned int r;
+
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_S(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fftox_f64s32)
+{
+	int r;
+
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+
+	if (A_c == FP_CLS_INF) {
+		*(int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_D(r, A, 32, 1);
+		*(int *)vrz = r;
+	}
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fftox_f64u32)
+{
+	unsigned int r;
+
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_D(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fftoi_f32s32)
+{
+	int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_S(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fftoi_f32u32)
+{
+	unsigned int r;
+
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_S(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fftoi_f64s32)
+{
+	int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_D(r, A, 32, 1);
+		*(unsigned int *)vrz = r;
+	}
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fftoi_f64u32)
+{
+	unsigned int r;
+
+	FPU_INSN_START(DR, DN, SI);
+	FP_DECL_D(A);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	if (A_c == FP_CLS_INF) {
+		*(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(unsigned int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_D(r, A, 32, 0);
+		*(unsigned int *)vrz = r;
+	}
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fftofi_fs_rn)
+{
+	int r;
+
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_NEAREST);
+	if (A_c == FP_CLS_INF) {
+		*(int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		FP_FROM_INT_S(R, r, 32, int);
+		FP_PACK_SP(vrz, R);
+	}
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fftofi_fs_rz)
+{
+	int r;
+
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_ZERO);
+	if (A_c == FP_CLS_INF) {
+		*(int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		FP_FROM_INT_S(R, r, 32, int);
+		FP_PACK_SP(vrz, R);
+	}
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fftofi_fs_rpi)
+{
+	int r;
+
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_PINF);
+	if (A_c == FP_CLS_INF) {
+		*(int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		FP_FROM_INT_S(R, r, 32, int);
+		FP_PACK_SP(vrz, R);
+	}
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fftofi_fs_rni)
+{
+	int r;
+
+	FPU_INSN_START(SR, SR, SI);
+	FP_DECL_S(A);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_SP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_MINF);
+	if (A_c == FP_CLS_INF) {
+		*(int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)vrz = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_S(r, A, 32, 1);
+		FP_FROM_INT_S(R, r, 32, int);
+		FP_PACK_SP(vrz, R);
+	}
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fftofi_fd_rn)
+{
+	unsigned long long r;
+
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_NEAREST);
+	if (A_c == FP_CLS_INF) {
+		*(int *)vrx = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)vrx = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 64, 2);
+		FP_FROM_INT_D(R, r, 64, long);
+		FP_PACK_DP(vrz, R);
+	}
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fftofi_fd_rz)
+{
+	unsigned long long r;
+
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_ZERO);
+	if (A_c == FP_CLS_INF) {
+		*(int *)vrx = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)vrx = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 64, 2);
+		FP_FROM_INT_D(R, r, 64, long);
+		FP_PACK_DP(vrz, R);
+	}
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fftofi_fd_rpi)
+{
+	unsigned long long r;
+
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_PINF);
+	if (A_c == FP_CLS_INF) {
+		*(int *)vrx = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)vrx = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 64, 2);
+		FP_FROM_INT_D(R, r, 64, long);
+		FP_PACK_DP(vrz, R);
+	}
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fftofi_fd_rni)
+{
+	unsigned long long r;
+
+	FPU_INSN_START(DR, DR, DR);
+	FP_DECL_D(A);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_UNPACK_DP(A, vrx);
+	SET_AND_SAVE_RM(FP_RND_MINF);
+	if (A_c == FP_CLS_INF) {
+		*(int *)vrx = (A_s == 0) ? 0x7fffffff : 0x80000000;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else if (A_c == FP_CLS_NAN) {
+		*(int *)vrx = 0xffffffff;
+		FP_SET_EXCEPTION(FP_EX_INVALID);
+	} else {
+		FP_TO_INT_ROUND_D(r, A, 64, 2);
+		FP_FROM_INT_D(R, r, 64, long);
+		FP_PACK_DP(vrz, R);
+	}
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fxtof_s32f32)
+{
+	int a;
+
+	FPU_INSN_START(SR, SR, SI);
+	a = *(int *)vrx;
+
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_S(R, a, 32, int);
+
+	FP_PACK_SP(vrz, R);
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fxtof_u32f32)
+{
+	unsigned int a;
+
+	FPU_INSN_START(SR, SR, SI);
+	a = *(unsigned int *)vrx;
+
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_S(R, a, 32, int);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fxtof_s32f64)
+{
+	int a;
+
+	FPU_INSN_START(SR, SR, SI);
+	a = *(int *)vrx;
+
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_D(R, a, 32, int);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fxtof_u32f64)
+{
+	unsigned int a;
+
+	FPU_INSN_START(DR, DR, DR);
+	a = *(unsigned int *)vrx;
+
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_D(R, a, 32, int);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(fitof_s32f32)
+{
+	FPU_INSN_START(SR, SN, SI);
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_S(R, *(int *)vrx, 32, int);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fitof_u32f32)
+{
+	FPU_INSN_START(SR, SN, SI);
+
+	FP_DECL_S(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_S(R, *(unsigned int *)vrx, 32, int);
+
+	FP_PACK_SP(vrz, R);
+
+	FPU_INSN_SP_END;
+}
+
+void FPUV3_OP_FUNC(fitof_s32f64)
+{
+	unsigned long long result;
+	long long x_val, z_val;
+	void *vrx, *vrz;
+
+	x_val = (int)get_float32(x);
+	vrx = &x_val;
+	vrz = &z_val;
+
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_D(R, x_val, 32, int);
+
+	FP_PACK_DP(vrz, R);
+
+	result = *(unsigned long long *)vrz;
+
+	set_float64(result, z);
+
+	if (FP_CUR_EXCEPTIONS)
+		raise_float_exception(FP_CUR_EXCEPTIONS);
+}
+
+void FPUV3_OP_FUNC(fitof_u32f64)
+{
+	FPU_INSN_START(SR, SN, DI);
+	FP_DECL_D(R);
+	FP_DECL_EX;
+
+	FP_FROM_INT_D(R, *(unsigned int *)vrx, 32, int);
+
+	FP_PACK_DP(vrz, R);
+
+	FPU_INSN_DP_END;
+}
+
+void FPUV3_OP_FUNC(flds)
+{
+	unsigned int result;
+	unsigned int imm;
+	unsigned int op_val1;
+	unsigned int vrz, rx;
+
+	rx = (inst_data->inst >> FPUV3_REG_SHI_RX) & FPUV3_REG_MASK;
+	vrz = (inst_data->inst & 0xf) | ((inst_data->inst >> 21) & 0x10);
+
+	op_val1 = get_uint32(rx, inst_data);
+	imm = FPUV3_IMM8(inst_data->inst);
+	result = get_float32_from_memory(op_val1 + imm * 4);
+
+	set_float32(result, vrz);
+}
+
+void FPUV3_OP_FUNC(fldd)
+{
+	unsigned long long result;
+	unsigned int imm;
+	unsigned int op_val1;
+	unsigned int vrz, rx;
+
+	rx = (inst_data->inst >> FPUV3_REG_SHI_RX) & FPUV3_REG_MASK;
+	vrz = (inst_data->inst & 0xf) | ((inst_data->inst >> 21) & 0x10);
+
+	op_val1 = get_uint32(rx, inst_data);
+	imm = FPUV3_IMM8(inst_data->inst);
+	result = get_float64_from_memory(op_val1 + imm * 4);
+
+	set_float64(result, vrz);
+}
+
+void FPUV3_OP_FUNC(fsts)
+{
+	unsigned int result;
+	unsigned int imm, op_val1;
+	unsigned int vrz, rx;
+
+	rx = (inst_data->inst >> FPUV3_REG_SHI_RX) & FPUV3_REG_MASK;
+	vrz = (inst_data->inst & 0xf) | ((inst_data->inst >> 21) & 0x10);
+
+	imm = FPUV3_IMM8(inst_data->inst);
+	op_val1 = get_uint32(rx, inst_data);
+	result = get_float32(vrz);
+
+	set_float32_to_memory(result, op_val1 + imm * 4);
+}
+
+void FPUV3_OP_FUNC(fstd)
+{
+	unsigned long long result;
+	unsigned int imm, op_val1;
+	unsigned int rx, vrz;
+
+	rx = (inst_data->inst >> FPUV3_REG_SHI_RX) & FPUV3_REG_MASK;
+	vrz = (inst_data->inst & 0xf) | ((inst_data->inst >> 21) & 0x10);
+
+	imm = FPUV3_IMM8(inst_data->inst);
+	op_val1 = get_uint32(rx, inst_data);
+	result = get_float64(vrz);
+
+	set_float64_to_memory(result, op_val1 + imm * 4);
+}
+
+void FPUV3_OP_FUNC(fmovi)
+{
+	unsigned int rz, imm4, imm8, sign, type;
+	union float64_components val;
+	void *vrz;
+	unsigned int z_val;
+
+	type = (inst_data->inst >> 6) & 0x3;
+	sign = (inst_data->inst >> 5) & 0x1;
+	imm4 = (inst_data->inst >> 16) & 0xf;
+	imm8 = (((inst_data->inst >> 20) & 0x3f) << 2) +
+	       ((inst_data->inst >> 8) & 0x3);
+	rz = (inst_data->inst >> FPUV3_VREG_SHI_VRZ) & FPUV3_VREG_MASK;
+
+	/* calculate value. */
+	val.f = ((imm8 << 3) + (1 << 11)) * 1.0 / (1 << imm4);
+	if (sign)
+		val.f = val.f * (-1);
+
+	if (type == 0x1) {
+		vrz = &z_val;
+		FP_DECL_D(A);
+		FP_DECL_S(R);
+		FP_DECL_EX;
+		FP_UNPACK_DP(A, &val.f64);
+		FP_CONV(S, D, 1, 2, R, A);
+		FP_PACK_SP(vrz, R);
+		set_float32(*(unsigned int *)vrz, rz);
+		if (FP_CUR_EXCEPTIONS)
+			raise_float_exception(FP_CUR_EXCEPTIONS);
+	} else if (type == 0x2) {
+		set_float64(val.f64, rz);
+	} else {
+	}
+}
+
+#define FPU_PCODE_INSN(pcode) fpu_pcode_insn##pcode
+#define FPU_PCODE_DEFINE(sop)                                                  \
+	struct insn_pcode_array FPU_PCODE_INSN(sop)[FPUV3_PCODE_MAX]
+
+#define SOP_MAP(sop)                                                  \
+	[sop] = { FPU_PCODE_INSN(sop) }
+#define PCODE_MAP(id, insn)                                                  \
+	[id] = { FPU_OP_NAME(insn) }
+#define PCODE_RANGE_MAP(id1, id2, insn)                                                  \
+	[id1... id2] = { FPU_OP_NAME(insn) }
+#define FPUV3_SOP 0xD
+#define FPUV3_OP_MAX 0xF
+#define FPUV3_SOP_MAX 0x3F
+#define FPUV3_PCODE_MAX 0x20
+
+FPU_PCODE_DEFINE(FPUV3_FLOAT_ARITH) = {
+	PCODE_MAP(FPUV3_FADDS, fadds),
+	PCODE_MAP(FPUV3_FSUBS, fsubs),
+	PCODE_MAP(FPUV3_FMOVS, fmovs),
+	PCODE_MAP(FPUV3_FABSS, fabss),
+	PCODE_MAP(FPUV3_FNEGS, fnegs),
+	PCODE_MAP(FPUV3_FCMPZHSS, fcmpzhss),
+	PCODE_MAP(FPUV3_FCMPZLTS, fcmpzlts),
+	PCODE_MAP(FPUV3_FCMPNEZS, fcmpnezs),
+	PCODE_MAP(FPUV3_FCMPZUOS, fcmpzuos),
+	PCODE_MAP(FPUV3_FCMPHSS, fcmphss),
+	PCODE_MAP(FPUV3_FCMPLTS, fcmplts),
+	PCODE_MAP(FPUV3_FCMPNES, fcmpnes),
+	PCODE_MAP(FPUV3_FCMPUOS, fcmpuos),
+	PCODE_MAP(FPUV3_FMULS, fmuls),
+	PCODE_MAP(FPUV3_FNMULS, fnmuls),
+	PCODE_MAP(FPUV3_FMACS, fmacs),
+	PCODE_MAP(FPUV3_FMSCS, fmscs),
+	PCODE_MAP(FPUV3_FNMACS, fnmacs),
+	PCODE_MAP(FPUV3_FNMSCS, fnmscs),
+	PCODE_MAP(FPUV3_FDIVS, fdivs),
+	PCODE_MAP(FPUV3_FRECIPS, frecips),
+	PCODE_MAP(FPUV3_FSQRTS, fsqrts),
+	PCODE_MAP(FPUV3_FINSS, finss),
+};
+
+FPU_PCODE_DEFINE(FPUV3_FLOAT_EXT_ARITH) = {
+	PCODE_MAP(FPUV3_FMAXNMS, fmaxnms),
+	PCODE_MAP(FPUV3_FMINNMS, fminnms),
+	PCODE_MAP(FPUV3_FCMPHZS, fcmphzs),
+	PCODE_MAP(FPUV3_FCMPLSZS, fcmplszs),
+	PCODE_MAP(FPUV3_FFMULAS, ffmulas),
+	PCODE_MAP(FPUV3_FFMULSS, ffmulss),
+	PCODE_MAP(FPUV3_FFNMULAS, ffnmulas),
+	PCODE_MAP(FPUV3_FFNMULSS, ffnmulss),
+	PCODE_MAP(FPUV3_FSELS, fsels),
+};
+
+FPU_PCODE_DEFINE(FPUV3_DOUBLE_ARITH) = {
+	PCODE_MAP(FPUV3_FADDD, faddd),
+	PCODE_MAP(FPUV3_FSUBD, fsubd),
+	PCODE_MAP(FPUV3_FMOVD, fmovd),
+	PCODE_MAP(FPUV3_FMOVXS, fmovxs),
+	PCODE_MAP(FPUV3_FABSD, fabsd),
+	PCODE_MAP(FPUV3_FNEGD, fnegd),
+	PCODE_MAP(FPUV3_FCMPZHSD, fcmpzhsd),
+	PCODE_MAP(FPUV3_FCMPZLTD, fcmpzltd),
+	PCODE_MAP(FPUV3_FCMPZNED, fcmpzned),
+	PCODE_MAP(FPUV3_FCMPZUOD, fcmpzuod),
+	PCODE_MAP(FPUV3_FCMPHSD, fcmphsd),
+	PCODE_MAP(FPUV3_FCMPLTD, fcmpltd),
+	PCODE_MAP(FPUV3_FCMPNED, fcmpned),
+	PCODE_MAP(FPUV3_FCMPUOD, fcmpuod),
+	PCODE_MAP(FPUV3_FMULD, fmuld),
+	PCODE_MAP(FPUV3_FNMULD, fnmuld),
+	PCODE_MAP(FPUV3_FMACD, fmacd),
+	PCODE_MAP(FPUV3_FMSCD, fmscd),
+	PCODE_MAP(FPUV3_FNMACD, fnmacd),
+	PCODE_MAP(FPUV3_FNMSCS, fnmscd),
+	PCODE_MAP(FPUV3_FDIVD, fdivd),
+	PCODE_MAP(FPUV3_FRECIPD, frecipd),
+	PCODE_MAP(FPUV3_FSQRTD, fsqrtd),
+};
+
+FPU_PCODE_DEFINE(FPUV3_DOUBLE_EXT_ARITH) = {
+	PCODE_MAP(FPUV3_FMAXNMD, fmaxnmd),
+	PCODE_MAP(FPUV3_FMINNMD, fminnmd),
+	PCODE_MAP(FPUV3_FCMPHZD, fcmphzd),
+	PCODE_MAP(FPUV3_FCMPLSZD, fcmplszd),
+	PCODE_MAP(FPUV3_FFMULAD, ffmulad),
+	PCODE_MAP(FPUV3_FFMULSD, ffmulsd),
+	PCODE_MAP(FPUV3_FFNMULAD, ffnmulad),
+	PCODE_MAP(FPUV3_FFNMULSD, ffnmulsd),
+	PCODE_MAP(FPUV3_FSELD, fseld),
+};
+
+FPU_PCODE_DEFINE(FPUV3_CONVERT) = {
+	PCODE_MAP(FPUV3_FSTOSI_RN, fstosi_rn),
+	PCODE_MAP(FPUV3_FSTOSI_RZ, fstosi_rz),
+	PCODE_MAP(FPUV3_FSTOSI_RPI, fstosi_rpi),
+	PCODE_MAP(FPUV3_FSTOSI_RNI, fstosi_rni),
+	PCODE_MAP(FPUV3_FSTOUI_RN, fstoui_rn),
+	PCODE_MAP(FPUV3_FSTOUI_RZ, fstoui_rz),
+	PCODE_MAP(FPUV3_FSTOUI_RPI, fstoui_rpi),
+	PCODE_MAP(FPUV3_FSTOUI_RNI, fstoui_rni),
+	PCODE_MAP(FPUV3_FDTOSI_RN, fdtosi_rn),
+	PCODE_MAP(FPUV3_FDTOSI_RZ, fdtosi_rz),
+	PCODE_MAP(FPUV3_FDTOSI_RPI, fdtosi_rpi),
+	PCODE_MAP(FPUV3_FDTOSI_RNI, fdtosi_rni),
+	PCODE_MAP(FPUV3_FDTOUI_RN, fdtoui_rn),
+	PCODE_MAP(FPUV3_FDTOUI_RZ, fdtoui_rz),
+	PCODE_MAP(FPUV3_FDTOUI_RPI, fdtoui_rpi),
+	PCODE_MAP(FPUV3_FDTOUI_RNI, fdtoui_rni),
+	PCODE_MAP(FPUV3_FSITOS, fsitos),
+	PCODE_MAP(FPUV3_FUITOS, fuitos),
+	PCODE_MAP(FPUV3_FSITOD, fsitod),
+	PCODE_MAP(FPUV3_FIOTOD, fuitod),
+	PCODE_MAP(FPUV3_FDTOS, fdtos),
+	PCODE_MAP(FPUV3_FSTOD, fstod),
+	PCODE_MAP(FPUV3_FMTVRH, fmtvrh),
+	PCODE_MAP(FPUV3_FMTVRL, fmtvrl), //FMTVR.32.1
+	PCODE_MAP(FPUV3_FMFVRH, fmfvrh),
+	PCODE_MAP(FPUV3_FMFVRL, fmfvrl), //FMFVR.32.1
+};
+
+FPU_PCODE_DEFINE(FPUV3_TRANSFER) = {
+	PCODE_MAP(FPUV3_FMFVRD, fmfvrd),
+	PCODE_MAP(FPUV3_FMFVRL2, fmfvrl2),
+	PCODE_MAP(FPUV3_FMTVRD, fmtvrd),
+	PCODE_MAP(FPUV3_FMTVRL2, fmtvrl2),
+};
+
+FPU_PCODE_DEFINE(FPUV3_LD) = {
+	PCODE_RANGE_MAP(FPUV3_FLDS_MIN, FPUV3_FLDS_MAX, flds),
+	PCODE_RANGE_MAP(FPUV3_FLDD_MIN, FPUV3_FLDD_MAX, fldd),
+};
+
+FPU_PCODE_DEFINE(FPUV3_ST) = {
+	PCODE_RANGE_MAP(FPUV3_FSTS_MIN, FPUV3_FSTS_MAX, fsts),
+	PCODE_RANGE_MAP(FPUV3_FSTD_MIN, FPUV3_FSTD_MAX, fstd),
+};
+
+FPU_PCODE_DEFINE(FPUV3_LD_REG) = {
+	PCODE_RANGE_MAP(FPUV3_FLDRS_MIN, FPUV3_FLDRS_MAX, fldrs),
+	PCODE_RANGE_MAP(FPUV3_FLDRD_MIN, FPUV3_FLDRD_MAX, fldrd),
+};
+
+FPU_PCODE_DEFINE(FPUV3_ST_REG) = {
+	PCODE_RANGE_MAP(FPUV3_FSTRS_MIN, FPUV3_FSTRS_MAX, fstrs),
+	PCODE_RANGE_MAP(FPUV3_FSTRD_MIN, FPUV3_FSTRD_MAX, fstrd),
+};
+
+FPU_PCODE_DEFINE(FPUV3_LD_MEM) = {
+	PCODE_MAP(FPUV3_FLDMS, fldms),
+	PCODE_MAP(FPUV3_FLDMD, fldmd),
+	PCODE_MAP(FPUV3_FLDMUS, fldmus),
+	PCODE_MAP(FPUV3_FLDMUD, fldmud),
+};
+
+FPU_PCODE_DEFINE(FPUV3_ST_MEM) = {
+	PCODE_MAP(FPUV3_FSTMS, fstms),
+	PCODE_MAP(FPUV3_FSTMD, fstmd),
+	PCODE_MAP(FPUV3_FSTMUS, fstmus),
+	PCODE_MAP(FPUV3_FSTMUD, fstmud),
+};
+
+FPU_PCODE_DEFINE(FPUV3_CONVERT_F_IX) = {
+	PCODE_MAP(FPUV3_FFTOX_F32U32, fftox_f32u32), //fstoux
+	PCODE_MAP(FPUV3_FFTOX_F32S32, fftox_f32s32), //fstosx
+	PCODE_MAP(FPUV3_FFTOX_F64U32, fftox_f64u32), //fdtoux
+	PCODE_MAP(FPUV3_FFTOX_F64S32, fftox_f64s32), //fdtosx
+	PCODE_MAP(FPUV3_FFTOI_F32U32, fftoi_f32u32), //fstoui
+	PCODE_MAP(FPUV3_FFTOI_F32S32, fftoi_f32s32), //fstosi
+	PCODE_MAP(FPUV3_FFTOI_F64U32, fftoi_f64u32), //fdtoui
+	PCODE_MAP(FPUV3_FFTOI_F64S32, fftoi_f64s32), //fdtosi
+};
+
+FPU_PCODE_DEFINE(FPUV3_CONVERT_F_FI) = {
+	PCODE_MAP(FPUV3_FFTOFI_FS_RN, fftofi_fs_rn),
+	PCODE_MAP(FPUV3_FFTOFI_FS_RZ, fftofi_fs_rz),
+	PCODE_MAP(FPUV3_FFTOFI_FS_RPI, fftofi_fs_rpi),
+	PCODE_MAP(FPUV3_FFTOFI_FS_RNI, fftofi_fs_rni),
+	PCODE_MAP(FPUV3_FFTOFI_FD_RN, fftofi_fd_rn),
+	PCODE_MAP(FPUV3_FFTOFI_FD_RZ, fftofi_fd_rz),
+	PCODE_MAP(FPUV3_FFTOFI_FD_RPI, fftofi_fd_rpi),
+	PCODE_MAP(FPUV3_FFTOFI_FD_RNI, fftofi_fd_rni),
+};
+
+FPU_PCODE_DEFINE(FPUV3_CONVERT_IX_F) = {
+	PCODE_MAP(FPUV3_FXTOF_U32F32, fxtof_u32f32), //uxtofs
+	PCODE_MAP(FPUV3_FXTOF_S32F32, fxtof_s32f32), //sxtofs
+	PCODE_MAP(FPUV3_FXTOF_U32F64, fxtof_u32f64), //uxtofd
+	PCODE_MAP(FPUV3_FXTOF_S32F64, fxtof_s32f64), //sxtofd
+	PCODE_MAP(FPUV3_FITOF_U32F32, fitof_u32f32), //fuitos
+	PCODE_MAP(FPUV3_FITOF_S32F32, fitof_s32f32), //fsitos
+	PCODE_MAP(FPUV3_FITOF_U32F64, fitof_u32f64), //fuitod
+	PCODE_MAP(FPUV3_FITOF_S32F64, fitof_s32f64), //fsitod
+};
+
+FPU_PCODE_DEFINE(FPUV3_MOVI) = {
+	PCODE_RANGE_MAP(FPUV3_MOVI_T0, FPUV3_MOVI_T1, fmovi),
+	PCODE_RANGE_MAP(FPUV3_MOVI_T2, FPUV3_MOVI_T3, fmovi),
+};
+
+struct insn_sop_array sop_insn[FPUV3_SOP_MAX] = {
+	SOP_MAP(FPUV3_FLOAT_ARITH),
+	SOP_MAP(FPUV3_FLOAT_ARITH),
+	SOP_MAP(FPUV3_FLOAT_EXT_ARITH),
+	SOP_MAP(FPUV3_DOUBLE_ARITH),
+	SOP_MAP(FPUV3_DOUBLE_EXT_ARITH),
+	SOP_MAP(FPUV3_CONVERT),
+	SOP_MAP(FPUV3_TRANSFER),
+	SOP_MAP(FPUV3_LD),
+	SOP_MAP(FPUV3_ST),
+	SOP_MAP(FPUV3_LD_REG),
+	SOP_MAP(FPUV3_ST_REG),
+	SOP_MAP(FPUV3_LD_MEM),
+	SOP_MAP(FPUV3_ST_MEM),
+	SOP_MAP(FPUV3_CONVERT_F_IX),
+	SOP_MAP(FPUV3_CONVERT_F_FI),
+	SOP_MAP(FPUV3_CONVERT_IX_F),
+	SOP_MAP(FPUV3_MOVI),
+};
+
+struct insn_op_array fpu_vfp_insn[FPUV3_OP_MAX] = { [FPUV3_SOP] = {
+							    sop_insn } };
diff --git a/arch/csky/math-emu/fp860.h b/arch/csky/math-emu/fp860.h
new file mode 100644
index 000000000000..4188256bce64
--- /dev/null
+++ b/arch/csky/math-emu/fp860.h
@@ -0,0 +1,248 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CSKY_FP860_H__
+#define __CSKY_FP860_H__
+
+#include "math.h"
+
+/* FPUv3 ISA OP Pcode MASK and SHIFT */
+#define FPUV3_REG_MASK 0x1f
+#define FPUV3_REG_SHI_RX 16
+#define FPUV3_REG_SHI_RY 21
+#define FPUV3_REG_SHI_RZ 0
+#define FPUV3_VREG_MASK 0x1f
+#define FPUV3_VREG_SHI_VRX 16
+#define FPUV3_VREG_SHI_VRY 21
+#define FPUV3_VREG_SHI_VRZ 0
+
+#define FPUV3_OP_MASK 0xf
+#define FPUV3_OP_SHI 26
+#define FPUV3_SOP_MASK 0x3f
+#define FPUV3_SOP_SHI 10
+#define FPUV3_PCODE_MASK 0x1f
+#define FPUV3_PCODE_SHI 0x5
+
+#define FPUV3_IMM4_MASK 0xf
+#define FPUV3_IMM4H_SHI 0x11
+#define FPUV3_IMM4L_SHI 0x4
+#define FPUV3_IMM2_MASK 0x3
+#define FPUV3_IMM2_SHI 0x5
+
+#define CSKY_INSN_VRX(x) ((x >> FPUV3_VREG_SHI_VRX) & FPUV3_VREG_MASK)
+#define CSKY_INSN_VRY(x) ((x >> FPUV3_VREG_SHI_VRY) & FPUV3_VREG_MASK)
+#define CSKY_INSN_VRZ(x) ((x >> FPUV3_VREG_SHI_VRZ) & FPUV3_VREG_MASK)
+
+#define FPUV3_IMM8L_MASK (FPUV3_IMM4_MASK)
+#define FPUV3_IMM8H_MASK (FPUV3_IMM4_MASK << FPUV3_IMM4L_SHI)
+#define FPUV3_IMM8L(x) ((x >> FPUV3_IMM4L_SHI) & FPUV3_IMM8L_MASK)
+#define FPUV3_IMM8H(x) ((x >> FPUV3_IMM4H_SHI) & FPUV3_IMM8H_MASK)
+#define FPUV3_IMM8(x) (FPUV3_IMM8H(x) | FPUV3_IMM8L(x))
+
+#define FPUV3_IMM2(x) ((x >> FPUV3_IMM2_SHI) & FPUV3_IMM2_MASK)
+
+#define CSKY_INSN_OP(x) ((x >> FPUV3_OP_SHI) & FPUV3_OP_MASK)
+#define CSKY_INSN_SOP(x) ((x >> FPUV3_SOP_SHI) & FPUV3_SOP_MASK)
+#define CSKY_INSN_PCODE(x) ((x >> FPUV3_PCODE_SHI) & FPUV3_PCODE_MASK)
+
+#define FPUV3_FLOAT_ARITH 0x0
+#define FPUV3_FADDS 0x0
+#define FPUV3_FSUBS 0x1
+#define FPUV3_FMOVS 0x4
+#define FPUV3_FABSS 0x6
+#define FPUV3_FNEGS 0x7
+#define FPUV3_FCMPZHSS 0x8
+#define FPUV3_FCMPZLTS 0x9
+#define FPUV3_FCMPNEZS 0xA
+#define FPUV3_FCMPZUOS 0xB
+#define FPUV3_FCMPHSS 0xC
+#define FPUV3_FCMPLTS 0xD
+#define FPUV3_FCMPNES 0xE
+#define FPUV3_FCMPUOS 0xF
+#define FPUV3_FMULS 0x10
+#define FPUV3_FNMULS 0x11
+#define FPUV3_FMACS 0x14
+#define FPUV3_FMSCS 0x15
+#define FPUV3_FNMACS 0x16
+#define FPUV3_FNMSCS 0x17
+#define FPUV3_FDIVS 0x18
+#define FPUV3_FRECIPS 0x19
+#define FPUV3_FSQRTS 0x1A
+#define FPUV3_FINSS 0x1B
+
+#define FPUV3_FLOAT_EXT_ARITH 0x1
+#define FPUV3_FMAXNMS 0x8
+#define FPUV3_FMINNMS 0x9
+#define FPUV3_FCMPHZS 0xA
+#define FPUV3_FCMPLSZS 0xB
+#define FPUV3_FFMULAS 0x10
+#define FPUV3_FFMULSS 0x11
+#define FPUV3_FFNMULAS 0x12
+#define FPUV3_FFNMULSS 0x13
+#define FPUV3_FSELS 0x19
+
+#define FPUV3_DOUBLE_ARITH 0x2
+#define FPUV3_FADDD 0x0
+#define FPUV3_FSUBD 0x1
+#define FPUV3_FMOVD 0x4
+#define FPUV3_FMOVXS 0x5
+#define FPUV3_FABSD 0x6
+#define FPUV3_FNEGD 0x7
+#define FPUV3_FCMPZHSD 0x8
+#define FPUV3_FCMPZLTD 0x9
+#define FPUV3_FCMPZNED 0xA
+#define FPUV3_FCMPZUOD 0xB
+#define FPUV3_FCMPHSD 0xC
+#define FPUV3_FCMPLTD 0xD
+#define FPUV3_FCMPNED 0xE
+#define FPUV3_FCMPUOD 0xF
+#define FPUV3_FMULD 0x10
+#define FPUV3_FNMULD 0x11
+#define FPUV3_FMACD 0x14
+#define FPUV3_FMSCD 0x15
+#define FPUV3_FNMACD 0x16
+#define FPUV3_FNMSCS 0x17
+#define FPUV3_FDIVD 0x18
+#define FPUV3_FRECIPD 0x19
+#define FPUV3_FSQRTD 0x1A
+
+#define FPUV3_DOUBLE_EXT_ARITH 0x3
+#define FPUV3_FMAXNMD 0x8
+#define FPUV3_FMINNMD 0x9
+#define FPUV3_FCMPHZD 0xA
+#define FPUV3_FCMPLSZD 0xB
+#define FPUV3_FFMULAD 0x10
+#define FPUV3_FFMULSD 0x11
+#define FPUV3_FFNMULAD 0x12
+#define FPUV3_FFNMULSD 0x13
+#define FPUV3_FSELD 0x19
+
+#define FPUV3_CONVERT 0x6
+#define FPUV3_FSTOSI_RN 0x0
+#define FPUV3_FSTOSI_RZ 0x1
+#define FPUV3_FSTOSI_RPI 0x2
+#define FPUV3_FSTOSI_RNI 0x3
+#define FPUV3_FSTOUI_RN 0x4
+#define FPUV3_FSTOUI_RZ 0x5
+#define FPUV3_FSTOUI_RPI 0x6
+#define FPUV3_FSTOUI_RNI 0x7
+#define FPUV3_FDTOSI_RN 0x8
+#define FPUV3_FDTOSI_RZ 0x9
+#define FPUV3_FDTOSI_RPI 0xA
+#define FPUV3_FDTOSI_RNI 0xB
+#define FPUV3_FDTOUI_RN 0xC
+#define FPUV3_FDTOUI_RZ 0xD
+#define FPUV3_FDTOUI_RPI 0xE
+#define FPUV3_FDTOUI_RNI 0xF
+#define FPUV3_FSITOS 0x10
+#define FPUV3_FUITOS 0x11
+#define FPUV3_FSITOD 0x14
+#define FPUV3_FIOTOD 0x15
+#define FPUV3_FDTOS 0x16
+#define FPUV3_FSTOD 0x17
+#define FPUV3_FMTVRH 0x1A
+#define FPUV3_FMTVRL 0x1B
+#define FPUV3_FMFVRH 0x18
+#define FPUV3_FMFVRL 0x19
+
+#define FPUV3_TRANSFER 0x7
+#define FPUV3_FMFVRD 0x18
+#define FPUV3_FMFVRL2 0x1A
+#define FPUV3_FMTVRD 0x1C
+#define FPUV3_FMTVRL2 0x1E
+
+#define FPUV3_LD 0x8
+#define FPUV3_FLDS_MIN 0x0
+#define FPUV3_FLDS_MAX 0x7
+#define FPUV3_FLDD_MIN 0x8
+#define FPUV3_FLDD_MAX 0xF
+
+#define FPUV3_ST 0x9
+#define FPUV3_FSTS_MIN 0x0
+#define FPUV3_FSTS_MAX 0x7
+#define FPUV3_FSTD_MIN 0x8
+#define FPUV3_FSTD_MAX 0xF
+
+#define FPUV3_LD_REG 0xA
+#define FPUV3_FLDRS_MIN 0x0
+#define FPUV3_FLDRS_MAX 0x3
+#define FPUV3_FLDRD_MIN 0x8
+#define FPUV3_FLDRD_MAX 0xB
+
+#define FPUV3_ST_REG 0xB
+#define FPUV3_FSTRS_MIN 0x0
+#define FPUV3_FSTRS_MAX 0x3
+#define FPUV3_FSTRD_MIN 0x8
+#define FPUV3_FSTRD_MAX 0xB
+
+#define FPUV3_LD_MEM 0xC
+#define FPUV3_FLDMS 0x0
+#define FPUV3_FLDMD 0x8
+#define FPUV3_FLDMUS 0x4
+#define FPUV3_FLDMUD 0xC
+
+#define FPUV3_ST_MEM 0xD
+#define FPUV3_FSTMS 0x0
+#define FPUV3_FSTMD 0x8
+#define FPUV3_FSTMUS 0x4
+#define FPUV3_FSTMUD 0xC
+
+#define FPUV3_CONVERT_F_IX 0x10
+#define FPUV3_FFTOX_F32U32 0xA
+#define FPUV3_FFTOX_F32S32 0xB
+#define FPUV3_FFTOX_F64U32 0xC
+#define FPUV3_FFTOX_F64S32 0xD
+#define FPUV3_FFTOI_F32U32 0x1A
+#define FPUV3_FFTOI_F32S32 0x1B
+#define FPUV3_FFTOI_F64U32 0x1C
+#define FPUV3_FFTOI_F64S32 0x1D
+
+#define FPUV3_CONVERT_F_FI 0x11
+#define FPUV3_FFTOFI_FS_RN 0x4
+#define FPUV3_FFTOFI_FS_RZ 0x5
+#define FPUV3_FFTOFI_FS_RPI 0x6
+#define FPUV3_FFTOFI_FS_RNI 0x7
+#define FPUV3_FFTOFI_FD_RN 0x8
+#define FPUV3_FFTOFI_FD_RZ 0x9
+#define FPUV3_FFTOFI_FD_RPI 0xA
+#define FPUV3_FFTOFI_FD_RNI 0xB
+
+#define FPUV3_CONVERT_IX_F 0x12
+#define FPUV3_FXTOF_U32F32 0xA
+#define FPUV3_FXTOF_S32F32 0xB
+#define FPUV3_FXTOF_U32F64 0xC
+#define FPUV3_FXTOF_S32F64 0xD
+#define FPUV3_FITOF_U32F32 0x1A
+#define FPUV3_FITOF_S32F32 0x1B
+#define FPUV3_FITOF_U32F64 0x1C
+#define FPUV3_FITOF_S32F64 0x1D
+
+#define FPUV3_MOVI 0x39
+#define FPUV3_MOVI_T0 0x0
+#define FPUV3_MOVI_T1 0xF
+#define FPUV3_MOVI_T2 0x10
+#define FPUV3_MOVI_T3 0x1F
+
+#define FPU_OP_NAME(name) fp860_##name
+
+union emu_func {
+	void (*fpu)(int x, int y, int z, struct inst_data *inst_data);
+};
+
+struct insn_pcode_array {
+	union emu_func func;
+};
+
+struct insn_sop_array {
+	struct insn_pcode_array *pcode;
+};
+
+struct insn_op_array {
+	struct insn_sop_array *sop;
+};
+
+extern struct insn_op_array fpu_vfp_insn[];
+
+#define FPUV3_OP_FUNC(insn)                                                    \
+	FPU_OP_NAME(insn)(int x, int y, int z, struct inst_data *inst_data)
+
+#endif
diff --git a/arch/csky/math-emu/math.c b/arch/csky/math-emu/math.c
new file mode 100644
index 000000000000..7277e3c558f3
--- /dev/null
+++ b/arch/csky/math-emu/math.c
@@ -0,0 +1,481 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/sched/signal.h>
+#include <linux/signal.h>
+#include <linux/perf_event.h>
+#include <linux/uaccess.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+#include <asm/ptrace.h>
+#include <abi/fpu.h>
+#include <asm/reg_ops.h>
+
+#include "math.h"
+
+#if defined(CONFIG_CPU_CK810)
+#include "fp810.h"
+#define FPR_L_IDX(x) (x * 4)
+#define FPR_H_IDX(x) ((x * 4) + 1)
+#ifdef __CSKYBE__
+#define FPR_IDX(x) FPR_H_IDX(x)
+#else
+#define FPR_IDX(x) FPR_L_IDX(x)
+#endif
+#elif defined(CONFIG_CPU_CK860)
+#include "fp860.h"
+#define FPR_L_IDX(x) (x * 2)
+#define FPR_H_IDX(x) ((x * 2) + 1)
+#ifdef __CSKYBE__
+#define FPR_IDX(x) FPR_H_IDX(x)
+#else
+#define FPR_IDX(x) FPR_L_IDX(x)
+#endif
+#else
+#error cpu not support mathfpu
+#endif
+
+#define FP_INST_MASK 0xF4000000
+#define FP_INST_OP_MASK 0xFC000000
+#define ROUND_MODE_MASK (0x3 << 24)
+
+//TODO:use
+#define __FPU_FPCR (current->thread.user_fp.fcr)
+#define __FPU_FPESR (current->thread.user_fp.fesr)
+#define __FPU_FPCR_U (current->thread.emul_fp.user_fcr)
+#define __FPU_FPESR_U (current->thread.emul_fp.user_fesr)
+
+#define INST_IS_FP(x) (((x & FP_INST_OP_MASK) == FP_INST_MASK) ? 1 : 0)
+
+const unsigned long long float64_constant[] = {
+	0x0000000000000000ULL, /* double 0.0 */
+	0x3ff0000000000000ULL, /* double 1.0 */
+	0x4000000000000000ULL, /* double 2.0 */
+	0x4008000000000000ULL, /* double 3.0 */
+	0x4010000000000000ULL, /* double 4.0 */
+	0x4014000000000000ULL, /* double 5.0 */
+	0x3fe0000000000000ULL, /* double 0.5 */
+	0x4024000000000000ULL /* double 10.0 */
+};
+
+const unsigned int float32_constant[] = {
+	0x00000000, /* single 0.0 */
+	0x3f800000, /* single 1.0 */
+	0x40000000, /* single 2.0 */
+	0x40400000, /* single 3.0 */
+	0x40800000, /* single 4.0 */
+	0x40a00000, /* single 5.0 */
+	0x3f000000, /* single 0.5 */
+	0x41200000 /* single 10.0 */
+};
+
+inline unsigned int read_gr(int reg_num, struct pt_regs *regs)
+{
+	switch (reg_num) {
+	case 0:
+		return regs->orig_a0;
+	case 1:
+		return regs->a1;
+	case 2:
+		return regs->a2;
+	case 3:
+		return regs->a3;
+	case 4 ... 13:
+		return regs->regs[reg_num - 4];
+	case 14:
+		return regs->usp;
+	case 15:
+		return regs->lr;
+#if defined(__CSKYABIV2__)
+	case 16 ... 30:
+		return regs->exregs[reg_num - 16];
+#endif
+	default:
+		break;
+	}
+	return 0;
+}
+
+inline void write_gr(unsigned int val, int reg_num, struct pt_regs *regs)
+{
+	switch (reg_num) {
+	case 0:
+		regs->a0 = val;
+		break;
+	case 1:
+		regs->a1 = val;
+		break;
+	case 2:
+		regs->a2 = val;
+		break;
+	case 3:
+		regs->a3 = val;
+		break;
+	case 4 ... 13:
+		regs->regs[reg_num - 4] = val;
+		break;
+	case 14:
+		regs->usp = val;
+		break;
+	case 15:
+		regs->lr = val;
+		break;
+#if defined(__CSKYABIV2__)
+	case 16 ... 30:
+		regs->exregs[reg_num - 16] = val;
+		break;
+#endif
+	default:
+		break;
+	}
+}
+
+inline unsigned int get_fpvalue32(unsigned int addr)
+{
+	unsigned int result;
+
+	get_user(result, (unsigned int *)addr);
+	return result;
+}
+
+inline void set_fpvalue32(unsigned int val, unsigned int addr)
+{
+	unsigned int result = (unsigned int)val;
+
+	put_user(result, (unsigned int *)addr);
+}
+
+inline unsigned long long get_fpvalue64(unsigned int addr)
+{
+	union float64_components result;
+
+#ifdef __CSKYBE__
+	get_user(result.i[1], (unsigned int *)addr);
+	get_user(result.i[0], (unsigned int *)(addr + 4));
+#else
+	get_user(result.i[1], (unsigned int *)(addr + 4));
+	get_user(result.i[0], (unsigned int *)addr);
+#endif
+
+	return result.f64;
+}
+
+inline void set_fpvalue64(unsigned long long val, unsigned int addr)
+{
+	union float64_components result;
+
+	result.f64 = val;
+#ifdef __CSKYBE__
+	put_user(result.i[1], (unsigned int *)addr);
+	put_user(result.i[0], (unsigned int *)(addr + 4));
+#else
+	put_user(result.i[1], (unsigned int *)(addr + 4));
+	put_user(result.i[0], (unsigned int *)addr);
+#endif
+}
+
+inline unsigned long long read_fpr64(int reg_num)
+{
+	union float64_components result;
+
+	int reg_id0 = FPR_IDX(reg_num);
+	int reg_id1 = reg_id0 % 2 ? (reg_id0 - 1) : (reg_id0 + 1);
+
+	result.i[0] = current->thread.user_fp.vr[reg_id0];
+	result.i[1] = current->thread.user_fp.vr[reg_id1];
+
+	return result.f64;
+}
+
+inline void write_fpr64(unsigned long long val, int reg_num)
+{
+	union float64_components result;
+	int reg_id0, reg_id1;
+
+	reg_id0 = FPR_IDX(reg_num);
+	reg_id1 = reg_id0 % 2 ? (reg_id0 - 1) : (reg_id0 + 1);
+	result.f64 = val;
+	current->thread.user_fp.vr[reg_id0] = result.i[0];
+	current->thread.user_fp.vr[reg_id1] = result.i[1];
+}
+
+inline unsigned int read_fpr32l(int reg_num)
+{
+	return current->thread.user_fp.vr[FPR_L_IDX(reg_num)];
+}
+
+inline unsigned int read_fpr32h(int reg_num)
+{
+	return current->thread.user_fp.vr[FPR_H_IDX(reg_num)];
+}
+
+inline void write_fpr32l(unsigned int val, int reg_num)
+{
+	current->thread.user_fp.vr[FPR_L_IDX(reg_num)] = (unsigned long)val;
+}
+
+inline void write_fpr32h(unsigned int val, int reg_num)
+{
+	current->thread.user_fp.vr[FPR_H_IDX(reg_num)] = (unsigned long)val;
+}
+
+inline char get_fsr_c(struct pt_regs *regs)
+{
+	char result = regs->sr & 0x1;
+	return result;
+}
+
+inline void set_fsr_c(unsigned int val, struct pt_regs *regs)
+{
+	if (val)
+		regs->sr |= 0x1;
+	else
+		regs->sr &= 0xfffffffe;
+}
+
+unsigned long long get_double_constant(const unsigned int index)
+{
+	return float64_constant[index];
+}
+
+unsigned int get_single_constant(const unsigned int index)
+{
+	return float32_constant[index];
+}
+
+inline unsigned int read_fpcr(void)
+{
+	return current->thread.user_fp.fcr;
+}
+
+inline void write_fpcr(unsigned int val)
+{
+	current->thread.user_fp.fcr = val;
+}
+
+inline unsigned int read_fpesr(void)
+{
+	return current->thread.user_fp.fesr;
+}
+
+inline void write_fpesr(unsigned int val)
+{
+	__FPU_FPESR_U |= val;
+	current->thread.user_fp.fesr = __FPU_FPESR_U;
+}
+
+inline unsigned int get_round_mode(void)
+{
+	unsigned int result = read_fpcr();
+
+	return result & ROUND_MODE_MASK;
+}
+
+inline void set_round_mode(unsigned int val)
+{
+	write_fpcr((read_fpcr() & ~ROUND_MODE_MASK) | (val & ROUND_MODE_MASK));
+}
+
+inline void clear_fesr(unsigned int fesr)
+{
+	write_fpesr(0);
+}
+
+inline unsigned long long get_float64(int reg_num)
+{
+	unsigned long long result;
+
+	result = read_fpr64(reg_num);
+	return result;
+}
+
+inline unsigned int get_float32(int reg_num)
+{
+	unsigned int result;
+
+	result = read_fpr32l(reg_num);
+	return result;
+}
+
+inline void set_float64(unsigned long long val, int reg_num)
+{
+	write_fpr64(val, reg_num);
+}
+
+inline void set_float32(unsigned int val, int reg_num)
+{
+	write_fpr32l(val, reg_num);
+}
+
+inline unsigned int get_float32h(int reg_num)
+{
+	unsigned int result;
+
+	result = read_fpr32h(reg_num);
+	return result;
+}
+
+inline void set_float32h(unsigned int val, int reg_num)
+{
+	write_fpr32h(val, reg_num);
+}
+
+inline unsigned int get_uint32(int reg_num, struct inst_data *inst_data)
+{
+	unsigned int result;
+
+	result = read_gr(reg_num, inst_data->regs);
+	return result;
+}
+
+inline void set_uint32(unsigned int val, int reg_num,
+		       struct inst_data *inst_data)
+{
+	write_gr(val, reg_num, inst_data->regs);
+}
+
+inline unsigned long long get_float64_from_memory(unsigned long addr)
+{
+	return get_fpvalue64(addr);
+}
+
+inline void set_float64_to_memory(unsigned long long val, unsigned long addr)
+{
+	set_fpvalue64(val, addr);
+}
+
+inline unsigned int get_float32_from_memory(unsigned long addr)
+{
+	return get_fpvalue32(addr);
+}
+
+inline void set_float32_to_memory(unsigned int val, unsigned long addr)
+{
+	set_fpvalue32(val, addr);
+}
+
+static unsigned int fpe_exception_pc;
+inline void raise_float_exception(unsigned int exception)
+{
+	int sig;
+	kernel_siginfo_t info;
+
+	unsigned int enable_ex = exception & __FPU_FPCR_U &
+				 FPE_REGULAR_EXCEPTION;
+
+	if (!enable_ex) {
+		if (exception)
+			write_fpesr(0x8000 | (exception << 8));
+		return;
+	}
+
+	if (!(exception & FPE_REGULAR_EXCEPTION)) {
+		info.si_code = __SI_FAULT;
+		goto send_sigfpe;
+	}
+
+	if (enable_ex & FPE_IOC)
+		info.si_code = FPE_FLTINV;
+	else if (enable_ex & FPE_DZC)
+		info.si_code = FPE_FLTDIV;
+	else if (enable_ex & FPE_UFC)
+		info.si_code = FPE_FLTUND;
+	else if (enable_ex & FPE_OFC)
+		info.si_code = FPE_FLTOVF;
+	else if (enable_ex & FPE_IXC)
+		info.si_code = FPE_FLTRES;
+
+send_sigfpe:
+	sig = SIGFPE;
+	info.si_signo = SIGFPE;
+	info.si_errno = 0;
+	info.si_addr = (void *)(fpe_exception_pc);
+	send_sig_info(sig, &info, current);
+}
+
+inline unsigned int get_fpu_insn(struct pt_regs *regs)
+{
+	unsigned short inst_low, inst_high;
+	unsigned int result, inst;
+	unsigned int inst_ptr = instruction_pointer(regs);
+
+	result = 0;
+	inst = 0;
+	inst_low = 0;
+	inst_high = 0;
+
+	if (__get_user(inst_low, (unsigned short *)inst_ptr) == 0) {
+		if (__get_user(inst_high, (unsigned short *)(inst_ptr + 2)) ==
+		    0) {
+			inst = inst_high | ((unsigned int)inst_low << 16);
+			if (INST_IS_FP(inst))
+				result = inst;
+		}
+	}
+
+	return result;
+}
+
+inline int do_fpu_insn(unsigned int inst, struct pt_regs *regs)
+{
+	int index;
+	int sop, pcode;
+	int vrx, vry, vrz;
+	struct inst_data inst_data;
+
+	fpe_exception_pc = regs->pc;
+	inst_data.inst = inst;
+	inst_data.regs = regs;
+	save_to_user_fp(&current->thread.user_fp);
+
+#if defined(CONFIG_CPU_CK810)
+	/* array1's 13 bit is 0, array2's is 1 */
+	if (inst & FPUV2_LDST_MASK) {
+		index = FPUV2_LDST_INSN_INDEX(inst);
+		vrx = CSKY_INSN_RX(inst);
+		vry = CSKY_INSN_VRY(inst);
+		vrz = CSKY_INSN_VRZ(inst);
+
+		if (likely(inst_op2[index].fn != NULL))
+			inst_op2[index].fn(vrx, vry, vrz, &inst_data);
+		else
+			goto fault;
+	} else {
+		index = FPUV2_INSN_INDEX(inst);
+		vrx = CSKY_INSN_VRX(inst);
+		vry = CSKY_INSN_VRY(inst);
+		vrz = CSKY_INSN_VRZ(inst);
+
+		if (likely(inst_op1[index].fn != NULL))
+			inst_op1[index].fn(vrx, vry, vrz, &inst_data);
+		else
+			goto fault;
+	}
+#elif defined(CONFIG_CPU_CK860)
+	index = CSKY_INSN_OP(inst);
+	sop = CSKY_INSN_SOP(inst);
+	pcode = CSKY_INSN_PCODE(inst);
+
+	if (likely(fpu_vfp_insn[index].sop[sop].pcode[pcode].func.fpu !=
+		   NULL)) {
+		vrx = CSKY_INSN_VRX(inst);
+		vry = CSKY_INSN_VRY(inst);
+		vrz = CSKY_INSN_VRZ(inst);
+		fpu_vfp_insn[index].sop[sop].pcode[pcode].func.fpu(
+			vrx, vry, vrz, &inst_data);
+
+	} else {
+		goto fault;
+	}
+#else
+	return 0;
+#endif
+
+	restore_from_user_fp(&current->thread.user_fp);
+	return 0;
+fault:
+	restore_from_user_fp(&current->thread.user_fp);
+	return 1;
+}
diff --git a/arch/csky/math-emu/math.h b/arch/csky/math-emu/math.h
new file mode 100644
index 000000000000..099c1b8f769e
--- /dev/null
+++ b/arch/csky/math-emu/math.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __CSKY_FP_MATH_H__
+#define __CSKY_FP_MATH_H__
+
+struct inst_data {
+	unsigned int inst;
+	struct pt_regs *regs;
+};
+
+union float64_components {
+	unsigned long long f64;
+	unsigned int i[2];
+	double f;
+};
+
+union fd_data {
+	unsigned long long n;
+	double d;
+};
+
+union fs_data {
+	unsigned int n;
+	float f;
+};
+
+#define DPFROMINIT(sp, x)                                                      \
+	unsigned long long x##_val;                                            \
+	x##_val = 0LL;                                                         \
+	sp = &x##_val
+#define SPFROMINIT(sp, x)                                                      \
+	unsigned int x##_val;                                                  \
+	x##_val = 0;                                                           \
+	sp = &x##_val
+#define DPFROMREG(dp, x)                                                       \
+	unsigned long long x##_val;                                            \
+	x##_val = get_float64(x);                                              \
+	dp = &x##_val
+#define SPFROMREG(sp, x)                                                       \
+	unsigned int x##_val;                                                  \
+	x##_val = get_float32(x);                                              \
+	sp = &x##_val
+
+#define SP_CONST_DATA(sp, ind)                                                 \
+	unsigned int sp##_val;                                                 \
+	sp##_val = get_single_constant(ind);                                   \
+	sp = &sp##_val
+#define DP_CONST_DATA(dp, ind)                                                 \
+	unsigned long long dp##_val;                                           \
+	dp##_val = get_double_constant(ind);                                   \
+	dp = &dp##_val
+
+#define REG_INIT_SN
+
+#define REG_INIT_SI(reg)                                                       \
+		void *vr##reg;                                                 \
+		SPFROMINIT(vr##reg, reg)
+
+#define REG_INIT_SR(reg)                                                       \
+		void *vr##reg;                                                 \
+		SPFROMREG(vr##reg, reg)
+
+#define REG_INIT_DN
+
+#define REG_INIT_DI(reg)                                                       \
+		void *vr##reg;                                                 \
+		DPFROMINIT(vr##reg, reg)
+
+#define REG_INIT_DR(reg)                                                       \
+		void *vr##reg;                                                 \
+		DPFROMREG(vr##reg, reg)
+
+#define FPU_INSN_START(t1, t2, t3)                                             \
+		REG_INIT_##t1(x);                                              \
+		REG_INIT_##t2(y);                                              \
+		REG_INIT_##t3(z)
+
+#define FPU_INSN_DP_END                                                        \
+	do {                                                                   \
+		set_float64(*(unsigned long long *)vrz, z);                    \
+		if (FP_CUR_EXCEPTIONS)                                         \
+			raise_float_exception(FP_CUR_EXCEPTIONS);              \
+	} while (0)
+
+#define FPU_INSN_SP_END                                                        \
+	do {                                                                   \
+		set_float32(*(unsigned int *)vrz, z);                          \
+		if (FP_CUR_EXCEPTIONS)                                         \
+			raise_float_exception(FP_CUR_EXCEPTIONS);              \
+	} while (0)
+
+#define SET_FLAG_END                                                           \
+	do {                                                                   \
+		set_fsr_c(result, inst_data->regs);                            \
+		if (FP_CUR_EXCEPTIONS)                                         \
+			raise_float_exception(FP_CUR_EXCEPTIONS);              \
+	} while (0)
+
+#define SET_AND_SAVE_RM(mode)                                                  \
+	unsigned int saved_mode;                                               \
+	saved_mode = get_round_mode();                                         \
+	set_round_mode(mode << 24)
+#define RESTORE_ROUND_MODE set_round_mode(saved_mode)
+
+#define MAC_INTERNAL_ROUND_DP                                                  \
+	do {                                                                   \
+		FP_PACK_DP(vrz, T);                                            \
+		FP_UNPACK_DP(T, vrz);                                          \
+	} while (0)
+
+#define MAC_INTERNAL_ROUND_SP                                                  \
+	do {                                                                   \
+		FP_PACK_SP(vrz, T);                                            \
+		FP_UNPACK_SP(T, vrz);                                          \
+	} while (0)
+
+#define SET_FSR_C(val, reg)                                                    \
+	do {                                                                   \
+		if (val) {                                                     \
+			regs->sr |= 0x1;                                       \
+		} else {                                                       \
+			regs->sr &= 0xfffffffe;                                \
+		}                                                              \
+	} while (0)
+
+inline void raise_float_exception(unsigned int exception);
+
+inline char get_fsr_c(struct pt_regs *regs);
+inline void set_fsr_c(unsigned int val, struct pt_regs *regs);
+inline unsigned long long read_fpr64(int reg_num);
+inline unsigned int read_fpr32l(int reg_num);
+inline unsigned int read_fpr32h(int reg_num);
+inline void write_fpr64(unsigned long long val, int reg_num);
+inline void write_fpr32l(unsigned int val, int reg_num);
+inline void write_fpr32h(unsigned int val, int reg_num);
+inline unsigned int read_gr(int reg_num, struct pt_regs *regs);
+inline void write_gr(unsigned int val, int reg_num, struct pt_regs *regs);
+inline unsigned int read_fpr(int reg_num);
+inline void write_fpr(unsigned int val, int reg_num);
+inline unsigned int read_fpsr(void);
+inline void write_fpsr(unsigned int val);
+inline unsigned int get_fpvalue32(unsigned int addr);
+inline void set_fpvalue32(unsigned int val, unsigned int addr);
+inline unsigned long long get_fpvalue64(unsigned int addr);
+inline void set_fpvalue64(unsigned long long val, unsigned int addr);
+inline unsigned int read_fpcr(void);
+inline void write_fpcr(unsigned int val);
+inline unsigned int read_fpesr(void);
+inline void write_fpesr(unsigned int val);
+inline unsigned long long get_double_constant(const unsigned int index);
+inline unsigned int get_single_constant(const unsigned int index);
+inline unsigned int get_round_mode(void);
+inline void set_round_mode(unsigned int val);
+inline void clear_fesr(unsigned int fesr);
+inline unsigned long long get_float64(int reg_num);
+inline unsigned int get_float32(int reg_num);
+inline void set_float64(unsigned long long val, int reg_num);
+inline void set_float32(unsigned int val, int reg_num);
+inline void set_float32h(unsigned int val, int reg_num);
+inline unsigned int get_uint32(int reg_num, struct inst_data *inst_data);
+inline void set_uint32(unsigned int val, int reg_num,
+		       struct inst_data *inst_data);
+inline unsigned long long get_float64_from_memory(unsigned long addr);
+inline void set_float64_to_memory(unsigned long long val, unsigned long addr);
+inline unsigned int get_float32_from_memory(unsigned long addr);
+inline void set_float32_to_memory(unsigned int val, unsigned long addr);
+
+#endif
diff --git a/arch/csky/math-emu/sfp-fixs.h b/arch/csky/math-emu/sfp-fixs.h
new file mode 100644
index 000000000000..4fdbec820aba
--- /dev/null
+++ b/arch/csky/math-emu/sfp-fixs.h
@@ -0,0 +1,214 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __SFP_FIXS_H__
+#define __SFP_FIXS_H__
+
+#ifdef _FP_FRAC_CLZ_4
+#undef _FP_FRAC_CLZ_4
+#define _FP_FRAC_CLZ_4(R, X)                                                   \
+	do {                                                                   \
+		if (X##_f[3]) {                                                \
+			__FP_CLZ(R, X##_f[3]);                                 \
+		} else if (X##_f[2]) {                                         \
+			__FP_CLZ(R, X##_f[2]);                                 \
+			R += _FP_W_TYPE_SIZE;                                  \
+		} else if (X##_f[1]) {                                         \
+			__FP_CLZ(R, X##_f[1]);                                 \
+			R += _FP_W_TYPE_SIZE * 2;                              \
+		} else {                                                       \
+			__FP_CLZ(R, X##_f[0]);                                 \
+			R += _FP_W_TYPE_SIZE * 3;                              \
+		}                                                              \
+	} while (0)
+#endif
+
+#ifdef _FP_TO_INT_ROUND
+#undef _FP_TO_INT_ROUND
+#define _FP_TO_INT_ROUND(fs, wc, r, X, rsize, rsigned)                              \
+	do {                                                                        \
+		r = 0;                                                              \
+		switch (X##_c) {                                                    \
+		case FP_CLS_NORMAL:                                                 \
+			if (X##_e >= _FP_FRACBITS_##fs - 1) {                       \
+				if (X##_e < rsize - 1 + _FP_WFRACBITS_##fs) {       \
+					if (X##_e >= _FP_WFRACBITS_##fs - 1) {      \
+						_FP_FRAC_ASSEMBLE_##wc(r, X,        \
+								       rsize);      \
+						r <<= X##_e -                       \
+						      _FP_WFRACBITS_##fs + 1;       \
+					} else {                                    \
+						_FP_FRAC_SRL_##wc(                  \
+							X,                          \
+							_FP_WORKBITS - X##_e +      \
+								_FP_FRACBITS_##fs - \
+								1);                 \
+						_FP_FRAC_ASSEMBLE_##wc(r, X,        \
+								       rsize);      \
+					}                                           \
+				}                                                   \
+			} else {                                                    \
+				int _lz0, _lz1;                                     \
+				if (X##_e <= -_FP_WORKBITS - 1)                     \
+					_FP_FRAC_SET_##wc(X,                        \
+							  _FP_MINFRAC_##wc);        \
+				else                                                \
+					_FP_FRAC_SRS_##wc(X,                        \
+							  _FP_FRACBITS_##fs -       \
+								  1 - X##_e,        \
+							  _FP_WFRACBITS_##fs);      \
+				_FP_FRAC_CLZ_##wc(_lz0, X);                         \
+				_FP_ROUND(wc, X);                                   \
+				_FP_FRAC_CLZ_##wc(_lz1, X);                         \
+				if (_lz1 < _lz0)                                    \
+					X##_e++; /* For overflow detection.  */     \
+				_FP_FRAC_SRL_##wc(X, _FP_WORKBITS);                 \
+				_FP_FRAC_ASSEMBLE_##wc(r, X, rsize);                \
+			}                                                           \
+			if (rsigned && X##_s)                                       \
+				r = -r;                                             \
+			if ((rsigned > 0 || X##_s) && (X##_e == rsize - 1) &&       \
+			    (r == (1 << (rsize - 1))))                              \
+				break;                                              \
+			if (X##_e >= rsize - (rsigned > 0 || X##_s) ||              \
+			    (!rsigned && X##_s)) { /* overflow */                   \
+			case FP_CLS_NAN:                                            \
+			case FP_CLS_INF:                                            \
+				if (!rsigned) {                                     \
+					r = 0;                                      \
+					if (!X##_s)                                 \
+						r = ~r;                             \
+				} else if (rsigned != 2) {                          \
+					r = 1;                                      \
+					r <<= rsize - 1;                            \
+					r -= 1 - X##_s;                             \
+				}                                                   \
+				FP_SET_EXCEPTION(FP_EX_INVALID);                    \
+			}                                                           \
+			break;                                                      \
+		case FP_CLS_ZERO:                                                   \
+			break;                                                      \
+		}                                                                   \
+	} while (0)
+#endif
+
+#ifdef _FP_PACK_CANONICAL
+#undef _FP_PACK_CANONICAL
+#define _FP_PACK_CANONICAL(fs, wc, X)                                               \
+	do {                                                                        \
+		switch (X##_c) {                                                    \
+		case FP_CLS_NORMAL:                                                 \
+			X##_e += _FP_EXPBIAS_##fs;                                  \
+			if (X##_e > 0) {                                            \
+				_FP_ROUND(wc, X);                                   \
+				if (_FP_FRAC_OVERP_##wc(fs, X)) {                   \
+					_FP_FRAC_CLEAR_OVERP_##wc(fs, X);           \
+					X##_e++;                                    \
+				}                                                   \
+				_FP_FRAC_SRL_##wc(X, _FP_WORKBITS);                 \
+				if (X##_e >= _FP_EXPMAX_##fs) {                     \
+					/* overflow */                              \
+					switch (FP_ROUNDMODE) {                     \
+					case FP_RND_NEAREST:                        \
+						X##_c = FP_CLS_INF;                 \
+						break;                              \
+					case FP_RND_PINF:                           \
+						if (!X##_s)                         \
+							X##_c = FP_CLS_INF;         \
+						break;                              \
+					case FP_RND_MINF:                           \
+						if (X##_s)                          \
+							X##_c = FP_CLS_INF;         \
+						break;                              \
+					}                                           \
+					if (X##_c == FP_CLS_INF) {                  \
+						/* Overflow to infinity */          \
+						X##_e = _FP_EXPMAX_##fs;            \
+						_FP_FRAC_SET_##wc(                  \
+							X, _FP_ZEROFRAC_##wc);      \
+					} else {                                    \
+						/* Overflow to maximum normal */    \
+						X##_e = _FP_EXPMAX_##fs - 1;        \
+						_FP_FRAC_SET_##wc(                  \
+							X, _FP_MAXFRAC_##wc);       \
+					}                                           \
+					FP_SET_EXCEPTION(FP_EX_OVERFLOW);           \
+					FP_SET_EXCEPTION(FP_EX_INEXACT);            \
+				}                                                   \
+			} else {                                                    \
+				/* we've got a denormalized number */               \
+				int max_inc =                                       \
+					(FP_ROUNDMODE == FP_RND_NEAREST) ? 3 :      \
+									   7;       \
+				max_inc += (_FP_FRAC_LOW_##fs(X) & 0xf);            \
+				bool is_tiny =                                      \
+					(X##_e < 0) ||                              \
+					!(max_inc & (_FP_WORK_LSB << 1));           \
+				X##_e = -X##_e + 1;                                 \
+				if (X##_e <= _FP_WFRACBITS_##fs) {                  \
+					_FP_FRAC_SRS_##wc(X, X##_e,                 \
+							  _FP_WFRACBITS_##fs);      \
+					if (_FP_FRAC_HIGH_##fs(X) &                 \
+					    (_FP_OVERFLOW_##fs >> 1)) {             \
+						X##_e = 1;                          \
+						_FP_FRAC_SET_##wc(                  \
+							X, _FP_ZEROFRAC_##wc);      \
+					} else {                                    \
+						_FP_ROUND(wc, X);                   \
+						if (_FP_FRAC_HIGH_##fs(X) &         \
+						    (_FP_OVERFLOW_##fs >>           \
+						     1)) {                          \
+							X##_e = 1;                  \
+							_FP_FRAC_SET_##wc(          \
+								X,                  \
+								_FP_ZEROFRAC_##wc); \
+							FP_SET_EXCEPTION(           \
+								FP_EX_INEXACT);     \
+						} else {                            \
+							X##_e = 0;                  \
+							_FP_FRAC_SRL_##wc(          \
+								X,                  \
+								_FP_WORKBITS);      \
+						}                                   \
+					}                                           \
+					if ((is_tiny || (X##_e == 0)) &&            \
+					    ((FP_CUR_EXCEPTIONS &                   \
+					      FP_EX_INEXACT) ||                     \
+					     (FP_TRAPPING_EXCEPTIONS &              \
+					      FP_EX_UNDERFLOW)))                    \
+						FP_SET_EXCEPTION(                   \
+							FP_EX_UNDERFLOW);           \
+				} else {                                            \
+					/* underflow to zero */                     \
+					X##_e = 0;                                  \
+					if (!_FP_FRAC_ZEROP_##wc(X)) {              \
+						_FP_FRAC_SET_##wc(                  \
+							X, _FP_MINFRAC_##wc);       \
+						_FP_ROUND(wc, X);                   \
+						_FP_FRAC_LOW_##wc(X) >>=            \
+							(_FP_WORKBITS);             \
+					}                                           \
+					FP_SET_EXCEPTION(FP_EX_UNDERFLOW);          \
+				}                                                   \
+			}                                                           \
+			break;                                                      \
+		case FP_CLS_ZERO:                                                   \
+			X##_e = 0;                                                  \
+			_FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);                    \
+			break;                                                      \
+		case FP_CLS_INF:                                                    \
+			X##_e = _FP_EXPMAX_##fs;                                    \
+			_FP_FRAC_SET_##wc(X, _FP_ZEROFRAC_##wc);                    \
+			break;                                                      \
+		case FP_CLS_NAN:                                                    \
+			X##_e = _FP_EXPMAX_##fs;                                    \
+			if (!_FP_KEEPNANFRACP) {                                    \
+				_FP_FRAC_SET_##wc(X, _FP_NANFRAC_##fs);             \
+				X##_s = _FP_NANSIGN_##fs;                           \
+			} else                                                      \
+				_FP_FRAC_HIGH_RAW_##fs(X) |= _FP_QNANBIT_##fs;      \
+			break;                                                      \
+		}                                                                   \
+	} while (0)
+#endif
+
+#endif
diff --git a/arch/csky/math-emu/sfp-util.h b/arch/csky/math-emu/sfp-util.h
new file mode 100644
index 000000000000..a17b7e4b0dfa
--- /dev/null
+++ b/arch/csky/math-emu/sfp-util.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef W_TYPE_SIZE
+#define W_TYPE_SIZE 32
+#endif
+
+#define __BITS4 (W_TYPE_SIZE / 4)
+#define __ll_B ((UWtype)1 << (W_TYPE_SIZE / 2))
+#define __ll_lowpart(t) ((UWtype)(t) & (__ll_B - 1))
+#define __ll_highpart(t) ((UWtype)(t) >> (W_TYPE_SIZE / 2))
+
+#if !defined(add_ssaaaa)
+#define add_ssaaaa(sh, sl, ah, al, bh, bl)                                     \
+	do {                                                                   \
+		UWtype __x;                                                    \
+		__x = (al) + (bl);                                             \
+		(sh) = (ah) + (bh) + (__x < (al));                             \
+		(sl) = __x;                                                    \
+	} while (0)
+#endif
+
+#if !defined(sub_ddmmss)
+#define sub_ddmmss(sh, sl, ah, al, bh, bl)                                     \
+	do {                                                                   \
+		UWtype __x;                                                    \
+		__x = (al) - (bl);                                             \
+		(sh) = (ah) - (bh) - (__x > (al));                             \
+		(sl) = __x;                                                    \
+	} while (0)
+#endif
+
+#if !defined(umul_ppmm) && defined(smul_ppmm)
+#define umul_ppmm(w1, w0, u, v)                                                \
+	do {                                                                   \
+		UWtype __w1;                                                   \
+		UWtype __xm0 = (u), __xm1 = (v);                               \
+		smul_ppmm(__w1, w0, __xm0, __xm1);                             \
+		(w1) = __w1 + (-(__xm0 >> (W_TYPE_SIZE - 1)) & __xm1) +        \
+		       (-(__xm1 >> (W_TYPE_SIZE - 1)) & __xm0);                \
+	} while (0)
+#endif
+
+/* If we still don't have umul_ppmm, define it using plain C.  */
+#if !defined(umul_ppmm)
+#define umul_ppmm(w1, w0, u, v)                                                \
+	do {                                                                   \
+		UWtype __x0, __x1, __x2, __x3;                                 \
+		UHWtype __ul, __vl, __uh, __vh;                                \
+		__ul = __ll_lowpart(u);                                        \
+		__uh = __ll_highpart(u);                                       \
+		__vl = __ll_lowpart(v);                                        \
+		__vh = __ll_highpart(v);                                       \
+		__x0 = (UWtype)__ul * __vl;                                    \
+		__x1 = (UWtype)__ul * __vh;                                    \
+		__x2 = (UWtype)__uh * __vl;                                    \
+		__x3 = (UWtype)__uh * __vh;                                    \
+		__x1 += __ll_highpart(__x0); /* this can't give carry */       \
+		__x1 += __x2; /* but this indeed can */                        \
+		if (__x1 < __x2) /* did we get it? */                          \
+			__x3 += __ll_B; /* yes, add it in the proper pos.  */  \
+		(w1) = __x3 + __ll_highpart(__x1);                             \
+		(w0) = __ll_lowpart(__x1) * __ll_B + __ll_lowpart(__x0);       \
+	} while (0)
+#endif
+
+#define udiv_qrnnd(q, r, n1, n0, d)                                                 \
+	do {                                                                        \
+		UWtype __d1, __d0, __q1, __q0;                                      \
+		UWtype __r1, __r0, __m;                                             \
+		__d1 = __ll_highpart(d);                                            \
+		__d0 = __ll_lowpart(d);                                             \
+		__r1 = (n1) % __d1;                                                 \
+		__q1 = (n1) / __d1;                                                 \
+		__m = (UWtype)__q1 * __d0;                                          \
+		__r1 = __r1 * __ll_B | __ll_highpart(n0);                           \
+		if (__r1 < __m) {                                                   \
+			__q1--, __r1 += (d);                                        \
+			if (__r1 >=                                                 \
+			    (d)) /* i.e. we didn't get carry when adding to __r1 */ \
+				if (__r1 < __m)                                     \
+					__q1--, __r1 += (d);                        \
+		}                                                                   \
+		__r1 -= __m;                                                        \
+		__r0 = __r1 % __d1;                                                 \
+		__q0 = __r1 / __d1;                                                 \
+		__m = (UWtype)__q0 * __d0;                                          \
+		__r0 = __r0 * __ll_B | __ll_lowpart(n0);                            \
+		if (__r0 < __m) {                                                   \
+			__q0--, __r0 += (d);                                        \
+			if (__r0 >= (d))                                            \
+				if (__r0 < __m)                                     \
+					__q0--, __r0 += (d);                        \
+		}                                                                   \
+		__r0 -= __m;                                                        \
+		(q) = (UWtype)__q1 * __ll_B | __q0;                                 \
+		(r) = __r0;                                                         \
+	} while (0)
+
+#define abort() return 0
-- 
2.17.1

