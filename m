Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8380B41CD78
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 22:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346766AbhI2UjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 16:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345611AbhI2UjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 16:39:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 028276136A;
        Wed, 29 Sep 2021 20:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632947851;
        bh=k0jUlGJBK5TZDgDEi1+aE6n+zqLLo17WSv6MatuQbi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JuCF6D5ggy+fGhjTto+szT/BmUu6aecT3jeMLUu6NPvD+7Mg9IPH+/mnc6HdXfaKn
         neDh28MFdhU495Kh2Qfpti0uaDv6HP0Q/yzPWNiMC2XQiF9pvvALKeUWYvdnnaICzx
         t9V5guNuqASSMGOuxC64WbKzZQLZrDdpoLt+s/YWxPLQm5TPpL3gANhCFYdBkF9tRP
         1LYeOeZXhJQhjZmzanBzrS/UQwOQfWTrSG5UYMs8iTcFkYbtCWRWvQ2fMRyohQ7c8O
         8qUq6XhXQg6svWgQcCzRdsnwXw1L6S+taZNHwJWhyEgQobTi4XllQAgMyzgMQAEcVT
         qZTtgEJSCY7qg==
Date:   Wed, 29 Sep 2021 13:37:25 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fangrui Song <maskray@google.com>,
        Peter Smith <peter.smith@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Dave Martin <dave.martin@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH v2] ARM: mm: proc-macros: ensure *_tlb_fns are 4B aligned
Message-ID: <YVTOhRJ5Zx2kk/KN@archlinux-ax161>
References: <CAKwvOdmjZ+QmjTJnQ-w5hLPJjow1gYnWTe6f8RBhQUJ2b3cYnw@mail.gmail.com>
 <20210929192026.1604095-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929192026.1604095-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:20:24PM -0700, Nick Desaulniers wrote:
> QEMU 6.1.0 is more correct about trapping on misaligned accesses. A
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

Tested-by: Nathan Chancellor <nathan@kernel.org>

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
>  	.type	\name\()_tlb_fns, #object
> +	.align 2
>  ENTRY(\name\()_tlb_fns)
>  	.long	\name\()_flush_user_tlb_range
>  	.long	\name\()_flush_kern_tlb_range
> 
> base-commit: 02d5e016800d082058b3d3b7c3ede136cdc6ddcb
> prerequisite-patch-id: 3edbe4a8485c7a75a61dbbe299e8ce1985d87ee0
> -- 
> 2.33.0.685.g46640cef36-goog
> 
> 
