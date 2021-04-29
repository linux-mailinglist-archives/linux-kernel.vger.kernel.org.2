Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFC136E7E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhD2JYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhD2JYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:24:41 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494BC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:23:54 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id t4so15538116ejo.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 02:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F8cREKu+7p2lFf21gsP7RTu5Zef9Sd3kayTqrQK/7ds=;
        b=Al1qjFvxRLGghYHIOI+isxnecFyTgSjOxpf7NwVHobrXlgIhwBEaKxIVbyllnEwoAp
         BoANU9NuXlpUbC9myklwu4LxrscJKNPBNDJpm1GQ+DbpC6v/LxXbhqD0NzGnj5hmjXmC
         RKubRD9+NjNWaGvyc4eU19c8mXnLwYKZPIMV4Dsi+/xGlY6Tv0zdvnoD/yAKhResXwD6
         4vpgNIHik2Z3RJDQSmDwgcqSO7UBw5wIs469Veqmq6czAy0BaTs5lSUeVLFALzPszuty
         0oyhGoFggGb7uCDn4674L8SXZRYQIphc9ont8/wpBMmDsW5ixiy1RdDwLoMrsR5An4KE
         b2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F8cREKu+7p2lFf21gsP7RTu5Zef9Sd3kayTqrQK/7ds=;
        b=efLqY74o67y35KEeGxdmZZBROL77pbe3OPcIZbaRNjjjc7CgfoKzxnt9UMw/6S/p0h
         QdOc6BHjBRum++++yJPBwh0g/+RG1Eh1skfsDrY2P4FyT1e/v17uNxfKBuo5N9bNRr+z
         eRIzZwA3DBKHPHoMrMs3brPoAu0i9rzzMCBXKX8Ola9Dh+gyczSgauXD1ti4QJiLPgUX
         nPxuiCTG84l190WDyn2TADznTJLr8stN/j+ynGA3KgZ5MlK3hBZp/J3ejkdhX5HgbLEw
         ZdgCZaaufxhNFckqc0wtOt42XLvcIZNRs/GJNw9YtXMVVFQ+eXtHexYl5myvZ3UVG7mT
         8LLw==
X-Gm-Message-State: AOAM5316beGn5B3VAV1u252FNmG1fKWYOHDbL4vgs8p+hwRDGqZAIWr2
        gxIMECGsRUCl5146W+TeX5ZVSC7AhOxJYo3Ukbmn
X-Google-Smtp-Source: ABdhPJzmD5KIaSE76zux8n1Xthc6noF7GoYJOjt3oVwm/b5zsJgjfEFSjyl1HGJk8D9o50MGI6eo4N+rEp0rU6r5b60=
X-Received: by 2002:a17:906:b7d3:: with SMTP id fy19mr12024625ejb.269.1619688232584;
 Thu, 29 Apr 2021 02:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210423205159.830854-1-morbo@google.com> <20210428172847.GC4022@arm.com>
 <20210428174010.GA4593@sirena.org.uk> <CAGG=3QUATefn9AG+HvnCfEOBv3iRu4fzFwfmA7Djrh2CmP_weA@mail.gmail.com>
 <CAGG=3QUNykCfkS22g+HRWb0Goa8DJ72TUueLtMe5v1YfnStojw@mail.gmail.com> <20210429075454.GQ9028@arm.com>
In-Reply-To: <20210429075454.GQ9028@arm.com>
From:   Bill Wendling <morbo@google.com>
Date:   Thu, 29 Apr 2021 02:23:41 -0700
Message-ID: <CAGG=3QV0kR__23yEmwwXBpcE1gvjLqRNmF667hhVeY0B3urTqQ@mail.gmail.com>
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

