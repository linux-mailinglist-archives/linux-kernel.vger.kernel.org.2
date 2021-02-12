Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6857B319CB8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhBLKfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbhBLKft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:35:49 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BBCC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 02:35:09 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v1so3688302wrd.6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 02:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7Gz9jl63o2edkN9qH3Y2O4sqeUvPnz0Ltm6N36wNoo=;
        b=zn1rT1Xa/zUwRGatySbKhKS/fDbEet5U/VjM87shNphivAP6fjdzz3U6ARoGo/Snex
         RBwDURv6OUZbbVCW65a98dY0KPAM8+0U3JQjxTXoGIp3aN+/BO1ejjaoT9A75Z/KSUCs
         obRH3+BmRHnwL+NbF5nbBcmItOw127+LNSLUNCutqmLbdYhbpzf/4k3lYtTx8S2z65cW
         ZIYpgw+kPFq8EcN4K2XwqOL/wYLjQgLngHpEt6IcXbfiUC3EysnTCXgTN4HlkRhKGKwx
         8py330zBvZlz7STlkuWSzJvxisORhSeT5n8vtBwLhww61nJ7/qCjeMQ719rmkiNIlGc6
         U9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7Gz9jl63o2edkN9qH3Y2O4sqeUvPnz0Ltm6N36wNoo=;
        b=Dg98hhgQjVXGP4qDukKML7cvHqU8htk3VWl6dUSNkcbqyprw8gWjlrLtc2ZZ63bx7+
         f/zLodwMo3u7dcpRyO8AlffdFhGAPhxFwhJjwWRL9rmnQPxL8L7OoZTEOEN6QnABfPga
         roD4/SByr87hrJo5Cez+bichZGZ6o6+58vhNVMKKuYbT/zzzTznj6zo28ACokwTQikD5
         UEL+GMO/139Jes2G5jeDmclkbEhRxETmdS/fJC+60M9MnV6LRjmWqYhZgOVvxJsg+Rlk
         ij4hyweIyEfWsZ3hvbgsud1dLfB1qvuKgq4m+KO/h6EBoXmy0ncRKy8w8JoXDMGVMwUG
         qLFA==
X-Gm-Message-State: AOAM5313y3iQzu97l97GoJ7tnWiYh4yBtDiZWEfMW5L/C2f7iBpbibVU
        AH+FOG9CYTOamN31Z1ElAE/4WY24G6hHZPKva4xQ7A==
X-Google-Smtp-Source: ABdhPJwThiBlWDZD5d7pQvReYTBTOTblo4VhVEQiK+qcAKJUnw6CZY8vWbpW0fFW3tTmdJpxTMG6emW1CFJ0DWgQJg0=
X-Received: by 2002:adf:dcc2:: with SMTP id x2mr2552539wrm.178.1613126108301;
 Fri, 12 Feb 2021 02:35:08 -0800 (PST)
MIME-Version: 1.0
References: <20210110224850.1880240-1-suzuki.poulose@arm.com> <20210110224850.1880240-29-suzuki.poulose@arm.com>
In-Reply-To: <20210110224850.1880240-29-suzuki.poulose@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 12 Feb 2021 10:34:57 +0000
Message-ID: <CAJ9a7ViwNA__+5f7-DehM6OtGer3DjdZfWsgHc9EOcr5-vQXgA@mail.gmail.com>
Subject: Re: [PATCH v7 28/28] coresight: Add support for v8.4 SelfHosted tracing
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Zhou <jonathan.zhouwen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu, Suzuki,

Sorry for the really late response on this patch, but I noticed a
problem while doing a review of the ETE / TRBE set. (TRBE specs
mention TRFCR_ELx, so I was confirming a couple of things).

On Sun, 10 Jan 2021 at 22:49, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> From: Jonathan Zhou <jonathan.zhouwen@huawei.com>
>
> v8.4 tracing extensions added support for trace filtering controlled
> by TRFCR_ELx. This must be programmed to allow tracing at EL1/EL2 and
> EL0. The timestamp used is the virtual time. Also enable CONTEXIDR_EL2
> tracing if we are running the kernel at EL2.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Will Deacon <will@kernel.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
> [ Move the trace filtering setup etm_init_arch_data() and
>  clean ups]
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../coresight/coresight-etm4x-core.c          | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 3d3165dd09d4..18c1a80abab8 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -859,6 +859,30 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
>         return false;
>  }
>
> +static void cpu_enable_tracing(void)
> +{
> +       u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
> +       u64 trfcr;
> +
> +       if (!cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRACE_FILT_SHIFT))
> +               return;
> +
> +       /*
> +        * If the CPU supports v8.4 SelfHosted Tracing, enable
> +        * tracing at the kernel EL and EL0, forcing to use the
> +        * virtual time as the timestamp.
> +        */
> +       trfcr = (TRFCR_ELx_TS_VIRTUAL |
> +                TRFCR_ELx_ExTRE |
> +                TRFCR_ELx_E0TRE);
> +
> +       /* If we are running at EL2, allow tracing the CONTEXTIDR_EL2. */
> +       if (is_kernel_in_hyp_mode())
> +               trfcr |= TRFCR_EL2_CX;
> +

This is wrong - CX bit is present on TRFCR_EL2, not TRFCR_EL1.
Moreover, TRFCR_EL2 has a separate enables for tracing at EL0 and EL2.

Secondly - is this correct in principal?  Should the driver not be
reading the access it is permitted by the kernel, rather than giving
itself unfettered access to trace where it wants to.
Surely TRFCR_ELx  levels should be chosen in KConfig  and then should
be set up in kernel initialisation?

Regards

Mike



> +       write_sysreg_s(trfcr, SYS_TRFCR_EL1);
> +}
> +
>  static void etm4_init_arch_data(void *info)
>  {
>         u32 etmidr0;
> @@ -1044,6 +1068,7 @@ static void etm4_init_arch_data(void *info)
>         /* NUMCNTR, bits[30:28] number of counters available for tracing */
>         drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
>         etm4_cs_lock(drvdata, csa);
> +       cpu_enable_tracing();
>  }
>
>  static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
> --
> 2.24.1
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
