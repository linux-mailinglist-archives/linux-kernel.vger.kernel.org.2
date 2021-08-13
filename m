Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F893EBC00
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhHMSZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbhHMSY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:24:56 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D282C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:24:29 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id d11so19852700eja.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 11:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IgSWlgrvg7Y/toinu9+8DguAJs62b7mo/FK1YGP/k+M=;
        b=T4ogPSfDQZQc8DhKTa5ShkRKxMrzxPDTXrPMXDKVOb/W38RaGl6Pc/jYGv2Q2o/8Ma
         m5kuynAxW6I6EZPZIeKLrmm55nG3xjlEcopXls/+arcnfdX3Kwl2NmK6xqW+k4/krDxd
         HRmub3mn1XtET4oUccw9b/UczjX0B97bgwNKECdsNsgdZX33YWN9FjYwScSzszI/068y
         iSdMU2OWhnMr+c2ma4HMlL7FfFKMFdFKoaLKYPK3gMGLYxoHygH6x15c7j/quwchboAu
         35nEVxDt7NJiKNv+CxzQsV93UKsI80BCDaKoR+GpN7WMcztXLGl0dVeRg53nmeag0SCN
         i9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IgSWlgrvg7Y/toinu9+8DguAJs62b7mo/FK1YGP/k+M=;
        b=pt1xgAJWO97asNEt2XjLY6deSEk7DVoRtQTHZDARIa5xQUr/btM3TG6r/Q9BzdSLyq
         U9JV+te2Y4M8N+bPRGd0qA7MOPKrSchwWoVsU7ZEs6OvKtQV2Bhx/3fGOxDKMucafaJp
         3tMe7qN6WvOJfmBUcm2W/uDttDlVhFoC00vGyOEetD/kE0V7e0LuyXLb5TYCrfT3IR0s
         2+DSAdvPOC1TJcSaBnYXp8m3RQXAG/sRRuPUvs2x4k5s7qclVHeGBn+rRfZU7oVjitow
         sYs5aGhjCzBz+D9Kb39+Wpw2+6rVkWN7ATwD+pNaZ1dunHn8yJt3mtOadFefhFNB9vRo
         v8dQ==
X-Gm-Message-State: AOAM532fP/NQNFMu6AxaOVHMEfhFuvnqIuZTbhWCzis4uQMiCRn+a03A
        eaCPMwbzTyHZzmzkeaIP7k+OYIcY/xVxjEErwFEY
X-Google-Smtp-Source: ABdhPJxREcD5Nm/lmdmwnWqz3zpbvhxy7XMTBhK5i3Rz2TzEsbXdqCneDNrtDsSkvz1uUmEMQ5rU+CC3GwioP1gCqEQ=
X-Received: by 2002:a17:906:f854:: with SMTP id ks20mr3839626ejb.421.1628879067322;
 Fri, 13 Aug 2021 11:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210812204951.1551782-1-morbo@google.com> <87sfzde8lk.fsf@linkitivity.dja.id.au>
In-Reply-To: <87sfzde8lk.fsf@linkitivity.dja.id.au>
From:   Bill Wendling <morbo@google.com>
Date:   Fri, 13 Aug 2021 11:24:16 -0700
Message-ID: <CAGG=3QUz2LNgC8Hn6rU68ejjv4=J9Uidef0oH9A7=sKTs+vf7g@mail.gmail.com>
Subject: Re: [PATCH] ppc: add "-z notext" flag to disable diagnostic
To:     Daniel Axtens <dja@axtens.net>, Fangrui Song <maskray@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 7:13 AM Daniel Axtens <dja@axtens.net> wrote:
>
> Bill Wendling <morbo@google.com> writes:
>
> > The "-z notext" flag disables reporting an error if DT_TEXTREL is set on
> > PPC with CONFIG=kdump:
> >
> >   ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 against
> >     local symbol in readonly segment; recompile object files with -fPIC
> >     or pass '-Wl,-z,notext' to allow text relocations in the output
> >   >>> defined in built-in.a(arch/powerpc/kernel/misc.o)
> >   >>> referenced by arch/powerpc/kernel/misc.o:(.text+0x20) in archive
> >       built-in.a
> >
> > The BFD linker disables this by default (though it's configurable in
> > current versions). LLD enables this by default. So we add the flag to
> > keep LLD from emitting the error.
>
> You didn't provide a huge amount of context but I was able to reproduce
> a similar set of errors with pseries_le_defconfig and
>
My apologies for the lack of context. We discovered this issue when
moving to use LLD instead of BFD for our linker. This change suggested
by Fangrui Song. Here's his comments from
https://github.com/ClangBuiltLinux/linux/issues/811. (Nick Desaulniers
added a "Link" tag with his review.)

