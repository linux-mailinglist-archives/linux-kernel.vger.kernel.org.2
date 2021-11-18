Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB00C455710
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 09:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244645AbhKRIh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 03:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhKRIhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 03:37:20 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEAAC061570
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:34:20 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id ay21so11891216uab.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 00:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6w0RzrM/GbEobECevvTZaBFU3We35PLtFpcbjYgk7Co=;
        b=dEjGtRWkRtlNkMtUs8LaD4fbm086+2VvvJ6Egko9Ro6mAKNPoz1cap8iaUbnGt9nEs
         b9Qfdt8GTGsl2r1BItj3DfLjy0hk1f20NfjzKTc3Nn0ddrnpEta+qp2JnFkUbm5SFy+g
         uVV0wIOyaC6DAB8XUDMMTmtSTkxgRdYLDR4FhT3uSe+C1zk7lW+oWuJ8PobMYnyEfGPd
         g/LZvs5O7K/WEG+hrLWhqMEA0bPeCifeJQ+U3xkpPq1dPRJvc0A/EuNWfAkHIM/gYlxw
         UhxWEMBcrcNBPjYUibowrJ8Z2Hig6gkSDmEQ/XjsfyAsrx0ZDY5tSGbI28G1VXX7j6EN
         pHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6w0RzrM/GbEobECevvTZaBFU3We35PLtFpcbjYgk7Co=;
        b=TJbFc1g8ezFOF4J3v/Wyxk4b+aXRNK+ApVx+qS6lFZRIeWPBRjp5Gvuq/DWUI+0499
         67MWQp0a/v8+IR/eluZXwLUcvPMFHKmiVrK+CCmlKeRHeG8Ju/Mnbsr4i2Mcf1a8Eizy
         c/cMxkdIRjmdufDxtYIS8k54Vezr0kfVLf1212elnOyHnKhQdlnjPDnOnrmpiC3q1Ddb
         pV1MFynAGTqbtj6KJEvUIhY3h+qYceOSzrDidB1b0BSfrwDhV85oFupypU6W2WqWZI1c
         QxgURbwkhWf+Vkd/gyKngwxuX46yXzsNSHwC8AuG2hzX2xoYy+3O4bFmP6VCP1rl+nM0
         dlOA==
X-Gm-Message-State: AOAM532k3Db/LrTy5FWBt1XmpFvM2eELcjc8v9BI62DpCzuQKZiFf3tO
        MJ7YMwJi63RlsIiOn1vwpIyuw1j2jRTtoN1xh2I=
X-Google-Smtp-Source: ABdhPJwvRtFJAfJKkblu0AA0RBwcVAmnxYJ1yBVJujoxgXlR+XszHBeM73h7F90JT6TBQIM7+PdZWoV5phB62y24nuI=
X-Received: by 2002:a67:b844:: with SMTP id o4mr81292830vsh.61.1637224459684;
 Thu, 18 Nov 2021 00:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20211114074704.3508622-1-chenhuacai@loongson.cn>
 <CALAqxLVpTtjFrtKAkcrjDKN9R6FuSdY6LKQw8Mye-3Atqv7kQw@mail.gmail.com>
 <CAAhV-H6Bq63uM-ifkM8KDJGD1uavv42bG9ij_CZBbCpC-AFSjg@mail.gmail.com>
 <CALAqxLWkXu-rpn6Bu8Y92z3c8yPasCUrZY44GVM9dxxcViDorA@mail.gmail.com>
 <CAAhV-H5TrpRjgS6Fdoh5U63yh3QvixcByqnKDyXahKXphGKKAg@mail.gmail.com> <CALAqxLWg+zvGBytLw+353r00G2gbUMzvroxcsRqhdSGUZyjCcA@mail.gmail.com>
In-Reply-To: <CALAqxLWg+zvGBytLw+353r00G2gbUMzvroxcsRqhdSGUZyjCcA@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 18 Nov 2021 16:34:08 +0800
Message-ID: <CAAhV-H6NeB9Or=fc31r7teFdbeUZcJNh3VbGNXCtTbA7L38x3g@mail.gmail.com>
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

