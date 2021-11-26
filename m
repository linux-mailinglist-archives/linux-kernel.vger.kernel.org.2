Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2E45E9C7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359667AbhKZJDx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Nov 2021 04:03:53 -0500
Received: from mail-vk1-f181.google.com ([209.85.221.181]:36721 "EHLO
        mail-vk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347287AbhKZJBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:01:51 -0500
Received: by mail-vk1-f181.google.com with SMTP id b192so5516178vkf.3;
        Fri, 26 Nov 2021 00:58:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u0lBhcfAnaRE4bZpFJuFyiABanuMWgBjQpH4Ikk8Mt8=;
        b=Pj6opvr5c86tgGbApR+aFrKiQD1UlXXFaAAeQtkBvEE7jWNE5BQp4BxNdjO0gt0pgS
         ssNTYhDyru/8eSbd6oE0LpJBW35ug3WTTC0AN4iJDR47T+mp5D5WFphoZpb2oqn757eN
         ymM/O2aBs/NNFR/F1mnIPc4Ds5p2bSQXWeTrUFUN6IQdA3bKvUIk7OSZo82yEliLr7B7
         v7FORF/XFDz6pnYzHTif8pggrMEdlLWquwjH9kmnNIdFrwj5FLEFdFGUzjyY7es1v09n
         ziMHmYPdacAZNFU6y/GgmaoDKniN/1rZQTBp90QUHEnsgs3//rRrtYBfOwUIIuX0OWu6
         X0cw==
X-Gm-Message-State: AOAM532K52wOuaNUXXQv9MS03tpqbEjt4PTNJ0QSC5xb9Efua6AvpELM
        lHONg6k4gI5UmQC5E/TgQMKCuSLXeRPgwQ==
X-Google-Smtp-Source: ABdhPJzjkQkjdr5v6Miv4sKYGon6BIEkhMALh+0GqOCPrV/XCruozXwqzocLV4P4n/pyEPLBzCxwMQ==
X-Received: by 2002:a1f:5f94:: with SMTP id t142mr18037111vkb.34.1637917117998;
        Fri, 26 Nov 2021 00:58:37 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id n12sm3541380vsv.32.2021.11.26.00.58.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 00:58:37 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id f7so5494227vkf.10;
        Fri, 26 Nov 2021 00:58:37 -0800 (PST)
X-Received: by 2002:a05:6122:2193:: with SMTP id j19mr18403354vkd.7.1637917116905;
 Fri, 26 Nov 2021 00:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20211125152233.162868-1-geert@linux-m68k.org> <161F972E-7972-4001-BE19-C88F81EF8047@jrtc27.com>
In-Reply-To: <161F972E-7972-4001-BE19-C88F81EF8047@jrtc27.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Nov 2021 09:58:25 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXpmnmAy7cvA4b9LZe1skzjyOmYgUMgY7KiLRPznSj+2Q@mail.gmail.com>
Message-ID: <CAMuHMdXpmnmAy7cvA4b9LZe1skzjyOmYgUMgY7KiLRPznSj+2Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: sifive, plic: Fix
 number of interrupts
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

On Thu, Nov 25, 2021 at 5:08 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
> On 25 Nov 2021, at 15:22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > To improve human readability and enable automatic validation, the tuples
> > in "interrupts-extended" properties should be grouped using angle
> > brackets.  As the DT bindings lack an upper bound on the number of
> > interrupts, thus assuming one, proper grouping is currently flagged as
> > an error.

Rob: Is this a bug in the tooling that should be fixed?
Regardless, specifying a real upper limit is always a good idea.

> > Fix this by adding the missing "maxItems", limiting it to 9 interrupts
> > (one interrupt for a system management core, and two interrupts per core
> > for other cores), which should be sufficient for now.
>
> This is SiFive’s IP, so is this actually true? I would imagine it’s
> just parameterised and could be generated with as many targets as fit
> in the MMIO space, and that this is thus inaccurate. Besides, such a

Yes, this is implementation-defined.  I just used the maximum value
currently in use.

drivers/irqchip/irq-sifive-plic.c has #define MAX_CONTEXTS 15872,
which matches the value of CONTEXT_PER_HART and the available address
space in the driver and in [1].
Would you be more comfortable with "maxItems: 15872"?
Or do you prefer setting the maximum based on the compatible value
(2 for k210, 9 for fu540, 4 for jh7100[2])?

> function change should be made separately from the grouping change.

OK, will split in v2.

> The same goes for your equivalent sifive,clint0 patch.

OK.

> > Group the tuples in the example.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > .../interrupt-controller/sifive,plic-1.0.0.yaml      | 12 ++++++------
> > 1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > index 08d5a57ce00ff446..198b373f984f3438 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> > @@ -61,6 +61,7 @@ properties:
> >
> >   interrupts-extended:
> >     minItems: 1
> > +    maxItems: 9
> >     description:
> >       Specifies which contexts are connected to the PLIC, with "-1" specifying
> >       that a context is not present. Each node pointed to should be a

[1] https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf
[2] The PLIC memory map in
    https://github.com/starfive-tech/JH7100_Docs/blob/main/vic_u7_manual_with_creativecommons.pdf
    indicate other values of ENABLE_PER_HART and CONTEXT_PER_HART?
    Is memory the map correct?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
