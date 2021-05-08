Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C21B3770D5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 11:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhEHJT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 05:19:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18014 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhEHJTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 05:19:25 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FchVB5wbPzQkJl;
        Sat,  8 May 2021 17:14:58 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.72) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Sat, 8 May 2021
 17:18:14 +0800
Subject: Re: [PATCH 1/1] drm/nouveau: fix error return code in
 nouveau_backlight_init()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210508034810.2374-1-thunder.leizhen@huawei.com>
 <20210508073400.nnmwwyoxqqiwv36w@pmoreau.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <0b94bd89-c8a0-f1e8-057f-2f639464fadd@huawei.com>
Date:   Sat, 8 May 2021 17:18:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210508073400.nnmwwyoxqqiwv36w@pmoreau.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/8 15:34, Pierre Moreau wrote:
> Hello Zhen,
> 
> There was a similar patch sent in last month, though which does not seem to
> have been merged yet; see
> https://lists.freedesktop.org/archives/nouveau/2021-April/038451.html.
> 
> Whether `ret` should be `-ENOSPC` or `-ENOMEM` is hard to say as
> `nouveau_get_backlight_name()` could fail due to either.
> 
> I will propose an alternative fix which modifies `nouveau_get_backlight_name()`
> to return an int so the actual error code can be propagated back instead of
> guessed, as well as fix an ida ID leak which I just spotted.

It's a good idea.

> 
> Best,
> Pierre
> 
> On 2021-05-08 — 11:48, Zhen Lei wrote:
>> Fix to return a negative error code from the error handling case instead
>> of 0, as done elsewhere in this function.
>>
>> Fixes: db1a0ae21461 ("drm/nouveau/bl: Assign different names to interfaces")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/gpu/drm/nouveau/nouveau_backlight.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/nouveau/nouveau_backlight.c b/drivers/gpu/drm/nouveau/nouveau_backlight.c
>> index 72f35a2babcb..097ca344a086 100644
>> --- a/drivers/gpu/drm/nouveau/nouveau_backlight.c
>> +++ b/drivers/gpu/drm/nouveau/nouveau_backlight.c
>> @@ -273,6 +273,7 @@ nouveau_backlight_init(struct drm_connector *connector)
>>  		return -ENOMEM;
>>  
>>  	if (!nouveau_get_backlight_name(backlight_name, bl)) {
>> +		ret = -ENOSPC;
>>  		NV_ERROR(drm, "Failed to retrieve a unique name for the backlight interface\n");
>>  		goto fail_alloc;
>>  	}
>> -- 
>> 2.25.1
>>
>>
> 
> .
> 

