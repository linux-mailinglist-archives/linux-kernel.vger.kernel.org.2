Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 160714302AE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 14:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbhJPM7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 08:59:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240450AbhJPM7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 08:59:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FC276120A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 12:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634389023;
        bh=NsinonKH119OjwifjZy82GsiqQzJfczn0ZJZxIQqkGQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XeiaRhr3wF7EzNe4FIC+GtRX7tvl7cBWvk560//gRZqKY4ASIGOng+wRLQ0SOY/6F
         /XV9L6EH5L+f9X+7EzVfjunNkXPMutK+Y/Z/xBGSV2hf5CmTKBc6zkJjD1LpPC8TIo
         a2j6ePFvhAXeLQdtCARYZ3WzXvgvCzRXB6NDR8f2yFtmD/eio3BfOjkO+od390vzhs
         nQw/s0d/OEwD9qe2VDv0ayntCHIB+zUPHZLPJMBkZQ+tXh/3RoFo66NxSIh8t5MRyk
         SrOsbK3XAC3yKdXcHBqe50NjFhKuhnzS9fOBr2Sw6ojGYrluRpC9fOr9Fm0PME8L47
         1nLPeAVCFR32w==
Received: by mail-ua1-f48.google.com with SMTP id u5so23329409uao.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Oct 2021 05:57:03 -0700 (PDT)
X-Gm-Message-State: AOAM5311ufag5gDuV+rr4+fEebjT6K6SAC76qgy9Dfqq0lBbe8QuPLkU
        gkUxs9XjkI6V8IhNtBIkmKV0LWTurYisnGtT0MA=
X-Google-Smtp-Source: ABdhPJyYmy9I1jJUAIFP49csFzkTWJzf9NeB+lBd1HnG0jVFKArnzAC1PQl3HeHqdbMJJMM348S0sICXFBUlMYIkjsk=
X-Received: by 2002:a05:6102:32cd:: with SMTP id o13mr19996599vss.50.1634389022294;
 Sat, 16 Oct 2021 05:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-3-guoren@kernel.org>
 <2216787.nSqPeTNalD@phil>
In-Reply-To: <2216787.nSqPeTNalD@phil>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 16 Oct 2021 20:56:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQKc1DGcCy_sFjSs8p+VMNGHFrjO2uLZrHnjdD1pZ2RZg@mail.gmail.com>
Message-ID: <CAJF2gTQKc1DGcCy_sFjSs8p+VMNGHFrjO2uLZrHnjdD1pZ2RZg@mail.gmail.com>
Subject: Re: [PATCH V4 2/3] dt-bindings: update riscv plic compatible string
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 16, 2021 at 6:35 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi Guo,
>
> Am Samstag, 16. Oktober 2021, 05:21:59 CEST schrieb guoren@kernel.org:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add the compatible string "thead,c900-plic" to the riscv plic
> > bindings to support allwinner d1 SOC which contains c906 core.
>
> The compatible strings sound good now, but some things below
>
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Atish Patra <atish.patra@wdc.com>
> >
> > ---
> >
> > Changes since V4:
> >  - Update description in errata style
> >  - Update enum suggested by Anup, Heiko, Samuel
> >
> > Changes since V3:
> >  - Rename "c9xx" to "c900"
> >  - Add thead,c900-plic in the description section
> > ---
> >  .../interrupt-controller/sifive,plic-1.0.0.yaml       | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > index 08d5a57ce00f..272f29540135 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > @@ -35,6 +35,12 @@ description:
> >    contains a specific memory layout, which is documented in chapter 8 of the
> >    SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
> >
> > +  The C9xx PLIC does not comply with the interrupt claim/completion process defined
> > +  by the RISC-V PLIC specification because C9xx PLIC will mask an IRQ when it is
> > +  claimed by PLIC driver (i.e. readl(claim) and the IRQ will be unmasked upon
> > +  completion by PLIC driver (i.e. writel(claim). This behaviour breaks the handling
> > +  of IRQS_ONESHOT by the generic handle_fasteoi_irq() used in the PLIC driver.
> > +
> >  maintainers:
> >    - Sagar Kadam <sagar.kadam@sifive.com>
> >    - Paul Walmsley  <paul.walmsley@sifive.com>
> > @@ -46,7 +52,10 @@ properties:
> >        - enum:
> >            - sifive,fu540-c000-plic
> >            - canaan,k210-plic
> > -      - const: sifive,plic-1.0.0
> > +      - enmu:
>
>         ^ spelling enum
>
> > +          - sifive,plic-1.0.0
> > +          - thead,c900-plic
> > +          - allwinner,sun20i-d1-plic
>
> but in general I'd think that you want something like
>
>   compatible:
>     oneOf:
>       - items:
>           - enum:
>               - sifive,fu540-c000-plic
>               - canaan,k210-plic
>           - const: sifive,plic-1.0.0
>       - items:
>           - enum:
>               - allwinner,sun20i-d1-plic
>           - const: thead,c900-plic
>
> Having only one item list would allow as valid combinations like
> "sifive,fu540-c000-plic", "thead,c900-plic" when checking the schema.
>
> With the oneOf and separate lists we can make sure that such
> "illegal" combinations get flagged by the dtbs_check
>
> [the enum with the single allwinner entry already leaves
>  room for later addition to the c900-plic variant]
Thx, I'll fix it in the next version.

another question: Is the allwinner_sun20i_d1_plic needed to IRQCHIP_DECLARE?

+IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", thead_c900_plic_init);
+IRQCHIP_DECLARE(allwinner_sun20i_d1_plic, "allwinner,sun20i-d1-plic",
thead_c900_plic_init);

>
> Heiko

>
>
>


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
