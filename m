Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B023440860
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 12:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhJ3KaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 06:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbhJ3K37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 06:29:59 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39ED6C061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 03:27:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id p14so20592854wrd.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 03:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00D8zl/w7yQbU3CfyVaAz58+MxxvUD0z083tR5Sb+l4=;
        b=PmsNF0xHqLuHIOEmmF3lWCKBywHii0lbygo2kOEIqSn1ji0Q3egoRkxdlzJn494Xkm
         BV/Ry7BsmScRNpVG+ZFVy7H06u8NTJ2Kj3Klsa62537XqzzjryBs0YljJRfByfNv+F1I
         nkKJ2AgeGdABQTZu/eSXMAmlhZ2YFaqpg3bGM8Py1ACFVfjNmS37FhcIcN/YwnayCK07
         zgQ7uR7416/mGw2q3vLPqA41JFkG0+DSwV1z6/iblDUwgjfQO7Y8RDWFgBCFG+BNcIq+
         fC+8CtL9sLn3m3O2B2eVExuBy3L8iboNg3TMUSYbGPXqgUCgqlHPQ6WSSbcz94ahhAyH
         gJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00D8zl/w7yQbU3CfyVaAz58+MxxvUD0z083tR5Sb+l4=;
        b=CnGzq4W6ByklocqeoQ6jKM9fDonU6fj/eZc37ZQKz+galHPvuoDCnMiSH4LDvzkTup
         h6lkXP/+mT6ulgv0QMEfDMvXKDwYltOT+28cCGAaNKF4JC4n6+JLs7uvoKw0agkOfPf6
         CM6rArreJ1Uno4jBMUyagovrxkZkPKLaeGgrFd5rfRXy8QZB9UvMpiLjvEs9KZhd5Ocx
         cHkVEXjaFGjlsCXvaeSXrB9F/CJIQLdxFD1xBTcUT9GO6yz2YqdKx3HRUtp8QK3pxjjC
         v/Uykt/+WqEjSRPhb9M5A891N4nM2NWi2gNuuV9fD8KSXhwjrd8IRYLcuPvYbVcWi4yF
         Bcog==
X-Gm-Message-State: AOAM531cgaXz1p+rbDiRc0p2pCzHZyceuKHf8Xy9HZH7hYmX/woHBQge
        OPk4Cp6Y+1rSKYIWrZIMVYnGn9yz6vwmsGX6Q1h05gzPBjimGw==
X-Google-Smtp-Source: ABdhPJxVqlYF2HwtysH6iDwffuQq6BB03SGMWpDRIMQpOak0tjIikXlTh2VE13NHeGmqYIf6q0xgeSEMw5FodUyCPkQ=
X-Received: by 2002:a05:6000:1a89:: with SMTP id f9mr21361369wry.249.1635589647516;
 Sat, 30 Oct 2021 03:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-4-guoren@kernel.org>
 <87a6ixbcse.wl-maz@kernel.org> <20211028135523.5cf4b66b@redslave.neermore.group>
 <87sfwl9oxg.wl-maz@kernel.org>
In-Reply-To: <87sfwl9oxg.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 30 Oct 2021 15:57:16 +0530
Message-ID: <CAAhSdy3+vaUODbVbjQtUbB+exjrsrY3CitNvzEEcrh_nSBg6yA@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] irqchip/sifive-plic: Fixup thead, c900-plic
 request_threaded_irq with ONESHOT
To:     Marc Zyngier <maz@kernel.org>
Cc:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Guo Ren <guoren@kernel.org>, Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 8:28 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 28 Oct 2021 11:55:23 +0100,
> Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> >
> > Hello Marc and Guo Ren!
> >
> > On Mon, 25 Oct 2021 11:48:33 +0100
> > Marc Zyngier <maz@kernel.org> wrote:
> >
> > > On Sun, 24 Oct 2021 02:33:03 +0100,
> > > guoren@kernel.org wrote:
> > > >
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" in the
> > > > driver, only the first interrupt could be handled, and continue irq
> > > > is blocked by hw. Because the thead,c900-plic couldn't complete
> > > > masked irq source which has been disabled in enable register. Add
> > > > thead_plic_chip which fix up c906-plic irq source completion
> > > > problem by unmask/mask wrapper.
> > > >
> > > > Here is the description of Interrupt Completion in PLIC spec [1]:
> > > >
> > > > The PLIC signals it has completed executing an interrupt handler by
> > > > writing the interrupt ID it received from the claim to the
> > > > claim/complete register. The PLIC does not check whether the
> > > > completion ID is the same as the last claim ID for that target. If
> > > > the completion ID does not match an interrupt source that is
> > > > currently enabled for the target, the ^^ ^^^^^^^^^ ^^^^^^^
> > > > completion is silently ignored.
> > >
> > > Given this bit of the spec...
> > >
> > > > +static void plic_thead_irq_eoi(struct irq_data *d)
> > > > +{
> > > > + struct plic_handler *handler =
> > > > this_cpu_ptr(&plic_handlers); +
> > > > + if (irqd_irq_masked(d)) {
> > > > +         plic_irq_unmask(d);
> > > > +         writel(d->hwirq, handler->hart_base +
> > > > CONTEXT_CLAIM);
> > > > +         plic_irq_mask(d);
> > > > + } else {
> > > > +         writel(d->hwirq, handler->hart_base +
> > > > CONTEXT_CLAIM);
> > > > + }
> > > > +}
> > > > +
> > >
> > > ... it isn't obvious to me why this cannot happen on an SiFive PLIC.
> >
> > This indeed happens with SiFive PLIC. I am currently tinkering with
> > da9063 RTC on SiFive Unmatched, and ALARM irq fires only once. However
> > with changes proposed by Guo Ren in plic_thead_irq_eoi, everything
> > begins to work fine.
> >
> > May be these change should be propagated to plic_irq_eoi instead of
> > making a new function ?
>
> That's my impression too. I think the T-Head defect is pretty much
> immaterial when you consider how 'interesting' the PLIC architecture
> is. Conflating EOI and masking really is a misfeature...

Unfortunately, the PLIC implementation is the same across existing
boards (except T-HEAD) so this issue is there on all existing boards.

I double checked the upcoming RISC-V AIA specification and this
problem is not there in RISC-V AIA because the interrupt claim/completion
is different.
(Refer, https://github.com/riscv/riscv-aia/releases/download/0.2-draft.27/riscv-interrupts-027.pdf)

I plan to send-out RFC PATCH for AIA soon so that we get early
feedback from everyone on LKML.

Regards,
Anup

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
