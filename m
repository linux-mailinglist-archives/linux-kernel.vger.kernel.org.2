Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2493449CE5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 21:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238428AbhKHUMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 15:12:01 -0500
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:51112 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238408AbhKHUMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 15:12:00 -0500
Received: from [192.168.1.18] ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id kAx6mHJabOvR0kAx7mrfnM; Mon, 08 Nov 2021 21:09:14 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 08 Nov 2021 21:09:14 +0100
X-ME-IP: 86.243.171.122
Subject: Re: [PATCH] platform/x86: hp_accel: Fix an error handling path in
 'lis3lv02d_probe()'
To:     Mark Gross <markgross@kernel.org>
Cc:     eric.piel@tremplin-utc.net, hdegoede@redhat.com,
        dmitry.torokhov@gmail.com, giedriuswork@gmail.com,
        dvhart@linux.intel.com, akpm@linux-foundation.org, pavel@suse.cz,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <5a4f218f8f16d2e3a7906b7ca3654ffa946895f8.1636314074.git.christophe.jaillet@wanadoo.fr>
 <20211108194814.GI61200@T470>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <21eabb3a-db41-6323-0ecd-f231029b75c5@wanadoo.fr>
Date:   Mon, 8 Nov 2021 21:09:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211108194814.GI61200@T470>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 08/11/2021 à 20:48, Mark Gross a écrit :
> On Sun, Nov 07, 2021 at 08:57:07PM +0100, Christophe JAILLET wrote:
>> If 'led_classdev_register()' fails, some additional resources should be
>> released.
>>
>> Add the missing 'i8042_remove_filter()' and 'lis3lv02d_remove_fs()' calls
>> that are already in the remove function but are missing here.
>>
>> Fixes: a4c724d0723b ("platform: hp_accel: add a i8042 filter to remove HPQ6000 data from kb bus stream")
>> Fixes: 9e0c79782143 ("lis3lv02d: merge with leds hp disk")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/platform/x86/hp_accel.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/platform/x86/hp_accel.c b/drivers/platform/x86/hp_accel.c
>> index b183967ecfb7..435a91fe2568 100644
>> --- a/drivers/platform/x86/hp_accel.c
>> +++ b/drivers/platform/x86/hp_accel.c
>> @@ -331,9 +331,11 @@ static int lis3lv02d_probe(struct platform_device *device)
> adding some lines of context:
> 
> 326         /* filter to remove HPQ6000 accelerometer data
> 327          * from keyboard bus stream */
> 328         if (strstr(dev_name(&device->dev), "HPQ6000"))
> 329                 i8042_install_filter(hp_accel_i8042_filter);
> 330
>>   	INIT_WORK(&hpled_led.work, delayed_set_status_worker);
>>   	ret = led_classdev_register(NULL, &hpled_led.led_classdev);
>>   	if (ret) {
>> +		i8042_remove_filter(hp_accel_i8042_filter);
> This filter was added under a conditional.  Should it not be removed under a
> similar conditional?

Agreed that it looks odd, but in the remove function, we already don't 
have the conditional.

Moreover, in, we have 'i8042_remove_filter()':
	if (i8042_platform_filter != filter) {
		ret = -EINVAL;
		goto out;
	}
So, if 'i8042_install_filter(hp_accel_i8042_filter)' is not called, the 
removal will be a no-op.

>>   		lis3lv02d_joystick_disable(&lis3_dev);
>>   		lis3lv02d_poweroff(&lis3_dev);
>>   		flush_work(&hpled_led.work);
>> +		lis3lv02d_remove_fs(&lis3_dev);
> where was the fs ever added?

In 'lis3lv02d_init_device()' (see [1]), like what is undone with 
'lis3lv02d_joystick_disable()' and 'lis3lv02d_poweroff()'.

'lis3lv02d_remove_fs()' is also already part of the remove function.

I guess that having a 'lis3lv02d_uninit_device()' would be much more 
cleaner.


[1]: 
https://elixir.bootlin.com/linux/v5.15.1/source/drivers/misc/lis3lv02d/lis3lv02d.c#L1188

CJ
> 
> --mark
> 
>>   		return ret;
>>   	}
>>   
>> -- 
>> 2.30.2
>>
> 

