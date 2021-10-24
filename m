Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6AB4387F2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhJXJhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 05:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:47492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhJXJhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:37:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAE3D60FC3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 09:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635068114;
        bh=IlbU6KyJkBI1Z94Cc9kky5MxQqGU06IDmh+4HRt23lc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YUSKlxnb+jfZTpF147lXJBflAnb+RzN0O79cz4IJyeXTFddfj0iqnc+Msa6CuaIBf
         0ssbB4d18zgk7SUIVsIDdAqOi65okgGyK7uK7Hp4+VjOI4+tu98MAwTGECRnnGKM7K
         pTe7IgxsIvh1B+iJKRnZPIGWbOMMj/BloapKxoFONdwWXg2eyfEh3QoRG/NpwVn7lh
         /dxEb8EyuIQgg3EBaxqcFz3y67wRwOYyxaAguawwIRYeaWzYGeZ1xAK4r8VoDzIGtl
         lRq62BihGX7KwOmIjIsKfci1TyD/yvA44hhQ7+peTuW5CTP17Lno0EJ0D+0LuMediF
         MCX879F3emHXg==
Received: by mail-ua1-f44.google.com with SMTP id b4so4020515uaq.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 02:35:13 -0700 (PDT)
X-Gm-Message-State: AOAM531/HIHuC1K3OpYEw/oLhPxfah9srptrqQDHCHlZEys9YgeL472V
        XKBycwFIj/TssMFSuz/gbQNxHgKlFQ6i/T3EIxw=
X-Google-Smtp-Source: ABdhPJzobizkWZ1xrNx3JCykrkXO8I6K24jGJAu3bnZIpb6l0D8xrjYiPaFYN9bw8oVlIQB2yLAfWWu6lra390XSfj8=
X-Received: by 2002:a05:6102:6c1:: with SMTP id m1mr10405969vsg.28.1635068112938;
 Sun, 24 Oct 2021 02:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-3-guoren@kernel.org>
 <CAAhSdy2a2XgjOpezoq=SvX2XTcAWhceKF9X9v3z7xyO9Z4DMPQ@mail.gmail.com>
 <CAJF2gTTKJXY6DAq=-ajAiTEY7hpMT1bqnvNndW=5EnD5EEP-cw@mail.gmail.com> <CAAhSdy1FfMGPWBExEVe9Vdh2s_fNP43Rp7jNdEMNmP1nmPZL_Q@mail.gmail.com>
In-Reply-To: <CAAhSdy1FfMGPWBExEVe9Vdh2s_fNP43Rp7jNdEMNmP1nmPZL_Q@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 24 Oct 2021 17:35:02 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTevdrtqphqtHDx1pmypwjUSG7fZz5Znr-iDNsn1QNu3Q@mail.gmail.com>
Message-ID: <CAJF2gTTevdrtqphqtHDx1pmypwjUSG7fZz5Znr-iDNsn1QNu3Q@mail.gmail.com>
Subject: Re: [PATCH V5 2/3] dt-bindings: update riscv plic compatible string
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 5:18 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Sun, Oct 24, 2021 at 2:31 PM Guo Ren <guoren@kernel.org> wrote:
> >
> > On Sun, Oct 24, 2021 at 3:35 PM Anup Patel <anup@brainfault.org> wrote:
> > >
> > > On Sun, Oct 24, 2021 at 7:03 AM <guoren@kernel.org> wrote:
> > > >
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Add the compatible string "thead,c900-plic" to the riscv plic
> > > > bindings to support allwinner d1 SOC which contains c906 core.
> > > >
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Cc: Anup Patel <anup@brainfault.org>
> > > > Cc: Atish Patra <atish.patra@wdc.com>
> > > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > > Cc: Rob Herring <robh@kernel.org>
> > > > Cc: Rob Herring <robh+dt@kernel.org>
> > > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > > >
> > > > ---
> > > >
> > > > Changes since V5:
> > > >  - Add DT list
> > > >  - Fixup compatible string
> > > >  - Remove allwinner-d1 compatible
> > > >  - make dt_binding_check
> > > >
> > > > Changes since V4:
> > > >  - Update description in errata style
> > > >  - Update enum suggested by Anup, Heiko, Samuel
> > > >
> > > > Changes since V3:
> > > >  - Rename "c9xx" to "c900"
> > > >  - Add thead,c900-plic in the description section
> > > > ---
> > > >  .../interrupt-controller/sifive,plic-1.0.0.yaml   | 15 ++++++++++++---
> > > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > > index 08d5a57ce00f..18b97bfd7954 100644
> > > > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > > @@ -35,6 +35,10 @@ description:
> > > >    contains a specific memory layout, which is documented in chapter 8 of the
> > > >    SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
> > > >
> > > > +  The thead,c900-plic couldn't complete masked irq source which has been disabled in
> > > > +  enable register. Add thead_plic_chip which fix up c906-plic irq source completion
> > > > +  problem by unmask/mask wrapper.
> > > > +
> > >
> > > This is an incomplete description about how T-HEAD PLIC is different from
> > > RISC-V PLIC.
> > >
> > > I would suggest the following:
> > >
> > > The T-HEAD C9xx SoC implements a modified/custom T-HEAD PLIC specification
> > > which will mask current IRQ upon read to CLAIM register and will unmask the IRQ
> > > upon write to CLAIM register. The thead,c900-plic compatible string
> > > represents the
> > > custom T-HEAD PLIC specification.
> > The patch fixup the problem that when "thead,c900-plic" couldn't
> > complete masked irq source which has been disabled.
> >
> > This patch is different from the last one in that there is no
> > relationship with the auto-mask feature.
>
> This patch adds compatible string for T-HEAD PLIC so it
> should describe how T-HEAD PLIC is different from RISC-V
> PLIC. The DT bindings document describes HW and not
> the software work-around implemented using DT bindings.
>
> Your irqchip patch uses T-HEAD PLIC compatible string to
> implement a work-around.
>
> In other words, this patch is different from the irqchip patch.

How about below:

The thead,c900-plic compatible string represents the custom T-HEAD
PLIC specification.
 - It couldn't complete masked irq source which has been disabled in
enable register. Add thead_plic_chip which fix up c906-plic irq source
completion problem by unmask/mask wrapper.
 - It implements a modified/custom T-HEAD PLIC specification which
will mask current IRQ upon read to CLAIM register and will unmask the
IRQ upon write to CLAIM register. But the feature wasn't utilized by
software.

>
> Regards,
> Anup
>
> >
> > >
> > > Regards,
> > > Anup
> > >
> > > >  maintainers:
> > > >    - Sagar Kadam <sagar.kadam@sifive.com>
> > > >    - Paul Walmsley  <paul.walmsley@sifive.com>
> > > > @@ -42,11 +46,16 @@ maintainers:
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    items:
> > > > +   oneOf:
> > > > +    - items:
> > > >        - enum:
> > > > -          - sifive,fu540-c000-plic
> > > > -          - canaan,k210-plic
> > > > +        - sifive,fu540-c000-plic
> > > > +        - canaan,k210-plic
> > > >        - const: sifive,plic-1.0.0
> > > > +    - items:
> > > > +      - enum:
> > > > +        - allwinner,sun20i-d1-plic
> > > > +      - const: thead,c900-plic
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > > --
> > > > 2.25.1
> > > >
> >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
> > ML: https://lore.kernel.org/linux-csky/



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
