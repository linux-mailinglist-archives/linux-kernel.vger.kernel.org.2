Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3251036EFC6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 20:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbhD2Sx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 14:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbhD2Sx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 14:53:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5BFC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:52:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id gx5so9348977ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 11:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yV9cxzQq9N1fpD7pjE0zlpfDuyGNd6+h0F0/Tf6pS0=;
        b=JGvNA3TyjYst2lJpl0zaPfCjHPxpFn536A/AZeK5+7sp2UVaeew+SYRR47ukb+gsxl
         Dy8gcOx0rkZIZT1FBtqqh/3EKfyCUa2XohZRnLpsOnHyzkbaLSUzgbsziXMVQENoLA71
         aOBOXKsDFCwOKXjgqoFsLY55LC5VYeFX6NWsf6Try3z9apUZweaDr4/JjDs+ZYGySQo8
         GRkRnP1iwOUCJHprMJa8izCdEjsVvygGF2BcAJbG6idUtCtzKyGUbAeiPeKHZi1MDE8z
         qFAt4DyloIvZakZUTSlMQbY+AYX85yAcAerdEF7maq66/fVDPQhGNs7nawAma4Ppmkba
         0DRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yV9cxzQq9N1fpD7pjE0zlpfDuyGNd6+h0F0/Tf6pS0=;
        b=Phbk3MI+x0YABwkRcG67MsRsq9pl3/txLG6mJRxNcLJyuL/Ue9SQI8XMkKwCOtR/FR
         6k8hPc6faHTv4JAAcLwXZS2OOD6PLH+olbNg6xNfFoq+hSokCmLWghwPzX2eNLT+dkHe
         xRn+ZWUAipYYoYicG+z6Fl2+LtmT50GT/T5d5SWFRoZPpzuz4+UZ7SpI2GRBstFn0mj+
         4s1roVsdRpjyahPQk1X9MBu28n9vMZAsC0rMNiLsYo7eh1iu3N+XeJOsjZ4EHeeE6shX
         V8fRufDzB9s5YA8UrzOlNrjjlKDIIS8tGuR/rEosY8wu5I/D6WZGLxFsb/Hxevx0xczZ
         FViA==
X-Gm-Message-State: AOAM533bxlU4rG3gtd0m4af8FFys3wAoFjSx7xJsye/MeM0Rk0Qt8XRM
        ny/00PFI9r/3ZovJXeHVUg5Li7LWk/0+L/L4fgqD
X-Google-Smtp-Source: ABdhPJw10znQ1o7oPRMqW3o5DtP4m7icKNtuuiEvnUEf85sqQX1fbAZZT3CsyymyW9VosExLQEmpzRoDwXPFnU8mWKc=
X-Received: by 2002:a17:906:685:: with SMTP id u5mr1395276ejb.449.1619722357543;
 Thu, 29 Apr 2021 11:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210423205159.830854-1-morbo@google.com> <20210428172847.GC4022@arm.com>
 <20210428174010.GA4593@sirena.org.uk> <CAGG=3QUATefn9AG+HvnCfEOBv3iRu4fzFwfmA7Djrh2CmP_weA@mail.gmail.com>
 <CAGG=3QUNykCfkS22g+HRWb0Goa8DJ72TUueLtMe5v1YfnStojw@mail.gmail.com>
 <20210429075454.GQ9028@arm.com> <CAGG=3QV0kR__23yEmwwXBpcE1gvjLqRNmF667hhVeY0B3urTqQ@mail.gmail.com>
 <20210429095027.GR9028@arm.com>
