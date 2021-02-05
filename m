Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444E5311054
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbhBERHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbhBEQdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 11:33:13 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E7CC06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 10:14:54 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id a8so11157686lfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 10:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YriR2p78K/vHHtzWx/ItCRdYg1dmwwp3GdKREBar06I=;
        b=pqEFA3lIa3yN9nngQaWfiywwo2ZSDn5+1d2EQ/LbVfpfSw8GKliTCeol1YB15k8RJP
         Ir0WxrNpHIu3ngNu9WGdluyljKt8YcRDQnYrXcNyEoXt51y0A59WtXDMpe06xAvpfhVR
         iotsqfiXp0umQpKe5zXAJMbsHN7t/9u3dZ7Czxa0dG9s4/Y6S/sZjFX9UdRU76a1ZoVE
         /hq+DBp8hpE+VHJhvZRdhqdJ2CdEP/xzUJB6nHeZ5nC+oEAM1o28suAV7rKf7R96a5mg
         XuNBeZT0UE5QUBSRaliFcZZxFR1LR/+yOpgBC8xC1d2uYqejLXQJIKUzSFqAPxcC5CNm
         2WYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YriR2p78K/vHHtzWx/ItCRdYg1dmwwp3GdKREBar06I=;
        b=tLSQMR8DEwlZ6Id1uFydWF9z1gFx2bx7+kmsVjczQcnCKBwzvKO1iwHT6BZZBJgQf0
         oyCXd+iRobDtolhvTHhqDmTnncTAbCjeNadZMuhWfwV9uPrSJvicJ8D3jubewL+kR1oo
         00hqzpZsoGvFl4bO1YpIDiNsCGjQKc1MjErDCSZSWJ9k0oazIwUZffI4xHpY2GvXSeKh
         eIy5At22iMzH7wNlTREvklKgpqQ/RQMPp7HpnIUuriDckD2B9bIxLpaLv2mezh9O0tPC
         +W4mzaevVT8lpN/GM90mVFCOfeusy2LguEE0iC8vWNnmSXrzQxguuPNfe+C5VFYEbUpi
         teNg==
X-Gm-Message-State: AOAM533L/o3KC1P64DNe5zAL3JhkCHdtJnbxMNsE0SGmrWsqWsFtlEwe
        WRKi92l1Davoy2S7kLgpXtDNNwEUiS0f0tiETThOFQ==
X-Google-Smtp-Source: ABdhPJzSGO5tZcOtelk/HyR2Ol1kqQCS3E+C+04PZWXnAHFrL6NFakA7BLPSeI4FoggUaddjEgr95Af4UTWMScUF5PM=
X-Received: by 2002:ac2:5622:: with SMTP id b2mr3121608lff.297.1612548892948;
 Fri, 05 Feb 2021 10:14:52 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXGZFZciN1_KruCr=g6GANNpRrCLR48b3q13+QfK481C7Q@mail.gmail.com>
 <20210118202409.GG30090@zn.tnic> <YAYAvBARSRSg8z8G@rani.riverdale.lan>
 <CAMj1kXHM98-iDYpAozaWEv-qxhZ0-CUMwSdG532x2d+55gXDhQ@mail.gmail.com>
 <20210203185148.GA1711888@localhost> <CAMj1kXFPOvkcw573wzKzMQOgT-nddFcAZo9M4Lk+idn_1UBbnA@mail.gmail.com>
 <20210204105155.GA32255@zn.tnic> <YBxqnosGDroAnpio@rani.riverdale.lan>
 <20210204221318.GI32255@zn.tnic> <YByMdh/qDEwreq6S@rani.riverdale.lan> <20210205113930.GD17488@zn.tnic>
