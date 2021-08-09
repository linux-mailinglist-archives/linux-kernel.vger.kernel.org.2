Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32CA33E4F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhHIWOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:14:22 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:28240 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233408AbhHIWOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628547241; x=1660083241;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=0Px6fPAVDm9J+urpxo+V3asbxCE08s9BbxQbkr8IiGE=;
  b=Y3ZxTEUzbQf1alILOOjSIYmhCZ7HwA8uBFmWrCtH43Q+EJSi2l1mE5Gp
   thvWQESTr3lNjRl8VNOpEuXZDAfrzD/3yFYEJznDyaiFrxg7V2cqDcIxO
   0Kgvh85tg18Harp9ARHzLfU2RjLFuWE08txjlFgZmNbyKlGm0I1kHRICD
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Aug 2021 15:14:01 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Aug 2021 15:14:00 -0700
Received: from [10.111.162.189] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 9 Aug
 2021 15:13:58 -0700
Subject: Re: [PATCH v4 29/35] mm: slub: Move flush_cpu_slab() invocations
 __free_slab() invocations out of IRQ context
To:     Vlastimil Babka <vbabka@suse.cz>, Mike Galbraith <efault@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-30-vbabka@suse.cz>
 <0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com>
 <6e3bb54fdf7208f3f86a5d31e1ef2a576d8e7e37.camel@gmx.de>
 <7d9ac614-f18e-de5d-2d47-f92e618d76fc@suse.cz>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <eca69b61-13cd-474d-f02c-05131494ce3a@quicinc.com>
Date:   Mon, 9 Aug 2021 18:13:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <7d9ac614-f18e-de5d-2d47-f92e618d76fc@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03d.na.qualcomm.com (10.85.0.91) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2021 4:08 PM, Vlastimil Babka wrote:
> On 8/9/2021 8:44 PM, Mike Galbraith wrote:
>> On Mon, 2021-08-09 at 09:41 -0400, Qian Cai wrote:
>>>
>>>
>>> On 8/5/2021 11:19 AM, Vlastimil Babka wrote:
>>>>
>>>>  
>>>> +static DEFINE_MUTEX(flush_lock);
>>>> +static DEFINE_PER_CPU(struct slub_flush_work, slub_flush);
>>>> +
>>>>  static void flush_all(struct kmem_cache *s)
>>>>  {
>>>> -       on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
>>>> +       struct slub_flush_work *sfw;
>>>> +       unsigned int cpu;
>>>> +
>>>> +       mutex_lock(&flush_lock);
>>>
>>> Vlastimil, taking the lock here could trigger a warning during memory
>>> offline/online due to the locking order:
>>>
>>> slab_mutex -> flush_lock
>>
>> Bugger.  That chain ending with cpu_hotplug_lock makes slub_cpu_dead()
>> taking slab_mutex a non-starter for cpu hotplug as well.  It's
>> established early by kernel_init_freeable()..kmem_cache_destroy() as
>> well as by slab_mem_going_offline_callback().
> 
> I suck at reading the lockdep splats, so I don't see yet how the "existing
> reverse order" occurs - I do understand the order in the "lsbug".
> What I also wonder is why didn't this occur also in the older RT trees with this
> patch. I did change the order of locks in flush_all() to take flush_lock first
> and cpus_read_lock() second, as Cyrill Gorcunov suggested. Would the original
> order prevent this? Or we would fail anyway because we already took
> cpus_read_lock() in offline_pages() and now are taking it again - do these nest
> or not?

"lsbug" is just an user-space tool running workloads like memory offline/online
via sysfs. The splat indicated that the existing locking orders on the running
system saw so far are:

flush_lock -> cpu_hotplug_lock (in #1)
  cpu_hotplug_lock -> pck_batch_high_lock (in #2)
    pcp_batch_high_lock -> (memory_chain).rwsem (in #3)
      (memory_chain).rwsem -> slab_mutex (in #4)

Thus, lockdep inferences that taking flush_lock first could later reaching
slab_mutex. Then, in the commit, memory offline (in #0) started to take the locking
order slab_mutex -> flush_lock. Thus, the potential deadlock warning.
