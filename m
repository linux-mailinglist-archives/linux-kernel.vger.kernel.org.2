Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD85F359C98
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbhDILEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhDILEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:04:38 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1B7C061761
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 04:04:26 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id v6so6739409ejo.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 04:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=6/JnVL8LfaZdf+zS+mi0dG+OAyirzCOEuyoJgncWbSg=;
        b=eq8YU0RewVVk6hub1QGwAdPgMqo88js1FBgRgBvcQ/eyJXx0rrjkdsaRgSy5pVxDE5
         FXsGdJBjo1fLI6eyOd3do+o2BR/+B3lrN+9YF5JdxnHBnxtG6YVixgPtvcI4g6BE/yXf
         S85SCuoabIEhcs2ffoOr5WM62pto6LIZwZI68HCFe7p5hCgbWP21ZowiiUwys/YqUfd+
         EfIKV9vaNj4zLYF/uaalUeXtGwXK9HSqWKfzFIH3MNGRv7QlTbwYsr0ita6/SgygEcYf
         LYKzMGuTsm7MxtLoM5KvLGNVBdxldCOTkFa1SEaxVcmef1vIFgqPsRPp7QowqkI3P6QU
         Zwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6/JnVL8LfaZdf+zS+mi0dG+OAyirzCOEuyoJgncWbSg=;
        b=YkWXIZKwz91SrqZm7vNpEEO3u0iWYtO1PqVgYr57KVQXJKZET1IuyHYP+FYIRw+IC5
         iU8J9VNoF86Qyy5srdkcIvQ5FOv1ErOwJPsBE/H1DCZE1/ommmHbsdZ8TwgKiFqlXqkz
         iPYuj1773BbANhEuUt1kDeTUrU+CPnIbBS8w301D6BdVpAYq1LlzFCO1xanL0l9DpZNd
         4iDXc6yDRv8jOr9e180w5MflPKEnsxTRHtT634Ztq7baprrHGKbB01lkFXd/BHEtVOaw
         WMXzuph2y+7hcBRFrblyqEGNxL6QPDvuFASvMelMvCdlViEMlgNbsAcQDQbJmGIcsJzg
         fIoQ==
X-Gm-Message-State: AOAM530WeNNTBcm5jaHfHZKLXmFn3skUWjexQJXjRjgrN/sf20uDQEiz
        kOmm9044t2sX+z8WB5fDGOA=
X-Google-Smtp-Source: ABdhPJxJNZboaileCS232D/njgL/jwYVi3sL0vyTBT+hTXCmnyaKNCqta3CREGAvoYmQHy0jdYHNYg==
X-Received: by 2002:a17:906:7d02:: with SMTP id u2mr129361ejo.249.1617966264746;
        Fri, 09 Apr 2021 04:04:24 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:ffef:9b69:ce50:8284? ([2a02:908:1252:fb60:ffef:9b69:ce50:8284])
        by smtp.gmail.com with ESMTPSA id e15sm1066012ejh.56.2021.04.09.04.04.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 04:04:24 -0700 (PDT)
Subject: Re: [PATCH 1/2] mm/vmscan: add sync_shrinkers function
To:     Vlastimil Babka <vbabka@suse.cz>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     ray.huang@amd.com, daniel@ffwll.ch, akpm@linux-foundation.org
References: <20210409071725.1532-1-christian.koenig@amd.com>
 <462c2a51-4aa8-47ba-1c67-171ca651b016@suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <951bf630-35e4-9b5a-2ace-007a685d1994@gmail.com>
Date:   Fri, 9 Apr 2021 13:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <462c2a51-4aa8-47ba-1c67-171ca651b016@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 09.04.21 um 13:00 schrieb Vlastimil Babka:
> On 4/9/21 9:17 AM, Christian König wrote:
>> To be able to switch to a spinlock and reduce lock contention in the TTM
>> shrinker we don't want to hold a mutex while unmapping and freeing pages
>> from the pool.
> Does using spinlock instead of mutex really reduce lock contention?

Well using the spinlock instead of the mutex is only the cherry on the cake.

The real improvement for the contention is the fact that we just grab 
the next pool and drop the lock again instead of doing the whole IOMMU 
unmap and flushing of the CPU TLB dance while holding the lock.

>> But then we somehow need to prevent a race between (for example) the shrinker
>> trying to free pages and hotplug trying to remove the device which those pages
>> belong to.
>>
>> Taking and releasing the shrinker semaphore on the write side after
>> unmapping and freeing all pages should make sure that no shrinker is running in
>> paralell any more.
> So you explain this in this commit log for adding the function, but then the
> next patch just adds a sync_shrinkers() call without any comment. I would expect
> there a comment explaining why it's done there - what it protects against, as
> it's not an obvious pattern IMHO.

Good point, going to add a comment.

Thanks,
Christian.

>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   include/linux/shrinker.h |  1 +
>>   mm/vmscan.c              | 10 ++++++++++
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/include/linux/shrinker.h b/include/linux/shrinker.h
>> index 0f80123650e2..6b75dc372fce 100644
>> --- a/include/linux/shrinker.h
>> +++ b/include/linux/shrinker.h
>> @@ -92,4 +92,5 @@ extern void register_shrinker_prepared(struct shrinker *shrinker);
>>   extern int register_shrinker(struct shrinker *shrinker);
>>   extern void unregister_shrinker(struct shrinker *shrinker);
>>   extern void free_prealloced_shrinker(struct shrinker *shrinker);
>> +extern void sync_shrinkers(void);
>>   #endif
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 562e87cbd7a1..46cd9c215d73 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -408,6 +408,16 @@ void unregister_shrinker(struct shrinker *shrinker)
>>   }
>>   EXPORT_SYMBOL(unregister_shrinker);
>>   
>> +/**
>> + * sync_shrinker - Wait for all running shrinkers to complete.
>> + */
>> +void sync_shrinkers(void)
>> +{
>> +	down_write(&shrinker_rwsem);
>> +	up_write(&shrinker_rwsem);
>> +}
>> +EXPORT_SYMBOL(sync_shrinkers);
>> +
>>   #define SHRINK_BATCH 128
>>   
>>   static unsigned long do_shrink_slab(struct shrink_control *shrinkctl,
>>

