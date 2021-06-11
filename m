Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889F23A399C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 04:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhFKCUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 22:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhFKCUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 22:20:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D484C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 19:18:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l1so1257535pgm.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 19:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=CxgTlwmogoHhOULSFq3GJiDbsRi88PXUgGnGmm64QIk=;
        b=aPH2Rj6GwUHE43OWEfQPUaa1wYw6SyzIomh4HiyRwux/MIJA/vVXxze7aXwz3HUt+H
         9pB7OWEbdwAoXrga89jq2Y4jSIdaGgx1FyMjJ7F85COtVOd553YmR2DHyaTmAyLRAvIb
         A+XLas/CxN6Yw/j7uCYPmHxOJ148N18bS1sgfV8gN8zOCxH6ZX2uFFj1iCpZGFbiqiR1
         IKkh3chxuGJg5fN4jNohvhjFajK02UxfrBPG28fSwEoJKbWdi2kzyi8Lyqx/bxWKqsIQ
         rJJqszvCD6WZMLR/RRnuAdTFiGF47FwWxeWjLru9Kg+hhIbwqtioVe9yFxKavSOgnvyu
         RyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CxgTlwmogoHhOULSFq3GJiDbsRi88PXUgGnGmm64QIk=;
        b=aRJFBDztqE9z8g/mvS7Sk4czfk2AFMzCTLHfpL1Gz+Tky7kuKAQ30aTGSFC/82Iq9P
         7tsHLuzSHIT8D/ot6xP6+gghG7pvMetyrJ3dHaxqJun+nc6H4Dqr8U5Rwl/DXy5YZYGW
         zCrUamlw/g+fo7lvfnIOQ0naoLRdLp42j1QcLZvqrae2nnliTxzpqDrItEiD+87054A1
         qeI91iAPw6HYlU3aLjv3QaPXP/qCUtMp1W0DUjmrCBaClI6Ciyulv9GuVNedTnczZwmb
         If9HGNi4OUsHHJOPctGaR0ekZIzo0B5FJNlHBvrK6pGwQPlLI0BmQ9fCk2n1YtwTjHjH
         AMug==
X-Gm-Message-State: AOAM53177AuhPvb+dj+LWZvADkUd5mvaXdmcFs9/BLtQ8sqhLXRJI1Bh
        ba3v2QvIXA2c2w/lnnCcMjM=
X-Google-Smtp-Source: ABdhPJzD6Rfn7Da741MQ5mLIAeix7PdUK5MlNUqEkxRnucYkYh6IJqCQQ5CHd+OUpP90WUCkWnW8YA==
X-Received: by 2002:a62:bd14:0:b029:2de:8bf7:2df8 with SMTP id a20-20020a62bd140000b02902de8bf72df8mr5856590pff.60.1623377907516;
        Thu, 10 Jun 2021 19:18:27 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id o16sm3439636pfu.75.2021.06.10.19.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 19:18:27 -0700 (PDT)
Subject: Re: [PATCH] drm: Lock pointer access in drm_master_release()
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <20210609092119.173590-1-desmondcheongzx@gmail.com>
 <YMHlLQHRLWgWlXTs@phenom.ffwll.local>
 <f16f4123-bd0b-f09c-ddf1-7197c841b588@gmail.com>
 <YMJCdG7k5sNaiHen@phenom.ffwll.local>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <d8150fdb-3a59-e491-f148-1c528fe3c824@gmail.com>
