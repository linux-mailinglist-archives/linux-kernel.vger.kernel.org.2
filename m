Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C19542663F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbhJHIyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:54:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229673AbhJHIyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:54:51 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1988giNu009289;
        Fri, 8 Oct 2021 04:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=Fq/gj8352g72/PDTPzFxiswoYtN8nxxAPS+Bkz2Gt40=;
 b=RMpGPyBe8xnCTqxSEyXfv1CDOeerkWNe88cJGGcyvjljfHz3noAYX1gLcXsvmGCSRQJY
 Sx66Pa24jJno6OnkH3GQXtUOBpxAZNoiHDdNrHgppGCx/UDOCUYsYe/kNUNvyDChvOVX
 xus/Of/L8qVBHHt4A9hxTlE/zFwMYX3fxBKitHD3kGzeWGVeKUuUq74L9O8MXamt9je/
 Pwg5JN279U3DV6F9P/OYcTy5rh2aK3+14PsCoDHtKspcQ5V/b3T1iSbNfMMn9Czx+Vmq
 P9XUiy4JkW3HwWMtA0c+UrjCRMOUh5aHcGXGUU/fsZIyNzFzYVGzJxpG74L+Wrr2nU6J 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bjg2nku56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 04:52:18 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1988kO5r019211;
        Fri, 8 Oct 2021 04:52:17 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bjg2nku46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 04:52:17 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1988i8sh028518;
        Fri, 8 Oct 2021 08:52:15 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 3bef2amh5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 08:52:14 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1988qAtf3670744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 8 Oct 2021 08:52:10 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB9D711C04A;
        Fri,  8 Oct 2021 08:52:09 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34B6911C075;
        Fri,  8 Oct 2021 08:52:09 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.5.116])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  8 Oct 2021 08:52:09 +0000 (GMT)
Date:   Fri, 8 Oct 2021 10:52:05 +0200
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     ultrachin@163.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, brookxu.cn@gmail.com,
        chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>
Subject: Re: [PATCH] mm: Free per cpu pages async to shorten program exit
 time
Message-ID: <20211008105205.07d2f205@p-imbrenda>
In-Reply-To: <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
References: <20211008063933.331989-1-ultrachin@163.com>
        <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
Organization: IBM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zrEqWOEjg4p3EyP54B30Sn751r50ZyGH
X-Proofpoint-GUID: B81By5jLMB_41d_zkIdfvRaawgPREw_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-08_02,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 mlxlogscore=999 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110080051
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Oct 2021 10:17:50 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 08.10.21 08:39, ultrachin@163.com wrote:
> > From: chen xiaoguang <xiaoggchen@tencent.com>
> > 
> > The exit time is long when program allocated big memory and
> > the most time consuming part is free memory which takes 99.9%
> > of the total exit time. By using async free we can save 25% of
> > exit time.
> > 
> > Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
> > Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
> > Signed-off-by: lu yihui <yihuilu@tencent.com>  
> 
> I recently discussed with Claudio if it would be possible to tear down 
> the process MM deferred, because for some use cases (secure/encrypted 
> virtualization, very large mmaps) tearing down the page tables is 
> already the much more expensive operation.
> 
> There is mmdrop_async(), and I wondered if one could reuse that concept 
> when tearing down a process -- I didn't look into feasibility, however, 
> so it's just some very rough idea.

I have done some experiments by unconditionally replacing mmdrop with
mmdrop_async in exit.c and nothing broke, and exit time of large
processes was almost instant (with the actual cleanup being performed in
background)

my approach is probably simpler/cleaner:

diff --git a/include/asm-generic/mmu_context.h b/include/asm-generic/mmu_context.h
index 91727065bacb..900931a6a105 100644
--- a/include/asm-generic/mmu_context.h
+++ b/include/asm-generic/mmu_context.h
@@ -73,4 +73,8 @@ static inline void deactivate_mm(struct task_struct *tsk,
 }
 #endif
 
+#ifndef arch_exit_mm_mmput
+#define arch_exit_mm_mmput mmput
+#endif
+
 #endif /* __ASM_GENERIC_MMU_CONTEXT_H */
diff --git a/kernel/exit.c b/kernel/exit.c
index 9a89e7f36acb..604cb9c740fa 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -498,7 +498,7 @@ static void exit_mm(void)
        task_unlock(current);
        mmap_read_unlock(mm);
        mm_update_next_owner(mm);
-       mmput(mm);
+       arch_exit_mm_mmput(mm);
        if (test_thread_flag(TIF_MEMDIE))
                exit_oom_victim();
 }

these are the minimal changes to common code, then each architecture can
define their own arch_exit_mm_mmput as they see fit (for example, to free
asynchronously only for certain classes of mm, like big ones, VMs, or so).

Another option is to simply always replace mmput with mmput_async, which I
expect will raise more eyebrows.

