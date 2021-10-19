Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B220643344F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 13:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhJSLFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 07:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235319AbhJSLFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 07:05:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1DB8960241;
        Tue, 19 Oct 2021 11:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634641382;
        bh=ELLDNUa7AYT/pHZy7nOn4cGW1dErgUPv0UCQO5aCIRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mVDjPEtJobNVi24Khf35bYrflQP4ZlKdNmrkOac9gYqktk0U3go0hIis7CrMLoAI0
         bXqIaW6Serb7XymnaTHQmnVAevG+08HcxR3k53Jpx4cFZjxvJPXXExb8QYz9BIQu3b
         dv5qIPc3nehTkkHMAEDE3YRKf5Po3XLS3i8MJD6biV3kEDaH1AF8xBzwNksW3q4pTm
         9KsOjJAKgGqZlNUzHUQp5TSd0u25gcK0oWyg+4PIfjWGSqh4+JOhQc6Mi/5eXZJ0zu
         pLF1jh0zHAA0Qt0VuOE7Lfq5rwfOxtQ49q6W+h3/M4MH5fGiCcyBhZapDAdfsrlZGg
         7Phf7vcGmvbfQ==
Date:   Tue, 19 Oct 2021 12:02:34 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, maz@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 03/15] arm64: errata: Add workaround for TSB flush
 failures
Message-ID: <20211019110233.GD13251@willie-the-truck>
References: <20211014223125.2605031-1-suzuki.poulose@arm.com>
 <20211014223125.2605031-4-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014223125.2605031-4-suzuki.poulose@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 11:31:13PM +0100, Suzuki K Poulose wrote:
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index ccd757373f36..bdbeac75ead6 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -352,6 +352,18 @@ static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
>  };
>  #endif	/* CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE */
>  
> +#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE
> +static const struct midr_range tsb_flush_fail_cpus[] = {
> +#ifdef CONFIG_ARM64_ERRATUM_2067961
> +	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> +#endif
> +#ifdef CONFIG_ARM64_ERRATUM_2054223
> +	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
> +#endif
> +	{},
> +};
> +#endif	/* CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILURE */
> +
>  const struct arm64_cpu_capabilities arm64_errata[] = {
>  #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
>  	{
> @@ -558,6 +570,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>  		.type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
>  		CAP_MIDR_RANGE_LIST(trbe_overwrite_fill_mode_cpus),
>  	},
> +#endif
> +#ifdef CONFIG_ARM64_WORKAROUND_TSB_FLUSH_FAILRE

You still haven't fixed this typo...

Seriously, I get compile warnings from this -- are you not seeing them?

Will
