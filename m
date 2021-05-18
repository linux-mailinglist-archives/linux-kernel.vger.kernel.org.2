Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E43881E6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 23:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236987AbhERVOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 17:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230166AbhERVOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 17:14:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDE79611BF;
        Tue, 18 May 2021 21:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621372378;
        bh=+XwfrEanFh4KN53uNfFPtVzdxotlHS4G0gMOF3X0WWU=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jW7Z5QSAQBCRP3CKw+PHGutOzM5iOK9y1tHxZ6wz9E3G9YwJphlNGn4YXcrY5VVvU
         /8G7pnwdxTS8Be9nMmIT4mMf34ma2lXxCrYCifz10pMNCgGPrbq1D3MafdTe0cD180
         thyhN50YhNCqhYek5zhBP7w5KqK9BRQO1b6/QgZFq14s/+WJxLlz1TEmrOYMw25STx
         lwQEf8oR297grjB9ipFruYyE0UgGB830qqXQR6kDeYYSpe/fXNMfZWPiSHYeeOqdeo
         AjjIYQxIbigYb/4UmQ1iZ1QJrJDC6hULdYEy7tg9dN72d4Km1cerHjsoJHVYejXtSB
         pFCddv1n/5rnw==
Subject: Re: [PATCH] powerpc: Kconfig: disable CONFIG_COMPAT for clang < 12
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Fangrui Song <maskray@google.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210518205858.2440344-1-ndesaulniers@google.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <fe638f4e-4dea-2f5e-2193-2f8b63aaf7a8@kernel.org>
Date:   Tue, 18 May 2021 14:12:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210518205858.2440344-1-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/2021 1:58 PM, Nick Desaulniers wrote:
> Until clang-12, clang would attempt to assemble 32b powerpc assembler in
> 64b emulation mode when using a 64b target triple with -m32, leading to
> errors during the build of the compat VDSO. Simply disable all of
> CONFIG_COMPAT; users should upgrade to the latest release of clang for
> proper support.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/1160
> Link: https://github.com/llvm/llvm-project/commits/2288319733cd5f525bf7e24dece08bfcf9d0ff9e
> Link: https://groups.google.com/g/clang-built-linux/c/ayNmi3HoNdY/m/XJAGj_G2AgAJ
> Suggested-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>   arch/powerpc/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index ce3f59531b51..2a02784b7ef0 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -289,6 +289,7 @@ config PANIC_TIMEOUT
>   config COMPAT
>   	bool "Enable support for 32bit binaries"
>   	depends on PPC64
> +	depends on !CC_IS_CLANG || CLANG_VERSION >= 120000
>   	default y if !CPU_LITTLE_ENDIAN
>   	select ARCH_WANT_OLD_COMPAT_IPC
>   	select COMPAT_OLD_SIGACTION
> 

