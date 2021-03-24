Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B516C347480
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhCXJZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:25:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231678AbhCXJZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616577918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KiJLpsb7sBqIFEZS6k034QylOs9bBEzr4nsRk/aiDe8=;
        b=ZHDvb8yHlVG5wTwDM6eDRiW0HaHj5y0aYes7xSA5EBXz34lGGuKqiSL0G6lzeKlLmfamEm
        lUDWFhiCbEh8bHnSG87IUL4zzZ2IiworLcC7XlpC8622G0xa5r34B+iMCHGwPo0Hp5HwmS
        BGJcIVyIjYmD5DFxvG8VhmlSxwS2dZA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-rv3FlocvNba8BZvygKyziw-1; Wed, 24 Mar 2021 05:25:16 -0400
X-MC-Unique: rv3FlocvNba8BZvygKyziw-1
Received: by mail-ej1-f70.google.com with SMTP id mj6so636656ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 02:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KiJLpsb7sBqIFEZS6k034QylOs9bBEzr4nsRk/aiDe8=;
        b=JKjquL0rIC1GSSYrJNLSjp1TY98+BXpWm/wQ3ZInyiv9d7neYi3Y8welWXLnxUBMvW
         pFYr+qhRjpRA1JrSF54AG3fSry4DS5wKnFz0famqSWqrCGKvXd1jxUYUHJSIZUCiVSrO
         8WKytCwi+2Cv19HsMkYoFoRXET+BjS/DUGGTBbHRu9tTx550Ihs80eXv8KNGS9XoXRUL
         RZ4bV33RdC08JpElcS3R8mDeZl4hCkMR/XBTsvWJvZJo8apoNDFj3wIdfW+wnAYLxxyy
         6rGm1ybDMGUcdoUSl8BXu3axXtsEHe8eYa83kMR2cHVYwAJ8FUHgqiBoRO233f3W1GLq
         bdfQ==
X-Gm-Message-State: AOAM532WQfRm+tkOo5MOMe5HYBNK33xcZZO36aqw6lKwB0xLjt6r6ZuV
        AvRFsP/xfhmPcRqCxE7C3ENulbPcvRaUoHwhk5kR/qNMEtmttaUJ8SJ7ZutbOvA4PXYDeEirIDd
        qaqHIu5UNv1WvYXShtfvY1Yo/
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr2411481ede.271.1616577915030;
        Wed, 24 Mar 2021 02:25:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx8V99Ml56KJxiioMzpj7liCOYIdYohqtPnMXbGUTkOxugweGmjzgcdLDZgoJhNHBmZAVkj8g==
X-Received: by 2002:a05:6402:27d4:: with SMTP id c20mr2411467ede.271.1616577914888;
        Wed, 24 Mar 2021 02:25:14 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q26sm632370eja.45.2021.03.24.02.25.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Mar 2021 02:25:14 -0700 (PDT)
Subject: Re: [PATCH 1/2] extcon: extcon-gpio: Log error if work-queue init
 fails
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <cover.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
 <bfd893701ac3d239fef856d2f589063983422100.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <1860d4e8-2e3a-fe05-cab9-782f3e35b9ab@redhat.com>
Date:   Wed, 24 Mar 2021 10:25:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <bfd893701ac3d239fef856d2f589063983422100.1616574973.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/24/21 10:21 AM, Matti Vaittinen wrote:
> Add error print for probe failure when resource managed work-queue
> initialization fails.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Suggested-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/extcon/extcon-gpio.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon-gpio.c b/drivers/extcon/extcon-gpio.c
> index 4105df74f2b0..8ea2cda8f7f3 100644
> --- a/drivers/extcon/extcon-gpio.c
> +++ b/drivers/extcon/extcon-gpio.c
> @@ -114,8 +114,10 @@ static int gpio_extcon_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	ret = devm_delayed_work_autocancel(dev, &data->work, gpio_extcon_work);
> -	if (ret)
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize delayed_work");
>  		return ret;
> +	}

The only ret which we can have here is -ENOMEM and as a rule we don't log
errors for those, because the kernel memory-management code already complains
loudly when this happens.

So IMHO this patch should be dropped.

Regards,

Hans




>  
>  	/*
>  	 * Request the interrupt of gpio to detect whether external connector
> 

