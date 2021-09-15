Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE2540C599
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhIOMux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233060AbhIOMut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:50:49 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BFFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:49:29 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q21so887066ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FH30O377gCgchXls+ioHq2bH2D59xWo/oWbpx95frec=;
        b=xhGX94MOrFx2mzp0j5ncdCZ5dCT2mazIZkr1mviCJiS80EUNFleKKreZXEUnGsEl0B
         vdN+VClwwMuI5dnoKmKvq4UNj2/oJxVlEyn5C0n8l8Puc3X7ibjl6pZGyGxcwT3RxBKL
         eDv1dSIhf7lLE32JWtVSrCw0BxUaAa2D48EpV68hyd95LRyF0jM+sH5eUjuYIFRCR+0r
         c57uJqRiiZeLKfn8DLEX/VIUFzgxjK+LMxrXuMzdIU7nd46ENNBN86hbww3SsONQEUjV
         Qa7flzcShVlQ7GpM2WBEhWUAN0dzXr43jcNn5rK8pjf2z/+kLnnRAFkpSai0+z8MUDTq
         3l1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FH30O377gCgchXls+ioHq2bH2D59xWo/oWbpx95frec=;
        b=H4cUuVQ9FWLbJZ8e4yWrL6fLgNk1A+uENXDGMelRxCUmUVWswk+Yw+c8N0xvdxKBXH
         j9YWl0C5gb3PBQu69zU57BqBE76DEbjneawKezn1lr29iy7jAwqNmI2CAsa5ZUMTM/OP
         HQDjb/GpQFGav6gaBUBbZ0SWvcdViU6d/AcE886srN0V0dLWYXPeWRqBOmfl2tmZ9KjA
         UY68iqd3ol2OkC8qqbsY1Ox4Unh1pKLA49+NCV2Mzy4BjJmo4z1A/EYykQc6fVtPvJVP
         6cUlNUfUCSripJKyjPWvp76O8JVTleWe6hAQTMFglkGfyt3VkOaVM3Yea9WkXecLVM+q
         bE4w==
X-Gm-Message-State: AOAM531Dat8MJWhNP+IVt0bV1vTzwlM/6ItwZWeisnIBUWvT2yRFp1Pz
        ut4Ly7QUNTmZ3YHUAn4xLn/0PTWtpxKp08JmsgyOdA==
X-Google-Smtp-Source: ABdhPJxP1J4tkSukc7gi2W/9LCeNDw8Ayv/w9QtLVPeRLbYGByFQWKBMzIZ4psjS0KnFHCwO/fP+RwSFcc86TxobHa4=
X-Received: by 2002:a05:651c:102d:: with SMTP id w13mr20050344ljm.229.1631710168105;
 Wed, 15 Sep 2021 05:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210907151204.118861-1-huobean@gmail.com> <20210907151204.118861-3-huobean@gmail.com>
 <CAPDyKFpC6iei96n-UcRTNrxTaHeejzfQX+rka7GSwSZjXN7-4g@mail.gmail.com> <92123c0398e154334cc947ce8f16e89ce0c3c9af.camel@gmail.com>
In-Reply-To: <92123c0398e154334cc947ce8f16e89ce0c3c9af.camel@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Sep 2021 14:48:51 +0200
Message-ID: <CAPDyKFpAjMwPbxew0FyHH9mLOTaPw01AL0fCCLDjSP0N=xQcaA@mail.gmail.com>
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

On Wed, 15 Sept 2021 at 11:54, Bean Huo <huobean@gmail.com> wrote:
>
> On Tue, 2021-09-14 at 10:13 +0200, Ulf Hansson wrote:
> > >          }
> > > +       /*
> > > +        * In case CQE is enabled, the timeout will be set a
> > > maximum timeout in
> > > +        * sdhci_cqe_enable(), so, no need to go through the below
> > > algorithm.
> > > +        */
> > > +       if (host->cqe_enabled)
> >
> >
> >  I don't think this is a good idea. For example, host->cqe_enabled is
> >
> > set for the hsq case well.
>
> Uffe,
>
> My apologies for this, I forgot to check hsq, hsq will call
> sdhci_send_command() as well.
>
>
> How about changing it to this?
>
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 240c5af793dc..7235e398ef93 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -649,6 +649,7 @@ EXPORT_SYMBOL(mmc_wait_for_cmd);
>  void mmc_set_data_timeout(struct mmc_data *data, const struct mmc_card
> *card)
>  {
>         unsigned int mult;
> +       struct mmc_host *host = card->host;
>
>         /*
>          * SDIO cards only define an upper 1 s limit on access.
> @@ -659,6 +660,13 @@ void mmc_set_data_timeout(struct mmc_data *data,
> const struct mmc_card *card)
>                 return;
>         }
>
> +       /*
> +        * For the CQE use case, the data transfer timeout will be set
> a maximum
> +        * timeout value in HW timer in function sdhci_cqe_enable(),
> so, no need
> +        * to go through the below algorithm.
> +        */
> +       if (host->cqe_enabled && !host->hsq_enabled)
> +               return;

Are you really sure the timeout isn't used (or could make sense to be
used for new cases)?

For example, we also have mtk-sd, which doesn't make use of sdhci_cqe_enable().

>         /*
>          * SD cards use a 100 multiplier rather than 10
>          */
>
> I have another timeout change associated with data transfer as well, if
> this change is acceptible, I will submit it with that together.
>
> Kind regards,
> Bean
>

Kind regards
Uffe
