Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2840D45AD10
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 21:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbhKWUNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 15:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232501AbhKWUNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:13:05 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85257C061714
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 12:09:56 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id k2so538370lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 12:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RUVHvpDWEBEfs1rA1nDK27iWUayqNQz0QB3zyVMeGIw=;
        b=Gx8xj3XG561BXhcV10Wx+2ZauEdGbJUODP+0YCMfQFUvND++0mS6GfxiLEtSqDytvv
         AnvzW96dqJ4x8MlyvHzsiG58VHxfO3ZNsI8g+VoABqaB9ozhKW0GxtuPIA/Jn++EqFQX
         GwgF37tbnSboXj8kJ7Zu8p690+UVMvkniEX62Q24H8dVp3K6IWQPlaOnHT0gfl/AaEFy
         Zh8/2zCkLBq4QR3+EeW3ZY7yJk0CQkLQZncIUqOdk3p0SADh4du5ZIcLAlH1BXB04py0
         WDyhVvuiYOvBMrZyhdq/IfSx/JqQuSGkIbQY+b9bb5f1VBLzqmyPvzq3Gkvk3Fja5HpN
         +rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUVHvpDWEBEfs1rA1nDK27iWUayqNQz0QB3zyVMeGIw=;
        b=aiQ1co2al7sbcyRD1K3tzXQnqEGFv06p+2tG3EBNXXyd+Jps0WSL1KlMuNGfBHc6W/
         PUBEnuo39VbM5nQ1MAVOj6xl925dVeZVfKxh63F3xR8G2rE5Ga53Nwfa4KbvoarDoAf9
         r2kaiKW228D4NuwuplpsJ57WlNGVfH4dRmmCk3X0+7mYGaF1p4BEGlQ4jmKXibdEQQls
         Zt6VWeoIwtTMIY1ksLAJDQKgmfHts19+aNBiy+OKnheW7nNEbVvtHyWP9v3DmX8rBYjg
         ru0Y16qwUAHX8hc31dd7TbdHDMcf+vnNdYnDroEIh1NtT9MTQRigfA/VeG7ge4IGwL16
         bbDw==
X-Gm-Message-State: AOAM533txbpOQYVVsILqgtpcwvJie9XrsJyHMK+VX1cC95JEl/gLa7Me
        dsD0KSlbWywitYc4toNUs0EyE/p4QIa1GLgf1myZsg==
X-Google-Smtp-Source: ABdhPJzaZfhmzYFEL5qRSvRdg1nJ4rAMNq2jR2Fsv3IFyKJnFZ25EBoa+LBAimt2uhaFYazqObYuevCozI5jPymVS9k=
X-Received: by 2002:a2e:a22a:: with SMTP id i10mr8650725ljm.16.1637698194349;
 Tue, 23 Nov 2021 12:09:54 -0800 (PST)
MIME-Version: 1.0
References: <20211120112318.10474-1-kmcopper@danwin1210.me>
In-Reply-To: <20211120112318.10474-1-kmcopper@danwin1210.me>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Nov 2021 21:09:18 +0100
Message-ID: <CAPDyKFrwnL4-XhwVXVvVk2ZXJF+FPEvaMmzPN4HvHs1s760FyA@mail.gmail.com>
Subject: Re: [PATCH] mmc: arasan: add runtime power management support
To:     Kyle Copperfield <kmcopper@danwin1210.me>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Manish Narani <manish.narani@xilinx.com>,
        Dragan Simic <dragan.simic@gmail.com>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Nov 2021 at 12:23, Kyle Copperfield <kmcopper@danwin1210.me> wrote:
