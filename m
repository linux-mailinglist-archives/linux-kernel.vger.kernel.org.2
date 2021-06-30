Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB4D3B84FD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 16:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235275AbhF3OXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 10:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235141AbhF3OXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 10:23:33 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF099C061756
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:21:03 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id x12so1778607vsp.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ul+xfgqMRCF8BIHYL3fuS5RV/KFPrPSsd3KoauRtG+E=;
        b=g1/Yz7J7EbTwoG2FKUYTMNDjHw+J0zuJngzLKCwBAi92YOaR1H/rH1Aimab0guY8m9
         HL/RTgwaI2Pnx4QodfDqzcVF+2fVtDzDjgzxvrWp43H85z8lJcKW4y0ZAJujo4vS844T
         kNdioF3dVQG6vf2b+LRTRYXBY6PtwEEjEs0UjWFreSepzJaqTWsDKGrZq0rRq8OspE7M
         34m4qoTX3DwPYz3H9ab6koTkroo3lby4TQi3BmjealppKuiQrgn1P9pAlFhN5dgo0KPX
         vFVDgL04i/qvHMuCRfwbhiArPVr37rvlk4i2Hi3CrR9v2MdhEQH6F9jJFOQJ5nDLSyot
         iJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ul+xfgqMRCF8BIHYL3fuS5RV/KFPrPSsd3KoauRtG+E=;
        b=TKJDyFypj6Bs3GEe3QEJsd8XKGOON6b+cWJmtftaCmEFGvJlsD0cNEIVN+v9R5WoUn
         XbqlXSxcXbsYWk4IE7j6EtDDYuaVOmRR45nGbbOtlQmBB8pu1hqvZRRtflLFfensaENs
         lK8NN7HjpHCVlN38rDBP5qTd3Bivx/3iFTtCopAV+HnbRVHUI0uEXdc385jfdO0tGciz
         Jf7eS1sDmMPhy1sYJeQbhOAQr4wLojdEALPGWksO9o9tugXDmyOp07ik1MoeD2YYI+K1
         RGhDxPrKrmUZyIzp/n/GyIzL/BL56KJ6vVfad70VznWUShse/eaiPVq5tWLCYbj01izh
         XiJQ==
X-Gm-Message-State: AOAM533bbcLD5wCN/xcCBlksn2crpSYCq7bel0u1F/GqBdhPnPNj9/Uf
        cofPxrGvIaX8uAL6I1E9jcUMRIYkXPb+utICLEhBzw==
X-Google-Smtp-Source: ABdhPJwSZ0Nw8q+87tEXQ8Kz1ZEXL/lCsklv41CrRimd986bvtdFFmZpnkAGKH67f1m9IPzvusrw7mFjxJzIYXr5/E8=
X-Received: by 2002:a67:8783:: with SMTP id j125mr7711177vsd.42.1625062863038;
 Wed, 30 Jun 2021 07:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210624163045.33651-1-alcooperx@gmail.com>
In-Reply-To: <20210624163045.33651-1-alcooperx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 30 Jun 2021 16:20:26 +0200
Message-ID: <CAPDyKFqwrX64W8t-PYrN-JYTttu6Bsfg40abPOOYFdZqDH0qMw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Fix warning message when accessing RPMB in
 HS400 mode
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 at 18:31, Al Cooper <alcooperx@gmail.com> wrote:
>
> When an eMMC device is being run in HS400 mode, any access to the
> RPMB device will cause the error message "mmc1: Invalid UHS-I mode
> selected". This happens as a result of tuning being disabled before
> RPMB access and then re-enabled after the RPMB access is complete.
> When tuning is re-enabled, the system has to switch from HS400
> to HS200 to do the tuning and then back to HS400. As part of
> sequence to switch from HS400 to HS200 the system is temporarily
> put into HS mode. When switching to HS mode, sdhci_get_preset_value()
> is called and does not have support for HS mode and prints the warning
> message and returns the preset for SDR12. The fix is to add support
> for MMC and SD HS modes to sdhci_get_preset_value().
>
> This can be reproduced on any system running eMMC in HS400 mode
> (not HS400ES) by using the "mmc" utility to run the following
> command: "mmc rpmb read-counter /dev/mmcblk0rpmb".
>
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

I assume we want this for stable kernels, but it would be nice to add
a fixes tag as well.

Do you know if there is a specific commit that this fixes?

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 4 ++++
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index bf238ade1602..6b39126fbf06 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1812,6 +1812,10 @@ static u16 sdhci_get_preset_value(struct sdhci_host *host)
>         u16 preset = 0;
>
>         switch (host->timing) {
> +       case MMC_TIMING_MMC_HS:
> +       case MMC_TIMING_SD_HS:
> +               preset = sdhci_readw(host, SDHCI_PRESET_FOR_HIGH_SPEED);
> +               break;
>         case MMC_TIMING_UHS_SDR12:
>                 preset = sdhci_readw(host, SDHCI_PRESET_FOR_SDR12);
>                 break;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0770c036e2ff..960fed78529e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -253,6 +253,7 @@
>
>  /* 60-FB reserved */
>
> +#define SDHCI_PRESET_FOR_HIGH_SPEED    0x64
>  #define SDHCI_PRESET_FOR_SDR12 0x66
>  #define SDHCI_PRESET_FOR_SDR25 0x68
>  #define SDHCI_PRESET_FOR_SDR50 0x6A
>
> base-commit: 7426cedc7dad67bf3c71ea6cc29ab7822e1a453f
> --
> 2.17.1
>
