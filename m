Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4775A387F50
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 20:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbhERSNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 14:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhERSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 14:13:23 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31138C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:12:04 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e14so9914602ils.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 11:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQ9zaCOp8oqQrD+fHP3Fdg+K1ve8YEQcFRk+aoot2Bg=;
        b=SPI3jgv83ug1FmZ2aXaus4J1ngxCW/Qdg+BDJNh6AbsZYCzKPerHAuTN41H2Q3qKDc
         kjPDFeptOrDy5Lj8bCo4o6twWBW/ySImxntllArFWSFqc3F9m9dM+MvKIgqAqYD7yL+h
         yd8IRO1EMbUHPDMY49hBumV9b4jdYmaks4ttC5Sn9/+/gRqHZWrg8hUwMTEO8HXJ6iI2
         9sR2bO25iqiRH0ffvBBu6PjJmsivbqX3eoPYjo4LUPOhcw536qF68yN3Z3rtFi2l/zT/
         vKiPGDOV60WNiOX6lzomJV4UOav5k6VS8uRd84fX5/5fXSxYItatnv6Bo/D/8nd3taeV
         OzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQ9zaCOp8oqQrD+fHP3Fdg+K1ve8YEQcFRk+aoot2Bg=;
        b=X1DV+2U59F6d8OpDldHs4/omgF5ORVnFw7cksuhdBbbAFh7ntvCPE8/nFcqn95nele
         w/+iVr0kmmp6N72a85ImEc89DBRTbBPuN/Vi+p5GoWan9+fA1j7mKi6ESD8axCsBTgrl
         5mE3nKEb2YNt2ZH0L5ilcurwrD9hUMHgmYmQrr+E/QbgrjVyOtd9kYpg6xC+JLGF4rRX
         HNEuUGb/WGAKGit2QIDiJbjudQ2fwzLPf28Q3iOGu0UrKh1KQMhVln2dH82QLJWkn2od
         Dq2d3VN9xQ56HaQCyIYuOebCVpQ681Mpaj9tyjemvAPEE1Ye6fWxFQ1b47OQN+7mkp+E
         6lDg==
X-Gm-Message-State: AOAM532OfUhV1lXAwXu0+HtAa0ErNzdhdc171H8OzM1huM6IU8zFwoD0
        c1gIVk/5mTJPHZyjYa1/2Tw4AWBwjFRPTVG8kc8EXYJg4lo=
X-Google-Smtp-Source: ABdhPJzLcze5XSY9bYNTxbp0vKNnrQDKlgs9ajlVAuyfdPNR01Tzfh3iI7JYxqyeCB9/BL39hpyo7sUJWzH0aenxpr4=
X-Received: by 2002:a05:6e02:f50:: with SMTP id y16mr5297315ilj.61.1621361523434;
 Tue, 18 May 2021 11:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210517235546.3038875-1-eugenis@google.com> <20210518174439.GA28491@arm.com>
In-Reply-To: <20210518174439.GA28491@arm.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Tue, 18 May 2021 11:11:52 -0700
Message-ID: <CAMn1gO5TmJZ4M4EyQ60VMc2-acUZSYkaB9M0C9kOv_dXQe54Ug@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: speed up mte_set_mem_tag_range
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Will Deacon <will@kernel.org>,
        Steven Price <steven.price@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 10:44 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Mon, May 17, 2021 at 04:55:46PM -0700, Evgenii Stepanov wrote:
