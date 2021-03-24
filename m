Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0612347FB2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbhCXRmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:42:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:57426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237296AbhCXRlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:41:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8049C61A19;
        Wed, 24 Mar 2021 17:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616607699;
        bh=htBRaBnyR28VLiCRvWJ8GrezsXw43e6rEl/CYh5JYlY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nC/39jKLJ2WW5B7Ht9uVjnTzS4IVBjlUt+qLupSoW7jSCpOj05mAKW0ze0wVvFBWh
         vVS+QvUq+zn9dM3FhPYf/Up4ZhUHuyUBQVWlzThEQMOlJy+EcN6HGvnaGgootoghSz
         2+MHZ1qSlpgjzcfFYw3kbqi+jQhg2VLHPbMyb4la362GqeeMRb3pgGhx7357zM5mwn
         OMzblv0IlYn2TKJdLwnKYhPFF3cBLeUAGX5mSE3zJ720qVJ1odPYLwdtT3s8xW9v9N
         WqA31GPfnwLfjtsOTQQFlq8wPk2kwJ02FUJ1L7ImzbC26d38IuELPv73g1oAmS2rtD
         LnJr8S0H59oJA==
Date:   Wed, 24 Mar 2021 10:41:35 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: move --fix-cortex-a53-843419 linker test to
 Kconfig
Message-ID: <20210324174135.umlsyuzjvspq5rdz@archlinux-ax161>
References: <20210324071128.1723273-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324071128.1723273-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 04:11:28PM +0900, Masahiro Yamada wrote:
> $(call ld-option, --fix-cortex-a53-843419) in arch/arm64/Makefile is
> evaluated every time even for Make targets that do not need the linker,
> such as "make ARCH=arm64 install".
> 
> Recently, the Kbuild tree queued up a patch to avoid needless
> compiler/linker flag evaluation. I beleive it is a good improvement
> itself, but causing a false-positive warning for arm64 installation
> in linux-next. (Thanks to Nathan for the report)
> 
> Kconfig can test the linker capability just once, and store it in the
> .config file. The build and installation steps that follow do not need
> to test the liniker over again.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Tested-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the quick fix!

> ---
> 
> I was not sure what the preferred CONFIG option name is.
> Please suggest a one if you have a better idea.
> 
> 
>  arch/arm64/Kconfig  | 3 +++
>  arch/arm64/Makefile | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 5656e7aacd69..4a33428de8ac 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -521,6 +521,9 @@ config ARM64_ERRATUM_843419
>  
>  	  If unsure, say Y.
>  
> +config ARM64_LD_HAS_FIX_ERRATUM_843419
> +	def_bool $(ld-option,--fix-cortex-a53-843419)
> +
>  config ARM64_ERRATUM_1024718
>  	bool "Cortex-A55: 1024718: Update of DBM/AP bits without break before make might result in incorrect update"
>  	default y
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 5b84aec31ed3..7ef44478560d 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -21,7 +21,7 @@ LDFLAGS_vmlinux		+= -shared -Bsymbolic -z notext \
>  endif
>  
>  ifeq ($(CONFIG_ARM64_ERRATUM_843419),y)
> -  ifeq ($(call ld-option, --fix-cortex-a53-843419),)
> +  ifneq ($(CONFIG_ARM64_LD_HAS_FIX_ERRATUM_843419),y)
>  $(warning ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum)
>    else
>  LDFLAGS_vmlinux	+= --fix-cortex-a53-843419
> -- 
> 2.27.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
