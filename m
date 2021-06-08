Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D172139F701
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhFHMoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 08:44:30 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:42970 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbhFHMo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:44:29 -0400
Received: by mail-ua1-f46.google.com with SMTP id w5so11518345uaq.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 05:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mcc8OYc1xINsDjGaAzn2LnDPNNAqALk30CWabYfEJ5Y=;
        b=ae0mnRjOIMn1cVt/lfPKFZ+dihY+iVQiOB120cuEUj9cs4YROrh3apZGQSzDgRbtlQ
         6VMqpdt+vo7uIubvyFJ/Gx8sXMH/cCATEK4+QHruCfTWpe/arCeuwdIsjxRCeGuxCy/T
         3/l9qXGBLWYlUf0UO1fouktqbEeWW0bhbJn4a9o5sPOB9J/ev9MesoPHr9U1j2NAxzKy
         fWLwR7FRoH4KaROXLt+TtwVt/t1rNDMycHYALf5xLoDJRfmpceC9CP5luc1gX3BMBtw9
         OfM8ymR4sp3l5h+b6rYCj4WUoUF0xGfhCxVD6Kn0RP4vW8YwWgb6yEc53dzg+868y8+Y
         un7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mcc8OYc1xINsDjGaAzn2LnDPNNAqALk30CWabYfEJ5Y=;
        b=gCRt8HOVtEhkVFq61etaoduUWP5SeKGFrRaYoKjyeAFSiXQbjWGtUugLhyuUOAaLxB
         WlcM0XCF6MASRSftArg7z4aj48AN5inUqgYYx/ZqXJzapfBzowE8gNRcMs0fNgDBb1R0
         VdvWXK4ZS4Qm0eUzOvTrTZEIUhLReLD9xg4qUQIAEizpCWs9eEfplc3mvJS7RKVc3y6u
         D8AgWUChlyu5UkJ0gwtFpFZOz+prtuJgJdpv2ClUlJcWAF3lmLCwScNxVGvHOmgvdJNG
         yU4wrQXUM8+5BXYiWwgrLK7mA5oWcjRsktWJAOamsEXrIeuBz/4Aj+6mPg5INfnrVzOA
         FWXw==
X-Gm-Message-State: AOAM530Bv/XORq0sIJSrQkyCUGy6SPOWgEr+eu27GkCVjC/RFQruEGu0
        50ltnJB05MvW5rQl+1T6O/VUBV7qmsJtgqJOy2tLVA==
X-Google-Smtp-Source: ABdhPJxaPShcDb8weegxYcT+6lqT0m9ossZqMq8qD5rdHUJ1HszEh+p7p3IuISUl9zNHrKvoARqbkguEnZU/w/ywjho=
X-Received: by 2002:ab0:7c5b:: with SMTP id d27mr12310573uaw.15.1623156082979;
 Tue, 08 Jun 2021 05:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210602192758.38735-1-alcooperx@gmail.com> <20210602192758.38735-2-alcooperx@gmail.com>
In-Reply-To: <20210602192758.38735-2-alcooperx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Jun 2021 14:40:46 +0200
Message-ID: <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci
 controller on the BCM7211
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 at 21:28, Al Cooper <alcooperx@gmail.com> wrote:
>
> Add support for the legacy Arasan sdhci controller on the BCM7211 and
> related SoC's. This includes adding a .shutdown callback to increase
> the power savings during S5.

Please split this into two separate changes.

May I also ask about the ->shutdown() callback and in relation to S5.
What makes the ->shutdown callback only being invoked for S5?

Kind regards
Uffe

