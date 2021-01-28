Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A3C306A12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 02:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhA1BNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 20:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhA1BLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 20:11:15 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AE0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 17:10:35 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id d6so3731476ilo.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 17:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=v+u1DiVrW3O+pldsYbx0PikwzegMHzk/tjgfkZuCvGg=;
        b=pI/cGUyNW+neaOvEcVmBjKcIhXcIDz9dj5cGJuj36sCqj04fRmMzT0CtZW60lccJpW
         yob4Gjy/p3kpf24dpBShsMUWLCUx7PB+0AS7amQ9UEkBcwJ1VJQIGV/bs6UwcbCm7PVF
         M9DEVf9N1cqMpAgIWVtRVSUJ1L8LtGYORXMEeOhFRyZH2XgbK1zWCFEX3LV/3muLitUF
         HGYaRLTVgw4dmQUdt+b0XpstSNEgiqhj1T3H8KoGs0fbiHrAsxbDdKixWBkQRCtjqsPo
         1AfDjrKFo0ZMeNqHBnG+8s2ZCbU2Nzkz3TDJ8dXMnIEXEU4XulD1vx/E5csmT6WQhbFJ
         4MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=v+u1DiVrW3O+pldsYbx0PikwzegMHzk/tjgfkZuCvGg=;
        b=Tu3NJysyTwURm4ReQUOc8AXx8ZYIvXzVKRCnjDjxcZ9YAOeClTVcxd/l09stiUZNvl
         tbkNbU7zqSYjpkBwQBX7HTZYexF8j+zxhxnvbgqW/vRPIIJwFCjWid5Uo/D6FWLRMCtJ
         iJ8D+2TGZMyOvMCA4LdTTk0WuD4kKkB8H3b/HGnxNT07fVRPuxdY+wTTOoA9/xnyZGco
         xz9hr7hsOixm4mgpq57xHBlQSvfA0KU41tFOfqgIvda1udXJugkaPiZeAvqkZ+i31GI2
         m88kRqDdKtM87hxp/7i74azORzEMc+T55D+oxinWQQCCJUjZ0xKRaWyH8lY/H3YzugiF
         K/vA==
X-Gm-Message-State: AOAM532mo47GDvD4fVzLZUx/MmZxH4UP/wdOU5koAO9df79f+3sulvWo
        i+ciWu2YyfxcrFhgScZj5MFXV/Jt7b6WlLoV854=
X-Google-Smtp-Source: ABdhPJwULJpG1pBaErtPQ/134pFpRXy+j4+aXLwHgH4E1eWw91BGnRb76/QFIQt6wjdCTIYhunngt6PsdI1Vb4g4b5E=
X-Received: by 2002:a05:6e02:e94:: with SMTP id t20mr11016518ilj.10.1611796234823;
 Wed, 27 Jan 2021 17:10:34 -0800 (PST)
MIME-Version: 1.0
References: <20210125172956.j2prlchhqwfcgzuc@google.com> <20210127205600.1227437-1-maskray@google.com>
In-Reply-To: <20210127205600.1227437-1-maskray@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 28 Jan 2021 02:10:23 +0100
Message-ID: <CA+icZUVUfgyZm3Sz1scNYnXaz3C22W0BnQx1z79G=M-23eUmJQ@mail.gmail.com>
Subject: Re: [PATCH v4] x86: Treat R_386_PLT32 as R_386_PC32
To:     Fangrui Song <maskray@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 9:56 PM 'Fangrui Song' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> This is similar to commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as
> R_X86_64_PC32"), but for i386.  As far as Linux kernel is concerned,
> R_386_PLT32 can be treated the same as R_386_PC32.
>
> R_386_PLT32/R_X86_64_PLT32 are PC-relative relocation types which can
> only be used by branches. If the referenced symbol is defined
> externally, a PLT will be used.
> R_386_PC32/R_X86_64_PC32 are PC-relative relocation types which can be
> used by address taking operations and branches. If the referenced symbol
> is defined externally, a copy relocation/canonical PLT entry will be
> created in the executable.
>
> On x86-64, there is no PIC vs non-PIC PLT distinction and an
> R_X86_64_PLT32 relocation is produced for both `call/jmp foo` and
> `call/jmp foo@PLT` with newer (2018) GNU as/LLVM integrated assembler.
> This avoids canonical PLT entries (st_shndx=0, st_value!=0).
>
> On i386, there are 2 types of PLTs, PIC and non-PIC. Currently the
> GCC/GNU as convention is to use R_386_PC32 for non-PIC PLT and
> R_386_PLT32 for PIC PLT. Copy relocations/canonical PLT entries are
> possible ABI issues but GCC/GNU as will likely keep the status quo
> because (1) the ABI is legacy (2) the change will drop a GNU ld
> diagnostic for non-default visibility ifunc in shared objects.
> https://sourceware.org/bugzilla/show_bug.cgi?id=27169
>
> clang-12 -fno-pic (since
> https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
> can emit R_386_PLT32 for compiler generated function declarations,
> because preventing canonical PLT entries is weighed over the rare ifunc
> diagnostic.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1210
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>

Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # v3

- Sedat -

> ---
> Change in v2:
> * Improve commit message
> ---
> Change in v3:
> * Change the GCC link to the more relevant GNU as link.
> * Fix the relevant llvm-project commit.
> ---
> Change in v4:
> * Improve comments and commit message
> ---
>  arch/x86/kernel/module.c |  1 +
>  arch/x86/tools/relocs.c  | 12 ++++++++----
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> index 34b153cbd4ac..5e9a34b5bd74 100644
> --- a/arch/x86/kernel/module.c
> +++ b/arch/x86/kernel/module.c
> @@ -114,6 +114,7 @@ int apply_relocate(Elf32_Shdr *sechdrs,
>                         *location += sym->st_value;
>                         break;
>                 case R_386_PC32:
> +               case R_386_PLT32:
>                         /* Add the value, subtract its position */
>                         *location += sym->st_value - (uint32_t)location;
>                         break;
> diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
> index ce7188cbdae5..1c3a1962cade 100644
> --- a/arch/x86/tools/relocs.c
> +++ b/arch/x86/tools/relocs.c
> @@ -867,9 +867,11 @@ static int do_reloc32(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
>         case R_386_PC32:
>         case R_386_PC16:
>         case R_386_PC8:
> +       case R_386_PLT32:
>                 /*
> -                * NONE can be ignored and PC relative relocations don't
> -                * need to be adjusted.
> +                * NONE can be ignored and PC relative relocations don't need
> +                * to be adjusted. Because sym must be defined, R_386_PLT32 can
> +                * be treated the same way as R_386_PC32.
>                  */
>                 break;
>
> @@ -910,9 +912,11 @@ static int do_reloc_real(struct section *sec, Elf_Rel *rel, Elf_Sym *sym,
>         case R_386_PC32:
>         case R_386_PC16:
>         case R_386_PC8:
> +       case R_386_PLT32:
>                 /*
> -                * NONE can be ignored and PC relative relocations don't
> -                * need to be adjusted.
> +                * NONE can be ignored and PC relative relocations don't need
> +                * to be adjusted. Because sym must be defined, R_386_PLT32 can
> +                * be treated the same way as R_386_PC32.
>                  */
>                 break;
>
> --
> 2.30.0.280.ga3ce27912f-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210127205600.1227437-1-maskray%40google.com.
