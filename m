Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1175536D223
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 08:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235808AbhD1GVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 02:21:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229464AbhD1GU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 02:20:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E5D6613B3;
        Wed, 28 Apr 2021 06:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619590813;
        bh=BPGBcdwWsPK+VWmwhkZcjg6B9YwW6MzNpkLcI9YyF1w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wu36xqXGEbpcZ3GQcel8BNC3a7SgqJqL5NgfFDpHddDvMConrs5kirkHSOO/Kqqdg
         g9DnRYE2sDTwOWlQbg70fr/rS/dyzcXLjlV40R+tF3T7ajQbRJ7FXjAl8ql5q2Xw4q
         dz5Q++uDKdOe6Q4XYSlwQYcRD+BhxuC5rsygUaitlSTl9KX83hBASnZzBD9wQGUVg7
         clPM/TkLgj8xvWxl5QLqKDEQTjLEI2QQe73tYf9bNPPh29VYgbAitNhqDVEOwM40nS
         XPK7j4jNJXjY/Sx6flryr49cAkuMwdsFUO4wEsFhrkDrE0FSVLCJGmuQx6018xWZRA
         ikT2c5C3pcbUQ==
Received: by mail-lj1-f175.google.com with SMTP id u25so32618957ljg.7;
        Tue, 27 Apr 2021 23:20:13 -0700 (PDT)
X-Gm-Message-State: AOAM5333727T4R1iqtHy+Vy2AMX22DNTaKsGiSrB0OmD9wMHuDLEnzOX
        FkjLH0K88+twOEhoQO8kcLTljkFmr78rXIipjFM=
X-Google-Smtp-Source: ABdhPJw53928mDraeNWTaV2iHE5WvLcBS7WkEpGOzHwpTRh40u1BPcFZ8vDVhA4aghx6p7oM3o/XMCj6WNAygmps7kc=
X-Received: by 2002:a2e:8182:: with SMTP id e2mr19968195ljg.238.1619590811056;
 Tue, 27 Apr 2021 23:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210421024826.13529-1-wangjunqiang@iscas.ac.cn>
In-Reply-To: <20210421024826.13529-1-wangjunqiang@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 28 Apr 2021 14:19:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRJFPJ09iBUUoFx35Kkb2_HyWpgCGeBdMJhD8XimjuCcw@mail.gmail.com>
Message-ID: <CAJF2gTRJFPJ09iBUUoFx35Kkb2_HyWpgCGeBdMJhD8XimjuCcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] csky: add CSKY 810/860 FPU instruction simulation
To:     Wang Junqiang <wangjunqiang@iscas.ac.cn>
Cc:     Guo Ren <guoren@linux.alibaba.com>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Li Weiwei <liweiwei@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 10:56 AM Wang Junqiang <wangjunqiang@iscas.ac.cn> wrote:
>
> This patch is the implementation code of CSKY 810/860 FPU instruction
> simulation based on the math-emu of kernel and glibc softfp:
>
> sfp-machine.h: contains the migrated code and FMA support
> sfp-fixs.h: contains the code that fix the origin math-emu library
>             to CSKY 810/860 instruction function
> fp810.c/fp860.c: contain the implementation of ck810 and ck860
>                  FPU 32/64 instruction simulation
> math.c: contains the function call interface
>
> origin math-emu fixs:
>     typo 2->1 in _FP_FRAC_CLZ_4 macro
>     exception flag setting in _FP_TO_INT_ROUND and _FP_PACK_CANONICAL macro
>     calculation error in __FP_FRAC_SUB_3 and __FP_FRAC_SUB_4 macro
Has the patch merged? Please give out the lore.kernel.org mailing list link.

