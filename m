Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49FA30B00F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 20:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbhBATHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 14:07:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231790AbhBATHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 14:07:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9B0564E24;
        Mon,  1 Feb 2021 19:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612206386;
        bh=T3mY97qTIItV8Y42MPe/7OnIIOnipORNs8aCgjUcDfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IK3X+++h0B6P2DMotlKVBwgwm+p26fmU7HUAU1uWWJnmTH9dbm4S29ZapeAO/IFNX
         wXXumwIvhBuHTt6leVMXrHaCknYWtXpMFHEhuDPYwZ7e79REIoHIBrQW/N+2FahWAm
         lSWxcMm/v1ZRquJyuDh4jGkxa6FFsC48AjSU98APyloPdqkFwkJEX3GKC/Q+vYFaQ6
         RbG7juz//Uh5l4ZEU8tLTFZcuG20N6vCXc53cxkcTq0cm5NNyogSU9ubuxW6foC1YQ
         EvPVxGyBT8IqJVy0L4CVuODoaq4lbhgWoWWjl5x+XPghhXPMWqBgsNh7yFZDoFMkTc
         cV6HjB1xTMGFw==
Date:   Mon, 1 Feb 2021 19:06:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 11/26] KVM: arm64: Stub CONFIG_DEBUG_LIST at Hyp
Message-ID: <20210201190620.GJ15632@willie-the-truck>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-12-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108121524.656872-12-qperret@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 12:15:09PM +0000, Quentin Perret wrote:
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
> index 1fc0684a7678..33bd381d8f73 100644
> --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> @@ -10,7 +10,7 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
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

Can we get away with defining our own CHECK_DATA_CORRUPTION macro instead?

Will
