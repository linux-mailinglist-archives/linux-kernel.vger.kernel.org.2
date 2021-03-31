Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F27349154
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhCYL7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:59:24 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52957 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhCYL7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:59:17 -0400
Received: from mail-wr1-f70.google.com ([209.85.221.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lPOdw-0007un-3K
        for linux-kernel@vger.kernel.org; Thu, 25 Mar 2021 11:59:16 +0000
Received: by mail-wr1-f70.google.com with SMTP id n17so2552118wrq.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 04:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DfiLBHztHE4rXP9YTfO8+HSekNR/3pABhRdVX34TR+A=;
        b=Fb+RwLcl5mn9PYEnCF4cTYQdiWDgn+CbWmRa0W+b2BTPibkFAGV9sltmni3EQMi7Zo
         w3OpbpwHS7jMSb+8mCg8j8pDKjoclvkgXXSpkbGBpOi32/njLS4vkfr4LKVDluDJScP0
         W8tA269OdrGmdG8o7sx7Qr/BSABplif1xVmXFosyysoJ3zt/7EiB36z5WHfyWbF3KXwq
         q/mMCpNN264vGGyrkA5UKAN9pFQdUvRH/uEsEa1NWwwe0WHDgzoDtngFGbdvbbk19kJg
         +wMHx/VngMtn4hBvqiOgMhlS7+sER5qjt0kjs3khkIDKIdlANaqJ9DcFmuXFO68sx9j4
         MXFA==
X-Gm-Message-State: AOAM533E58DGgSd9w2cwYuiFl8iOP6rCim2DMhuVFO73iJ4VLKBS78Vt
        tPYBYITNVCet8GogbnPfnl5PPyvt7pxKCllnNnRVV+Ixd/JaZ1yYcFXoYFeEWlmAXEfVH+/pSnp
        BmQbkiui5ow8mQu+vubt6KuBXu/KfR4Az4VpN2uhJ2Q==
X-Received: by 2002:a1c:5f89:: with SMTP id t131mr7340331wmb.173.1616673555713;
        Thu, 25 Mar 2021 04:59:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVSjSgCphFJsd4YHNWcAP1j5EjsqiQU9p4nuTKndG2SXF8I2/J+tpPUwLhskg+gbiQC5L4iA==
X-Received: by 2002:a1c:5f89:: with SMTP id t131mr7340312wmb.173.1616673555490;
        Thu, 25 Mar 2021 04:59:15 -0700 (PDT)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id r1sm7996635wrj.63.2021.03.25.04.59.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 04:59:15 -0700 (PDT)
Subject: Re: [PATCH] regulator: Use IRQF_ONESHOT
To:     Jian Dong <dj0227@163.com>, matthias.bgg@gmail.com,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        huyue2@yulong.com, Jian Dong <dongjian@yulong.com>
References: <1616501538-120724-1-git-send-email-dj0227@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9428d264-aafa-793f-8c6c-86c55213f5f9@canonical.com>
Date:   Thu, 25 Mar 2021 12:59:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1616501538-120724-1-git-send-email-dj0227@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2021 13:12, Jian Dong wrote:
> From: Jian Dong <dongjian@yulong.com>
> 
> Fixes coccicheck error:
> 
> drivers/regulator/mt6360-regulator.c:388:8-33: ERROR:
> drivers/regulator/pca9450-regulator.c:781:7-32: ERROR:
> drivers/regulator/slg51000-regulator.c:480:8-33: ERROR:
> drivers/regulator/qcom-labibb-regulator.c:364:8-33: ERROR:
> Threaded IRQ with no primary handler requested without IRQF_ONESHOT
> 
> Signed-off-by: Jian Dong <dongjian@yulong.com>
> ---
>  drivers/regulator/mt6360-regulator.c      | 4 ++--
>  drivers/regulator/pca9450-regulator.c     | 2 +-
>  drivers/regulator/qcom-labibb-regulator.c | 3 ++-
>  drivers/regulator/slg51000-regulator.c    | 4 ++--
>  4 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/regulator/mt6360-regulator.c b/drivers/regulator/mt6360-regulator.c
> index 15308ee..947350d 100644
> --- a/drivers/regulator/mt6360-regulator.c
> +++ b/drivers/regulator/mt6360-regulator.c
> @@ -385,8 +385,8 @@ static int mt6360_regulator_irq_register(struct platform_device *pdev,
>  			return irq;
>  		}
>  
> -		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, irq_desc->handler, 0,
> -						irq_desc->name, rdev);
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL, irq_desc->handler,
> +					IRQF_ONESHOT, irq_desc->name, rdev);

This does not look like trivial rename/replace fix. This should be
tested but it looks that you just did what coccinelle asked for, without
testing.

>  		if (ret) {
>  			dev_err(&pdev->dev, "Fail to request %s irq\n", irq_desc->name);
>  			return ret;
> diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
> index 2f7ee21..d4bc1c3 100644
> --- a/drivers/regulator/pca9450-regulator.c
> +++ b/drivers/regulator/pca9450-regulator.c
> @@ -780,7 +780,7 @@ static int pca9450_i2c_probe(struct i2c_client *i2c,
>  
>  	ret = devm_request_threaded_irq(pca9450->dev, pca9450->irq, NULL,
>  					pca9450_irq_handler,
> -					(IRQF_TRIGGER_FALLING | IRQF_ONESHOT),
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,

How this is related to the missing IRQF_ONESHOT?

>  					"pca9450-irq", pca9450);
>  	if (ret != 0) {
>  		dev_err(pca9450->dev, "Failed to request IRQ: %d\n",
> diff --git a/drivers/regulator/qcom-labibb-regulator.c b/drivers/regulator/qcom-labibb-regulator.c
> index de25e32..cac5fd5 100644
> --- a/drivers/regulator/qcom-labibb-regulator.c
> +++ b/drivers/regulator/qcom-labibb-regulator.c
> @@ -362,7 +362,8 @@ static int qcom_labibb_set_ocp(struct regulator_dev *rdev)
>  		return ret;
>  
>  	return devm_request_threaded_irq(vreg->dev, vreg->ocp_irq, NULL,
> -					 qcom_labibb_ocp_isr, irq_flags,
> +					 qcom_labibb_ocp_isr,
> +					 irq_flags | IRQF_ONESHOT,
>  					 ocp_irq_name, vreg);
>  }
>  
> diff --git a/drivers/regulator/slg51000-regulator.c b/drivers/regulator/slg51000-regulator.c
> index 75a941f..3f310ab 100644
> --- a/drivers/regulator/slg51000-regulator.c
> +++ b/drivers/regulator/slg51000-regulator.c
> @@ -479,8 +479,8 @@ static int slg51000_i2c_probe(struct i2c_client *client)
>  	if (chip->chip_irq) {
>  		ret = devm_request_threaded_irq(dev, chip->chip_irq, NULL,
>  						slg51000_irq_handler,
> -						(IRQF_TRIGGER_HIGH |
> -						IRQF_ONESHOT),
> +						IRQF_TRIGGER_HIGH |
> +						IRQF_ONESHOT,
>  						"slg51000-irq", chip);

How this is related to the missing IRQF_ONESHOT?

Best regards,
Krzysztof
