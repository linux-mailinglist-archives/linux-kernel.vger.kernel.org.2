Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95F542D023
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 03:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhJNB6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 21:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229838AbhJNB6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 21:58:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B876D611C7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 01:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634176602;
        bh=ZM1WtEcrPzwwxvHBTUjeSUaYDLGchqrWv7/MuM1+iKs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YyjHojCkCAxkJR/SZtzr1Aipoj61eaNEalKmcj/LdOc4ye5Ah0aT0XAqL9a+FYbUb
         Qrpoc0Xaxhw2bfOiLjSV60I5q2rfKxQ+srPDZ5N4e2DoyTIMnT6qfZsMd6Unj7wpXj
         O7MW5bAlE+EVC6F+p4xFZmg48hYPRni+SHggyUd5HVkEgx2fhjdXYyqMd2ke7kjL+N
         LXhti1QdovC5CMlbkpe79fwXqkdnmZnSQ1i5X6DWirqSVTjZpksGcwjtVhJsQeo6GP
         VG455Jz62tozaj4v6GB3G+SgHjpc1nmL09SR6B8/RPturncr3+2968getaD2WnMUEA
         Hzc4m5V2H3Xpg==
Received: by mail-ua1-f47.google.com with SMTP id f3so8363823uap.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 18:56:42 -0700 (PDT)
X-Gm-Message-State: AOAM531+3G3Y3M4fL8N4vQ5nFVzVEd4dxwudi5qQnyf5+TmPaeA+P3BN
        pKavzgRDCSilpU9TSRv703fuoQQtz+0sFc27XZI=
X-Google-Smtp-Source: ABdhPJwcg3E1UNy8BxUoWk9DY2FjjSeWhM5YSg4jFs3PzAfzX0W3w/6AA7Jxy3ZvdjJonirUlFXWd42hmFT55xwPMic=
X-Received: by 2002:ab0:5b59:: with SMTP id v25mr3102685uae.57.1634176601756;
 Wed, 13 Oct 2021 18:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211013012149.2834212-1-guoren@kernel.org> <4027415.QZv1u5a1DM@diego>
 <CAJF2gTTDZ0QjY9JL=U61=ubWrGWVOe2VBbW6hgzsHqsePgN0Ww@mail.gmail.com> <21791128.ik6S1v3eFK@phil>
In-Reply-To: <21791128.ik6S1v3eFK@phil>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 14 Oct 2021 09:56:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQiCMctaUkJPoJsAOGAHOtprquOJHRHyN-j_HWHyEdzuA@mail.gmail.com>
Message-ID: <CAJF2gTQiCMctaUkJPoJsAOGAHOtprquOJHRHyN-j_HWHyEdzuA@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: update riscv plic compatible string
To:     Heiko Stuebner <heiko@sntech.de>
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

On Thu, Oct 14, 2021 at 8:26 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Mittwoch, 13. Oktober 2021, 14:49:57 CEST schrieb Guo Ren:
> > On Wed, Oct 13, 2021 at 5:43 PM Heiko St=C3=BCbner <heiko@sntech.de> wr=
ote:
> > >
> > > Am Mittwoch, 13. Oktober 2021, 11:19:53 CEST schrieb Anup Patel:
> > > > On Wed, Oct 13, 2021 at 2:44 PM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
> > > > >
> > > > > Am Mittwoch, 13. Oktober 2021, 11:11:26 CEST schrieb Anup Patel:
> > > > > > On Wed, Oct 13, 2021 at 2:27 PM Heiko St=C3=BCbner <heiko@sntec=
h.de> wrote:
> > > > > > >
> > > > > > > Hi Anup,
> > > > > > >
> > > > > > > Am Mittwoch, 13. Oktober 2021, 07:11:46 CEST schrieb Anup Pat=
el:
> > > > > > > > On Wed, Oct 13, 2021 at 6:52 AM <guoren@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > > > > > >
> > > > > > > > > Add the compatible string "thead,c900-plic" to the riscv =
plic
> > > > > > > > > bindings to support SOCs with thead,c9xx processor cores.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > > > > > Cc: Rob Herring <robh@kernel.org>
> > > > > > > > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > > > > > > > > Cc: Anup Patel <anup@brainfault.org>
> > > > > > > > > Cc: Atish Patra <atish.patra@wdc.com>
> > > > > > > > >
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Changes since V3:
> > > > > > > > >  - Rename "c9xx" to "c900"
> > > > > > > > >  - Add thead,c900-plic in the description section
> > > > > > > > > ---
> > > > > > > > >  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml=
    | 6 ++++++
