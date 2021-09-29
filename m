Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5DF41CDA6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 22:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346812AbhI2U71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 16:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346776AbhI2U7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:59:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0372F61528
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 20:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632949063;
        bh=z4p1G85CcZY4Hw6JjpFyc6yNDWNhKYa5qIXjea56ROk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BCt/fH2Xsp2dUVpc8yNaIPngq+lpqcBhHpVptGHG75DNkMm2dGvg72CoDfTfqjCfN
         DEHag33GHtgzBXjgbwPd/d59qoGA3UejbgpUaLUpQeZR5l3TAj7trO0GZ82FdCC+Mb
         4Si2a2CsqvayNAd6J0I7LZ8akRfA9B8N31Pu029LMuAkJx3FYuCKDXoogkljLp2ign
         bMbQsP0SPLvZ5yAN3mCGkJ2aJ1ej2oeKzR4rfHG4PZlYOwF6tIs6Gj1fi3eq+68dCi
         V0PQld8jjcL90A9d4LpBEOlQZbfRKZhxre5Wj3Pnwi3XrQbp8cb/mB/mdHVDNN8VN3
         hMVEPqoDCalig==
Received: by mail-oi1-f180.google.com with SMTP id a3so4553487oid.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 13:57:42 -0700 (PDT)
X-Gm-Message-State: AOAM532uhtVoJ0QKJaiUPrR89X+uOXwdZLUs6XnX0K2rPx1M5e/Xjs7f
        RRRgZMFiOSBM6yuvpP/8aNBhbv3VQBHYLP9xko4=
X-Google-Smtp-Source: ABdhPJyQ02Eim0iYMuBFE57S99npQ7Xq2PVHC2N79V8Y/pD0vYiVEfJaKQfKSJ6bLch4lf8Y8TeZF5z/Sk5/ExHwDk0=
X-Received: by 2002:aca:32c2:: with SMTP id y185mr9488548oiy.47.1632949062268;
 Wed, 29 Sep 2021 13:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmjZ+QmjTJnQ-w5hLPJjow1gYnWTe6f8RBhQUJ2b3cYnw@mail.gmail.com>
 <20210929192026.1604095-1-ndesaulniers@google.com>
In-Reply-To: <20210929192026.1604095-1-ndesaulniers@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 29 Sep 2021 22:57:30 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHkcTZOR1eb-GVVe3m77Lfg8qdp+wLgHMOr7yNTecBGOw@mail.gmail.com>
Message-ID: <CAMj1kXHkcTZOR1eb-GVVe3m77Lfg8qdp+wLgHMOr7yNTecBGOw@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: mm: proc-macros: ensure *_tlb_fns are 4B aligned
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Fangrui Song <maskray@google.com>,
        Peter Smith <peter.smith@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Dave Martin <dave.martin@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sept 2021 at 21:20, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> QEMU 6.1.0 is more correct about trapping on misaligned accesses.

Btw, this is not entirely relevant. QEMU now behaves like every single
hardware implementation does, and reports an alignment fault when
using a load-multiple instruction on an address that is not 32-bit
aligned, as the architecture requires.


> A
> kernel built with CONFIG_THUMB2_KERNEL=y and using clang as the
> assembler could generate non-naturally-aligned v7wbi_tlb_fns which
> results in a boot failure. The original commit adding the macro missed
> the .align directive on this data.
>
> Fixes: 66a625a88174 ("ARM: mm: proc-macros: Add generic proc/cache/tlb struct definition macros")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1447
> Link: https://lore.kernel.org/all/0699da7b-354f-aecc-a62f-e25693209af4@linaro.org/
> Debugged-by: Ard Biesheuvel <ardb@kernel.org>
> Debugged-by: Nathan Chancellor <nathan@kernel.org>
> Debugged-by: Richard Henderson <richard.henderson@linaro.org>
> Suggested-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Changes V1 -> V2:
> * Drop accidentally committed Kconfig change.
> * Pick up Ard's AB tag.
>
>  arch/arm/mm/proc-macros.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index e2c743aa2eb2..d9f7dfe2a7ed 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -340,6 +340,7 @@ ENTRY(\name\()_cache_fns)
>
>  .macro define_tlb_functions name:req, flags_up:req, flags_smp
>         .type   \name\()_tlb_fns, #object
> +       .align 2
>  ENTRY(\name\()_tlb_fns)
>         .long   \name\()_flush_user_tlb_range
>         .long   \name\()_flush_kern_tlb_range
>
> base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
> prerequisite-patch-id: 3edbe4a8485c7a75a61dbbe299e8ce1985d87ee0
> --
> 2.33.0.685.g46640cef36-goog
>
