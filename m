Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E31E441486
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 08:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhKAH7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 03:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229882AbhKAH7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 03:59:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 464D460F56
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 07:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635753402;
        bh=TBzEfh4UWc/gUlf4onT3eyLw52Cjhrz+B9wb/eT2Ekk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hNl2rukHiKsM9YW4n26JFDlaEa7C3kSeR2TfQcEzFW0TxguD3kP+yvAT5kKbAlrp1
         FsHAJ9CwtvCkejbXbYDHxQVZP1/HZPhRlnOGQs6fcRhBILwcG2IdxvbEMVDebk1z01
         ebsEe3pyDyE2zhndURAKLCVnltM/tpSA+DXxyD1oXQNSUUJQwSvfshVO9QgtPPgnFs
         uDvUGV2JWZ1Kgm1OGFQfkG29xYGyFAhf8lyI/j/nBK3a/Kb84a6qBd875+IyzdFQaX
         O40F95tGxgRvdelGHBdMc5TTjJ/SQGziopcAozxSfKyTKhQxv5/HMc2PL9K4U/uP6O
         wKpQVs0YsRNAw==
Received: by mail-ua1-f54.google.com with SMTP id q13so30404152uaq.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 00:56:42 -0700 (PDT)
X-Gm-Message-State: AOAM530AwmnEqjLn1KoM31jLjpJZpLuDN8OB0K8dosbe99gGgJCyiXdT
        8XqkrUfcmeDdx8jW25E08gjpxKbpXkedfFWod64=
X-Google-Smtp-Source: ABdhPJwkzeYQJNhGI/wkjlGHlXo2oAgLD7FNzJun23uvED1t+XI6+VUtKDcHjgfZW/6tz0GZHEAAMbveF0p9UiY6mNQ=
X-Received: by 2002:ab0:728e:: with SMTP id w14mr25512432uao.97.1635753401252;
 Mon, 01 Nov 2021 00:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-4-guoren@kernel.org>
 <87a6ixbcse.wl-maz@kernel.org> <20211028135523.5cf4b66b@redslave.neermore.group>
 <87sfwl9oxg.wl-maz@kernel.org> <CAJF2gTR3CqtmKZKS3fOQ9mzSLn7_oh7YoSSmWP1YM=ujB_srMw@mail.gmail.com>
 <CAAhSdy1WrxbMsiWkwOXd_76A6wNAh05C1QQ-oFXoE9U-F0akiA@mail.gmail.com>
 <CAJF2gTRwi+yH-hQ0SHKDOuUf=OOMfJxQb6Q5m6xRCPjvbYjqaQ@mail.gmail.com> <CAAhSdy3r2oVOq9yd+ZkOs1oCHRH-qvjLDa25Jp3qeD1tSxWEWQ@mail.gmail.com>
In-Reply-To: <CAAhSdy3r2oVOq9yd+ZkOs1oCHRH-qvjLDa25Jp3qeD1tSxWEWQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Nov 2021 15:56:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTecsYE9HM-_XfBWFQ6sbHE0x1=6up5wD+yfX0QjXTyLA@mail.gmail.com>
Message-ID: <CAJF2gTTecsYE9HM-_XfBWFQ6sbHE0x1=6up5wD+yfX0QjXTyLA@mail.gmail.com>
Subject: Re: [PATCH V5 3/3] irqchip/sifive-plic: Fixup thead, c900-plic
 request_threaded_irq with ONESHOT
