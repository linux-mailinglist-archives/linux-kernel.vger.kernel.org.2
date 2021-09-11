Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE92F407425
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 02:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbhIKAMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 20:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhIKAL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 20:11:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59B2A611BF;
        Sat, 11 Sep 2021 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631319044;
        bh=HgiHQcF3LVK3G9eZiQ8cGSEktVPqKSf0eNxm5bavhHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VwzAjXeLlL0qOsTx09PxPCWphn2hIwR0xwGAWWSV7SBYC/Ni7r4MjSRJFgykbzwIC
         EhZR9MR8MFizjtcVLoOHVdxTOwJm0DittF5KPAR++m++AVBGKFOyOE3F7Cz+ugW7OK
         ImptrCEe3nCkkG+WfdSbwOYrbvaekh3QqGCTmOuPO70+MWyVw20MbwJj3x16bzxgZZ
         NVMfAhM0TNJ+XvkB9ieHKt3SyyssfcIIFFi2J3w+ThXdtaMfs/8K4Bf7gC9RLJi6Fa
         dfywPPUQE0/kuDB46YGzop/ilR2atmrpAPTojA/jXGE7IeHBH/HV6REoDUHio43smN
         QrwyeRjEY952g==
Date:   Fri, 10 Sep 2021 17:10:38 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 07/10] arm64: remove GCC version check for
 ARCH_SUPPORTS_INT128
Message-ID: <YTvz/r/Le6YF2a6F@archlinux-ax161>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-8-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-8-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:44PM -0700, Nick Desaulniers wrote:
> Now that GCC 5.1 is the minimally supported compiler version, this
> Kconfig check is no longer necessary.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/arm64/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 077f2ec4eeb2..5c7ae4c3954b 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -86,7 +86,7 @@ config ARM64
>  	select ARCH_SUPPORTS_LTO_CLANG_THIN
>  	select ARCH_SUPPORTS_CFI_CLANG
>  	select ARCH_SUPPORTS_ATOMIC_RMW
> -	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
> +	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_SUPPORTS_NUMA_BALANCING
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
>  	select ARCH_WANT_DEFAULT_BPF_JIT
> -- 
> 2.33.0.309.g3052b89438-goog
> 
> 
