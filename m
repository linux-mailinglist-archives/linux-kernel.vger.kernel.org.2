Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B1235F664
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351836AbhDNOoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349135AbhDNOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:44:00 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E42BC061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:43:37 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id s16so15633640iog.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YZVZDpwAdidWFtU6RiI402UdeGUs8c1Nk5u1ItVyewM=;
        b=N0AjO9bryWx3Ag8bLuoxEt2+guOISDaF9i5gzO9Mdr2w98+j+auDIXMUs1+g9TcBWQ
         Ykb4bTkF84KkfPpSFPb5BeVj3H+PQIw/zX93Uc9T+BuNEztLex0ugwV3cnUo+gAKexar
         ToZAcSDgTFWXrY1dzY3v9gfZE7H/QB6uJ4YB37pAqbhEkr2L9bvf7CrA4yUyvnoTSNMC
         PWcreuW6WuUyCmW1WCfTg/it1+Lk9cOlxeuD3QUP8XrFQNKndOlho4PAfxD1VFePiP6e
         T/ZMVg9ipP5x3FvwehDa3IM4KherTZWvlI3z+cImcyejFU7kvygHHwwykZkB+qC0iPru
         gAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YZVZDpwAdidWFtU6RiI402UdeGUs8c1Nk5u1ItVyewM=;
        b=iJUUjdZLkS3ZcxmbAlp1Np6LNsqqBPegE1+fdBCKk8ufCDl/hSpLizSJaXMMZZ0jNa
         /zfY5yxW5Xr//FGvBLmoKOeKU0O0lFGljCtC/sY2/f6BMhHZx70ujkzDSfdSP0EEUw7K
         1B4tbzIHvt45ENDl/zLIzmWTRek8a9bfMyp3lQTCyxMpzltsiRMlbF1LfLMq1e5fUSwz
         tFomtn/Wy+z11niqzNc154V9YDPv9o3xmpSI6c7kg6IFMyGGIu1DbSGY8owJsADTv/op
         6W42jV+X3A5PJEMDGPmBtpm1bkfZSoHye1J+HDQmjeEJonQRIuz3a8j2BwZlsaEiJD5K
         kgmg==
X-Gm-Message-State: AOAM531NCyblNHoQyja3imb9E8qwHGwyE9IHkPBrNk5/tezZXnIkv0de
        8m3gvmN+K31L/V3qMRdEnSFmWg==
X-Google-Smtp-Source: ABdhPJzyjJzBMO59YSTbgba3MsXmD20jos+S+Jo0tu8a1CQqA2feVDd+7+Hmi9Ff/ONyb6f4ZP7E7g==
X-Received: by 2002:a02:230d:: with SMTP id u13mr39458646jau.53.1618411416481;
        Wed, 14 Apr 2021 07:43:36 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o6sm8264302ioa.21.2021.04.14.07.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 07:43:36 -0700 (PDT)
Subject: Re: [PATCH v2 00/16] Multigenerational LRU Framework
To:     Dave Chinner <david@fromorbit.com>
Cc:     SeongJae Park <sj38.park@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Manes <ben.manes@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michael Larabel <michael@michaellarabel.com>,
        Michal Hocko <mhocko@suse.com>,
        Michel Lespinasse <michel@lespinasse.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Rong Chen <rong.a.chen@intel.com>,
        SeongJae Park <sjpark@amazon.de>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        Ying Huang <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        linux-kernel@vger.kernel.org, lkp@lists.01.org,
        page-reclaim@google.com
References: <20210413075155.32652-1-sjpark@amazon.de>
 <3ddd4f8a-8e51-662b-df11-a63a0e75b2bc@kernel.dk>
 <20210413231436.GF63242@dread.disaster.area>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <91146ee7-3054-a81a-296e-e75c24f4e290@kernel.dk>
