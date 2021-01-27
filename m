Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EB33067D3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbhA0XYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbhA0W4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 17:56:51 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AFCC061793
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:38:10 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id i7so2676251pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 14:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EGTDub2HL3JRl4kOfLecB1flsjSx6VNDzS6CSE6flsM=;
        b=cgoLzwUDbAVjRddaXVq2FgcSo7K3TpWHd9qMmev8D+6tJKyHW2ChVRhL/qkS0p8MHY
         G3zqernmCo5q35GHqR0BukiOxoZKjho9T9mqeI3K8w5tAXlXe+RQujKYv53f4ZJijsp7
         2K6MhqJHLYc7MCAmnE+rqnVnEx3fp645iBZ2q240i94qju8f8g+ULdQo7/VKKWVt0GWV
         2S4uvRxR4XhMmCrKWokavMQ3A24thBabISME2UreeEqOXNq5V0Vf2Mj1sAIXLd1RQoTg
         j4OSpn+LLM3ip8Ah9VzcQw4t+E21G82B7+dGVu2Fbaaj4Mrj/me2o+49B8otXwrkrFWD
         K0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGTDub2HL3JRl4kOfLecB1flsjSx6VNDzS6CSE6flsM=;
        b=LRCEOooRYGOS77emn3rDrWbHfi6wQZAaqGe6S5Wzv7P+3wUewvp5uN/ZaLnYj6eWdZ
         IIBR8EblZ7su+sUg6CEaD7bhfytqUPqYaCw0cG8VZsMVD/QCsUj5Z+rgqJdXag3AH1uN
         WhX5hNiOjsB6w4XNSSBcIGQ+mvVuCKutYO17djM8Ng1Mkf8YKskXQKsZZlt0Tv+k6qeP
         F+XblOgt5QI9f5ChKwCreEkzgmePx5PM9rH19xXABWdn0EaWXozkih4scb8sEPFz3sBw
         8xXt9aWJSaI/1rcUVFqZhZif3prFlfaAbYZ5m0i8UZa1x5oazKp1+UsUEvKk/Ioz6k0p
         tf+g==
X-Gm-Message-State: AOAM530cI9/MIh9fllL+EE/wXiYVu0ZhTcAc0Fp2LWVEttwyfQcjZAvC
        Atzqip1o/afu55NF1chkG694VYZ1ZXYcO6+TaAmp6Q==
X-Google-Smtp-Source: ABdhPJx98F4Ggb0M5a4LiNvG3+LgOF0tjxuXRKQOVkS/m3OiQ//vcTkyDr86hHe3MHEgfxQ2YAKQk1b02ao6JwIT25o=
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id
 144-20020a6218960000b0290197491cbe38mr12776863pfy.15.1611787089325; Wed, 27
 Jan 2021 14:38:09 -0800 (PST)
MIME-Version: 1.0
References: <20210125172956.j2prlchhqwfcgzuc@google.com> <20210127205600.1227437-1-maskray@google.com>
In-Reply-To: <20210127205600.1227437-1-maskray@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 27 Jan 2021 14:37:57 -0800
Message-ID: <CAKwvOdkWkBMzFmYdLtdJswXdL2U7ycteVvmZLwk8AUvtrAy6gQ@mail.gmail.com>
Subject: Re: [PATCH v4] x86: Treat R_386_PLT32 as R_386_PC32
To:     Fangrui Song <maskray@google.com>, Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 12:56 PM Fangrui Song <maskray@google.com> wrote:
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

Boris, my CI is red since
https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6
landed (Dec 5) for i386.  If you need a shorter (or less toolchain
verbiage) commit message, please consider simply:

```
This is similar to commit b21ebf2fb4cd ("x86: Treat R_X86_64_PLT32 as
R_X86_64_PC32"), but for i386.  From that commit message:
  As far as the Linux kernel is concerned, R_386_PLT32 can be
  treated the same as R_386_PC32.

clang-12 -fno-pic (since
https://github.com/llvm/llvm-project/commit/a084c0388e2a59b9556f2de0083333232da3f1d6)
can emit R_386_PLT32 for compiler generated function declarations.
```

It would help me abuse <strikethrough>alcohol</strikethrough>coffee
less to have one less fire.

>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1210
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Fangrui Song <maskray@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nick Desaulniers <ndesaulniers@google.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>
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


-- 
Thanks,
~Nick Desaulniers