On Wed, Nov 17, 2021 at 4:31 AM John Stultz <john.stultz@linaro.org> wrote:
>
> On Tue, Nov 16, 2021 at 3:37 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> > On Tue, Nov 16, 2021 at 10:05 AM John Stultz <john.stultz@linaro.org> wrote:
> > > On Mon, Nov 15, 2021 at 5:41 PM Huacai Chen <chenhuacai@gmail.com> wrote:
> > > > On Tue, Nov 16, 2021 at 1:27 AM John Stultz <john.stultz@linaro.org> wrote:
> > > > > On Sat, Nov 13, 2021 at 11:47 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > > > > >
> > > > > > The current cyc_to_ns() implementation is like this:
> > > > > >
> > > > > > static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
> > > > > > {
> > > > > >         return (cyc * mult) >> shift;
> > > > > > }
> > > > > >
> > > > > > But u64*u32 maybe overflow, so introduce ARCH_HAS_CYC_TO_NS to allow
> > > > > > architecture to override it.
> > > > > >
> > > > >
> > > > > If that's the case, it would seem too large a mult/shift pair had been selected.
> > > > We use a 100MHz clock and the counter is 64bit, the mult is ~160M. But
> > > > even if we use a smaller mult, cyc*mult, it can also overflow.
> > >
> > > Well, yes, any simple multiplication could overflow. My point is that
> > > the mult/shift pair is usually calculated for an expected interval
> > > range via clocks_calc_mult_shift(), where the max interval for
> > > sched_clock is set to an hour.  So any interval length under an hour
> > > should not overflow in a simple multiplication.
> > >
> > > What I'm trying to understand is what is the case you have where your
> > > interval length is longer than an hour?
> > > As that might break other assumptions going on in the code.
> > We found that the mult is "reasonable" if we use 100MHz, 50MHz or
> > 25MHz clocks, but if we use some others, such as 33MHz, the calculated
> > mult is dramatically large.
>
> So that sounds a little concerning, but in clocks_calc_mult_shift() we
> try to find an accurate mult/shift pair that fits the expected range.
> As we want to be as accurate as possible, we need higher shift values
> for freqs that don't evenly divide NSEC_PER_SEC, in order to minimize
> the error. So larger mult/shift values isn't necessarily a problem.
>
> For the set you gave, the code should give
> 100000000 -> m:20971520 s:21
> 50000000 -> m:41943040 s:21
> 25000000 -> m:83886080 s:21
> 33333333 -> m:125829121 s:22
>
> And yes, the 33Mhz does have a larger mult/shift pair, but that's
> because we want to be as accurate as possible in the conversion.
Maybe we have made some mistakes, let's investigate it deeper. Thanks.

Huacai

>
> And calculating that max interval multiplication (one hour of cycles):
> 100Mhz:     (180000000000cyc * 41943040 = 7549747200000000000) >> 21 =
> 3600000000000 ns
> 50Mhz:       (90000000000cyc * 83886080 = 7549747200000000000) >> 21 =
> 3600000000000 ns
> 25Mhz:       (360000000000cyc * 20971520 = 7549747200000000000) >> 21
> = 3600000000000 ns
> 33Mhz:       (119999998800cyc * 125829121 = 15099494369005054800) >>
> 22 = 3599999992610 ns
>
> So assuming you're seeing the same mult/shift from above, we should be
> able to handle an hour of cycles without overflowing the
> multiplication.
> (Though it definitely gets close with the 33Mhz case, as we would
> overflow with an hour + 7 seconds or so of cycles.)
>
> If you're seeing something else, let us know, as then it's probably a bug.
>
> But again, it would be good to understand the use case where the
> sched_clock epoch isn't being updated for over an hour.  I'm guessing
> hrtimers are being deferred for a super long time?
>
> > > > > What sort of cycle range are you considering to be valid here? Can you
> > > > > provide more rationale as to why this needs the ability to be
> > > > > overridden?
> > > > >
> > > > > And what sort of arch-specific logic do you envision, rather than
> > > > > having a common implementation to avoid the overflow?
> > > > u64*u64 can be handled by hardware (store the high bits and low bits
> > > > of result in two registers). So, if we use assembly, we can handle the
> > > > overflow correctly. E.g., LoongArch (and MIPS) can override
> > > > cyc_to_ns() like this:
> > > >
> > > > static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
> > > > {
> > > >         u64 t1, t2, t3;
> > > >         unsigned long long rv;
> > > >
> > > >         /* 64-bit arithmetic can overflow, so use 128-bit. */
> > > >         __asm__ (
> > > >                 "nor            %[t1], $r0, %[shift]    \n\t"
> > > >                 "mulh.du        %[t2], %[cyc], %[mult]  \n\t"
> > > >                 "mul.d          %[t3], %[cyc], %[mult]  \n\t"
> > > >                 "slli.d         %[t2], %[t2], 1         \n\t"
> > > >                 "srl.d          %[rv], %[t3], %[shift]  \n\t"
> > > >                 "sll.d          %[t1], %[t2], %[t1]     \n\t"
> > > >                 "or             %[rv], %[t1], %[rv]     \n\t"
> > > >                 : [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2),
> > > > [t3] "=&r" (t3)
> > > >                 : [cyc] "r" (cyc), [mult] "r" (mult), [shift] "r" (shift)
> > > >                 : );
> > > >         return rv;
> > > > }
> > >
> > > But then isn't the mul_u64_u32_shr() the right abstraction for such a
> > > custom implementation?
> > >
> > > Then potentially implement a generic cyc_to_ns() implementation that
> > > uses that instead?
> > OK, we will try to override mul_u64_u32_shr() rather than cyc_to_ns().
>
> If the use case is considered reasonable, there likely still needs to
> be a cyc_to_ns() implementation that uses mult_u64_u32_shr(), but
> hopefully it can be generic (maybe under a config option for the
> deferred hrtimer use case?).
>
> thanks
> -john