```
The text relocations are real. lld can link .tmp_vmlinux1 smoothly if
you pass -z notext. Though, it will still be insightful to investigate
where these text relocations come from. I believe there are only 2
categories.

(a) For a CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y build (x86 and arm64
select the option by default), ___ksymtab+* sections (non-SHF_WRITE)
contains entries relocated by PC relative relocations. These entries
do not need dynamic relocations.

out/powerpc64le/.config generated by ppc64le_defconfig does not enable
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y.

% readelf -r out/x86_64/entry/entry_64.o
...
Relocation section '.rela___ksymtab+native_load_gs_index' at offset
0x6460 contains 2 entries:
    Offset             Info             Type               Symbol's
Value  Symbol's Name + Addend
0000000000000000  0000007a00000002 R_X86_64_PC32
0000000000000ea0 native_load_gs_index + 0
0000000000000004  0000001d00000002 R_X86_64_PC32
0000000000000000 __ksymtab_strings + 0

include/asm-generic/export.h

ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 against
local symbol in readonly segment; recompile object files with -fPIC or
pass '-Wl
,-z,notext' to allow text relocations in the output
>>> defined in init/built-in.a(do_mounts.o)
>>> referenced by do_mounts.c
>>>               do_mounts.o:(__ksymtab_name_to_dev_t) in archive init/built-in.a

(b) R_PPC64_ADDR64 in __mcount_loc sections.

ld.lld: error: can't create dynamic relocation R_PPC64_ADDR64 against
local symbol in readonly segment; recompile object files with -fPIC or
pass '-Wl
,-z,notext' to allow text relocations in the output
>>> defined in init/built-in.a(do_mounts_rd.o)
>>> referenced by do_mounts_rd.c
>>>               do_mounts_rd.o:(__mcount_loc+0x0) in archive init/built-in.a

This section is generated by ./scripts/recordmcount
"init/do_mounts_rd.o". The tool hard codes R_PPC64_ADDR64.

% grep PPC64 scripts/recordmcount.c
        case EM_PPC64:  reltype = R_PPC64_ADDR64; break;
```

> make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- CC="ccache clang-11" LD=ld.lld-11 AR=llvm-ar-11 -j4 vmlinux
>
> I also checked the manpage, and indeed the system ld does not issue this
> warning/error by default.
>
It should be noted that the BFD linker can emit this warning/error if
binutils is configured with
"--enable-textrel-check={warning,error,yes}".

> > ---
> >  arch/powerpc/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> > index 6505d66f1193..17a9fbf9b789 100644
> > --- a/arch/powerpc/Makefile
> > +++ b/arch/powerpc/Makefile
> > @@ -122,6 +122,7 @@ endif
> >
> >  LDFLAGS_vmlinux-y := -Bstatic
> >  LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) := -pie
> > +LDFLAGS_vmlinux-$(CONFIG_RELOCATABLE) += -z notext
>
> Is there any reason this should be gated on CONFIG_RELOCATABLE? (I tried
> without it and got different but possibly related linker errors...)
>
My understanding is that '-z notext' allows (i.e. doesn't emit
warnings/errors for) relocations against read-only segments. So it's
not really relevant to non-relocatable builds.

Unrelated question: Should the "-pie" flag be added with "+= -pie"
(note the plus sign)?

> Also, is this behaviour new?
>
I don't believe so. It's only when we wanted to use LLD that it was noticed.

BTW, this patch should more properly be attributed to Fangrui Song. I
can send a follow-up patch that reflects this and adds more context to
the commit message.

-bw

> Kind regards,
> Daniel
>
> >  LDFLAGS_vmlinux      := $(LDFLAGS_vmlinux-y)
> >
> >  ifdef CONFIG_PPC64
> > --
> > 2.33.0.rc1.237.g0d66db33f3-goog
