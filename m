Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15D73378E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbhCKQLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:11:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:50348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234443AbhCKQLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:11:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9B2464FA3;
        Thu, 11 Mar 2021 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615479095;
        bh=E87K7pnoXEeIDrTmeoC6YBHh9dve+IPi3cHQxxCc+48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4nQkqHdL2JuiHy0v2ICafmTOqoiN8+zS4zbPAFePc4r1RMXoTJGboIAYvQZfEPBF
         GASa0lX9rDFbjdV/u9cqZYMIfoNOCbLZtk5qU9ZXXBK88F9pjPW5AaudDHtLSMCwAK
         UaCYzk52WXL9ew+/ibFLCtNCEoxbKtXA8hLTLaHKBz0VYcIBOLhKVG/yDso31B+O3a
         kg08E5Shw0uyYbCKengLJSNL8r9DwTPM+BhQI9l/Avm9I16E4tw+u/FbILg0EGqcOZ
         ZhHS/8FgummcqWjQ+ZKJoYyJ9/JRTfmt/XT0iRGrGFYfvcz9ARI3R119VVk1wpNUE2
         /M+7wLuvdDMlQ==
Date:   Thu, 11 Mar 2021 16:11:28 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 11/34] KVM: arm64: Stub CONFIG_DEBUG_LIST at Hyp
Message-ID: <20210311161127.GB31206@willie-the-truck>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-12-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210310175751.3320106-12-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 05:57:28PM +0000, Quentin Perret wrote:
> In order to use the kernel list library at EL2, introduce stubs for the
> CONFIG_DEBUG_LIST out-of-lines calls.
> 
> Signed-off-by: Quentin Perret <qperret@google.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/Makefile |  2 +-
>  arch/arm64/kvm/hyp/nvhe/stub.c   | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/kvm/hyp/nvhe/stub.c
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> index 24ff99e2eac5..144da72ad510 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -13,7 +13,7 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
>  lib-objs := $(addprefix ../../../lib/, $(lib-objs))
>  
>  obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
> -	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o
> +	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o
>  obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
>  	 ../fpsimd.o ../hyp-entry.o ../exception.o
>  obj-y += $(lib-objs)
> diff --git a/arch/arm64/kvm/hyp/nvhe/stub.c b/arch/arm64/kvm/hyp/nvhe/stub.c
> new file mode 100644
> index 000000000000..c0aa6bbfd79d
> --- /dev/null
> +++ b/arch/arm64/kvm/hyp/nvhe/stub.c
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Stubs for out-of-line function calls caused by re-using kernel
> + * infrastructure at EL2.
> + *
> + * Copyright (C) 2020 - Google LLC
> + */
> +
> +#include <linux/list.h>
> +
> +#ifdef CONFIG_DEBUG_LIST
> +bool __list_add_valid(struct list_head *new, struct list_head *prev,
> +		      struct list_head *next)
> +{
> +		return true;
> +}
> +
> +bool __list_del_entry_valid(struct list_head *entry)
> +{
> +		return true;
> +}
> +#endif

This isn't any worse than disabling DEBUG_LIST for the EL2 object, so as
an initial implementation:

Acked-by: Will Deacon <will@kernel.org>

but we really should have the debug list checks on (probably
unconditionally) for the EL2 code in my opinion.

Will
