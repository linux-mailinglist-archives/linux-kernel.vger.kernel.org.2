Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE9940A8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 10:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhINIPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 04:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbhINIPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 04:15:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A55C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:14:26 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id k4so27002483lfj.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 01:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gNAG6sGwDoGBymW4v3k2eOOtXFLNm8P1dLCL1GXtjWw=;
        b=dNM9vb+VveLvd2V/oVpPSsK+h62LKqMHmFHU963BBbU4Lb9pm4ysOpfp5YnrysH+MJ
         OUCVwq2PJIun9j6Ic/UtB+2eLZMl2AoehNGV4dSfUWT1LfrIQHNkD0wcBv7c/LXw0heO
         FYNbd4K08VsPgRqWLKtWMmOhLpZOqwCtosnZbU1sRl704aoQiBsWew6hUdOLTY8WSieA
         B6ZWLIFQJkh1iAahWrEBnjAj5mER4S6PBGGDgA+AmB/om+Y/r3t/sblBeUfhE0jD4d1b
         IlilLuFbPSVd4HK0n1btBB5WB6mbnp0Sx/z7uLwZYp85/9QDAe55EavHS0ZEelactzRF
         B8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gNAG6sGwDoGBymW4v3k2eOOtXFLNm8P1dLCL1GXtjWw=;
        b=7Aiv09I8Y1O2dOdJ2GQ+27mdJ0HOneBsFPF3WGHqUuzK7r+zRi5w3z3s6SzQrLHkPT
         Dk1F87Md0KhSIVCIYw4VsXsIz/MH2aCaqcggSfqs98UVmCmJz8qpCMpw/mW5RKSfODW2
         VDL2N+m6xA7/fo4pHCGlP5/MxkY7nM1jm2Sy353gvtbAF4ELT7PXSP2q6ra3yl1BL5gc
         dAgubEYpFBleQLy9hBSr2+jY1kK/hoVStkqpTb+hHFrEx5Ky42T7vfuh4nzMuCIag3jT
         OuA5tXKWapaZV1QF+xybRkOs+6yKo7EJGJI4jtx80hfAVMEm/uOTQgJTEtKGZKNADYh/
         f4Rg==
X-Gm-Message-State: AOAM533ViV/93iGr46bFXFvbO7wUc7kiByzwfNgb0qSGa3OEwjildjH5
        wysvT9eQI7OhhFA02ifqwl/8eEDd9A9/quCv4FhalA==
X-Google-Smtp-Source: ABdhPJz/39ZOyxqmVezb9i3SjizQHorwf0mpUOqdFpYqSbdtNny2LPuz9a6DaVUyBR31t7Q+Hk5gL+fzBvq2PVpCJ0o=
X-Received: by 2002:ac2:43b1:: with SMTP id t17mr8992193lfl.373.1631607264938;
 Tue, 14 Sep 2021 01:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210907151204.118861-1-huobean@gmail.com> <20210907151204.118861-3-huobean@gmail.com>
In-Reply-To: <20210907151204.118861-3-huobean@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Sep 2021 10:13:48 +0200
Message-ID: <CAPDyKFpC6iei96n-UcRTNrxTaHeejzfQX+rka7GSwSZjXN7-4g@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mmc: core: No need to calculate the timeout value
 for CQE data transmission
To:     Bean Huo <huobean@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Sept 2021 at 17:12, Bean Huo <huobean@gmail.com> wrote:
>
> From: Bean Huo <beanhuo@micron.com>
>
> In case CQE is enabled, the timeout value of data transmission is always
> set to be maximum in sdhci_cqe_enable(), so, calculating its timeout value
> is obviously superfluous. Change to return directly, which can save some CPU
> cycle time.
>
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
>  drivers/mmc/core/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 240c5af793dc..0b571a3bc988 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -649,6 +649,7 @@ EXPORT_SYMBOL(mmc_wait_for_cmd);
>  void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>  {
>         unsigned int mult;
> +       struct mmc_host *host = card->host;
>
>         /*
>          * SDIO cards only define an upper 1 s limit on access.
> @@ -659,6 +660,13 @@ void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card *card)
>                 return;
>         }
>
> +       /*
> +        * In case CQE is enabled, the timeout will be set a maximum timeout in
> +        * sdhci_cqe_enable(), so, no need to go through the below algorithm.
> +        */
> +       if (host->cqe_enabled)

 I don't think this is a good idea. For example, host->cqe_enabled is
set for the hsq case well.

> +               return;
> +
>         /*
>          * SD cards use a 100 multiplier rather than 10
>          */

Kind regards
Uffe