>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  drivers/mmc/host/Kconfig       |  2 +-
>  drivers/mmc/host/sdhci-iproc.c | 30 ++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci.h       |  2 ++
>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index a4d4c757eea0..561184fa7eb9 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -412,7 +412,7 @@ config MMC_SDHCI_MILBEAUT
>
>  config MMC_SDHCI_IPROC
>         tristate "SDHCI support for the BCM2835 & iProc SD/MMC Controller"
> -       depends on ARCH_BCM2835 || ARCH_BCM_IPROC || COMPILE_TEST
> +       depends on ARCH_BCM2835 || ARCH_BCM_IPROC || ARCH_BRCMSTB || COMPILE_TEST
>         depends on MMC_SDHCI_PLTFM
>         depends on OF || ACPI
>         default ARCH_BCM_IPROC
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index ddeaf8e1f72f..cce390fe9cf3 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -286,11 +286,35 @@ static const struct sdhci_iproc_data bcm2711_data = {
>         .mmc_caps = MMC_CAP_3_3V_DDR,
>  };
>
> +static const struct sdhci_pltfm_data sdhci_bcm7211a0_pltfm_data = {
> +       .quirks = SDHCI_QUIRK_MISSING_CAPS |
> +               SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
> +               SDHCI_QUIRK_BROKEN_DMA |
> +               SDHCI_QUIRK_BROKEN_ADMA,
> +       .ops = &sdhci_iproc_ops,
> +};
> +
> +#define BCM7211A0_BASE_CLK_MHZ 100
> +static const struct sdhci_iproc_data bcm7211a0_data = {
> +       .pdata = &sdhci_bcm7211a0_pltfm_data,
> +       .caps = ((BCM7211A0_BASE_CLK_MHZ / 2) << SDHCI_TIMEOUT_CLK_SHIFT) |
> +               (BCM7211A0_BASE_CLK_MHZ << SDHCI_CLOCK_BASE_SHIFT) |
> +               ((0x2 << SDHCI_MAX_BLOCK_SHIFT)
> +                       & SDHCI_MAX_BLOCK_MASK) |
> +               SDHCI_CAN_VDD_330 |
> +               SDHCI_CAN_VDD_180 |
> +               SDHCI_CAN_DO_SUSPEND |
> +               SDHCI_CAN_DO_HISPD,
> +       .caps1 = SDHCI_DRIVER_TYPE_C |
> +                SDHCI_DRIVER_TYPE_D,
> +};
> +
>  static const struct of_device_id sdhci_iproc_of_match[] = {
>         { .compatible = "brcm,bcm2835-sdhci", .data = &bcm2835_data },
>         { .compatible = "brcm,bcm2711-emmc2", .data = &bcm2711_data },
>         { .compatible = "brcm,sdhci-iproc-cygnus", .data = &iproc_cygnus_data},
>         { .compatible = "brcm,sdhci-iproc", .data = &iproc_data },
> +       { .compatible = "brcm,bcm7211a0-sdhci", .data = &bcm7211a0_data },
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_iproc_of_match);
> @@ -384,6 +408,11 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>         return ret;
>  }
>
> +static void sdhci_iproc_shutdown(struct platform_device *pdev)
> +{
> +       sdhci_pltfm_suspend(&pdev->dev);
> +}
> +
>  static struct platform_driver sdhci_iproc_driver = {
>         .driver = {
>                 .name = "sdhci-iproc",
> @@ -394,6 +423,7 @@ static struct platform_driver sdhci_iproc_driver = {
>         },
>         .probe = sdhci_iproc_probe,
>         .remove = sdhci_pltfm_unregister,
> +       .shutdown = sdhci_iproc_shutdown,
>  };
>  module_platform_driver(sdhci_iproc_driver);
>
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0770c036e2ff..c35ed4be75b7 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -201,8 +201,10 @@
>
>  #define SDHCI_CAPABILITIES     0x40
>  #define  SDHCI_TIMEOUT_CLK_MASK                GENMASK(5, 0)
> +#define  SDHCI_TIMEOUT_CLK_SHIFT 0
>  #define  SDHCI_TIMEOUT_CLK_UNIT        0x00000080
>  #define  SDHCI_CLOCK_BASE_MASK         GENMASK(13, 8)
> +#define  SDHCI_CLOCK_BASE_SHIFT        8
>  #define  SDHCI_CLOCK_V3_BASE_MASK      GENMASK(15, 8)
>  #define  SDHCI_MAX_BLOCK_MASK  0x00030000
>  #define  SDHCI_MAX_BLOCK_SHIFT  16
> --
> 2.17.1
>
