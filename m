Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4863F42BAFA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 10:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbhJMI7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 04:59:51 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43368 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhJMI7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 04:59:50 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1maa4z-0003gQ-6C; Wed, 13 Oct 2021 10:57:41 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: update riscv plic compatible string
Date:   Wed, 13 Oct 2021 10:57:40 +0200
Message-ID: <4039032.XOxOlHldtI@diego>
In-Reply-To: <CAAhSdy042JY_Vm2j_d5t4jweS3gf51h30j1O9LXDnE6KkB8AEg@mail.gmail.com>
References: <20211013012149.2834212-1-guoren@kernel.org> <CAAhSdy042JY_Vm2j_d5t4jweS3gf51h30j1O9LXDnE6KkB8AEg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

Am Mittwoch, 13. Oktober 2021, 07:11:46 CEST schrieb Anup Patel:
> On Wed, Oct 13, 2021 at 6:52 AM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add the compatible string "thead,c900-plic" to the riscv plic
> > bindings to support SOCs with thead,c9xx processor cores.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Atish Patra <atish.patra@wdc.com>
> >
> > ---
> >
> > Changes since V3:
> >  - Rename "c9xx" to "c900"
> >  - Add thead,c900-plic in the description section
> > ---
> >  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml    | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > index 08d5a57ce00f..82629832e5a5 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > @@ -35,6 +35,11 @@ description:
> >    contains a specific memory layout, which is documented in chapter 8 of the
> >    SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
> >
> > +  While the "thead,c900-plic" would mask IRQ with readl(claim), so it needn't
> > +  mask/unmask which needed in RISC-V PLIC. When in IRQS_ONESHOT & IRQCHIP_EOI_THREADED
> > +  path, unnecessary mask operation would cause a blocking irq bug in thead,c900-plic.
> > +  Because when IRQ is disabled in c900, writel(hwirq, claim) would be invalid.
> 
> This is a totally incorrect description of the errata required for C9xx PLIC.
> 
> Please don't project non-compliance as a feature of C9xx PLIC.
> 
> > +
> >  maintainers:
> >    - Sagar Kadam <sagar.kadam@sifive.com>
> >    - Paul Walmsley  <paul.walmsley@sifive.com>
> > @@ -46,6 +51,7 @@ properties:
> >        - enum:
> >            - sifive,fu540-c000-plic
> >            - canaan,k210-plic
> > +          - thead,c900-plic

we still want specific SoC names in the compatible, the "c900"
is still a sort-of placeholder.


> >        - const: sifive,plic-1.0.0
> 
> The PLIC DT node requires two compatible string:
> <implementation_compat>, <spec_compat>
> 
> The C9xx PLIC is not RISC-V PLIC so, the DT node should
> be: "thead,c900-plic", "thead,c9xx-plic"
> 
> You need to change "- const: sifive,plic-1.0.0" to
> - enum:
>     - sifive,plic-1.0.0
>     - thead,c9xx-plic


