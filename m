Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3501B3E87BA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 03:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhHKBnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 21:43:23 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:59376 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230190AbhHKBnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 21:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1628646179; x=1660182179;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=8sYmq5fBAgsNnOGPza/iYi6HIXCeHTxXeW7dDs6f1zc=;
  b=lZKnrnN6MNd6YSyv08ePoI2huzxsGa3Zs33Dc1PLwfqfG3W9oxWQnCKc
   C48v945x49h8dHB1fI9w/wGBYRF2AdwyiqjkaNHr/9Cs4AKGk7H/r5ycS
   QxuardrGrHY2Mk+nysiAZeipA1rRkMG0oXBSbq4z4YzG8FmTTbDe1izFO
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Aug 2021 18:42:59 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 10 Aug 2021 18:42:58 -0700
Received: from [10.111.168.10] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Tue, 10 Aug
 2021 18:42:57 -0700
Subject: Re: [PATCH v4 29/35] mm: slub: Move flush_cpu_slab() invocations
 __free_slab() invocations out of IRQ context
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
References: <20210805152000.12817-1-vbabka@suse.cz>
 <20210805152000.12817-30-vbabka@suse.cz>
 <0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com>
 <50fe26ba-450b-af57-506d-438f67cfbce3@suse.cz>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <13a3f616-19b5-ce25-87ad-bb241d0b0c18@quicinc.com>
Date:   Tue, 10 Aug 2021 21:42:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <50fe26ba-450b-af57-506d-438f67cfbce3@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03f.na.qualcomm.com (10.85.0.47) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2021 10:33 AM, Vlastimil Babka wrote:
> On 8/9/21 3:41 PM, Qian Cai wrote:
> 
>>>  static void flush_all(struct kmem_cache *s)
>>>  {
>>> -	on_each_cpu_cond(has_cpu_slab, flush_cpu_slab, s, 1);
>>> +	struct slub_flush_work *sfw;
>>> +	unsigned int cpu;
>>> +
>>> +	mutex_lock(&flush_lock);
>>
>> Vlastimil, taking the lock here could trigger a warning during memory offline/online due to the locking order:
>>
>> slab_mutex -> flush_lock
> 
> Here's the full fixup, also incorporating Mike's fix. Thanks.
> 
> ----8<----
> From c2df67d5116d4615c322e262556e34117e268104 Mon Sep 17 00:00:00 2001
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Tue, 10 Aug 2021 10:58:07 +0200
> Subject: [PATCH] mm, slub: fix memory and cpu hotplug related lock ordering
>  issues
> 
> Qian Cai reported [1] a lockdep splat on memory offline.
> 
> [   91.374541] WARNING: possible circular locking dependency detected
> [   91.381411] 5.14.0-rc5-next-20210809+ #84 Not tainted
> [   91.387149] ------------------------------------------------------
> [   91.394016] lsbug/1523 is trying to acquire lock:
> [   91.399406] ffff800018e76530 (flush_lock){+.+.}-{3:3}, at: flush_all+0x50/0x1c8
> [   91.407425] but task is already holding lock:
> [   91.414638] ffff800018e48468 (slab_mutex){+.+.}-{3:3}, at: slab_memory_callback+0x44/0x280
> [   91.423603] which lock already depends on the new lock.
> 
> To fix it, we need to change the order in flush_all() so that cpus_read_lock()
> is first and mutex_lock(&flush_lock) second.
> 
> Also when called from slab_mem_going_offline_callback() we are already under
> cpus_read_lock() and cannot take it again, so create a flush_all_cpus_locked()
> variant and decouple flushing from actual shrinking for this call path.
> 
> Additionally, Mike Galbraith reported [2] wrong order of cpus_read_lock() and
> slab_mutex in kmem_cache_destroy() path and proposed a fix to reverse it.
> 
> This patch is a fixup for the mmotm patch
> mm-slub-move-flush_cpu_slab-invocations-__free_slab-invocations-out-of-irq-context.patch
> 
> [1] https://lore.kernel.org/lkml/0b36128c-3e12-77df-85fe-a153a714569b@quicinc.com/
> [2] https://lore.kernel.org/lkml/2eb3cf340716c40f03a0a342ab40219b3d1de195.camel@gmx.de/
> 
> Reported-by: Qian Cai <quic_qiancai@quicinc.com>
> Reported-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

This is running fine for me. There is a separate hugetlb crash while fuzzing and will
report to where it belongs.
