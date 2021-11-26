Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF6B45EA57
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344599AbhKZJ3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:29:05 -0500
Received: from mail-ua1-f43.google.com ([209.85.222.43]:40791 "EHLO
        mail-ua1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbhKZJ1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:27:05 -0500
Received: by mail-ua1-f43.google.com with SMTP id y5so17326759ual.7;
        Fri, 26 Nov 2021 01:23:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SktczEZvO7fymdakFqebWM/pQEoSmTkh1E0WAx6R/E0=;
        b=bbSy814SJk5bKDaZd91igWSvMxNKfDib6wGMVo2reJhT+WMTNgLYUt2/1QFEb2tSAL
         RYVA/1Y0QTpUcOE6lYXBWXJ/uJ9vgya83BlSRdYoDf/zj81R63kCS4GtMwBXubz8iMih
         VwTjLp7lMnZVpqYdQjpXROUDz2ASikIS97+4l3a/a8uyIoTEE4icpclof3h3dnZGYLx5
         SuLwp9vnHzM4ilz3HvKBNPvrhR0d2ndvfXdb3Pr9anSmyITeeL4Rn0YZb4kNWTH6Nb4b
         A+p52LZbWOI+fgoLLOyf6btnktY+Yfv1cx0NrTYDHAU/hsDyOjnPfIADIqBb4s2l8OIP
         aUZQ==
X-Gm-Message-State: AOAM530kGRukOIg3DXIc+BA1uqkE2wYRL+5Ox0s5Fx77+nqPSJKE6hmu
        KPcSktdWsPKUIQSiELj5KI8FsjWKHBgUCA==
X-Google-Smtp-Source: ABdhPJy5l+TohySFU8s2yMgmxgZD8qod85TL2weGNOS6U1E/NUhejWnnSFIs8KWn9nM5s04UcqSpSQ==
X-Received: by 2002:ab0:6c44:: with SMTP id q4mr33877854uas.72.1637918631782;
        Fri, 26 Nov 2021 01:23:51 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id n10sm3663811uaj.20.2021.11.26.01.23.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Nov 2021 01:23:51 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id w23so17340073uao.5;
        Fri, 26 Nov 2021 01:23:50 -0800 (PST)
X-Received: by 2002:a05:6102:3232:: with SMTP id x18mr15892154vsf.38.1637918630521;
 Fri, 26 Nov 2021 01:23:50 -0800 (PST)
MIME-Version: 1.0
References: <20211125152317.162958-1-geert@linux-m68k.org> <CAMuHMdVg-r3P_SPqDK7K4rYLzLP+=Wy9KatiNrpK7ebKJSx-Tg@mail.gmail.com>
 <CAAhSdy2WEAkVBh9Za-w4nzpEiVT17RNFOAKJEHFce+rsYiaCQQ@mail.gmail.com>
In-Reply-To: <CAAhSdy2WEAkVBh9Za-w4nzpEiVT17RNFOAKJEHFce+rsYiaCQQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 26 Nov 2021 10:23:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWAHW-RF-RrMbH=AsVmSRw=JEsUot0PaMzDdve70JfXQQ@mail.gmail.com>
Message-ID: <CAMuHMdWAHW-RF-RrMbH=AsVmSRw=JEsUot0PaMzDdve70JfXQQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: sifive, clint: Fix number of interrupts
To:     Anup Patel <anup@brainfault.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anup,

On Fri, Nov 26, 2021 at 10:15 AM Anup Patel <anup@brainfault.org> wrote:
> On Fri, Nov 26, 2021 at 2:34 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Nov 25, 2021 at 4:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > To improve human readability and enable automatic validation, the tuples
> > > in "interrupts-extended" properties should be grouped using angle
> > > brackets.  As the DT bindings lack an upper bound on the number of
> > > interrupts, thus assuming one, proper grouping is currently flagged as
> > > an error.
> > >
> > > Fix this by adding the missing "maxItems", limiting it to 10 interrupts
> > > (two interrupts for a system management core, and two interrupts per
> > > core for other cores), which should be sufficient for now.
> > >
> > > Group the tuples in the example.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > > ---
> > >  .../devicetree/bindings/timer/sifive,clint.yaml          | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > index a35952f487426988..55bec2d059807c48 100644
> > > --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > > @@ -43,6 +43,7 @@ properties:
> > >
> > >    interrupts-extended:
> > >      minItems: 1
> > > +    maxItems: 10
> >
> > Cfr. Jessica's comment on my PLIC patch:
> >
> > The maximum supported by the CLINT memory map is 8192.
> > Device-specific limits would be 4 for k210 and jh7100, and 10 for
> > fu540.
>
> As-per CLINT chapter of SiFive FU740 manual:
> 1) Offset 0x0000 to 0x3fff is MSIPx registers (up to 4096 registers)
> 2) Offset 0x4000 to 0xbff7 is MTIMECMPx registers (up to 4095 registers)

Thanks, I had missed these are 64-bit (and did wonder about the extra
space ;-)

> 3) Offset 0xbff8 to 0xc000 is MTIME register
> (Refer, https://sifive.cdn.prismic.io/sifive/28560457-c5a4-4f88-866c-8098d02afea1_FU740-C000-Manual-v1p0.pdf)
>
> The "maxItems" for SiFive CLINT should be 4095.

OK.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
