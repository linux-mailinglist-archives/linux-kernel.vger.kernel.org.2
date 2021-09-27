Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA541A30F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbhI0WeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbhI0WeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:34:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53793C061740
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:32:35 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z24so84963419lfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SWtpZ8PO1D/9eZFX8nceZYsmLHQWGmkDYyw8clyIoeQ=;
        b=nsv+9QbYaiqvtpvL0wrJuH7G7mw8h6nMh5mofTyXGGAeKDE8SUGersA+a/Yo3NkFAr
         aniIIzDZ6Jbf0clUsu2XlJdS32IPCPd9V3FHvw5WnG5PidLr41vu5a16BeAd0ww2ZLyh
         RgWN54kjzvAjvFPaejwwXJaYwsdpZqxPr3YBK3CaBn/dylvTLV2OOnsH/w+oaaKIdd7E
         +F2HXqZgxbqkizIt2ZzKQOpzx94qj5/yKPko8l3qUfJ8V4Q6hC8w8RzN8k2uxmCZpxHq
         WhgAGDzMaiMWranShw8/gsrbRLnRvabX3luVEEkOmMZy0v32tnx/xDK3duThElp/r9Zq
         WArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SWtpZ8PO1D/9eZFX8nceZYsmLHQWGmkDYyw8clyIoeQ=;
        b=aHp+my1Yirll91zZhmGNbRQRE9TO2qUh010zV3Qut48kGv3V5xPB5jdoDjKHgIZh8a
         UlhS7TITbcmhmUVZ+laMYADMLCKrhqMNso4teQXTuxu7W/mayXkHICJUGj5G6R3Qvws6
         g9htr3qutRoda0RF12699zjvkI5FnVveT1a/UtQJhj1t7ctgxfaQplOPpx9IgfWKSADW
         JFEf85ZdCPuYAh1DVlC/2eLRms3bF/wTuLv5TuIimj3Z1aGDip/MRr68UUMCKnfHAt+Q
         ALpvmXOPEvRBA8kyFwfEzplp0Da9iYQiFF3lwqweRYDA88uQyDuyx0JYKVG+XxZGaThG
         JzxQ==
X-Gm-Message-State: AOAM533AUvDgCOqTHH2d8njXQBjEtXnFhUmQRHTjuEgVThwiykSvYfGU
        R31VEP6GKP9sBdhfzgKZZosttVtRPtrOsQ3NKSc2NA==
X-Google-Smtp-Source: ABdhPJyEXb/yQ9/a6K8aBzhJdUYb10ZUYNoy2vlteyYKNJZtPx8j46XiOXQmIJRCjJRs1TQZhUKudUPzSmNoSz+Gk+Y=
X-Received: by 2002:a05:6512:3fa5:: with SMTP id x37mr2271959lfa.233.1632781953710;
 Mon, 27 Sep 2021 15:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210924133257.112017-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210924133257.112017-1-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:31:56 +0200
Message-ID: <CAPDyKFr6tEEm0j7qBrA3dqqEZxF-5+DXrau3TKTK8RRuYeL5yA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: Describe driver in KConfig
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sept 2021 at 15:33, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Describe better which driver applies to which SoC, to make configuring
> kernel for Samsung SoC easier.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 71313961cc54..e4c1648e364e 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -315,15 +315,17 @@ config MMC_SDHCI_TEGRA
>           If unsure, say N.
>
>  config MMC_SDHCI_S3C
> -       tristate "SDHCI support on Samsung S3C SoC"
> +       tristate "SDHCI support on Samsung S3C/S5P/Exynos SoC"
>         depends on MMC_SDHCI
>         depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
>         help
>           This selects the Secure Digital Host Controller Interface (SDHCI)
>           often referrered to as the HSMMC block in some of the Samsung S3C
> -         range of SoC.
> +         (S3C2416, S3C2443, S3C6410), S5Pv210 and Exynos (Exynso4210,
> +         Exynos4412) SoCs.
>
> -         If you have a controller with this interface, say Y or M here.
> +         If you have a controller with this interface (thereforeyou build for
> +         such Samsung SoC), say Y or M here.
>
>           If unsure, say N.
>
> --
> 2.30.2
>
