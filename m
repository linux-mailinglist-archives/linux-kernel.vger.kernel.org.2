Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067C7324F61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhBYLq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:46:26 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38806 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234024AbhBYLqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:46:19 -0500
Received: from zn.tnic (p200300ec2f03dc0059e4821217d1e808.dip0.t-ipconnect.de [IPv6:2003:ec:2f03:dc00:59e4:8212:17d1:e808])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE5851EC0591;
        Thu, 25 Feb 2021 12:45:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614253538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=5PC1Iat4+U7GzFaV6HWVYimOi8jqa6Fap0CPvCUVnQg=;
        b=cCwk3ZrzLR8sEGhihzdtBoZ4ZoZ9P5Yplu8KfdGPkNnQjUFRyd/ZD5MoIXGi8Z7opZxBgm
        xp9dLVVPhZAq1puYghfwV3ZqepUCksli333gmkTg/f5E0lK9C2fcKqPBzQCFsWlvbr7WKC
        02+YNJtx8bZO+xFL9xWGuEHJzJD49fs=
Date:   Thu, 25 Feb 2021 12:45:33 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] x86: mark some mpspec inline functions as __init
Message-ID: <20210225114533.GA380@zn.tnic>
References: <20210225112247.2240389-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210225112247.2240389-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:22:41PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> clang-13 sometimes decides to not inline early_get_smp_config(),
> which leads to a link-time warning:
> 
> WARNING: modpost: vmlinux.o(.text+0x838cc): Section mismatch in reference from the function early_get_smp_config() to the variable .init.data:x86_init
> The function early_get_smp_config() references
> the variable __initdata x86_init.
> This is often because early_get_smp_config lacks a __initdata
> annotation or the annotation of x86_init is wrong.
> 
> There are two other functions which may run into the same issue,
> so mark all three as __init.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/x86/include/asm/mpspec.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mpspec.h b/arch/x86/include/asm/mpspec.h
> index e90ac7e9ae2c..b41066dbf5c2 100644
> --- a/arch/x86/include/asm/mpspec.h
> +++ b/arch/x86/include/asm/mpspec.h
> @@ -49,17 +49,17 @@ extern int smp_found_config;
>  # define smp_found_config 0
>  #endif
>  
> -static inline void get_smp_config(void)
> +static inline __init void get_smp_config(void)

__always_inline then I guess.

Not inlining those is just silly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