Date:   Fri, 11 Jun 2021 10:18:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMJCdG7k5sNaiHen@phenom.ffwll.local>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/21 12:48 am, Daniel Vetter wrote:
> On Thu, Jun 10, 2021 at 11:21:39PM +0800, Desmond Cheong Zhi Xi wrote:
>> On 10/6/21 6:10 pm, Daniel Vetter wrote:
>>> On Wed, Jun 09, 2021 at 05:21:19PM +0800, Desmond Cheong Zhi Xi wrote:
>>>> This patch eliminates the following smatch warning:
>>>> drivers/gpu/drm/drm_auth.c:320 drm_master_release() warn: unlocked access 'master' (line 318) expected lock '&dev->master_mutex'
>>>>
>>>> The 'file_priv->master' field should be protected by the mutex lock to
>>>> '&dev->master_mutex'. This is because other processes can concurrently
>>>> modify this field and free the current 'file_priv->master'
>>>> pointer. This could result in a use-after-free error when 'master' is
>>>> dereferenced in subsequent function calls to
>>>> 'drm_legacy_lock_master_cleanup()' or to 'drm_lease_revoke()'.
>>>>
>>>> An example of a scenario that would produce this error can be seen
>>>> from a similar bug in 'drm_getunique()' that was reported by Syzbot:
>>>> https://syzkaller.appspot.com/bug?id=148d2f1dfac64af52ffd27b661981a540724f803
>>>>
>>>> In the Syzbot report, another process concurrently acquired the
>>>> device's master mutex in 'drm_setmaster_ioctl()', then overwrote
>>>> 'fpriv->master' in 'drm_new_set_master()'. The old value of
>>>> 'fpriv->master' was subsequently freed before the mutex was unlocked.
>>>>
>>>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>>> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>>>
>>> Thanks a lot. I've done an audit of this code, and I found another
>>> potential problem in drm_is_current_master. The callers from drm_auth.c
>>> hold the dev->master_mutex, but all the external ones dont. I think we
>>> need to split this into a _locked function for use within drm_auth.c, and
>>> the exported one needs to grab the dev->master_mutex while it's checking
>>> master status. Ofc there will still be races, those are ok, but right now
>>> we run the risk of use-after free problems in drm_lease_owner.
>>>
>>> Are you up to do that fix too?
>>>
>>
>> Hi Daniel,
>>
>> Thanks for the pointer, I'm definitely up for it!
>>
>>> I think the drm_lease.c code also needs an audit, there we'd need to make
>>> sure that we hold hold either the lock or a full master reference to avoid
>>> the use-after-free issues here.
>>>
>>
>> I'd be happy to look into drm_lease.c as well.
>>
>>> Patch merged to drm-misc-fixes with cc: stable.
>>> -Daniel
>>>
>>>> ---
>>>>    drivers/gpu/drm/drm_auth.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
>>>> index f00e5abdbbf4..b59b26a71ad5 100644
>>>> --- a/drivers/gpu/drm/drm_auth.c
>>>> +++ b/drivers/gpu/drm/drm_auth.c
>>>> @@ -315,9 +315,10 @@ int drm_master_open(struct drm_file *file_priv)
>>>>    void drm_master_release(struct drm_file *file_priv)
>>>>    {
>>>>    	struct drm_device *dev = file_priv->minor->dev;
>>>> -	struct drm_master *master = file_priv->master;
>>>> +	struct drm_master *master;
>>>>
>>>>    	mutex_lock(&dev->master_mutex);
>>>> +	master = file_priv->master;
>>>>    	if (file_priv->magic)
>>>>    		idr_remove(&file_priv->master->magic_map, file_priv->magic);
>>>> -- 
>>>> 2.25.1
>>>>
>>>
>>
>>  From what I can see, there are other places in the kernel that could use the
>> _locked version of drm_is_current_master as well, such as drm_mode_getfb in
>> drm_framebuffer.c. I'll take a closer look, and if the changes make sense
>> I'll prepare a patch series for them.
> 
> Oh maybe we have a naming confusion: the _locked is the one where the
> caller must grab the lock already, whereas drm_is_current_master would
> grab the master_mutex internally to do the check. The one in
> drm_framebuffer.c looks like it'd need the internal one since there's no
> other need to grab the master_mutex.
> -Daniel
> 

Ah ok got it, I think I confused myself earlier.

Just to check, may I include you in a Reported-by: tag?