>
> Signed-off-by: Wang Junqiang <wangjunqiang@iscas.ac.cn>
> Signed-off-by: Li Weiwei <liweiwei@iscas.ac.cn>
+ Co-developed-by: Li Weiwei <>
> ---
>  arch/csky/include/asm/sfp-machine.h  |  441 ++++
>  arch/csky/include/uapi/asm/siginfo.h |   10 +
>  arch/csky/math-emu/Makefile          |   13 +
>  arch/csky/math-emu/fp810.c           | 2420 +++++++++++++++++++++
>  arch/csky/math-emu/fp810.h           |  524 +++++
>  arch/csky/math-emu/fp860.c           | 2944 ++++++++++++++++++++++++++
>  arch/csky/math-emu/fp860.h           |  256 +++
>  arch/csky/math-emu/math.c            |  489 +++++
>  arch/csky/math-emu/math.h            |  176 ++
>  arch/csky/math-emu/sfp-fixs.h        |  213 ++
>  arch/csky/math-emu/sfp-util.h        |   98 +
>  11 files changed, 7584 insertions(+)
>  create mode 100644 arch/csky/include/asm/sfp-machine.h
>  create mode 100644 arch/csky/include/uapi/asm/siginfo.h
>  create mode 100644 arch/csky/math-emu/Makefile
>  create mode 100644 arch/csky/math-emu/fp810.c
>  create mode 100644 arch/csky/math-emu/fp810.h
>  create mode 100644 arch/csky/math-emu/fp860.c
>  create mode 100644 arch/csky/math-emu/fp860.h
>  create mode 100644 arch/csky/math-emu/math.c
>  create mode 100644 arch/csky/math-emu/math.h
>  create mode 100644 arch/csky/math-emu/sfp-fixs.h
>  create mode 100644 arch/csky/math-emu/sfp-util.h
>
> diff --git a/arch/csky/include/asm/sfp-machine.h b/arch/csky/include/asm/sfp-machine.h
> new file mode 100644
> index 000000000000..1f6dfad701f1
> --- /dev/null
> +++ b/arch/csky/include/asm/sfp-machine.h
> @@ -0,0 +1,441 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#define _FP_W_TYPE_SIZE 32
> +#define _FP_W_TYPE unsigned long
> +#define _FP_WS_TYPE signed long
> +#define _FP_I_TYPE long
> +
> +#define _FP_MUL_MEAT_S(R, X, Y)                                                \
> +       _FP_MUL_MEAT_1_wide(_FP_WFRACBITS_S, R, X, Y, umul_ppmm)
> +#define _FP_MUL_MEAT_D(R, X, Y)                                                \
> +       _FP_MUL_MEAT_2_wide(_FP_WFRACBITS_D, R, X, Y, umul_ppmm)
> +#define _FP_MUL_MEAT_Q(R, X, Y)                                                \
> +       _FP_MUL_MEAT_4_wide(_FP_WFRACBITS_Q, R, X, Y, umul_ppmm)
> +
> +#define _FP_MUL_MEAT_DW_S(R, X, Y)                                             \
> +       _FP_MUL_MEAT_DW_1_wide(_FP_WFRACBITS_S, R, X, Y, umul_ppmm)
> +#define _FP_MUL_MEAT_DW_D(R, X, Y)                                             \
> +       _FP_MUL_MEAT_DW_2_wide(_FP_WFRACBITS_D, R, X, Y, umul_ppmm)
> +#define _FP_MUL_MEAT_DW_Q(R, X, Y)                                             \
> +       _FP_MUL_MEAT_DW_4_wide(_FP_WFRACBITS_Q, R, X, Y, umul_ppmm)
> +
> +#define _FP_DIV_MEAT_S(R, X, Y) _FP_DIV_MEAT_1_udiv_norm(S, R, X, Y)
> +#define _FP_DIV_MEAT_D(R, X, Y) _FP_DIV_MEAT_2_udiv(D, R, X, Y)
> +#define _FP_DIV_MEAT_Q(R, X, Y) _FP_DIV_MEAT_4_udiv(Q, R, X, Y)
> +
> +#define _FP_NANFRAC_S _FP_QNANBIT_S
> +#define _FP_NANFRAC_D _FP_QNANBIT_D, 0
> +#define _FP_NANFRAC_Q _FP_QNANBIT_Q, 0, 0, 0
> +#define _FP_NANSIGN_S (0)
> +#define _FP_NANSIGN_D (0)
> +#define _FP_NANSIGN_Q (0)
> +
> +#define _FP_KEEPNANFRACP 1
> +#define _FP_QNANNEGATEDP 0
> +
> +#define _FP_CHOOSENAN(fs, wc, R, X, Y, OP)                                     \
> +       do {                                                                   \
> +               if ((_FP_FRAC_HIGH_RAW_##fs(X) & _FP_QNANBIT_##fs) &&          \
> +                   !(_FP_FRAC_HIGH_RAW_##fs(Y) & _FP_QNANBIT_##fs)) {         \
> +                       R##_s = Y##_s;                                         \
> +                       _FP_FRAC_COPY_##wc(R, Y);                              \
> +               } else {                                                       \
> +                       R##_s = X##_s;                                         \
> +                       _FP_FRAC_COPY_##wc(R, X);                              \
> +               }                                                              \
> +               R##_c = FP_CLS_NAN;                                            \
> +       } while (0)
> +
> +#define __FPU_FPCSR (current->thread.user_fp.fcr)
> +#define __FPU_FPCSR_RM (get_round_mode())
> +#define _FP_TININESS_AFTER_ROUNDING (0)
> +
> +/* Obtain the current rounding mode. */
> +#define FP_ROUNDMODE ({ (__FPU_FPCSR_RM & 0x3000000) >> 24; })
> +
> +#define FP_RND_NEAREST 0
> +#define FP_RND_ZERO 1
> +#define FP_RND_PINF 2
> +#define FP_RND_MINF 3
> +
> +#define FP_EX_INVALID (1 << 0)
> +#define FP_EX_DIVZERO (1 << 1)
> +#define FP_EX_OVERFLOW (1 << 2)
> +#define FP_EX_UNDERFLOW (1 << 3)
> +#define FP_EX_INEXACT (1 << 4)
> +#define FP_EX_DENORM (1 << 5)
> +
> +#define SF_CEQ 2
> +#define SF_CLT 1
> +#define SF_CGT 3
> +#define SF_CUN 4
> +
> +#include <asm/byteorder.h>
> +
> +#ifdef __BIG_ENDIAN__
> +#define __BYTE_ORDER __BIG_ENDIAN
> +#define __LITTLE_ENDIAN 0
> +#else
> +#define __BYTE_ORDER __LITTLE_ENDIAN
> +#define __BIG_ENDIAN 0
> +#endif
> +
> +#if _FP_W_TYPE_SIZE < 64
> +#define _FP_FRACTBITS_DW_D (4 * _FP_W_TYPE_SIZE)
> +#define _FP_FRACTBITS_DW_S (2 * _FP_W_TYPE_SIZE)
> +#define _FP_FRAC_LOW_D(X) _FP_FRAC_LOW_2(X)
> +#define _FP_FRAC_HIGH_DW_D(X) _FP_FRAC_HIGH_4(X)
> +#define _FP_FRAC_HIGH_DW_S(X) _FP_FRAC_HIGH_2(X)
> +#else
> +#define _FP_FRACTBITS_DW_D (2 * _FP_W_TYPE_SIZE)
> +#define _FP_FRACTBITS_DW_S _FP_W_TYPE_SIZE
> +#define _FP_FRAC_LOW_D(X) _FP_FRAC_LOW_1(X)
> +#define _FP_FRAC_HIGH_DW_D(X) _FP_FRAC_HIGH_2(X)
> +#define _FP_FRAC_HIGH_DW_S(X) _FP_FRAC_HIGH_1(X)
> +#endif
> +
> +#define _FP_FRAC_LOW_S(X) _FP_FRAC_LOW_1(X)
> +
> +#define _FP_FRAC_HIGHBIT_DW_1(fs, X) (X##_f & _FP_HIGHBIT_DW_##fs)
> +#define _FP_FRAC_HIGHBIT_DW_2(fs, X)                                           \
> +       (_FP_FRAC_HIGH_DW_##fs(X) & _FP_HIGHBIT_DW_##fs)
> +#define _FP_FRAC_HIGHBIT_DW_4(fs, X)                                           \
> +       (_FP_FRAC_HIGH_DW_##fs(X) & _FP_HIGHBIT_DW_##fs)
> +
> +#define _FP_QNANBIT_SH_D                                                       \
> +       ((_FP_W_TYPE)1 << (_FP_FRACBITS_D - 2 + _FP_WORKBITS) % _FP_W_TYPE_SIZE)
> +
> +#define _FP_IMPLBIT_SH_D                                                       \
> +       ((_FP_W_TYPE)1 << (_FP_FRACBITS_D - 1 + _FP_WORKBITS) % _FP_W_TYPE_SIZE)
> +
> +#define _FP_WFRACBITS_DW_D (2 * _FP_WFRACBITS_D)
> +#define _FP_WFRACXBITS_DW_D (_FP_FRACTBITS_DW_D - _FP_WFRACBITS_DW_D)
> +#define _FP_HIGHBIT_DW_D                                                       \
> +       ((_FP_W_TYPE)1 << (_FP_WFRACBITS_DW_D - 1) % _FP_W_TYPE_SIZE)
> +
> +#define _FP_WFRACBITS_DW_S (2 * _FP_WFRACBITS_S)
> +#define _FP_WFRACXBITS_DW_S (_FP_FRACTBITS_DW_S - _FP_WFRACBITS_DW_S)
> +#define _FP_HIGHBIT_DW_S                                                       \
> +       ((_FP_W_TYPE)1 << (_FP_WFRACBITS_DW_S - 1) % _FP_W_TYPE_SIZE)
> +
> +#define _FP_MUL_MEAT_DW_1_wide(wfracbits, R, X, Y, doit)                       \
> +       do {                                                                   \
> +               doit(R##_f1, R##_f0, X##_f, Y##_f);                            \
> +       } while (0)
> +
> +#define _FP_MUL_MEAT_DW_2_wide(wfracbits, R, X, Y, doit)                       \
> +       do {                                                                   \
> +               _FP_FRAC_DECL_2(_FP_MUL_MEAT_DW_2_wide_b);                     \
> +               _FP_FRAC_DECL_2(_FP_MUL_MEAT_DW_2_wide_c);                     \
> +               doit(_FP_FRAC_WORD_4(R, 1), _FP_FRAC_WORD_4(R, 0), X##_f0,     \
> +                    Y##_f0);                                                  \
> +               doit(_FP_MUL_MEAT_DW_2_wide_b_f1, _FP_MUL_MEAT_DW_2_wide_b_f0, \
> +                    X##_f0, Y##_f1);                                          \
> +               doit(_FP_MUL_MEAT_DW_2_wide_c_f1, _FP_MUL_MEAT_DW_2_wide_c_f0, \
> +                    X##_f1, Y##_f0);                                          \
> +               doit(_FP_FRAC_WORD_4(R, 3), _FP_FRAC_WORD_4(R, 2), X##_f1,     \
> +                    Y##_f1);                                                  \
> +               __FP_FRAC_ADD_3(_FP_FRAC_WORD_4(R, 3), _FP_FRAC_WORD_4(R, 2),  \
> +                               _FP_FRAC_WORD_4(R, 1), 0,                      \
> +                               _FP_MUL_MEAT_DW_2_wide_b_f1,                   \
> +                               _FP_MUL_MEAT_DW_2_wide_b_f0,                   \
> +                               _FP_FRAC_WORD_4(R, 3), _FP_FRAC_WORD_4(R, 2),  \
> +                               _FP_FRAC_WORD_4(R, 1));                        \
> +               __FP_FRAC_ADD_3(_FP_FRAC_WORD_4(R, 3), _FP_FRAC_WORD_4(R, 2),  \
> +                               _FP_FRAC_WORD_4(R, 1), 0,                      \
> +                               _FP_MUL_MEAT_DW_2_wide_c_f1,                   \
> +                               _FP_MUL_MEAT_DW_2_wide_c_f0,                   \
> +                               _FP_FRAC_WORD_4(R, 3), _FP_FRAC_WORD_4(R, 2),  \
> +                               _FP_FRAC_WORD_4(R, 1));                        \
> +       } while (0)
> +
> +#define _FP_FRAC_COPY_1_2(D, S) (D##_f = S##_f0)
> +#define _FP_FRAC_COPY_2_1(D, S) ((D##_f0 = S##_f), (D##_f1 = 0))
> +#define _FP_FRAC_COPY_2_2(D, S) _FP_FRAC_COPY_2(D, S)
> +#define _FP_FRAC_COPY_1_4(D, S) (D##_f = S##_f[0])
> +#define _FP_FRAC_COPY_2_4(D, S)                                                \
> +       do {                                                                   \
> +               D##_f0 = S##_f[0];                                             \
> +               D##_f1 = S##_f[1];                                             \
> +       } while (0)
> +#define _FP_FRAC_COPY_4_1(D, S)                                                \
> +       do {                                                                   \
> +               D##_f[0] = S##_f;                                              \
> +               D##_f[1] = D##_f[2] = D##_f[3] = 0;                            \
> +       } while (0)
> +#define _FP_FRAC_COPY_4_2(D, S)                                                \
> +       do {                                                                   \
> +               D##_f[0] = S##_f0;                                             \
> +               D##_f[1] = S##_f1;                                             \
> +               D##_f[2] = D##_f[3] = 0;                                       \
> +       } while (0)
> +#define _FP_FRAC_COPY_4_4(D, S) _FP_FRAC_COPY_4(D, S)
> +
> +/* fma (Inf, 0, c).  */
> +#ifndef FP_EX_INVALID_IMZ_FMA
> +#define FP_EX_INVALID_IMZ_FMA 0
> +#endif
> +
> +#define __FP_FRAC_SUB_3(r2, r1, r0, x2, x1, x0, y2, y1, y0)                    \
> +       do {                                                                   \
> +               int _c1, _c2;                                                  \
> +               r0 = x0 - y0;                                                  \
> +               _c1 = r0 > x0;                                                 \
> +               r1 = x1 - y1;                                                  \
> +               _c2 = r1 > x1;                                                 \
> +               r1 -= _c1;                                                     \
> +               _c2 |= _c1 && (y1 == x1);                                      \
> +               r2 = x2 - y2 - _c2;                                            \
> +       } while (0)
> +
> +#define __FP_FRAC_SUB_4(r3, r2, r1, r0, x3, x2, x1, x0, y3, y2, y1, y0)        \
> +       do {                                                                   \
> +               int _c1, _c2, _c3;                                             \
> +               r0 = x0 - y0;                                                  \
> +               _c1 = r0 > x0;                                                 \
> +               r1 = x1 - y1;                                                  \
> +               _c2 = r1 > x1;                                                 \
> +               r1 -= _c1;                                                     \
> +               _c2 |= _c1 && (y1 == x1);                                      \
> +               r2 = x2 - y2;                                                  \
> +               _c3 = r2 > x2;                                                 \
> +               r2 -= _c2;                                                     \
> +               _c3 |= _c2 && (y2 == x2);                                      \
> +               r3 = x3 - y3 - _c3;                                            \
> +       } while (0)
> +
> +#define _FP_FMA(fs, wc, dwc, R, X, Y, Z)                                                \
> +       do {                                                                            \
> +               __label__ done_fma;                                                     \
> +               FP_DECL_##fs(_FP_FMA_T);                                                \
> +               _FP_FMA_T##_s = X##_s ^ Y##_s;                                          \
> +               _FP_FMA_T##_e = X##_e + Y##_e + 1;                                      \
> +               switch (_FP_CLS_COMBINE(X##_c, Y##_c)) {                                \
> +               case _FP_CLS_COMBINE(FP_CLS_NORMAL, FP_CLS_NORMAL):                     \
> +                       switch (Z##_c) {                                                \
> +                       case FP_CLS_INF:                                                \
> +                       case FP_CLS_NAN:                                                \
> +                               R##_s = Z##_s;                                          \
> +                               _FP_FRAC_COPY_##wc(R, Z);                               \
> +                               R##_c = Z##_c;                                          \
> +                               break;                                                  \
> +                       case FP_CLS_ZERO:                                               \
> +                               R##_c = FP_CLS_NORMAL;                                  \
> +                               R##_s = _FP_FMA_T##_s;                                  \
> +                               R##_e = _FP_FMA_T##_e;                                  \
> +                               _FP_MUL_MEAT_##fs(R, X, Y);                             \
> +                               if (_FP_FRAC_OVERP_##wc(fs, R))                         \
> +                                       _FP_FRAC_SRS_##wc(R, 1,                         \
> +                                                         _FP_WFRACBITS_##fs);          \
> +                               else                                                    \
> +                                       R##_e--;                                        \
> +                               break;                                                  \
> +                       case FP_CLS_NORMAL:;                                            \
> +                               _FP_FRAC_DECL_##dwc(_FP_FMA_TD);                        \
> +                               _FP_FRAC_DECL_##dwc(_FP_FMA_ZD);                        \
> +                               _FP_FRAC_DECL_##dwc(_FP_FMA_RD);                        \
> +                               _FP_MUL_MEAT_DW_##fs(_FP_FMA_TD, X, Y);                 \
> +                               R##_e = _FP_FMA_T##_e;                                  \
> +                               int _FP_FMA_tsh =                                       \
> +                                       _FP_FRAC_HIGHBIT_DW_##dwc(                      \
> +                                               fs, _FP_FMA_TD) == 0;                   \
> +                               _FP_FMA_T##_e -= _FP_FMA_tsh;                           \
> +                               int _FP_FMA_ediff = _FP_FMA_T##_e - Z##_e;              \
> +                               if (_FP_FMA_ediff >= 0) {                               \
> +                                       int _FP_FMA_shift =                             \
> +                                               _FP_WFRACBITS_##fs -                    \
> +                                               _FP_FMA_tsh - _FP_FMA_ediff;            \
> +                                       if (_FP_FMA_shift <=                            \
> +                                           -_FP_WFRACBITS_##fs)                        \
> +                                               _FP_FRAC_SET_##dwc(                     \
> +                                                       _FP_FMA_ZD,                     \
> +                                                       _FP_MINFRAC_##dwc);             \
> +                                       else {                                          \
> +                                               _FP_FRAC_COPY_##dwc##_##wc(             \
> +                                                       _FP_FMA_ZD, Z);                 \
> +                                               if (_FP_FMA_shift < 0)                  \
> +                                                       _FP_FRAC_SRS_##dwc(             \
> +                                                               _FP_FMA_ZD,             \
> +                                                               -_FP_FMA_shift,         \
> +                                                               _FP_WFRACBITS_DW_##fs); \
> +                                               else if (_FP_FMA_shift > 0)             \
> +                                                       _FP_FRAC_SLL_##dwc(             \
> +                                                               _FP_FMA_ZD,             \
> +                                                               _FP_FMA_shift);         \
> +                                       }                                               \
> +                                       R##_s = _FP_FMA_T##_s;                          \
> +                                       if (_FP_FMA_T##_s == Z##_s)                     \
> +                                               _FP_FRAC_ADD_##dwc(                     \
> +                                                       _FP_FMA_RD,                     \
> +                                                       _FP_FMA_TD,                     \
> +                                                       _FP_FMA_ZD);                    \
> +                                       else {                                          \
> +                                               _FP_FRAC_SUB_##dwc(                     \
> +                                                       _FP_FMA_RD,                     \
> +                                                       _FP_FMA_TD,                     \
> +                                                       _FP_FMA_ZD);                    \
> +                                               if (_FP_FRAC_NEGP_##dwc(                \
> +                                                           _FP_FMA_RD)) {              \
> +                                                       R##_s = Z##_s;                  \
> +                                                       _FP_FRAC_SUB_##dwc(             \
> +                                                               _FP_FMA_RD,             \
> +                                                               _FP_FMA_ZD,             \
> +                                                               _FP_FMA_TD);            \
> +                                               }                                       \
> +                                       }                                               \
> +                               } else {                                                \
> +                                       R##_e = Z##_e;                                  \
> +                                       R##_s = Z##_s;                                  \
> +                                       _FP_FRAC_COPY_##dwc##_##wc(_FP_FMA_ZD,          \
> +                                                                  Z);                  \
> +                                       _FP_FRAC_SLL_##dwc(                             \
> +                                               _FP_FMA_ZD,                             \
> +                                               _FP_WFRACBITS_##fs);                    \
> +                                       int _FP_FMA_shift =                             \
> +                                               -_FP_FMA_ediff - _FP_FMA_tsh;           \
> +                                       if (_FP_FMA_shift >=                            \
> +                                           _FP_WFRACBITS_DW_##fs)                      \
> +                                               _FP_FRAC_SET_##dwc(                     \
> +                                                       _FP_FMA_TD,                     \
> +                                                       _FP_MINFRAC_##dwc);             \
> +                                       else if (_FP_FMA_shift > 0)                     \
> +                                               _FP_FRAC_SRS_##dwc(                     \
> +                                                       _FP_FMA_TD,                     \
> +                                                       _FP_FMA_shift,                  \
> +                                                       _FP_WFRACBITS_DW_##fs);         \
> +                                       if (Z##_s == _FP_FMA_T##_s)                     \
> +                                               _FP_FRAC_ADD_##dwc(                     \
> +                                                       _FP_FMA_RD,                     \
> +                                                       _FP_FMA_ZD,                     \
> +                                                       _FP_FMA_TD);                    \
> +                                       else                                            \
> +                                               _FP_FRAC_SUB_##dwc(                     \
> +                                                       _FP_FMA_RD,                     \
> +                                                       _FP_FMA_ZD,                     \
> +                                                       _FP_FMA_TD);                    \
> +                               }                                                       \
> +                               if (_FP_FRAC_ZEROP_##dwc(_FP_FMA_RD)) {                 \
> +                                       if (_FP_FMA_T##_s == Z##_s)                     \
> +                                               R##_s = Z##_s;                          \
> +                                       else                                            \
> +                                               R##_s = (FP_ROUNDMODE ==                \
> +                                                        FP_RND_MINF);                  \
> +                                       _FP_FRAC_SET_##wc(R,                            \
> +                                                         _FP_ZEROFRAC_##wc);           \
> +                                       R##_c = FP_CLS_ZERO;                            \
> +                               } else {                                                \
> +                                       int _FP_FMA_rlz;                                \
> +                                       _FP_FRAC_CLZ_##dwc(_FP_FMA_rlz,                 \
> +                                                          _FP_FMA_RD);                 \
> +                                       _FP_FMA_rlz -= _FP_WFRACXBITS_DW_##fs;          \
> +                                       R##_e -= _FP_FMA_rlz;                           \
> +                                       int _FP_FMA_shift =                             \
> +                                               _FP_WFRACBITS_##fs -                    \
> +                                               _FP_FMA_rlz;                            \
> +                                       if (_FP_FMA_shift > 0)                          \
> +                                               _FP_FRAC_SRS_##dwc(                     \
> +                                                       _FP_FMA_RD,                     \
> +                                                       _FP_FMA_shift,                  \
> +                                                       _FP_WFRACBITS_DW_##fs);         \
> +                                       else if (_FP_FMA_shift < 0)                     \
> +                                               _FP_FRAC_SLL_##dwc(                     \
> +                                                       _FP_FMA_RD,                     \
> +                                                       -_FP_FMA_shift);                \
> +                                       _FP_FRAC_COPY_##wc##_##dwc(                     \
> +                                               R, _FP_FMA_RD);                         \
> +                                       R##_c = FP_CLS_NORMAL;                          \
> +                               }                                                       \
> +                               break;                                                  \
> +                       }                                                               \
> +                       goto done_fma;                                                  \
> +               case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_NAN):                           \
> +                       _FP_CHOOSENAN(fs, wc, _FP_FMA_T, X, Y, '*');                    \
> +                       break;                                                          \
> +               case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_NORMAL):                        \
> +               case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_INF):                           \
> +               case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_ZERO):                          \
> +                       _FP_FMA_T##_s = X##_s;                                          \
> +               case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_INF):                           \
> +               case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_NORMAL):                        \
> +               case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_NORMAL):                       \
> +               case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_ZERO):                         \
> +                       _FP_FRAC_COPY_##wc(_FP_FMA_T, X);                               \
> +                       _FP_FMA_T##_c = X##_c;                                          \
> +                       break;                                                          \
> +               case _FP_CLS_COMBINE(FP_CLS_NORMAL, FP_CLS_NAN):                        \
> +               case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_NAN):                           \
> +               case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_NAN):                          \
> +                       _FP_FMA_T##_s = Y##_s;                                          \
> +               case _FP_CLS_COMBINE(FP_CLS_NORMAL, FP_CLS_INF):                        \
> +               case _FP_CLS_COMBINE(FP_CLS_NORMAL, FP_CLS_ZERO):                       \
> +                       _FP_FRAC_COPY_##wc(_FP_FMA_T, Y);                               \
> +                       _FP_FMA_T##_c = Y##_c;                                          \
> +                       break;                                                          \
> +               case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_ZERO):                          \
> +               case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_INF):                          \
> +                       _FP_FMA_T##_s = _FP_NANSIGN_##fs;                               \
> +                       _FP_FMA_T##_c = FP_CLS_NAN;                                     \
> +                       _FP_FRAC_SET_##wc(_FP_FMA_T, _FP_NANFRAC_##fs);                 \
> +                       FP_SET_EXCEPTION(FP_EX_INVALID |                                \
> +                                        FP_EX_INVALID_IMZ_FMA);                        \
> +                       break;                                                          \
> +               default:                                                                \
> +                       abort();                                                        \
> +               }                                                                       \
> +               /* T = X * Y is zero, infinity or NaN.  */                              \
> +               switch (_FP_CLS_COMBINE(_FP_FMA_T##_c, Z##_c)) {                        \
> +               case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_NAN):                           \
> +                       _FP_CHOOSENAN(fs, wc, R, _FP_FMA_T, Z, '+');                    \
> +                       break;                                                          \
> +               case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_NORMAL):                        \
> +               case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_INF):                           \
> +               case _FP_CLS_COMBINE(FP_CLS_NAN, FP_CLS_ZERO):                          \
> +               case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_NORMAL):                        \
> +               case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_ZERO):                          \
> +                       R##_s = _FP_FMA_T##_s;                                          \
> +                       _FP_FRAC_COPY_##wc(R, _FP_FMA_T);                               \
> +                       R##_c = _FP_FMA_T##_c;                                          \
> +                       break;                                                          \
> +               case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_NAN):                           \
> +               case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_NAN):                          \
> +               case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_NORMAL):                       \
> +               case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_INF):                          \
> +                       R##_s = Z##_s;                                                  \
> +                       _FP_FRAC_COPY_##wc(R, Z);                                       \
> +                       R##_c = Z##_c;                                                  \
> +                       R##_e = Z##_e;                                                  \
> +                       break;                                                          \
> +               case _FP_CLS_COMBINE(FP_CLS_INF, FP_CLS_INF):                           \
> +                       if (_FP_FMA_T##_s == Z##_s) {                                   \
> +                               R##_s = Z##_s;                                          \
> +                               _FP_FRAC_COPY_##wc(R, Z);                               \
> +                               R##_c = Z##_c;                                          \
> +                       } else {                                                        \
> +                               R##_s = _FP_NANSIGN_##fs;                               \
> +                               R##_c = FP_CLS_NAN;                                     \
> +                               _FP_FRAC_SET_##wc(R, _FP_NANFRAC_##fs);                 \
> +                               FP_SET_EXCEPTION(FP_EX_INVALID |                        \
> +                                                FP_EX_INVALID_ISI);                    \
> +                       }                                                               \
> +                       break;                                                          \
> +               case _FP_CLS_COMBINE(FP_CLS_ZERO, FP_CLS_ZERO):                         \
> +                       if (_FP_FMA_T##_s == Z##_s)                                     \
> +                               R##_s = Z##_s;                                          \
> +                       else                                                            \
> +                               R##_s = (FP_ROUNDMODE == FP_RND_MINF);                  \
> +                       _FP_FRAC_COPY_##wc(R, Z);                                       \
> +                       R##_c = Z##_c;                                                  \
> +                       break;                                                          \
> +               default:                                                                \
> +                       abort();                                                        \
> +               }                                                                       \
> +       done_fma:;                                                                      \
> +       } while (0)
> +
> +#if _FP_W_TYPE_SIZE < 64
> +#define FP_FMA_S(R, X, Y, Z) _FP_FMA(S, 1, 2, R, X, Y, Z)
> +#define FP_FMA_D(R, X, Y, Z) _FP_FMA(D, 2, 4, R, X, Y, Z)
> +#else
> +#define FP_FMA_S(R, X, Y, Z) _FP_FMA(S, 1, 1, R, X, Y, Z)
> +#define FP_FMA_D(R, X, Y, Z) _FP_FMA(D, 1, 2, R, X, Y, Z)
> +#endif
> diff --git a/arch/csky/include/uapi/asm/siginfo.h b/arch/csky/include/uapi/asm/siginfo.h
> new file mode 100644
> index 000000000000..435701a193a6
> --- /dev/null
> +++ b/arch/csky/include/uapi/asm/siginfo.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
/* SPDX-License-Identifier: GPL-2.0 */


