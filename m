Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1608C394055
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhE1Jyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234926AbhE1Jyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622195581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nsLO7oE7ppzKwDyWlT5ZZ5W2YnsqsWgEvpJ/TDeViTw=;
        b=XdPGe3pltsNwZc/TCmjMQc3ZaIakei7UQGNqiohwvUcuJoXkAs2EQgGjteqXguCOZLdvWa
        tcdWHVtU0o+mHSGUREVx2gW5kgQrHz65cpkSXole8ap3zBljXQrDKuoXOLMv1Iu8u66NAf
        9jwRptGr9IdFa0zr/jHI8mNIvecY0zM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-EkW52LtdNg2gE3RGojgbKQ-1; Fri, 28 May 2021 05:52:55 -0400
X-MC-Unique: EkW52LtdNg2gE3RGojgbKQ-1
Received: by mail-wm1-f69.google.com with SMTP id v2-20020a7bcb420000b0290146b609814dso975780wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:52:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nsLO7oE7ppzKwDyWlT5ZZ5W2YnsqsWgEvpJ/TDeViTw=;
        b=pDscDc1CYd5c8ZTWcdqjgn1MEqyDVkSbWzczjfGeWGNJKvPTS6JGUBZ3v+eZsXJdAF
         15m7QzPyjFJBmLueWO/PgY9d7UfRfR3Ss+TotPFJ7GnkI6TKcDyh9asan6vhWFS08GeX
         1qESRH5MUXpI9cHpKVk/K2nDl+Kg4rF/CJvtnGv9CertyvmwWROEv5hNfmmRAZQj9M9Y
         eMhQeKG6Ar7qV+9bPnZjqzI17rDpy8o9CQmAtSz62MdpPlJGNtOI5JRKc3pYg9iCocCv
         6f8EmmO5lA3KMWHGXxDlkFp9nX9fd+GvcIHlPo06B4lo0/gRtwRbitQ2Yt5VALz1o4yO
         zfxA==
X-Gm-Message-State: AOAM533YWHU870WKc0sTu6cpMS1bd+14oCO/4uF2fMevrw9i/M/ORq/n
        ZHFY5cjRUccjuklzrZ6ngSaIpqUFWQlj6EiG5XZSZvZJ4yg0RpR1F8EB2Ai1Xff9R/Q9Q+DDT8m
        KqILiupQvUhKHIjf/As5fpKpp
X-Received: by 2002:a5d:678d:: with SMTP id v13mr7837036wru.83.1622195574371;
        Fri, 28 May 2021 02:52:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxG4YyUeXor4MT0iGqBaZAOV/7On75O7U8GctRL57wC7nBOjUUfEzxiFJ/HR6a3s5j8EhW+Lg==
X-Received: by 2002:a5d:678d:: with SMTP id v13mr7837021wru.83.1622195574175;
        Fri, 28 May 2021 02:52:54 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6870.dip0.t-ipconnect.de. [91.12.104.112])
        by smtp.gmail.com with ESMTPSA id y22sm15948776wma.36.2021.05.28.02.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 May 2021 02:52:53 -0700 (PDT)
Subject: Re: [PATCH 0/6 v2] Calculate pcp->high based on zone sizes and active
 CPUs
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hillf Danton <hdanton@sina.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, "Tang, Feng" <feng.tang@intel.com>
References: <20210525080119.5455-1-mgorman@techsingularity.net>
 <7177f59b-dc05-daff-7dc6-5815b539a790@intel.com>
 <20210528085545.GJ30378@techsingularity.net>
 <54ff0363-2f39-71d1-e26c-962c3fddedae@redhat.com>
 <e73d39cc-df2f-5000-0212-6073955fb291@redhat.com>
 <20210528094949.GL30378@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <6c189def-11cc-80db-0fde-56aa506cfdea@redhat.com>
Date:   Fri, 28 May 2021 11:52:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210528094949.GL30378@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.05.21 11:49, Mel Gorman wrote:
> On Fri, May 28, 2021 at 11:08:01AM +0200, David Hildenbrand wrote:
>> On 28.05.21 11:03, David Hildenbrand wrote:
>>> On 28.05.21 10:55, Mel Gorman wrote:
>>>> On Thu, May 27, 2021 at 12:36:21PM -0700, Dave Hansen wrote:
>>>>> Hi Mel,
>>>>>
>>>>> Feng Tang tossed these on a "Cascade Lake" system with 96 threads and
>>>>> ~512G of persistent memory and 128G of DRAM.  The PMEM is in "volatile
>>>>> use" mode and being managed via the buddy just like the normal RAM.
>>>>>
>>>>> The PMEM zones are big ones:
>>>>>
>>>>>            present  65011712 = 248 G
>>>>>            high       134595 = 525 M
>>>>>
>>>>> The PMEM nodes, of course, don't have any CPUs in them.
>>>>>
>>>>> With your series, the pcp->high value per-cpu is 69584 pages or about
>>>>> 270MB per CPU.  Scaled up by the 96 CPU threads, that's ~26GB of
>>>>> worst-case memory in the pcps per zone, or roughly 10% of the size of
>>>>> the zone.
>>>
>>> When I read about having such big amounts of free memory theoretically
>>> stuck in PCP lists, I guess we really want to start draining the PCP in
>>> alloc_contig_range(), just as we do with memory hotunplug when offlining.
>>>
>>
>> Correction: we already drain the pcp, we just don't temporarily disable it,
>> so a race as described in offline_pages() could apply:
>>
>> "Disable pcplists so that page isolation cannot race with freeing
>>   in a way that pages from isolated pageblock are left on pcplists."
>>
>> Guess we'd then want to move the draining before start_isolate_page_range()
>> in alloc_contig_range().
>>
> 
> Or instead of draining, validate the PFN range in alloc_contig_range
> is within the same zone and if so, call zone_pcp_disable() before
> start_isolate_page_range and enable after __alloc_contig_migrate_range.
> 

We require the caller to only pass a range within a single zone, so that 
should be fine.

The only ugly thing about zone_pcp_disable() is 
mutex_lock(&pcp_batch_high_lock) which would serialize all 
alloc_contig_range() and even with offline_pages().

-- 
Thanks,

David / dhildenb

