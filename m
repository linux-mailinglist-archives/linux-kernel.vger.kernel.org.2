Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDE44530FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 12:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbhKPLmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 06:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhKPLlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 06:41:36 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE4DC061A09
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:37:35 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id p2so41625559uad.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 03:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qfxH9S6PzR164j8Dpik4zeNcArybsi88mL/E+bTZWc=;
        b=JqAOcaWZ56N2xtpBF5ooCltYQGX547fhuaQcWEOLhuQsAh6Bezo+GO9wVdMPGGgASc
         6fgVR9fWYlpMwEWWC0ycog1FdeiegonHc1vvYhEjXwXIPBSLLEPRjqHNcDPsTXVIJ4iB
         /mqGsMJ0J/nWZvP/csLM2RT/qDH5LDExUnMstZca0B+NEJwDirHS7qOLb2X2Os6je3ry
         lslyHGJ4OCuHeeF55635GI8J0lbo8SRCrJxTYpmiPD5r6QjM2bFYnHsHnnI7Tg20Pgcd
         GVMJpdUvp0pciuLCSIoQajDWAisz1KW03GcMBOTEowdRdQqtrcR5LcbKC4T8vDY9KmrD
         NplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qfxH9S6PzR164j8Dpik4zeNcArybsi88mL/E+bTZWc=;
        b=HRamw9iaa2/RsWmyxGUiT9wjbq3iFGBEn7D0zurze5yrh5jQnRFAW2AWUWAHIYATi5
         5wI2JVeHagmCxL/mNcpcAk2n0UNB7WtORf0sqRBpIWhmvZXa7+AXPeVx4jKRLc8xtwL0
         Fkl/eX9k/ex15RFgu5Ot3evNAP3qwvZgoOPgpGt3prsdZkZVSA30hdihLxqNGf0MrqCg
         LIRNi51FcRHlgMKuKuwCrL0sW9yFnyMasvc51NlPyBResSvRXN1NpvVm9LTDJuQZ+PdX
         k/brwcOzjGtK7giHC2IRwE46+o+hD0FfyvFmaKXhR7NopvUng2REzEBbMHbdWt1Ml4Dc
         fTcg==
X-Gm-Message-State: AOAM5300fIdkymM3smmSAp/SB7I8TprgRlHXcLjQGBF6F8u3wRpHwyYe
        /o9qyDdfzVa3ZwEE3tgJ4J3PRq+vCUIt3EELdCFV4y6DKXSOPjDD
X-Google-Smtp-Source: ABdhPJy7lj42KeQDhGCimrbKT7/8ViK3lq8SsKL+rLELdrLIs1wRZ0BzmL4E5RD1zbvGGKYsEfD6EUIwnhs4YNUt0NQ=
X-Received: by 2002:a05:6102:240b:: with SMTP id j11mr55837737vsi.54.1637062654805;
 Tue, 16 Nov 2021 03:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20211114074704.3508622-1-chenhuacai@loongson.cn>
 <CALAqxLVpTtjFrtKAkcrjDKN9R6FuSdY6LKQw8Mye-3Atqv7kQw@mail.gmail.com>
 <CAAhV-H6Bq63uM-ifkM8KDJGD1uavv42bG9ij_CZBbCpC-AFSjg@mail.gmail.com> <CALAqxLWkXu-rpn6Bu8Y92z3c8yPasCUrZY44GVM9dxxcViDorA@mail.gmail.com>
In-Reply-To: <CALAqxLWkXu-rpn6Bu8Y92z3c8yPasCUrZY44GVM9dxxcViDorA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Tue, 16 Nov 2021 19:37:23 +0800
Message-ID: <CAAhV-H5TrpRjgS6Fdoh5U63yh3QvixcByqnKDyXahKXphGKKAg@mail.gmail.com>
Subject: Re: [PATCH] time/sched_clock: Allow architecture to override cyc_to_ns()
To:     John Stultz <john.stultz@linaro.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, John,

On Tue, Nov 16, 2021 at 10:05 AM John Stultz <john.stultz@linaro.org> wrote:
>
> On Mon, Nov 15, 2021 at 5:41 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> >
> > Hi, John,
> >
> > On Tue, Nov 16, 2021 at 1:27 AM John Stultz <john.stultz@linaro.org> wrote:
> > >
> > > On Sat, Nov 13, 2021 at 11:47 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > >
> > > > The current cyc_to_ns() implementation is like this:
> > > >
> > > > static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
> > > > {
> > > >         return (cyc * mult) >> shift;
> > > > }
> > > >
> > > > But u64*u32 maybe overflow, so introduce ARCH_HAS_CYC_TO_NS to allow
> > > > architecture to override it.
> > > >
> > >
> > > If that's the case, it would seem too large a mult/shift pair had been selected.
> > We use a 100MHz clock and the counter is 64bit, the mult is ~160M. But
> > even if we use a smaller mult, cyc*mult, it can also overflow.
>
> Well, yes, any simple multiplication could overflow. My point is that
> the mult/shift pair is usually calculated for an expected interval
> range via clocks_calc_mult_shift(), where the max interval for
> sched_clock is set to an hour.  So any interval length under an hour
> should not overflow in a simple multiplication.
>
> What I'm trying to understand is what is the case you have where your
> interval length is longer than an hour?
> As that might break other assumptions going on in the code.
We found that the mult is "reasonable" if we use 100MHz, 50MHz or
25MHz clocks, but if we use some others, such as 33MHz, the calculated
mult is dramatically large.

>
> > > What sort of cycle range are you considering to be valid here? Can you
> > > provide more rationale as to why this needs the ability to be
> > > overridden?
> > >
> > > And what sort of arch-specific logic do you envision, rather than
> > > having a common implementation to avoid the overflow?
> > u64*u64 can be handled by hardware (store the high bits and low bits
> > of result in two registers). So, if we use assembly, we can handle the
> > overflow correctly. E.g., LoongArch (and MIPS) can override
> > cyc_to_ns() like this:
> >
> > static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
> > {
> >         u64 t1, t2, t3;
> >         unsigned long long rv;
> >
> >         /* 64-bit arithmetic can overflow, so use 128-bit. */
> >         __asm__ (
> >                 "nor            %[t1], $r0, %[shift]    \n\t"
> >                 "mulh.du        %[t2], %[cyc], %[mult]  \n\t"
> >                 "mul.d          %[t3], %[cyc], %[mult]  \n\t"
> >                 "slli.d         %[t2], %[t2], 1         \n\t"
> >                 "srl.d          %[rv], %[t3], %[shift]  \n\t"
> >                 "sll.d          %[t1], %[t2], %[t1]     \n\t"
> >                 "or             %[rv], %[t1], %[rv]     \n\t"
> >                 : [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2),
> > [t3] "=&r" (t3)
> >                 : [cyc] "r" (cyc), [mult] "r" (mult), [shift] "r" (shift)
> >                 : );
> >         return rv;
> > }
>
> But then isn't the mul_u64_u32_shr() the right abstraction for such a
> custom implementation?
>
> Then potentially implement a generic cyc_to_ns() implementation that
> uses that instead?
OK, we will try to override mul_u64_u32_shr() rather than cyc_to_ns().

Huacai
>
> thanks
> -john
