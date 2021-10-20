Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039AC434646
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhJTH4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 03:56:16 -0400
Received: from foss.arm.com ([217.140.110.172]:57112 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhJTH4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 03:56:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 218D0ED1;
        Wed, 20 Oct 2021 00:54:01 -0700 (PDT)
Received: from [192.168.1.131] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E64F3F70D;
        Wed, 20 Oct 2021 00:53:58 -0700 (PDT)
Subject: Re: [PATCH v2 3/4] arm64: vdso32: suppress error message for 'make
 mrproper'
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Lucas Henneman <henneman@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
References: <20211019223646.1146945-1-ndesaulniers@google.com>
 <20211019223646.1146945-4-ndesaulniers@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <145cec53-b20b-bdf2-1209-eb457aa72f44@arm.com>
Date:   Wed, 20 Oct 2021 09:54:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211019223646.1146945-4-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/20/21 12:36 AM, Nick Desaulniers wrote:
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
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

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
> 

-- 
Regards,
Vincenzo
