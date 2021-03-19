Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06BBE341F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 15:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbhCSONb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhCSONG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 10:13:06 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD4C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:13:06 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id v11so3092548uao.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 07:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E8f3xPNPx4BIwTngXOEt68+fl9DFV15IvjUwnO6QUZs=;
        b=GiJ8Et5AxvmToXt37hYkZgm9C6910veLh4SPPv5YRVjIJb1EBq2AQ91eBMTnWNysHU
         0TuQH1k+JJnlSZAvQDXpBTnYVPVqIBFGRZtY7dZDZ4yKi153hjqQwHYLGoYnjfxFtQVF
         2KjK3CpbB4737zoBTKugKe2xOxVV7GBRKoBhw/CmV30ba1c9/A/BNoh/a73gLp/fbRWm
         nYmhFhT3vA/K+W36RdQQ2fnQ/i6EE3UOy/4OYjJlRCXQjAuczLUqoB5Ns9xeFY+1nlXN
         CDwbiAhsVYy1XkfXiFnaILYqST7ZfPs6x7hDRu/gkHKQKEXbo+BKtR6hCjL7TFWFg78L
         zoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E8f3xPNPx4BIwTngXOEt68+fl9DFV15IvjUwnO6QUZs=;
        b=VUa4f8NnbkeI0/URNxe/OhHwa61Tcae1T5mVq9M7TPTMydEuROiNI6Hlnveha/11Wv
         4M+dy6NNCAU4YvO0OS3WOmFxEblSxil8U3iwczXViyUck/1Ve/yzTdwvn8cMH7jpr6qq
         OUyIpHletrah30FDkGjOpB6vquon717LFZgspc5+1ayCisVfxc/ik2LqXgZCYRpaet3w
         vNkEDbjaRMlaryLTP95TN431bhbLQfRzZRHnQ1Zovsoa+WVptT9IA/QekiAe/5irPZJ4
         bLkWxQy5PykcgW9BhF6a72x94/2H3z1j6L9+tKKHU0MLmqLg+ubYAHuBef2ZlyNIqYB1
         UhzQ==
X-Gm-Message-State: AOAM5324rLHTPSfxGfc8L9IG2ZNL5k73G4wD2Ztg81gXzWlh52P6vigS
        87e3OAP8FYtcs7YWZWvA/wRZBEiMcq93y3FT7a7fyQ==
X-Google-Smtp-Source: ABdhPJwFnNbMuuZg7c7dC6maK0O60IJdYShVNW0mFCbYyIKA+qf27ErP6VRGaUuNZtLTsuUbmLA/eHHrx7YHpvVvXFw=
X-Received: by 2002:a9f:2843:: with SMTP id c61mr4150354uac.129.1616163185587;
 Fri, 19 Mar 2021 07:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <b62a68d1f8488e7f95befc6723ba5c20d6781628.1615487235.git.limings@nvidia.com>
 <1615936797-245197-1-git-send-email-limings@nvidia.com>
In-Reply-To: <1615936797-245197-1-git-send-email-limings@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 19 Mar 2021 15:12:28 +0100
Message-ID: <CAPDyKFpvuKU50T1UXfo-H5=gesOwqH4rW4sok4sYOZBgFijt2g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: add ACPI support for
 BlueField-3 SoC
To:     Liming Sun <limings@nvidia.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Khalil Blaiech <kblaiech@nvidia.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Mar 2021 at 00:20, Liming Sun <limings@nvidia.com> wrote:
>
> This commit adds ACPI support in the sdhci-of-dwcmshc driver for
> BlueField-3 SoC. It has changes to only use the clock hierarchy
> for Deviec Tree since the clk is not supported by ACPI. Instead,
> ACPI can define 'clock-frequency' which is parsed by existing
> sdhci_get_property(). This clock value will be returned in function
> dwcmshc_get_max_clock().
>
> Signed-off-by: Liming Sun <limings@nvidia.com>
> Reviewed-by: Khalil Blaiech <kblaiech@nvidia.com>

Liming, can you please rebase and repost a new version. It seems like
Shawn Lin's patch that added rockchip platform support causes the
conflict.

Kind regards
Uffe


