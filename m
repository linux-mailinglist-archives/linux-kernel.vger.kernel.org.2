Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9894387D4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 11:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhJXJVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 05:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhJXJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 05:21:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1394FC061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 02:18:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 84-20020a1c0457000000b003232b0f78f8so9501572wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 02:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgyiV7a56jcfc4Zgoz6RZ06xgGpfIBQ1EcTEps9MZjg=;
        b=XKSV0mMdPBwyMtpoB+nMYnoMrQWo7jtJYxcm9fM447tgOmbpzq2q1uBMTJ6OCoqJsa
         xUaNmOpA6PXlO5DIHHercncaA7oEyh/taIXVaw9rhbaccLMFTbX/Ei+55vl1/xWraSW8
         iHxKtOzpHQaJIsXtzifgJd67lg3/C7/WbYhGJLUwcoAqEJnp96yfLaRXYOKDYdExgWKj
         BOa3XPKe+0LaX8JPO8BjVK1KVaQAF+265jypGC5JHayXfgy23HJyUqyrg2p6pU9ssjDz
         bmygz1sfZtTKR7XjStPG5terbAPdKGJnGJ2nOx1jp3H01BUhYyEpKImZ8hMDC0UWei/U
         QpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgyiV7a56jcfc4Zgoz6RZ06xgGpfIBQ1EcTEps9MZjg=;
        b=fsZcPuaINKtqp+DtGtmIUPw9AIIJsvGTCM2Ld1ZmBRmPCbyaNsw2KwcBHKhdWcrQUn
         Ie5970ZBSiSQTL996v8VUnZef8mgulY8unpTtCtciCh8iX6/3zbNhtBF2fkNt2tM/9eu
         Dmf1pR+dnwkW96FqcFg5RURzffa7BzOiVawpiW59fxUCSn4B6CWYCD2YEoUEP0rj4A3M
         Y3pOXNMyhlMTlg/DXgpHJxvO0K7It5dFg9E01V3Wqycv2to9QPYvGy1UkUv87g056eaI
         NXgHSjN5LCHwOrgmmgNZFTDKVUanGWUgfCb+9LWjQSLGl31PEXbsQfckcz7b1IhCCXXA
         k2Zw==
X-Gm-Message-State: AOAM530NumJLcBTEy4QCREqWM/mfohJVrCIYG+lv99jhnj3IVqgr+uop
        pAuKeW3iPf6QxXB5eg3sWEmGNXLJID9Wto4akGkkgA==
X-Google-Smtp-Source: ABdhPJxdU+4zeuFzfRihPM9WedFMwnx5jYQEiDfGFR2NApNSgsTeKpCU8nbwhdPVkMLvdUDFBZDWn1zlnN+yOpiVVf0=
X-Received: by 2002:a1c:7918:: with SMTP id l24mr11879021wme.137.1635067129520;
 Sun, 24 Oct 2021 02:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-3-guoren@kernel.org>
 <CAAhSdy2a2XgjOpezoq=SvX2XTcAWhceKF9X9v3z7xyO9Z4DMPQ@mail.gmail.com> <CAJF2gTTKJXY6DAq=-ajAiTEY7hpMT1bqnvNndW=5EnD5EEP-cw@mail.gmail.com>
In-Reply-To: <CAJF2gTTKJXY6DAq=-ajAiTEY7hpMT1bqnvNndW=5EnD5EEP-cw@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 24 Oct 2021 14:48:38 +0530
Message-ID: <CAAhSdy1FfMGPWBExEVe9Vdh2s_fNP43Rp7jNdEMNmP1nmPZL_Q@mail.gmail.com>
Subject: Re: [PATCH V5 2/3] dt-bindings: update riscv plic compatible string
To:     Guo Ren <guoren@kernel.org>
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

On Sun, Oct 24, 2021 at 2:31 PM Guo Ren <guoren@kernel.org> wrote:
>
> On Sun, Oct 24, 2021 at 3:35 PM Anup Patel <anup@brainfault.org> wrote:
> >
> > On Sun, Oct 24, 2021 at 7:03 AM <guoren@kernel.org> wrote:
> > >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Add the compatible string "thead,c900-plic" to the riscv plic
> > > bindings to support allwinner d1 SOC which contains c906 core.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Cc: Anup Patel <anup@brainfault.org>
> > > Cc: Atish Patra <atish.patra@wdc.com>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > >
> > > ---
> > >
> > > Changes since V5:
> > >  - Add DT list
> > >  - Fixup compatible string
> > >  - Remove allwinner-d1 compatible
> > >  - make dt_binding_check
> > >
> > > Changes since V4:
> > >  - Update description in errata style
> > >  - Update enum suggested by Anup, Heiko, Samuel
> > >
> > > Changes since V3:
> > >  - Rename "c9xx" to "c900"
> > >  - Add thead,c900-plic in the description section
> > > ---
> > >  .../interrupt-controller/sifive,plic-1.0.0.yaml   | 15 ++++++++++++---
> > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > index 08d5a57ce00f..18b97bfd7954 100644
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > > @@ -35,6 +35,10 @@ description:
> > >    contains a specific memory layout, which is documented in chapter 8 of the
> > >    SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
> > >
> > > +  The thead,c900-plic couldn't complete masked irq source which has been disabled in
> > > +  enable register. Add thead_plic_chip which fix up c906-plic irq source completion
> > > +  problem by unmask/mask wrapper.
> > > +
> >
> > This is an incomplete description about how T-HEAD PLIC is different from
> > RISC-V PLIC.
> >
> > I would suggest the following:
> >
> > The T-HEAD C9xx SoC implements a modified/custom T-HEAD PLIC specification
> > which will mask current IRQ upon read to CLAIM register and will unmask the IRQ
> > upon write to CLAIM register. The thead,c900-plic compatible string
> > represents the
> > custom T-HEAD PLIC specification.
> The patch fixup the problem that when "thead,c900-plic" couldn't
> complete masked irq source which has been disabled.
>
> This patch is different from the last one in that there is no
> relationship with the auto-mask feature.

This patch adds compatible string for T-HEAD PLIC so it
should describe how T-HEAD PLIC is different from RISC-V
PLIC. The DT bindings document describes HW and not
the software work-around implemented using DT bindings.

Your irqchip patch uses T-HEAD PLIC compatible string to
implement a work-around.

In other words, this patch is different from the irqchip patch.

Regards,
Anup

>
> >
> > Regards,
> > Anup
> >
> > >  maintainers:
> > >    - Sagar Kadam <sagar.kadam@sifive.com>
> > >    - Paul Walmsley  <paul.walmsley@sifive.com>
> > > @@ -42,11 +46,16 @@ maintainers:
> > >
> > >  properties:
> > >    compatible:
> > > -    items:
> > > +   oneOf:
> > > +    - items:
> > >        - enum:
> > > -          - sifive,fu540-c000-plic
> > > -          - canaan,k210-plic
> > > +        - sifive,fu540-c000-plic
> > > +        - canaan,k210-plic
> > >        - const: sifive,plic-1.0.0
> > > +    - items:
> > > +      - enum:
> > > +        - allwinner,sun20i-d1-plic
> > > +      - const: thead,c900-plic
> > >
> > >    reg:
> > >      maxItems: 1
> > > --
> > > 2.25.1
> > >
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