> +#ifndef _CSKY_SIGINFO_H
> +#define _CSKY_SIGINFO_H
> +
> +#include <asm-generic/siginfo.h>
> +
> +#undef __SI_FAULT
> +#define __SI_FAULT     -2
> +
> +#endif
> diff --git a/arch/csky/math-emu/Makefile b/arch/csky/math-emu/Makefile
> new file mode 100644
> index 000000000000..9fea02749367
> --- /dev/null
> +++ b/arch/csky/math-emu/Makefile
> @@ -0,0 +1,13 @@
> +#
> +# Makefile for csky-specific math emulate.
> +#
> +
> +ccflags-y := -w
> +
> +obj-$(CONFIG_CPU_HAS_MATHEMU)          += math-emu.o
> +
> +ifneq ($(CONFIG_CPU_CK860),y)
> +math-emu-y                     += math.o fp810.o
> +else
> +math-emu-y                     += math.o fp860.o
> +endif
> diff --git a/arch/csky/math-emu/fp810.c b/arch/csky/math-emu/fp810.c
> new file mode 100644
> index 000000000000..9bc89b30d86b
> --- /dev/null
> +++ b/arch/csky/math-emu/fp810.c
> @@ -0,0 +1,2420 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * CSKY  860  MATHEMU
> + *
> + * Copyright (C) 2021 Hangzhou C-SKY Microsystems co.,ltd.
> + *
> + *    Authors: Li Weiwei <liweiwei@iscas.ac.cn>
> + *             Wang Junqiang <wangjunqiang@iscas.ac.cn>
> + *
> + */
Remove all above, and just:
/* SPDX-License-Identifier: GPL-2.0 */