On Thu, Apr 29, 2021 at 12:55 AM Szabolcs Nagy <szabolcs.nagy@arm.com> wrote:
> The 04/28/2021 12:31, Bill Wendling wrote:
> > On Wed, Apr 28, 2021 at 12:21 PM Bill Wendling <morbo@google.com> wrote:
> > > On Wed, Apr 28, 2021 at 10:40 AM Mark Brown <broonie@kernel.org> wrote:
> > > > On Wed, Apr 28, 2021 at 06:28:47PM +0100, Catalin Marinas wrote:
> > > > > On Fri, Apr 23, 2021 at 01:51:59PM -0700, Bill Wendling wrote:
> > > >
> > > > > > Since the note.gnu.property section in the vDSO is not checked by the
> > > > > > dynamic linker, discard the .note.gnu.property sections in the vDSO.
> > > >
> > > > > Can we not instead fix the linker script to preserve the
> > > > > .note.gnu.property, correctly aligned? It doesn't take much space and
> > > > > while we don't use it now, it has the BTI information about the binary.
> > > >
> > > > > Cc'ing a few others who were involved in the BTI support.
> > > >
> > > > Not just BTI, we also flag PAC usage in there too and could add other
> > > > extensions going forwards.  While the note isn't actively used by
> > > > anything right now due to the kernel mapping the vDSO prior to userspace
> > > > starting it is part of the ABI and something could end up wanting to use
> > > > it and getting confused if it's not there.  It would be much better to
> > > > fix the alignment issue.
> > >
> > > If there's only one of the 8-byte aligned sections guaranteed, we
> > > could place it first in the note. Otherwise, we will have to change
> > > the alignment of the note (or somehow merge multiple notes).
> > >
> > I should have clarified that there's only one *entry* in the
> > .note.gnu.properties section, and if not then is it possible to merge
> > multiple entries into one. (Excuse my ignorance if this is already the
> > case.)
>
> .note.gnu.property should go to PT_GNU_PROPERTY and it
> should be merged following rules specified in
> https://github.com/hjl-tools/linux-abi/wiki/Linux-Extensions-to-gABI
> and
> https://github.com/ARM-software/abi-aa/blob/master/aaelf64/aaelf64.rst#program-property
>
> it may also be covered by a (8byte aligned) PT_NOTE, but
> that's not a requirement on aarch64 (x86 requires it for
> compatibility with old dynamic linker, but since the vdso
> is handled specially that may not be relevant either).
>
> i don't know how this works in linker scripts.

This is a potential patch. I haven't had time to test it though.
However, it does appear to format the section in the "expected" way,
so one's able to grab the build IDs. Thoughts?

$ objdump -s -j .note ./arch/arm64/kernel/vdso/vdso.so

./arch/arm64/kernel/vdso/vdso.so:     file format elf64-little

Contents of section .note:
 0288 04000000 10000000 05000000 474e5500  ............GNU.
 0298 000000c0 04000000 03000000 00000000  ................
 02a8 06000000 04000000 00000000 4c696e75  ............Linu
 02b8 78000000 000a0500 06000000 01000000  x...............
 02c8 00010000 4c696e75 78000000 00000000  ....Linux.......
 02d8 04000000 14000000 03000000 474e5500  ............GNU.
 02e8 958db149 af5156cb 45309896 7a53ae8a  ...I.QV.E0..zS..
 02f8 ef34e95c                             .4.\

diff --git a/arch/arm64/kernel/vdso/vdso.lds.S
b/arch/arm64/kernel/vdso/vdso.lds.S
index d808ad31e01f..d51e886c6223 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -31,7 +31,13 @@ SECTIONS
        .gnu.version_d  : { *(.gnu.version_d) }
        .gnu.version_r  : { *(.gnu.version_r) }

-       .note           : { *(.note.*) }                :text   :note
+       /*
+        * Add the .note.gnu.property section first, as it's aligned to
+        * 8-bytes, while other notes are aligned to 4-bytes.
+        */
+       . = ALIGN(8);
+
+       .note           : { *(.note.gnu.property) *(.note.*) }  :text   :note

        . = ALIGN(16);
