Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5EE42BB64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbhJMJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbhJMJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:22:11 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBEAC061765
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:20:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t2so5997858wrb.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+lUdmvM630HC9Rc0ejWwyoYWLa7F0b+RBSdS/FDtwnA=;
        b=jig85W7cYgKDE+smX7nYNQXEs3qABJA6zH/0hbObl7vu+CWeDkZBq41AszpsMC/woD
         8z1mA1Hcy/K5ehSvffBsNDjKBIDCADmNvDmFv3G+/2KbjjG5GZQ9xR8yrPHYEWYvWy4k
         OnTWLlxDlRhtDvwgyCzBNPu4F6AJ9J491lfjO0R88PK26w4mCvH/NXiXw+1wSGucDaMd
         GOWMe5l88a3PAS7oN8N19t+usI9dWPRLtOgGdAlFJc0RK3T9fN8mPNF+redW7XRG2ObZ
         8hN/lB1gsob3dBR7zFQZZVQ6/CtLz0Z4m3l3NWP+7X+dBukal8sqGA9+WRBcrhO8zizh
         Bjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+lUdmvM630HC9Rc0ejWwyoYWLa7F0b+RBSdS/FDtwnA=;
        b=HjTR6vpdcoMmRo/sEZ7/KHFbaOTVgzrYsqq3iN/rdIiuUDjsM5M641K3ytKHqCUek7
         xgkczcxJLPP/cGs2cOdTebW8CLV5qkFv3KVoEUvCGm1SavCycQn18TXrkwmrtExZTWkv
         xIva9OuZtKtmYdLVB/L5+KnNDZXc7WLDbORtF/gaEcEPJjnPgVr70G8eB/VbAyUVJF0v
         F9Ki3V9i+9/KnJdycYJqNa9BnpSFU5fTHnfuVIf7wKgKCnB9O4LTGfBMe5bSWQpXbsI4
         l9QaCbY8cuTquAwQPVC2VwydUyGFw6p8kA2hLyZVcH5WqYZXmKEQ3nQd0eR3YumwbUwU
         i/fw==
X-Gm-Message-State: AOAM532A86X23eU2sS89wnhXZQolPpLf3qlKzecrywisb3ppmTIcQB97
        46gaMn7EwmxFUYWzNUpspi/TqC8LLpVkuL3WaiDiLA==
X-Google-Smtp-Source: ABdhPJxcNbhOtXc4vc3bnKsG1B/rm5+IOBi8MrlVcwvpsck/N4s2oStH/YRZtt5Q9hiN4g+mvfd9cYNMusiL6Jrn+Yc=
X-Received: by 2002:a05:600c:4111:: with SMTP id j17mr11477749wmi.59.1634116804936;
 Wed, 13 Oct 2021 02:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211013012149.2834212-1-guoren@kernel.org> <4039032.XOxOlHldtI@diego>
 <CAAhSdy3j2Co2ckxn4vDtOxL=Ym3hgb66vkmnTbUjec+x7bRRDA@mail.gmail.com> <4245323.jvX0RauA9x@diego>
In-Reply-To: <4245323.jvX0RauA9x@diego>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 13 Oct 2021 14:49:53 +0530
Message-ID: <CAAhSdy29WAXfBz6Ag-kAjNo_uhJO+AuC0e-UyWhwhaCmrw7pjw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: update riscv plic compatible string
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Guo Ren <guoren@kernel.org>, Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 2:44 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 13. Oktober 2021, 11:11:26 CEST schrieb Anup Patel:
> > On Wed, Oct 13, 2021 at 2:27 PM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> > >
> > > Hi Anup,
> > >
> > > Am Mittwoch, 13. Oktober 2021, 07:11:46 CEST schrieb Anup Patel:
> > > > On Wed, Oct 13, 2021 at 6:52 AM <guoren@kernel.org> wrote:
> > > > >
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > >
> > > > > Add the compatible string "thead,c900-plic" to the riscv plic
> > > > > bindings to support SOCs with thead,c9xx processor cores.
> > > > >
> > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > > > > Cc: Anup Patel <anup@brainfault.org>
> > > > > Cc: Atish Patra <atish.patra@wdc.com>
> > > > >
> > > > > ---
> > > > >
> > > > > Changes since V3:
> > > > >  - Rename "c9xx" to "c900"
> > > > >  - Add thead,c900-plic in the description section
> > > > > ---
> > > > >  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml    | 6 =
++++++
> > > > >  1 file changed, 6 insertions(+)
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/interrupt-controll=
er/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-con=
troller/sifive,plic-1.0.0.yaml
> > > > > index 08d5a57ce00f..82629832e5a5 100644
> > > > > --- a/Documentation/devicetree/bindings/interrupt-controller/sifi=
ve,plic-1.0.0.yaml
> > > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifi=
ve,plic-1.0.0.yaml
> > > > > @@ -35,6 +35,11 @@ description:
> > > > >    contains a specific memory layout, which is documented in chap=
ter 8 of the
> > > > >    SiFive U5 Coreplex Series Manual <https://static.dev.sifive.co=
m/U54-MC-RVCoreIP.pdf>.
> > > > >
> > > > > +  While the "thead,c900-plic" would mask IRQ with readl(claim), =
so it needn't
> > > > > +  mask/unmask which needed in RISC-V PLIC. When in IRQS_ONESHOT =
& IRQCHIP_EOI_THREADED
> > > > > +  path, unnecessary mask operation would cause a blocking irq bu=
g in thead,c900-plic.
> > > > > +  Because when IRQ is disabled in c900, writel(hwirq, claim) wou=
ld be invalid.
> > > >
> > > > This is a totally incorrect description of the errata required for =
C9xx PLIC.
> > > >
> > > > Please don't project non-compliance as a feature of C9xx PLIC.
> > > >
> > > > > +
> > > > >  maintainers:
> > > > >    - Sagar Kadam <sagar.kadam@sifive.com>
> > > > >    - Paul Walmsley  <paul.walmsley@sifive.com>
> > > > > @@ -46,6 +51,7 @@ properties:
> > > > >        - enum:
> > > > >            - sifive,fu540-c000-plic
> > > > >            - canaan,k210-plic
> > > > > +          - thead,c900-plic
> > >
> > > we still want specific SoC names in the compatible, the "c900"
> > > is still a sort-of placeholder.
> >
> > Yes, we need "c900" compatible string as well. The "c9xx"
> > compatible string is for the custom PLIC spec followed by T-HEAD.
>
> What I meant was that the soc-specific string should name the
> actual SoC (c906, c910) and not some imaginary chip ;-)

Ahh, yes. It should be an actual soc name in the compatible
string.

For example, SiFive uses "fu540" string to identify some of the
devices on both SiFive unleashed and SiFive unmatched boards.

I was under the impression that "c900" is an actual SoC name.

Regards,
Anup

>
> See for example mali gpu bindings for a similar reference
> in devicetree/bindings/gpu/arm,mali-bifrost.yaml .
>
>
>
>
> >
> > >
> > >
> > > > >        - const: sifive,plic-1.0.0
> > > >
> > > > The PLIC DT node requires two compatible string:
> > > > <implementation_compat>, <spec_compat>
> > > >
> > > > The C9xx PLIC is not RISC-V PLIC so, the DT node should
> > > > be: "thead,c900-plic", "thead,c9xx-plic"
> > > >
> > > > You need to change "- const: sifive,plic-1.0.0" to
> > > > - enum:
> > > >     - sifive,plic-1.0.0
> > > >     - thead,c9xx-plic
> > >
> > >
> >
> > Regards,
> > Anup
> >
>
>
>
>
