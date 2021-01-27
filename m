Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1BC305D68
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:42:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbhA0NlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:41:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:54484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238534AbhA0NjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:39:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6233EAF49;
        Wed, 27 Jan 2021 13:38:33 +0000 (UTC)
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
To:     Michal Hocko <mhocko@suse.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <20210126085243.GE827@dhcp22.suse.cz>
 <CAKfTPtAhqiHtPMUTZv8Bs3Cg5=HXLmrda=j4_HFrF=7ztYZLGA@mail.gmail.com>
 <20210126135918.GQ827@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <62d61572-830b-a660-8049-3826128343c5@suse.cz>
Date:   Wed, 27 Jan 2021 14:38:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126135918.GQ827@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 2:59 PM, Michal Hocko wrote:
>> 
>> On 8 CPUs, I run hackbench with up to 16 groups which means 16*40
>> threads. But I raise up to 256 groups, which means 256*40 threads, on
>> the 224 CPUs system. In fact, hackbench -g 1 (with 1 group) doesn't
>> regress on the 224 CPUs  system.  The next test with 4 groups starts
>> to regress by -7%. But the next one: hackbench -g 16 regresses by 187%
>> (duration is almost 3 times longer). It seems reasonable to assume
>> that the number of running threads and resources scale with the number
>> of CPUs because we want to run more stuff.
> 
> OK, I do understand that more jobs scale with the number of CPUs but I
> would also expect that higher order pages are generally more expensive
> to get so this is not really a clear cut especially under some more
> demand on the memory where allocations are smooth. So the question
> really is whether this is not just optimizing for artificial conditions.

FWIW, I enabled CONFIG_SLUB_STATS and run "hackbench -l 16000 -g 16" in a
(small) VM, and checked tools/vm/slabinfo -DA as per the config option's help,
and it seems to be these 2 caches that are stressed:

Name                   Objects      Alloc       Free   %Fast Fallb O CmpX   UL
kmalloc-512                812   25655535   25654908  71   1     0 0 20082    0
skbuff_head_cache          304   25602632   25602632  84   1     0 0 11241    0

I guess larger pages mean more batched per-cpu allocations without going to the
shared structures or even page allocator. But 3 times duration is still surprising
to me. I'll dig more.
 

