Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8736041A312
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 00:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbhI0WeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 18:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbhI0WeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 18:34:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1D7C061765
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:32:40 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y26so44665971lfa.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aZmS6rLgK39LtutF7yAa96lv04t7RDe75/Kx+aSiY2E=;
        b=X6FX1tN9L59q05EXpGd4/f2lf4YcQ/iruEPmtTVrvi72cWYyC2tR+io4b2N4pWqI0E
         TU04vV+aR009Wg+KsH3HiR04dIxiRNDcoEK2KceAYY9MA8Clynu7Mye8zGh0vuXtI6aA
         8Cj8jRmReUUJuGK+T+FaJq/oTcQhsVIkLv9XrAplkstiW87A/mqW2BJ1rZHsQHtHPcYE
         HpXz+3dQIaaVJL7BQdaZFHi46DfOckJAcRTgyYqiHVyfYEOgxSGlU9UTgLzMdyTnrS9d
         1vGSDwDDyxAuZfCN4h4ouEfcwCU3J8fiOm1GE2AcVRMXPpR3Ob1ullwB79hnGDROEYCz
         wcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aZmS6rLgK39LtutF7yAa96lv04t7RDe75/Kx+aSiY2E=;
        b=N/TkuJVJTMuupffml8ZQZvNJvvBLR0oJUI5iIKo1+gEO4ZAFNrtO8bYiqN1qR9uHIY
         Kp9lcduvr0NA+xA67PIJWgsYhgCOyjgIS0R1nBSQRyITkEmm05iK3FFnzdXvwoZWnN+5
         6Mcz6tLsDOLgphBaVoYCCyHneu7toegVuBLZsagxvE0moQDEZVMrmT9/2eIs0kCxHlmE
         C0FdX97UHngw/+42jjxcgl+lzi5HfIXBBfeJ/6rjqlnbcDMM3c+b/dw99RxagnwzTgqS
         mO5z2gB/4Q80xe0YPQfgVm2uasCXy3WKSK6RdWt8ZQlj99y4MrlBKbEBs1uUVf/s6GKe
         OruQ==
X-Gm-Message-State: AOAM531jnXg7iR40Y6lx1eQ4tgZ4VFIC7Q5flzi74XblA2Dnk9swElOK
        Dnoy1c0HLH0PSuhWE6kpqfhDKk6jtyPI+a3B57MuOQ==
X-Google-Smtp-Source: ABdhPJw6amc1LcHW1FQv1swccHY5vLgF6UhTt8kYXV8iC/5wcxE6mB/3V0jzQcB68Qw1TjUMsPEEulq2xNR1ujfC9Us=
X-Received: by 2002:a05:6512:1515:: with SMTP id bq21mr2292117lfb.71.1632781958851;
 Mon, 27 Sep 2021 15:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210924225111.143112-1-colin.king@canonical.com>
In-Reply-To: <20210924225111.143112-1-colin.king@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:32:02 +0200
Message-ID: <CAPDyKFq_eEP+HayXhGRSGWXVG9Gq0dq4DEnYG+qwjLktwnyvEw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-o2micro: Fix spelling mistake "unsupport"
 -> "unsupported"
To:     Colin King <colin.king@canonical.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sept 2021 at 00:51, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a pr_info message. Fix it. Also
> put msi in capital letters.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 51d55a87aebe..f045c1ee4667 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -489,7 +489,7 @@ static void sdhci_pci_o2_enable_msi(struct sdhci_pci_chip *chip,
>
>         ret = pci_find_capability(chip->pdev, PCI_CAP_ID_MSI);
>         if (!ret) {
> -               pr_info("%s: unsupport msi, use INTx irq\n",
> +               pr_info("%s: unsupported MSI, use INTx irq\n",
>                         mmc_hostname(host->mmc));
>                 return;
>         }
> --
> 2.32.0
>
