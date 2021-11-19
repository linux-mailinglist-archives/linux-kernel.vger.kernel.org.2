Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86219456BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 09:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhKSIfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 03:35:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25777 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229633AbhKSIfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 03:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637310756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tUuoKjixLQkWOo6/knJS/yxc8h9J4lm72RKU4yaFvIo=;
        b=BnHzNqTNgI98k4D2gX6o7CU2a9QdVPAefJNT3rIJ27r23V1Vjf5DTUT27McJtBz9I5Zqj5
        3rUuyokjIWYQaN2B2pFX6HnyKr+w9LJP6OREOgWnmTojrawIwNLkI6TRj9AFOIWd1pIAAK
        T+TyhzxrQjlvzLheopWrKIBrJrATXpA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-NCkPxFDAO4e3fLn2UV9EHQ-1; Fri, 19 Nov 2021 03:32:35 -0500
X-MC-Unique: NCkPxFDAO4e3fLn2UV9EHQ-1
Received: by mail-wm1-f69.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so3715371wmg.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 00:32:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tUuoKjixLQkWOo6/knJS/yxc8h9J4lm72RKU4yaFvIo=;
        b=aW8ryLzv4d5NWbFXhLsU2STCbc+x61eue7FNFlFNFBq8ffWgI81pMxoOSgRp0prch/
         ccC6Cz9D8kUTE+y0b1cj95LLsdBXhZzEx5tn9NC3micAQlmkDORVk1i0Pdbc9AfRubKH
         nwcZ7JhsStsLeV7XeVd+BfQ+86BZUJjMqkuBEkTiKzcOAnIKLh8vsuktrRLUlyek+jyt
         lBjEnbaWkX4eFNBxJFmq+dMjPj/t/AoiaQP92G9l0m86EsBD5GC8uWk2G7eE+3joWJdW
         rriTWWGFqIdrbi4YpAtOmlG54L7iyLyrsu/zbYFEWxpvVXavEOm7pgvEK+CtJCeb8EeS
         Auyw==
X-Gm-Message-State: AOAM533NdfO8vAnfbYxzCeaaYMBoqRfa2a20Qosv7DbdsGFA3ruBZZOk
        dSnHbMAJtySegAlMd6xhbuPwiWtrAGLju/D4Ofeivb30cAHUpabSMonCny4g8GhZqCqU+zdzMH8
        AyPtvuTY0kPH+YiK6BWTNDKCc
X-Received: by 2002:a05:600c:2156:: with SMTP id v22mr4877445wml.159.1637310753860;
        Fri, 19 Nov 2021 00:32:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+6a7rxjlIR8+FNOMhZH5MUe8GhJzMMes1/fzoti38R1czb1GyITps3evRL1yExeB1HLGWNA==
X-Received: by 2002:a05:600c:2156:: with SMTP id v22mr4877410wml.159.1637310753625;
        Fri, 19 Nov 2021 00:32:33 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n184sm10977123wme.2.2021.11.19.00.32.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 00:32:33 -0800 (PST)
Message-ID: <9b41eb05-a095-39af-8b76-a73fa2532e92@redhat.com>
Date:   Fri, 19 Nov 2021 09:32:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] spidev: Make probe to fail early if a spidev compatible
 is used
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org
References: <20211109225920.1158920-1-javierm@redhat.com>
 <20211110074247.g7eaq2z27bwdt4m5@pengutronix.de>
 <YZaZpx7cudaAEGIP@sirena.org.uk>
 <20211119074015.kji2hzarevxgfl5l@pengutronix.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211119074015.kji2hzarevxgfl5l@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

On 11/19/21 08:40, Uwe Kleine-König wrote:

[snip]

> 
> It affects c) only if the device tree has a device with compatible =
> "spidev". For such a device the history is:
>
>   - Before 956b200a846e ("spi: spidev: Warn loudly if instantiated from
>     DT as "spidev"") in v4.1-rc1:
>     Just bound silently
> 
>   - After 956b200a846e up to 6840615f85f6 ("spi: spidev: Add SPI ID
>     table") in v5.15-rc6:
>     The device was automatically bound with a warning
> 
>   - After 6840615f85f6:
>     The device doesn't bind automatically, when using driver_override
>     you get a warning.
> 
>   - With the proposed patch:
>     The device cannot be bound even using driver_override
>

My understanding is that there's an agreement that using "spidev" as the
specific compatible string is something that should not be supported.
 
> Not this affects also devices that use
> 
> 	compatible = "myvender,devicename", "spidev";
> 

This is indeed a corner case and I'm less sure what the kernel should do
about it. I just learned now that of_device_is_compatible() return value
is not a boolean but instead a "score":

https://elixir.bootlin.com/linux/latest/source/drivers/of/base.c#L455

I wonder if we could add another helper that returns the index instead,
and do: of_device_is_compatible_index(spi->dev.of_node, "spidev") == 0

Another option is to add an of_device_is_compatible_specific() helper.

Or just consider DT nodes with a general "spidev" compatible string to
also not be valid. I would lean towards this one I think.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

