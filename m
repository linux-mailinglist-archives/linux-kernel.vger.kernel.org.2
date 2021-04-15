Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76063608BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 14:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbhDOMDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 08:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhDOMDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 08:03:44 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBBDC061760
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:03:21 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id b18so6854776vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUz3HXaBkVj8VSFrQQ9X5yODbbRw47llRPRWGnTEIRM=;
        b=BCbXhBQ+y5EXL6VEc3xYmNMhyLYVoqhZLtvDMJZ+Vhoatu8xnCZpCueqDnrkF+JU0T
         VLpNn4fefD43r5l613XegE+0bNV0J/tBn6X79BPjqehuF8WIwVvg3W0zaybYD1xbtFV1
         pq5nJKDayG711JKdZ1N13PiT6+JiUmDM/1GuBK6tL9DGye+Sgk/TNgSZPGMjbQZATB5i
         PjGLI/cnX3vSpfvycwIJn4VHG0LCmDemHv3AyqFfgLEftnVFnNstDdPEK8pxSEpyyL/Y
         M2EOmKDC0G7sZ7V3GTt0Dzm2nuAsuFvFzXKtKe3Xw8f4WUmR3uXbFI9Dbs4+FclvR14F
         CXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUz3HXaBkVj8VSFrQQ9X5yODbbRw47llRPRWGnTEIRM=;
        b=bu8ITxV94E6moZ7J4MyNE45Qm6xLv7wk9ZOmXzVvCLssW5us5LuTBk6l/2nsNdqAcN
         jLw7luqd7JIEchPYN11eap/0TnWM1X2zcvGHt+kKHgzlMxH+4KlyodHciaj9La6qgLFL
         C8Dzwi3B1DZu8YJMq/WEoCBVnGNG266Nf4NODZ//OCPmBg0UBaThtA6v9LZgld3vkBo0
         MvfINl6ezE1eKuNOg57cMXOVYy3dXFZYlH9rx4bo2oDd8X1kVyaiQleJp9sgeOsydNoc
         GskzyXYoEJ/gKN0bA9MNh/AVYNtMY0G0JCRlMoo2gI2Q26MdwwV7zFZcQXoyKOCHyhYJ
         wQ2w==
X-Gm-Message-State: AOAM531/Sj+Oz4MEazFni7yaLnq1LjnOuof5rJrBKczlZVAmkGrkyQu0
        cn+Fo5e5M/QYBARpGxJq8Qjc1mbBgl4RZzlMINtD0A==
X-Google-Smtp-Source: ABdhPJzYrV95ZwIOxPy47s7byHeTNiu15hRx32Un8/nA7FoJkRZAcaROnIkGe4eFSoRGPNJOw/gzmosNAgxB2KAH/Vw=
X-Received: by 2002:a05:6102:21d1:: with SMTP id r17mr1484367vsg.19.1618488200756;
 Thu, 15 Apr 2021 05:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210415084412.51125-1-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 14:02:43 +0200
Message-ID: <CAPDyKFqpLAie9kP1Z2WXCzAaZZv7xJuE62ObGL2nD+owOLzuxA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: sdhci-s3c: simplify getting of_device_id
 match data
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 at 10:44, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Use of_device_get_match_data() to make the code slightly smaller and to
> remove the of_device_id table forward declaration.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes since v1:
> 1. Rewrite the commit msg as it is not a NULL pointer dereference.
> ---
>  drivers/mmc/host/sdhci-s3c.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index f48a788a9d3d..8e1dca625620 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -20,6 +20,7 @@
>  #include <linux/gpio.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> @@ -461,19 +462,12 @@ static int sdhci_s3c_parse_dt(struct device *dev,
>  }
>  #endif
>
> -#ifdef CONFIG_OF
> -static const struct of_device_id sdhci_s3c_dt_match[];
> -#endif
> -
>  static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
>                         struct platform_device *pdev)
>  {
>  #ifdef CONFIG_OF
> -       if (pdev->dev.of_node) {
> -               const struct of_device_id *match;
> -               match = of_match_node(sdhci_s3c_dt_match, pdev->dev.of_node);
> -               return (struct sdhci_s3c_drv_data *)match->data;
> -       }
> +       if (pdev->dev.of_node)
> +               return (struct sdhci_s3c_drv_data *)of_device_get_match_data(&pdev->dev);
>  #endif
>         return (struct sdhci_s3c_drv_data *)
>                         platform_get_device_id(pdev)->driver_data;
> --
> 2.25.1
>
