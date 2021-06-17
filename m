Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 011453AB526
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhFQNuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232559AbhFQNuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:50:20 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B93DC061574;
        Thu, 17 Jun 2021 06:48:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id f30so10690871lfj.1;
        Thu, 17 Jun 2021 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r+WSgPEpOCcz2ZWxrp9FCsB4CB9DuPrqyD11wi3qMmo=;
        b=XkWn9gYDAKkfWlGpxGGJ59Qsp7+izVtH8LBds7sYhfG2Io2jbO+IiuYdAn7/YNA0J5
         yLqeYLy03BpjPLb/5e+62h7xKB4oWxrpuqdO6ecrIi21Uttar8TsGFgkXuHEpTaNzBW5
         JB3+/vxPp2A1oO+P7DnkYFqxAIhQKltCnYaDIbRQ4C46xOL0zL89iGCZcC2vq9AskD4+
         HFRdFyn9TPVLkkfw7xIfDKvTaVzIsh6Z1vhxfYAv+0sEQ7QQ4MZRb7Pa6RJjzWpLEV8E
         nanfDOV5Fy6s4PGfMCAFW/MwNkpwClwv12cGL4kWNejyezQ11ek0DMmCIq93yInKzTS1
         VuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r+WSgPEpOCcz2ZWxrp9FCsB4CB9DuPrqyD11wi3qMmo=;
        b=kVPxGndZ6P0SNp3yvxAyNSUcIm4n4pJzbscRBiDYXPxQONCffd3fmAy4O9I2NwD5YQ
         Uos07MUU5/1ttxRB+Rg+y11rUN2DarrnLWcxPS2S8sYkQ0WH1sio/yyCVuT4/7qGRlxS
         +20wyVHMIcC5Fs2l367dP8pwWkXnAm7Lk3qZ8Tr9FUGQyM+26svxZutGpnE2Ab8UfiLI
         95DXAvzrSYlrWIWtMSJCP2Rf5sOKieH1O9O754AYLcnf9MAbvcCjeE0gvfsoyj99rTSD
         qedJtrJGCd3j/9Z4cjFuEjBLpm69Yj2bJnh+mbq4MosvPbCbEdG4HQl035TZ+hu2D/I2
         VNeA==
X-Gm-Message-State: AOAM533DchaYiUi29WeUR4oz8XaQqKrMxiAMwE61HoszYSptoIdVHuWK
        ybsWcvt+EJOZaxZbmbxlQiWOjD6yDaQ=
X-Google-Smtp-Source: ABdhPJyFPRzHnR84XKOyXT8nH8X4PQbctGQpx0x7WgQ033Up6jZz2wBqEtTi+5sGciWF6LjX0yeucw==
X-Received: by 2002:ac2:42c2:: with SMTP id n2mr4171088lfl.0.1623937689804;
        Thu, 17 Jun 2021 06:48:09 -0700 (PDT)
Received: from [192.168.2.145] (94-29-29-31.dynamic.spd-mgts.ru. [94.29.29.31])
        by smtp.googlemail.com with ESMTPSA id p4sm588029lfr.87.2021.06.17.06.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 06:48:09 -0700 (PDT)
Subject: Re: [PATCH v1] hwmon: (lm90) Use edge-triggered interrupt
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org
References: <20210616190708.1220-1-digetx@gmail.com>
 <20210617001243.GA3211292@roeck-us.net>
 <3c6cbaf3-187b-1682-69b8-a2b34f23b928@gmail.com>
 <20210617131205.GA59767@roeck-us.net>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <de7682c2-ae34-c594-d237-330ea33cbc78@gmail.com>
