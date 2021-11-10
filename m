Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8104944BCDC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhKJIbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:31:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41210 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229931AbhKJIbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636532942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YihxrOMmNt2oqWpAuNo21m+sY73LGbUIdvBRibcMMgc=;
        b=BpIFf9/caayvnJhJy4cXwc8pRJ2Q5OMPgDkDNcck1nxlkyKPZ2gH45tKnJWU1vhfRe3R7D
        RYxdVJTmQIAseIPqQ2/YahvXw959QWruD8Y9B2lvB6bz0QKO3bdGAt6/Zn2CNl2AiQXmNJ
        kPlNNzQ0mWILqNBPDX9jSxWf2ywi3S4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-3XpI7jNqNXGvl77tOUI36Q-1; Wed, 10 Nov 2021 03:29:00 -0500
X-MC-Unique: 3XpI7jNqNXGvl77tOUI36Q-1
Received: by mail-wm1-f70.google.com with SMTP id 67-20020a1c0046000000b0032cd88916e5so779926wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:29:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YihxrOMmNt2oqWpAuNo21m+sY73LGbUIdvBRibcMMgc=;
        b=JrXRbVni0gfmNsmOZ3Ct4WLmxt8ItXDHFjrnkjw1xMRqZxF4PL7ac8y3XrSMM0zpYD
         T0e7CLjeDzgm7K4NXL0rThJzMksxZzQeCvQFvdLVp4uooqGvGLEcDlavVDFLdp9TgfA+
         k/X54I+4/AZ7pHc81dk6KNNazGDd/zMs442OAAUYlO9gO2hltuNSxdy2UPMUyKBwh8is
         AVMepfx9RjU8UEKF+5ESsNsyHUfwXqXfrWK2pi202R4PPk6lygG2rWcYZSmMQ8dnanim
         SOazssYa/nBF6koQj4EF8Q2bJrCvYAqlI0eGSaxkZB9raAw72Tr9MdhWQETSgQ3B4Pox
         he7A==
X-Gm-Message-State: AOAM531geNDvFRJwsIs3iLHUcPR3vD5NPVCGnAxTmSBhmbrUCQWZNEO0
        wB1wJWFlOMZ0u0a+KrmpQLRQ3apGsFJKr5u0eZ+XDUFfk1KWWEK7Q3rjDuVoKP0oK/vGa4v2EFW
        icMV0CdzDsKpfKE0SQsT4Ae+1
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr17430326wrt.88.1636532939429;
        Wed, 10 Nov 2021 00:28:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzmgp+ezugnIRRk+GUvYvTjS/Ot8vQ0tBCHC7hCSJeWNNzORcL++Xma9R8mtNWZSEeHS4xhSw==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr17430305wrt.88.1636532939188;
        Wed, 10 Nov 2021 00:28:59 -0800 (PST)
Received: from [192.168.1.129] ([92.176.231.106])
        by smtp.gmail.com with ESMTPSA id d1sm9794879wrz.92.2021.11.10.00.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 00:28:58 -0800 (PST)
Message-ID: <864e80df-2be2-ef07-5794-5522774e3e6c@redhat.com>
Date:   Wed, 10 Nov 2021 09:28:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] spidev: Make probe to fail early if a spidev compatible
 is used
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, kernel@pengutronix.de
References: <20211109225920.1158920-1-javierm@redhat.com>
 <20211110074247.g7eaq2z27bwdt4m5@pengutronix.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211110074247.g7eaq2z27bwdt4m5@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

On 11/10/21 08:42, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Nov 09, 2021 at 11:59:20PM +0100, Javier Martinez Canillas wrote:
>> Some Device Trees don't use a real device name in the compatible string
>> for SPI devices nodes, abusing the fact that the spidev driver name is
>> used to match as a fallback when a SPI device ID table is not defined.
>>
>> But since commit 6840615f85f6 ("spi: spidev: Add SPI ID table") a table
>> for SPI device IDs was added to the driver breaking the assumption that
>> these DTs were relying on.
>>
>> There has been a warning message for some time since commit 956b200a846e
>> ("spi: spidev: Warn loudly if instantiated from DT as "spidev""), making
>> quite clear that this case is not really supported by the spidev driver.
>>
>> Since these devices won't match anyways after the mentioned commit, there
>> is no point to continue if an spidev compatible is used. Let's just make
>> the driver probe to fail early.
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> Up to 6840615f85f6 the choices you had to use the spidev driver were
> (assuing a dt machine):
> 
>  a) Use compatible = "spidev" and ignore the warning
>  b) Use compatible = $chipname and add $chipname to the list of
>     supported devices for the spidev driver. (e.g. "rohm,dh2228fv")
>  c) Use compatible = $chipname and force binding the spidev driver using
> 
>    	echo spidev > /sys/bus/spi/devices/spiX.Y/driver_override
> 	echo spiX.Y > /sys/bus/spi/drivers/spidev/bind
>
> Commit 6840615f85f6 changed that in situation a) you had to switch to c)
> (well, or b) adding "spidev" to the spi id list).
> 
> With the change introduced by this patch, you make it impossible to bind
> the spidev driver to such a device (without kernel source changes) even
> using approach c). I wonder if this is too harsh given that changing the
> dtb is difficult on some machines.
>

Right. I completely forgot about driver_override. I wonder if the warning
should mention that, so users can know how to get it to match again after
commit 6840615f85f6.

Because currently they would notice a change in behavior but may not know
how to make it to work again.

Honestly I would just stop supporting it, since as mentioned it was really
an abuse on the driver model device matching. But I believe that should be
made clear what the situation is. What's actually supported and what's not.

Best regards, -- 
Javier Martinez Canillas
Linux Engineering
Red Hat

