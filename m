Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38C4342A6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 02:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhJTAw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 20:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhJTAw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 20:52:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 401A960F44;
        Wed, 20 Oct 2021 00:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634691015;
        bh=cOeWhoeUDvU0/o6OPXU3xhOyMuNbiH62/GnL+jUSlTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jX+KFrUb0Q0KEijK4YJyHG0XsyFnXr5tT1K8hXsuXR203vHOOVwNPpM5xTOJsW0AY
         zDbhZqK8IxnwzzuC4uI/v0kZPGZlGlgKTLlCosHnl8U+VN8IxTw6tQF2D+RmGx/q6I
         qcThK0l/yq6r/klsqeNRpzLDMYliM4D4JK2GK86wY3kCVv6M9CYAJGGa9wVgHnRXvJ
         oQyoCDs7BxtKxsW4M4bgX1UPURLg7WXVddWFZP/YGchHYkIyVUjf1aXIQZUmYCZ5lW
         US3q+VV7lqP1ZmcPyL6ktyXC4pcPvPXrh9hBC7MfqMZ2qYOxi2jzBQH98uvQZqyKH0
         R0CzM5BGB4OCQ==
Date:   Tue, 19 Oct 2021 17:50:09 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Lucas Henneman <henneman@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 3/4] arm64: vdso32: suppress error message for 'make
 mrproper'
Message-ID: <YW9nwT2m7Ft30BSm@archlinux-ax161>
References: <20211019223646.1146945-1-ndesaulniers@google.com>
 <20211019223646.1146945-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019223646.1146945-4-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 03:36:45PM -0700, Nick Desaulniers wrote:
> When running the following command without arm-linux-gnueabi-gcc in
> one's $PATH, the following warning is observed:
> 
> $ ARCH=arm64 CROSS_COMPILE_COMPAT=arm-linux-gnueabi- make -j72 LLVM=1 mrproper
> make[1]: arm-linux-gnueabi-gcc: No such file or directory
> 
> This is because KCONFIG is not run for mrproper, so CONFIG_CC_IS_CLANG
> is not set, and we end up eagerly evaluating various variables that try
> to invoke CC_COMPAT.
> 
> This is a similar problem to what was observed in
> commit dc960bfeedb0 ("h8300: suppress error messages for 'make clean'")
> 
> Reported-by: Lucas Henneman <henneman@google.com>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> Changes v1 -> v2:
> * Change to suppressing via redirecting stderr to /dev/null, as per
>   Masahiro.
> * Add Masahiro's SB tag.
> * Cite dc960bfeedb0.
> 
>  arch/arm64/kernel/vdso32/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
> index 1407516e041e..e478cebb9891 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -38,7 +38,8 @@ cc32-disable-warning = $(call try-run,\
>  # As a result we set our own flags here.
>  
>  # KBUILD_CPPFLAGS and NOSTDINC_FLAGS from top-level Makefile
> -VDSO_CPPFLAGS := -DBUILD_VDSO -D__KERNEL__ -nostdinc -isystem $(shell $(CC_COMPAT) -print-file-name=include)
> +VDSO_CPPFLAGS := -DBUILD_VDSO -D__KERNEL__ -nostdinc
> +VDSO_CPPFLAGS += -isystem $(shell $(CC_COMPAT) -print-file-name=include 2>/dev/null)
>  VDSO_CPPFLAGS += $(LINUXINCLUDE)
>  
>  # Common C and assembly flags
> -- 
> 2.33.0.1079.g6e70778dc9-goog
> 
> 
