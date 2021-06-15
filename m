Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D353A88CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhFOSuY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Jun 2021 14:50:24 -0400
Received: from mail-vk1-f174.google.com ([209.85.221.174]:43650 "EHLO
        mail-vk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbhFOSuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:50:22 -0400
Received: by mail-vk1-f174.google.com with SMTP id d13so47084vkl.10;
        Tue, 15 Jun 2021 11:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WGPi/wXiZjPo5w4DPHF3qlaSDaruBYsxDZl7JrnERyE=;
        b=B3+g0pU00IZQP4X7tQaOCngXVEoTtgAJZnGTV9vxndMkQnpI5JsSNxfYrOrfAIuDvg
         fcmqkTKrIWlaCjtvKAOxmNHEseG8rzxJIKFQBoKj0bhi/tKswE+2YJO5u/KKu0VQux4M
         5KY12RdQvn0G5GjahOAJt9JcWw1VQIcjF/4HRZUkCmmuCLJMyw8wP+Jw1LgdHBIy6iD9
         B+OgrlgCE/11KK1yIuwQXJS/86uCE+y2MAF3FQIpVpz/RJ/lzWZhkv+SILAgC1FBASke
         hJNnKMLwzmhGxAEBy2oLWH97Nin94Fzg5RoY3wsfEBFCi8o3mzb9TkmYV5pSmQDW2FiM
         kBtA==
X-Gm-Message-State: AOAM531unPSb/iuEkiD1B83dp96jm969x/WiBJoRcKQTUIG7YaeU5pSq
        SQaK6Lxhb23bbwWl+mysyAz6mawzSfgSW8ssC2s=
X-Google-Smtp-Source: ABdhPJyw49VknPdSZNzySmsqz3tuP81/+LXhX25/+RNCDBWNub6bhsIxOQ6G6dXG++0p/CUhpt03g4wh6B0nCOy678U=
X-Received: by 2002:a1f:ac45:: with SMTP id v66mr6243318vke.1.1623782896276;
 Tue, 15 Jun 2021 11:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210419005539.22729-1-mick@ics.forth.gr> <20210419005539.22729-6-mick@ics.forth.gr>
 <CAMuHMdW=23SPXwqcjD+30M_d0azdze2=ChZM-PF1brf9bCNtrA@mail.gmail.com> <fe02eb618eee141e8bc021e8e30906fc@mailhost.ics.forth.gr>
In-Reply-To: <fe02eb618eee141e8bc021e8e30906fc@mailhost.ics.forth.gr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Jun 2021 20:48:05 +0200
Message-ID: <CAMuHMdXtT1L3yfzkTkbhqz3zgUQj89Bcm7mqz+m126NprAsK8Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] RISC-V: Add crash kernel support
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Jun 15, 2021 at 8:29 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
> Στις 2021-06-15 16:19, Geert Uytterhoeven έγραψε:
> > This does not match
> > https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml#L77:
> >
> >     $ref: types.yaml#/definitions/uint64-array
> >     maxItems: 2
> >     description:
> >       This property (currently used only on arm64) holds the memory
> > range,
> >       the address and the size, of the elf core header which mainly
> > describes
> >       the panicked kernel\'s memory layout as PT_LOAD segments of elf
> > format.
> >
> > Hence "linux,elfcorehdr" should be a property of the /chosen node,
> > instead of a memory node with a compatible value of "linux,elfcorehdr".
> >
>
> That's a binding for a property on the /chosen node, that as the text
> says it's defined for arm64 only and the code that handled it was also

That doesn't mean it must not be used on other architectures ;-)
Arm64 was just the first one to use it...

> on arm64. Instead the reserved-region binding I used is a standard
> binding, if you don't like the name used for the compatible string
> because it overlaps with that property we can change it. I want to use a
> reserved-region for this because we'll have to reserve it anyway so
> using a property on /chosen and then using that property to reserve the
> region seemed suboptimal.
>
> >> v2:
> >>  * Use linux,usable-memory on /memory instead of a new binding
> >
> > This part seems to have been removed in v3 and later?
> > Note that "linux,usable-memory-range" should be a property of the
> > /chosen node, too, cfr.
> > https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml#L85
> >
>
> No special handling is needed when using linux,usable-memory on /memory,
> limiting the available memory is handled by generic code at
> drivers/of/fdt.c

It was my understanding both properties under /chosen are the
recommended methods for new platforms... Let's see what Rob has
to say...

Anyway, I sent a patch series to switch to generic "linux,elfcorehdr"
handling
https://lore.kernel.org/r/cover.1623780059.git.geert+renesas@glider.be/

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