> +#include <linux/uaccess.h>
> +#include "sfp-util.h"
> +#include <math-emu/soft-fp.h>
> +#include "sfp-fixs.h"
> +#include <math-emu/single.h>
> +#include <math-emu/double.h>
> +#include "fp810.h"
> +
> +/*
> + * z = |x|
> + */
> +void
> +FPUV2_OP_FUNC(fabsd)
> +{
> +       union float64_components u;
> +
> +       DEBUG_DP_U_START(fabsd);
> +       u.f64 = get_float64(x);
> +#ifdef __CSKYBE__
> +       u.i[0] &= 0x7fffffff;
> +#else
> +       u.i[1] &= 0x7fffffff;
> +#endif
> +       set_float64(u.f64, z);
> +       DEBUG_DP_U_END(fabsd, u.f64);
> +}
> +
> +void
> +FPUV2_OP_FUNC(fabsm)
> +{
> +       union float64_components u;
> +
> +       DEBUG_DP_U_START(fabsm);
> +       u.f64 = get_float64(x);
> +       u.i[0] &= 0x7fffffff;
> +       u.i[1] &= 0x7fffffff;
> +       set_float64(u.f64, z);
> +       DEBUG_DP_U_END(fabsm, u.f64);
> +}
> +
> +void
> +FPUV2_OP_FUNC(fabss)
> +{
> +       unsigned int result;
> +
> +       DEBUG_SP_U_START(fabss);
> +       result = get_float32(x) & 0x7fffffff;
> +       set_float32(result, z);
> +       DEBUG_SP_U_END(fabss);
> +}
> +
> +/*
> + * z = x + y
> + */
> +void
> +FPUV2_OP_FUNC(faddd)
> +{
> +       FPU_INSN_START(DR, DR, DI);
> +       DEBUG_DP(faddd);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +
> +       FP_ADD_D(R, A, B);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(faddd);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(faddm)
> +{
> +       FPU_INSN_START(DR, DR, DI);
> +       DEBUG_DP(faddm);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       FP_ADD_S(R, A, B);
> +       FP_PACK_SP(vrz, R);
> +
> +       FP_UNPACK_SP(A, vrx + 4);
> +       FP_UNPACK_SP(B, vry + 4);
> +
> +       FP_ADD_S(R, A, B);
> +
> +       FP_PACK_SP(vrz + 4, R);
> +
> +       DEBUG_DP_END(faddm);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fadds)
> +{
> +       FPU_INSN_START(SR, SR, SI);
> +       DEBUG_SP(fadds);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       FP_ADD_S(R, A, B);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fadds);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * fpsr.c = (x >= y) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmphsd)
> +{
> +       int result;
> +
> +       FPU_INSN_START(DR, DR, DN);
> +       DEBUG_CMP(fcmphsd);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +
> +       FP_CMP_D(result, A, B, 3);
> +       if  ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +           result = 0;
> +       } else
> +               result = ((result == 0) || (result == 1)) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmphsd);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x >= y) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmphss)
> +{
> +       int result;
> +
> +       FPU_INSN_START(SR, SR, SN);
> +       DEBUG_CMP(fcmphss);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       FP_CMP_S(result, A, B, 3);
> +       if  ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +           result = 0;
> +       } else
> +               result = ((result == 0) || (result == 1)) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmphss);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x < y) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmpltd)
> +{
> +       int result;
> +
> +       FPU_INSN_START(DR, DR, DN);
> +       DEBUG_CMP(fcmpltd);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +
> +       FP_CMP_D(result, A, B, 3);
> +       if  ((result == 3) && (((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN)))) {
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +           result = 0;
> +       } else
> +               result = (result == -1) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpltd);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x < y) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmplts)
> +{
> +       int result;
> +
> +       FPU_INSN_START(SR, SR, SN);
> +       DEBUG_CMP(fcmplts);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       FP_CMP_S(result, A, B, 3);
> +       if  ((result == 3) && ((A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN))) {
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +           result = 0;
> +       } else
> +               result = (result == -1) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmplts);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x == y) ? 0 : 1
> + */
> +void
> +FPUV2_OP_FUNC(fcmpned)
> +{
> +       int result;
> +
> +       FPU_INSN_START(DR, DR, DN);
> +       DEBUG_CMP(fcmpned);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +
> +       FP_CMP_D(result, A, B, 3);
> +       if  ((result == 3) && (FP_ISSIGNAN_D(A) || FP_ISSIGNAN_D(B))) {
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +           result = 1;
> +       } else
> +               result = (result != 0) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpned);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x == y) ? 0 : 1
> + */
> +void
> +FPUV2_OP_FUNC(fcmpnes)
> +{
> +       int result;
> +
> +       FPU_INSN_START(SR, SR, SN);
> +       DEBUG_CMP(fcmpnes);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       FP_CMP_S(result, A, B, 3);
> +       if ((result == 3) && (FP_ISSIGNAN_S(A) || FP_ISSIGNAN_S(B))) {
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +           result = 1;
> +       } else
> +               result = (result != 0) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpnes);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x == NaN || y == NaN) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmpuod)
> +{
> +       int result;
> +
> +       FPU_INSN_START(DR, DR, DN);
> +       DEBUG_CMP(fcmpuod);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +
> +       result = (A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpuod);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x == NaN || y == NaN) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmpuos)
> +{
> +       int result;
> +
> +       FPU_INSN_START(SR, SR, SN);
> +       DEBUG_CMP(fcmpuos);
> +
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       result = (A_c == FP_CLS_NAN) || (B_c == FP_CLS_NAN) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpuos);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x >= 0) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmpzhsd)
> +{
> +       int result;
> +       void *constant;
> +
> +       FPU_INSN_START(DR, DN, DN);
> +       DP_CONST_DATA(constant, 0);
> +       DEBUG_CMP_U(fcmpzhsd);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, constant);
> +
> +       FP_CMP_D(result, A, B, 3);
> +       if ((result == 3) && (A_c == FP_CLS_NAN)) {
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +           result = 0;
> +       } else
> +               result = ((result == 0) || (result == 1)) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpzhsd);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x >= 0) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmpzhss)
> +{
> +       int result;
> +       void *constant;
> +
> +       FPU_INSN_START(SR, SN, SN);
> +       SP_CONST_DATA(constant, 0);
> +       DEBUG_CMP_U(fcmpzhss);
> +
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, constant);
> +
> +       FP_CMP_S(result, A, B, 3);
> +       if  ((result == 3) && (A_c == FP_CLS_NAN)) {
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +           result = 0;
> +       } else
> +               result = ((result == 0) || (result == 1)) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpzhss);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x <= 0) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmpzlsd)
> +{
> +       int result;
> +       void *constant;
> +
> +       FPU_INSN_START(DR, DN, DN);
> +       DP_CONST_DATA(constant, 0);
> +       DEBUG_CMP_U(fcmpzlsd);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, constant);
> +
> +       FP_CMP_D(result, A, B, 3);
> +       if  ((result == 3) && (FP_ISSIGNAN_D(A))) {
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +           result = 0;
> +       } else
> +               result = ((result == 0) || (result == -1)) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpzlsd);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x <= 0) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmpzlss)
> +{
> +       int result;
> +       void *constant;
> +
> +       FPU_INSN_START(SR, SN, SN);
> +       SP_CONST_DATA(constant, 0);
> +       DEBUG_CMP_U(fcmpzlss);
> +
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, constant);
> +
> +       FP_CMP_S(result, A, B, 3);
> +       if  ((result == 3) && (A_c == FP_CLS_NAN)) {
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +           result = 0;
> +       } else
> +               result = ((result == 0) || (result == -1)) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpzlss);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x != 0) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmpzned)
> +{
> +       int result;
> +       void *constant;
> +
> +       FPU_INSN_START(DR, DN, DN);
> +       DP_CONST_DATA(constant, 0);
> +       DEBUG_CMP_U(fcmpzned);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, constant);
> +
> +       FP_CMP_D(result, A, B, 3);
> +       if  ((result == 3) && (FP_ISSIGNAN_D(A))) {
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +           result = 1;
> +       } else
> +               result = (result != 0) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpzned);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x != 0) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmpznes)
> +{
> +       int result;
> +       void *constant;
> +
> +       FPU_INSN_START(SR, SN, SN);
> +       SP_CONST_DATA(constant, 0);
> +       DEBUG_CMP_U(fcmpznes);
> +
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, constant);
> +
> +       FP_CMP_S(result, A, B, 3);
> +       if  ((result == 3) && (FP_ISSIGNAN_S(A))) {
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +           result = 1;
> +       } else
> +               result = (result != 0) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpznes);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x == NaN) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmpzuod)
> +{
> +       int result;
> +
> +       FPU_INSN_START(DR, DN, DN);
> +       DEBUG_CMP_U(fcmpzuod);
> +       FP_DECL_D(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +
> +       result = (A_c == FP_CLS_NAN) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpzuod);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * fpsr.c = (x == NaN) ? 1 : 0
> + */
> +void
> +FPUV2_OP_FUNC(fcmpzuos)
> +{
> +       int result;
> +
> +       FPU_INSN_START(SR, SN, SN);
> +       DEBUG_CMP_U(fcmpzuos);
> +
> +       FP_DECL_S(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +
> +       result = (A_c == FP_CLS_NAN) ? 1 : 0;
> +
> +       DEBUG_FLAG_END(fcmpzuos);
> +       SET_FLAG_END;
> +}
> +
> +/*
> + * z = x / y
> + */
> +void
> +FPUV2_OP_FUNC(fdivd)
> +{
> +       FPU_INSN_START(DR, DR, DI);
> +       DEBUG_DP(fdivd);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +
> +       FP_DIV_D(R, A, B);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(fdivd);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fdivs)
> +{
> +       FPU_INSN_START(SR, SR, SI);
> +       DEBUG_SP(fdivs);
> +
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       FP_DIV_S(R, A, B);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fdivs);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = (float)x
> + */
> +void
> +FPUV2_OP_FUNC(fdtos)
> +{
> +       FPU_INSN_START(DR, DN, SI);
> +       DEBUG_SP_U(fdtos);
> +       FP_DECL_D(A);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +
> +       FP_CONV(S, D, 1, 2, R, A);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fdtos);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = (int)x
> + */
> +void
> +FPUV2_OP_FUNC(fdtosi_rn)
> +{
> +       int r;
> +
> +       FPU_INSN_START(DR, DN, SI);
> +       DEBUG_DP2SP(fdtosi, rn);
> +       FP_DECL_D(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_NEAREST);
> +       if  (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if  (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_D(r, A, 32, 1);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +
> +       DEBUG_SP_END(fdtosi_rn);
> +       FPU_INSN_SP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fdtosi_rz)
> +{
> +       int r;
> +
> +       FPU_INSN_START(DR, DN, SI);
> +       DEBUG_DP2SP(fdtosi, rz);
> +       FP_DECL_D(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_ZERO);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if  (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_D(r, A, 32, 1);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +
> +       DEBUG_SP_END(fdtosi_rz);
> +       FPU_INSN_SP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fdtosi_rpi)
> +{
> +       int r;
> +
> +       FPU_INSN_START(DR, DN, SI);
> +       DEBUG_DP2SP(fdtosi, rpi);
> +       FP_DECL_D(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_PINF);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_D(r, A, 32, 1);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fdtosi_rpi);
> +       FPU_INSN_SP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fdtosi_rni)
> +{
> +       int r;
> +
> +       FPU_INSN_START(DR, DN, SI);
> +       DEBUG_DP2SP(fdtosi, rni);
> +       FP_DECL_D(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_MINF);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_D(r, A, 32, 1);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fdtosi_rni);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = (unsigned int)x
> + */
> +void
> +FPUV2_OP_FUNC(fdtoui_rn)
> +{
> +       unsigned int r;
> +
> +       FPU_INSN_START(DR, DN, SI);
> +       DEBUG_DP2SP(fdtoui, rn);
> +       FP_DECL_D(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_NEAREST);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_D(r, A, 32, 0);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fdtoui_rn);
> +       FPU_INSN_SP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fdtoui_rz)
> +{
> +       unsigned int r;
> +
> +       FPU_INSN_START(DR, DN, SI);
> +       DEBUG_DP2SP(fdtoui, rz);
> +       FP_DECL_D(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_ZERO);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_D(r, A, 32, 0);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fdtoui_rz);
> +       FPU_INSN_SP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fdtoui_rpi)
> +{
> +       unsigned int r;
> +
> +       FPU_INSN_START(DR, DN, SI);
> +       DEBUG_DP2SP(fdtoui, rpi);
> +       FP_DECL_D(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_PINF);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_D(r, A, 32, 0);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fdtoui_rpi);
> +       FPU_INSN_SP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fdtoui_rni)
> +{
> +       unsigned int r;
> +
> +       FPU_INSN_START(DR, DN, SI);
> +       DEBUG_DP2SP(fdtoui, rni);
> +       FP_DECL_D(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_MINF);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_D(r, A, 32, 0);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fdtoui_rni);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z += x * y
> + */
> +void
> +FPUV2_OP_FUNC(fmacd)
> +{
> +       FPU_INSN_START(DR, DR, DR);
> +       DEBUG_DP_MAC(fmacd);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_D(C);
> +       FP_DECL_D(T);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +       FP_UNPACK_DP(C, vrz);
> +
> +       FP_MUL_D(T, A, B);
> +       MAC_INTERNAL_ROUND_DP;
> +       FP_ADD_D(R, T, C);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(fmacd);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fmacm)
> +{
> +       FPU_INSN_START(DR, DR, DR);
> +       DEBUG_DP_MAC(fmacm);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(C);
> +       FP_DECL_S(T);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +       FP_UNPACK_SP(C, vrz);
> +
> +       FP_MUL_S(T, A, B);
> +       MAC_INTERNAL_ROUND_SP;
> +       FP_ADD_S(R, T, C);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       FP_UNPACK_SP(A, vrx + 4);
> +       FP_UNPACK_SP(B, vry + 4);
> +       FP_UNPACK_SP(C, vrz + 4);
> +
> +       FP_MUL_S(T, A, B);
> +       MAC_INTERNAL_ROUND_SP;
> +       FP_ADD_S(R, T, C);
> +
> +       FP_PACK_SP(vrz + 4, R);
> +       DEBUG_DP_END(fmacm);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fmacs)
> +{
> +       FPU_INSN_START(SR, SR, SR);
> +       DEBUG_SP_MAC(fmacs);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(C);
> +       FP_DECL_S(T);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +       FP_UNPACK_SP(C, vrz);
> +
> +       FP_MUL_S(T, A, B);
> +       MAC_INTERNAL_ROUND_SP;
> +       FP_ADD_S(R, T, C);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fmacs);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = x[63:32]
> + */
> +void
> +FPUV2_OP_FUNC(fmfvrh)
> +{
> +       union float64_components op_val1;
> +       unsigned int result;
> +
> +       z = inst_data->inst & 0x1f;
> +       DEBUG_SP_INT_START(fmfvrh);
> +       x = CSKY_INSN_RX(inst_data->inst);
> +       op_val1.f64 = get_float64(x);
> +
> +#ifdef __CSKYBE__
> +       result = (unsigned int)op_val1.i[0];
> +#else
> +       result = (unsigned int)op_val1.i[1];
> +#endif
> +
> +       set_uint32(result, z, inst_data);
> +       DEBUG_SP_INT_END(fmfvrh);
> +}
> +
> +/*
> + * z = x[31:0]
> + */
> +void
> +FPUV2_OP_FUNC(fmfvrl)
> +{
> +       union float64_components op_val1;
> +       unsigned int result;
> +
> +       z = inst_data->inst & 0x1f;
> +       DEBUG_SP_INT_START(fmfvrl);
> +       x = CSKY_INSN_RX(inst_data->inst);
> +       op_val1.f64 = get_float64(x);
> +
> +#ifdef __CSKYBE__
> +       result = (unsigned int)op_val1.i[1];
> +#else
> +       result = (unsigned int)op_val1.i[0];
> +#endif
> +
> +       set_uint32(result, z, inst_data);
> +       DEBUG_SP_INT_END(fmfvrl);
> +}
> +
> +/*
> + * z = x
> + */
> +void
> +FPUV2_OP_FUNC(fmovd)
> +{
> +       unsigned long long result;
> +
> +       DEBUG_DP_U_START(fmovd);
> +       result = get_float64(x);
> +
> +       set_float64(result, z);
> +       DEBUG_DP_U_END(fmovd, result);
> +}
> +
> +void
> +FPUV2_OP_FUNC(fmovm)
> +{
> +       unsigned long long result;
> +
> +       DEBUG_DP_U_START(fmovm);
> +       result = get_float64(x);
> +
> +       set_float64(result, z);
> +       DEBUG_DP_U_END(fmovm, result);
> +}
> +
> +void
> +FPUV2_OP_FUNC(fmovs)
> +{
> +       unsigned int result;
> +
> +       DEBUG_SP_U_START(fmovs);
> +       result = get_float32(x);
> +
> +       set_float32(result, z);
> +       DEBUG_SP_U_END(fmovs);
> +}
> +
> +/*
> + * z = x * y - z
> + */
> +void
> +FPUV2_OP_FUNC(fmscd)
> +{
> +       FPU_INSN_START(DR, DR, DR);
> +       DEBUG_DP_MAC(fmscd);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_D(C);
> +       FP_DECL_D(T);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +       FP_UNPACK_DP(C, vrz);
> +
> +       FP_MUL_D(T, A, B);
> +       MAC_INTERNAL_ROUND_DP;
> +       FP_SUB_D(R, T, C);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(fmscd);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fmscm)
> +{
> +       FPU_INSN_START(DR, DR, DI);
> +       DEBUG_DP(fmscm);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(C);
> +       FP_DECL_S(T);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +       FP_UNPACK_SP(C, vrz);
> +
> +       FP_MUL_S(T, A, B);
> +       MAC_INTERNAL_ROUND_SP;
> +       FP_SUB_S(R, T, C);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       FP_UNPACK_SP(A, vrx + 4);
> +       FP_UNPACK_SP(B, vry + 4);
> +       FP_UNPACK_SP(C, vrz + 4);
> +
> +       FP_MUL_S(T, A, B);
> +       MAC_INTERNAL_ROUND_SP;
> +       FP_SUB_S(R, T, C);
> +
> +       FP_PACK_SP(vrz + 4, R);
> +
> +       DEBUG_DP_END(fmscm);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fmscs)
> +{
> +       FPU_INSN_START(SR, SR, SR);
> +       DEBUG_SP_MAC(fmscs);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(C);
> +       FP_DECL_S(T);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +       FP_UNPACK_SP(C, vrz);
> +
> +       FP_MUL_S(T, A, B);
> +       MAC_INTERNAL_ROUND_SP;
> +       FP_SUB_S(R, T, C);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fmscs);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z[63:32] = x
> + */
> +void
> +FPUV2_OP_FUNC(fmtvrh)
> +{
> +       union float64_components result;
> +
> +       x = CSKY_INSN_RX(inst_data->inst);
> +#ifdef __CSKYBE__
> +       result.i[0] = (unsigned int)get_uint32(x, inst_data);
> +       set_float32h(result.i[0], z);
> +#else
> +       result.i[1] = (unsigned int)get_uint32(x, inst_data);
> +       set_float32h(result.i[1], z);
> +#endif
> +}
> +
> +/*
> + * z[31:0] = x
> + */
> +void
> +FPUV2_OP_FUNC(fmtvrl)
> +{
> +       union float64_components result;
> +
> +       x = CSKY_INSN_RX(inst_data->inst);
> +#ifdef __CSKYBE__
> +       result.i[1] = (unsigned int)get_uint32(x, inst_data);
> +       set_float32(result.i[1], z);
> +#else
> +       result.i[0] = (unsigned int)get_uint32(x, inst_data);
> +       set_float32(result.i[0], z);
> +#endif
> +}
> +
> +/*
> + * z = x * y
> + */
> +void
> +FPUV2_OP_FUNC(fmuld)
> +{
> +       FPU_INSN_START(DR, DR, DI);
> +       DEBUG_DP(fmuld);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +
> +       FP_MUL_D(R, A, B);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(fmuld);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fmulm)
> +{
> +       FPU_INSN_START(DR, DR, DI);
> +       DEBUG_DP(fmulm);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       FP_MUL_S(R, A, B);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       FP_UNPACK_SP(A, vrx + 4);
> +       FP_UNPACK_SP(B, vry + 4);
> +
> +       FP_MUL_S(R, A, B);
> +
> +       FP_PACK_SP(vrz + 4, R);
> +
> +       DEBUG_DP_END(fmulm);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fmuls)
> +{
> +
> +       FPU_INSN_START(SR, SR, SI);
> +       DEBUG_SP(fmuls);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       FP_MUL_S(R, A, B);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fmuls);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = -x
> + */
> +void
> +FPUV2_OP_FUNC(fnegd)
> +{
> +       union float64_components u;
> +
> +       DEBUG_DP_U_START(fnegd);
> +       u.f64 = get_float64(x);
> +#ifdef __CSKYBE__
> +       u.i[0] ^= 0x80000000;
> +#else
> +       u.i[1] ^= 0x80000000;
> +#endif
> +       set_float64(u.f64, z);
> +       DEBUG_DP_U_END(fnegd, u.f64);
> +}
> +
> +void
> +FPUV2_OP_FUNC(fnegm)
> +{
> +       union float64_components u;
> +
> +       DEBUG_DP_U_START(fnegm);
> +       u.f64 = get_float64(x);
> +       u.i[0] ^= 0x80000000;
> +       u.i[1] ^= 0x80000000;
> +       set_float64(u.f64, z);
> +       DEBUG_DP_U_END(fnegm, u.f64);
> +}
> +
> +void
> +FPUV2_OP_FUNC(fnegs)
> +{
> +       unsigned int result;
> +
> +       DEBUG_SP_U_START(fnegs);
> +       result = get_float32(x) ^ 0x80000000;
> +       set_float32(result, z);
> +       DEBUG_SP_U_END(fnegs);
> +}
> +
> +/*
> + * z -= x * y
> + */
> +void
> +FPUV2_OP_FUNC(fnmacd)
> +{
> +       FPU_INSN_START(DR, DR, DR);
> +       DEBUG_DP_MAC(fnmacd);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_D(C);
> +       FP_DECL_D(T);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +       FP_UNPACK_DP(C, vrz);
> +
> +       FP_MUL_D(T, A, B);
> +       MAC_INTERNAL_ROUND_DP;
> +       FP_SUB_D(R, C, T);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(fnmacd);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fnmacm)
> +{
> +       FPU_INSN_START(DR, DR, DR);
> +       DEBUG_DP_MAC(fnmacm);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(C);
> +       FP_DECL_S(T);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +       FP_UNPACK_SP(C, vrz);
> +
> +       FP_MUL_S(T, A, B);
> +       MAC_INTERNAL_ROUND_SP;
> +       FP_SUB_S(R, C, T);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       FP_UNPACK_SP(A, vrx + 4);
> +       FP_UNPACK_SP(B, vry + 4);
> +       FP_UNPACK_SP(C, vrz + 4);
> +
> +       FP_MUL_S(T, A, B);
> +
> +       FP_SUB_S(R, C, T);
> +
> +       FP_PACK_SP(vrz + 4, R);
> +
> +       DEBUG_DP_END(fnmacm);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fnmacs)
> +{
> +       FPU_INSN_START(SR, SR, SR);
> +       DEBUG_SP_MAC(fnmacs);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(C);
> +       FP_DECL_S(T);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +       FP_UNPACK_SP(C, vrz);
> +
> +       FP_MUL_S(T, A, B);
> +       MAC_INTERNAL_ROUND_SP;
> +       FP_SUB_S(R, C, T);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fnmacs);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = -z -x * y
> + */
> +void
> +FPUV2_OP_FUNC(fnmscd)
> +{
> +       FPU_INSN_START(DR, DR, DR);
> +       DEBUG_DP_MAC(fnmscd);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_D(C);
> +       FP_DECL_D(T);
> +       FP_DECL_D(N);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +       FP_UNPACK_DP(C, vrz);
> +
> +       FP_MUL_D(T, A, B);
> +       MAC_INTERNAL_ROUND_DP;
> +       FP_NEG_D(N, C);
> +       FP_SUB_D(R, N, T);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(fnmscd);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fnmscm)
> +{
> +       FPU_INSN_START(DR, DR, DR);
> +       DEBUG_DP_MAC(fnmscm);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(C);
> +       FP_DECL_S(T);
> +       FP_DECL_S(N);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +       FP_UNPACK_SP(C, vrz);
> +
> +       FP_MUL_S(T, A, B);
> +       MAC_INTERNAL_ROUND_SP;
> +       FP_NEG_S(N, C);
> +       FP_SUB_S(R, N, T);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       FP_UNPACK_SP(A, vrx + 4);
> +       FP_UNPACK_SP(B, vry + 4);
> +       FP_UNPACK_SP(C, vrz + 4);
> +
> +       FP_MUL_S(T, A, B);
> +       MAC_INTERNAL_ROUND_SP;
> +       FP_NEG_S(N, C);
> +       FP_SUB_S(R, N, T);
> +
> +       FP_PACK_SP(vrz + 4, R);
> +
> +       DEBUG_DP_END(fnmscm);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fnmscs)
> +{
> +       FPU_INSN_START(SR, SR, SR);
> +       DEBUG_SP_MAC(fnmscs);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(C);
> +       FP_DECL_S(T);
> +       FP_DECL_S(N);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +       FP_UNPACK_SP(C, vrz);
> +
> +       FP_MUL_S(T, A, B);
> +       MAC_INTERNAL_ROUND_SP;
> +       FP_NEG_S(N, C);
> +       FP_SUB_S(R, N, T);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fnmscs);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = -x * y
> + */
> +void
> +FPUV2_OP_FUNC(fnmuld)
> +{
> +       FPU_INSN_START(DR, DR, DI);
> +       DEBUG_DP(fnmuld);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_D(T);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +
> +       FP_MUL_D(T, A, B);
> +       FP_NEG_D(R, T);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(fnmuld);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fnmulm)
> +{
> +       FPU_INSN_START(DR, DR, DI);
> +       DEBUG_DP(fnmulm);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(T);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       FP_MUL_S(T, A, B);
> +       FP_NEG_S(R, T);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       FP_UNPACK_SP(A, vrx + 4);
> +       FP_UNPACK_SP(B, vry + 4);
> +
> +       FP_MUL_S(T, A, B);
> +       FP_NEG_S(R, T);
> +
> +       FP_PACK_SP(vrz + 4, R);
> +
> +       DEBUG_DP_END(fnmulm);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fnmuls)
> +{
> +       FPU_INSN_START(SR, SR, SI);
> +       DEBUG_SP(fnmuls);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(T);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       FP_MUL_S(T, A, B);
> +       FP_NEG_S(R, T);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fnmuls);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = 1 / x
> + */
> +void
> +FPUV2_OP_FUNC(frecipd)
> +{
> +       void *constant;
> +
> +       FPU_INSN_START(DR, DN, DI);
> +       DEBUG_DP_U(frecipd);
> +       DP_CONST_DATA(constant, 1);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, constant);
> +
> +       FP_DIV_D(R, B, A);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(frecipd);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(frecips)
> +{
> +       void *constant;
> +       unsigned int constant_val;
> +
> +       FPU_INSN_START(SR, SN, SI);
> +       DEBUG_SP_U(frecips);
> +       constant_val = get_single_constant(1);
> +       constant = &constant_val;
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, constant);
> +
> +       FP_DIV_S(R, B, A);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(frecips);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = (double)x
> + */
> +void
> +FPUV2_OP_FUNC(fsitod)
> +{
> +       FPU_INSN_START(SR, DN, DI);
> +       DEBUG_SP2DP(fsitod);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_FROM_INT_D(R, *(int *)vrx, 32, int);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(fsitod);
> +       FPU_INSN_DP_END;
> +
> +}
> +
> +/*
> + * z = (float)x
> + */
> +void
> +FPUV2_OP_FUNC(fsitos)
> +{
> +       FPU_INSN_START(SR, SN, SI);
> +       DEBUG_SP_U(fsitos);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_FROM_INT_S(R, *(int *)vrx, 32, int);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fsitos);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = x ^ 1/2
> + */
> +void
> +FPUV2_OP_FUNC(fsqrtd)
> +{
> +       FPU_INSN_START(DR, DN, DI);
> +       DEBUG_DP_U(fsqrtd);
> +       FP_DECL_D(A);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +
> +       FP_SQRT_D(R, A);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(fsqrtd);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fsqrts)
> +{
> +       FPU_INSN_START(SR, SN, SI);
> +       DEBUG_SP_U(fsqrts);
> +       FP_DECL_S(A);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +
> +       FP_SQRT_S(R, A);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fsqrts);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = (double)x
> + */
> +void
> +FPUV2_OP_FUNC(fstod)
> +{
> +       FPU_INSN_START(SR, DN, DI);
> +       DEBUG_SP2DP(fstod);
> +       FP_DECL_S(A);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +
> +       FP_CONV(D, S, 2, 1, R, A);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(fstod);
> +       FPU_INSN_DP_END;
> +}
> +
> +/*
> + * z = (int)x
> + */
> +void
> +FPUV2_OP_FUNC(fstosi_rn)
> +{
> +       int r;
> +
> +       FPU_INSN_START(SR, SN, SI);
> +       DEBUG_SP_CVT_U(fstosi, rn);
> +       FP_DECL_S(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_NEAREST);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_S(r, A, 32, 1);
> +               FP_SET_EXCEPTION(FP_CUR_EXCEPTIONS);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fstosi_rn);
> +       FPU_INSN_SP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fstosi_rz)
> +{
> +       int r;
> +
> +       FPU_INSN_START(SR, SN, SI);
> +       DEBUG_SP_CVT_U(fstosi, rz);
> +       FP_DECL_S(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_ZERO);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_S(r, A, 32, 1);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fstosi_rz);
> +       FPU_INSN_SP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fstosi_rpi)
> +{
> +       int r;
> +
> +       FPU_INSN_START(SR, SN, SI);
> +       DEBUG_SP_CVT_U(fstosi, rpi);
> +       FP_DECL_S(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_PINF);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_S(r, A, 32, 1);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fstosi_rpi);
> +       FPU_INSN_SP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fstosi_rni)
> +{
> +       int r;
> +
> +       FPU_INSN_START(SR, SN, SI);
> +       DEBUG_SP_CVT_U(fstosi, rni);
> +       FP_DECL_S(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_MINF);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0x7fffffff : 0x80000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_S(r, A, 32, 1);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fstosi_rni);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = (unsigned int)x
> + */
> +void
> +FPUV2_OP_FUNC(fstoui_rn)
> +{
> +       unsigned int r;
> +
> +       FPU_INSN_START(SR, SN, SI);
> +       DEBUG_SP_CVT_U(fstoui, rn);
> +       FP_DECL_S(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_NEAREST);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_S(r, A, 32, 0);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fstoui_rn);
> +       FPU_INSN_SP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fstoui_rz)
> +{
> +       unsigned int r;
> +
> +       FPU_INSN_START(SR, SN, SI);
> +       DEBUG_SP_CVT_U(fstoui, rz);
> +       FP_DECL_S(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_ZERO);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_S(r, A, 32, 0);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fstoui_rz);
> +       FPU_INSN_SP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fstoui_rpi)
> +{
> +       unsigned int r;
> +
> +       FPU_INSN_START(SR, SN, SI);
> +       DEBUG_SP_CVT_U(fstoui, rpi);
> +       FP_DECL_S(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_PINF);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_S(r, A, 32, 0);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fstoui_rpi);
> +       FPU_INSN_SP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fstoui_rni)
> +{
> +       unsigned int r;
> +
> +       FPU_INSN_START(SR, SN, SI);
> +       DEBUG_SP_CVT_U(fstoui, rni);
> +       FP_DECL_S(A);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       SET_AND_SAVE_RM(FP_RND_MINF);
> +       if (A_c == FP_CLS_INF) {
> +               *(unsigned int *)vrz = (A_s == 0) ? 0xffffffff : 0x00000000;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else if (A_c == FP_CLS_NAN) {
> +               *(unsigned int *)vrz = 0xffffffff;
> +               FP_SET_EXCEPTION(FP_EX_INVALID);
> +       } else {
> +               FP_TO_INT_ROUND_S(r, A, 32, 0);
> +               *(unsigned int *)vrz = r;
> +       }
> +       RESTORE_ROUND_MODE;
> +       DEBUG_SP_END(fstoui_rni);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = x - y
> + */
> +void
> +FPUV2_OP_FUNC(fsubd)
> +{
> +       FPU_INSN_START(DR, DR, DI);
> +       DEBUG_DP(fsubd);
> +       FP_DECL_D(A);
> +       FP_DECL_D(B);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_DP(A, vrx);
> +       FP_UNPACK_DP(B, vry);
> +
> +       FP_SUB_D(R, A, B);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(fsubd);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fsubm)
> +{
> +       FPU_INSN_START(DR, DR, DI);
> +       DEBUG_DP(fsubm);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       FP_SUB_S(R, A, B);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       FP_UNPACK_SP(A, vrx + 4);
> +       FP_UNPACK_SP(B, vry + 4);
> +
> +       FP_SUB_S(R, A, B);
> +
> +       FP_PACK_SP(vrz + 4, R);
> +
> +       DEBUG_DP_END(fsubm);
> +       FPU_INSN_DP_END;
> +}
> +
> +void
> +FPUV2_OP_FUNC(fsubs)
> +{
> +       FPU_INSN_START(SR, SR, SI);
> +       DEBUG_SP(fsubs);
> +       FP_DECL_S(A);
> +       FP_DECL_S(B);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_UNPACK_SP(A, vrx);
> +       FP_UNPACK_SP(B, vry);
> +
> +       FP_SUB_S(R, A, B);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fsubs);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = (double)x
> + */
> +void
> +FPUV2_OP_FUNC(fuitod)
> +{
> +       FPU_INSN_START(SR, DN, DI);
> +       DEBUG_SP2DP(fuitod);
> +       FP_DECL_D(R);
> +       FP_DECL_EX;
> +
> +       FP_FROM_INT_D(R, *(unsigned int *)vrx, 32, int);
> +
> +       FP_PACK_DP(vrz, R);
> +
> +       DEBUG_DP_END(fuitod);
> +       FPU_INSN_DP_END;
> +
> +}
> +
> +/*
> + * z = (float)x
> + */
> +void
> +FPUV2_OP_FUNC(fuitos)
> +{
> +       FPU_INSN_START(SR, SN, SI);
> +       DEBUG_SP_U(fsitos);
> +       FP_DECL_S(R);
> +       FP_DECL_EX;
> +
> +       FP_FROM_INT_S(R, *(unsigned int *)vrx, 32, int);
> +
> +       FP_PACK_SP(vrz, R);
> +
> +       DEBUG_SP_END(fuitos);
> +       FPU_INSN_SP_END;
> +}
> +
> +/*
> + * z = *(x + imm * 4)
> + */
> +void
> +FPUV2_OP_FUNC(fldd)
> +{
> +       unsigned long long result;
> +       unsigned int imm;
> +       unsigned int op_val1;
> +
> +       op_val1 = get_uint32(x, inst_data);
> +       imm = FPUV2_LDST_IMM8(inst_data->inst);
> +       result = get_float64_from_memory(op_val1 + imm * 4);
> +
> +       set_float64(result, z);
> +}
> +
> +void
> +FPUV2_OP_FUNC(fldm)
> +{
> +       unsigned long long result;
> +       unsigned int imm;
> +       unsigned int op_val1;
> +
> +       op_val1 = get_uint32(x, inst_data);
> +       imm = FPUV2_LDST_IMM8(inst_data->inst);
> +       result = get_float64_from_memory(op_val1 + imm * 8);
> +
> +       set_float64(result, z);
> +}
> +
> +void
> +FPUV2_OP_FUNC(flds)
> +{
> +       unsigned int result;
> +       unsigned int imm;
> +       unsigned int op_val1;
> +
> +       op_val1 = get_uint32(x, inst_data);
> +       imm = FPUV2_LDST_IMM8(inst_data->inst);
> +       result = get_float32_from_memory(op_val1 + imm * 4);
> +
> +       set_float32(result, z);
> +}
> +
> +/*
> + * z = *(x)  ...
> + */
> +void
> +FPUV2_OP_FUNC(fldmd)
> +{
> +       unsigned long long result;
> +       int i;
> +       unsigned int op_val1;
> +
> +       op_val1 = get_uint32(x, inst_data);
> +       for (i = 0; i < y; i++) {
> +               result = get_float64_from_memory(op_val1 + i * 8);
> +               set_float64(result, z + i);
> +       }
> +}
> +
> +void
> +FPUV2_OP_FUNC(fldmm)
> +{
> +       unsigned long long result;
> +       int i;
> +       unsigned int op_val1;
> +
> +       op_val1 = get_uint32(x, inst_data);
> +       for (i = 0; i < y; i++) {
> +               result = get_float64_from_memory(op_val1 + i * 8);
> +               set_float64(result, z + i);
> +       }
> +}
> +
> +void
> +FPUV2_OP_FUNC(fldms)
> +{
> +       unsigned int result;
> +       int i;
> +       unsigned int op_val1;
> +
> +       op_val1 = get_uint32(x, inst_data);
> +       for (i = 0; i < y; i++) {
> +               result = get_float32_from_memory(op_val1 + i * 4);
> +               set_float32(result, z + i);
> +       }
> +}
> +
> +/*
> + * z = *(x + y * imm)
> + */
> +void
> +FPUV2_OP_FUNC(fldrd)
> +{
> +       unsigned long long result;
> +       unsigned int imm, op_val1, op_val2;
> +
> +       imm = FPUV2_LDST_R_IMM2(inst_data->inst);
> +       op_val1 = get_uint32(x, inst_data);
> +       op_val2 = get_uint32(y, inst_data);
> +       result = get_float64_from_memory(op_val1 + (op_val2 << imm));
> +
> +       set_float64(result, z);
> +}
> +
> +void
> +FPUV2_OP_FUNC(fldrm)
> +{
> +       unsigned long long result;
> +       unsigned int imm, op_val1, op_val2;
> +
> +       imm =  FPUV2_LDST_R_IMM2(inst_data->inst);
> +       op_val1 = get_uint32(x, inst_data);
> +       op_val2 = get_uint32(y, inst_data);
> +       result = get_float64_from_memory(op_val1 + (op_val2 << imm));
> +
> +       set_float64(result, z);
> +}
> +
> +void
> +FPUV2_OP_FUNC(fldrs)
> +{
> +       unsigned int result;
> +       unsigned int imm, op_val1, op_val2;
> +
> +       imm =  FPUV2_LDST_R_IMM2(inst_data->inst);
> +       op_val1 = get_uint32(x, inst_data);
> +       op_val2 = get_uint32(y, inst_data);
> +       result = get_float32_from_memory(op_val1 + (op_val2 << imm));
> +
> +       set_float32(result, z);
> +}
> +
> +/*
> + * *(x + imm * 4) = z
> + */
> +void
> +FPUV2_OP_FUNC(fstd)
> +{
> +       unsigned long long result;
> +       unsigned int imm, op_val1;
> +
> +       imm = FPUV2_LDST_IMM8(inst_data->inst);
> +       op_val1 = get_uint32(x, inst_data);
> +       result = get_float64(z);
> +
> +       set_float64_to_memory(result, op_val1 + imm * 4);
> +}
> +
> +void
> +FPUV2_OP_FUNC(fstm)
> +{
> +       unsigned long long result;
> +       unsigned int imm, op_val1;
> +
> +       imm = FPUV2_LDST_IMM8(inst_data->inst);
> +       op_val1 = get_uint32(x, inst_data);
> +       result = get_float64(z);
> +
> +       set_float64_to_memory(result, op_val1 + imm * 8);
> +}
> +
> +void
> +FPUV2_OP_FUNC(fsts)
> +{
> +       unsigned int result;
> +       unsigned int imm, op_val1;
> +
> +       imm = FPUV2_LDST_IMM8(inst_data->inst);
> +       op_val1 = get_uint32(x, inst_data);
> +       result = get_float32(z);
> +
> +       set_float32_to_memory(result, op_val1 + imm * 4);
> +}
> +
> +/*
> + * z = *(x)  ...
> + */
> +void
> +FPUV2_OP_FUNC(fstmd)
> +{
> +       unsigned long long result;
> +       int i;
> +       unsigned int op_val1;
> +
> +       op_val1 = get_uint32(x, inst_data);
> +       for (i = 0; i < y; i++) {
> +               result = get_float64(z + i);
> +               set_float64_to_memory(result, op_val1 + i * 8);
> +       }
> +}
> +
> +void
> +FPUV2_OP_FUNC(fstmm)
> +{
> +       unsigned long long result;
> +       int i;
> +       unsigned int op_val1;
> +
> +       op_val1 = get_uint32(x, inst_data);
> +       for (i = 0; i < y; i++) {
> +               result = get_float64(z + i);
> +               set_float64_to_memory(result, op_val1 + i * 8);
> +       }
> +}
> +
> +void
> +FPUV2_OP_FUNC(fstms)
> +{
> +       unsigned int result;
> +       int i;
> +       unsigned int op_val1;
> +
> +       op_val1 = get_uint32(x, inst_data);
> +       for (i = 0; i < y; i++) {
> +               result = get_float32(z + i);
> +               set_float32_to_memory(result, op_val1 + i * 4);
> +       }
> +}
> +
> +/*
> + * *(x + y * imm) = z
> + */
> +void
> +FPUV2_OP_FUNC(fstrd)
> +{
> +       unsigned long long result;
> +       unsigned int imm, op_val1, op_val2;
> +
> +       imm =  FPUV2_LDST_R_IMM2(inst_data->inst);
> +       op_val1 = get_uint32(x, inst_data);
> +       op_val2 = get_uint32(y, inst_data);
> +       result = get_float64(z);
> +
> +       set_float64_to_memory(result, op_val1 + (op_val2 << imm));
> +}
> +
> +void
> +FPUV2_OP_FUNC(fstrm)
> +{
> +       unsigned long long result;
> +       unsigned int imm, op_val1, op_val2;
> +
> +       imm =  FPUV2_LDST_R_IMM2(inst_data->inst);
> +       op_val1 = get_uint32(x, inst_data);
> +       op_val2 = get_uint32(y, inst_data);
> +       result = get_float64(z);
> +
> +       set_float64_to_memory(result, op_val1 + (op_val2 << imm));
> +}
> +
> +void
> +FPUV2_OP_FUNC(fstrs)
> +{
> +       unsigned int result;
> +       unsigned int imm, op_val1, op_val2;
> +
> +       imm =  FPUV2_LDST_R_IMM2(inst_data->inst);
> +       op_val1 = get_uint32(x, inst_data);
> +       op_val2 = get_uint32(y, inst_data);
> +       result = get_float32(z);
> +
> +       set_float32_to_memory(result, op_val1 + (op_val2 << imm));
> +}
> +
> +#define SOP_MAP(id, insn)                                                  \
> +       [id] = { FPU_OP_NAME(insn) }
> +
> +struct instruction_op_array inst_op1[0xff] = {
> +       SOP_MAP(FPUV2_FABSD, fabsd),
> +       SOP_MAP(FPUV2_FABSM, fabsm),
> +       SOP_MAP(FPUV2_FABSS, fabss),
> +       SOP_MAP(FPUV2_FADDD, faddd),
> +       SOP_MAP(FPUV2_FADDM, faddm),
> +       SOP_MAP(FPUV2_FADDS, fadds),
> +       SOP_MAP(FPUV2_FCMPHSD, fcmphsd),
> +       SOP_MAP(FPUV2_FCMPHSS, fcmphss),
> +       SOP_MAP(FPUV2_FCMPLTD, fcmpltd),
> +       SOP_MAP(FPUV2_FCMPLTS, fcmplts),
> +       SOP_MAP(FPUV2_FCMPNED, fcmpned),
> +       SOP_MAP(FPUV2_FCMPNES, fcmpnes),
> +       SOP_MAP(FPUV2_FCMPUOD, fcmpuod),
> +       SOP_MAP(FPUV2_FCMPUOS, fcmpuos),
> +       SOP_MAP(FPUV2_FCMPZHSD, fcmpzhsd),
> +       SOP_MAP(FPUV2_FCMPZHSS, fcmpzhss),
> +       SOP_MAP(FPUV2_FCMPZLSD, fcmpzlsd),
> +       SOP_MAP(FPUV2_FCMPZLSS, fcmpzlss),
> +       SOP_MAP(FPUV2_FCMPZNED, fcmpzned),
> +       SOP_MAP(FPUV2_FCMPZNES, fcmpznes),
> +       SOP_MAP(FPUV2_FCMPZUOD, fcmpzuod),
> +       SOP_MAP(FPUV2_FCMPZUOS, fcmpzuos),
> +       SOP_MAP(FPUV2_FDIVD, fdivd),
> +       SOP_MAP(FPUV2_FDIVS, fdivs),
> +       SOP_MAP(FPUV2_FDTOS, fdtos),
> +       SOP_MAP(FPUV2_FDTOSI_RN, fdtosi_rn),
> +       SOP_MAP(FPUV2_FDTOSI_RZ, fdtosi_rz),
> +       SOP_MAP(FPUV2_FDTOSI_RPI, fdtosi_rpi),
> +       SOP_MAP(FPUV2_FDTOSI_RNI, fdtosi_rni),
> +       SOP_MAP(FPUV2_FDTOUI_RN, fdtoui_rn),
> +       SOP_MAP(FPUV2_FDTOUI_RZ, fdtoui_rz),
> +       SOP_MAP(FPUV2_FDTOUI_RPI, fdtoui_rpi),
> +       SOP_MAP(FPUV2_FDTOUI_RNI, fdtoui_rni),
> +       SOP_MAP(FPUV2_FMACD, fmacd),
> +       SOP_MAP(FPUV2_FMACM, fmacm),
> +       SOP_MAP(FPUV2_FMACS, fmacs),
> +       SOP_MAP(FPUV2_FMFVRH, fmfvrh),
> +       SOP_MAP(FPUV2_FMFVRL, fmfvrl),
> +       SOP_MAP(FPUV2_FMOVD, fmovd),
> +       SOP_MAP(FPUV2_FMOVM, fmovm),
> +       SOP_MAP(FPUV2_FMOVS, fmovs),
> +       SOP_MAP(FPUV2_FMSCD, fmscd),
> +       SOP_MAP(FPUV2_FMSCM, fmscm),
> +       SOP_MAP(FPUV2_FMSCS, fmscs),
> +       SOP_MAP(FPUV2_FMTVRH, fmtvrh),
> +       SOP_MAP(FPUV2_FMTVRL, fmtvrl),
> +       SOP_MAP(FPUV2_FMULD, fmuld),
> +       SOP_MAP(FPUV2_FMULM, fmulm),
> +       SOP_MAP(FPUV2_FMULS, fmuls),
> +       SOP_MAP(FPUV2_FNEGD, fnegd),
> +       SOP_MAP(FPUV2_FNEGM, fnegm),
> +       SOP_MAP(FPUV2_FNEGS, fnegs),
> +       SOP_MAP(FPUV2_FNMACD, fnmacd),
> +       SOP_MAP(FPUV2_FNMACM, fnmacm),
> +       SOP_MAP(FPUV2_FNMACS, fnmacs),
> +       SOP_MAP(FPUV2_FNMSCD, fnmscd),
> +       SOP_MAP(FPUV2_FNMSCM, fnmscm),
> +       SOP_MAP(FPUV2_FNMSCS, fnmscs),
> +       SOP_MAP(FPUV2_FNMULD, fnmuld),
> +       SOP_MAP(FPUV2_FNMULM, fnmulm),
> +       SOP_MAP(FPUV2_FNMULS, fnmuls),
> +       SOP_MAP(FPUV2_FRECIPD, frecipd),
> +       SOP_MAP(FPUV2_FRECIPS, frecips),
> +       SOP_MAP(FPUV2_FSITOD, fsitod),
> +       SOP_MAP(FPUV2_FSITOS, fsitos),
> +       SOP_MAP(FPUV2_FSQRTD, fsqrtd),
> +       SOP_MAP(FPUV2_FSQRTS, fsqrts),
> +       SOP_MAP(FPUV2_FSTOD, fstod),
> +       SOP_MAP(FPUV2_FSTOSI_RN, fstosi_rn),
> +       SOP_MAP(FPUV2_FSTOSI_RZ, fstosi_rz),
> +       SOP_MAP(FPUV2_FSTOSI_RPI, fstosi_rpi),
> +       SOP_MAP(FPUV2_FSTOSI_RNI, fstosi_rni),
> +       SOP_MAP(FPUV2_FSTOUI_RN, fstoui_rn),
> +       SOP_MAP(FPUV2_FSTOUI_RZ, fstoui_rz),
> +       SOP_MAP(FPUV2_FSTOUI_RPI, fstoui_rpi),
> +       SOP_MAP(FPUV2_FSTOUI_RNI, fstoui_rni),
> +       SOP_MAP(FPUV2_FSUBD, fsubd),
> +       SOP_MAP(FPUV2_FSUBM, fsubm),
> +       SOP_MAP(FPUV2_FSUBS, fsubs),
> +       SOP_MAP(FPUV2_FUITOD, fuitod),
> +       SOP_MAP(FPUV2_FUITOS, fuitos),
> +};
> +
> +struct instruction_op_array inst_op2[0x1f] = {
> +       SOP_MAP(FPUV2_FLDD, fldd),
> +       SOP_MAP(FPUV2_FLDM, fldm),
> +       SOP_MAP(FPUV2_FLDMD, fldmd),
> +       SOP_MAP(FPUV2_FLDMM, fldmm),
> +       SOP_MAP(FPUV2_FLDMS, fldms),
> +       SOP_MAP(FPUV2_FLDRD, fldrd),
> +       SOP_MAP(FPUV2_FLDRM, fldrm),
> +       SOP_MAP(FPUV2_FLDRS, fldrs),
> +       SOP_MAP(FPUV2_FLDS, flds),
> +       SOP_MAP(FPUV2_FSTD, fstd),
> +       SOP_MAP(FPUV2_FSTM, fstm),
> +       SOP_MAP(FPUV2_FSTMD, fstmd),
> +       SOP_MAP(FPUV2_FSTMM, fstmm),
> +       SOP_MAP(FPUV2_FSTMS, fstms),
> +       SOP_MAP(FPUV2_FSTRD, fstrd),
> +       SOP_MAP(FPUV2_FSTRM, fstrm),
> +       SOP_MAP(FPUV2_FSTRS, fstrs),
> +       SOP_MAP(FPUV2_FSTS, fsts),
> +};
> diff --git a/arch/csky/math-emu/fp810.h b/arch/csky/math-emu/fp810.h
> new file mode 100644
> index 000000000000..bdbc715e8389
> --- /dev/null
> +++ b/arch/csky/math-emu/fp810.h
> @@ -0,0 +1,524 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * CSKY  860  MATHEMU
> + *
> + * Copyright (C) 2021 Hangzhou C-SKY Microsystems co.,ltd.
> + *
> + *    Authors: Li Weiwei <liweiwei@iscas.ac.cn>
> + *             Wang Junqiang <wangjunqiang@iscas.ac.cn>
> + *
> + */
Remove all above, just:
/* SPDX-License-Identifier: GPL-2.0 */


> +#ifndef __CSKY_FP810_H__
> +#define __CSKY_FP810_H__
> +
> +#include "math.h"
> +/*
> + * 5 - 12 bits in SOP.
> + */
> +#define FPUV2_FABSD 0x46
> +#define FPUV2_FABSM 0x86
> +#define FPUV2_FABSS 0x6
> +#define FPUV2_FADDD 0x40
> +#define FPUV2_FADDM 0x80
> +#define FPUV2_FADDS 0x0
> +#define FPUV2_FCMPHSD 0x4c
> +#define FPUV2_FCMPHSS 0xc
> +#define FPUV2_FCMPLTD 0x4d
> +#define FPUV2_FCMPLTS 0xd
> +#define FPUV2_FCMPNED 0x4e
> +#define FPUV2_FCMPNES 0xe
> +#define FPUV2_FCMPUOD 0x4f
> +#define FPUV2_FCMPUOS 0xf
> +#define FPUV2_FCMPZHSD 0x48
> +#define FPUV2_FCMPZHSS 0x8
> +#define FPUV2_FCMPZLSD 0x49
> +#define FPUV2_FCMPZLSS 0x9
> +#define FPUV2_FCMPZNED 0x4a
> +#define FPUV2_FCMPZNES 0xa
> +#define FPUV2_FCMPZUOD 0x4b
> +#define FPUV2_FCMPZUOS 0xb
> +#define FPUV2_FDIVD 0x58
> +#define FPUV2_FDIVS 0x18
> +#define FPUV2_FDTOS 0xd6
> +#define FPUV2_FDTOSI_RN 0xc8
> +#define FPUV2_FDTOSI_RZ 0xc9
> +#define FPUV2_FDTOSI_RPI 0xca
> +#define FPUV2_FDTOSI_RNI 0xcb
> +#define FPUV2_FDTOUI_RN 0xcc
> +#define FPUV2_FDTOUI_RZ 0xcd
> +#define FPUV2_FDTOUI_RPI 0xce
> +#define FPUV2_FDTOUI_RNI 0xcf
> +#define FPUV2_FMACD 0x54
> +#define FPUV2_FMACM 0x94
> +#define FPUV2_FMACS 0x14
> +#define FPUV2_FMFVRH 0xd8
> +#define FPUV2_FMFVRL 0xd9
> +#define FPUV2_FMOVD 0x44
> +#define FPUV2_FMOVM 0x84
> +#define FPUV2_FMOVS 0x4
> +#define FPUV2_FMSCD 0x55
> +#define FPUV2_FMSCM 0x95
> +#define FPUV2_FMSCS 0x15
> +#define FPUV2_FMTVRH 0xda
> +#define FPUV2_FMTVRL 0xdb
> +#define FPUV2_FMULD 0x50
> +#define FPUV2_FMULM 0x90
> +#define FPUV2_FMULS



--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
