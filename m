Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD8945E9FE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353444AbhKZJKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245170AbhKZJIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:08:41 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2953DC061746
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 01:05:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id a18so17129939wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 01:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VOszlauxSKRV5GdcAuyWOFBZoDmtHbCxcUQ0mFztaQs=;
        b=fTydEgc1BkjDuikjg/tqneBR45cgcl8+pNxIT2JOAFt7Z1QBLiRXywcSlbXXkG+xK5
         sDA14RfYXUJsXP3gXjW3a0vrO+wi2JIaebo80OAsYQPxWYBTPPXUDCwVUdxXQMznolWw
         Mx/S5rumtAswC5AgJmj6Y6ODFEH7XzrByarix8mVIXdJt5/E/tvP6DZZdDWeGWQYRlKg
         sviZfV/wkvYPKAxIPUIsKPGKrWfT7b3K8+FJ4yImnSY7x8bP+GOXykT7/rLReLEB3+mr
         8BZXWG8wx4PHSuQ7HqXreNzBlWYk2RsAdsfDQzWG3/N2pjhuY7C3+y++kO770xcqaUde
         X5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VOszlauxSKRV5GdcAuyWOFBZoDmtHbCxcUQ0mFztaQs=;
        b=EoUZKyU9PE36MKDCqV5/eAIZjS+dPC1wg1Y7ujOU6tfqm9V00HPWbZ5R+QaiDKkNik
         HrTe8/gkUVPoNqAdUvLWKNGP2AkDdFJXhkaLvrzKnLnwcLpCgvm7kZ/v6quiK87lKkWE
         9zSOAaeQttgVQBITqHgbKxnpzN1ubFmXevg4btgRyfKcXdsbHn25MKcUTAver4u/ka+H
         X9nWpypHRkvUZOJ4t+/yz94+xntAo/JKLk83H3s6r34DreHPKzj7V5Kc7zU/d4iTJoyp
         8qAE9RTBe0VWPWD7u9NQjlnnAcJ8fws4HNV+SDgC74Gf7LjDHcQsUrhvry3InvARaeRE
         fZvw==
X-Gm-Message-State: AOAM533RThNJd35pOPjA/UiarWE71SA5F0I+bS2hfNmfRYCYyKYGkx4u
        q/6aZmd4LDzlQQnMz6OpcIlMfRnG5oqnfcwaV+Iw1g==
X-Google-Smtp-Source: ABdhPJx2g0Ir5Jx6J9mngEH1tP5d7kuUVF/S+thBQllAKNw54Ur1qZPJS78YnNnTQnM+vBWDFPyL9PWm49w43w+RVxE=
X-Received: by 2002:adf:e848:: with SMTP id d8mr12866916wrn.3.1637917526467;
 Fri, 26 Nov 2021 01:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20211125152233.162868-1-geert@linux-m68k.org> <161F972E-7972-4001-BE19-C88F81EF8047@jrtc27.com>
 <CAMuHMdXpmnmAy7cvA4b9LZe1skzjyOmYgUMgY7KiLRPznSj+2Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXpmnmAy7cvA4b9LZe1skzjyOmYgUMgY7KiLRPznSj+2Q@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 26 Nov 2021 14:35:14 +0530
Message-ID: <CAAhSdy1SGQqSupUZyPRUak3zEKOXkX9emdQ8bSoB4-zGZOSyhg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: sifive, plic: Fix
 number of interrupts
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michael Zhu <michael.zhu@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 2:28 PM Geert Uytterhoeven <geert@linux-m68k.org> w=
rote:
>
> Hi Jessica,
>
> On Thu, Nov 25, 2021 at 5:08 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
> > On 25 Nov 2021, at 15:22, Geert Uytterhoeven <geert@linux-m68k.org> wro=
te:
> > > To improve human readability and enable automatic validation, the tup=
les
> > > in "interrupts-extended" properties should be grouped using angle
> > > brackets.  As the DT bindings lack an upper bound on the number of
> > > interrupts, thus assuming one, proper grouping is currently flagged a=
s
> > > an error.
>
> Rob: Is this a bug in the tooling that should be fixed?
> Regardless, specifying a real upper limit is always a good idea.
>
> > > Fix this by adding the missing "maxItems", limiting it to 9 interrupt=
s
> > > (one interrupt for a system management core, and two interrupts per c=
ore
> > > for other cores), which should be sufficient for now.
> >
> > This is SiFive=E2=80=99s IP, so is this actually true? I would imagine =
it=E2=80=99s
> > just parameterised and could be generated with as many targets as fit
> > in the MMIO space, and that this is thus inaccurate. Besides, such a
>
> Yes, this is implementation-defined.  I just used the maximum value
> currently in use.
>
> drivers/irqchip/irq-sifive-plic.c has #define MAX_CONTEXTS 15872,
> which matches the value of CONTEXT_PER_HART and the available address
> space in the driver and in [1].
> Would you be more comfortable with "maxItems: 15872"?
> Or do you prefer setting the maximum based on the compatible value
> (2 for k210, 9 for fu540, 4 for jh7100[2])?

Yes, 15872 is an appropriate value for "maxItems".

Regards,
Anup

>
> > function change should be made separately from the grouping change.
>
> OK, will split in v2.
>
> > The same goes for your equivalent sifive,clint0 patch.
>
> OK.
>
> > > Group the tuples in the example.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > ---
> > > .../interrupt-controller/sifive,plic-1.0.0.yaml      | 12 ++++++-----=
-
> > > 1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/interrupt-controller/s=
ifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-control=
ler/sifive,plic-1.0.0.yaml
> > > index 08d5a57ce00ff446..198b373f984f3438 100644
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,p=
lic-1.0.0.yaml
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,p=
lic-1.0.0.yaml
> > > @@ -61,6 +61,7 @@ properties:
> > >
> > >   interrupts-extended:
> > >     minItems: 1
> > > +    maxItems: 9
> > >     description:
> > >       Specifies which contexts are connected to the PLIC, with "-1" s=
pecifying
> > >       that a context is not present. Each node pointed to should be a
>
> [1] https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf
> [2] The PLIC memory map in
>     https://github.com/starfive-tech/JH7100_Docs/blob/main/vic_u7_manual_=
with_creativecommons.pdf
>     indicate other values of ENABLE_PER_HART and CONTEXT_PER_HART?
>     Is memory the map correct?
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
