Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE0C42BC1C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbhJMJwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbhJMJwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:52:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BACAC061770
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:49:35 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id o20so6329275wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QUZkGbwnQAAPgFgGOXyoAal33YFX9xEzX2kiEfKJARY=;
        b=cFtTKzQWmxH85040DBdv2XzZnHGHDLwxwfbdDhUjS1Z4nkTHcgs4z6pXhuqb82omX3
         Rnf1GYeK86oLqkM+Q9wobBCXmysQjvQTp/AYckUlbXtXyC3wfC7ve6iZudSJbuR/NQzb
         w2+LtXno4BkpG6AH2SFZ9pfvfbJaFRX+fAeIFKQ8Xi4jmB9vw4hwmBjpOmpWYmnGgkgI
         PhUrgkL1jiPymx/oygqgIsQBevMFM4Rj3QU6UMdvyESFlKYwbx3AlYZ8L6Ej4p6vA3DW
         4pgHZaoV1KcYyWCg/KGGUtkWk+6DLspHr3as5P0g85runKGU75pfmZcwgMWABKKXaro+
         2yBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QUZkGbwnQAAPgFgGOXyoAal33YFX9xEzX2kiEfKJARY=;
        b=eOvMWugrP+RdllOz0mWmupdTuWGtKeKbN1hTxYINB3qwSxLSsJbxaebyBaWgbZCMdz
         VdoeWorTTxRjpDOCstysxkiCsIQ1hvCEzqXSCQpS4RchvtDjX8MvmBVKQ1Z5fY5Beu7B
         FPmaKeA61m9YIp0yiMXto8Ck0DeP3xaKrvB7Pl+U8QWEhDIuenDuqND2Lm9JOTEoGjHl
         v4u9C269iz0+7i95SES1TpNnj10SVb8O8meMfNf7o6+WXceM/ChDbI2qR3UfQKu94Cb9
         V3IL8btcZYwCQj4rB5FQ7PklZzfM+ei8PdCJgrxRKJ0/UW6QA6bbwmFxTl68FhNGLJoC
         TeJQ==
X-Gm-Message-State: AOAM530Y5duCw3daRMy5N0bi79tYnSY3X1LzhLF5g25/wqZICQLgxnSh
        R5gEOe5iDKafAYj0Uxrj37WSCC8CwRgwZr8ZId325Q==
X-Google-Smtp-Source: ABdhPJwOEgEX8UXqvzbiP+g6QdZofE1SRjKfEHKEK9mfith4l7ZzT15rR/+GDY5d4xtxKQ+RnlRSr2P86+Et+pio2G0=
X-Received: by 2002:a5d:5849:: with SMTP id i9mr5085992wrf.331.1634118573439;
 Wed, 13 Oct 2021 02:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20211013012149.2834212-1-guoren@kernel.org> <4245323.jvX0RauA9x@diego>
 <CAAhSdy29WAXfBz6Ag-kAjNo_uhJO+AuC0e-UyWhwhaCmrw7pjw@mail.gmail.com> <4027415.QZv1u5a1DM@diego>
In-Reply-To: <4027415.QZv1u5a1DM@diego>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 13 Oct 2021 15:19:20 +0530
Message-ID: <CAAhSdy21akVxyzP=Xnci=x+=ndL3DCJ3z7s24bwp9OG9Z5bj9Q@mail.gmail.com>
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

