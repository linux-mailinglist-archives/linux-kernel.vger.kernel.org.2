Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59535368737
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 21:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236952AbhDVTcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 15:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDVTcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 15:32:32 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DC4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:31:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id f6-20020a17090a6546b029015088cf4a1eso1543494pjs.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HtlHiq0OXm9PrD6fGzcxib+iHeSzuf64yByn1v5aKv8=;
        b=LwV4HrEp45TBQ19vnNUH70ukl4eRnlAL32lVAnklfGvL0fqK71oB9JexmFY5tIo9xV
         +WqyREO0MMGKkBIXQkr93BmGKcIpysRN9/cqJlkvTsLjZC/pMly0sptr65NXnaoY41Wm
         X8Af6MqgbwEZx2tyMuJzGnVi99lXjWGeOZJpIzx3uGaw9XjCWFuiS3U2XigP+pTr1d5A
         phwp3GVUusKrEOkAD6quZqUakoyoLDUH05kf15Xa9dbACH2Xxf1m2Tw3ra+k3CM4N+zh
         bV51IJDeVwK1P9cz+kcXs9j2tA2pCEXEN8BRjWteAqUP8KVV+A0cZPygcm1RfLCYUkrE
         Okug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HtlHiq0OXm9PrD6fGzcxib+iHeSzuf64yByn1v5aKv8=;
        b=SeXle/u/l6/rPC8OfohWblGHaCH84aOaLK3sLrulMGae8i4Fuur3zVmbpnf4DJkwRa
         MWh76tkLp0chiXp8O+uyFGQrLtnDoPH5CgKgggM8g3uhZOKs9P9mRj/+s4M1o+JgtGCu
         rXGDoezo4w8fptXGzA5xGuGhhUj8hc9esh3zNDtdSQG/sBhxFtOV0BYJq/C86kv1d1Yn
         muQOynYni/mo5X5Aed9G+AzmfakRxaxF4tDm5XzaHNWqBUA59jNEgAZy+yfRiFge48Ne
         j7ujSR1s+W/9R06OZVa03N+gIiGgsPR0Zpi8BHi0kucbNmwb1c8w6JO+a5huAq2xrgHc
         S3Lw==
X-Gm-Message-State: AOAM531sKszGLH4354dR9a3Jg7W5qiXNb6g96A7oRMaa5eq9vSnJiKhy
        cPI9MxDFhejJRR2DiyuqePU=
X-Google-Smtp-Source: ABdhPJwmlxvE13U20o4EVs5e5HoPFbkVMQjktu3xZ4dyTjTKHKkJbtEn+21mtb4DXAj6+HXV06ehRw==
X-Received: by 2002:a17:90a:7c4b:: with SMTP id e11mr1616813pjl.151.1619119914995;
        Thu, 22 Apr 2021 12:31:54 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k127sm2956907pfd.63.2021.04.22.12.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 12:31:54 -0700 (PDT)
Subject: Re: alloc_contig_range() with MIGRATE_MOVABLE performance regression
 since 4.9
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, l.stach@pengutronix.de,
        LKML <linux-kernel@vger.kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>,
        Michal Nazarewicz <mina86@mina86.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Oscar Salvador <OSalvador@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <dbdf7b8c-9165-f87c-92d4-cfb5a4f01221@gmail.com>
 <YIEqpIOAyrs26soC@dhcp22.suse.cz>
 <8919b724-ce5b-a80f-bbea-98b99af97357@redhat.com>
 <58726a6b-5468-a6b4-7c26-371ef5d71ee2@gmail.com>
 <9df905cf-cc4f-c739-26cb-c2e5c6e5a234@redhat.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <a0420344-4d9b-8e90-69cd-b0de20d683e0@gmail.com>
Date:   Thu, 22 Apr 2021 12:31:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <9df905cf-cc4f-c739-26cb-c2e5c6e5a234@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/2021 11:35 AM, David Hildenbrand wrote:
> On 22.04.21 19:50, Florian Fainelli wrote:
>>
>>
>> On 4/22/2021 1:56 AM, David Hildenbrand wrote:
>>> On 22.04.21 09:49, Michal Hocko wrote:
>>>> Cc David and Oscar who are familiar with this code as well.
>>>>
>>>> On Wed 21-04-21 11:36:01, Florian Fainelli wrote:
>>>>> Hi all,
>>>>>
>>>>> I have been trying for the past few days to identify the source of a
>>>>> performance regression that we are seeing with the 5.4 kernel but not
>>>>> with the 4.9 kernel on ARM64. Testing something newer like 5.10 is
>>>>> a bit
>>>>> challenging at the moment but will happen eventually.
>>>>>
>>>>> What we are seeing is a ~3x increase in the time needed for
>>>>> alloc_contig_range() to allocate 1GB in blocks of 2MB pages. The
>>>>> system
>>>>> is idle at the time and there are no other contenders for memory other
>>>>> than the user-space programs already started (DHCP client, shell,
>>>>> etc.).
>>>
>>> Hi,
>>>
>>> If you can easily reproduce it might be worth to just try bisecting;
>>> that could be faster than manually poking around in the code.
>>>
>>> Also, it would be worth having a look at the state of upstream Linux.
>>> Upstream Linux developers tend to not care about minor performance
>>> regressions on oldish kernels.
>>
>> This is a big pain point here and I cannot agree more, but until we
>> bridge that gap, this is not exactly easy to do for me unfortunately and
>> neither is bisection :/
>>
>>>
>>> There has been work on improving exactly the situation you are
>>> describing -- a "fail fast" / "no retry" mode for alloc_contig_range().
>>> Maybe it tackles exactly this issue.
>>>
>>> https://lkml.kernel.org/r/20210121175502.274391-3-minchan@kernel.org
>>>
>>> Minchan is already on cc.
>>
>> This patch does not appear to be helping, in fact, I had locally applied
>> this patch from way back when:
>>
>> https://lkml.org/lkml/2014/5/28/113
>>
>> which would effectively do this unconditionally. Let me see if I can
>> showcase this problem a x86 virtual machine operating in similar
>> conditions to ours.
> 
> How exactly are you allocating these 2MiB blocks?
> 
> Via CMA->alloc_contig_range() or via alloc_contig_range() directly? I
> assume via CMA.

I am allocating this memory directly via alloc_contig_range(start, end,
MIGRATE_MOVABLE, GFP_KERNEL), just looping over 1024MB via 2MB
increments. This is just a synthetic benchmark though we do have an
allocator that behaves just like that as well.

> 
> For
> 
> https://lkml.kernel.org/r/20210121175502.274391-3-minchan@kernel.org
> 
> to do its work you'll have to pass  __GFP_NORETRY to
> alloc_contig_range(). This requires CMA adaptions, from where we call
> alloc_contig_range().

Yes, I did modify the alloc_contig_range() caller to pass GFP_KERNEL |
__GFP_NORETRY. I did run for a more iterations (1000) and the results
are not very conclusive as with __GFP_NORETRY the allocation time per
allocation was not significantly better, in fact it was slightly worse
by 100us than without.

My x86 VM with 1GB of DRAM including 512MB being in ZONE_MOVABLE does
shows identical numbers for both 4.9 and 5.4 so this must be something
specific to ARM64 and/or the code we added to create a ZONE_MOVABLE on
that architecture since movablecore does not appear to have any effect
unlike x86.
-- 
Florian
