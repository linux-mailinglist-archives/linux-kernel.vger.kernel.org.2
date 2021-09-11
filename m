Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38206407422
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 02:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhIKAJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 20:09:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhIKAJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 20:09:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 199AA61153;
        Sat, 11 Sep 2021 00:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631318907;
        bh=Rn8JbUkAe5lHAAHM/43rtcAZCRA3lWLsjQNCfKtDhv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNLLGz5mZjevnGVjER83RvZyDg9GbS4TN0MzxnLwG87T8k/wYwdoXiiOuiQ2OvpQm
         zH8Zyg1AgiMFQQQgPGt2ILacAJgb8sX6XmxGZXeoHOE0b0yBakysLkeLdtKjw74Oa8
         /tq7SNfiWf7JXrrFV/4Khg9Fg5x6v9/R12E+xaFnCu5o6Tz83ZVKwSMSFaWT+hRTql
         tiDm6FPPLFPY21vC/K4zS7VvxWLgU5OJUIYOVsMgFzt15Qm/IMe/8WWnp5c11p9Qs7
         N3ByCBou78W14fSODhjWJWowBRo4TBo7K90152Irz/C/k1Y9YnoHy8F/DVIlUrRr1E
         dmBaLJ7kDCG/Q==
Date:   Fri, 10 Sep 2021 17:08:22 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] Kconfig.debug: drop GCC 5+ version check for DWARF5
Message-ID: <YTvzdrlrh2H98yjY@archlinux-ax161>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-5-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-5-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:41PM -0700, Nick Desaulniers wrote:
> Now that the minimum supported version of GCC is 5.1, we no longer need
> this Kconfig version check for CONFIG_DEBUG_INFO_DWARF5.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  lib/Kconfig.debug | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ed4a31e34098..d566f601780f 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -295,7 +295,7 @@ config DEBUG_INFO_DWARF4
>  
>  config DEBUG_INFO_DWARF5
>  	bool "Generate DWARF Version 5 debuginfo"
> -	depends on GCC_VERSION >= 50000 || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
> +	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
>  	depends on !DEBUG_INFO_BTF
>  	help
>  	  Generate DWARF v5 debug info. Requires binutils 2.35.2, gcc 5.0+ (gcc
> -- 
> 2.33.0.309.g3052b89438-goog
> 
> 
