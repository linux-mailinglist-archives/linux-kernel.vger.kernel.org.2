Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C392E34712C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 06:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbhCXFnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 01:43:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:61502 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232805AbhCXFmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 01:42:33 -0400
IronPort-SDR: H3BAL5/2LxDdOeN09prRVJ6Rosb0x2i82ghu1ghYyToL3UzkhuIjKUfIyibK7S9Lw7/qH9990w
 Kfco45hOP6CQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="169972015"
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="169972015"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 22:42:31 -0700
IronPort-SDR: uY8zEC9EPsgGJ7D6e5j4Zix4CcoOOaky9/lPtfzMmfm1SD2SJ/ltKADe5SflKld3bHpzQ0M5f6
 uEXMt3ar5jqg==
X-IronPort-AV: E=Sophos;i="5.81,272,1610438400"; 
   d="scan'208";a="514059073"
Received: from likexu-mobl1.ccr.corp.intel.com (HELO [10.238.4.93]) ([10.238.4.93])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 22:42:27 -0700
Subject: Re: [PATCH v4 RESEND 3/5] perf/x86/lbr: Move cpuc->lbr_xsave
 allocation out of sleeping region
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210322060635.821531-1-like.xu@linux.intel.com>
 <20210322060635.821531-4-like.xu@linux.intel.com>
 <CAM9d7ci7qj47xDC3z2AzYGjnFdPRNsuEPGivZ1_re-XGhoBwMg@mail.gmail.com>
 <5fda3599-1b51-5f58-fdcc-2afcf6d4968b@linux.intel.com>
 <CAM9d7cgouGAAt46qe_DGqMX0xzYF3a0ZQw2aXFwdxo4d66d18A@mail.gmail.com>
From:   Like Xu <like.xu@linux.intel.com>
Organization: Intel OTC
Message-ID: <103ad691-4ea8-6fcb-afcc-c69e3abcd1f6@linux.intel.com>
Date:   Wed, 24 Mar 2021 13:42:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgouGAAt46qe_DGqMX0xzYF3a0ZQw2aXFwdxo4d66d18A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/24 12:04, Namhyung Kim wrote:
> On Wed, Mar 24, 2021 at 12:47 PM Like Xu <like.xu@linux.intel.com> wrote:
>>
>> Hi Namhyung,
>>
>> On 2021/3/24 9:32, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Mon, Mar 22, 2021 at 3:14 PM Like Xu <like.xu@linux.intel.com> wrote:
>>>> +void reserve_lbr_buffers(struct perf_event *event)
>>>> +{
>>>> +       struct kmem_cache *kmem_cache = x86_get_pmu()->task_ctx_cache;
>>>> +       struct cpu_hw_events *cpuc;
>>>> +       int cpu;
>>>> +
>>>> +       if (!static_cpu_has(X86_FEATURE_ARCH_LBR))
>>>> +               return;
>>>> +
>>>> +       for_each_possible_cpu(cpu) {
>>>> +               cpuc = per_cpu_ptr(&cpu_hw_events, cpu);
>>>> +               if (kmem_cache && !cpuc->lbr_xsave && !event->attr.precise_ip)
>>>> +                       cpuc->lbr_xsave = kmem_cache_alloc(kmem_cache, GFP_KERNEL);
>>>> +       }
>>>> +}
>>>
>>> I think we should use kmem_cache_alloc_node().
>>
>> "kmem_cache_alloc_node - Allocate an object on the specified node"
>>
>> The reserve_lbr_buffers() is called in __x86_pmu_event_init().
>> When the LBR perf_event is scheduled to another node, it seems
>> that we will not call init() and allocate again.
>>
>> Do you mean use kmem_cache_alloc_node() for each numa_nodes_parsed ?
> 
> I assume cpuc->lbr_xsave will be accessed for that cpu only.
> Then it needs to allocate it in the node that cpu belongs to.
> Something like below..
> 
>      cpuc->lbr_xsave = kmem_cache_alloc_node(kmem_cache, GFP_KERNEL,
>                                                 cpu_to_node(cpu));

Thanks, it helps and I will apply it in the next version.

> 
> Thanks,
> Namhyung
> 