> ---
> v1->v2:
>    Changes for comments from Adrian Hunter <adrian.hunter@intel.com>:
>    - Make changes in sdhci-of-dwcmshc instead.
> v1: Initial version which was done in sdhci-acpi.c
> ---
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 50 ++++++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index 59d8d96..bf5037a 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -7,6 +7,7 @@
>   * Author: Jisheng Zhang <jszhang@kernel.org>
>   */
>
> +#include <linux/acpi.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/kernel.h>
> @@ -51,6 +52,16 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
>         sdhci_adma_write_desc(host, desc, addr, len, cmd);
>  }
>
> +static unsigned int dwcmshc_get_max_clock(struct sdhci_host *host)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +
> +       if (pltfm_host->clk)
> +               return sdhci_pltfm_clk_get_max_clock(host);
> +       else
> +               return pltfm_host->clock;
> +}
> +
>  static void dwcmshc_check_auto_cmd23(struct mmc_host *mmc,
>                                      struct mmc_request *mrq)
>  {
> @@ -104,7 +115,7 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
>         .set_clock              = sdhci_set_clock,
>         .set_bus_width          = sdhci_set_bus_width,
>         .set_uhs_signaling      = dwcmshc_set_uhs_signaling,
> -       .get_max_clock          = sdhci_pltfm_clk_get_max_clock,
> +       .get_max_clock          = dwcmshc_get_max_clock,
>         .reset                  = sdhci_reset,
>         .adma_write_desc        = dwcmshc_adma_write_desc,
>  };
> @@ -117,6 +128,7 @@ static void dwcmshc_set_uhs_signaling(struct sdhci_host *host,
>
>  static int dwcmshc_probe(struct platform_device *pdev)
>  {
> +       struct device *dev = &pdev->dev;
>         struct sdhci_pltfm_host *pltfm_host;
>         struct sdhci_host *host;
>         struct dwcmshc_priv *priv;
> @@ -131,7 +143,7 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         /*
>          * extra adma table cnt for cross 128M boundary handling.
>          */
> -       extra = DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_128M);
> +       extra = DIV_ROUND_UP_ULL(dma_get_required_mask(dev), SZ_128M);
>         if (extra > SDHCI_MAX_SEGS)
>                 extra = SDHCI_MAX_SEGS;
>         host->adma_table_cnt += extra;
> @@ -139,19 +151,21 @@ static int dwcmshc_probe(struct platform_device *pdev)
>         pltfm_host = sdhci_priv(host);
>         priv = sdhci_pltfm_priv(pltfm_host);
>
> -       pltfm_host->clk = devm_clk_get(&pdev->dev, "core");
> -       if (IS_ERR(pltfm_host->clk)) {
> -               err = PTR_ERR(pltfm_host->clk);
> -               dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
> -               goto free_pltfm;
> +       if (dev->of_node) {
> +               pltfm_host->clk = devm_clk_get(dev, "core");
> +               if (IS_ERR(pltfm_host->clk)) {
> +                       err = PTR_ERR(pltfm_host->clk);
> +                       dev_err(dev, "failed to get core clk: %d\n", err);
> +                       goto free_pltfm;
> +               }
> +               err = clk_prepare_enable(pltfm_host->clk);
> +               if (err)
> +                       goto free_pltfm;
> +
> +               priv->bus_clk = devm_clk_get(dev, "bus");
> +               if (!IS_ERR(priv->bus_clk))
> +                       clk_prepare_enable(priv->bus_clk);
>         }
> -       err = clk_prepare_enable(pltfm_host->clk);
> -       if (err)
> -               goto free_pltfm;
> -
> -       priv->bus_clk = devm_clk_get(&pdev->dev, "bus");
> -       if (!IS_ERR(priv->bus_clk))
> -               clk_prepare_enable(priv->bus_clk);
>
>         err = mmc_of_parse(host->mmc);
>         if (err)
> @@ -239,11 +253,19 @@ static int dwcmshc_resume(struct device *dev)
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_dwcmshc_dt_ids);
>
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id sdhci_dwcmshc_acpi_ids[] = {
> +       { .id = "MLNXBF30" },
> +       {}
> +};
> +#endif
> +
>  static struct platform_driver sdhci_dwcmshc_driver = {
>         .driver = {
>                 .name   = "sdhci-dwcmshc",
>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>                 .of_match_table = sdhci_dwcmshc_dt_ids,
> +               .acpi_match_table = ACPI_PTR(sdhci_dwcmshc_acpi_ids),
>                 .pm = &dwcmshc_pmops,
>         },
>         .probe  = dwcmshc_probe,
> --
> 1.8.3.1
>