Date:   Thu, 17 Jun 2021 16:48:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210617131205.GA59767@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2021 16:12, Guenter Roeck пишет:
> On Thu, Jun 17, 2021 at 10:11:19AM +0300, Dmitry Osipenko wrote:
>> 17.06.2021 03:12, Guenter Roeck пишет:
>>> On Wed, Jun 16, 2021 at 10:07:08PM +0300, Dmitry Osipenko wrote:
>>>> The LM90 driver uses level-based interrupt triggering. The interrupt
>>>> handler prints a warning message about the breached temperature and
>>>> quits. There is no way to stop interrupt from re-triggering since it's
>>>> level-based, thus thousands of warning messages are printed per second
>>>> once interrupt is triggered. Use edge-triggered interrupt in order to
>>>> fix this trouble.
>>>>
>>>> Fixes: 109b1283fb532 ("hwmon: (lm90) Add support to handle IRQ")
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/hwmon/lm90.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
>>>> index ebbfd5f352c0..ce8ebe60fcdc 100644
>>>> --- a/drivers/hwmon/lm90.c
>>>> +++ b/drivers/hwmon/lm90.c
>>>> @@ -1908,7 +1908,7 @@ static int lm90_probe(struct i2c_client *client)
>>>>  		dev_dbg(dev, "IRQ: %d\n", client->irq);
>>>>  		err = devm_request_threaded_irq(dev, client->irq,
>>>>  						NULL, lm90_irq_thread,
>>>> -						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>>>> +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>>>>  						"lm90", client);
>>>
>>> We can't do that. Problem is that many of the devices supported by this driver
>>> behave differently when it comes to interrupts. Specifically, the interrupt
>>> handler is supposed to reset the interrupt condition (ie reading the status
>>> register should reset it). If that is the not the case for a specific chip,
>>> we'll have to update the code to address the problem for that specific chip.
>>> The above code would probably just generate a single interrupt while never
>>> resetting the interrupt condition, which is obviously not what we want to
>>> happen.
>>
>> The nct1008/72 datasheet [1] says that reading the status register
>> doesn't reset interrupt until temperature is returned back into normal
>> state, which is what I'm witnessing.
>>
>> [1] https://www.onsemi.com/pdf/datasheet/nct1008-d.pdf
>>
>> Page 10 "Status Register":
>>
>> "Reading the status register clears the five flags, Bit 6 to Bit 2,
>> provided the error conditions causing the flags to beset  have  gone
>> away.  A  flag  bit  can  be  reset  only  if  the corresponding
>> value    register    contains    an    in-limit measurement or if the
>> sensor is good."
>>
>> So the interrupt handler doesn't actually stop interrupt from
>> reoccurring and the whole KMSG is instantly spammed with:
>>
>> ...
>> [  217.484034] lm90 0-004c: temp2 out of range, please check!
>> [  217.484569] lm90 0-004c: temp2 out of range, please check!
>> [  217.485006] systemd-journald[179]: /dev/kmsg buffer overrun, some
>> messages lost.
>> [  217.485109] lm90 0-004c: temp2 out of range, please check!
>> [  217.485699] lm90 0-004c: temp2 out of range, please check!
>> [  217.486235] lm90 0-004c: temp2 out of range, please check!
>> [  217.486776] lm90 0-004c: temp2 out of range, please check!
>> [  217.486874] systemd-journald[179]: /dev/kmsg buffer overrun, ...
>>
>> It's interesting that the very first version of the nct1008-support
>> patch used edge-triggered interrupt flags [2].
>>
>> [2] http://lkml.iu.edu/hypermail/linux/kernel/1104.1/01669.html
>>
> A lot of this depends on the chip and its wiring, as well as on chip
> configuration. Even for a specific chip there may be configuration
> dependencies. The interrupt configuration in situations like this
> should really be determined by devicetree configuration, and not
> be hardcoded. Is this a devicetree based system ? If so, there should
> be an entry for this chip pointing to the interrupt, and that entry
> should include a trigger mask. That mask should be set to edge
> triggered.

This is a device-tree based system, in particular it's NVIDIA Tegra30
Nexus 7. The interrupt support was originally added to the lm90 driver
by Wei Ni who works at NVIDIA and did it for the Tegra boards. The Tegra
device-trees are specifying the trigger mask and apparently they all are
cargo-culted and wrong because they use IRQ_TYPE_LEVEL_HIGH, while it
should be IRQ_TYPE_EDGE_FALLING.

The IRQF flag in devm_request_threaded_irq() overrides the trigger mask
specified in a device-tree. IIUC, the interrupt is used only by OF-based
devices, hence I think we could simply remove the IRQF flag from the
code and fix the device-trees. Does it sound good to you?