Date:   Wed, 14 Apr 2021 08:43:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210413231436.GF63242@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 5:14 PM, Dave Chinner wrote:
> On Tue, Apr 13, 2021 at 10:13:24AM -0600, Jens Axboe wrote:
>> On 4/13/21 1:51 AM, SeongJae Park wrote:
>>> From: SeongJae Park <sjpark@amazon.de>
>>>
>>> Hello,
>>>
>>>
>>> Very interesting work, thank you for sharing this :)
>>>
>>> On Tue, 13 Apr 2021 00:56:17 -0600 Yu Zhao <yuzhao@google.com> wrote:
>>>
>>>> What's new in v2
>>>> ================
>>>> Special thanks to Jens Axboe for reporting a regression in buffered
>>>> I/O and helping test the fix.
>>>
>>> Is the discussion open?  If so, could you please give me a link?
>>
>> I wasn't on the initial post (or any of the lists it was posted to), but
>> it's on the google page reclaim list. Not sure if that is public or not.
>>
>> tldr is that I was pretty excited about this work, as buffered IO tends
>> to suck (a lot) for high throughput applications. My test case was
>> pretty simple:
>>
>> Randomly read a fast device, using 4k buffered IO, and watch what
>> happens when the page cache gets filled up. For this particular test,
>> we'll initially be doing 2.1GB/sec of IO, and then drop to 1.5-1.6GB/sec
>> with kswapd using a lot of CPU trying to keep up. That's mainline
>> behavior.
> 
> I see this exact same behaviour here, too, but I RCA'd it to
> contention between the inode and memory reclaim for the mapping
> structure that indexes the page cache. Basically the mapping tree
> lock is the contention point here - you can either be adding pages
> to the mapping during IO, or memory reclaim can be removing pages
> from the mapping, but we can't do both at once.
> 
> So we end up with kswapd spinning on the mapping tree lock like so
> when doing 1.6GB/s in 4kB buffered IO:
> 
> -   20.06%     0.00%  [kernel]               [k] kswapd                                                                                                        ▒
>    - 20.06% kswapd                                                                                                                                             ▒
>       - 20.05% balance_pgdat                                                                                                                                   ▒
>          - 20.03% shrink_node                                                                                                                                  ▒
>             - 19.92% shrink_lruvec                                                                                                                             ▒
>                - 19.91% shrink_inactive_list                                                                                                                   ▒
>                   - 19.22% shrink_page_list                                                                                                                    ▒
>                      - 17.51% __remove_mapping                                                                                                                 ▒
>                         - 14.16% _raw_spin_lock_irqsave                                                                                                        ▒
>                            - 14.14% do_raw_spin_lock                                                                                                           ▒
>                                 __pv_queued_spin_lock_slowpath                                                                                                 ▒
>                         - 1.56% __delete_from_page_cache                                                                                                       ▒
>                              0.63% xas_store                                                                                                                   ▒
>                         - 0.78% _raw_spin_unlock_irqrestore                                                                                                    ▒
>                            - 0.69% do_raw_spin_unlock                                                                                                          ▒
>                                 __raw_callee_save___pv_queued_spin_unlock                                                                                      ▒
>                      - 0.82% free_unref_page_list                                                                                                              ▒
>                         - 0.72% free_unref_page_commit                                                                                                         ▒
>                              0.57% free_pcppages_bulk                                                                                                          ▒
> 
> And these are the processes consuming CPU:
> 
>    5171 root      20   0 1442496   5696   1284 R  99.7   0.0   1:07.78 fio
>    1150 root      20   0       0      0      0 S  47.4   0.0   0:22.70 kswapd1
>    1146 root      20   0       0      0      0 S  44.0   0.0   0:21.85 kswapd0
>    1152 root      20   0       0      0      0 S  39.7   0.0   0:18.28 kswapd3
>    1151 root      20   0       0      0      0 S  15.2   0.0   0:12.14 kswapd2

