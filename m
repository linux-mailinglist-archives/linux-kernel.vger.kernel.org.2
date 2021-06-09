Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D023A1BD7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 19:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFIRfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 13:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39585 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230413AbhFIRfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 13:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623259992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z5PeafNk3PET9iL6P0K5jSNG1YbfyZtfZ3N7TbBn370=;
        b=LCOxOkQwL7wcDE6L7jiZhXW0PRmPJtRIG1exAKUi068lMbddFv6DQj/rclBcEPFKGwOj95
        tTSr4TfcqOtCD9L7DCJgMZBJ1p6DozifP/zaSmQDh5HfU7JGwJM0y9i8eHLBdr3g0srgrO
        G7mh6ZY0heYWHyQcQCzDwrxVbBL6P6A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-AkOymzRBOuiCONY7boTKfQ-1; Wed, 09 Jun 2021 13:33:10 -0400
X-MC-Unique: AkOymzRBOuiCONY7boTKfQ-1
Received: by mail-ej1-f69.google.com with SMTP id k1-20020a17090666c1b029041c273a883dso3719679ejp.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 10:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z5PeafNk3PET9iL6P0K5jSNG1YbfyZtfZ3N7TbBn370=;
        b=mCg245YXUmWW5ANqDl02WMjEJge4cORGk373iB6msOHeLk4wmAPT4m3Nj4knqUd5/a
         dL85XLrQGMMMpe8y6ubtrBFmA6o9HNr4sZG1kFw/szE6ACkGvEd/WYX4lu76Q0RLDjFw
         ujiH9N45JUYbLuL57Z7Ek/sX1+UWmMWwId7EQc0MSromELX+OgEcR6G8lPg/ni4oOVSZ
         lttaC0kiz3kvFiYWqpRthB4Vga/5NXewYPdnbAI9+cXwRbqE0UEgLY3MgsbT1zSe9UiU
         Q07jNhL/Q8GpycpCGSGRt5BIPvLU9vbTW/RarzItna51huCojfIvA2WoY4T9U8QQF6+o
         tJcA==
X-Gm-Message-State: AOAM531LIsjSD0O+RdHFbeko8LeZc93itzkAQPiROF9EA28jzht6tjEt
        0RxDXXiGoiYhX4SyK5UEYJbuCx+cIkNVa6ukxE4/MgBHvVYAPI07OgFeNTTVfbz6ZOuAXB1WbyP
        NMWI2azT74KjEahbrpkJWEw9p
X-Received: by 2002:a17:906:2dcb:: with SMTP id h11mr954404eji.52.1623259989321;
        Wed, 09 Jun 2021 10:33:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4nbim+Zr6BK+zgNZSMI68VdIfv/jfWQlUElfYxtyDWRUb5a2I4XkK7fPwA76egn6tK0cHLQ==
X-Received: by 2002:a17:906:2dcb:: with SMTP id h11mr954397eji.52.1623259989163;
        Wed, 09 Jun 2021 10:33:09 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id i5sm178077edt.11.2021.06.09.10.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 10:33:08 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] i2c: cht-wc: Replace of_node by NULL
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wsa@kernel.org
References: <20210609173035.83777-1-andriy.shevchenko@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <12ff5e74-a38d-a1f4-3a9d-6ac9379b2924@redhat.com>
Date:   Wed, 9 Jun 2021 19:33:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609173035.83777-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/9/21 7:30 PM, Andy Shevchenko wrote:
> The driver is run on the platforms where OF node is always NULL.
> The confusion comes from IRQ domain APIs that take either OF or
> firmware node as input parameter. Since fwnode is not used here
> either, replace of_node by NULL.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: rewrote in order to pass NULL instead of of_node (Hans)
>  drivers/i2c/busses/i2c-cht-wc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> 
> diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
> index 08f491ea21ac..1cf68f85b2e1 100644
> --- a/drivers/i2c/busses/i2c-cht-wc.c
> +++ b/drivers/i2c/busses/i2c-cht-wc.c
> @@ -354,8 +354,7 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
>  		return ret;
>  
>  	/* Alloc and register client IRQ */
> -	adap->irq_domain = irq_domain_add_linear(pdev->dev.of_node, 1,
> -						 &irq_domain_simple_ops, NULL);
> +	adap->irq_domain = irq_domain_add_linear(NULL, 1, &irq_domain_simple_ops, NULL);
>  	if (!adap->irq_domain)
>  		return -ENOMEM;
>  
> 

