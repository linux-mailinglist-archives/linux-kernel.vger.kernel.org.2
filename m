Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731B63E2AC1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 14:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343734AbhHFMoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 08:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbhHFMoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 08:44:37 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E7FC061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 05:44:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id y7so766062ljp.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 05:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUGZghFDl11vs00dn1bBhuFfeam16nyG6Ia09ASLgZs=;
        b=Tn0SdedHjL8I2aKCvPSfOmnmBwXw8vTE0CtlDMTiP4CidYwjaChJwhKhyt2Qd/FO+g
         UNTviRBd+PWByGSsuafxHFown5psNKCm/aGF1y700SAnmIryqlYGfeTPOtTO2mYSZIKb
         ek5EmHa4RPVNeBM6k9n5y/HZ899fvQ0L8V9LhbwIIUvT+mtIF0iy0SgW9E57Gi61J8+Z
         AykVPNP/IsKcFYAhWji4xE2feOtFH2fQBVGywMA1R6DIoEdCmMMsbMCb/uOBNuvpAOtI
         xtn6vkB2vXZwQ7P9vfPQAB79eDq2LzRAcf9zaDbzA1VuIsg2d+rbf35/OkFCV5qeXbCm
         +68A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUGZghFDl11vs00dn1bBhuFfeam16nyG6Ia09ASLgZs=;
        b=tG0YW5Plqf2g+14hAWJjy+JBZr39IIPOuay8aL8YLfVTk88+X7aYmog9AAI6OxpSoh
         GnHYj7vLQ7R0aH6PyDLbFVNr60gZcj3dqz8WGq2Cak7iqVfmemxsLiohIXyVab7NyxD+
         ax6HVXd8mlArQEFyHpXK4ziXTSCfufaAeThztnKMhgkPbNkgUaKNldwG1go//JfLj70j
         KqZFHnJyUj8AkfUf57f1ItZ3sHidil8roda6dCPPzBjwxbLsgPorWRGOzPevmEhoQoEw
         rRJ1fZOy7gzmXMm1fBZVGQIsL47oJLBGICseK1zI/z1hjYr3tKNKs9M/sunjopCHyE8+
         5lwA==
X-Gm-Message-State: AOAM532sJKd+3/cpeBILTrXgpF+Wcru6orYrlHpP79nM5NUdnikRecbB
        7z1W7tiHaFmbtTIihcYmu0R9QXeXe3o1p34uEIU=
X-Google-Smtp-Source: ABdhPJyw9UQdg2wcTF6X6YqWYALeU15zPaIeekDTsntEglCxKQbhjNwgbNs8ElgLyi66gGTX5Dv7Dw2Okzt7g1N24y8=
X-Received: by 2002:a05:651c:b10:: with SMTP id b16mr6674355ljr.35.1628253858084;
 Fri, 06 Aug 2021 05:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210728135217.591173-1-suzuki.poulose@arm.com> <20210728135217.591173-8-suzuki.poulose@arm.com>
In-Reply-To: <20210728135217.591173-8-suzuki.poulose@arm.com>
From:   Linu Cherian <linuc.decode@gmail.com>
Date:   Fri, 6 Aug 2021 18:14:06 +0530
Message-ID: <CAAHhmWj=dTkobukjRYmdsP_BwmVwKQrcecH4=0kOjtgo8axVaQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] arm64: Add erratum detection for TRBE overwrite in
 FILL mode
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, maz@kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        catalin.marinas@arm.com, Coresight ML <coresight@lists.linaro.org>,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Wed, Jul 28, 2021 at 7:23 PM Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Arm Neoverse-N2 and the Cortex-A710 cores are affected
> by a CPU erratum where the TRBE will overwrite the trace buffer
> in FILL mode. The TRBE doesn't stop (as expected in FILL mode)
> when it reaches the limit and wraps to the base to continue
> writing upto 3 cache lines. This will overwrite any trace that
> was written previously.
>
> Add the Neoverse-N2 erratumi(#2139208) and Cortex-A710 erratum
> (#2119858) to the  detection logic.
>
> This will be used by the TRBE driver in later patches to work
> around the issue. The detection has been kept with the core
> arm64 errata framework list to make sure :
>   - We don't duplicate the framework in TRBE driver
>   - The errata detection is advertised like the rest
>     of the CPU errata.
>
> Note that the Kconfig entries will be added after we have added
> the work around in the TRBE driver, which depends on the cpucap
> from here.
>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm64/kernel/cpu_errata.c | 25 +++++++++++++++++++++++++
>  arch/arm64/tools/cpucaps       |  1 +
>  2 files changed, 26 insertions(+)
>
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index e2c20c036442..ccd757373f36 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -340,6 +340,18 @@ static const struct midr_range erratum_1463225[] = {
>  };
>  #endif
>
> +#ifdef CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
> +static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
> +#ifdef CONFIG_ARM64_ERRATUM_2139208
> +       MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
> +#endif
> +#ifdef CONFIG_ARM64_ERRATUM_2119858
> +       MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
> +#endif
> +       {},
> +};
> +#endif /* CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE */
> +
>  const struct arm64_cpu_capabilities arm64_errata[] = {
>  #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
>         {
> @@ -533,6 +545,19 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
>                 .capability = ARM64_WORKAROUND_NVIDIA_CARMEL_CNP,
>                 ERRATA_MIDR_ALL_VERSIONS(MIDR_NVIDIA_CARMEL),
>         },
> +#endif
> +#ifdef CONFIG_ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE
> +       {
> +               /*
> +                * The erratum work around is handled within the TRBE
> +                * driver and can be applied per-cpu. So, we can allow
> +                * a late CPU to come online with this erratum.
> +                */
> +               .desc = "ARM erratum 2119858 or 2139208",
> +               .capability = ARM64_WORKAROUND_TRBE_OVERWRITE_FILL_MODE,
> +               .type = ARM64_CPUCAP_WEAK_LOCAL_CPU_FEATURE,
> +               CAP_MIDR_RANGE_LIST(trbe_overwrite_fill_mode_cpus),
> +       },
>  #endif
>         {
>         }
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index 49305c2e6dfd..1ccb92165bd8 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -53,6 +53,7 @@ WORKAROUND_1418040
>  WORKAROUND_1463225
>  WORKAROUND_1508412
>  WORKAROUND_1542419
> +WORKAROUND_TRBE_OVERWRITE_FILL_MODE
>  WORKAROUND_CAVIUM_23154
>  WORKAROUND_CAVIUM_27456
>  WORKAROUND_CAVIUM_30115

We need to keep this list sorted ?

> --
> 2.24.1
>
> _______________________________________________
> CoreSight mailing list
> CoreSight@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/coresight
