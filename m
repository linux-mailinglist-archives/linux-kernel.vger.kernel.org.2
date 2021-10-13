Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7AC42BB42
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbhJMJQu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Oct 2021 05:16:50 -0400
Received: from gloria.sntech.de ([185.11.138.130]:43518 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238960AbhJMJQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:16:49 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1maaLU-0003mB-I0; Wed, 13 Oct 2021 11:14:44 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Anup Patel <anup@brainfault.org>
Cc:     Guo Ren <guoren@kernel.org>, Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: update riscv plic compatible string
Date:   Wed, 13 Oct 2021 11:14:43 +0200
Message-ID: <4245323.jvX0RauA9x@diego>
In-Reply-To: <CAAhSdy3j2Co2ckxn4vDtOxL=Ym3hgb66vkmnTbUjec+x7bRRDA@mail.gmail.com>
References: <20211013012149.2834212-1-guoren@kernel.org> <4039032.XOxOlHldtI@diego> <CAAhSdy3j2Co2ckxn4vDtOxL=Ym3hgb66vkmnTbUjec+x7bRRDA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 13. Oktober 2021, 11:11:26 CEST schrieb Anup Patel:
> On Wed, Oct 13, 2021 at 2:27 PM Heiko Stübner <heiko@sntech.de> wrote:
> >
> > Hi Anup,
> >
> > Am Mittwoch, 13. Oktober 2021, 07:11:46 CEST schrieb Anup Patel:
> > > On Wed, Oct 13, 2021 at 6:52 AM <guoren@kernel.org> wrote:
> > > >
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Add the compatible string "thead,c900-plic" to the riscv plic
> > > > bindings to support SOCs with thead,c9xx processor cores.
> > > >
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Cc: Rob Herring <robh@kernel.org>
> > > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > > > Cc: Anup Patel <anup@brainfault.org>
> > > > Cc: Atish Patra <atish.patra@wdc.com>
> > > >
> > > > ---
> > > >
> > > > Changes since V3:
> > > >  - Rename "c9xx" to "c900"
> > > >  - Add thead,c900-plic in the description section
> > > > ---
> > > >  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml    | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > > index 08d5a57ce00f..82629832e5a5 100644
> > > > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > > @@ -35,6 +35,11 @@ description:
> > > >    contains a specific memory layout, which is documented in chapter 8 of the
> > > >    SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
> > > >
> > > > +  While the "thead,c900-plic" would mask IRQ with readl(claim), so it needn't
> > > > +  mask/unmask which needed in RISC-V PLIC. When in IRQS_ONESHOT & IRQCHIP_EOI_THREADED
> > > > +  path, unnecessary mask operation would cause a blocking irq bug in thead,c900-plic.
> > > > +  Because when IRQ is disabled in c900, writel(hwirq, claim) would be invalid.
> > >
> > > This is a totally incorrect description of the errata required for C9xx PLIC.
> > >
> > > Please don't project non-compliance as a feature of C9xx PLIC.
> > >
> > > > +
> > > >  maintainers:
> > > >    - Sagar Kadam <sagar.kadam@sifive.com>
> > > >    - Paul Walmsley  <paul.walmsley@sifive.com>
> > > > @@ -46,6 +51,7 @@ properties:
> > > >        - enum:
> > > >            - sifive,fu540-c000-plic
> > > >            - canaan,k210-plic
> > > > +          - thead,c900-plic
> >
> > we still want specific SoC names in the compatible, the "c900"
> > is still a sort-of placeholder.
> 
> Yes, we need "c900" compatible string as well. The "c9xx"
> compatible string is for the custom PLIC spec followed by T-HEAD.

What I meant was that the soc-specific string should name the
actual SoC (c906, c910) and not some imaginary chip ;-)

See for example mali gpu bindings for a similar reference
in devicetree/bindings/gpu/arm,mali-bifrost.yaml .




> 
> >
> >
> > > >        - const: sifive,plic-1.0.0
> > >
> > > The PLIC DT node requires two compatible string:
> > > <implementation_compat>, <spec_compat>
> > >
> > > The C9xx PLIC is not RISC-V PLIC so, the DT node should
> > > be: "thead,c900-plic", "thead,c9xx-plic"
> > >
> > > You need to change "- const: sifive,plic-1.0.0" to
> > > - enum:
> > >     - sifive,plic-1.0.0
> > >     - thead,c9xx-plic
> >
> >
> 
> Regards,
> Anup
> 




