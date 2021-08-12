Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A555B3EA76D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbhHLPU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 11:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46044 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236850AbhHLPU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 11:20:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628781630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5OMPPEs9ujuHSvx/fxuwi84cH52/9VQwos/NS7fl/I=;
        b=hQ8qosJBNn1xnp8WQSXgbP9JCM+1hLP8Cvtq+8xCYNNqHA1JMCwQ3bm5IpKvfT1XnU3Lmz
        K44WghXAYCX5bBfgUylXKw0/6FZQam/FuyY7ncq8szbw94ht3KbAkZhhRz3BSvCIW4Wbcb
        iURTKc/6pqv9c3vEfcPEcJ0QQsO+HdE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-gx81Hpd9OhqzLK9emCwbKw-1; Thu, 12 Aug 2021 11:20:28 -0400
X-MC-Unique: gx81Hpd9OhqzLK9emCwbKw-1
Received: by mail-ed1-f69.google.com with SMTP id g3-20020a0564024243b02903be33db5ae6so3211595edb.18
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 08:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A5OMPPEs9ujuHSvx/fxuwi84cH52/9VQwos/NS7fl/I=;
        b=cE8vy1bI9+jGyjUO9Mfw8Fg1zDr/bSsWGZoH+FMO/Ql/NV1gFnOg+/ZnnV6ju2mtLU
         fFaasqUCUqmSl7HikjUny3tWRXvDHet+Xq/g5poRoHP+kguUzmlOzkhPASCrScGKabUZ
         70/0ItJnugYAfXd87ZjTHMBXQrB1adkzQWS+x+bjTQexS5wdULigfx2l8nQ/3xldEohz
         MgeTAb9LA8lyGKg7WD2VtPLOUCe1ZCY0qx9T/ZkxiP4Olb8eyIY7HTG+4N3HVx/jiQet
         pMPRwmwPY2Jf0SEBcBXVXyQwpQnxhcGvwTBQ3nIDZT6qMIVQtVAUB5Hv4pkhA8agokAv
         JwuQ==
X-Gm-Message-State: AOAM531lzy3nRjLwzXsV0HpIxCqYyVB+HJN1XxWGOCxJAg6ynK9Oe++O
        adaQ/siTIdRVTeJDFkhIldB0XkcBPA2JxX2JOCgaaHP19z+6176ZvB7aY2k6AREONLfEr/AnLee
        B1Hc31mVUC60lLWbR0goA3gVq
X-Received: by 2002:a17:906:b782:: with SMTP id dt2mr2289073ejb.294.1628781626988;
        Thu, 12 Aug 2021 08:20:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywupV1SnYcXA6ApxaFvollFdpNxIJ9e+zDqIZXTpGac6DGPWBaUtFJCw4GtFfotIFaTRHwOw==
X-Received: by 2002:a17:906:b782:: with SMTP id dt2mr2289061ejb.294.1628781626752;
        Thu, 12 Aug 2021 08:20:26 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id jo17sm941344ejb.40.2021.08.12.08.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 08:20:26 -0700 (PDT)
Subject: Re: [PATCH] power: supply: axp288_charger: Use the defined variable
 to clean code
To:     Tang Bin <tangbin@cmss.chinamobile.com>, sre@kernel.org,
        wens@csie.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <20210811104929.24608-1-tangbin@cmss.chinamobile.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <60b7038f-2c68-4559-6a97-a5f2bc97647f@redhat.com>
Date:   Thu, 12 Aug 2021 17:20:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210811104929.24608-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/11/21 12:49 PM, Tang Bin wrote:
> Use the defined variable "dev" to make the code cleaner.
> 
> Co-developed-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  drivers/power/supply/axp288_charger.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/supply/axp288_charger.c b/drivers/power/supply/axp288_charger.c
> index a4df1ea92..b9553be9b 100644
> --- a/drivers/power/supply/axp288_charger.c
> +++ b/drivers/power/supply/axp288_charger.c
> @@ -813,7 +813,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	if (val == 0)
>  		return -ENODEV;
>  
> -	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>  	if (!info)
>  		return -ENOMEM;
>  
> @@ -823,7 +823,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  
>  	info->cable.edev = extcon_get_extcon_dev(AXP288_EXTCON_DEV_NAME);
>  	if (info->cable.edev == NULL) {
> -		dev_dbg(&pdev->dev, "%s is not ready, probe deferred\n",
> +		dev_dbg(dev, "%s is not ready, probe deferred\n",
>  			AXP288_EXTCON_DEV_NAME);
>  		return -EPROBE_DEFER;
>  	}
> @@ -834,8 +834,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  			dev_dbg(dev, "EXTCON_USB_HOST is not ready, probe deferred\n");
>  			return -EPROBE_DEFER;
>  		}
> -		dev_info(&pdev->dev,
> -			 "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
> +		dev_info(dev, "Using " USB_HOST_EXTCON_HID " extcon for usb-id\n");
>  	}
>  
>  	platform_set_drvdata(pdev, info);
> @@ -874,7 +873,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  	INIT_WORK(&info->otg.work, axp288_charger_otg_evt_worker);
>  	info->otg.id_nb.notifier_call = axp288_charger_handle_otg_evt;
>  	if (info->otg.cable) {
> -		ret = devm_extcon_register_notifier(&pdev->dev, info->otg.cable,
> +		ret = devm_extcon_register_notifier(dev, info->otg.cable,
>  					EXTCON_USB_HOST, &info->otg.id_nb);
>  		if (ret) {
>  			dev_err(dev, "failed to register EXTCON_USB_HOST notifier\n");
> @@ -899,7 +898,7 @@ static int axp288_charger_probe(struct platform_device *pdev)
>  					NULL, axp288_charger_irq_thread_handler,
>  					IRQF_ONESHOT, info->pdev->name, info);
>  		if (ret) {
> -			dev_err(&pdev->dev, "failed to request interrupt=%d\n",
> +			dev_err(dev, "failed to request interrupt=%d\n",
>  								info->irq[i]);
>  			return ret;
>  		}
> 

