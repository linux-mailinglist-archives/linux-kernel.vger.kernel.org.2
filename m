Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA953689E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbhDWAdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:33:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235302AbhDWAdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:33:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 520C4613F6;
        Fri, 23 Apr 2021 00:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619137947;
        bh=HxcklD0m2+PXP/vIiOXF29m0Dl9QrshDlK/NZ6JeiX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EGX3Bts2GQCYP5+LroCn6aAMaLHd4ZUVjU0s+4nvbCvIPE589xstwR/oKN0LHnlLQ
         1kHNasUGRrH8AB+HDMViRw+78dSmqgQC6JzsKa+R0G4HIceLC2DndNKiWhIO67X5VK
         G4wIb1qjlPG7BxKknHmyMg9xJqN9D27WYwPTyyHNvosJrp6cxwms3fyUZhbc9cfOzU
         ca0hExb0c4WGjx3RJ7WQNLktGCITgTRV9wMg6ZQF9BOn/uLxPOucsag8xxGGO/jRM9
         sm4qLr3SBOMAfxoZUVtLwdGkE4x933W9MQ3S4dbVVC7TXEjtZml4yWIlhDj8NgEPNd
         tROCSFGicHofQ==
Date:   Thu, 22 Apr 2021 17:32:21 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Joe Perches <joe@perches.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Joerg Roedel <jroedel@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed: enable -Wundef
Message-ID: <YIIVlahVlJAsaE9W@archlinux-ax161>
References: <20210422190450.3903999-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210422190450.3903999-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 12:04:42PM -0700, Nick Desaulniers wrote:
> A discussion around -Wundef showed that there were still a few boolean
> Kconfigs where #if was used rather than #ifdef to guard different code.
> Kconfig doesn't define boolean configs, which can result in -Wundef
> warnings.
> 
> arch/x86/boot/compressed/Makefile resets the CFLAGS used for this
> directory, and doesn't re-enable -Wundef as the top level Makefile does.
> If re-added, with RANDOMIZE_BASE and X86_NEED_RELOCS disabled, the
> following warnings are visible.
> 
> arch/x86/boot/compressed/misc.h:82:5: warning: 'CONFIG_RANDOMIZE_BASE'
> is not defined, evaluates to 0 [-Wundef]
>     ^
> arch/x86/boot/compressed/misc.c:175:5: warning: 'CONFIG_X86_NEED_RELOCS'
> is not defined, evaluates to 0 [-Wundef]
>     ^
> 
> Simply fix these and re-enable this warning for this directory.

I wonder if it is worth turning on -Wall for this directory...

> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: Joe Perches <joe@perches.com>
> Link: https://github.com/ClangBuiltLinux/linux/issues/570
> Link: https://lore.kernel.org/lkml/67f6cd269684c9aa8463ff4812c3b4605e6739c3.camel@perches.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/x86/boot/compressed/Makefile | 1 +
>  arch/x86/boot/compressed/misc.c   | 2 +-
>  arch/x86/boot/compressed/misc.h   | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index e0bc3988c3fa..77cc373c1036 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -30,6 +30,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
>  
>  KBUILD_CFLAGS := -m$(BITS) -O2
>  KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
> +KBUILD_CFLAGS += -Wundef
>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>  cflags-$(CONFIG_X86_32) := -march=i386
>  cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
> diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
> index 267e7f93050e..3a214cc3239f 100644
> --- a/arch/x86/boot/compressed/misc.c
> +++ b/arch/x86/boot/compressed/misc.c
> @@ -172,7 +172,7 @@ void __puthex(unsigned long value)
>  	}
>  }
>  
> -#if CONFIG_X86_NEED_RELOCS
> +#ifdef CONFIG_X86_NEED_RELOCS
>  static void handle_relocations(void *output, unsigned long output_len,
>  			       unsigned long virt_addr)
>  {
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 901ea5ebec22..b140f988a233 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -79,7 +79,7 @@ struct mem_vector {
>  	u64 size;
>  };
>  
> -#if CONFIG_RANDOMIZE_BASE
> +#ifdef CONFIG_RANDOMIZE_BASE
>  /* kaslr.c */
>  void choose_random_location(unsigned long input,
>  			    unsigned long input_size,
> 
> base-commit: 16fc44d6387e260f4932e9248b985837324705d8
> -- 
> 2.31.1.498.g6c1eba8ee3d-goog
> 
