Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6833305935
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhA0LHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:07:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:51290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235983AbhA0LEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:04:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 339FAACBA;
        Wed, 27 Jan 2021 11:04:05 +0000 (UTC)
To:     Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Bharata B Rao <bharata@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>
References: <20201118082759.1413056-1-bharata@linux.ibm.com>
 <CAKfTPtA_JgMf_+zdFbcb_V9rM7JBWNPjAz9irgwFj7Rou=xzZg@mail.gmail.com>
 <20210121053003.GB2587010@in.ibm.com>
 <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com>
 <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz>
 <20210123051607.GC2587010@in.ibm.com>
 <CAKfTPtAjyVmS5VYvU6DBxg4-JEo5bdmWbngf-03YsY18cmWv_g@mail.gmail.com>
 <66652406-25e4-a9e7-45a1-8ad14d2e8a36@suse.cz>
 <20210126230305.GD30941@willie-the-truck>
 <alpine.DEB.2.22.394.2101270907260.673600@www.lameter.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
Message-ID: <81424d71-c479-4c4a-de14-0a9b3f636e23@suse.cz>
Date:   Wed, 27 Jan 2021 12:04:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2101270907260.673600@www.lameter.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/21 10:10 AM, Christoph Lameter wrote:
> On Tue, 26 Jan 2021, Will Deacon wrote:
> 
>> > Hm, but booting the secondaries is just a software (kernel) action? They are
>> > already physically there, so it seems to me as if the cpu_present_mask is not
>> > populated correctly on arm64, and it's just a mirror of cpu_online_mask?
>>
>> I think the present_mask retains CPUs if they are hotplugged off, whereas
>> the online mask does not. We can't really do any better on arm64, as there's
>> no way of telling that a CPU is present until we've seen it.
> 
> The order of each page in a kmem cache --and therefore also the number
> of objects in a slab page-- can be different because that information is
> stored in the page struct.
> 
> Therefore it is possible to retune the order while the cache is in operaton.

Yes, but it's tricky to do the retuning safely, e.g. if freelist randomization
is enabled, see [1].

But as a quick fix for the regression, the heuristic idea could work reasonably
on all architectures?
- if num_present_cpus() is > 1, trust that it doesn't have the issue such as
arm64, and use it
- otherwise use nr_cpu_ids

Long-term we can attempt to do the retuning safe, or decide that number of cpus
shouldn't determine the order...

[1] https://lore.kernel.org/linux-mm/d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz/

> This means you can run an initcall after all cpus have been brought up to
> set the order and number of objects in a slab page differently.
> 
> The older slab pages will continue to exist with the old orders until they
> are freed.
> 

