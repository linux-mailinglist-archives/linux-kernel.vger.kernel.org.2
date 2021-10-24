Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D652E4387BD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhJXJEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 05:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhJXJEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:04:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83D8C60F57
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 09:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635066100;
        bh=Q0VYQA2JvqZt+JhQWrv84zpC9usCOBda9SPMR0yD3sM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kthwDYUzOYXbfcLswBUxZUYLLbflQ6Bto4C3zpEKkQiLsfukoK0UAOEyC79dwrL2h
         vKa5m5RYFkFZe/slMwEzuksuCFMYJqu2K93ZYMeoYIhdroynkC5sHjJYMnrbGD1jR5
         3AWg/Nzx6JoHlWToUjz3fXLstCGBnnXt0S2PcuEG+W4uD1SRpquRc3Nx1QSGVkUOdL
         BUE1ErnQpyIQLfzVWdnicDz03HjzBYb7T1q2ut1oVXNOIvpewi2WtjGEfVJHSbHwvD
         lACjJiNC+RSrK0WdHHXQPeXnSqaePNgfJ5EBvbv1Hx32Xo9rXnmlAYWExG8W+X24+b
         63lNOlqSw2BCg==
Received: by mail-ua1-f48.google.com with SMTP id a17so16052986uax.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 02:01:40 -0700 (PDT)
X-Gm-Message-State: AOAM532heKJ6eEd6Ubast+yBp3wIpXKsLQP4VSCpyJwyipSyZ5LC1vp+
        XKMnT+1m16GWVta4B53eEquVn0eaMYl9r/ozBH4=
X-Google-Smtp-Source: ABdhPJwNFi8ldbIWIfgnw9DyrcJJh9mCHghrGexwLOyoqkF6ln85i546lFSABhn2q511h7JwOjKduhcm1QbCuQ78kR4=
X-Received: by 2002:a05:6102:c4d:: with SMTP id y13mr9744916vss.33.1635066099683;
 Sun, 24 Oct 2021 02:01:39 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-3-guoren@kernel.org>
 <CAAhSdy2a2XgjOpezoq=SvX2XTcAWhceKF9X9v3z7xyO9Z4DMPQ@mail.gmail.com>
In-Reply-To: <CAAhSdy2a2XgjOpezoq=SvX2XTcAWhceKF9X9v3z7xyO9Z4DMPQ@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 24 Oct 2021 17:01:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTKJXY6DAq=-ajAiTEY7hpMT1bqnvNndW=5EnD5EEP-cw@mail.gmail.com>
Message-ID: <CAJF2gTTKJXY6DAq=-ajAiTEY7hpMT1bqnvNndW=5EnD5EEP-cw@mail.gmail.com>
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

On Sun, Oct 24, 2021 at 3:35 PM Anup Patel <anup@brainfault.org> wrote:
>
> On Sun, Oct 24, 2021 at 7:03 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add the compatible string "thead,c900-plic" to the riscv plic
> > bindings to support allwinner d1 SOC which contains c906 core.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Atish Patra <atish.patra@wdc.com>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> >
> > ---
> >
> > Changes since V5:
> >  - Add DT list
> >  - Fixup compatible string
> >  - Remove allwinner-d1 compatible
> >  - make dt_binding_check
> >
> > Changes since V4:
> >  - Update description in errata style
> >  - Update enum suggested by Anup, Heiko, Samuel
> >
> > Changes since V3:
> >  - Rename "c9xx" to "c900"
> >  - Add thead,c900-plic in the description section
> > ---
> >  .../interrupt-controller/sifive,plic-1.0.0.yaml   | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > index 08d5a57ce00f..18b97bfd7954 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > @@ -35,6 +35,10 @@ description:
> >    contains a specific memory layout, which is documented in chapter 8 of the
> >    SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
> >
> > +  The thead,c900-plic couldn't complete masked irq source which has been disabled in
> > +  enable register. Add thead_plic_chip which fix up c906-plic irq source completion
> > +  problem by unmask/mask wrapper.
> > +
>
> This is an incomplete description about how T-HEAD PLIC is different from
> RISC-V PLIC.
>
> I would suggest the following:
>
> The T-HEAD C9xx SoC implements a modified/custom T-HEAD PLIC specification
> which will mask current IRQ upon read to CLAIM register and will unmask the IRQ
> upon write to CLAIM register. The thead,c900-plic compatible string
> represents the
> custom T-HEAD PLIC specification.
The patch fixup the problem that when "thead,c900-plic" couldn't
complete masked irq source which has been disabled.

This patch is different from the last one in that there is no
relationship with the auto-mask feature.

>
> Regards,
> Anup
>
> >  maintainers:
> >    - Sagar Kadam <sagar.kadam@sifive.com>
> >    - Paul Walmsley  <paul.walmsley@sifive.com>
> > @@ -42,11 +46,16 @@ maintainers:
> >
> >  properties:
> >    compatible:
> > -    items:
> > +   oneOf:
> > +    - items:
> >        - enum:
> > -          - sifive,fu540-c000-plic
> > -          - canaan,k210-plic
> > +        - sifive,fu540-c000-plic
> > +        - canaan,k210-plic
> >        - const: sifive,plic-1.0.0
> > +    - items:
> > +      - enum:
> > +        - allwinner,sun20i-d1-plic
> > +      - const: thead,c900-plic
> >
> >    reg:
> >      maxItems: 1
> > --
> > 2.25.1
> >



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
