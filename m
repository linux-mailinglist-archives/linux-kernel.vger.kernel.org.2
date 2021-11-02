Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F4F4433BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbhKBQvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:51:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234806AbhKBQvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:51:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CE796112D;
        Tue,  2 Nov 2021 16:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635871713;
        bh=7ILamZGe9w+I3NxSwD0YsX5zvTJuLuPf8sWfHLzgVXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4q1/o678ZngzUTXAkN205OWRP72Ndz9WH/ZNZdVqxRSNVl6zOdjkD9xewDnfjWH9
         rAf9wIKqo4DuQoRO/AlOqrzaupc+jwSXduLWQvXbwnXefXdFPauzb3QFySrsQVfnhJ
         7BkqTbzl2p92Xw0AAebJCl+LgPq9Et8W4no7aNDtd/FtrvjsXWIQJAhJPT0B354S2D
         +gX92juzprvtkU1Ik7wOcaamGCD9KwWdeGkHCb8WPgeM3tnSS5YITDGd+XyCNN8nC6
         q3zJchHbwe1aZ0x0XkLOT0rXHPYRuCvAABBqwxPNnR3LlU2aLocqoK89cEfxLBvXDh
         A7bziBKyg4Fdw==
Date:   Tue, 2 Nov 2021 09:48:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andreas Schwab <schwab@suse.de>
Cc:     linux-riscv@lists.infradead.org,
        Saleem Abdulrasool <abdulras@google.com>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] riscv: fix building external modules
Message-ID: <YYFr3F89YWfUDJxm@archlinux-ax161>
References: <20210804173214.1027994-1-abdulras@google.com>
 <mvma6imr1ww.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mvma6imr1ww.fsf@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 04:51:43PM +0100, Andreas Schwab wrote:
> When building external modules, vdso_prepare should not be run.  If the
> kernel sources are read-only, it will fail.
> 
> Fixes: fde9c59aebaf ("riscv: explicitly use symbol offsets for VDSO")
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  arch/riscv/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 0eb4568fbd29..41f3a75fe2ec 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -108,11 +108,13 @@ PHONY += vdso_install
>  vdso_install:
>  	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso $@
>  
> +ifeq ($(KBUILD_EXTMOD),)
>  ifeq ($(CONFIG_MMU),y)
>  prepare: vdso_prepare
>  vdso_prepare: prepare0
>  	$(Q)$(MAKE) $(build)=arch/riscv/kernel/vdso include/generated/vdso-offsets.h
>  endif
> +endif
>  
>  ifneq ($(CONFIG_XIP_KERNEL),y)
>  ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_SOC_CANAAN),yy)
> -- 
> 2.33.1
> 
> 
> -- 
> Andreas Schwab, SUSE Labs, schwab@suse.de
> GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
> "And now for something completely different."
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
