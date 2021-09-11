Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC8D407426
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 02:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhIKAMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 20:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:48830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233946AbhIKAMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 20:12:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 43FD661153;
        Sat, 11 Sep 2021 00:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631319068;
        bh=yeeED2XMwiYj2Vyk5oFYVTWh2J/e+jx7vDdEx6zHkaA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OH44Dm9E/m8nTgon7/ykIa2PVxuVXWyyJodxT/7qa/A3ptGVXbRFkn5ne+XnQMoQ6
         +NvL2aqi+/pCqravPaPv/GU+5tog4+D3wi5V3t8MHLUV0r4Rj+6vR5yrLNXtzKq4/4
         hPA/AnjEG1QUFG8faYUsbTWRx70Baa9mPUgkb7HbkJM2VcEi1q5UzJ9BbuqU9cjlZa
         jK61WbJjHJk+3Wv1DDaot96NfJkep8lLmL6FIKmOp2iWG4Jj0LEIAMxbh9+5J9/1Td
         Qsii5hYxErCPuPn2RTeIiuS5Ryth+OoxMe/AlDfbT+iYFEk8PKxPrQ9JK7zfjX5cKS
         djKBHxatAsKvg==
Date:   Fri, 10 Sep 2021 17:11:03 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] Makefile: drop GCC < 5
 -fno-var-tracking-assignments workaround
Message-ID: <YTv0F8LrjrzenT0n@archlinux-ax161>
References: <20210910234047.1019925-1-ndesaulniers@google.com>
 <20210910234047.1019925-9-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910234047.1019925-9-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2021 at 04:40:45PM -0700, Nick Desaulniers wrote:
> Now that GCC 5.1 is the minimally supported version, we can drop this
> workaround for older versions of GCC.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  Makefile | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index 2d1e491f7737..f9ef07f573e0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -849,12 +849,6 @@ endif
>  
>  DEBUG_CFLAGS	:=
>  
> -# Workaround for GCC versions < 5.0
> -# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=61801
> -ifdef CONFIG_CC_IS_GCC
> -DEBUG_CFLAGS	+= $(call cc-ifversion, -lt, 0500, $(call cc-option, -fno-var-tracking-assignments))
> -endif
> -
>  ifdef CONFIG_DEBUG_INFO
>  
>  ifdef CONFIG_DEBUG_INFO_SPLIT
> -- 
> 2.33.0.309.g3052b89438-goog
> 
> 