> > Use DC GVA / DC GZVA to speed up KASan memory tagging in HW tags mode.
> >
> > The first cacheline is always tagged using STG/STZG even if the address is
> > cacheline-aligned, as benchmarks show it is faster than a conditional
> > branch.
> [...]
> > diff --git a/arch/arm64/include/asm/mte-kasan.h b/arch/arm64/include/asm/mte-kasan.h
> > index ddd4d17cf9a0..e29a0e2ab35c 100644
> > --- a/arch/arm64/include/asm/mte-kasan.h
> > +++ b/arch/arm64/include/asm/mte-kasan.h
> > @@ -48,45 +48,7 @@ static inline u8 mte_get_random_tag(void)
> >       return mte_get_ptr_tag(addr);
> >  }
> >
> > -/*
> > - * Assign allocation tags for a region of memory based on the pointer tag.
> > - * Note: The address must be non-NULL and MTE_GRANULE_SIZE aligned and
> > - * size must be non-zero and MTE_GRANULE_SIZE aligned.
> > - */
> > -static inline void mte_set_mem_tag_range(void *addr, size_t size,
> > -                                             u8 tag, bool init)
>
> With commit 2cb34276427a ("arm64: kasan: simplify and inline MTE
> functions") you wanted this inlined for performance. Does this not
> matter much that it's now out of line?
>
> > diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
> > index d31e1169d9b8..c06ada79a437 100644
> > --- a/arch/arm64/lib/Makefile
> > +++ b/arch/arm64/lib/Makefile
> > @@ -18,3 +18,5 @@ obj-$(CONFIG_CRC32) += crc32.o
> >  obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
> >
> >  obj-$(CONFIG_ARM64_MTE) += mte.o
> > +
> > +obj-$(CONFIG_KASAN_HW_TAGS) += mte-kasan.o
> > diff --git a/arch/arm64/lib/mte-kasan.S b/arch/arm64/lib/mte-kasan.S
> > new file mode 100644
> > index 000000000000..9f6975e2af60
> > --- /dev/null
> > +++ b/arch/arm64/lib/mte-kasan.S
> > @@ -0,0 +1,63 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2021 Google Inc.
> > + */
> > +#include <linux/const.h>
> > +#include <linux/linkage.h>
> > +
> > +#include <asm/mte-def.h>
> > +
> > +     .arch   armv8.5-a+memtag
> > +
> > +     .macro  __set_mem_tag_range, stg, gva, start, size, linesize, tmp1, tmp2, tmp3
> > +     add     \tmp3, \start, \size
> > +     cmp     \size, \linesize, lsl #1
> > +     b.lt    .Lsmtr3_\@
>
> We could do with some comments here. Why the lsl #1? I think I get it
> but it would be good to make this more readable.
>
> It may be easier if you placed it in a file on its own (as it is now but
> with a less generic file name) and use a few .req instead of the tmpX.
> You can use the macro args only for the stg/gva.

Yes, I think we could use more comments and .req here, like the
userspace version of this function that we use in Scudo:
https://cs.android.com/android/platform/superproject/+/master:external/scudo/standalone/memtag.h;l=150;drc=34c8857fef28eab205c22cbfb4bfda2f848e5a80

> > +
> > +     sub     \tmp1, \linesize, #1
> > +     bic     \tmp2, \tmp3, \tmp1
> > +     orr     \tmp1, \start, \tmp1
> > +
> > +.Lsmtr1_\@:
> > +     \stg    \start, [\start], #MTE_GRANULE_SIZE
> > +     cmp     \start, \tmp1
> > +     b.lt    .Lsmtr1_\@
> > +
> > +.Lsmtr2_\@:
> > +     dc      \gva, \start
> > +     add     \start, \start, \linesize
> > +     cmp     \start, \tmp2
> > +     b.lt    .Lsmtr2_\@
> > +
> > +.Lsmtr3_\@:
> > +     cmp     \start, \tmp3
> > +     b.ge    .Lsmtr4_\@
> > +     \stg    \start, [\start], #MTE_GRANULE_SIZE
> > +     b       .Lsmtr3_\@
> > +.Lsmtr4_\@:
> > +     .endm
>
> If we want to get the best performance out of this, we should look at
> the memset implementation and do something similar. In principle it's
> not that far from a memzero, though depending on the microarchitecture
> it may behave slightly differently.

For Scudo I compared our storeTags implementation linked above against
__mtag_tag_zero_region from the arm-optimized-routines repository
(which I think is basically an improved version of that memset
implementation rewritten to use STG and DC GZVA), and our
implementation performed better on the hardware that we have access
to.

> Anyway, before that I wonder if we wrote all this in C + inline asm
> (three while loops or maybe two and some goto), what's the performance
> difference? It has the advantage of being easier to maintain even if we
> used some C macros to generate gva/gzva variants.

I'm not sure I agree that it will be easier to maintain. Due to the
number of "unusual" instructions required here it seems more readable
to have the code in pure assembly than to require readers to switch
contexts between C and asm. If we did move it to inline asm then I
think it should basically be a large blob of asm like the Scudo code
that I linked.

Peter