In-Reply-To: <20210205113930.GD17488@zn.tnic>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Feb 2021 10:14:40 -0800
Message-ID: <CAKwvOdkyk_AejhxhasBggxYtSJi+3T-tjCExe+nAM5iJJ5_1aQ@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Remove EFI PGD build time checks
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 3:39 AM Borislav Petkov <bp@alien8.de> wrote:
>
> From: Borislav Petkov <bp@suse.de>
>
> With CONFIG_X86_5LEVEL, CONFIG_UBSAN and CONFIG_UBSAN_UNSIGNED_OVERFLOW
> enabled, clang fails the build with
>
>   x86_64-linux-ld: arch/x86/platform/efi/efi_64.o: in function `efi_sync_low_kernel_mappings':
>   efi_64.c:(.text+0x22c): undefined reference to `__compiletime_assert_354'
>
> which happens due to -fsanitize=unsigned-integer-overflow being enabled:
>
>   -fsanitize=unsigned-integer-overflow: Unsigned integer overflow, where
>   the result of an unsigned integer computation cannot be represented
>   in its type. Unlike signed integer overflow, this is not undefined
>   behavior, but it is often unintentional. This sanitizer does not check
>   for lossy implicit conversions performed before such a computation
>   (see -fsanitize=implicit-conversion).
>
> and that fires when the (intentional) EFI_VA_START/END defines overflow
> an unsigned long, leading to the assertion expressions not getting
> optimized away (on GCC they do)...
>
> However, those checks are superfluous: the runtime services mapping
> code already makes sure the ranges don't overshoot EFI_VA_END as the
> EFI mapping range is hardcoded. On each runtime services call, it is
> switched to the EFI-specific PGD and even if mappings manage to escape
> that last PGD, this won't remain unnoticed for long.
>
> So rip them out.
>
> See https://github.com/ClangBuiltLinux/linux/issues/256 for more info.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Link: http://lkml.kernel.org/r/20210107223424.4135538-1-arnd@kernel.org
> Signed-off-by: Borislav Petkov <bp@suse.de>

Thanks, this fixes the failed assertion for me.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

(https://lore.kernel.org/lkml/20201230154104.522605-1-arnd@kernel.org/
is needed to finish a build of that configuration; going to chase that
next)

(consider applying Arvind's+Ard's suggested by tag)

> ---
>  arch/x86/platform/efi/efi_64.c | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
> index e1e8d4e3a213..8efd003540ca 100644
> --- a/arch/x86/platform/efi/efi_64.c
> +++ b/arch/x86/platform/efi/efi_64.c
> @@ -115,31 +115,12 @@ void efi_sync_low_kernel_mappings(void)
>         pud_t *pud_k, *pud_efi;
>         pgd_t *efi_pgd = efi_mm.pgd;
>
> -       /*
> -        * We can share all PGD entries apart from the one entry that
> -        * covers the EFI runtime mapping space.
> -        *
> -        * Make sure the EFI runtime region mappings are guaranteed to
> -        * only span a single PGD entry and that the entry also maps
> -        * other important kernel regions.
> -        */
> -       MAYBE_BUILD_BUG_ON(pgd_index(EFI_VA_END) != pgd_index(MODULES_END));
> -       MAYBE_BUILD_BUG_ON((EFI_VA_START & PGDIR_MASK) !=
> -                       (EFI_VA_END & PGDIR_MASK));
> -
>         pgd_efi = efi_pgd + pgd_index(PAGE_OFFSET);
>         pgd_k = pgd_offset_k(PAGE_OFFSET);
>
>         num_entries = pgd_index(EFI_VA_END) - pgd_index(PAGE_OFFSET);
>         memcpy(pgd_efi, pgd_k, sizeof(pgd_t) * num_entries);
>
> -       /*
> -        * As with PGDs, we share all P4D entries apart from the one entry
> -        * that covers the EFI runtime mapping space.
> -        */
> -       BUILD_BUG_ON(p4d_index(EFI_VA_END) != p4d_index(MODULES_END));
> -       BUILD_BUG_ON((EFI_VA_START & P4D_MASK) != (EFI_VA_END & P4D_MASK));
> -
>         pgd_efi = efi_pgd + pgd_index(EFI_VA_END);
>         pgd_k = pgd_offset_k(EFI_VA_END);
>         p4d_efi = p4d_offset(pgd_efi, 0);
> --
> 2.29.2
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette



-- 
Thanks,
~Nick Desaulniers
