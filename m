Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0277541C984
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 18:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbhI2QGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 12:06:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345959AbhI2QFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 12:05:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B478661216;
        Wed, 29 Sep 2021 16:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632931415;
        bh=tVBtl4bvJzaWZY3bfdOBchZobhAPhzOL8sIz+i7XJ/E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gCGUsA9M4giYGYM9RT6s96W+L8ynk0J3ZtT6P6IEbu66qMBoxaGncPOo9lEBCCnFa
         Su7bSLS0hWBRVBxUx2J3r5yIHMLik9h27Plbs7+h0ohzB7KrzUilq2rka5iZGuQMwC
         sYWl2aSIezfDm8wwH8DNmWTCyMKy5j2jLubwZZBa7teAE+ZFQoqJ0SmYfqT7A+33Vi
         odVb/sQ8NvY3Zuv30pK/UkqRV/ATU7eyKvz4YETzL4qFpQIjPB39wIJ1SdBI7SFI74
         CXmidLPeP/E/RBpPqHjdpktiKjTy88MC07l89HWbhTL4oJ9K635F/F945WIg8tR5TW
         r4S0Zy50vBRyw==
Date:   Wed, 29 Sep 2021 17:03:30 +0100
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
Subject: Re: [PATCH v2 14/16] arm64: Add a capability for FEAT_ECV
Message-ID: <20210929160329.GE22029@willie-the-truck>
References: <20210922211941.2756270-1-maz@kernel.org>
 <20210922211941.2756270-15-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922211941.2756270-15-maz@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 10:19:39PM +0100, Marc Zyngier wrote:
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

Could we add a HWCAP for this and change the field to FTR_VISIBLE, please? I
know most users of the counter are indirected via the vDSO, but there are
some users out there using the counter directly and it would save them
having to probe via SIGILL if there was a hwcap available.

Cheers,

Will
