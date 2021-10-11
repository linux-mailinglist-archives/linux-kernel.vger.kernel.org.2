Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D8C428B93
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 12:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbhJKK6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 06:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:50032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236190AbhJKK6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 06:58:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 531E960EB4;
        Mon, 11 Oct 2021 10:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633949798;
        bh=g6eOo7baVMAlB8CHao6MjQMNqHLg/GMJHrwiPTDHLF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nzff+TeJVtKL5bG99c/4gakkFVrBi4fyyb1UDTPufBMS7ts3ifHfAzDqx9fKBOTBJ
         rPJ+p1Ohpf6SiCaC/V2xeqysamtwpAhf6V6Z/jgCBlrt3o5jLr+52KmWzzVZG539sX
         DuTElPR5ZyD+f6CWufUAVZQ93zAGA02mCH8+WxqKlR7xmkYp03/EK95NqYNQeIuYvZ
         WjytS8d+9Ogl2aITINBL2p0dClWVV9d8PUpCiQfI2LK1XQoyVmSrAjTn/H66s3i8c6
         XxXs6B5ocnx+TN+BqAWilrBzWaXv5RWhfHKTzHgdWTsjk1f9obRj6WpU5U0Q53cSqw
         ESe5RAOWnPHmw==
Date:   Mon, 11 Oct 2021 11:56:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Oliver Upton <oupton@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 14/17] arm64: Add a capability for FEAT_ECV
Message-ID: <20211011105629.GB4009@willie-the-truck>
References: <20211010114306.2910453-1-maz@kernel.org>
 <20211010114306.2910453-15-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010114306.2910453-15-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 12:43:03PM +0100, Marc Zyngier wrote:
> Add a new capability to detect the Enhanced Counter Virtualization
> feature (FEAT_ECV).
> 
> Reviewed-by: Oliver Upton <oupton@google.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 10 ++++++++++
>  arch/arm64/tools/cpucaps       |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index f8a3067d10c6..26b11ce8fff6 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1926,6 +1926,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.sign = FTR_UNSIGNED,
>  		.min_field_value = 1,
>  	},
> +	{
> +		.desc = "Enhanced Counter Virtualization",
> +		.capability = ARM64_HAS_ECV,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_cpuid_feature,
> +		.sys_reg = SYS_ID_AA64MMFR0_EL1,
> +		.field_pos = ID_AA64MMFR0_ECV_SHIFT,
> +		.sign = FTR_UNSIGNED,
> +		.min_field_value = 1,
> +	},
>  #ifdef CONFIG_ARM64_PAN
>  	{
>  		.desc = "Privileged Access Never",
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 49305c2e6dfd..7a7c58acd8f0 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -18,6 +18,7 @@ HAS_CRC32
>  HAS_DCPODP
>  HAS_DCPOP
>  HAS_E0PD
> +HAS_ECV
>  HAS_EPAN
>  HAS_GENERIC_AUTH
>  HAS_GENERIC_AUTH_ARCH

We should also make the ECV field FTR_VISIBLE.

Will
