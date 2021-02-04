Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9C430EFC4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 10:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbhBDJev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 04:34:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:40396 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235040AbhBDJed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 04:34:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF8F4AC97;
        Thu,  4 Feb 2021 09:33:47 +0000 (UTC)
Subject: Re: [RFC PATCH v0] mm/slub: Let number of online CPUs determine the
 slub page order
To:     bharata@linux.ibm.com
Cc:     Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, guro@fb.com,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        aneesh.kumar@linux.ibm.com, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>
References: <alpine.DEB.2.22.394.2101210959060.100764@www.lameter.com>
 <d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz>
 <CAKfTPtDy3Ynk2nGCTWiXjz9-4vuSHB3pGuafoTUBPFNO1ac3PA@mail.gmail.com>
 <786571e7-b9a2-4cdb-06d5-aa4a4b439b7e@suse.cz>
 <20210123051607.GC2587010@in.ibm.com>
 <CAKfTPtAjyVmS5VYvU6DBxg4-JEo5bdmWbngf-03YsY18cmWv_g@mail.gmail.com>
 <66652406-25e4-a9e7-45a1-8ad14d2e8a36@suse.cz>
 <20210126230305.GD30941@willie-the-truck>
 <alpine.DEB.2.22.394.2101270907260.673600@www.lameter.com>
 <81424d71-c479-4c4a-de14-0a9b3f636e23@suse.cz>
 <20210203111009.GB2869122@in.ibm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <aac07668-99a0-4c7e-5f8b-10751af364c5@suse.cz>
Date:   Thu, 4 Feb 2021 10:33:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210203111009.GB2869122@in.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/3/21 12:10 PM, Bharata B Rao wrote:
> On Wed, Jan 27, 2021 at 12:04:01PM +0100, Vlastimil Babka wrote:
>> Yes, but it's tricky to do the retuning safely, e.g. if freelist randomization
>> is enabled, see [1].
>> 
>> But as a quick fix for the regression, the heuristic idea could work reasonably
>> on all architectures?
>> - if num_present_cpus() is > 1, trust that it doesn't have the issue such as
>> arm64, and use it
>> - otherwise use nr_cpu_ids
>> 
>> Long-term we can attempt to do the retuning safe, or decide that number of cpus
>> shouldn't determine the order...
>> 
>> [1] https://lore.kernel.org/linux-mm/d7fb9425-9a62-c7b8-604d-5828d7e6b1da@suse.cz/
> 
> So what is preferrable here now? Above or other quick fix or reverting
> the original commit?

I would try the above first. In case it doesn't work, revert. As the immediate
fix for the regression, that people can safely backport.
Anything more complex will take more time and would be more risky to backport.

> Regards,
> Bharata.
> 