On Wed, Oct 13, 2021 at 3:13 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 13. Oktober 2021, 11:19:53 CEST schrieb Anup Patel:
> > On Wed, Oct 13, 2021 at 2:44 PM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> > >
> > > Am Mittwoch, 13. Oktober 2021, 11:11:26 CEST schrieb Anup Patel:
> > > > On Wed, Oct 13, 2021 at 2:27 PM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
> > > > >
> > > > > Hi Anup,
> > > > >
> > > > > Am Mittwoch, 13. Oktober 2021, 07:11:46 CEST schrieb Anup Patel:
> > > > > > On Wed, Oct 13, 2021 at 6:52 AM <guoren@kernel.org> wrote:
> > > > > > >
> > > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > > >
> > > > > > > Add the compatible string "thead,c900-plic" to the riscv plic
> > > > > > > bindings to support SOCs with thead,c9xx processor cores.
> > > > > > >
> > > > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > > > > > > Cc: Anup Patel <anup@brainfault.org>
> > > > > > > Cc: Atish Patra <atish.patra@wdc.com>
> > > > > > >
> > > > > > > ---
> > > > > > >
> > > > > > > Changes since V3:
> > > > > > >  - Rename "c9xx" to "c900"
> > > > > > >  - Add thead,c900-plic in the description section
> > > > > > > ---
> > > > > > >  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml    =
| 6 ++++++
> > > > > > >  1 file changed, 6 insertions(+)
> > > > > > >
> > > > > > > diff --git a/Documentation/devicetree/bindings/interrupt-cont=
roller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt=
-controller/sifive,plic-1.0.0.yaml
> > > > > > > index 08d5a57ce00f..82629832e5a5 100644
> > > > > > > --- a/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/=
sifive,plic-1.0.0.yaml
> > > > > > > @@ -35,6 +35,11 @@ description:
> > > > > > >    contains a specific memory layout, which is documented in =
chapter 8 of the
> > > > > > >    SiFive U5 Coreplex Series Manual <https://static.dev.sifiv=
e.com/U54-MC-RVCoreIP.pdf>.
> > > > > > >
> > > > > > > +  While the "thead,c900-plic" would mask IRQ with readl(clai=
m), so it needn't
> > > > > > > +  mask/unmask which needed in RISC-V PLIC. When in IRQS_ONES=
HOT & IRQCHIP_EOI_THREADED
> > > > > > > +  path, unnecessary mask operation would cause a blocking ir=
q bug in thead,c900-plic.
> > > > > > > +  Because when IRQ is disabled in c900, writel(hwirq, claim)=
 would be invalid.
> > > > > >
> > > > > > This is a totally incorrect description of the errata required =
for C9xx PLIC.
> > > > > >
> > > > > > Please don't project non-compliance as a feature of C9xx PLIC.
> > > > > >
> > > > > > > +
> > > > > > >  maintainers:
> > > > > > >    - Sagar Kadam <sagar.kadam@sifive.com>
> > > > > > >    - Paul Walmsley  <paul.walmsley@sifive.com>
> > > > > > > @@ -46,6 +51,7 @@ properties:
> > > > > > >        - enum:
> > > > > > >            - sifive,fu540-c000-plic
> > > > > > >            - canaan,k210-plic
> > > > > > > +          - thead,c900-plic
> > > > >
> > > > > we still want specific SoC names in the compatible, the "c900"
> > > > > is still a sort-of placeholder.
> > > >
> > > > Yes, we need "c900" compatible string as well. The "c9xx"
> > > > compatible string is for the custom PLIC spec followed by T-HEAD.
> > >
> > > What I meant was that the soc-specific string should name the
> > > actual SoC (c906, c910) and not some imaginary chip ;-)
> >
> > Ahh, yes. It should be an actual soc name in the compatible
> > string.
> >
> > For example, SiFive uses "fu540" string to identify some of the
> > devices on both SiFive unleashed and SiFive unmatched boards.
> >
> > I was under the impression that "c900" is an actual SoC name.
> >
> > Regards,
> > Anup
> >
> > >
> > > See for example mali gpu bindings for a similar reference
> > > in devicetree/bindings/gpu/arm,mali-bifrost.yaml .
> > >
> > >
> > >
> > >
> > > >
> > > > >
> > > > >
> > > > > > >        - const: sifive,plic-1.0.0
> > > > > >
> > > > > > The PLIC DT node requires two compatible string:
> > > > > > <implementation_compat>, <spec_compat>
> > > > > >
> > > > > > The C9xx PLIC is not RISC-V PLIC so, the DT node should
> > > > > > be: "thead,c900-plic", "thead,c9xx-plic"
> > > > > >
> > > > > > You need to change "- const: sifive,plic-1.0.0" to
> > > > > > - enum:
> > > > > >     - sifive,plic-1.0.0
> > > > > >     - thead,c9xx-plic
>
> isn't XuanTie the series containing the c906 and c910?
> So maybe
>         thead,xuantie-plic
> for the spec compatible.
>
> So doing in full
>         compatible =3D "thead,c906-plic", "thead,xuantie-plic"

This is a much better suggestion. I will let Guo decide.

Regards,
Anup

>
>
> Heiko
>
>
