Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAF535FA0A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344284AbhDNRr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbhDNRrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:47:23 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D907DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:47:01 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id m20so1769386uah.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 10:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q97lT2gtlL/ZYrFbpq2z+qcIs3qeeq4P5EG52TEAcdM=;
        b=FASsM6Mqt/GGPdEfPxH0BeAUtBP2LBxWtovEIAxVgZPiKATwrM0upW/rmS2tgAPLGW
         tLDmP5USwnjCv+CG2k3l3djEKlvlTFqF89cW7lv20RbUF5NJQt2Eh702Ba0Le1xYFzFS
         YSIe+HmENCrzrHUhgcRPg5vpyCxBOhlEiEk4Vgc3QyM0PDsKBaiPbZL84aqlMsYjXuqx
         LBLoMT9lOX6TOf6eJskvSa3NdvMLVfR3fvxW+OeSjFGoPVjO1k27txBuXoToxTm5srBh
         luyDjDc3beB2HX7FJm5KgFVtgMZQ3V1yKxHfr5c/vqsXlDKkTtN8XhReO6rveIvpVgaJ
         jGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q97lT2gtlL/ZYrFbpq2z+qcIs3qeeq4P5EG52TEAcdM=;
        b=FWwJ2+ZRnEBcsYRBRKJu+qOIDVZl1QjUd0KQhVl1sjHFclHhiObbQq6WnSjUQugiv4
         G46GLqcHcZqzBuuJZp98JPx5ohaYsb8zgR9A8ajpmMoF6kRRlJVwEHt7olw4Himm6IJE
         Jtzvpt3+sqYwoOd4qIBnzlTMPlNyUc6UC+ojPqn2FzQUiYt+tepwa3SuVgtI1NkgwxYw
         oUFrLCdEavTPa0PmgJeRg7YFqaORMd38IfT8qhs4VfOyhqkYtnJ8Bt9yI8hI6FA+ujj4
         uF+4TInx++wwKheyzgaWT0s4g06h+dRVUKimxSLEHErCMNZLDEvLzRxSb0muwNcf71L3
         C7OA==
X-Gm-Message-State: AOAM532KqLC2o8iSZ7M6JCeGe9LinRMtwMjQGMqpxvPvwMfFFNU+Fkcc
        S0fuDfDkKYirnrUtlFGL/aSYTOURka84LGYUzlAJTQ==
X-Google-Smtp-Source: ABdhPJxOFhS7WC1rn9NAh8rEqbOu1jy+k//lbPl6ERVT8Ju5qO+Yh7E4m942OCFjR9GUQT4EjgwshKNKLwszoxpvB44=
X-Received: by 2002:a9f:3728:: with SMTP id z37mr27839924uad.89.1618422420730;
 Wed, 14 Apr 2021 10:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210414000803.662534-1-nathan@kernel.org>
In-Reply-To: <20210414000803.662534-1-nathan@kernel.org>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 14 Apr 2021 10:46:49 -0700
Message-ID: <CABCJKueJjOguo7-PUR1yhZm4sX4F7t-7ZMcjU8pAMBQyv6Pmnw@mail.gmail.com>
Subject: Re: [PATCH] arm64: alternatives: Move length validation in alternative_{insn,endif}
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jian Cai <jiancai@google.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

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

Thank you for fixing these!

The patch looks correct to me, next-20210413 builds with LLVM_IAS=1
after I applied it, and defconfig built with both Clang and gcc boots
normally. Please feel free to add:

Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Tested-by: Sami Tolvanen <samitolvanen@google.com>

Sami
