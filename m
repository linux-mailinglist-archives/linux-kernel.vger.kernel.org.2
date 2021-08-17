Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F563EF1F3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 20:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbhHQSgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 14:36:35 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49988 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232948AbhHQSge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 14:36:34 -0400
Received: from zn.tnic (p200300ec2f1175006a73053df3c19379.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:7500:6a73:53d:f3c1:9379])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5F3F41EC0556;
        Tue, 17 Aug 2021 20:35:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1629225356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SO/ZV2Mk9I+24npFwndDFprvZYKCgwEBp0TLU34JObY=;
        b=mD4tyYQ4Dgu/6qqSsGd1ETxygVxMjefruTmdlXPAzT1Cldts7ME5phL+vafDh5e34LMIQf
        1Va0l2sDKUFdx6x77/5TWPNlUAvYvmsSk9uo+4+U5cd7hsm5q2VLPPryNQjTFTDEbf1XHF
        QjYKEGZsY0xZieL8R8EBfO3HVDFr9Kc=
Date:   Tue, 17 Aug 2021 20:36:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     torvic9@mailbox.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "graysky@archlinux.us" <graysky@archlinux.us>
Subject: Re: [PATCH 2/2] x86, Makefile: Add new generic x86-64 settings
 v2/v3/v4
Message-ID: <YRwBs89eogLJEiRn@zn.tnic>
References: <269701460.117528.1629210189833@office.mailbox.org>
 <796036867.117557.1629210288168@office.mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <796036867.117557.1629210288168@office.mailbox.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 04:24:48PM +0200, torvic9@mailbox.org wrote:
> Add new generic x86-64 CPU tunings introduced with recent versions of
> gcc and clang, as documented in x86-64-psABI [1].
> 
> This is taken straight from graysky's CPU optimization patch with minor
> modifications [2].
> 
> [1] https://gitlab.com/x86-psABIs/x86-64-ABI/-/commit/77566eb03bc6a326811cb7e9a6b9396884b67c7c
> [2] https://github.com/graysky2/kernel_compiler_patch
> 
> Signed-off-by: Tor Vic <torvic9@mailbox.org>
> ---
>  arch/x86/Kconfig.cpu  | 26 +++++++++++++++++++++++++-
>  arch/x86/Makefile.cpu |  6 ++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
> index 814fe0d349b0..a2c872aa5a0b 100644
> --- a/arch/x86/Kconfig.cpu
> +++ b/arch/x86/Kconfig.cpu
> @@ -294,6 +294,30 @@ config GENERIC_CPU
>  	  Generic x86-64 CPU.
>  	  Run equally well on all x86-64 CPUs.
>  
> +config GENERIC_CPU_V2
> +	bool "Generic-x86-64-v2"
> +	depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
> +	depends on X86_64
> +	help
> +	  Generic x86-64 CPU.
> +	  Run equally well on all x86-64 CPUs with min support of x86-64-v2.
> +
> +config GENERIC_CPU_V3
> +	bool "Generic-x86-64-v3"
> +	depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
> +	depends on X86_64
> +	help
> +	  Generic x86-64-v3 CPU with v3 instructions.
> +	  Run equally well on all x86-64 CPUs with min support of x86-64-v3.
> +
> +config GENERIC_CPU_V4
> +	bool "Generic-x86-64-v4"
> +	depends on ( CC_IS_GCC && GCC_VERSION > 110000 ) || ( CC_IS_CLANG && CLANG_VERSION >= 120000 )
> +	depends on X86_64
> +	help
> +	  Generic x86-64 CPU with v4 instructions.
> +	  Run equally well on all x86-64 CPUs with min support of x86-64-v4.

Every once in a while, patches like that pop up without any real numbers
advocating for the additional and perhaps unnecessary complexity.

If those -march switches don't bring any measureable improvements - and
I highly doubt they do - you shouldn't waste time with submitting them.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