> > > > > > > > >  1 file changed, 6 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/interrupt-=
controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/inter=
rupt-controller/sifive,plic-1.0.0.yaml
> > > > > > > > > index 08d5a57ce00f..82629832e5a5 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/interrupt-control=
ler/sifive,plic-1.0.0.yaml
> > > > > > > > > +++ b/Documentation/devicetree/bindings/interrupt-control=
ler/sifive,plic-1.0.0.yaml
> > > > > > > > > @@ -35,6 +35,11 @@ description:
> > > > > > > > >    contains a specific memory layout, which is documented=
 in chapter 8 of the
> > > > > > > > >    SiFive U5 Coreplex Series Manual <https://static.dev.s=
ifive.com/U54-MC-RVCoreIP.pdf>.
> > > > > > > > >
> > > > > > > > > +  While the "thead,c900-plic" would mask IRQ with readl(=
claim), so it needn't
> > > > > > > > > +  mask/unmask which needed in RISC-V PLIC. When in IRQS_=
ONESHOT & IRQCHIP_EOI_THREADED
> > > > > > > > > +  path, unnecessary mask operation would cause a blockin=
g irq bug in thead,c900-plic.
> > > > > > > > > +  Because when IRQ is disabled in c900, writel(hwirq, cl=
aim) would be invalid.
> > > > > > > >
> > > > > > > > This is a totally incorrect description of the errata requi=
red for C9xx PLIC.
> > > > > > > >
> > > > > > > > Please don't project non-compliance as a feature of C9xx PL=
IC.
> > > > > > > >
> > > > > > > > > +
> > > > > > > > >  maintainers:
> > > > > > > > >    - Sagar Kadam <sagar.kadam@sifive.com>
> > > > > > > > >    - Paul Walmsley  <paul.walmsley@sifive.com>
> > > > > > > > > @@ -46,6 +51,7 @@ properties:
> > > > > > > > >        - enum:
> > > > > > > > >            - sifive,fu540-c000-plic
> > > > > > > > >            - canaan,k210-plic
> > > > > > > > > +          - thead,c900-plic
> > > > > > >
> > > > > > > we still want specific SoC names in the compatible, the "c900=
"
> > > > > > > is still a sort-of placeholder.
> > > > > >
> > > > > > Yes, we need "c900" compatible string as well. The "c9xx"
> > > > > > compatible string is for the custom PLIC spec followed by T-HEA=
D.
> > > > >
> > > > > What I meant was that the soc-specific string should name the
> > > > > actual SoC (c906, c910) and not some imaginary chip ;-)
> > > >
> > > > Ahh, yes. It should be an actual soc name in the compatible
> > > > string.
> > > >
> > > > For example, SiFive uses "fu540" string to identify some of the
> > > > devices on both SiFive unleashed and SiFive unmatched boards.
> > > >
> > > > I was under the impression that "c900" is an actual SoC name.
> > > >
> > > > Regards,
> > > > Anup
> > > >
> > > > >
> > > > > See for example mali gpu bindings for a similar reference
> > > > > in devicetree/bindings/gpu/arm,mali-bifrost.yaml .
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >        - const: sifive,plic-1.0.0
> > > > > > > >
> > > > > > > > The PLIC DT node requires two compatible string:
> > > > > > > > <implementation_compat>, <spec_compat>
> > > > > > > >
> > > > > > > > The C9xx PLIC is not RISC-V PLIC so, the DT node should
> > > > > > > > be: "thead,c900-plic", "thead,c9xx-plic"
> > > > > > > >
> > > > > > > > You need to change "- const: sifive,plic-1.0.0" to
> > > > > > > > - enum:
> > > > > > > >     - sifive,plic-1.0.0
> > > > > > > >     - thead,c9xx-plic
> > >
> > > isn't XuanTie the series containing the c906 and c910?
> > XuanTie contain two CPU series:
> > riscv: c906, c910
> > csky: c807, c810, c860
> >
> > > So maybe
> > >         thead,xuantie-plic
> > > for the spec compatible.
> > >
> > > So doing in full
> > >         compatible =3D "thead,c906-plic", "thead,xuantie-plic"
> > How about:
> > compatible =3D "allwinner,d1-plic", "thead,c900-plic"
>
> This looks sensible.
>
> - I guess the question in general is, is the PLIC part of the core spec
> or part of the soc. In other words will all SoCs that use C9xx cores,
> use this specific PLIC characteristic?
Yes, unless soc wants to customize.

>
> - If all C9xx-based SoCs will use this PLIC, I guess that thead,c900-plic
>   in your compatible above sounds pretty good.
>
> - Should it be thead,* or t-head,* for the vendor-prefix?
T-Head Semiconductor Co., Ltd.
ref: https://github.com/T-head-Semi

So it's "thead" for vendor-prefix

>   (domain seems to be t-head.cn)
>
>
> Heiko
>
>

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
