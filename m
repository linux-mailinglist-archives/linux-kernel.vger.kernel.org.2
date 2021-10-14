Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D96A542D81D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 13:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbhJNL03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 07:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhJNL01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 07:26:27 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70552C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 04:24:22 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id t9so25255820lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 04:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBxhJYaCOX3Id7KwwNjAEqmvk1pt+TeT2pj5DWPXCKY=;
        b=VdV9zFSD3os+m4+AHDB+PAnnnCCeOwAUayEF1wwCJ6RVpB/uXIpS3/UTNSsqq8qiUv
         1zZc261Xkg9DT2oQEf9fQY1tHr4mGbcEWFI1/Xv1T0+aq0s/xxqJGzFOfXQHn0zlDs4l
         5u4efJKQTGyc+ohk+ibFqRaDKNk9L6zYBPrAMsxbCRtzOuUAMt9SoPRyMc5bIlYWu8hG
         QqEVrEppMoMQU/6UULwvetb3fkh83PHbzACSlwIcwnPACRjxDs00UMsnjLZgZ4v/GVvu
         mVjzQhR/papd8lNztKvbV0TpnFlZG+RfwuuQeysxqdRBKskMBipqdF4mHvIxPPm+8HVk
         BCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBxhJYaCOX3Id7KwwNjAEqmvk1pt+TeT2pj5DWPXCKY=;
        b=X1xD2Z2CPDfCNhUhI980U+WrksNdftO6zc1Jzggag09DpIwFFX9qeXq8/wFh8bzhkW
         ITlkTfG6K8OpYorETrNyofH67bsMKUpLSV3/RdUBWzG9foBMcPBvClGO8eDKxJP8se6u
         3eUFuts2HbUmEmY2mKdDaHmuDVn2Olz355V10+cqHBRutO9I8/NyIaYiLMED44t9QfpF
         FLB6gXAmPP32Xu2CXBQcOLWikknlOjHNpF3x+yLYnd1g4NHDleILUA1k/oJ9KwFwxMDb
         UdnIIYcaGDT+YUDo/Jr9iZ8bA0jMNTRq+22+xnyG5KhQsbi5i58LbWiJKQUyFthszezv
         2ZEQ==
X-Gm-Message-State: AOAM531B58KMEX61IxeKU0Cu+PUEwr7yzR/XiUDxoRz5I+IES63izKaL
        Y8xp1zUv/oIdpAkcj7kYYYiHVOjWgNyjtFFBKERwSg==
X-Google-Smtp-Source: ABdhPJy4bhF2na6uhZbQZ/ETeLgPA6upQWe9mpPZBreg2G5kdHjhMXSFWBGqAMxhuvr8Qvr3RKHNWppnqSwqqjagFBg=
X-Received: by 2002:a2e:b8d5:: with SMTP id s21mr5632172ljp.300.1634210660744;
 Thu, 14 Oct 2021 04:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211013201723.52212-1-andriy.shevchenko@linux.intel.com> <20211013201723.52212-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211013201723.52212-2-andriy.shevchenko@linux.intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Oct 2021 13:23:44 +0200
Message-ID: <CAPDyKFrGv1OhnXhzq9KmjktcfLwuD=k8BU+aYqbJHCOiv-a5PA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] mmc: sdhci-pci: Read card detect from ACPI for
 Intel Merrifield
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Eric Biggers <ebiggers@google.com>,
        Raul E Rangel <rrangel@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2021 at 22:17, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Intel Merrifield platform had been converted to use ACPI enumeration.
> However, the driver missed an update to retrieve card detect GPIO.
> Fix it here.
>
> Unfortunately we can't rely on CD GPIO state because there are two
> different PCB designs in the wild that are using the opposite card
> detection sense and there is no way to distinguish those platforms,
> that's why ignore CD GPIO completely and use it only as an event.
>
> Fixes: 4590d98f5a4f ("sfi: Remove framework for deprecated firmware")
> BugLink: https://github.com/edison-fw/meta-intel-edison/issues/135
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for fixes and by adding a stable tag, thanks!

Note that, I am expecting yet another version of the remaining patches
in the series, allowing you to address the final comments from Adrian.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index be19785227fe..d0f2edfe296c 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -616,16 +616,12 @@ static int intel_select_drive_strength(struct mmc_card *card,
>         return intel_host->drv_strength;
>  }
>
> -static int bxt_get_cd(struct mmc_host *mmc)
> +static int sdhci_get_cd_nogpio(struct mmc_host *mmc)
>  {
> -       int gpio_cd = mmc_gpio_get_cd(mmc);
>         struct sdhci_host *host = mmc_priv(mmc);
>         unsigned long flags;
>         int ret = 0;
>
> -       if (!gpio_cd)
> -               return 0;
> -
>         spin_lock_irqsave(&host->lock, flags);
>
>         if (host->flags & SDHCI_DEVICE_DEAD)
> @@ -638,6 +634,21 @@ static int bxt_get_cd(struct mmc_host *mmc)
>         return ret;
>  }
>
> +static int bxt_get_cd(struct mmc_host *mmc)
> +{
> +       int gpio_cd = mmc_gpio_get_cd(mmc);
> +
> +       if (!gpio_cd)
> +               return 0;
> +
> +       return sdhci_get_cd_nogpio(mmc);
> +}
> +
> +static int mrfld_get_cd(struct mmc_host *mmc)
> +{
> +       return sdhci_get_cd_nogpio(mmc);
> +}
> +
>  #define SDHCI_INTEL_PWR_TIMEOUT_CNT    20
>  #define SDHCI_INTEL_PWR_TIMEOUT_UDELAY 100
>
> @@ -1341,6 +1352,14 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>                                          MMC_CAP_1_8V_DDR;
>                 break;
>         case INTEL_MRFLD_SD:
> +               slot->cd_idx = 0;
> +               slot->cd_override_level = true;
> +               /*
> +                * There are two PCB designs of SD card slot with the opposite
> +                * card detection sense. Quirk this out by ignoring GPIO state
> +                * completely in the custom ->get_cd() callback.
> +                */
> +               slot->host->mmc_host_ops.get_cd = mrfld_get_cd;
>                 slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>                 break;
>         case INTEL_MRFLD_SDIO:
> --
> 2.33.0
>
