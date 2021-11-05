Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB2D446A46
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 22:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhKEVJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 17:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhKEVJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 17:09:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA21DC061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 14:06:35 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id v15so9903567ljc.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 14:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8ekPbxFkl2No7KCWi5lfhL3+5lIg3GBm30pE4uSVqWk=;
        b=drKjIx38RYDRTnv+3mqDDC7UMt6AoIoTx/LvR2Qg/Hwm17y0c4Qt1RVXX2iJPBWouH
         0DRxPhkT9ujCWepCtnu0jX0c/IORmiGPBH2UShbjfVWCA4k8mXA1fCO0b+ZaCr32+MCT
         WJa95RipxyIJAqyxkgIOhOnt591K0MjY9SUQpYvv5gSyHzoWYNpDnnNO6ORNQqOgUC1p
         r+kD5cl/zgm30utoqW+gizRu4ZB8U8sS1HeprZxPgpSLUuiUPQln99s+90oyBibcARLB
         4NHGrtuHGk3LLM45JUv714TFAbur/tNWYiFqTk2ww9WW4XJGJNJfgX4YEJs+bHy2reoQ
         zdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8ekPbxFkl2No7KCWi5lfhL3+5lIg3GBm30pE4uSVqWk=;
        b=5nh/yzQZm93s8clJK/wIAkr8/+ispuPqRlf0rGAXO6fsK0MAYbz7dnpVz6fa18wHBm
         P/Hlt+cDAtf5+tdGnl3Rp1abPb6oSLWodpGeNd5ld9vCys9K3Qm0a5CIi39kt4ckdrsE
         wq6Mxqh2nIYkZMBFGAhA3u2/KX/sLafIjNZQ6/2yGG+cKwM3y49raEWZ2a3AMqM8CiF/
         T+yMNdHxEiDZJ7Etlvka5IHC9j1UlFEDGLtWjUcJmxmTiWXNJOgOmYqZATwrQwgF1y1/
         nCedlksXWsQCcO0WB5YMxPpy8cgAi+ZMV/K5aRogtx4XIp81jWSK/TcOnhJmnQxRLhdp
         GR4g==
X-Gm-Message-State: AOAM5313G1QsxCOKgUU+J1iXx+f4kfU1Nb2gCZsF/GPhBo6wzawsFEEN
        bSf87a1b3O38w4xwQnGRlOqjDYRZYdzaQcsLTE1yoA==
X-Google-Smtp-Source: ABdhPJzINjsxFhV2yejBgV/znnB678jW21C1LtxUZQQl5A81L+4emVqEEGoYR0ShhMPdNTDld1bsgNhjs3mOC7/l+Do=
X-Received: by 2002:a2e:8183:: with SMTP id e3mr29632366ljg.526.1636146393948;
 Fri, 05 Nov 2021 14:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <202111051833.sOedoq8J-lkp@intel.com> <YYUhzUEbK4t5/hOC@hirez.programming.kicks-ass.net>
In-Reply-To: <YYUhzUEbK4t5/hOC@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 14:06:22 -0700
Message-ID: <CAKwvOdnPWrBDasA73CRZQPwPt8Bd6H6B3qWTxqWt6UkdkAo=Uw@mail.gmail.com>
Subject: Re: [peterz-queue:x86/wip.extable 1/22] drivers/crypto/ccree/cc_driver.c:117:18:
 warning: result of comparison of constant 18446744073709551615 with
 expression of type 'typeof (_Generic((mask), char: (unsigned char)0, unsigned
 char: (unsigned char)0, signed char: (unsigned char)0, unsigned shor...
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 5:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Nov 05, 2021 at 06:17:44PM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.gi=
t x86/wip.extable
> > head:   a4d149db054a77aa35b04bb088f749cbb9a2edea
> > commit: 4b9e954553a4137f7504e068438851c27edc6b22 [1/22] bitfield.h: Fix=
 "type of reg too small for mask" test
