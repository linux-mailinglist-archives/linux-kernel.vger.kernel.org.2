Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6566F36B23E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 13:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhDZLQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 07:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhDZLP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 07:15:59 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850D7C06138C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 04:15:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r20so34095742ejo.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 04:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hnjr3dCi4hCFH0E2IT+UC1Sw0LW27btik6EgV4fSASY=;
        b=ZK79hNDuTPAnQIcmy5yhMTe1JdyE3pgZxy+8e4WrhCvOmTkDcp9Wt0XowrgUI2TWiM
         m5eBSeNk0jxFBpCicqW9NSea2ed3Brwl/7gd7uAdsAsDfFqycfEAWtBR8v2tI69eF2fC
         PcIkBpTFoEWhbrkA5mQkHrZITQfhdgbP8oDls+uQklmfnayKurg7mSze6YRXn6j0Kp3q
         nNkdKJOKRK5UYMSVgK9QDgFy4TvE2dBnYMwg6lEpkxL06FLR4oA9guRfnAla3+QGX4DF
         QbeqfX6sAwRS0UIlUYK5MjFPMbeezJrv+sRg1xmudHzEkB8yrqigyp/33ncOddhNwEj/
         uaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hnjr3dCi4hCFH0E2IT+UC1Sw0LW27btik6EgV4fSASY=;
        b=g3EbMhwHlOrcKgWSoZPTRyEU8KZk14Bgkb+yodvGGzMRB/qunVbtnPL8RPqDNpdA44
         EypHTKJ2AeX87U6yjw1EU5+gPYIPeuJz9Adt3fKwEUQ17SrP2xf36sy5F8Lz0vK2SRpU
         5Jf/iksJCZvTjIbbahGuOBVcDZwYtUFjmN2iPGirc3VcALFB5EHXO/vkFLwXNMNtiWFx
         l8M8wWskjMCEyEiboZmsPS5c6ofFyhrQGE8ISFMuWHKUb0o1XQUPJXkt7jl40o9nrsbH
         amU0VxOfr1T4yYEScUL0GkpWJFHHEoqWWgLp+a9YB2PJmlFZXZmi+7UUGm62Zdd8w41y
         A0Dg==
X-Gm-Message-State: AOAM533Mn1PvOeMf9QWZFWCHihCVzIAYUBvBVZCvmS3Uf2CvAIcnDTFI
        tM+oAhqd/E2u7U4m7NvYL2U6v4d2qoo=
X-Google-Smtp-Source: ABdhPJx81PB9/OFPNLuSjgtYtafdOJTkTTVUWd+LMl4HPtM9iy8wWrNpPZQPwBImYgWHf5jqhZ6V7Q==
X-Received: by 2002:a17:907:c0b:: with SMTP id ga11mr17789045ejc.545.1619435716310;
        Mon, 26 Apr 2021 04:15:16 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:ddf1:e741:577e:9eb2? ([2a02:908:1252:fb60:ddf1:e741:577e:9eb2])
        by smtp.gmail.com with ESMTPSA id r25sm13611385edv.78.2021.04.26.04.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Apr 2021 04:15:15 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/ttm: optimize the pool shrinker a bit v2
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, vbabka@suse.cz, daniel@ffwll.ch,
        ray.huang@amd.com
References: <20210415115624.2904-1-christian.koenig@amd.com>
 <20210415115624.2904-2-christian.koenig@amd.com>
 <20210415133310.1ee9df70a9eb887be937c3a3@linux-foundation.org>
 <57572373-d68c-80de-7f9e-c04239d1b050@gmail.com>
Message-ID: <51fe2c43-4f05-5727-1680-b6907d652630@gmail.com>
Date:   Mon, 26 Apr 2021 13:15:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <57572373-d68c-80de-7f9e-c04239d1b050@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a gentle ping?

Are you ok with this explanation Andrew or should I look for a different 
approach?

Thanks,
Christian.

Am 16.04.21 um 09:08 schrieb Christian König:
> Am 15.04.21 um 22:33 schrieb Andrew Morton:
>> On Thu, 15 Apr 2021 13:56:24 +0200 "Christian König" 
>> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>> @@ -530,6 +525,11 @@ void ttm_pool_fini(struct ttm_pool *pool)
>>>               for (j = 0; j < MAX_ORDER; ++j)
>>> ttm_pool_type_fini(&pool->caching[i].orders[j]);
>>>       }
>>> +
>>> +    /* We removed the pool types from the LRU, but we need to also 
>>> make sure
>>> +     * that no shrinker is concurrently freeing pages from the pool.
>>> +     */
>>> +    sync_shrinkers();
>> It isn't immediately clear to me how this works. ttm_pool_fini() has
>> already freed all the pages hasn't it?  So why would it care if some
>> shrinkers are still playing with the pages?
>
> Yes ttm_pool_fini() has freed up all pages which had been in the pool 
> when the function was called.
>
> But the problem is it is possible that a parallel running shrinker has 
> taken a page from the pool and is in the process of freeing it up.
>
> When I return here the pool structure and especially the device 
> structure are freed while the parallel running shrinker is still using 
> them.
>
> I could go for a design where we have one shrinker per device instead, 
> but that would put a bit to much pressure on the pool in my opinion.
>
>> Or is it the case that ttm_pool_fini() is assuming that there will be
>> some further action against these pages, which requires that shrinkers
>> no longer be accessing the pages and which further assumes that future
>> shrinker invocations will not be able to look up these pages?
>>
>> IOW, a bit more explanation about the dynamics here would help!
>
> Sorry, I'm not a native speaker of English and sometimes still have a 
> hard time explaining things.
>
> Regards,
> Christian.

