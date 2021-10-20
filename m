Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE0434FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 18:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhJTQLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 12:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhJTQLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 12:11:04 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC40C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:08:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g79-20020a1c2052000000b00323023159e1so2987424wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 09:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jU6so7/xmOAFW/5s5ePQjgzisbppTQiQVv9ulVydV04=;
        b=iNttK7oYUXsKvaJ8rzn//EimD6P+6OHcX+mwgg0gJuTPMnGd7PnIyjAhZLvN/vEpWh
         W6YleLtRhL/OoHrY/X/jDl2zkirtDaTHhjrbPzUlyTfX/5dwLrMvBUpxdT29XfuAU580
         xwvDyj7K9KwQ29+7iiRltTXU8r01rWEaCib8cAOOpwvTRPqMamVpub9TfySxzKwlL1m4
         bxUWaAbd6WEt1VRrBhTRezlPY3k1Y2s9FtLvEmdQcP/n5riV5qhpb4JkaX0RArtt8Krf
         rqyeV11RlV9pOUWdPXpsFuOsmPNzyEFtnasEY/EX9VKO/Ve75P20cdW555lN02yeDlX5
         HoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jU6so7/xmOAFW/5s5ePQjgzisbppTQiQVv9ulVydV04=;
        b=QxZ7l+CJIde3sZWwY5Ma3pPpbi+ARlg7yB+8LZWhVJv5saTOH2bbSkbXEI/9gTMi3d
         jhCTeDdDo+Ud5tpSjLTdLiCyTl4UcJkeEeT4ym64Pt3qqHyZMRVot08bUtlk6iiQagE3
         KcVVJOZiZ7ceoOY6q+lOeofCtsghjMY7GwO28rRE9bLDXGtVUSkkLstPp8+owOC3LVrt
         UAmdoClCq7GXROCYPnWxvVN4VJlJLReKg63e9ORUPGRIKCgtg2gWgu6DPp4YSEBdEd+K
         VS2hSVeXOUH+PEvskHrzmun2c1s8vcM3kYgI+YO3NKc+d4l37dxYyH7Rm699mqhZ6uV8
         Dw/Q==
X-Gm-Message-State: AOAM533gyAka7iYPcRfEwOevjzN3QhSJo6Uwo27OF4N76kDwlNHHBHNv
        wFIZhtyyx2ADki7Si/DjhzZVsLSVY5gIRjcSQLGcgQ==
X-Google-Smtp-Source: ABdhPJw0lgiD+qkfnFE0ywDfuTzMV+8e+bVIm3cOn/bK21wlW0F0sSuD8murJaR508c7NLifiZ3ei8uq1COTmdDPJSE=
X-Received: by 2002:a05:600c:354c:: with SMTP id i12mr133300wmq.59.1634746127808;
 Wed, 20 Oct 2021 09:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-2-guoren@kernel.org>
 <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org> <f850af365f2ac77af79ec59f92e6434a@kernel.org>
 <CAJF2gTShT8Tvk0z6B52zKEi0vq_toc-7mAKWFKj3j-zg=OhpYQ@mail.gmail.com>
 <8735oxuxlq.wl-maz@kernel.org> <CAJF2gTSmyu9nA5M3QLeR1LdGMkeGb7jE93Z9zjixcpb_freLMw@mail.gmail.com>
 <875ytrddma.wl-maz@kernel.org> <CAAhSdy0TwOjv_RDMRsKqcqTE8PSO_A_EttMGBiDbb-0PTRizZg@mail.gmail.com>
 <871r4fd996.wl-maz@kernel.org>
In-Reply-To: <871r4fd996.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 20 Oct 2021 21:38:36 +0530
Message-ID: <CAAhSdy24WRZP70C0HUA1y0nVf0yWdj4SYY8HhGSfxQzDdafYnQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] irqchip/sifive-plic: Add thead,c900-plic support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>, Samuel Holland <samuel@sholland.org>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 8:38 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Wed, 20 Oct 2021 15:33:49 +0100,
> Anup Patel <anup@brainfault.org> wrote:
> >
> > On Wed, Oct 20, 2021 at 7:04 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Tue, 19 Oct 2021 14:27:02 +0100,
> > > Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > On Tue, Oct 19, 2021 at 6:18 PM Marc Zyngier <maz@kernel.org> wrote:
> > > > >
> > > > > On Tue, 19 Oct 2021 10:33:49 +0100,
> > > > > Guo Ren <guoren@kernel.org> wrote:
> > > > >
> > > > > > > If you have an 'automask' behavior and yet the HW doesn't record this
> > > > > > > in a separate bit, then you need to track this by yourself in the
> > > > > > > irq_eoi() callback instead. I guess that you would skip the write to
> > > > > > > the CLAIM register in this case, though I have no idea whether this
> > > > > > > breaks
> > > > > > > the HW interrupt state or not.
> > > > > > The problem is when enable bit is 0 for that irq_number,
> > > > > > "writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM)" wouldn't affect
> > > > > > the hw state machine. Then this irq would enter in ack state and no
> > > > > > continues irqs could come in.
> > > > >
> > > > > Really? This means that you cannot mask an interrupt while it is being
> > > > > handled? How great...
> > > > If the completion ID does not match an interrupt source that is
> > > > currently enabled for the target, the completion is silently ignored.
> > > > So, C9xx completion depends on enable-bit.
> > >
> > > Is that what the PLIC spec says? Or what your implementation does? I
> > > can understand that one implementation would be broken, but if the
> > > PLIC architecture itself is broken, that's far more concerning.
> >
> > Yes, we are dealing with a broken/non-compliant PLIC
> > implementation.
> >
> > The RISC-V PLIC spec defines a very different behaviour for the
> > interrupt claim (i.e. readl(claim)) and interrupt completion (i.e.
> > writel(claim)). The T-HEAD PLIC implementation does things
> > different from what the RISC-V PLIC spec says because it will
> > mask an interrupt upon interrupt claim whereas PLIC spec says
> > it should only clear the interrupt pending bit (not mask the interrupt).
> >
> > Quoting interrupt claim process (chapter 9) from PLIC spec:
> > "The PLIC can perform an interrupt claim by reading the claim/complete
> > register, which returns the ID of the highest priority pending interrupt or
> > zero if there is no pending interrupt. A successful claim will also atomically
> > clear the corresponding pending bit on the interrupt source."
> >
> > Refer, https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc
>
> That's not the point I'm making. According to Guo, the PLIC (any
> implementation of it) will ignore a write to claim on a masked
> interrupt.

Yes, write to claim on a masked interrupt is certainly ignored but
read to claim does not automatically mask the interrupt.

>
> If that's indeed correct, then a sequence such as:
>
> (1) irq = read(claim)

This will return highest priority pending interrupt and clear the
pending bit as-per RISC-V PLIC spec.

> (2) mask from the interrupt handler with the right flags so that it
> isn't done lazily
> (3) write(irq, claim)
>
> will result in an interrupt blocked in ack state (and probably no more
> interrupt for this CPU at this priority). That would be an interesting
> bug in the current code, but also a pretty bad architectural choice.

The interrupt claim/completion is for each interrupt and not at CPU
level so if an interrupt is masked then only that interrupt is blocked
for all CPUs but other interrupts can still be raised.

Regards,
Anup

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
