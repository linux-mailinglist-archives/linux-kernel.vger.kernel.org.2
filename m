Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DD640FF80
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 20:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbhIQSjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 14:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234566AbhIQSjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 14:39:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631903856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2uGSUJ4OwEDinUYdbE9Xm9EZmCzZGXaFlbE5avYj6BU=;
        b=HAXr+reeIrWgIG2HORKAqF7eUQS9F9b1bB0EnPhQbL4uWhTptIE3EGWdgdfTKsMG+oae10
        esIooirIeNfSbQs5WZuBESY18vqhSGvRDCcwLeM0mPnvpMPpoBqInLipsZQBqit6mMBpio
        o8M+Mg8qRonjKNIWSV7+eoRMJuiYo58=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-eCKz45_GOUqPFbhUxldQQg-1; Fri, 17 Sep 2021 14:37:35 -0400
X-MC-Unique: eCKz45_GOUqPFbhUxldQQg-1
Received: by mail-ed1-f71.google.com with SMTP id x14-20020a50ba8e000000b003d5a565de3aso8969147ede.18
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 11:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2uGSUJ4OwEDinUYdbE9Xm9EZmCzZGXaFlbE5avYj6BU=;
        b=TZT7EpjfXBEP3JFgUNw+igW95FOQBcGs8N9l2wMLBFcQE7JJhzlkYgDPX+9h+YGPe/
         bDmSDORqbjmTICEV/YvdMoCjCYC5CsklD+ELDm+QUTW4UDQSQs273KhGLF11aoPJbbUs
         BWxj3HpQ1t0mlGeENyNf3kMtCBHr3/Q1Dm5r7ps05QzvI+uOrXmOGEWB1nnTW8nBG5Iq
         mLL0wt2CWhqsgwx10SUoXyuu1jxjPsL0WYXONV0yxvQoH1SN65kOhet2LESadt8NCXRs
         C8aZkkMiEZnLRZQpxTFctgNUOYwX4UEl2MnEP/ZNRln2OvyLf5Sn+SFwonl/B2TtCW8X
         R90w==
X-Gm-Message-State: AOAM531l7LKdL3iN6wGw9Reeoor316UJWB5xdxPMaBbgovLreyjIohwi
        hBxOPDTeMQR5XoZgZimtLhsoS35g///HmtoGimctlqbgcmPtjmuvIltDOEOTy8fjS57DBer9otq
        Bkgh+m75oyzQRt7Y76bIkaCiCzOxh+zCrvKfr2pzpZ5i5XOp4UuB8Zm410ojtcFH+bdBSH3vRSr
        X+
X-Received: by 2002:a50:e1c4:: with SMTP id m4mr6128306edl.307.1631903853557;
        Fri, 17 Sep 2021 11:37:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNbhN9Xkm6HUn/UupN6L6rbjYldGZ9ByZPcxb82N8bRPpnSTbC7H/rf8BnRjTmNHq7BNslfg==
X-Received: by 2002:a50:e1c4:: with SMTP id m4mr6128287edl.307.1631903853384;
        Fri, 17 Sep 2021 11:37:33 -0700 (PDT)
Received: from x1.localdomain ([2a0e:5700:4:11:334c:7e36:8d57:40cb])
        by smtp.gmail.com with ESMTPSA id e22sm3175909edu.35.2021.09.17.11.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Sep 2021 11:37:33 -0700 (PDT)
Subject: Re: [PATCH] Input: silead - Make use of the helper function
 dev_err_probe()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210916153426.15158-1-caihuoqing@baidu.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <83e5b7db-4707-0ab3-c02e-e467c3190358@redhat.com>
Date:   Fri, 17 Sep 2021 20:37:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210916153426.15158-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/16/21 5:34 PM, Cai Huoqing wrote:
> When possible use dev_err_probe help to properly deal with the
> PROBE_DEFER error, the benefit is that DEFER issue will be logged
> in the devices_deferred debugfs file.
> Using dev_err_probe() can reduce code size, and the error value
> gets printed.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/input/touchscreen/silead.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/silead.c b/drivers/input/touchscreen/silead.c
> index 1ee760bac0cf..adfac271f0b5 100644
> --- a/drivers/input/touchscreen/silead.c
> +++ b/drivers/input/touchscreen/silead.c
> @@ -548,11 +548,9 @@ static int silead_ts_probe(struct i2c_client *client,
>  
>  	/* Power GPIO pin */
>  	data->gpio_power = devm_gpiod_get_optional(dev, "power", GPIOD_OUT_LOW);
> -	if (IS_ERR(data->gpio_power)) {
> -		if (PTR_ERR(data->gpio_power) != -EPROBE_DEFER)
> -			dev_err(dev, "Shutdown GPIO request failed\n");
> -		return PTR_ERR(data->gpio_power);
> -	}
> +	if (IS_ERR(data->gpio_power))
> +		return dev_err_probe(dev, PTR_ERR(data->gpio_power),
> +				     "Shutdown GPIO request failed\n");
>  
>  	error = silead_ts_setup(client);
>  	if (error)
> 

