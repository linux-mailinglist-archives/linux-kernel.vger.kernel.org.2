Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853C142C021
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbhJMMgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:36:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhJMMgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:36:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B81860EBB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634128484;
        bh=JlEDbRIR5mybHqyx6SQLCFaW8BoVnGveOk9R4ZFD7zM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K9t6NAqdOEGZzMasWIlRt5fOEnzL+LmFFNeDVs21urg2VMs97F3D/NOu0l1x7Ohvl
         cCgNe4QJYOEgIt5UTstaCvU1AYpln/4twGOILue/3NOT4rQ963KsfdYo4Ri1Zcge9T
         4IfpGMouomb+OykZNrTZmL/kfHMk4vxc7zMt5k25f/Q30b7hUifeSGdjNEHkBGfapj
         aWKo2p3fWPgJiilcOt+kW8ZwuSFYdo6jHhSjxLvQLIqrHpzcWP0tNp7hFuxtFkAUYe
         eSlRF7GCD6guQIz8+kzxhYI/8GtKgWMIO2QF/urtCv/F0US8hjMd+5ozsJqx17fVhy
         fAj0w4v6OmWaw==
Received: by mail-vk1-f180.google.com with SMTP id 34so1713169vkl.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:34:44 -0700 (PDT)
X-Gm-Message-State: AOAM532d/LXqx8LaqBMAOEsSUPEx4u4Ozph4LZYBbmvklqhN6/zx+C6r
        PKUO/9upk6Idq7dg/ZSPq2idc63FO8hQQsTUQvg=
X-Google-Smtp-Source: ABdhPJyG0CYAXgVJwI3HxRrhPFgUh8fz6ejBECHvxddZ69z75kh9bvDLh3hS92Kduf5pciR1hzt0XY9NvHv/yHjzIcA=
X-Received: by 2002:a1f:1844:: with SMTP id 65mr32743708vky.3.1634128483719;
 Wed, 13 Oct 2021 05:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211013012149.2834212-1-guoren@kernel.org> <CAAhSdy042JY_Vm2j_d5t4jweS3gf51h30j1O9LXDnE6KkB8AEg@mail.gmail.com>
 <4039032.XOxOlHldtI@diego>
In-Reply-To: <4039032.XOxOlHldtI@diego>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Oct 2021 20:34:32 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSJaYqH-=QQgM+d6jMQh1i97Q2=O9MCu_8jS2w06q5fCg@mail.gmail.com>
Message-ID: <CAJF2gTSJaYqH-=QQgM+d6jMQh1i97Q2=O9MCu_8jS2w06q5fCg@mail.gmail.com>
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

On Wed, Oct 13, 2021 at 4:57 PM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Anup,
>
> Am Mittwoch, 13. Oktober 2021, 07:11:46 CEST schrieb Anup Patel:
> > On Wed, Oct 13, 2021 at 6:52 AM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Add the compatible string "thead,c900-plic" to the riscv plic
> > > bindings to support SOCs with thead,c9xx processor cores.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > > Cc: Anup Patel <anup@brainfault.org>
> > > Cc: Atish Patra <atish.patra@wdc.com>
> > >
> > > ---
> > >
> > > Changes since V3:
> > >  - Rename "c9xx" to "c900"
> > >  - Add thead,c900-plic in the description section
> > > ---
> > >  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml    | 6 ++++=
++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/s=
ifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-control=
ler/sifive,plic-1.0.0.yaml
> > > index 08d5a57ce00f..82629832e5a5 100644
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,p=
lic-1.0.0.yaml
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,p=
lic-1.0.0.yaml
> > > @@ -35,6 +35,11 @@ description:
> > >    contains a specific memory layout, which is documented in chapter =
8 of the
> > >    SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U5=
4-MC-RVCoreIP.pdf>.
> > >
> > > +  While the "thead,c900-plic" would mask IRQ with readl(claim), so i=
t needn't
> > > +  mask/unmask which needed in RISC-V PLIC. When in IRQS_ONESHOT & IR=
QCHIP_EOI_THREADED
> > > +  path, unnecessary mask operation would cause a blocking irq bug in=
 thead,c900-plic.
> > > +  Because when IRQ is disabled in c900, writel(hwirq, claim) would b=
e invalid.
> >
> > This is a totally incorrect description of the errata required for C9xx=
 PLIC.
> >
> > Please don't project non-compliance as a feature of C9xx PLIC.
> >
> > > +
> > >  maintainers:
> > >    - Sagar Kadam <sagar.kadam@sifive.com>
> > >    - Paul Walmsley  <paul.walmsley@sifive.com>
> > > @@ -46,6 +51,7 @@ properties:
> > >        - enum:
> > >            - sifive,fu540-c000-plic
> > >            - canaan,k210-plic
> > > +          - thead,c900-plic
>
> we still want specific SoC names in the compatible, the "c900"
> is still a sort-of placeholder.
c900 is not a SOC name, but a CPU name. For soc name, it should be
"allwinner,d1-plic".

>
>
> > >        - const: sifive,plic-1.0.0
> >
> > The PLIC DT node requires two compatible string:
> > <implementation_compat>, <spec_compat>
> >
> > The C9xx PLIC is not RISC-V PLIC so, the DT node should
> > be: "thead,c900-plic", "thead,c9xx-plic"
> >
> > You need to change "- const: sifive,plic-1.0.0" to
> > - enum:
> >     - sifive,plic-1.0.0
> >     - thead,c9xx-plic
>
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
