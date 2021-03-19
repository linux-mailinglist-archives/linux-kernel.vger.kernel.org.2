Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4632341EEF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhCSOB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229987AbhCSOB4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:01:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40FA364F11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 14:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616162516;
        bh=IAu41rditkWe+gtVLf0N/N+i35q7jf90D21+hxzAJoI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jb1WTTWS5WuiMrkcRhcyMDLIiNdOJlmapFBkacTne5ebDtnei+1I2MICvoSWl20Hd
         lZBcGaW7bL8QxiI3+hnCSEbQW0xUW6bEXpx8i/uO5PZyg3A6LxPQfj5tLgpOG2vOQ+
         o/QfoR47H5G4PHyx1CV6I8FwrsZCLFmlIEWSPJCxCDF1es61VG6hTBJ/OprX48cVEO
         5V8C92yTqRsjaeAHcwK/w9aBy7riC6RBoKdHs7Qmjdk+b1cp156Vt7vzVKG1dJyjGi
         c4h6pB6DUWYP0Tv0ywRVGUkpMhPNkASR6mL1GHgBacpGG1i9CoEyA+Z3qhGLBj0+Wz
         uru1EWoO1ndwQ==
Received: by mail-oi1-f180.google.com with SMTP id n8so4851091oie.10
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:01:56 -0700 (PDT)
X-Gm-Message-State: AOAM533kPGjn9jj9dy6W/liLqJMOdgoYqaR+4caFGPpxu1OdUuPgBMUO
        r2E4aCcxzV0GeBLNwuRAGVYxACbOhbVAKbqzm2g=
X-Google-Smtp-Source: ABdhPJxcY6q+eKHu3p+l16IH+6C7Ncmvh0TU0Mq6Q7Wia6KowpIupA8KZun/9UYUVuOQqKYH00/l7DnFdgI54anVrdI=
X-Received: by 2002:a05:6808:313:: with SMTP id i19mr1080533oie.67.1616162515535;
 Fri, 19 Mar 2021 07:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210225112122.2198845-1-arnd@kernel.org> <20210317143757.GD12269@arm.com>
 <20210317161838.GF12269@arm.com> <CAK8P3a0FeuGLYhiPx=GLdewu2P=Hix7cpVsbF05i5WO5T2XPvQ@mail.gmail.com>
 <20210319122506.GA6832@arm.com>
In-Reply-To: <20210319122506.GA6832@arm.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 19 Mar 2021 15:01:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1ocFzdvn=1-vX-xbPApuaKys3tQFDBH+k7bznXZ=RNgQ@mail.gmail.com>
Message-ID: <CAK8P3a1ocFzdvn=1-vX-xbPApuaKys3tQFDBH+k7bznXZ=RNgQ@mail.gmail.com>
Subject: Re: [PATCH] [RFC] arm64: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 1:25 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Thu, Mar 18, 2021 at 09:41:54AM +0100, Arnd Bergmann wrote:
> > On Wed, Mar 17, 2021 at 5:18 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Wed, Mar 17, 2021 at 02:37:57PM +0000, Catalin Marinas wrote:
> > > > On Thu, Feb 25, 2021 at 12:20:56PM +0100, Arnd Bergmann wrote:
> > > > > diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> > > > > index bad2b9eaab22..926cdb597a45 100644
> > > > > --- a/arch/arm64/kernel/vmlinux.lds.S
> > > > > +++ b/arch/arm64/kernel/vmlinux.lds.S
> > > > > @@ -217,7 +217,7 @@ SECTIONS
> > > > >             INIT_CALLS
> > > > >             CON_INITCALL
> > > > >             INIT_RAM_FS
> > > > > -           *(.init.altinstructions .init.bss .init.bss.*)  /* from the EFI stub */
> > > > > +           *(.init.altinstructions .init.data.* .init.bss .init.bss.*)     /* from the EFI stub */
> > > >
> > > > INIT_DATA already covers .init.data and .init.data.*, so I don't think
> > > > we need this change.
> > >
> > > Ah, INIT_DATA only covers init.data.* (so no dot in front). The above
> > > is needed for the EFI stub.
> >
> > I wonder if that is just a typo in INIT_DATA. Nico introduced it as part of
> > 266ff2a8f51f ("kbuild: Fix asm-generic/vmlinux.lds.h for
> > LD_DEAD_CODE_DATA_ELIMINATION"), so perhaps that should have
> > been .init.data.* instead.
>
> I think it was the other Nicholas ;) (with an 'h'). The vmlinux.lds.h
> change indeed looks like a typo (it's been around since 4.18).

Right, my mistake.

> > It looks like pointer authentication gone wrong, which ended up
> > with dereferencing the broken pointer in x22, and it explains why
> > it only happens with -cpu max. Presumably this also only happens
> > on secondary CPUs, so maybe the bit that initializes PAC on
> > secondary CPUs got discarded?
>
> I seems that the whole alternative instructions section is gone, so any
> run-time code patching that the kernel does won't work. The kernel boots
> with the diff below but I'm not convinced we don't miss anything else.
> In some cases you get a linker warning about gc sections but not in this
> case. Maybe we need some more asserts to ensure that certain sections
> are not empty.
>
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 11909782ee3e..036cc59033d3 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -203,7 +203,7 @@ SECTIONS
>         . = ALIGN(4);
>         .altinstructions : {
>                 __alt_instructions = .;
> -               *(.altinstructions)
> +               KEEP(*(.altinstructions))
>                 __alt_instructions_end = .;
>         }
>
> Do we need a KEEP(.init.altinstructions) as well?

I would guess so. Whatever causes the .altinstructions to get dropped
presumably also leads to the same happening to .init.altinstructions.

Ideally each use of altinstructions would cause a reference to a
particular symbol so that one gets kept, while any .altinstructions
for unused functions get discarded.

        Arnd
