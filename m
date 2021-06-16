Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BCD3A9E46
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 16:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhFPO52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 10:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234087AbhFPO5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 10:57:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1E176105A;
        Wed, 16 Jun 2021 14:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623855316;
        bh=AxlyDycZpX8N+vmFuWI19Sd23V+DuNrgeU3nJ9fSOlQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QbxJDVCXZCiJeF3/Q66YYkQXX8XrqQWunoHlN3fz7MvO3OBOJzfBaIE1+y9uV3EAJ
         7ZOnQOUax/KFmkvtfDUou8wXJ0FfPxJ4kcKXYjibBCJdFoN5AgHrlcU9CuAk4qCvlw
         zLTuWne2oMrfffRAnHML8LSecawZJ9nk0RmoqKCSYZh8Z9k8REa/NtJtsTmhlIcV+3
         ZIDmMzY3L8+UFaPWf88q3/7ddG2zmUdCL/6pwINt3fHenvC3PuKC/nnYWq23IPE5Nm
         lrqlsLz6YFDCi9nBadTiG2yRnNxG98sePhSk02i2zImkAJwuFwFs6frHPbEhyjfmgV
         h1jU+qvK6TdTg==
Received: by mail-ej1-f41.google.com with SMTP id ce15so4411016ejb.4;
        Wed, 16 Jun 2021 07:55:16 -0700 (PDT)
X-Gm-Message-State: AOAM531x7aUGMl6u3nY7EwpG0GTrXvjqxoPRQDu48/ZpAHSqHq3k+fLK
        VCKUy2nhapZxTNAWvfcxbyydHuygUoP+2zjyuw==
X-Google-Smtp-Source: ABdhPJwrM8JUB7d5DGbvDUmM8cwcGPrXjP07+dvcNQN2Yqm0+3CnQUECrHvdmK6ajaK5xuXmYOM66M46eB/vWGyFWYM=
X-Received: by 2002:a17:906:9419:: with SMTP id q25mr163961ejx.341.1623855315390;
 Wed, 16 Jun 2021 07:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210419005539.22729-1-mick@ics.forth.gr> <20210419005539.22729-6-mick@ics.forth.gr>
 <CAMuHMdW=23SPXwqcjD+30M_d0azdze2=ChZM-PF1brf9bCNtrA@mail.gmail.com>
 <fe02eb618eee141e8bc021e8e30906fc@mailhost.ics.forth.gr> <CAMuHMdXtT1L3yfzkTkbhqz3zgUQj89Bcm7mqz+m126NprAsK8Q@mail.gmail.com>
 <CAL_JsqLHOmZ6az0bYGC3dg__YX3aq=+Un4_x4+R2nNksc0hM2g@mail.gmail.com> <a488d802940f7fc2ae34a4fe583ec187@mailhost.ics.forth.gr>
In-Reply-To: <a488d802940f7fc2ae34a4fe583ec187@mailhost.ics.forth.gr>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 16 Jun 2021 08:55:02 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+9eBSHUwzWBipgoSHNDvxqfrTuY4Un0PrRhoaAHugJNw@mail.gmail.com>
Message-ID: <CAL_Jsq+9eBSHUwzWBipgoSHNDvxqfrTuY4Un0PrRhoaAHugJNw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] RISC-V: Add crash kernel support
To:     Nick Kossifidis <mick@ics.forth.gr>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
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

+Ard

On Tue, Jun 15, 2021 at 5:29 PM Nick Kossifidis <mick@ics.forth.gr> wrote:
>
> =CE=A3=CF=84=CE=B9=CF=82 2021-06-15 22:21, Rob Herring =CE=AD=CE=B3=CF=81=
=CE=B1=CF=88=CE=B5:
> > On Tue, Jun 15, 2021 at 12:48 PM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> >>
> >> Hi Nick,
> >>
> >> On Tue, Jun 15, 2021 at 8:29 PM Nick Kossifidis <mick@ics.forth.gr>
> >> wrote:
> >> > =CE=A3=CF=84=CE=B9=CF=82 2021-06-15 16:19, Geert Uytterhoeven =CE=AD=
=CE=B3=CF=81=CE=B1=CF=88=CE=B5:
> >> > > This does not match
> >> > > https://github.com/devicetree-org/dt-schema/blob/master/schemas/ch=
osen.yaml#L77:
> >> > >
> >> > >     $ref: types.yaml#/definitions/uint64-array
> >> > >     maxItems: 2
> >> > >     description:
> >> > >       This property (currently used only on arm64) holds the memor=
y
> >> > > range,
> >> > >       the address and the size, of the elf core header which mainl=
y
> >> > > describes
> >> > >       the panicked kernel\'s memory layout as PT_LOAD segments of =
elf
> >> > > format.
> >> > >
> >> > > Hence "linux,elfcorehdr" should be a property of the /chosen node,
> >> > > instead of a memory node with a compatible value of "linux,elfcore=
hdr".
> >> > >
> >> >
> >> > That's a binding for a property on the /chosen node, that as the tex=
t
> >> > says it's defined for arm64 only and the code that handled it was al=
so
> >>
> >> That doesn't mean it must not be used on other architectures ;-)
> >> Arm64 was just the first one to use it...
> >
> > It is used on arm64 because memory is often passed by UEFI tables and
> > not with /memory node. As riscv is also supporting EFI, I'd think they
> > would do the same.
> >
>
> We've had this discussion before, riscv uses /memory for now and even if
> we switched to getting memory from ACPI/UEFI tables, the elf core header
> is passed from the crashed kernel to the kdump kernel, it has nothing to
> do with UEFI since the bootloader is the kernel itself. Am I missing
> something ?

I believe if we originally booted using UEFI tables, then those are
passed the kdump kernel as well. The original DT may have had a
/memory node, but it's possible it didn't match what was in the UEFI
tables. So using the DT /memory nodes for kdump could give surprising
results. I think reserved regions also come from UEFI. Ard can
probably comment better.

Rob