To:     Anup Patel <anup@brainfault.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 1, 2021 at 12:28 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Mon, Nov 1, 2021 at 9:27 AM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Mon, Nov 1, 2021 at 10:53 AM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Mon, Nov 1, 2021 at 7:50 AM Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > On Thu, Oct 28, 2021 at 10:58 PM Marc Zyngier <maz@kernel.org> wrot=
e:
> > > > >
> > > > > On Thu, 28 Oct 2021 11:55:23 +0100,
> > > > > Nikita Shubin <nikita.shubin@maquefel.me> wrote:
> > > > > >
> > > > > > Hello Marc and Guo Ren!
> > > > > >
> > > > > > On Mon, 25 Oct 2021 11:48:33 +0100
> > > > > > Marc Zyngier <maz@kernel.org> wrote:
> > > > > >
> > > > > > > On Sun, 24 Oct 2021 02:33:03 +0100,
> > > > > > > guoren@kernel.org wrote:
> > > > > > > >
> > > > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > > > >
> > > > > > > > When using "devm_request_threaded_irq(,,,,IRQF_ONESHOT,,)" =
in the
> > > > > > > > driver, only the first interrupt could be handled, and cont=
inue irq
> > > > > > > > is blocked by hw. Because the thead,c900-plic couldn't comp=
lete
> > > > > > > > masked irq source which has been disabled in enable registe=
r. Add
> > > > > > > > thead_plic_chip which fix up c906-plic irq source completio=
n
> > > > > > > > problem by unmask/mask wrapper.
> > > > > > > >
> > > > > > > > Here is the description of Interrupt Completion in PLIC spe=
c [1]:
> > > > > > > >
> > > > > > > > The PLIC signals it has completed executing an interrupt ha=
ndler by
> > > > > > > > writing the interrupt ID it received from the claim to the
> > > > > > > > claim/complete register. The PLIC does not check whether th=
e
> > > > > > > > completion ID is the same as the last claim ID for that tar=
get. If
> > > > > > > > the completion ID does not match an interrupt source that i=
s
> > > > > > > > currently enabled for the target, the ^^ ^^^^^^^^^ ^^^^^^^
> > > > > > > > completion is silently ignored.
> > > > > > >
> > > > > > > Given this bit of the spec...
> > > > > > >
> > > > > > > > +static void plic_thead_irq_eoi(struct irq_data *d)
> > > > > > > > +{
> > > > > > > > + struct plic_handler *handler =3D
> > > > > > > > this_cpu_ptr(&plic_handlers); +
> > > > > > > > + if (irqd_irq_masked(d)) {
> > > > > > > > +         plic_irq_unmask(d);
> > > > > > > > +         writel(d->hwirq, handler->hart_base +
> > > > > > > > CONTEXT_CLAIM);
> > > > > > > > +         plic_irq_mask(d);
> > > > > > > > + } else {
> > > > > > > > +         writel(d->hwirq, handler->hart_base +
> > > > > > > > CONTEXT_CLAIM);
> > > > > > > > + }
> > > > > > > > +}
> > > > > > > > +
> > > > > > >
> > > > > > > ... it isn't obvious to me why this cannot happen on an SiFiv=
e PLIC.
> > > > > >
> > > > > > This indeed happens with SiFive PLIC. I am currently tinkering =
with
> > > > > > da9063 RTC on SiFive Unmatched, and ALARM irq fires only once. =
However
> > > > > > with changes proposed by Guo Ren in plic_thead_irq_eoi, everyth=
ing
> > > > > > begins to work fine.
> > > > > >
> > > > > > May be these change should be propagated to plic_irq_eoi instea=
d of
> > > > > > making a new function ?
> > > > >
> > > > > That's my impression too. I think the T-Head defect is pretty muc=
h
> > > > > immaterial when you consider how 'interesting' the PLIC architect=
ure
> > > > > is.
> > > > Which is the "T-Head defect" you mentioned here?
> > > >  1. Auto masking with claim + complete (I don't think it's a defect=
,
> > > > right? May I add a new patch to utilize the feature to decrease a
> > > > little duplicate mask/unmask operations in the future?)
> > >
> > > This is definitely a defect and non-compliance for T-HEAD because
> > I just agree with non-compliance, but what's the defect of
> > auto-masking? If somebody could explain, I'm very grateful.
> >
> > > no sane interrupt controller would mask interrupt upon claim and this
> > > is not what RISC-V PLIC defines.
> > >
> > > >  2. EOI failed when masked
> > >
> > > This defect exists for both RISC-V PLIC and T-HEAD PLIC
> > > because of the way interrupt completion is defined.
> > >
> > > >
> > > > > Conflating EOI and masking really is a misfeature...
> > > > I think the problem is riscv PLIC reuse enable bit as mask bit. I
> > > > recommend separating them. That means:
> > >
> > > There are no per-interrupt mask bits. We only have per-context
> > > and per-interrupt enable bits which is used to provide mask/unmask
> > > functionality expected by the irqchip framework.
> > >
> > > I don't see how this is a problem for RISC-V PLIC. The only real
> > > issue with RISC-V PLIC is the fact the interrupt completion will be
> > > ignored for a masked interrupt which is what Marc is pointing at.
> > So you are not considering add per-interrupt mask bits to solve the
> > above problem, right?
>
> The RISC-V PLIC has several limitations and also lacks a lot of features
> hence it's marked as deprecated in RISC-V platform specs and will be
> removed eventually from RISC-V platform specs.
>
> The RISC-V AIA will totally replace RISC-V PLIC going forward. In fact,
> RISC-V AIA APLIC addresses all limitations of RISC-V PLIC along with
> new features additions.
>
> >
> > I don't think you would keep below codes in AIA eoi.
> >  +             plic_irq_unmask(d);
> >  +             writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> >  +             plic_irq_mask(d);
>
> Like I mentioned previously, the AIA APLIC is very different from the
> PLIC so we don't need this mask/unmask dance over there. It has global
> per-interrupt enable bits in AIA APLIC which is different from PLIC.
The =E2=80=9Dglobal per-interrupt enable bits=E2=80=9C is okay.

>
> Regards,
> Anup
>
> >
> > >
> > > Regards,
> > > Anup
> > >
> > > >  - EOI still depends on enable bit.
> > > >  - Add mask/unmask bit regs to do the right thing.
> > >
> > >
> > >
> > > >
> > > > >
> > > > >         M.
> > > > >
> > > > > --
> > > > > Without deviation from the norm, progress is not possible.
> > > >
> > > >
> > > >
> > > > --
> > > > Best Regards
> > > >  Guo Ren
> > > >
> > > > ML: https://lore.kernel.org/linux-csky/
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
