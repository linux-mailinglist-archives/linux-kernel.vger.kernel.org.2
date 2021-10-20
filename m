Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A056C434DE2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJTOgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTOgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:36:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC56C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:34:02 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id b189-20020a1c1bc6000000b0030da052dd4fso10756047wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2cFhehtw2gzRQk7Qa6LrKMw4p/s424MMljllyART0OQ=;
        b=AozxwGNX1yZicLViDzo3g9qk+ZLtZUTbsDbPza3yuLLX0exN8SQocXpMAs82x0J2Fj
         ShRocDJEA4dvWf4HAr6z48A1cFOCacAAw5fAaIlnUSK4yzz2tkBKJmmM9b7VrNFkV+PL
         lqGheu4GzqpDpXsz4JXS9FZexzPqvdbukqLcPf4+k/HhevODyvG6P70pGICcWnIRQozY
         PolO+6ZnHvvvEBw6ADvUY///dRLh0dXNmoK3BX+xl4e7VSgS0U4mbrNq3d5BkCMxyCJD
         flpOopZQDSR/xkCf3HoxX4DhyDvhfYEmU8ipxoq0pPanRXNzG+UdRbOHrBxxryfOhWBj
         NzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2cFhehtw2gzRQk7Qa6LrKMw4p/s424MMljllyART0OQ=;
        b=m+DD6vTlrfjRC/yTOzSmTpTsiQDgK00gLIBwXB6DeqP7xAUOWpjg+uiJUOKCmzm9Ok
         yQoONecuzhT6dsOPDjuOW3L2e3Y22ZvD5Gt85vAeRucpN486A1UeBYfW3Dh2Q4Bg6mvf
         N/kX19tOmAGZQLMWtsAQB8jcr+xFVTRXritNhs6Om29LiN8H9f46NeRt9l2cinXT6m1i
         /lvZjpb+RE6KoUQ6ixC66i59WBuve9YBmppN3r63NerMpdAbNT1MQvNQOrdQtf4HvgYu
         CmJa6cQy6oCIB0KIWlCI5Ox6xBcf15kNmt2FirbYXgaoLcXmxNppbAaOqVW4tlngxLbI
         bKBw==
X-Gm-Message-State: AOAM533voFfza3OvvwXdIY+uXv5xeAWDZsMPpeHhDZl6zmv9GkbbEiKh
        03crFwalYyaKu9S4M7REpPI0rDv7HstDg63K+oENdA==
X-Google-Smtp-Source: ABdhPJxOi8BJgXt9VNr5faBTIJ6D21SoWMk2EhW2bVdZhetIJAIWNF4EaEbsXB80didI86Wohcyh6UJsDvVe+okzzcU=
X-Received: by 2002:adf:f60e:: with SMTP id t14mr68513wrp.199.1634740441250;
 Wed, 20 Oct 2021 07:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-2-guoren@kernel.org>
 <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org> <f850af365f2ac77af79ec59f92e6434a@kernel.org>
 <CAJF2gTShT8Tvk0z6B52zKEi0vq_toc-7mAKWFKj3j-zg=OhpYQ@mail.gmail.com>
 <8735oxuxlq.wl-maz@kernel.org> <CAJF2gTSmyu9nA5M3QLeR1LdGMkeGb7jE93Z9zjixcpb_freLMw@mail.gmail.com>
 <875ytrddma.wl-maz@kernel.org>
In-Reply-To: <875ytrddma.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 20 Oct 2021 20:03:49 +0530
Message-ID: <CAAhSdy0TwOjv_RDMRsKqcqTE8PSO_A_EttMGBiDbb-0PTRizZg@mail.gmail.com>
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

On Wed, Oct 20, 2021 at 7:04 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 19 Oct 2021 14:27:02 +0100,
> Guo Ren <guoren@kernel.org> wrote:
> >
> > On Tue, Oct 19, 2021 at 6:18 PM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On Tue, 19 Oct 2021 10:33:49 +0100,
> > > Guo Ren <guoren@kernel.org> wrote:
> > >
> > > > > If you have an 'automask' behavior and yet the HW doesn't record this
> > > > > in a separate bit, then you need to track this by yourself in the
> > > > > irq_eoi() callback instead. I guess that you would skip the write to
> > > > > the CLAIM register in this case, though I have no idea whether this
> > > > > breaks
> > > > > the HW interrupt state or not.
> > > > The problem is when enable bit is 0 for that irq_number,
> > > > "writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM)" wouldn't affect
> > > > the hw state machine. Then this irq would enter in ack state and no
> > > > continues irqs could come in.
> > >
> > > Really? This means that you cannot mask an interrupt while it is being
> > > handled? How great...
> > If the completion ID does not match an interrupt source that is
> > currently enabled for the target, the completion is silently ignored.
> > So, C9xx completion depends on enable-bit.
>
> Is that what the PLIC spec says? Or what your implementation does? I
> can understand that one implementation would be broken, but if the
> PLIC architecture itself is broken, that's far more concerning.

Yes, we are dealing with a broken/non-compliant PLIC
implementation.

The RISC-V PLIC spec defines a very different behaviour for the
interrupt claim (i.e. readl(claim)) and interrupt completion (i.e.
writel(claim)). The T-HEAD PLIC implementation does things
different from what the RISC-V PLIC spec says because it will
mask an interrupt upon interrupt claim whereas PLIC spec says
it should only clear the interrupt pending bit (not mask the interrupt).

Quoting interrupt claim process (chapter 9) from PLIC spec:
"The PLIC can perform an interrupt claim by reading the claim/complete
register, which returns the ID of the highest priority pending interrupt or
zero if there is no pending interrupt. A successful claim will also atomically
clear the corresponding pending bit on the interrupt source."

Refer, https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc

Regards,
Anup

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
