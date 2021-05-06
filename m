Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1ED374E39
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 06:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhEFEHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 00:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhEFEHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 00:07:41 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93EBC061574;
        Wed,  5 May 2021 21:06:42 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id c36-20020a05683034a4b02902a5b84b1d12so3760094otu.8;
        Wed, 05 May 2021 21:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=45qqyDWvz+dGKIejtJRqM5vC5ZpgYtzj+432XuvSFYg=;
        b=gp/MscTpC9wD2RAN5/6tv+vppvbIP3BxG9jekPePdyodY50TmeynGGlWfuesbQfzFe
         8Y3S5EV3E3vEw7lW8NJFfi5YvPHpN1l/i4r3kCeCQbGCplik5gHxAJBod5pznHGwtQgz
         lU2WxaCryWtd3Pue3nHD4RS9UIi6RPIbaUJAF4KP5kwZe91jA3O0D90sRMZP1jF9JlJv
         U4K34yW8pID9tr7TSzq7aTgnvg1iedfjsQpIF7eEaNPgcR2azllm3PMiDGI9UA4+KRGU
         5k8I6H8ceM4dtvRYIpt1rtjj2Tjpylot135U6VTL8wlguxn2L7SEmTzO9rtQgq7PrleA
         Fzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=45qqyDWvz+dGKIejtJRqM5vC5ZpgYtzj+432XuvSFYg=;
        b=Nr6/86m6Mnagvi9D7f29WIXFgw2jEoj78WK9Rtd+F5Q+BqIbitQ58PZG5IOtMKE8Dm
         jpUxHka2hI8UH17ylkPmQu6341lZc66exBs5UDJj+ZGvNHb7qxM/LyGmdJXjlaes4ujp
         iF4nf1UWD42xxnklAOVh7Trht8Z6J3HVRaq+oG/zbw+WkTsmXrwQsfyEj8uAPhlva5VV
         RCWLyrWvtHMlOGINxtfxZWByRvFQ407Wu2LuombGez1fo+/aGhrXjW6fSi78T/5G/mDB
         7A/ziaUqZ6Dar833My2XN6/kahBi4PyVoR4/JMd9QRRcLZ3TprYKCvWCfMv9SM0vnhxB
         sdOA==
X-Gm-Message-State: AOAM531OF4WPHPtlAHGBEE7g/LIr92zvhr5LXOs45RiHrImsZJhN2m6Z
        qymBDkwLDxEwgwhO2KqsUr96EXJ0qeE=
X-Google-Smtp-Source: ABdhPJyua4JKgWxjygaf+08jeyJd8yarpAuA7LLJpt9pEOCQ8JKNz2JnZN3KwkqK0HrnYvMFVOkTNg==
X-Received: by 2002:a9d:247:: with SMTP id 65mr1661261otb.330.1620274001747;
        Wed, 05 May 2021 21:06:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3sm241371oic.48.2021.05.05.21.06.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 21:06:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 1/3] hwmon: (pmbus) Add new flag
 PMBUS_READ_STATUS_AFTER_FAILED_CHECK
To:     Erik Rosen <erik.rosen@metormote.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210505183248.57082-1-erik.rosen@metormote.com>
 <20210505183248.57082-2-erik.rosen@metormote.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <bbbe1330-dd94-29a1-0680-b9cf91e8f962@roeck-us.net>
Date:   Wed, 5 May 2021 21:06:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210505183248.57082-2-erik.rosen@metormote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/21 11:32 AM, Erik Rosen wrote:
> Some PMBus chips end up in an undefined state when trying to read an
> unsupported register. For such chips, it is necessary to reset the
> chip pmbus controller to a known state after a failed register check.
> This can be done by reading a known register. By setting this flag the
> driver will try to read the STATUS register after each failed
> register check. This read may fail, but it will put the chip into a
> known state.
> 
> Signed-off-by: Erik Rosen <erik.rosen@metormote.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/pmbus/pmbus_core.c |  2 ++
>  include/linux/pmbus.h            | 13 +++++++++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index aadea85fe630..cb0b3c7c3434 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -512,6 +512,8 @@ static bool pmbus_check_register(struct i2c_client *client,
>  	rv = func(client, page, reg);
>  	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
>  		rv = pmbus_check_status_cml(client);
> +	if (rv < 0 && (data->flags & PMBUS_READ_STATUS_AFTER_FAILED_CHECK))
> +		data->read_status(client, -1);
>  	pmbus_clear_fault_page(client, -1);
>  	return rv >= 0;
>  }
> diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
> index 12cbbf305969..edd7c84fef65 100644
> --- a/include/linux/pmbus.h
> +++ b/include/linux/pmbus.h
> @@ -43,6 +43,19 @@
>   */
>  #define PMBUS_NO_CAPABILITY			BIT(2)
>  
> +/*
> + * PMBUS_READ_STATUS_AFTER_FAILED_CHECK
> + *
> + * Some PMBus chips end up in an undefined state when trying to read an
> + * unsupported register. For such chips, it is necessary to reset the
> + * chip pmbus controller to a known state after a failed register check.
> + * This can be done by reading a known register. By setting this flag the
> + * driver will try to read the STATUS register after each failed
> + * register check. This read may fail, but it will put the chip in a
> + * known state.
> + */
> +#define PMBUS_READ_STATUS_AFTER_FAILED_CHECK	BIT(3)
> +
>  struct pmbus_platform_data {
>  	u32 flags;		/* Device specific flags */
>  
> 

