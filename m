Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95792456B6D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 09:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234140AbhKSIRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 03:17:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23960 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233858AbhKSIRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 03:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637309691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7JV1cZENXMXZyinTiwhaccj/QSmI5uZhTY4+XUIIsZA=;
        b=bW7NtCl+Xj0gL0G6YPX3dbJ8ThtBmCv2+gOVzjXzLybPQbzFPlpUPJc+EFZxKyYHcnYZeY
        WIqfNdhcaWPOSU7YZR31LF/KMnO6TrW0IAnZI1UMiw4q0uGSIHNaFpfEqw9CZL54Va64nw
        mk5zGYYIyb08Tp+uhTT9ewv7e8H1HY8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-vRFRgkXIP92rZLS5UJ_wrw-1; Fri, 19 Nov 2021 03:14:50 -0500
X-MC-Unique: vRFRgkXIP92rZLS5UJ_wrw-1
Received: by mail-wr1-f72.google.com with SMTP id b1-20020a5d6341000000b001901ddd352eso1607850wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 00:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7JV1cZENXMXZyinTiwhaccj/QSmI5uZhTY4+XUIIsZA=;
        b=b/ACSx55BRESrxgjZ3Nqr3h65Ek4F/Zpc0Smksnmw+yH1GXZ6052NThrw22T/xd+9+
         CuCxd06JQLLeLQEHls7DTlVT4TI1XqOtrY5UFtA51d8pPNO16q2AxqpYu9a/nzO1YQe8
         PqqaFXtaPhRFGR7cau/eeQeBIpbvlyFwTZA87UDVUD8xk8B74kNFvGzs6AuF441bAw9j
         6YelheGM4ZLqJveyJL94wZkCnzLKyvTpsstJcSo9SQA6VDTNp0emapAR1dtJVmv7+n8U
         ayxW+hevqehzul75y4EoMeuLTllF3UfltdfPtxw18vSoyvP+PtybbK3b1DLLXI2MVmir
         mPyA==
X-Gm-Message-State: AOAM530co3JHQH36l8R9y6Nktse6zN2bO/SNsDQx7tC6vxDv1TPDhi/K
        9uUvPhAVWBz8wmtWPenMNoH+kw+AAEANfkXZaWTavPLGKwbK3FV4WQb+NRkoSDZNHeXYORz8Dm0
        niMz+eG05W3qgvLRlEFpvB0wE
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr4450008wmh.60.1637309688849;
        Fri, 19 Nov 2021 00:14:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBlU4knLHloWUN5sSN3Ii1JoA342TzkqpYsfz9O9L8KdAkj6d0ZgiszUYl8BUt84AvBN/z1w==
X-Received: by 2002:a1c:21d7:: with SMTP id h206mr4449995wmh.60.1637309688629;
        Fri, 19 Nov 2021 00:14:48 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bg14sm2669635wmb.5.2021.11.19.00.14.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 00:14:48 -0800 (PST)
Message-ID: <f6349482-2f65-277d-afa7-9fb47e89221b@redhat.com>
Date:   Fri, 19 Nov 2021 09:14:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] spi: docs: improve the SPI userspace API documentation
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-spi@vger.kernel.org, Ralph Siemsen <ralph.siemsen@linaro.org>
References: <20211118213143.2345041-1-javierm@redhat.com>
 <20211119074529.cvi5zldkuofl4nl5@pengutronix.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20211119074529.cvi5zldkuofl4nl5@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

Thanks for your feedback.

On 11/19/21 08:45, Uwe Kleine-König wrote:
> On Thu, Nov 18, 2021 at 10:31:43PM +0100, Javier Martinez Canillas wrote:

[snip]

>> +
>>  Set up the other device characteristics (bits per word, SPI clocking,
>>  chipselect polarity, etc) as usual, so you won't always need to override
>>  them later.
>>  
>> -(Sysfs also supports userspace driven binding/unbinding of drivers to
>> -devices.  That mechanism might be supported here in the future.)
>> +Sysfs also supports userspace driven binding/unbinding of drivers to
>> +devices.  The mechanism works by writing to the device "driver_overrride"
>> +entry.  For example:
> 
> I'd write here:
> 
> 	Sysfs also supports userspace driven binding/unbinding of
> 	drivers to devices that don't bind automatically using one of
> 	the tables above. To make the spidev driver bind to such a
> 	device, use:
>

Agreed, that looks much nicer.
 
>> +
>> +    echo spidev > /sys/bus/spi/devices/spiX.Y/driver_override
>> +    echo spiB.C > /sys/bus/spi/drivers/spidev/bind
>>  
>>  When you do that, the sysfs node for the SPI device will include a child
>>  device node with a "dev" attribute that will be understood by udev or mdev.
> 
> What is "that" here? (Maybe this refers to "Set up the other device
> characteristics [...] as usual"? Is the effect still accurate?
>

My understanding is that "that" refers to: define an register a spi_board_info
with .modalias = "$chipname" to bind the device with the spidev driver.

Since the "dev" attribute will AFAIK contain the MAJOR:MINOR numbers for the
character device in /dev. This is the reason why I left this paragraph after
the explanation of the device <--> driver binding logic.

But probably while being there I should make that paragraph more clear too ?

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

