Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 274543120EE
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 03:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBGCb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 21:31:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:37248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhBGCbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 21:31:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CF4264E8C;
        Sun,  7 Feb 2021 02:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612665043;
        bh=IzYeZSry0qXTzjT2UN+6iWEQJbFKYdFQv0CID8sfJP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KTo8rm0rUEs4PkiNtiEDrp7e46mzt4rKMvVYBTMAfI+KHFCpg90Fj/RQrVNKtj743
         TCUcYOr8yRlgrNKohl7iqcYa+DiY1gXJMPouSJIOJdIUEyo32AFwr+LOYoDInP1FM+
         99EJ6C3uSvKFUBVqhZZbL3pWEAHoXhoR8PDlDU3aFwBJxcV2nNCxviifi3Y807KzVy
         O0BwonNqz1YptUN5zsS33kKY842JsIoU/UTcGtNEOet/crs27jBowMoHdI9WduGmEu
         9eGi763RN0w/2LUoNqCg9BUQ852ba66E/uNotTKAKUHk/JXIEmZSUDNotYZGQ5O3OX
         tWLCFCL9MNMCw==
Date:   Sat, 6 Feb 2021 19:30:41 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: Make CPU_BIG_ENDIAN depend on !LD_IS_LLD
Message-ID: <20210207023041.GA655027@ubuntu-m3-large-x86>
References: <20210202022441.1451389-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202022441.1451389-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 07:24:42PM -0700, Nathan Chancellor wrote:
> Similar to commit 28187dc8ebd9 ("ARM: 9025/1: Kconfig: CPU_BIG_ENDIAN
> depends on !LD_IS_LLD"), ld.lld does not support aarch64 big endian,
> leading to the following build error when CONFIG_CPU_BIG_ENDIAN is
> selected:
> 
> ld.lld: error: unknown emulation: aarch64linuxb
> 
> There are not currently plans to implement big endian support for
> aarch64 in ld.lld but if it should be supported in the future, this
> symbol can depend on the version that first supports it. In the
> meantime, prevent this symbol from being selected to avoid these type
> of build errors.
> 
> While we are here, the indentation of this symbol used spaces since its
> introduction in commit a872013d6d03 ("arm64: kconfig: allow
> CPU_BIG_ENDIAN to be selected"). Change it to tabs to be consistent with
> kernel coding style.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/380
> Link: https://github.com/ClangBuiltLinux/linux/issues/1288
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Fangrui has pushed proper aarch64linuxb and elf64-bigaarch64 for ld.lld:

https://reviews.llvm.org/D96211
https://reviews.llvm.org/D96188

This patch is needed for OUTPUT_FORMAT in the vDSO to work properly:

https://reviews.llvm.org/D96214

Once these are all merged into LLVM 13, I will update this to be:

depends on !LD_IS_LLD || LLD_VERSION >= 130000

Cheers,
Nathan

> ---
>  arch/arm64/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f39568b28ec1..5ddf9fe7b4ee 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -952,8 +952,9 @@ choice
>  	  that is selected here.
>  
>  config CPU_BIG_ENDIAN
> -       bool "Build big-endian kernel"
> -       help
> +	bool "Build big-endian kernel"
> +	depends on !LD_IS_LLD
> +	help
>  	  Say Y if you plan on running a kernel with a big-endian userspace.
>  
>  config CPU_LITTLE_ENDIAN
> 
> base-commit: 88bb507a74ea7d75fa49edd421eaa710a7d80598
> -- 
> 2.30.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