>
> Add runtime power management support in Arasan SDHCI driver.
>
> This patch is largely based on the original Arasan PM patch from
> https://lore.kernel.org/linux-mmc/1537283046-13985-1-git-send-email-manish.narani@xilinx.com/
> that was left abandoned since 2018 for an unknown reason.
>
> Changes made to the original patch include reducing the runtime
> suspend timeout to 50 ms and reusing the runtime PM configuration
> found in sdhci-of-at91 driver.
>
> Power consumption is measurably reduced on the Pinebook Pro and
> PinePhone Pro, on which the patch was tested.  More precisely,
> a reduction of about 200 mW was measured on the latter.
>
> Originally-by: Manish Narani <manish.narani@xilinx.com>
> Reviewed-by: Dragan Simic <dragan.simic@gmail.com>
> Tested-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Kyle Copperfield <kmcopper@danwin1210.me>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 88 +++++++++++++++++++++++++++++-
>  1 file changed, 86 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 737e2bfdedc2..63095d91a672 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -19,6 +19,7 @@
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/phy/phy.h>
>  #include <linux/regmap.h>
>  #include <linux/of.h>
> @@ -27,6 +28,7 @@
>  #include "cqhci.h"
>  #include "sdhci-pltfm.h"
>
> +#define SDHCI_ARASAN_AUTOSUSPEND_DELAY 50 /* ms */
>  #define SDHCI_ARASAN_VENDOR_REGISTER   0x78
>
>  #define SDHCI_ARASAN_ITAPDLY_REGISTER  0xF0F8
> @@ -456,6 +458,70 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
>                         SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
>  };
>
> +static int __maybe_unused sdhci_arasan_runtime_suspend(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       if (sdhci_arasan->has_cqe) {
> +               ret = cqhci_suspend(host->mmc);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       ret = sdhci_runtime_suspend_host(host);
> +       if (ret)
> +               return ret;
> +
> +       if (host->tuning_mode != SDHCI_TUNING_MODE_3)
> +               mmc_retune_needed(host->mmc);
> +
> +       clk_disable(pltfm_host->clk);
> +       clk_disable(sdhci_arasan->clk_ahb);

These should be clk_disable_unprepare() - and the corresponding
clk_enable() below, needs to be converted to clk_prepare_enable().

Moreover, I am wondering about why the phy is to be turned off with
phy_power_off() during system suspend, but not during runtime suspend?

When is it safe to turn off the phy?

> +
> +       return 0;
> +}
> +
> +static int __maybe_unused sdhci_arasan_runtime_resume(struct device *dev)
> +{
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct sdhci_host *host = platform_get_drvdata(pdev);
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +       int ret;
> +
> +       ret = clk_enable(sdhci_arasan->clk_ahb);
> +       if (ret) {
> +               dev_err(dev, "Cannot enable AHB clock: %d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = clk_enable(pltfm_host->clk);
> +       if (ret) {
> +               dev_err(dev, "Cannot enable SD clock: %d\n", ret);
> +               goto err_clk_ahb;
> +       }
> +
> +       ret = sdhci_runtime_resume_host(host, 0);
> +       if (ret)
> +               goto err_clk_disable;
> +
> +       if (sdhci_arasan->has_cqe)
> +               return cqhci_resume(host->mmc);
> +
> +       return 0;
> +
> +err_clk_disable:
> +       clk_disable(pltfm_host->clk);
> +err_clk_ahb:
> +       clk_disable(sdhci_arasan->clk_ahb);
> +
> +       return ret;
> +}
> +
>  #ifdef CONFIG_PM_SLEEP
>  /**
>   * sdhci_arasan_suspend - Suspend method for the driver
> @@ -552,8 +618,10 @@ static int sdhci_arasan_resume(struct device *dev)
>  }
>  #endif /* ! CONFIG_PM_SLEEP */
>
> -static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
> -                        sdhci_arasan_resume);
> +static const struct dev_pm_ops sdhci_arasan_dev_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(sdhci_arasan_suspend, sdhci_arasan_resume)

In sdhci_arasan_suspend() we assume that the clocks, etc are turned
on. This may not be the case anymore, as
sdhci_arasan_runtime_suspend() may already have done that.

There are a couple of options to deal with that, like using
pm_runtime_force_suspend|resume(). But then don't forget that you may
need to manage system wakeups, if that is supported.

> +       SET_RUNTIME_PM_OPS(sdhci_arasan_runtime_suspend,
> +                          sdhci_arasan_runtime_resume, NULL) };
>
>  /**
>   * sdhci_arasan_sdcardclk_recalc_rate - Return the card clock rate
> @@ -1681,13 +1749,25 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                         host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>         }
>
> +       pm_runtime_get_noresume(&pdev->dev);
> +       pm_runtime_set_active(&pdev->dev);
> +       pm_runtime_enable(&pdev->dev);
> +       pm_runtime_set_autosuspend_delay(&pdev->dev, SDHCI_ARASAN_AUTOSUSPEND_DELAY);
> +       pm_runtime_use_autosuspend(&pdev->dev);
> +
>         ret = sdhci_arasan_add_host(sdhci_arasan);
>         if (ret)
>                 goto err_add_host;
>
> +       pm_runtime_put_autosuspend(&pdev->dev);
> +
>         return 0;
>
>  err_add_host:
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_set_suspended(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
> +
>         if (!IS_ERR(sdhci_arasan->phy))
>                 phy_exit(sdhci_arasan->phy);
>  unreg_clk:
> @@ -1715,6 +1795,10 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>                 phy_exit(sdhci_arasan->phy);
>         }
>
> +       pm_runtime_get_sync(&pdev->dev);
> +       pm_runtime_disable(&pdev->dev);
> +       pm_runtime_put_noidle(&pdev->dev);
> +
>         sdhci_arasan_unregister_sdclk(&pdev->dev);
>
>         ret = sdhci_pltfm_unregister(pdev);

Kind regards
Uffe
