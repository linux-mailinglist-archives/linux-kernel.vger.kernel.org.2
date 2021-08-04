Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0B373DFC6D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhHDIFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:05:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39437 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236034AbhHDIEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:04:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628064263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C8JhLLtWeVm1W46th06VECpu4490VjDvsxVKWpqBsFE=;
        b=DWh06UpgDh2+A9FgsGgYzR3X7oxfkP9DLLbzxrcKGgn//TGhpqzXBHcl2Wrf/zgUMqw574
        iQbP/X2AHuSy8EHgMxXqWNt2EiZsBTbmSLWaSQizFhzwtEiWmvlDfZqH+HYFPx8kr9MjmU
        /sUeBAfMP3pOBxphc5UGQHBrWOLtlHY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-nkiSkACLPdSWVtePggIB9g-1; Wed, 04 Aug 2021 04:04:22 -0400
X-MC-Unique: nkiSkACLPdSWVtePggIB9g-1
Received: by mail-ed1-f71.google.com with SMTP id y19-20020a0564021713b02903bbfec89ebcso1039002edu.16
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 01:04:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C8JhLLtWeVm1W46th06VECpu4490VjDvsxVKWpqBsFE=;
        b=HGWt6DAh4+kBzD7ymlIV8+tqhcsjeMxExurBAq45YjwfWNBrMY6yaj8RPjgZYUgZSi
         7jq1/aWKjUFSFgQxQ7gmlMxw8eQHwWZSjDxECsGg2D2Btf1zW23BRAy8ysiebZLKRLE8
         aSNH447iINC+UFzshQKuuKWbo3qvItWP5j0u1zWfHfdePuEP3Hqpu887s+Cuyw6PAdio
         gI2TKZr0vcXM9scBBjbzCMfA0KKXiEKKW1yErXuBLAX/Wzn5+wCNt7txZyihZ2heJWmL
         z409lWRG5DeYK6TUAhQgE85hCVElRJ1s21fOLn2hny4DqJ/na6F+OUH1rV/COKMnbBnX
         uN9g==
X-Gm-Message-State: AOAM531YGzNR1nv0Sl4AwdfMAz9wydHc3Ddb1SFLx1bMqRwPVUonPOnd
        EirIgGsVgbdFzYiwLNAwD8w3PLMQkEZCjXjDUbWjAyQx0B11UV4ZVIKJZXJciw3CG6ZkyM1p1QB
        D+ka9j9tmpjaqd+lUMpBHUxzk
X-Received: by 2002:a17:906:12c6:: with SMTP id l6mr25518055ejb.373.1628064260936;
        Wed, 04 Aug 2021 01:04:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcX3pgtodGX9bn2A2Q9UPigJDSYOZREOJcOSv0/eYTJfsJ0M5wXc9FoFdW+LwQB1tUQ8gJOg==
X-Received: by 2002:a17:906:12c6:: with SMTP id l6mr25518017ejb.373.1628064260652;
        Wed, 04 Aug 2021 01:04:20 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m21sm617090edc.5.2021.08.04.01.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 01:04:20 -0700 (PDT)
Subject: Re: [PATCH v1 4/5] Bluetooth: hci_bcm: Use acpi_gpio_get_*_resource()
 helpers
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
References: <20210803192905.72246-1-andriy.shevchenko@linux.intel.com>
 <20210803192905.72246-4-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9fceba7d-627b-bec2-6315-46e66b646534@redhat.com>
Date:   Wed, 4 Aug 2021 10:04:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210803192905.72246-4-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/3/21 9:29 PM, Andy Shevchenko wrote:
> ACPI provides generic helpers to get GPIO interrupt and IO resources.
> Use it instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

As explained in my reply to 3/5 this makes the code a lot harder
to read with little to no gain, so NACK from me for this one.

Regards,

Hans

> ---
>  drivers/bluetooth/hci_bcm.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 16f854ac19b6..ed99fcde2523 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -911,15 +911,6 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
>  		dev->irq_active_low = true;
>  		break;
>  
> -	case ACPI_RESOURCE_TYPE_GPIO:
> -		gpio = &ares->data.gpio;
> -		if (gpio->connection_type == ACPI_RESOURCE_GPIO_TYPE_INT) {
> -			dev->gpio_int_idx = dev->gpio_count;
> -			dev->irq_active_low = gpio->polarity == ACPI_ACTIVE_LOW;
> -		}
> -		dev->gpio_count++;
> -		break;
> -
>  	default:
>  		break;
>  	}
> @@ -927,6 +918,12 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
>  	if (serdev_acpi_get_uart_resource(ares, &uart)) {
>  		dev->init_speed = uart->default_baud_rate;
>  		dev->oper_speed = 4000000;
> +	} else if (acpi_gpio_get_irq_resource(ares, &gpio)) {
> +		dev->gpio_int_idx = dev->gpio_count;
> +		dev->irq_active_low = gpio->polarity == ACPI_ACTIVE_LOW;
> +		dev->gpio_count++;
> +	} else if (acpi_gpio_get_io_resource(ares, &gpio)) {
> +		dev->gpio_count++;
>  	}
>  
>  	return 0;
> 

