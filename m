Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9982D326C7D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 10:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhB0JVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 04:21:20 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12587 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhB0JVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 04:21:19 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DngtY1HNVzMf1V;
        Sat, 27 Feb 2021 17:18:29 +0800 (CST)
Received: from [127.0.0.1] (10.40.192.131) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Sat, 27 Feb 2021
 17:20:24 +0800
Subject: Re: [Linuxarm] [PATCH v1] drm/nouveau/device: append a NUL-terminated
 character for the string which filled by strncpy()
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "bskeggs@redhat.com" <bskeggs@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <1614253132-21793-1-git-send-email-luojiaxing@huawei.com>
 <1b841f487ad742ee941282b534bdcb4d@hisilicon.com>
From:   luojiaxing <luojiaxing@huawei.com>
Message-ID: <27a28507-f394-43af-998e-6d03a971b85d@huawei.com>
Date:   Sat, 27 Feb 2021 17:20:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1b841f487ad742ee941282b534bdcb4d@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.40.192.131]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/2/26 9:01, Song Bao Hua (Barry Song) wrote:
>
>> -----Original Message-----
>> From: Luo Jiaxing [mailto:luojiaxing@huawei.com]
>> Sent: Friday, February 26, 2021 12:39 AM
>> To: nouveau@lists.freedesktop.org; dri-devel@lists.freedesktop.org;
>> bskeggs@redhat.com
>> Cc: linux-kernel@vger.kernel.org; linuxarm@openeuler.org; luojiaxing
>> <luojiaxing@huawei.com>
>> Subject: [Linuxarm] [PATCH v1] drm/nouveau/device: append a NUL-terminated
>> character for the string which filled by strncpy()
>>
>> Following warning is found when using W=1 to build kernel:
>>
>> In function ‘nvkm_udevice_info’,
>>      inlined from ‘nvkm_udevice_mthd’ at
>> drivers/gpu/drm/nouveau/nvkm/engine/device/user.c:195:10:
>> drivers/gpu/drm/nouveau/nvkm/engine/device/user.c:164:2: warning: ‘strncpy’
>> specified bound 16 equals destination size [-Wstringop-truncation]
>>    164 |  strncpy(args->v0.chip, device->chip->name, sizeof(args->v0.chip));
>> drivers/gpu/drm/nouveau/nvkm/engine/device/user.c:165:2: warning: ‘strncpy’
>> specified bound 64 equals destination size [-Wstringop-truncation]
>>    165 |  strncpy(args->v0.name, device->name, sizeof(args->v0.name));
>>
>> The reason of this warning is strncpy() does not guarantee that the
>> destination buffer will be NUL terminated. If the length of source string
>> is bigger than number we set by third input parameter, only first [number]
>> of characters is copied to the destination, and no NUL-terminated is
>> automatically added. There are some potential risks.
>>
>> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
>> ---
>>   drivers/gpu/drm/nouveau/nvkm/engine/device/user.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
>> b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
>> index fea9d8f..2a32fe0 100644
>> --- a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
>> +++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
>> @@ -161,8 +161,10 @@ nvkm_udevice_info(struct nvkm_udevice *udev, void *data,
>> u32 size)
>>   	if (imem && args->v0.ram_size > 0)
>>   		args->v0.ram_user = args->v0.ram_user - imem->reserved;
>>
>> -	strncpy(args->v0.chip, device->chip->name, sizeof(args->v0.chip));
>> -	strncpy(args->v0.name, device->name, sizeof(args->v0.name));
>> +	strncpy(args->v0.chip, device->chip->name, sizeof(args->v0.chip) - 1);
>> +	args->v0.chip[sizeof(args->v0.chip) - 1] = '\0';
>> +	strncpy(args->v0.name, device->name, sizeof(args->v0.name) - 1);
>> +	args->v0.name[sizeof(args->v0.name) - 1] = '\0';
>
> Isn't it better to use snprintf()?


yes, you are right,  snprintf() is better. Most of drivers use 
snprintf() to format a string,

but still some examples in kernel that use it for copy.


I modify to code to the follow and I think it's the same with strncpy 
but more safety

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c 
b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
index fea9d8f..4bf65bb 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/user.c
@@ -161,8 +161,8 @@ nvkm_udevice_info(struct nvkm_udevice *udev, void 
*data, u32 size)
         if (imem && args->v0.ram_size > 0)
                 args->v0.ram_user = args->v0.ram_user - imem->reserved;

-       strncpy(args->v0.chip, device->chip->name, sizeof(args->v0.chip));
-       strncpy(args->v0.name, device->name, sizeof(args->v0.name));
+       snprintf(args->v0.chip, sizeof(args->v0.chip), "%s", 
device->chip->name);
+       snprintf(args->v0.name, sizeof(args->v0.name), "%s", device->name);

Thanks

Jiaxing


>
>>   	return 0;
>>   }
>>
> Thanks
> Barry
>

