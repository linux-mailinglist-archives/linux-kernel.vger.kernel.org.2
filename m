Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052A345EA4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 10:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346114AbhKZJ1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 04:27:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359817AbhKZJZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 04:25:16 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4CFC0619DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 01:14:59 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso10190615wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 01:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RIa0tC4q8Mnplv7In8ruGkJCIcDpzXyFfkRNTnI/gU=;
        b=htVKZXcK7jnZggEM+44KEeJ5RS4R61e6LoW/7Ovf4aKoMyh0D2rehHg/92Myo0LSfT
         oGaBJ98mXkJxqsu1B32J4FzHHC+djXhtbqnFx9rcq123+aMwxgk6LjVjGd4FdwQa+tFs
         wdYhW+I7+9jSBkVBmXnMytE6zvCHWd4x2g286RkS6xWQ0qo2A1qzwIIoM7lGNrb5N4TQ
         o+o/uoPrM8xEnLf7Vw+bcES5+aSi5RAjXaDTAqRFIj8Kn6ta63UmcD+oj7WiMA7Tky0x
         MeAQxygYR/HTtB9pt7w4rQeJnJGCo3UUK7Bq5fX3bNkktp9xI+uTD3cqQn6SLxVBuNSE
         pXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RIa0tC4q8Mnplv7In8ruGkJCIcDpzXyFfkRNTnI/gU=;
        b=s0QWzAjXeEC4p4oPAh5elseY4jTP3af+IeWvCRrm/hXHF6KD2B/Ari6KjEbpmmIF6F
         +cr7QZiz8A1uSZSu4Cp5IFVCv9cpYHHbtkJJClpU9Le+7V34ui7TMGqR/UWAvTrg/G2h
         am0GkmBEpjvW98kXo1uG57eCCyKBUsu9puAFf+p0pLae3xYSnZsaur/euHmYFBKanszk
         wq1GdaOAkTN4bLtvFrhfeC79mlyhycuNhLEJRXS3F2jA6ETRAic6hYd3AWCVa4BRqS3n
         HEJ4Dbu9QaSkdcuIafy8M7r4M6NPUMYyXiu3/5A80rpSzTigTGi6Ldkh/VzeK0vXunQb
         m/rw==
X-Gm-Message-State: AOAM531s4GHZx2t5sqVYuYZBHopdy4qUX4OH64SBBMwzbzCqxSelHhd4
        eHnNOcbhJ01aOsrCEYVLSXdjTMbfLX2u7b+k2mdXsg==
X-Google-Smtp-Source: ABdhPJwC+do93NOFr9ub+o9kEAa0iBiw1ZnHGEoh33mkwVEbddlO34ojqOj2q4LxPp++TXTkSBu7/PkyFknSPRJbZ/c=
X-Received: by 2002:a1c:7201:: with SMTP id n1mr14095206wmc.176.1637918098323;
 Fri, 26 Nov 2021 01:14:58 -0800 (PST)
MIME-Version: 1.0
References: <20211125152317.162958-1-geert@linux-m68k.org> <CAMuHMdVg-r3P_SPqDK7K4rYLzLP+=Wy9KatiNrpK7ebKJSx-Tg@mail.gmail.com>
In-Reply-To: <CAMuHMdVg-r3P_SPqDK7K4rYLzLP+=Wy9KatiNrpK7ebKJSx-Tg@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 26 Nov 2021 14:44:47 +0530
Message-ID: <CAAhSdy2WEAkVBh9Za-w4nzpEiVT17RNFOAKJEHFce+rsYiaCQQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: sifive, clint: Fix number of interrupts
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Fri, Nov 26, 2021 at 2:34 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Thu, Nov 25, 2021 at 4:23 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > To improve human readability and enable automatic validation, the tuples
> > in "interrupts-extended" properties should be grouped using angle
> > brackets.  As the DT bindings lack an upper bound on the number of
> > interrupts, thus assuming one, proper grouping is currently flagged as
> > an error.
> >
> > Fix this by adding the missing "maxItems", limiting it to 10 interrupts
> > (two interrupts for a system management core, and two interrupts per
> > core for other cores), which should be sufficient for now.
> >
> > Group the tuples in the example.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> >  .../devicetree/bindings/timer/sifive,clint.yaml          | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > index a35952f487426988..55bec2d059807c48 100644
> > --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> > @@ -43,6 +43,7 @@ properties:
> >
> >    interrupts-extended:
> >      minItems: 1
> > +    maxItems: 10
>
> Cfr. Jessica's comment on my PLIC patch:
>
> The maximum supported by the CLINT memory map is 8192.
> Device-specific limits would be 4 for k210 and jh7100, and 10 for
> fu540.

As-per CLINT chapter of SiFive FU740 manual:
1) Offset 0x0000 to 0x3fff is MSIPx registers (up to 4096 registers)
2) Offset 0x4000 to 0xbff7 is MTIMECMPx registers (up to 4095 registers)
3) Offset 0xbff8 to 0xc000 is MTIME register
(Refer, https://sifive.cdn.prismic.io/sifive/28560457-c5a4-4f88-866c-8098d02afea1_FU740-C000-Manual-v1p0.pdf)

The "maxItems" for SiFive CLINT should be 4095.

Regards,
Anup

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
