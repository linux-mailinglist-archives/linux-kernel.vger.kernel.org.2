Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED4BC3E49CD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhHIQbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhHIQbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:31:19 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA960C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:30:58 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z2so18378575lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4VkPv3ijvSTRJOo9NDpocwpDrWuB20oSTHeZq/+JtY4=;
        b=iKxkoaL4kXVhoJaIu2txEDqyx63rLwuewv97sgvO1NvLABlJvzMEzcQHX8m24fF8lu
         MNqtTTYQ+qGttrYrZTrcwvePD0uE+OWxHK3M1k0eOEbg1w47J9We9QbFreNKNqt85Jzb
         pZFkqcpoLP2XQorJWRxzcU7dDzUUe8izELraOhOBARFbGt1wDLCTMANOWT+01qIvjXDf
         HZ1lDthuJDOHLo5E9jKEJW3xc5YL+zya9Mn8C2s4eaiyPVU6sCgZNxuSklUkFc+ds62C
         pXBQfFpL44dfqrxiztM8ObkmRzBEqi0LFvcAQ/hX9k5q9N0vge5xDaHfPktR9QT5/3mw
         J7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4VkPv3ijvSTRJOo9NDpocwpDrWuB20oSTHeZq/+JtY4=;
        b=JqJJZDpfaIOfPAZYoImDrg3kdAKsOLAXzeamMpCCpFNn7q7yj0HMIOG3/DUF9FOtJ3
         5nJTQh8993iXx3Zx9yCEbNA12BIcx7yw5JqgSu9iRhLdscoKOCw6hJyDyQLMOF82yrOy
         Z7ai3B6eTkgIb0B5Hf8wi77eqFQlYYO4RQQHbw7XhE6h6tuFtT9nlPeWMFWMRgya3uY3
         lou0IiogAaTyxFK5/HxGheS9oqfMIv+zd5cl9eHXYyjh55+RKOTbYADePO6sRMv5Vw8H
         nQEbzdnOYj1e60ZtlWpCl4aWLOhsIcmUNLFagA/BM6ypidHuZq3/1AQmLoHIwDXkeKdz
         jcWg==
X-Gm-Message-State: AOAM531Hx85VBoe9187ifEGGo6CpOxrgR65oHzVHDp4PKmAGlaVZ35qI
        nW80SEziIZM1/B+1AAzQp+4jUYQ4UyW+yDut8MiN+Q==
X-Google-Smtp-Source: ABdhPJzdL4ytuaQijALokAIa5Yk3f3euwhiuT27Zmii54Gn8/sNlSJY2a5P8w23L7LK5NBvmjW5aUeuHvVn5cD6M3nM=
X-Received: by 2002:ac2:5fc7:: with SMTP id q7mr17406150lfg.524.1628526656761;
 Mon, 09 Aug 2021 09:30:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-13-maz@kernel.org>
In-Reply-To: <20210809152651.2297337-13-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 9 Aug 2021 09:30:45 -0700
Message-ID: <CAOQ_QsjT8DUoXQsxWGgGiZkwNe2itRswGomtq6-p+7_oU01orQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] arm64: Add a capability for FEAT_EVC
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Mon, Aug 9, 2021 at 8:48 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Add a new capability to detect the Enhanced Counter Virtualization
> feature (FEAT_EVC).
>

s/FEAT_EVC/FEAT_ECV/g

> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/kernel/cpufeature.c | 10 ++++++++++
>  arch/arm64/tools/cpucaps       |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 0ead8bfedf20..9c2ce5408811 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1899,6 +1899,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>                 .sign = FTR_UNSIGNED,
>                 .min_field_value = 1,
>         },
> +       {
> +               .desc = "Enhanced counter virtualization",
> +               .capability = ARM64_HAS_ECV,
> +               .type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +               .matches = has_cpuid_feature,
> +               .sys_reg = SYS_ID_AA64MMFR0_EL1,
> +               .field_pos = ID_AA64MMFR0_ECV_SHIFT,
> +               .sign = FTR_UNSIGNED,
> +               .min_field_value = 1,
> +       },

Per one of your other patches in the series, it sounds like userspace
access to the self-synchronized registers hasn't been settled yet.
However, if/when available to userspace, should this cpufeature map to
an ELF HWCAP?

Also, w.r.t. my series I have out for ECV in KVM. All the controls
used in EL2 depend on ECV=0x2. I agree that ECV=0x1 needs a cpufeature
bit, but what about EL2's use case?

Besides the typo:

Reviewed-by: Oliver Upton <oupton@google.com>

--
Thanks,
Oliver

>  #ifdef CONFIG_ARM64_PAN
>         {
>                 .desc = "Privileged Access Never",
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
> --
> 2.30.2
>
