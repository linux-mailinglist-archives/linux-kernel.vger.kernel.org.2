Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C335F790
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 17:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352080AbhDNPZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 11:25:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41622 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346177AbhDNPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 11:25:49 -0400
Received: from mail-ej1-f72.google.com ([209.85.218.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWhOQ-0003HY-S3
        for linux-kernel@vger.kernel.org; Wed, 14 Apr 2021 15:25:26 +0000
Received: by mail-ej1-f72.google.com with SMTP id p11so550838eju.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 08:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1gNdMZIY7k9qgwfrohIjWBJglr1iMiMfvSgX5G9T2aM=;
        b=pxuu9RoN6GgBzJNyhPUD3IFWZJcXCircszCLxh+QcnNwPAxRyWDEXA9VBRP1WoxiG8
         hyc0Ss9LDX/v02QRodvPU9xgFVgRzCPW6/ZwCKvuNjDaQa8taLUgbeXjdFgV/u7VSowJ
         e3peWYbrv+Abovh5+Yo+thrrvdoz6S3bzQh8NiWt9vsdLInRodOV85cnwmNcXk8KmSF+
         91vLvU8MqA0bzLRwMUfQdJOiLTPIu3Lh/Z3Hh5tVY14eybaZa0LrCY9GpnZ/v2EW1X0D
         DQK1eCW9HbYU9n0GLCwACsO4BZt7xSp4VpjLvYE6BwDmAfd0ayvpZHsl6BdNvy+Oz4vp
         Nqfw==
X-Gm-Message-State: AOAM5324xsfJlYCahtf5L1FTRgBtWU3uOGUvApNMXGEoEWI70ktQhMMp
        O4REX26h4XL+eSTphEd98gT97l2Cq0SMYiwa6rzK6NmgD1LJNDoNTij0hgDMt4FYrHhKnJguYs6
        CTRYpxnoxK8/drP/Qt+SHj1kbM9BTNQ30btAVrgHLHg==
X-Received: by 2002:aa7:d14a:: with SMTP id r10mr31775574edo.385.1618413926563;
        Wed, 14 Apr 2021 08:25:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1JCAj/r+e3/uIOKJ2XZglO0McMtQzQ8diU5aN0gEjel2Jj0k1vvDuRlTIenHIoA7tdTyV1A==
X-Received: by 2002:aa7:d14a:: with SMTP id r10mr31775562edo.385.1618413926402;
        Wed, 14 Apr 2021 08:25:26 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id n14sm6781032ejy.90.2021.04.14.08.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 08:25:25 -0700 (PDT)
Subject: Re: [PATCH 1/3] mmc: sdhci-s3c: fix possible NULL pointer dereference
 when probed via platform
To:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
References: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <a0ac5d21-acc1-825a-1585-f8d897902b14@canonical.com>
Date:   Wed, 14 Apr 2021 17:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210414151242.102313-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2021 17:12, Krzysztof Kozlowski wrote:
> The driver can be matched by legacy platform way or OF-device matching.
> In the first case, of_match_node() can return NULL, which immediately
> would be dereferenced to get the match data.
> 
> Addresses-Coverity: Dereference null return value
> Fixes: cd1b00eb24b0 ("mmc: sdhci-s3c: Add device tree support")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
> 
> Not tested on HW, but the code should be equivalent (plus safer).
> 
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
>  			struct platform_device *pdev)
>  {
>  #ifdef CONFIG_OF
> -	if (pdev->dev.of_node) {
> -		const struct of_device_id *match;
> -		match = of_match_node(sdhci_s3c_dt_match, pdev->dev.of_node);

Now I have second thoughts whether NULL pointer can actually happen.  If
device is matched via platform/board files, maybe the pdev->dev.of_node
will be NULL thus skipping this branch?

Could there be a case where device is matched via platform_device_id()
(which has different name than compatible!) and (pdev->dev.of_node) is
still assigned? Maybe in case of out of tree DTS?

Anyway, the patch makes the code simpler/smaller, so I still think it is
reasonable. Just the severity of issue is questionable...

Best regards,
Krzysztof