> > ---
> >   include/linux/mm.h |  1 +
> >   kernel/exit.c      |  2 ++
> >   mm/page_alloc.c    | 89 +++++++++++++++++++++++++++++++++++++++++++---
> >   3 files changed, 87 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 73a52aba448f..2add3b635eee 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -908,6 +908,7 @@ void put_pages_list(struct list_head *pages);
> >   
> >   void split_page(struct page *page, unsigned int order);
> >   void copy_huge_page(struct page *dst, struct page *src);
> > +void kfreepcp_set_run(unsigned int cpu);
> >   
> >   /*
> >    * Compound pages have a destructor function.  Provide a
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index 91a43e57a32e..269eb81acbe9 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -167,10 +167,12 @@ static void __exit_signal(struct task_struct *tsk)
> >   static void delayed_put_task_struct(struct rcu_head *rhp)
> >   {
> >   	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
> > +	unsigned int cpu = tsk->cpu;
> >   
> >   	perf_event_delayed_put(tsk);
> >   	trace_sched_process_free(tsk);
> >   	put_task_struct(tsk);
> > +	kfreepcp_set_run(cpu);
> >   }
> >   
> >   void put_task_struct_rcu_user(struct task_struct *task)
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index b37435c274cf..8a748ea9156b 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -72,6 +72,7 @@
> >   #include <linux/padata.h>
> >   #include <linux/khugepaged.h>
> >   #include <linux/buffer_head.h>
> > +#include <linux/smpboot.h>
> >   #include <asm/sections.h>
> >   #include <asm/tlbflush.h>
> >   #include <asm/div64.h>
> > @@ -147,6 +148,12 @@ DEFINE_PER_CPU(int, _numa_mem_);		/* Kernel "local memory" node */
> >   EXPORT_PER_CPU_SYMBOL(_numa_mem_);
> >   #endif
> >   
> > +struct freepcp_stat {
> > +	struct task_struct *thread;
> > +	bool should_run;
> > +};
> > +DEFINE_PER_CPU(struct freepcp_stat, kfreepcp);
> > +
> >   /* work_structs for global per-cpu drains */
> >   struct pcpu_drain {
> >   	struct zone *zone;
> > @@ -3361,6 +3368,81 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone)
> >   	return min(READ_ONCE(pcp->batch) << 2, high);
> >   }
> >   
> > +void kfreepcp_set_run(unsigned int cpu)
> > +{
> > +	struct task_struct *tsk;
> > +	struct freepcp_stat *stat = this_cpu_ptr(&kfreepcp);
> > +
> > +	tsk = stat->thread;
> > +	per_cpu(kfreepcp.should_run, cpu) = true;
> > +
> > +	if (tsk && !task_is_running(tsk))
> > +		wake_up_process(tsk);
> > +}
> > +EXPORT_SYMBOL_GPL(kfreepcp_set_run);
> > +
> > +static int kfreepcp_should_run(unsigned int cpu)
> > +{
> > +	struct freepcp_stat *stat = this_cpu_ptr(&kfreepcp);
> > +
> > +	return stat->should_run;
> > +}
> > +
> > +static void run_kfreepcp(unsigned int cpu)
> > +{
> > +	struct zone *zone;
> > +	struct per_cpu_pages *pcp;
> > +	unsigned long flags;
> > +	struct freepcp_stat *stat = this_cpu_ptr(&kfreepcp);
> > +	bool need_free_more = false;
> > +
> > +
> > +
> > +again:
> > +	need_free_more = false;
> > +	for_each_populated_zone(zone) {
> > +		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
> > +		if (pcp->count && pcp->high && pcp->count > pcp->high) {
> > +			unsigned long batch = READ_ONCE(pcp->batch);
> > +			int high;
> > +
> > +			high = nr_pcp_high(pcp, zone);
> > +			local_irq_save(flags);
> > +			free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch),
> > +					pcp);
> > +			local_irq_restore(flags);
> > +			if (pcp->count > pcp->high)
> > +				need_free_more = true;
> > +		}
> > +
> > +		cond_resched();
> > +	}
> > +	if (need_free_more)
> > +		goto again;
> > +
> > +	stat->should_run = false;
> > +}
> > +
> > +static struct smp_hotplug_thread freepcp_threads = {
> > +	.store                  = &kfreepcp.thread,
> > +	.thread_should_run      = kfreepcp_should_run,
> > +	.thread_fn              = run_kfreepcp,
> > +	.thread_comm            = "kfreepcp/%u",
> > +};
> > +
> > +static int __init freepcp_init(void)
> > +{
> > +	int cpu;
> > +
> > +	for_each_possible_cpu(cpu)
> > +		per_cpu(kfreepcp.should_run, cpu) = false;
> > +
> > +	BUG_ON(smpboot_register_percpu_thread(&freepcp_threads));
> > +
> > +	return 0;
> > +}
> > +late_initcall(freepcp_init);
> > +
> >   static void free_unref_page_commit(struct page *page, unsigned long pfn,
> >   				   int migratetype, unsigned int order)
> >   {
> > @@ -3375,11 +3457,8 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
> >   	list_add(&page->lru, &pcp->lists[pindex]);
> >   	pcp->count += 1 << order;
> >   	high = nr_pcp_high(pcp, zone);
> > -	if (pcp->count >= high) {
> > -		int batch = READ_ONCE(pcp->batch);
> > -
> > -		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), pcp);
> > -	}
> > +	if (pcp->count >= high)
> > +		this_cpu_ptr(&kfreepcp)->should_run = false;
> >   }
> >   
> >   /*
> >   
> 
> 

