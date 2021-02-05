Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A1531128D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 21:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhBESwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:52:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:45584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233090AbhBEPEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:04:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5406D64EA1;
        Fri,  5 Feb 2021 16:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612542928;
        bh=u1co/FGUat5HAI0yiGhQV5noHY+wEidod999P0y8ViM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MsQqI2OprR5K8XBTnraMicQl74H5xko+0MMnyykPyvgI9YrKYFCMFR/RtXsed/BzW
         SXFgRKhNWXw95Eottebxi8Ys+xK+Un6T+rySi2SADXZkfJ17awPDHIum6UkEx2KPyt
         XV38tn5MTx/hI14KD2VQ115CqZ7ZM2O2BQ1UiGxg+303PJncao1khjzgecRuAD1s0f
         w9zp6SkM4B3keN4/XtsmmrgzhZskd8LXV9Q8Zd+8dHU6iH7Ec1kTLjBWKr7z0BQ/GK
         4nKiMN7r+Yx8pK2Frh3LJSDnqhawCmXJAYzb/UUg8EqSneIZQtgoo4ywTiFGPX89WF
         lbdNOWOrgjWlw==
Date:   Fri, 5 Feb 2021 16:35:21 +0000
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v6 12/21] arm64: cpufeature: Add an early command-line
 cpufeature override facility
Message-ID: <20210205163521.GA22665@willie-the-truck>
References: <20210201115637.3123740-1-maz@kernel.org>
 <20210201115637.3123740-13-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201115637.3123740-13-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 11:56:28AM +0000, Marc Zyngier wrote:
> In order to be able to override CPU features at boot time,
> let's add a command line parser that matches options of the
> form "cpureg.feature=value", and store the corresponding
> value into the override val/mask pair.
> 
> No features are currently defined, so no expected change in
> functionality.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Acked-by: David Brazdil <dbrazdil@google.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>  arch/arm64/kernel/Makefile         |   2 +-
>  arch/arm64/kernel/head.S           |   1 +
>  arch/arm64/kernel/idreg-override.c | 164 +++++++++++++++++++++++++++++
>  3 files changed, 166 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kernel/idreg-override.c
> 
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 86364ab6f13f..2262f0392857 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -17,7 +17,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
>  			   return_address.o cpuinfo.o cpu_errata.o		\
>  			   cpufeature.o alternative.o cacheinfo.o		\
>  			   smp.o smp_spin_table.o topology.o smccc-call.o	\
> -			   syscall.o proton-pack.o
> +			   syscall.o proton-pack.o idreg-override.o
>  
>  targets			+= efi-entry.o
>  
> diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> index d74e5f84042e..3243e3ae9bd8 100644
> --- a/arch/arm64/kernel/head.S
> +++ b/arch/arm64/kernel/head.S
> @@ -435,6 +435,7 @@ SYM_FUNC_START_LOCAL(__primary_switched)
>  
>  	mov	x0, x21				// pass FDT address in x0
>  	bl	early_fdt_map			// Try mapping the FDT early
> +	bl	init_feature_override
>  	bl	switch_to_vhe
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>  	bl	kasan_early_init
> diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> new file mode 100644
> index 000000000000..d8d0d3b25bc3
> --- /dev/null
> +++ b/arch/arm64/kernel/idreg-override.c
> @@ -0,0 +1,164 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Early cpufeature override framework
> + *
> + * Copyright (C) 2020 Google LLC
> + * Author: Marc Zyngier <maz@kernel.org>
> + */
> +
> +#include <linux/ctype.h>
> +#include <linux/kernel.h>
> +#include <linux/libfdt.h>
> +
> +#include <asm/cacheflush.h>
> +#include <asm/setup.h>
> +
> +#define FTR_DESC_NAME_LEN	20
> +#define FTR_DESC_FIELD_LEN	10
> +
> +struct ftr_set_desc {
> +	char 				name[FTR_DESC_NAME_LEN];
> +	struct arm64_ftr_override	*override;
> +	struct {
> +		char			name[FTR_DESC_FIELD_LEN];
> +		u8			shift;
> +	} 				fields[];
> +};
> +
> +static const struct ftr_set_desc * const regs[] __initconst = {
> +};
> +
> +static char *cmdline_contains_option(const char *cmdline, const char *option)
> +{
> +	char *str = strstr(cmdline, option);
> +
> +	if ((str == cmdline || (str > cmdline && isspace(*(str - 1)))))
> +		return str;
> +
> +	return NULL;
> +}
> +
> +static int __init find_field(const char *cmdline,
> +			     const struct ftr_set_desc *reg, int f, u64 *v)
> +{
> +	char opt[FTR_DESC_NAME_LEN + FTR_DESC_FIELD_LEN + 2], *str;
> +	size_t len;
> +
> +	snprintf(opt, ARRAY_SIZE(opt), "%s.%s=", reg->name, reg->fields[f].name);
> +
> +	str = cmdline_contains_option(cmdline, opt);
> +	if (!str)
> +		return -1;
> +
> +	str += strlen(opt);
> +	len = strcspn(str, " ");

I'm absolutely terrified of string parsing in C, but just wondering why you
only ignore literal spaces here. I _think_ the full-fat cmdline parsing uses
isspace() to delimit the options.

Would it be possible to reuse any of the logic over in parse_args() to avoid
having to roll this ourselves?

Will