> > config: riscv-randconfig-r032-20211105 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 84=
7a6807332b13f43704327c2d30103ec0347c77)
> > reproduce (this is a W=3D1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/s=
bin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install riscv cross compiling tool for clang build
> >         # apt-get install binutils-riscv64-linux-gnu
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.=
git/commit/?id=3D4b9e954553a4137f7504e068438851c27edc6b22
> >         git remote add peterz-queue https://git.kernel.org/pub/scm/linu=
x/kernel/git/peterz/queue.git
> >         git fetch --no-tags peterz-queue x86/wip.extable
> >         git checkout 4b9e954553a4137f7504e068438851c27edc6b22
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross =
W=3D1 ARCH=3Driscv
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/crypto/ccree/cc_driver.c:117:18: warning: result of comparis=
on of constant 18446744073709551615 with expression of type 'typeof (_Gener=
ic((mask), char: (unsigned char)0, unsigned char: (unsigned char)0, signed =
char: (unsigned char)0, unsigned short: (unsigned short)0, short: (unsigned=
 short)0, unsigned int: (unsigned int)0, int: (unsigned int)0, unsigned lon=
g: (unsigned long)0, long: (unsigned long)0, unsigned long long: (unsigned =
long long)0, long long: (unsigned long long)0, default: (mask)))' (aka 'uns=
igned int') is always false [-Wtautological-constant-out-of-range-compare]
> >            cache_params |=3D FIELD_PREP(mask, val);
> >                            ^~~~~~~~~~~~~~~~~~~~~
> >    include/linux/bitfield.h:111:3: note: expanded from macro 'FIELD_PRE=
P'
> >                    __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");=
    \
> >                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/bitfield.h:68:53: note: expanded from macro '__BF_FIEL=
D_CHECK'
> >                    BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) > =
    \
> >                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~=
~~~~~
> >    include/linux/build_bug.h:39:58: note: expanded from macro 'BUILD_BU=
G_ON_MSG'
> >    #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
> >                                        ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> >    include/linux/compiler_types.h:322:22: note: expanded from macro 'co=
mpiletime_assert'
> >            _compiletime_assert(condition, msg, __compiletime_assert_, _=
_COUNTER__)
> >            ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~
> >    include/linux/compiler_types.h:310:23: note: expanded from macro '_c=
ompiletime_assert'
> >            __compiletime_assert(condition, msg, prefix, suffix)
> >            ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    include/linux/compiler_types.h:302:9: note: expanded from macro '__c=
ompiletime_assert'
> >                    if (!(condition))                                   =
    \
> >                          ^~~~~~~~~
>
> I'm confused here.. the code reads:
>
>
> #define __scalar_type_to_unsigned_cases(type)                           \
>                 unsigned type:  (unsigned type)0,                       \
>                 signed type:    (unsigned type)0
>
> #define __unsigned_scalar_typeof(x) typeof(                             \
>                 _Generic((x),                                           \
>                         char:   (unsigned char)0,                       \
>                         __scalar_type_to_unsigned_cases(char),          \
>                         __scalar_type_to_unsigned_cases(short),         \
>                         __scalar_type_to_unsigned_cases(int),           \
>                         __scalar_type_to_unsigned_cases(long),          \
>                         __scalar_type_to_unsigned_cases(long long),     \
>                         default: (x)))
>
> #define __bf_cast_unsigned(type, x)     ((__unsigned_scalar_typeof(type))=
(x))
>
> #define __BF_FIELD_CHECK(_mask, _reg, _val, _pfx)                       \
>         ({                                                              \
>                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
>                                  _pfx "mask is not constant");          \
>                 BUILD_BUG_ON_MSG((_mask) =3D=3D 0, _pfx "mask is zero"); =
   \
>                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
>                                  ~((_mask) >> __bf_shf(_mask)) & (_val) :=
 0, \
>                                  _pfx "value too large for the field"); \
>                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask, _mask) >     \
>                                  __bf_cast_unsigned(_reg, ~0ull),       \
>                                  _pfx "type of reg too small for mask"); =
\
>                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
>                                               (1ULL << __bf_shf(_mask)));=
 \
>         })
>
> #define FIELD_PREP(_mask, _val)                                         \
>         ({                                                              \
>                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
>                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
>         })
>
>
> static void init_cc_cache_params(struct cc_drvdata *drvdata)
> {
>         struct device *dev =3D drvdata_to_dev(drvdata);
>         u32 cache_params, ace_const, val, mask;
>
>         ...
>
>         mask =3D CC_GENMASK(CC_AXIM_CACHE_PARAMS_AWCACHE);        <-- *BO=
OM*
>         cache_params &=3D ~mask;
>         cache_params |=3D FIELD_PREP(mask, val);
>
>         ...
> }
>
> So we're having "(unsigned int)mask > (unsigned long long)~0ull" as
> a compile time constant input to the BUILD_BUG_ON_MSG(), and clang-14 is
> now complaining it's a constant ?!?

No, the error message (trimmed for clarity):
>> warning: result of comparison of constant 18446744073709551615  (ie ~0ul=
l / ULLONG_MAX) with expression of type ... 'unsigned int') is always false=
 [-Wtautological-constant-out-of-range-compare]

Is `val` an int, but should be a long long? We're comparing if an
unsigned int is greater than ULLONG_MAX, which is impossible (or
rather a tautology; something that's always either true or false, in
this case false).  Or maybe mask and reg are different widths?

>
> It is that by design.
>


--=20
Thanks,
~Nick Desaulniers
