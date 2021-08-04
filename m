Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263B93E0047
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbhHDLfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbhHDLfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:35:34 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB21C061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 04:35:21 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id v16so823032vss.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 04:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zFmNv8bWnnhaUEfEbtd/dIDab8KFB9ZFGv6zOrp9yb4=;
        b=iu0kyRPpYLdd/jKrXz1byoUVslMvTNXKDP5os4v7jpIA9Q4eZ9ui2ItYYzm14Ep4dl
         ovQWvTdkAoGV/HM55AZMcYojzijUvBsmwjyLPGu0ajgS9yg+HSdYM/DjDuTE17r2kwku
         A+KsLof1HDrPTHh9X4WNRSZ47BKMaPTBXgjUPbKDxD5p3F1e9ikCH9SB/1sGkt0AhztT
         M73vqhZO16i6VffkAeO6/HB5YHRQsL1u+GxNm9q+8l7dx+BQdsx+PgRnG85naHFHwF+S
         Txfpfm+vz2kG5lnH4z1nUXucc4va+QumoW539vaWHuhUsrmG7osUGfM8sVu4nHtsY2kb
         9xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFmNv8bWnnhaUEfEbtd/dIDab8KFB9ZFGv6zOrp9yb4=;
        b=eYJlNq9sPc717seTD+rsEdVPeMYWuG4W/nyGbctDk04u+KtwvlPjhwaoDVZhqRiaDp
         HdRR2zfQ07LWw1F5pl08SnAwWn30OTYadj6crDebIp+Q5OUhFMYZPgtxFz4+nxikCeI0
         v+KmZQtf6r9kTGpPSGmOJhE7TBusqnrwCOp5rLVfDSrpdOFO3A3UKL3W70DpUuToIW5j
         xtDN20hJ/Ic/gcvHS3Vp2U1cd1wyJGDh7JdQiMB8sQCH0iYJYqZcSWyQJOAtz6BVb34f
         Y8RcKPrh1Lo1kBXNK08hPe7fl4hdrvBQ8uPQjyOrpVi1A1O69gQnyGqQ495bhjnQoUD5
         Jz0w==
X-Gm-Message-State: AOAM532jKABW9+uVPikwx6BIyZcZqPP4WnwZIHxA+2QoydAqMVeabco5
        +lsRfaUm/+A4LoZbRMIXTLADd3y/7hoL/7OFeXDvmA==
X-Google-Smtp-Source: ABdhPJyCx3nRY/4KqOLvHiEA42E1G/VVl/48vDkQI4N1BE+4zhkOavjC4jVwnhhJLmbbutkiekBOZaTnqYfqHAut40o=
X-Received: by 2002:a67:7c14:: with SMTP id x20mr9769573vsc.42.1628076920860;
 Wed, 04 Aug 2021 04:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210701143353.13188-1-yann.gautier@foss.st.com>
In-Reply-To: <20210701143353.13188-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Aug 2021 13:34:44 +0200
Message-ID: <CAPDyKFoCABbyKaejhzAqM9hv7Emg4WyfbtORoW_XMnmoxKSVAQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: stm32: check when the voltage switch procedure
 should be done
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jul 2021 at 16:34, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> From: Christophe Kerello <christophe.kerello@foss.st.com>
>
> If the card has not been power cycled, it may still be using 1.8V
> signaling. This situation is detected in mmc_sd_init_card function and
> should be handled in mmci stm32 variant.
> The host->pwr_reg variable is also correctly protected with spin locks.
>
> Fixes: 94b94a93e355 ("mmc: mmci_sdmmc: Implement signal voltage callbacks")
>
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

Applied for fixes and by adding stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index 51db30acf4dc..fdaa11f92fe6 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -479,8 +479,9 @@ static int sdmmc_post_sig_volt_switch(struct mmci_host *host,
>         u32 status;
>         int ret = 0;
>
> -       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> -               spin_lock_irqsave(&host->lock, flags);
> +       spin_lock_irqsave(&host->lock, flags);
> +       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180 &&
> +           host->pwr_reg & MCI_STM32_VSWITCHEN) {
>                 mmci_write_pwrreg(host, host->pwr_reg | MCI_STM32_VSWITCH);
>                 spin_unlock_irqrestore(&host->lock, flags);
>
> @@ -492,9 +493,11 @@ static int sdmmc_post_sig_volt_switch(struct mmci_host *host,
>
>                 writel_relaxed(MCI_STM32_VSWENDC | MCI_STM32_CKSTOPC,
>                                host->base + MMCICLEAR);
> +               spin_lock_irqsave(&host->lock, flags);
>                 mmci_write_pwrreg(host, host->pwr_reg &
>                                   ~(MCI_STM32_VSWITCHEN | MCI_STM32_VSWITCH));
>         }
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         return ret;
>  }
> --
> 2.17.1
>
