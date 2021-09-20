Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC37412AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 03:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhIUBp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 21:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhIUBlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:41:32 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1586C04CD1B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:58:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id eg28so43605717edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PC43tSgvhG7E0sEr+EdWjU4dUcDPCSX0FiAfZowtiZg=;
        b=nIMzEFRDbWw1z1g6+GhQbUl4DUvtylQpDP+jTHJoTenS8HI5r6M2ar3tFGhFvpuB9F
         QKXYIBNORPCzuiHLY0Ld/nyW4dWGSehFCuhVm4/g8RmFM5FHXd2YbKZ0ZWsZ6cjTQAAd
         rAeadVgIdfLtKpLv6nlbwU3BXfVWapw1JmfSgEVRKGbtNH3n+9mOlsTSffV7gW6rR8vl
         xqgtFQ70JnuH6tJCFZeN5B4s4aEyaXppka2q2ezEQUu6yee/X+ppufw0EYuEuEeXLtql
         9Fu+/Ttw3V4LZ+4ainPQa1WcvPUqJwVQdxIVp8zEDKfgATa9jJTmhHMY7ds0Fs4pA4f5
         h7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PC43tSgvhG7E0sEr+EdWjU4dUcDPCSX0FiAfZowtiZg=;
        b=Ab62gx47FGBx14T7mJ3xIyH1Slzrcyj9u9MIO8HI6qeDad84thOnlsxEUMEKtSXE2s
         vuW2uFD2a4sKjgp6IvU2Mf1K+nQGLcOTz6TMtN9jrpm7yNNA/rEOAhhQxzlNxZdubiVk
         f2qQ+P2RqjvDlcSiBkubmb7ejXPDGazgu/DJ6av61O7exR18Qx5AmUtdXAmLLOHbtYSl
         sQMB/1Iruex8XtRRccCOj/3QHClhRXSM+JYVSdZiQwniICzXlBp594jXyZv9oIvrHL4E
         DvRa0Y9TtV5U9URjHhyTezV16c+Ew3X1X+uTkqrcQHpaHvaJIQzf/kmJp0JR0Pj113M0
         mF0g==
X-Gm-Message-State: AOAM530erohXSBuBlCFIbcs49W7K7JW/HpUWPbSyzk/2cbAbo4IbghuP
        HB6VlJh6p6ZMjdOn34KIindcLKjcuw5ld9lcNR15grVLvUDq5w==
X-Google-Smtp-Source: ABdhPJx5e1g4BROAxqXoTN8Q7cw00CNUSRPKmEtwEG/MNdxn3PAjt/9c1I+re1VC08Eb6LibgwFMTXauNkekkW2yQRk=
X-Received: by 2002:a17:906:3a58:: with SMTP id a24mr17992046ejf.67.1632171491324;
 Mon, 20 Sep 2021 13:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210920190350.3860821-1-willmcvicker@google.com> <20210920190350.3860821-3-willmcvicker@google.com>
In-Reply-To: <20210920190350.3860821-3-willmcvicker@google.com>
From:   Will McVicker <willmcvicker@google.com>
Date:   Mon, 20 Sep 2021 13:57:55 -0700
Message-ID: <CABYd82YhCzLL8Bs0bMtC9cTFETtbKn8S1NXnP_254vHwzi4E3g@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] soc: samsung: change SOC_SAMSUNG default config logic
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 12:04 PM Will McVicker <willmcvicker@google.com> wrote:
>
> Switch the default logic to enable SOC_SAMSUNG and it's sub-configs to
> be enabled by default via "default y if ARCH_EXYNOS" versus being
> selected by the ARCH_EXYNOS config directly. This allows vendors to
> disable these configs if they wish and provides additional flexibility
> to modularize them in the presence of a generic kernel.
>
> There are no .config differences with this change. The configs
> SOC_SAMSUNG, EXYNOS_CHIPID, EXYNOS_PM_DOMAINS, and EXYNOS_PMU still
> remain enabled by default.
>
> Signed-off-by: Will McVicker <willmcvicker@google.com>
> ---
>  arch/arm64/Kconfig.platforms | 4 ----
>  drivers/soc/samsung/Kconfig  | 4 ++++
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 3a66ed43088d..6a006490c9b9 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -91,14 +91,10 @@ config ARCH_BRCMSTB
>
>  config ARCH_EXYNOS
>         bool "ARMv8 based Samsung Exynos SoC family"
> -       select EXYNOS_CHIPID
> -       select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
> -       select EXYNOS_PMU
>         select HAVE_S3C_RTC if RTC_CLASS
>         select PINCTRL
>         select PINCTRL_EXYNOS
>         select PM_GENERIC_DOMAINS if PM
> -       select SOC_SAMSUNG
>         help
>           This enables support for ARMv8 based Samsung Exynos SoC family.
>
> diff --git a/drivers/soc/samsung/Kconfig b/drivers/soc/samsung/Kconfig
> index 5745d7e5908e..9402c02bc9de 100644
> --- a/drivers/soc/samsung/Kconfig
> +++ b/drivers/soc/samsung/Kconfig
> @@ -4,6 +4,7 @@
>  #
>  menuconfig SOC_SAMSUNG
>         bool "Samsung SoC driver support" if COMPILE_TEST
> +       default y if ARCH_EXYNOS
>
>  if SOC_SAMSUNG
>
> @@ -15,6 +16,7 @@ config EXYNOS_ASV_ARM
>  config EXYNOS_CHIPID
>         bool "Exynos ChipID controller and ASV driver" if COMPILE_TEST
>         depends on ARCH_EXYNOS || COMPILE_TEST
> +       default y if ARCH_EXYNOS
>         select EXYNOS_ASV_ARM if ARM && ARCH_EXYNOS
>         select MFD_SYSCON
>         select SOC_BUS
> @@ -24,6 +26,7 @@ config EXYNOS_CHIPID
>  config EXYNOS_PMU
>         bool "Exynos PMU controller driver" if COMPILE_TEST
>         depends on ARCH_EXYNOS || ((ARM || ARM64) && COMPILE_TEST)
> +       default y if ARCH_EXYNOS
>         select EXYNOS_PMU_ARM_DRIVERS if ARM && ARCH_EXYNOS
>
>  # There is no need to enable these drivers for ARMv8
> @@ -34,6 +37,7 @@ config EXYNOS_PMU_ARM_DRIVERS
>  config EXYNOS_PM_DOMAINS
>         bool "Exynos PM domains" if COMPILE_TEST
>         depends on (ARCH_EXYNOS && PM_GENERIC_DOMAINS) || COMPILE_TEST
> +       default y if (ARCH_EXYNOS && PM_GENERIC_DOMAINS)
>
>  config SAMSUNG_PM_DEBUG
>         bool "Samsung PM Suspend debug"
> --
> 2.33.0.464.g1972c5931b-goog
>

Sorry I didn't see this patch sent yesterday:
https://lore.kernel.org/lkml/CAGOxZ50i6URzUQ7o7V4m7MR=2TqSeD6qx5fQaQDs+5nEq4fa2A@mail.gmail.com/

Looks like Krzysztof's patch covers my portion of the patch related to
EXYNOS_CHIPID. I'll keep an eye on his patch as it goes through and
will modify mine as needed since it's likely to come in after.

Thanks,
Will