In-Reply-To: <20210429095027.GR9028@arm.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 29 Apr 2021 11:52:26 -0700
Message-ID: <CAGG=3QW9t2zUPYLt_La=qQTZeHzfLBCXgZRbiia8T6K7n=YrdQ@mail.gmail.com>
Subject: Re: [PATCH] arm64/vdso: Discard .note.gnu.property sections in vDSO
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Kiss <Daniel.Kiss@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 2:50 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
> The 04/29/2021 02:23, Bill Wendling wrote:
> > On Thu, Apr 29, 2021 at 12:55 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
> > > The 04/28/2021 12:31, Bill Wendling wrote:
> > > > On Wed, Apr 28, 2021 at 12:21 PM Bill Wendling <morbo@google.com> wrote:
> > > > > On Wed, Apr 28, 2021 at 10:40 AM Mark Brown <broonie@kernel.org> wrote:
> > > > > > On Wed, Apr 28, 2021 at 06:28:47PM +0100, Catalin Marinas wrote:
> > > > > > > On Fri, Apr 23, 2021 at 01:51:59PM -0700, Bill Wendling wrote:
> > > > > >
> > > > > > > > Since the note.gnu.property section in the vDSO is not checked by the
> > > > > > > > dynamic linker, discard the .note.gnu.property sections in the vDSO.
> > > > > >
> > > > > > > Can we not instead fix the linker script to preserve the
> > > > > > > .note.gnu.property, correctly aligned? It doesn't take much space and
> > > > > > > while we don't use it now, it has the BTI information about the binary.
> > > > > >
> > > > > > > Cc'ing a few others who were involved in the BTI support.
> > > > > >
> > > > > > Not just BTI, we also flag PAC usage in there too and could add other
> > > > > > extensions going forwards.  While the note isn't actively used by
> > > > > > anything right now due to the kernel mapping the vDSO prior to userspace
> > > > > > starting it is part of the ABI and something could end up wanting to use
> > > > > > it and getting confused if it's not there.  It would be much better to
> > > > > > fix the alignment issue.
> > > > >
> > > > > If there's only one of the 8-byte aligned sections guaranteed, we
> > > > > could place it first in the note. Otherwise, we will have to change
> > > > > the alignment of the note (or somehow merge multiple notes).
> > > > >
> > > > I should have clarified that there's only one *entry* in the
> > > > .note.gnu.properties section, and if not then is it possible to merge
> > > > multiple entries into one. (Excuse my ignorance if this is already the
> > > > case.)
> > >
> > > .note.gnu.property should go to PT_GNU_PROPERTY and it
> > > should be merged following rules specified in
> > > https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI
> > > and
> > > https://github.com/ARM-software/abi-aa/blob/master/aaelf64/aaelf64.rst#program-property
> > >
> > > it may also be covered by a (8byte aligned) PT_NOTE, but
> > > that's not a requirement on aarch64 (x86 requires it for
> > > compatibility with old dynamic linker, but since the vdso
> > > is handled specially that may not be relevant either).
> > >
> > > i don't know how this works in linker scripts.
> >
> > This is a potential patch. I haven't had time to test it though.
> > However, it does appear to format the section in the "expected" way,
> > so one's able to grab the build IDs. Thoughts?
>
>
> please show the program headers.
>

$ readelf -lW arch/arm64/kernel/vdso/vdso.so

Elf file type is DYN (Shared object file)
Entry point 0x300
There are 4 program headers, starting at offset 64

Program Headers:
  Type           Offset   VirtAddr           PhysAddr
FileSiz  MemSiz   Flg Align
  LOAD           0x000000 0x0000000000000000 0x0000000000000000
0x000968 0x000968 R E 0x8
  DYNAMIC        0x0008a8 0x00000000000008a8 0x00000000000008a8
0x0000c0 0x0000c0 R   0x8
  NOTE           0x000288 0x0000000000000288 0x0000000000000288
0x000074 0x000074 R   0x8
  GNU_EH_FRAME   0x0008a4 0x00000000000008a4 0x00000000000008a4
0x000000 0x000000 R E 0x1

 Section to Segment mapping:
  Segment Sections...
   00     .hash .dynsym .dynstr .gnu.version .gnu.version_d .note
.text .eh_frame_hdr .eh_frame .dynamic
   01     .dynamic
   02     .note
   03     .eh_frame_hdr .eh_frame

> >
> > $ objdump -s -j .note ./arch/arm64/kernel/vdso/vdso.so
> >
> > ./arch/arm64/kernel/vdso/vdso.so:     file format elf64-little
> >
> > Contents of section .note:
> >  0288 04000000 10000000 05000000 474e5500  ............GNU.
> >  0298 000000c0 04000000 03000000 00000000  ................
> >  02a8 06000000 04000000 00000000 4c696e75  ............Linu
> >  02b8 78000000 000a0500 06000000 01000000  x...............
> >  02c8 00010000 4c696e75 78000000 00000000  ....Linux.......
> >  02d8 04000000 14000000 03000000 474e5500  ............GNU.
> >  02e8 958db149 af5156cb 45309896 7a53ae8a  ...I.QV.E0..zS..
> >  02f8 ef34e95c                             .4.\
> >
> > diff --git a/arch/arm64/kernel/vdso/vdso.lds.S
> > b/arch/arm64/kernel/vdso/vdso.lds.S
> > index d808ad31e01f..d51e886c6223 100644
> > --- a/arch/arm64/kernel/vdso/vdso.lds.S
> > +++ b/arch/arm64/kernel/vdso/vdso.lds.S
> > @@ -31,7 +31,13 @@ SECTIONS
> >         .gnu.version_d  : { *(.gnu.version_d) }
> >         .gnu.version_r  : { *(.gnu.version_r) }
> >
> > -       .note           : { *(.note.*) }                :text   :note
> > +       /*
> > +        * Add the .note.gnu.property section first, as it's aligned to
> > +        * 8-bytes, while other notes are aligned to 4-bytes.
> > +        */
> > +       . = ALIGN(8);
> > +
> > +       .note           : { *(.note.gnu.property) *(.note.*) }  :text   :note
> >
> >         . = ALIGN(16);
>
> --
