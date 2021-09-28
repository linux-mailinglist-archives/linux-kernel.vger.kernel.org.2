Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FA041B375
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbhI1QEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:04:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53929 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbhI1QEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:04:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5296DF42F;
        Tue, 28 Sep 2021 12:02:55 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=4bMrkmufLiQqbAD1pzxtLKc7Xm2QXqXXrC6POt
        E4iUI=; b=BMHo6YdQv9IC0ETzCDkW52HY/40nCzu3F0DbX0M6Fk7bUKCZpl644y
        Wn3Fu4UEMXmD6awsFWiveDmFKa9cygsxdD65KmUFUI1Fq/vVe2CHeWAMlU1SyWoN
        KusuQg+yxXKp9lWpJQhDcEWHxxzQ/5XTvoy1W98MjIyyvjlOtEhSs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA7C7DF42C;
        Tue, 28 Sep 2021 12:02:55 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=4bMrkmufLiQqbAD1pzxtLKc7Xm2QXqXXrC6POtE4iUI=; b=egrd5wPIzSwp4hqzxwpKTlca22zszwfK3BNI+f60YZjGo9b8hVlEOi9Ty0JbVcLZCunJz1WdSNt9Y7p69/dgCNC0n6ZPYkIF2rcybOnYXxVKUkvvtPXqUz1TYnJ1e7hwf8TDWDYibYA0VfM4JI15HZ8/hyOh6wSvLFyXcQVC37c=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 12920DF42B;
        Tue, 28 Sep 2021 12:02:55 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 154692DA0083;
        Tue, 28 Sep 2021 12:02:54 -0400 (EDT)
Date:   Tue, 28 Sep 2021 12:02:53 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 12/14] ARM: add CONFIG_PHYS_OFFSET default values
In-Reply-To: <20210928154143.2106903-13-arnd@kernel.org>
Message-ID: <5n4on6-8483-3417-1r59-86no56q082p1@syhkavp.arg>
References: <20210928154143.2106903-1-arnd@kernel.org> <20210928154143.2106903-13-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 8AA52D24-2075-11EC-81F6-62A2C8D8090B-78420484!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> For platforms that are not yet converted to ARCH_MULTIPLATFORM,
> we can disable CONFIG_ARM_PATCH_PHYS_VIRT, which in turn requires
> setting a correct address here.
> 
> As we actualy know what all the values are supposed to be based
> on the old mach/memory.h header file contents (from git history),
> we can just add them here.
> 
> This also solves a problem in Kconfig where 'make randconfig'
> fails to continue if no number is selected for a 'hex' option.
> Users can still override the number at configuration time, e.g.
> when the memory visible to the kernel starts at a nonstandard
> address on some machine, but it should no longer be required
> now.
> 
> I originally posted this back in 2016, but the problem still
> persists. The patch has gotten much simpler though, as almost
> all platforms rely on ARM_PATCH_PHYS_VIRT now.
> 
> Acked-by: Nicolas Pitre <nico@linaro.org>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> Link: https://lore.kernel.org/linux-arm-kernel/1455804123-2526139-5-git-send-email-arnd@arndb.de/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/Kconfig | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 12a0bd4b315d..0d4f3e2d50ad 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -264,10 +264,12 @@ config PHYS_OFFSET
>  	hex "Physical address of main memory" if MMU
>  	depends on !ARM_PATCH_PHYS_VIRT
>  	default DRAM_BASE if !MMU
> -	default 0x00000000 if ARCH_FOOTBRIDGE
> +	default 0x00000000 if ARCH_FOOTBRIDGE || ARCH_IXP4XX
>  	default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
> -	default 0x20000000 if ARCH_S5PV210
> -	default 0xc0000000 if ARCH_SA1100
> +	default 0x30000000 if ARCH_S3C24XX
> +	default 0xa0000000 if ARCH_IOP32X || ARCH_PXA
> +	default 0xc0000000 if ARCH_EP93XX || ARCH_SA1100
> +	default 0
>  	help
>  	  Please provide the physical address corresponding to the
>  	  location of main memory in your system.
> -- 
> 2.29.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
