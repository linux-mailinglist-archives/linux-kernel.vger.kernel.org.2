Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DD93A9542
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhFPItY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhFPItX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:49:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC99C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:47:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k7so2524800ejv.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 01:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=z4dc94oTDTB7k/dvNxTeUZ/Xn7C6MXk+TgQPy7nxzl4=;
        b=PJLeIRCCQdg8SzX5qXWSd+yUuWOc0gtAy57Oj54iM2e0ehqWFfsFOuWl7Wej7I05EM
         cvlfs2ZolRf5VMXL0+t2FS5b8wKN6QdHTL+J6OIp3b5b6MHSm6dcdJBsCHgJxPiDgHwf
         x7XwqPA0DVIgw7n9DyNf1HqJuAnKUp0wOuDpeLZuppWpkXI1/Xqv6EvfQFZJHHceN5nd
         VbuDdw8cmodjOCG10LqlTMFroelZbukCaoiMCbM/xqpvJx6Y0Q8LzVdN+FtmMJDzGGtU
         VlJocYRZDahBIL/Z4qRCFiHPYSZYHp18m09n8mxYj8ze3TXSmZTKCMLbWe3tWQbK3+Z7
         SVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=z4dc94oTDTB7k/dvNxTeUZ/Xn7C6MXk+TgQPy7nxzl4=;
        b=C1AS5NMy03Wo2kVw5LfQbvpyPYQZ+UiJScwTK6Jcg5pHomQtfpkoV2IftnLRrVt9Os
         dz1WYtrbwIE6BTaelU28jsfhufDMGzv8TjXPwfba0SEd0XAtdIPSg7mYNHVDT0VbPhEl
         MVAYtDACRhzFLyKXquXdHaUrTpy/qii2mGy+3IyApDejuRtbJQWBYEzmROoIPLFxCDDo
         aJQjhSvn5PPN3EoRO/kx1Wp7Xpx+wNL7X0jZC1blu7UW7mBAsYNR/P+RszXxmpfQIiEo
         0nUxH0KXrq4+mjC8zr9mPlJkRULvekteZk7jizFKz3vr/D93PGRN0JfZ27OxHdZmZ0BM
         QVNA==
X-Gm-Message-State: AOAM530sm5q9VSeFUaUcS49Y2X8vO8ghdvqBKqdZRQ24T27W55uvdVzW
        hTpezbTHGAF/vSx0ePPcrXM+8zmvo6c=
X-Google-Smtp-Source: ABdhPJwr6Wm0RBX0yfK2y/3aIJPhnD0E2zEBjG5VGk8xJTw9kK/jzetjFaV2EpoKd264VPISoTHGkg==
X-Received: by 2002:a17:907:2cef:: with SMTP id hz15mr4115630ejc.253.1623833236147;
        Wed, 16 Jun 2021 01:47:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:afc4:3771:10a6:8a6d? ([2a02:908:1252:fb60:afc4:3771:10a6:8a6d])
        by smtp.gmail.com with ESMTPSA id s5sm1200586edi.93.2021.06.16.01.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 01:47:15 -0700 (PDT)
Subject: Re: [PATCH] drm/ttm: fix error handling in ttm_bo_handle_move_mem()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Thomas Hellstr <C3@mwanda>, B6@mwanda,
        m <thomas.hellstrom@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <YMmadPwv8C+Ut1+o@mwanda>
 <03d0b798-d1ab-5b6f-2c27-8140d923d445@gmail.com>
 <20210616083758.GC1901@kadam>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <520a9d1f-8841-8d5e-595d-23783de8333d@gmail.com>
Date:   Wed, 16 Jun 2021 10:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616083758.GC1901@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 16.06.21 um 10:37 schrieb Dan Carpenter:
> On Wed, Jun 16, 2021 at 08:46:33AM +0200, Christian König wrote:
>> Sending the first message didn't worked, so let's try again.
>>
>> Am 16.06.21 um 08:30 schrieb Dan Carpenter:
>>> There are three bugs here:
>>> 1) We need to call unpopulate() if ttm_tt_populate() succeeds.
>>> 2) The "new_man = ttm_manager_type(bdev, bo->mem.mem_type);" assignment
>>>      was wrong and it was really assigning "new_mem = old_mem;".  There
>>>      is no need for this assignment anyway as we already have the value
>>>      for "new_mem".
>>> 3) The (!new_man->use_tt) condition is reversed.
>>>
>>> Fixes: ba4e7d973dd0 ("drm: Add the TTM GPU memory manager subsystem.")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>> ---
>>> This is from reading the code and I can't swear that I have understood
>>> it correctly.  My nouveau driver is currently unusable and this patch
>>> has not helped.  But hopefully if I fix enough bugs eventually it will
>>> start to work.
>> Well NAK, the code previously looked quite well and you are breaking it now.
>>
>> What's the problem with nouveau?
>>
> The new Firefox seems to excersize nouveau more than the old one so
> when I start 10 firefox windows it just hangs the graphics.
>
> I've added debug code and it seems like the problem is that
> nv50_mem_new() is failing.

Sounds like it is running out of memory to me.

Do you have a dmesg?

>
>
>>>    drivers/gpu/drm/ttm/ttm_bo.c | 14 ++++++++------
>>>    1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>>> index ebcffe794adb..72dde093f754 100644
>>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>>> @@ -180,12 +180,12 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
>>>    		 */
>>>    		ret = ttm_tt_create(bo, old_man->use_tt);
>>>    		if (ret)
>>> -			goto out_err;
>>> +			return ret;
>>>    		if (mem->mem_type != TTM_PL_SYSTEM) {
>>>    			ret = ttm_tt_populate(bo->bdev, bo->ttm, ctx);
>>>    			if (ret)
>>> -				goto out_err;
>>> +				goto err_destroy;
>>>    		}
>>>    	}
>>> @@ -193,15 +193,17 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
>>>    	if (ret) {
>>>    		if (ret == -EMULTIHOP)
>>>    			return ret;
>>> -		goto out_err;
>>> +		goto err_unpopulate;
>>>    	}
>>>    	ctx->bytes_moved += bo->base.size;
>>>    	return 0;
>>> -out_err:
>>> -	new_man = ttm_manager_type(bdev, bo->mem.mem_type);
>> This here switches new and old manager. E.g. the new_man is now pointing to
>> the existing resource manager.
> Why not just use "old_man" instead of basically the equivalent to
> "new_man = old_man"?  Can the old_man change part way through the
> function?

Good question :)

I don't think that old_man could change and yes that would be much more 
easier to understand.

Regards,
Christian.

>
> regards,
> dan carpenter
>

