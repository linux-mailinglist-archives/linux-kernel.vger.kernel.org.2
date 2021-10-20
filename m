Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40F5434D52
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 16:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbhJTOVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 10:21:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhJTOVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 10:21:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D79061373
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634739558;
        bh=fmi+0bD2m3tiuIJS1w2in+x3YNM1wstFL0HPNrVRe8w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nM3r90b+dwpLL60m0jQscBK0+9Dy10kOWm8uy3/ZKXvif0JDmcnttvbMSqaGcQdLD
         2pHlz2QbN3JzW7UNHBX4lhtaqgzf4U+qF4SQVX3zDuZ8+rVuUlWEqHDf9CPhyrNgBQ
         Xx0AId1V0cQVBKlDBQo3+/XzyWBC71teBm/ATWEkXVDIvs6Ll5RwJUtvSP/mxugprK
         82HFFUsNi7APytpsZdVE8PQH20BU/jU8siZjU7+ozj15+Z6RWZNh7Se5vYoDj/HPzY
         ebPRveXrldpuKIXDineCR7swtCwqJSh7qhdme95Q+y+qweD8vRoWoZzrN099ojeNxO
         WucXNcR8pUNpQ==
Received: by mail-ua1-f54.google.com with SMTP id q13so6958548uaq.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 07:19:18 -0700 (PDT)
X-Gm-Message-State: AOAM530XzF5k61WQ5ZJ0fuONqR1lw2jDkK9+pMzZFZDnvgoMGlioOKSe
        FG2OyKnfjtkha2rPVqrEsYl7NQpa/zNLIC3uJA8=
X-Google-Smtp-Source: ABdhPJxZX28p4AF2/Hb9dreu2KHUeZrpaHIutQS8IPPcSp3vbwrlkYw+gqn6YZxqPEz2uCrP8JhM/gweaUQ8SVFl0Lc=
X-Received: by 2002:ab0:5b59:: with SMTP id v25mr7354848uae.57.1634739556855;
 Wed, 20 Oct 2021 07:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-2-guoren@kernel.org>
 <8be1bdbd-365d-cd28-79d7-b924908f9e39@sholland.org> <f850af365f2ac77af79ec59f92e6434a@kernel.org>
 <CAJF2gTShT8Tvk0z6B52zKEi0vq_toc-7mAKWFKj3j-zg=OhpYQ@mail.gmail.com>
 <8735oxuxlq.wl-maz@kernel.org> <CAJF2gTSmyu9nA5M3QLeR1LdGMkeGb7jE93Z9zjixcpb_freLMw@mail.gmail.com>
 <875ytrddma.wl-maz@kernel.org>
In-Reply-To: <875ytrddma.wl-maz@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 20 Oct 2021 22:19:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRfBxXnG57Y+9z0O+GfwgoB9POmb=HL=CMCpu=uwfYY3w@mail.gmail.com>
Message-ID: <CAJF2gTRfBxXnG57Y+9z0O+GfwgoB9POmb=HL=CMCpu=uwfYY3w@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] irqchip/sifive-plic: Add thead,c900-plic support
To:     Marc Zyngier <maz@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Anup Patel <anup@brainfault.org>,
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

On Wed, Oct 20, 2021 at 9:34 PM Marc Zyngier <maz@kernel.org> wrote:
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

Here is the description of Interrupt Completion in PLIC spec [1]:

The PLIC signals it has completed executing an interrupt handler by
writing the interrupt ID it received from the claim to the claim/complete
register. The PLIC does not check whether the completion ID is the same
as the last claim ID for that target. If the completion ID does not match
an interrupt source that is currently enabled for the target, the
                                      ^^ ^^^^^^^^^ ^^^^^^^
completion is silently ignored.

[1] https://github.com/riscv/riscv-plic-spec/blob/master/riscv-plic.adoc

Did we misunderstand the PLIC spec?

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
