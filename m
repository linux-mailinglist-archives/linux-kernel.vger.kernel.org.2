Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6A03FD148
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 04:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241508AbhIACZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 22:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241408AbhIACZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 22:25:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7511260F90;
        Wed,  1 Sep 2021 02:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630463049;
        bh=INT2vR7GIr6vwYPaWAiUQpn7YO3MvTwIjqWsyiGOwDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DvHT2KRSgVWh8TzHVJcZJEKqvZzU2SX5f2TCn/wRf81qf/xi4mTf81CxroxBUtI9H
         1v/4dqpasz8G8ZjOfPL4H6Th3SnDLzQdQaXpH5lx2voTkrixRgWbwiB78pN6ypbxVB
         WY3Vuz5x87KgIBXQ/BesCU8Zljtrq+4wcCPPk8odB/MyAtSqanyeNQI1rzw/nzEav2
         vG7rubeoXdoN8AzQQkqDRXyObRpfO+sVQ4OB2jzesFxxJEmmqbKgfrZ7QnY8xrPI9C
         PeSvqc2F4S+Fb0hJOy06Zox3dW92WuRIfBARpcjAI6/OK6t+zYqWTEQ14iWsjNtN46
         vlfdCibhoEE1g==
Date:   Tue, 31 Aug 2021 19:24:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Maurizio Lombardi <mlombard@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
Subject: Re: [PATCH] x86/setup: Explicitly include acpi.h
Message-ID: <YS7kRKmWw33rVWF6@archlinux-ax161>
References: <20210901021510.1561219-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210901021510.1561219-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 07:15:11PM -0700, Nathan Chancellor wrote:
> After commit 342f43af70db ("iscsi_ibft: fix crash due to KASLR physical
> memory remapping"), certain configurations show the following errors:
> 
> arch/x86/kernel/setup.c: In function ‘setup_arch’:
> arch/x86/kernel/setup.c:916:13: error: implicit declaration of function ‘acpi_mps_check’ [-Werror=implicit-function-declaration]
>   916 |         if (acpi_mps_check()) {
>       |             ^~~~~~~~~~~~~~
> arch/x86/kernel/setup.c:1110:9: error: implicit declaration of function ‘acpi_table_upgrade’ [-Werror=implicit-function-declaration]
>  1110 |         acpi_table_upgrade();
>       |         ^~~~~~~~~~~~~~~~~~
> arch/x86/kernel/setup.c:1112:9: error: implicit declaration of function ‘acpi_boot_table_init’ [-Werror=implicit-function-declaration]
>  1112 |         acpi_boot_table_init();
>       |         ^~~~~~~~~~~~~~~~~~~~
> arch/x86/kernel/setup.c:1120:9: error: implicit declaration of function ‘early_acpi_boot_init’; did you mean ‘early_cpu_init’? [-Werror=implicit-function-declaration]
>  1120 |         early_acpi_boot_init();
>       |         ^~~~~~~~~~~~~~~~~~~~
>       |         early_cpu_init
> arch/x86/kernel/setup.c:1162:9: error: implicit declaration of function ‘acpi_boot_init’ [-Werror=implicit-function-declaration]
>  1162 |         acpi_boot_init();
>       |         ^~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
> 
> acpi.h was being implicitly included from iscsi_ibft.h in these
> configurations so the removal of that means these functions have no
> definition or declaration. Add acpi.h explicitly so there is no more
> error.
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
> 
> * No fixes tag as I doubt the mentioned commit is the root cause.
> 
> * The configuration was WSL2's, I did not drill down exactly which set
>   of configs triggers this but it is pretty obvious what is going on
>   here.

Actually, it reproduces with x86_64_defconfig so the configuration is
irrelevant. It looks like commit 12609013c43a ("x86/setup: Clean up the
header portion of setup.c") removed acpi.h, presumably because
iscsi_ibft.h included it but AFAIK, the kernel's policy has always been
to expliciltly include headers that are needed, rather than relying on
them being implicitly included.

If people care, I can resent with a fixes tag and calling out
x86_64_defconfig instead of the vague "certain configurations" but I do
not have a strong opinion personally.

>  arch/x86/kernel/setup.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 63b20536c8d2..79f164141116 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -5,6 +5,7 @@
>   * This file contains the setup_arch() code, which handles the architecture-dependent
>   * parts of early kernel initialization.
>   */
> +#include <linux/acpi.h>
>  #include <linux/console.h>
>  #include <linux/crash_dump.h>
>  #include <linux/dma-map-ops.h>
> 
> base-commit: 9e9fb7655ed585da8f468e29221f0ba194a5f613
> -- 
> 2.33.0
> 
