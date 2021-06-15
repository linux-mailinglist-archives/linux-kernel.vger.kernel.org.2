Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B8A3A8971
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 21:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbhFOTX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 15:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:57136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229946AbhFOTX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 15:23:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D64EF6109D;
        Tue, 15 Jun 2021 19:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623784911;
        bh=MiyNMOqe8D+Qv1ZCBNXEEXX1PzZVvhgk3ba2lE4oIg8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mtoG7zNPtpZsvQbvGP8yhZylUX75lhUTO0D3sGutRFQw4YsC/rBkyY/aHqAa3/x7Z
         FUurSl0cAWCim2VhAR/W2YM/ZVElxcCC+RoJMkLqlo/GGM6ZlLYp8X9q15baYqri3U
         L5CQGt0K11TGkZbZ5SoMB6QxIOE4JFnnUbIULj71aWTCQ+Pkgp4CKF4lIy9Qy3qk5j
         F0Y83bsO/aP731wd93GFUKpUYngFSP8I+RcM6jiYeT93Qa+yMWv5R7HY9BEYjPKDxk
         Vwoth1qDiFUPTHKq0BBr9yUiKBh2VWI+mRLPR1zl4Jv/ibpCeJOcOk3pCG+yYPK4GU
         rGBWtfIiEGdag==
Received: by mail-ej1-f52.google.com with SMTP id k7so24327321ejv.12;
        Tue, 15 Jun 2021 12:21:51 -0700 (PDT)
X-Gm-Message-State: AOAM5318De7cuvVvG31s6wJX1cZB5VLmLlXVvbw4EebV8ILKJCAT/IFh
        UTXs2rofUHGiguQI9mo70kFv/0aOETaMN/hPCA==
X-Google-Smtp-Source: ABdhPJwa2eewtgu6uySopO4xXVRmZ/yjtkv5h1exXtdSD1u+7n88m1i55KAd4hYrQJiPXyTsdD6k57DUi86pkmYzJdA=
X-Received: by 2002:a17:907:2059:: with SMTP id pg25mr1204414ejb.130.1623784910428;
 Tue, 15 Jun 2021 12:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210419005539.22729-1-mick@ics.forth.gr> <20210419005539.22729-6-mick@ics.forth.gr>
 <CAMuHMdW=23SPXwqcjD+30M_d0azdze2=ChZM-PF1brf9bCNtrA@mail.gmail.com>
 <fe02eb618eee141e8bc021e8e30906fc@mailhost.ics.forth.gr> <CAMuHMdXtT1L3yfzkTkbhqz3zgUQj89Bcm7mqz+m126NprAsK8Q@mail.gmail.com>
In-Reply-To: <CAMuHMdXtT1L3yfzkTkbhqz3zgUQj89Bcm7mqz+m126NprAsK8Q@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Jun 2021 13:21:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLHOmZ6az0bYGC3dg__YX3aq=+Un4_x4+R2nNksc0hM2g@mail.gmail.com>
Message-ID: <CAL_JsqLHOmZ6az0bYGC3dg__YX3aq=+Un4_x4+R2nNksc0hM2g@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] RISC-V: Add crash kernel support
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 12:48 PM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Nick,
>
> On Tue, Jun 15, 2021 at 8:29 PM Nick Kossifidis <mick@ics.forth.gr> wrote=
:
> > =CE=A3=CF=84=CE=B9=CF=82 2021-06-15 16:19, Geert Uytterhoeven =CE=AD=CE=
=B3=CF=81=CE=B1=CF=88=CE=B5:
> > > This does not match
> > > https://github.com/devicetree-org/dt-schema/blob/master/schemas/chose=
n.yaml#L77:
> > >
> > >     $ref: types.yaml#/definitions/uint64-array
> > >     maxItems: 2
> > >     description:
> > >       This property (currently used only on arm64) holds the memory
> > > range,
> > >       the address and the size, of the elf core header which mainly
> > > describes
> > >       the panicked kernel\'s memory layout as PT_LOAD segments of elf
> > > format.
> > >
> > > Hence "linux,elfcorehdr" should be a property of the /chosen node,
> > > instead of a memory node with a compatible value of "linux,elfcorehdr=
".
> > >
> >
> > That's a binding for a property on the /chosen node, that as the text
> > says it's defined for arm64 only and the code that handled it was also
>
> That doesn't mean it must not be used on other architectures ;-)
> Arm64 was just the first one to use it...

It is used on arm64 because memory is often passed by UEFI tables and
not with /memory node. As riscv is also supporting EFI, I'd think they
would do the same.

> > on arm64. Instead the reserved-region binding I used is a standard
> > binding, if you don't like the name used for the compatible string
> > because it overlaps with that property we can change it. I want to use =
a
> > reserved-region for this because we'll have to reserve it anyway so
> > using a property on /chosen and then using that property to reserve the
> > region seemed suboptimal.
> >
> > >> v2:
> > >>  * Use linux,usable-memory on /memory instead of a new binding
> > >
> > > This part seems to have been removed in v3 and later?
> > > Note that "linux,usable-memory-range" should be a property of the
> > > /chosen node, too, cfr.
> > > https://github.com/devicetree-org/dt-schema/blob/master/schemas/chose=
n.yaml#L85
> > >
> >
> > No special handling is needed when using linux,usable-memory on /memory=
,
> > limiting the available memory is handled by generic code at
> > drivers/of/fdt.c
>
> It was my understanding both properties under /chosen are the
> recommended methods for new platforms... Let's see what Rob has
> to say...
>
> Anyway, I sent a patch series to switch to generic "linux,elfcorehdr"
> handling
> https://lore.kernel.org/r/cover.1623780059.git.geert+renesas@glider.be/
>
> Thanks!
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
