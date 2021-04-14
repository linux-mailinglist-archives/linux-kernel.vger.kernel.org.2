Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF1B35FB99
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 21:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353375AbhDNTW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 15:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353370AbhDNTWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 15:22:54 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7E3C061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:22:30 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id r20so24475127ljk.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 12:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PUOYXNfICZdC1+9G6F70MzTNDWMZ0Mz9R8OhGw2MATA=;
        b=thrADslz3ToX7uQBnxWvFoINCJNnr6ngJ+dVi9lut9X4zfnY8g1wvwlW0ElJoXAkx5
         TMrFJGf4rs1Cvs85Z5PgLK2b4MB12ixyLb8wzp52LNINPbF6Orwb6o+8AAQXrKYiTKTw
         TrjFGLHCH8zBAjFQdc8gGv3bXXjOUxGY1oYulm/OmrIt4zCJXR6ZEfwbFGo3ZXNOf2m5
         9R4EKJkcIeA4VQlAeY5l+GPe5sUzJ3Xf0CJO6079ZJNUoGRmmdKi07HsEdpyGNEglEx9
         sy7DmPKgarJzSZNB4cpO704cM2jMIW6SXXtxRgjnonnAPEtkRIkdSCx/Pc8tPYTI/1fD
         ga4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PUOYXNfICZdC1+9G6F70MzTNDWMZ0Mz9R8OhGw2MATA=;
        b=d4QY52sWgMtpPbSEJwENlLCltNbaUIgaa/Xipec1pqbSqdEelUv6+hPV2PrP6jvTkC
         Q+QSYvk/1VyklE+4mz/nyJG0XyxLZbk4pzQCr+MnKXcNXVbsH0ZSC4/g3Xm54ngtFMk5
         t2tw6z6coOu2vY2yG1KiNZpXgRXeZHD9vGBvo9PEIxJQb9SWpdSeQaMD1yjcKqerPIAM
         7GyP8E77boM4/wzhjncKuuGd+r4TEILNryPOB/p6zPVkd3ccocjeAFQvNX6PAd7aGPXc
         ANUF6nRRv4lFXi4UfyiN1xUJRUK1/NrjQ866dVsPmK1KMBwORj1gcHb2nFeGeEqa6+Fq
         srNw==
X-Gm-Message-State: AOAM531T77UDMW+m5dLB35eWURuFlsgkqWa9zABKfbdvhBLxcMtIes66
        OH6BpQzKub9dl+eYCJ1G7mF+plQbEhL/3Mi3B2FeCQ==
X-Google-Smtp-Source: ABdhPJwANq4izR9wSH8/54RE6iS58ESvhjt5HzFkQu+osbE8ndiFXYYZTkcxTEz7tzXd7P68r30w9dJqp3FR/dq9ths=
X-Received: by 2002:a2e:b008:: with SMTP id y8mr23815586ljk.233.1618428149110;
 Wed, 14 Apr 2021 12:22:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210414000803.662534-1-nathan@kernel.org>
In-Reply-To: <20210414000803.662534-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 14 Apr 2021 12:22:17 -0700
Message-ID: <CAKwvOdmHA-5BLVMTViJuuqnHTLnVHaJeHf7M0nbfscxPFKYSPQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: alternatives: Move length validation in alternative_{insn,endif}
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Jian Cai <jiancai@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 5:09 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> After commit 2decad92f473 ("arm64: mte: Ensure TIF_MTE_ASYNC_FAULT is
> set atomically"), LLVM's integrated assembler fails to build entry.S:
>
> <instantiation>:5:7: error: expected assembly-time absolute expression
>  .org . - (664b-663b) + (662b-661b)
>       ^
> <instantiation>:6:7: error: expected assembly-time absolute expression
>  .org . - (662b-661b) + (664b-663b)
>       ^
>
> The root cause is LLVM's assembler has a one-pass design, meaning it
> cannot figure out these instruction lengths when the .org directive is
> outside of the subsection that they are in, which was changed by the
> .arch_extension directive added in the above commit.
>
> Apply the same fix from commit 966a0acce2fc ("arm64/alternatives: move
> length validation inside the subsection") to the alternative_endif
> macro, shuffling the .org directives so that the length validation
> happen will always happen in the same subsections. alternative_insn has
> not shown any issue yet but it appears that it could have the same issue
> in the future so just preemptively change it.

Thanks Nathan.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

I did some additional disassembly comparison.  In case we ever need it
again, I'll copy it below for posterity.

$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu make LLVM=1 LLVM_IAS=1
-j72 O=/tmp/a defconfig all
$ b4 am https://lore.kernel.org/lkml/20210414000803.662534-1-nathan@kernel.org/
-o - | git am -3
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu make LLVM=1 LLVM_IAS=1
-j72 O=/tmp/b defconfig all
$ for f in $(find /tmp/a/arch/arm64 -name \*.o); do llvm-objdump -dr
$f > $f.txt; done
$ for f in $(find /tmp/b/arch/arm64 -name \*.o); do llvm-objdump -dr
$f > $f.txt; done
$ for f in $(find /tmp/a/arch/arm64 -name \*.o); do diff -u $f.txt
$(echo $f.txt|sed 's/a/b/'); done | less

For no difference.  You can check more sections than .text by changing
`-d` to `-D` for llvm-objdump, though you're going to get a lot of
noise related to changes in .strtab and relocations referring to debug
info (.debug_str).  But if I drop your patch, rebuild, and recompare,
I see the same differences.

>
> Cc: stable@vger.kernel.org
> Fixes: f7b93d42945c ("arm64/alternatives: use subsections for replacement sequences")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1347
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>
> Apologies if my explanation or terminology is off, I am only now getting
> more familiar with assembly.
>
>  arch/arm64/include/asm/alternative-macros.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/alternative-macros.h b/arch/arm64/include/asm/alternative-macros.h
> index 5df500dcc627..8a078fc662ac 100644
> --- a/arch/arm64/include/asm/alternative-macros.h
> +++ b/arch/arm64/include/asm/alternative-macros.h
> @@ -97,9 +97,9 @@
>         .popsection
>         .subsection 1
>  663:   \insn2
> -664:   .previous
> -       .org    . - (664b-663b) + (662b-661b)
> +664:   .org    . - (664b-663b) + (662b-661b)
>         .org    . - (662b-661b) + (664b-663b)
> +       .previous
>         .endif
>  .endm
>
> @@ -169,11 +169,11 @@
>   */
>  .macro alternative_endif
>  664:
> +       .org    . - (664b-663b) + (662b-661b)
> +       .org    . - (662b-661b) + (664b-663b)
>         .if .Lasm_alt_mode==0
>         .previous
>         .endif
> -       .org    . - (664b-663b) + (662b-661b)
> -       .org    . - (662b-661b) + (664b-663b)
>  .endm
>
>  /*
>
> base-commit: 738fa58ee1328481d1d7889e7c430b3401c571b9
> --
> 2.31.1.272.g89b43f80a5
>


-- 
Thanks,
~Nick Desaulniers
