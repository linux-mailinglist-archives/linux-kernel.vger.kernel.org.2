Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08D642C08E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhJMMwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:52:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233204AbhJMMwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:52:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65E1F61108
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634129409;
        bh=J8g0tilzDKDby65Hj+Esonf9qYC68SF2NllkOVPodHI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ounni1CZ7mb3RKxYgPL+4J3upP35LrQNOjvT/tm80YmXedHoZ/RJV01CDPMnsITHx
         XZuOBDU5e+LCCvDF8pGLtaBV5PNoxLN3dXzIU5HEsZfOVAPxI1c0NXUS/Y1ylvBXMR
         cg4upO5gjW8dB/F/q/PftevcjyYCAmhdNgCLKOVKoiVCiEcS0993yV+5mTpW46J2fm
         BhBne/YZNbkrDZ854ZiHPS9280uG9aZz0TLU1fCpMNdwe+u4kAITjZv23tv2aKwXw1
         JnpEXHrrjcs+/QN99rokkFO3dV94qmM7l6Pz8Cfq5XQQNaRrCREAVVKP78HCuuuM/P
         8ciu1R8j/JwNA==
Received: by mail-ua1-f52.google.com with SMTP id h19so4197800uax.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:50:09 -0700 (PDT)
X-Gm-Message-State: AOAM530jZ+FK6Eu97xZ5tU+yz2uwuR1MhviemPzEeEqmMayRnq1SA6Zo
        04rh4xIw2CjNU7XkBApJ50B9bZa6VFK4zYMXtpQ=
X-Google-Smtp-Source: ABdhPJz42HJibxAywzH9SAbeD10S23rM8343rvOoO185Tk+OBWh2re//oqTnchMStnNcSzdI/PN6HjF7Apo3TozB8cs=
X-Received: by 2002:a05:6102:537:: with SMTP id m23mr1535407vsa.43.1634129408301;
 Wed, 13 Oct 2021 05:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20211013012149.2834212-1-guoren@kernel.org> <4245323.jvX0RauA9x@diego>
 <CAAhSdy29WAXfBz6Ag-kAjNo_uhJO+AuC0e-UyWhwhaCmrw7pjw@mail.gmail.com> <4027415.QZv1u5a1DM@diego>
In-Reply-To: <4027415.QZv1u5a1DM@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Oct 2021 20:49:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTDZ0QjY9JL=U61=ubWrGWVOe2VBbW6hgzsHqsePgN0Ww@mail.gmail.com>
Message-ID: <CAJF2gTTDZ0QjY9JL=U61=ubWrGWVOe2VBbW6hgzsHqsePgN0Ww@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: update riscv plic compatible string
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
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

On Wed, Oct 13, 2021 at 5:43 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
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
XuanTie contain two CPU series:
riscv: c906, c910
csky: c807, c810, c860

> So maybe
>         thead,xuantie-plic
> for the spec compatible.
>
> So doing in full
>         compatible =3D "thead,c906-plic", "thead,xuantie-plic"
How about:
compatible =3D "allwinner,d1-plic", "thead,c900-plic"

>
>
> Heiko
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
