Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21F63A9869
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhFPLCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhFPLCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:02:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9C8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:00:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id w21so2114185edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=sYAv+AVeb+Fl5OMylSeVqqG1epfvgEGQg3zps/TWGMY=;
        b=aO4lKMzMpD+C0oS3UIKPWBQnGIq1n3zblm08F6g5xcTnuaeQtVbzjzgNnIYGEJvmCA
         t1i9+82HhRWJ8pJrJAIYZCjbS3NlK2vP5ZOU+wOGzKczgcx7YG6DOt1tprLBASNoBW+j
         JcgEtKpdc8N/7puP3wZsjl167ne/Ch5MonvJIOqsO+hRfv9zqRnnHIJyVWLDdxOWa2tl
         aEF2V3gS4SyI0GWZ+I7Go9ZAkV6VEfWMYaIo5VXozGt9erIyl9hhhtXvaVp6i/7bIMhL
         KToyYClsjbvgeaEFgL+zIvDPRumjvqm0dqm0jmyVIYiMRlDYXuvQgAlxhw01Thwl/8rZ
         jUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=sYAv+AVeb+Fl5OMylSeVqqG1epfvgEGQg3zps/TWGMY=;
        b=AlY0hEd+ElaWB2+xTDQUholYsFD73CN3BjlRlJu5J+IXWLbPNN6A3xl5di5kCKzrWu
         9yUmBU0paXyrw3Pf+tApgQhRDdg6YASH6NxpiG5fA/3dA8rhcoyuxpeCpGAIVxwp+E/N
         yIQ392c8GUJuXXP2Kiz6GIYudhraYQE8ElTVn5Rorc+oG5VACDIeX/romg7MW+pCI8l+
         bqB56FGAkEUMEZBCe7mTE1BirI+9Vxptm5gcqh3OMfQv8w4mR7mwA1ybGis+BJWwgcIT
         Kmr7zh2wT55NjhetOvDF4I3IOng3P10Yd+13VUWPNrMoljOLVNB64+uYzQUbr2gsPYdt
         es4g==
X-Gm-Message-State: AOAM5313UMrHCSezQcbLx4KT/UsABGjIkbGpFGK05x8mxZPpTxNbW9P3
        5Vp7XFwBiCAbppXbxHTqlwaK0EbHpzI=
X-Google-Smtp-Source: ABdhPJwALbarIGLPP4tky17k4V8t9tif2+4uah9WHyiY+qOeSeASu1heOe0dMT7dChJVH9vsXheYaA==
X-Received: by 2002:a05:6402:487:: with SMTP id k7mr3323656edv.315.1623841240803;
        Wed, 16 Jun 2021 04:00:40 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:afc4:3771:10a6:8a6d? ([2a02:908:1252:fb60:afc4:3771:10a6:8a6d])
        by smtp.gmail.com with ESMTPSA id d22sm1392068ejj.47.2021.06.16.04.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 04:00:40 -0700 (PDT)
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
 <520a9d1f-8841-8d5e-595d-23783de8333d@gmail.com>
 <20210616093604.GD1901@kadam>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <7354cd94-06bf-ec36-4539-c3570c1775ae@gmail.com>
Date:   Wed, 16 Jun 2021 13:00:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210616093604.GD1901@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 16.06.21 um 11:36 schrieb Dan Carpenter:
> On Wed, Jun 16, 2021 at 10:47:14AM +0200, Christian König wrote:
>>
>> Am 16.06.21 um 10:37 schrieb Dan Carpenter:
>>> On Wed, Jun 16, 2021 at 08:46:33AM +0200, Christian König wrote:
>>>> Sending the first message didn't worked, so let's try again.
>>>>
>>>> Am 16.06.21 um 08:30 schrieb Dan Carpenter:
>>>>> There are three bugs here:
>>>>> 1) We need to call unpopulate() if ttm_tt_populate() succeeds.
>>>>> 2) The "new_man = ttm_manager_type(bdev, bo->mem.mem_type);" assignment
>>>>>       was wrong and it was really assigning "new_mem = old_mem;".  There
>>>>>       is no need for this assignment anyway as we already have the value
>>>>>       for "new_mem".
>>>>> 3) The (!new_man->use_tt) condition is reversed.
>>>>>
>>>>> Fixes: ba4e7d973dd0 ("drm: Add the TTM GPU memory manager subsystem.")
>>>>> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>>> ---
>>>>> This is from reading the code and I can't swear that I have understood
>>>>> it correctly.  My nouveau driver is currently unusable and this patch
>>>>> has not helped.  But hopefully if I fix enough bugs eventually it will
>>>>> start to work.
>>>> Well NAK, the code previously looked quite well and you are breaking it now.
>>>>
>>>> What's the problem with nouveau?
>>>>
>>> The new Firefox seems to excersize nouveau more than the old one so
>>> when I start 10 firefox windows it just hangs the graphics.
>>>
>>> I've added debug code and it seems like the problem is that
>>> nv50_mem_new() is failing.
>> Sounds like it is running out of memory to me.
>>
>> Do you have a dmesg?
>>
> At first there was a very straight forward use after free bug which I
> fixed.
> https://lore.kernel.org/nouveau/YMinJwpIei9n1Pn1@mwanda/T/#u
>
> But now the use after free is gone the only thing in dmesg is:
> "[TTM] Buffer eviction failed".  And I have some firmware missing.
>
> [  205.489763] rfkill: input handler disabled
> [  205.678292] nouveau 0000:01:00.0: Direct firmware load for nouveau/nva8_fuc084 failed with error -2
> [  205.678300] nouveau 0000:01:00.0: Direct firmware load for nouveau/nva8_fuc084d failed with error -2
> [  205.678302] nouveau 0000:01:00.0: msvld: unable to load firmware data
> [  205.678304] nouveau 0000:01:00.0: msvld: init failed, -19
> [  296.150632] [TTM] Buffer eviction failed
> [  417.084265] [TTM] Buffer eviction failed
> [  447.295961] [TTM] Buffer eviction failed
> [  510.800231] [TTM] Buffer eviction failed
> [  556.101384] [TTM] Buffer eviction failed
> [  616.495790] [TTM] Buffer eviction failed
> [  692.014007] [TTM] Buffer eviction failed
>
> The eviction failed message only shows up a minute after the hang so it
> seems more like a symptom than a root cause.

Yeah, look at the timing. What happens is that the buffer eviction timed 
out because the hardware is locked up.

No idea what that could be. It might not even be kernel related at all.

Regards,
Christian.

>
> regards,
> dan carpenter
>

