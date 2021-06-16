Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D9C3AA157
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbhFPQdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:39558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232234AbhFPQdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:33:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CECD361351;
        Wed, 16 Jun 2021 16:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623861070;
        bh=exkQJNSPkDaseMRDwokpCtaWrpnVtJkBzMN5rRvGQlo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CcrM6uikMWLtSBxw8H9H/2RY3qDvi+EYYeCjgHO3IJREBFMZI0Pd3wZ6OaIJGk+4N
         lDguHLiRALRo7Z+MZgOBGkqFhvoeQcekyMghWGkQiFqZVBe/0FDS52/h86X4d/CCxe
         CC8V6p1zS78I55C0TsuwMalmdvgQ9wrRekivnY6l5IlW6Sj74m5MmO87kgPug79KfJ
         6JYfmHysfpYqP40QQ0G5/wNlAmnOj0mVxMgo35afLZ4b4etyX0sAy05mvHSib5b4z2
         yeOWg2lCgxOh59vYBQq/TfJ5tSNzXOoe9fe94711BOMJha3rn6eUQkIF7JhIBU+hVP
         od/YObWbZ+Itg==
Received: by mail-ot1-f41.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so3067349oth.9;
        Wed, 16 Jun 2021 09:31:10 -0700 (PDT)
X-Gm-Message-State: AOAM5305JSNPw4xbGPfQmRSNnEOZ2Xyd3I5tHIPDkueWTPx6Sua8swiz
        VOAxjl3fNtVjJCSnEwrFcG5tfRi/N7htU2k4Tww=
X-Google-Smtp-Source: ABdhPJx9WT46czKGqGKZTMvu1g4TggAjHcYFrL9Wpp+S02PENnTUGH/uK+7MSGI2Zj6GCjUZrEQ4dXYVZrT4krxuSyw=
X-Received: by 2002:a9d:4c83:: with SMTP id m3mr638863otf.77.1623861070211;
 Wed, 16 Jun 2021 09:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210419005539.22729-1-mick@ics.forth.gr> <20210419005539.22729-6-mick@ics.forth.gr>
 <CAMuHMdW=23SPXwqcjD+30M_d0azdze2=ChZM-PF1brf9bCNtrA@mail.gmail.com>
 <fe02eb618eee141e8bc021e8e30906fc@mailhost.ics.forth.gr> <CAMuHMdXtT1L3yfzkTkbhqz3zgUQj89Bcm7mqz+m126NprAsK8Q@mail.gmail.com>
 <CAL_JsqLHOmZ6az0bYGC3dg__YX3aq=+Un4_x4+R2nNksc0hM2g@mail.gmail.com>
 <a488d802940f7fc2ae34a4fe583ec187@mailhost.ics.forth.gr> <CAL_Jsq+9eBSHUwzWBipgoSHNDvxqfrTuY4Un0PrRhoaAHugJNw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+9eBSHUwzWBipgoSHNDvxqfrTuY4Un0PrRhoaAHugJNw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 16 Jun 2021 18:30:58 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFfG5Sr+ix9xG3OBM8kgg8ARKNt0HFkL6MafB6vp2_xxQ@mail.gmail.com>
Message-ID: <CAMj1kXFfG5Sr+ix9xG3OBM8kgg8ARKNt0HFkL6MafB6vp2_xxQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] RISC-V: Add crash kernel support
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nick Kossifidis <mick@ics.forth.gr>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
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

On Wed, 16 Jun 2021 at 16:55, Rob Herring <robh+dt@kernel.org> wrote:
>
> +Ard
>
> On Tue, Jun 15, 2021 at 5:29 PM Nick Kossifidis <mick@ics.forth.gr> wrote=
:
> >
> > =CE=A3=CF=84=CE=B9=CF=82 2021-06-15 22:21, Rob Herring =CE=AD=CE=B3=CF=
=81=CE=B1=CF=88=CE=B5:
> > > On Tue, Jun 15, 2021 at 12:48 PM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > >>
> > >> Hi Nick,
> > >>
> > >> On Tue, Jun 15, 2021 at 8:29 PM Nick Kossifidis <mick@ics.forth.gr>
> > >> wrote:
> > >> > =CE=A3=CF=84=CE=B9=CF=82 2021-06-15 16:19, Geert Uytterhoeven =CE=
=AD=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
> > >> > > This does not match
> > >> > > https://github.com/devicetree-org/dt-schema/blob/master/schemas/=
chosen.yaml#L77:
> > >> > >
> > >> > >     $ref: types.yaml#/definitions/uint64-array
> > >> > >     maxItems: 2
> > >> > >     description:
> > >> > >       This property (currently used only on arm64) holds the mem=
ory
> > >> > > range,
> > >> > >       the address and the size, of the elf core header which mai=
nly
> > >> > > describes
> > >> > >       the panicked kernel\'s memory layout as PT_LOAD segments o=
f elf
> > >> > > format.
> > >> > >
> > >> > > Hence "linux,elfcorehdr" should be a property of the /chosen nod=
e,
> > >> > > instead of a memory node with a compatible value of "linux,elfco=
rehdr".
> > >> > >
> > >> >
> > >> > That's a binding for a property on the /chosen node, that as the t=
ext
> > >> > says it's defined for arm64 only and the code that handled it was =
also
> > >>
> > >> That doesn't mean it must not be used on other architectures ;-)
> > >> Arm64 was just the first one to use it...
> > >
> > > It is used on arm64 because memory is often passed by UEFI tables and
> > > not with /memory node. As riscv is also supporting EFI, I'd think the=
y
> > > would do the same.
> > >
> >
> > We've had this discussion before, riscv uses /memory for now and even i=
f
> > we switched to getting memory from ACPI/UEFI tables, the elf core heade=
r
> > is passed from the crashed kernel to the kdump kernel, it has nothing t=
o
> > do with UEFI since the bootloader is the kernel itself. Am I missing
> > something ?
>
> I believe if we originally booted using UEFI tables, then those are
> passed the kdump kernel as well. The original DT may have had a
> /memory node, but it's possible it didn't match what was in the UEFI
> tables. So using the DT /memory nodes for kdump could give surprising
> results. I think reserved regions also come from UEFI. Ard can
> probably comment better.
>

Anything that executes in the context of the UEFI boot firmware
(loaders, drivers, etc) may use the UEFI memory allocation routines to
allocate memory, and these allocations are communicated via the UEFI
memory map, not via the /memory node.

So it depends whether it matters if the kexec kernel tramples over
those regions. For kdump scenarios, it might be reasonable, but in the
general case, we should really respect what UEFI tells us about the
memory map when booting via UEFI.
