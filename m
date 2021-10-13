Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B602D42B117
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235306AbhJMAuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234265AbhJMAuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:50:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D25D660EDF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634086080;
        bh=a6HAceh2igYZ/jHxri/gKKRe+lR1pmv01NNdtrqIyGY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mLX8E04C7L4HGCzGqu639GlpJmRrd1wcJtrYvlHfM72UJu7yTwlYggsxJSDdxB32c
         eRzy2FQWSx87AhMoBjYCMCOtr3ApW0ozKXPOHLnzcPDUiNELIZDHeqLl7AyrSpzngR
         /T60PvKvmdnwVrWwCh1iA6/dHW6/BrcCi/+smbU/koEvlZX7J5zgmLRD7rWqk2iKtd
         wjwOOkfQgRmTDvQHhLoI9m4Xxr0SKVGJMDxQCvSOKpkH3QJVWYbJRbf/X1Fz+NN6gH
         iQaAjY3ryZBaANp5QH8Cd+SRNZVW49x9h0LSDJnkU/2+2l9c7/wY1Ba/hahm7W9yYN
         dPfoOQxBeoNGg==
Received: by mail-vk1-f181.google.com with SMTP id l39so802811vkd.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 17:48:00 -0700 (PDT)
X-Gm-Message-State: AOAM5337tmDub5F8wS9s1XYU7vnUtCRCnfff4SwFBVtULGeHOnXxEJ5b
        ZB+bONCwctHV+J3ylmd7D5STQ4ANOg4IKgLCoHM=
X-Google-Smtp-Source: ABdhPJwuAeXffmbONs1Dm69zu98tZn1ZPM4jYu8FThhRGYdQvURZeKDofJtl/UtQQNoUTDmqIukoBu7Zkg/YVcYLt/A=
X-Received: by 2002:a67:c08d:: with SMTP id x13mr35590851vsi.43.1634086079921;
 Tue, 12 Oct 2021 17:47:59 -0700 (PDT)
MIME-Version: 1.0
References: <20211012153432.2817285-1-guoren@kernel.org> <20211012153432.2817285-2-guoren@kernel.org>
 <CAAhSdy32wkwH5k3iwdUNDsXjUNX8icQwcz_h2E6UixH7ZmD5KQ@mail.gmail.com> <4404316.9H8m7z83OK@diego>
In-Reply-To: <4404316.9H8m7z83OK@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Oct 2021 08:47:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTjuyE2TbsieRiw7sGR1_2kqdfwSS3pvhc7_6C2b8zJZQ@mail.gmail.com>
Message-ID: <CAJF2gTTjuyE2TbsieRiw7sGR1_2kqdfwSS3pvhc7_6C2b8zJZQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] irqchip/sifive-plic: Add thead,c9xx-plic support
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <anup@brainfault.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 7:06 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Dienstag, 12. Oktober 2021, 18:40:26 CEST schrieb Anup Patel:
> > On Tue, Oct 12, 2021 at 9:04 PM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > thead,c9xx-plic would mask IRQ with readl(claim), so it needn't
> > > mask/unmask which needed in RISC-V PLIC.
> > >
> > > When in IRQS_ONESHOT & IRQCHIP_EOI_THREADED path, unnecessary mask
> > > operation would cause a blocking irq bug in thead,c9xx-plic. Because
> > > when IRQ is disabled in c9xx, writel(hwirq, claim) would be invalid.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Cc: Anup Patel <anup@brainfault.org>
> > > Cc: Thomas Gleixner <tglx@linutronix.de>
> > > Cc: Marc Zyngier <maz@kernel.org>
> > > Cc: Palmer Dabbelt <palmer@dabbelt.com>
> > > Cc: Atish Patra <atish.patra@wdc.com>
> > >
> > > ---
> > >
> > > Changes since V2:
> > >  - Add a separate compatible string "thead,c9xx-plic"
> > >  - set irq_mask/unmask of "plic_chip" to NULL and point
> > >    irq_enable/disable of "plic_chip" to plic_irq_mask/unmask
> > >  - Add a detailed comment block in plic_init() about the
> > >    differences in Claim/Completion process of RISC-V PLIC and C9xx
> > >    PLIC.
> > > ---
> > >  drivers/irqchip/irq-sifive-plic.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-=
sifive-plic.c
> > > index cf74cfa82045..3756b1c147c3 100644
> > > --- a/drivers/irqchip/irq-sifive-plic.c
> > > +++ b/drivers/irqchip/irq-sifive-plic.c
> > > @@ -79,6 +79,7 @@ struct plic_handler {
> > >  };
> > >  static int plic_parent_irq __ro_after_init;
> > >  static bool plic_cpuhp_setup_done __ro_after_init;
> > > +static bool disable_mask_unmask __ro_after_init;
> > >  static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
> > >
> > >  static inline void plic_toggle(struct plic_handler *handler,
> > > @@ -181,6 +182,13 @@ static int plic_irqdomain_map(struct irq_domain =
*d, unsigned int irq,
> > >  {
> > >         struct plic_priv *priv =3D d->host_data;
> > >
> > > +       if (disable_mask_unmask) {
> > > +               plic_chip.irq_mask      =3D NULL;
> > > +               plic_chip.irq_unmask    =3D NULL;
> > > +               plic_chip.irq_enable    =3D plic_irq_unmask;
> > > +               plic_chip.irq_disable   =3D plic_irq_mask;
> > > +       }
> > > +
> > >         irq_domain_set_info(d, irq, hwirq, &plic_chip, d->host_data,
> > >                             handle_fasteoi_irq, NULL, NULL);
> > >         irq_set_noprobe(irq);
> > > @@ -390,5 +398,14 @@ static int __init plic_init(struct device_node *=
node,
> > >         return error;
> > >  }
> > >
> > > +static int __init thead_c9xx_plic_init(struct device_node *node,
> > > +               struct device_node *parent)
> > > +{
> > > +       disable_mask_unmask =3D true;
> >
> > The plic_irqdomain_map() is called for each irq so "plic_chip"
> > will be updated multiple times.
> >
> > You can drop the disable_mask_unmask variable and instead
> > directly update "plic_chip" here.
>
> Actually I'd think something more dynamic might be appropriate?
>
> I.e. don't modify the generic plic_chip structure, but define a second
> one for this type of chip and reference that one in plic_irqdomain_map
> depending on the block found?
>
> According to [0] a system can have multiple PLICs and nothing
> guarantees that they'll always be the same variant on future socs
> [hardware engineers are very creative]
>
> So adding more stuff that modifies static content used by all PLICs
> doesn't really improve driver quality here ;-)
Agree, I like your style because it also could make cat
/proc/interrupts name properly.

static struct irq_chip sifive_plic_chip =3D {
        .name           =3D "SiFive PLIC",

static struct irq_chip thead_plic_chip =3D {
        .name           =3D "T-HEAD PLIC",
>
>
> Heiko
>
>
> [0] https://lore.kernel.org/linux-riscv/1839bf9ef91de2358a7e8ecade361f7a@=
www.loen.fr/T/
>
>
> >
> > > +
> > > +       return plic_init(node, parent);
> > > +}
> > > +
> > >  IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
> > >  IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legac=
y systems */
> > > +IRQCHIP_DECLARE(thead_c9xx_plic, "thead,c9xx-plic", thead_c9xx_plic_=
init);
> > > --
> > > 2.25.1
> > >
> >
> > Regards,
> > Anup
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
>
>
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
