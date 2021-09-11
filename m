Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D85407424
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 02:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbhIKAKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 20:10:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhIKAKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 20:10:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 518C4611BF;
        Sat, 11 Sep 2021 00:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631318959;
        bh=0YuBUzN72gkNDxmeZ5kJyvvvXFpC+53qFp+/zstmt9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmv5TRqSAS/BsSeUTEibp7up/z8FC7Zncd+zxhBvJXZt+59mJpA9lnYFUMKStarVU
         v9n6xzm0pz5TFMy2lLdAD56pxskSpwmyD/Qwk2x+0MsLPMkyWrsotNexrlUUx9sMTO
         QSXID0uMhcQaIcwYyLnChGlGf/5R6mim7v+zsF7QXsJEp++tdi4WOnL1w/6KKqOrjm
         qsL7W0FvrIpKokD0DvJUHnYFgYO7R2AGXcQLtj7If5DoSexiavFxZ5n+J9GyJ9qmJ9
         Q35lu2pPDxaoTktyiqVGVW86G2k5MwHRlFUzHFd4/eCIXkbEFVS7wtHRouXbvGH2zU
         1IASjekyXc0Bg==
Date:   Fri, 10 Sep 2021 17:09:14 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 05/10] riscv: remove Kconfig check for GCC version for
 ARCH_RV64I
Message-ID: <YTvzqrrN8xfYalt5@archlinux-ax161>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-6-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-6-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:42PM -0700, Nick Desaulniers wrote:
> The minimum supported version of GCC is now 5.1. The check wasn't
> correct as written anyways since GCC_VERSION is 0 when CC=clang.
> 
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Indeed, I meant to clean this up a while ago but forgot :/

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c79955655fa4..5fc1d0cc82e1 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -235,7 +235,7 @@ config ARCH_RV32I
>  config ARCH_RV64I
>  	bool "RV64I"
>  	select 64BIT
> -	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
> +	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
> -- 
> 2.33.0.309.g3052b89438-goog
> 
> 