Here's my profile when memory reclaim is active for the above mentioned
test case. This is a single node system, so just kswapd. It's using around
40-45% CPU:

    43.69%  kswapd0  [kernel.vmlinux]  [k] xas_create
            |
            ---ret_from_fork
               kthread
               kswapd
               balance_pgdat
               shrink_node
               shrink_lruvec
               shrink_inactive_list
               shrink_page_list
               __delete_from_page_cache
               xas_store
               xas_create

    16.88%  kswapd0  [kernel.vmlinux]  [k] queued_spin_lock_slowpath
            |
            ---ret_from_fork
               kthread
               kswapd
               balance_pgdat
               shrink_node
               shrink_lruvec
               |          
                --16.82%--shrink_inactive_list
                          |          
                           --16.55%--shrink_page_list
                                     |          
                                      --16.26%--_raw_spin_lock_irqsave
                                                queued_spin_lock_slowpath

     9.89%  kswapd0  [kernel.vmlinux]  [k] shrink_page_list
            |
            ---ret_from_fork
               kthread
               kswapd
               balance_pgdat
               shrink_node
               shrink_lruvec
               shrink_inactive_list
               shrink_page_list

     5.46%  kswapd0  [kernel.vmlinux]  [k] xas_init_marks
            |
            ---ret_from_fork
               kthread
               kswapd
               balance_pgdat
               shrink_node
               shrink_lruvec
               shrink_inactive_list
               shrink_page_list
               |          
                --5.41%--__delete_from_page_cache
                          xas_init_marks

     4.42%  kswapd0  [kernel.vmlinux]  [k] __delete_from_page_cache
            |
            ---ret_from_fork
               kthread
               kswapd
               balance_pgdat
               shrink_node
               shrink_lruvec
               shrink_inactive_list
               |          
                --4.40%--shrink_page_list
                          __delete_from_page_cache

     2.82%  kswapd0  [kernel.vmlinux]  [k] isolate_lru_pages
            |
            ---ret_from_fork
               kthread
               kswapd
               balance_pgdat
               shrink_node
               shrink_lruvec
               |          
               |--1.43%--shrink_active_list
               |          isolate_lru_pages
               |          
                --1.39%--shrink_inactive_list
                          isolate_lru_pages

     1.99%  kswapd0  [kernel.vmlinux]  [k] free_pcppages_bulk
            |
            ---ret_from_fork
               kthread
               kswapd
               balance_pgdat
               shrink_node
               shrink_lruvec
               shrink_inactive_list
               shrink_page_list
               free_unref_page_list
               free_unref_page_commit
               free_pcppages_bulk

     1.79%  kswapd0  [kernel.vmlinux]  [k] _raw_spin_lock_irqsave
            |
            ---ret_from_fork
               kthread
               kswapd
               balance_pgdat
               |          
                --1.76%--shrink_node
                          shrink_lruvec
                          shrink_inactive_list
                          |          
                           --1.72%--shrink_page_list
                                     _raw_spin_lock_irqsave

     1.02%  kswapd0  [kernel.vmlinux]  [k] workingset_eviction
            |
            ---ret_from_fork
               kthread
               kswapd
               balance_pgdat
               shrink_node
               shrink_lruvec
               shrink_inactive_list
               |          
                --1.00%--shrink_page_list
                          workingset_eviction

> i.e. when memory reclaim kicks in, the read process has 20% less
> time with exclusive access to the mapping tree to insert new pages.
> Hence buffered read performance goes down quite substantially when
> memory reclaim kicks in, and this really has nothing to do with the
> memory reclaim LRU scanning algorithm.
> 
> I can actually get this machine to pin those 5 processes to 100% CPU
> under certain conditions. Each process is spinning all that extra
> time on the mapping tree lock, and performance degrades further.
> Changing the LRU reclaim algorithm won't fix this - the workload is
> solidly bound by the exclusive nature of the mapping tree lock and
> the number of tasks trying to obtain it exclusively...

I've seen way worse than the above as well, it's just my go-to easy test
case for "man I wish buffered IO didn't suck so much".

>> The initial posting of this patchset did no better, in fact it did a bit
>> worse. Performance dropped to the same levels and kswapd was using as
>> much CPU as before, but on top of that we also got excessive swapping.
>> Not at a high rate, but 5-10MB/sec continually.
>>
>> I had some back and forths with Yu Zhao and tested a few new revisions,
>> and the current series does much better in this regard. Performance
>> still dips a bit when page cache fills, but not nearly as much, and
>> kswapd is using less CPU than before.
> 
> Profiles would be interesting, because it sounds to me like reclaim
> *might* be batching page cache removal better (e.g. fewer, larger
> batches) and so spending less time contending on the mapping tree
> lock...
> 
> IOWs, I suspect this result might actually be a result of less lock
> contention due to a change in batch processing characteristics of
> the new algorithm rather than it being a "better" algorithm...

See above - let me know if you want to see more specific profiling as
well.

-- 
Jens Axboe

