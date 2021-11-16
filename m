Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A3F45295B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 06:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236070AbhKPFFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 00:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239742AbhKPFEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 00:04:24 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627F0C0AD869
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 18:05:33 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id v15so39828448ljc.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 18:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zjekXk1Y41NYMAjRs/JND+2NT7LCcjfE8WzW5/92qDk=;
        b=gDD7yPuK8kPTByYLflBxcwsTCAOAFeX3g6bupkv5mZu/FP/k4B0JLQMi0mlODE9IJF
         fMnzgefPp0Up8C1bWfQvQk3URRt/paGRrnO332QCf0Fq6XZFhaNfkP7aPp0SSf+NX5Ct
         X4BGvLrY3QV933k8o09sy+7Y5TTX2EuMyet94nN6KuCJEy449klzfvOaSVgC02SH7heF
         siWjQAvsASpYpCP6etvtT5kITXLDVYjIk0I8oNlUIr8L7cJLV6pJQ7D0JuXKJxKaJWJ4
         Edo1PVgcv+kZ1za9OyAK6fCBD+5WUuJJW26xaATP4jN3Iw7PjYFkdIb+UEqBnocNAIac
         0pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjekXk1Y41NYMAjRs/JND+2NT7LCcjfE8WzW5/92qDk=;
        b=rOXw/oMTybk8v5+ae+gnt9nPwes9ZteMw4LR5A2wQyfClhT/lFFaCsR4ZrAnqRb/eq
         ZVM933AIZVTmmlbIQ7/zPslxPWDEdZ2z7vKpM1WChNf+pBqoOTUamtu+x/MSP6olmGDa
         Wqu/6uow1liQjhVdrdSA2bUgOmhEpAIbY7BBlY+N0osHLRGZ4OZ0Z1aUG5Ttd6FpVUVJ
         FR/mO6pckpG15CqWhO1wOUCw8TQI57o96tZBn9F9W7UCe0BmuqtTB87iwl82lj5dLTMc
         xk2A5Ek2kDdzwrIy0EQEgGynZfZ5tkYJT5E8nkAbTe2KC/ytjRiqE6qc1sOwejgvL1cv
         n7DA==
X-Gm-Message-State: AOAM531AwWm4xxfeSZ7WjOzygBm8R7W6b3qLeHZMLXW6rMBNUw/tV64A
        +R078G90J7xB8CE5pvLJ6/wt2oB6Cu8tVoYAmWUiHg==
X-Google-Smtp-Source: ABdhPJy/B4sMOnqWRZ9agdkanbVGNULTfsri2o9UkQ9qJsXgk03SXIlzoY5wNhbMMbHZaf3ZaSlFnE7+0A7qt120lEw=
X-Received: by 2002:a2e:1646:: with SMTP id 6mr3308759ljw.492.1637028331759;
 Mon, 15 Nov 2021 18:05:31 -0800 (PST)
MIME-Version: 1.0
References: <20211114074704.3508622-1-chenhuacai@loongson.cn>
 <CALAqxLVpTtjFrtKAkcrjDKN9R6FuSdY6LKQw8Mye-3Atqv7kQw@mail.gmail.com> <CAAhV-H6Bq63uM-ifkM8KDJGD1uavv42bG9ij_CZBbCpC-AFSjg@mail.gmail.com>
In-Reply-To: <CAAhV-H6Bq63uM-ifkM8KDJGD1uavv42bG9ij_CZBbCpC-AFSjg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 15 Nov 2021 18:05:20 -0800
Message-ID: <CALAqxLWkXu-rpn6Bu8Y92z3c8yPasCUrZY44GVM9dxxcViDorA@mail.gmail.com>
Subject: Re: [PATCH] time/sched_clock: Allow architecture to override cyc_to_ns()
To:     Huacai Chen <chenhuacai@gmail.com>
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

On Mon, Nov 15, 2021 at 5:41 PM Huacai Chen <chenhuacai@gmail.com> wrote:
>
> Hi, John,
>
> On Tue, Nov 16, 2021 at 1:27 AM John Stultz <john.stultz@linaro.org> wrote:
> >
> > On Sat, Nov 13, 2021 at 11:47 PM Huacai Chen <chenhuacai@loongson.cn> wrote:
> > >
> > > The current cyc_to_ns() implementation is like this:
> > >
> > > static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
> > > {
> > >         return (cyc * mult) >> shift;
> > > }
> > >
> > > But u64*u32 maybe overflow, so introduce ARCH_HAS_CYC_TO_NS to allow
> > > architecture to override it.
> > >
> >
> > If that's the case, it would seem too large a mult/shift pair had been selected.
> We use a 100MHz clock and the counter is 64bit, the mult is ~160M. But
> even if we use a smaller mult, cyc*mult, it can also overflow.

Well, yes, any simple multiplication could overflow. My point is that
the mult/shift pair is usually calculated for an expected interval
range via clocks_calc_mult_shift(), where the max interval for
sched_clock is set to an hour.  So any interval length under an hour
should not overflow in a simple multiplication.

What I'm trying to understand is what is the case you have where your
interval length is longer than an hour?
As that might break other assumptions going on in the code.

> > What sort of cycle range are you considering to be valid here? Can you
> > provide more rationale as to why this needs the ability to be
> > overridden?
> >
> > And what sort of arch-specific logic do you envision, rather than
> > having a common implementation to avoid the overflow?
> u64*u64 can be handled by hardware (store the high bits and low bits
> of result in two registers). So, if we use assembly, we can handle the
> overflow correctly. E.g., LoongArch (and MIPS) can override
> cyc_to_ns() like this:
>
> static inline u64 notrace cyc_to_ns(u64 cyc, u32 mult, u32 shift)
> {
>         u64 t1, t2, t3;
>         unsigned long long rv;
>
>         /* 64-bit arithmetic can overflow, so use 128-bit. */
>         __asm__ (
>                 "nor            %[t1], $r0, %[shift]    \n\t"
>                 "mulh.du        %[t2], %[cyc], %[mult]  \n\t"
>                 "mul.d          %[t3], %[cyc], %[mult]  \n\t"
>                 "slli.d         %[t2], %[t2], 1         \n\t"
>                 "srl.d          %[rv], %[t3], %[shift]  \n\t"
>                 "sll.d          %[t1], %[t2], %[t1]     \n\t"
>                 "or             %[rv], %[t1], %[rv]     \n\t"
>                 : [rv] "=&r" (rv), [t1] "=&r" (t1), [t2] "=&r" (t2),
> [t3] "=&r" (t3)
>                 : [cyc] "r" (cyc), [mult] "r" (mult), [shift] "r" (shift)
>                 : );
>         return rv;
> }

But then isn't the mul_u64_u32_shr() the right abstraction for such a
custom implementation?

Then potentially implement a generic cyc_to_ns() implementation that
uses that instead?

thanks
-john
