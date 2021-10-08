Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBFB4265CB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 10:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhJHIUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 04:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234072AbhJHITv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 04:19:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633681076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vRz40kngEAVjYMcYUsBVqp93s8UhDzgh0ZljeOK4r74=;
        b=P/f2eFOeJRC0wT872D0SwOIYVuvvqEidUPwGjzh1OuPOgl1WpViVnsUO9lpsmL92fmLI+4
        QFSa/IP20AOmbaWACQcv4Z/oO0E/QVsTL/TKy0Nik/ly07N27b6YUQzpyU0KPwIzwa10qR
        86t/Yvd7VEyVQzIciXvDWaqw+QAR9Bw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-0spBZwD1ObyY05Nrh0KqQw-1; Fri, 08 Oct 2021 04:17:53 -0400
X-MC-Unique: 0spBZwD1ObyY05Nrh0KqQw-1
Received: by mail-wr1-f70.google.com with SMTP id k16-20020a5d6290000000b00160753b430fso6714983wru.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 01:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vRz40kngEAVjYMcYUsBVqp93s8UhDzgh0ZljeOK4r74=;
        b=UTlUc8N3OhCAVf/MKtGiwUTeM6hRCHz/ZLGUjQkqH/bJf/LOD2g8EV+kY6EcqunvyH
         bwSnBzUZNPFRyhc9qXh3t0ae37HLToMCwfRWSP8ggu7ccRV93W9Le/X5jEBKcWeOh1Fv
         oMP2E0RbyUfItcux5pVfjzGHHk+7Lxic6RrzSqVTTJTvo3957RUanvOo6qA8sRQ5iYC+
         lhnNuSUJrcH5F8JerVLPQnsc5zkxwcW6xwNktXMevXigYviwJ7eZfRFVFF5gO2fNlRfi
         TKnf3qkYYmfD6U/7poKbdiSe9+Lv5KD+0wJ3+TDL/jDg+TmH+M+3pZRZYN4EhNl/KKlG
         QgTQ==
X-Gm-Message-State: AOAM532LfYHHVrWSSrscHfL8U0dHivN/PhkXXk5QdbgYdBLg/xWcucgc
        wi/Biv20UodIWXGaT6LEpur2U1mp4zkO2hybXPoBltl/8RZa6ezgmMO2pO6ArpGeyKPoC31F8L2
        uWFUMFRN5o7ntAWsinoQ3ZOtL
X-Received: by 2002:adf:8bcf:: with SMTP id w15mr2380848wra.144.1633681071959;
        Fri, 08 Oct 2021 01:17:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9MdZr9LqHNovhsqxJBS8yRIvgSvT8XHy8B+piaiM+ES79g2c6kQaBcllV+UrEazfC/dvYfQ==
X-Received: by 2002:adf:8bcf:: with SMTP id w15mr2380823wra.144.1633681071754;
        Fri, 08 Oct 2021 01:17:51 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c676e.dip0.t-ipconnect.de. [91.12.103.110])
        by smtp.gmail.com with ESMTPSA id c5sm11224404wml.9.2021.10.08.01.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 01:17:51 -0700 (PDT)
Subject: Re: [PATCH] mm: Free per cpu pages async to shorten program exit time
To:     ultrachin@163.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     brookxu.cn@gmail.com, chen xiaoguang <xiaoggchen@tencent.com>,
        zeng jingxiang <linuszeng@tencent.com>,
        lu yihui <yihuilu@tencent.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20211008063933.331989-1-ultrachin@163.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <d71e6021-777b-3ca9-b08f-64fe7ff51e08@redhat.com>
Date:   Fri, 8 Oct 2021 10:17:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20211008063933.331989-1-ultrachin@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.21 08:39, ultrachin@163.com wrote:
> From: chen xiaoguang <xiaoggchen@tencent.com>
> 
> The exit time is long when program allocated big memory and
> the most time consuming part is free memory which takes 99.9%
> of the total exit time. By using async free we can save 25% of
> exit time.
> 
> Signed-off-by: chen xiaoguang <xiaoggchen@tencent.com>
> Signed-off-by: zeng jingxiang <linuszeng@tencent.com>
> Signed-off-by: lu yihui <yihuilu@tencent.com>

I recently discussed with Claudio if it would be possible to tear down 
the process MM deferred, because for some use cases (secure/encrypted 
virtualization, very large mmaps) tearing down the page tables is 
already the much more expensive operation.

There is mmdrop_async(), and I wondered if one could reuse that concept 
when tearing down a process -- I didn't look into feasibility, however, 
so it's just some very rough idea.

> ---
>   include/linux/mm.h |  1 +
>   kernel/exit.c      |  2 ++
>   mm/page_alloc.c    | 89 +++++++++++++++++++++++++++++++++++++++++++---
>   3 files changed, 87 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 73a52aba448f..2add3b635eee 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -908,6 +908,7 @@ void put_pages_list(struct list_head *pages);
>   
>   void split_page(struct page *page, unsigned int order);
>   void copy_huge_page(struct page *dst, struct page *src);
> +void kfreepcp_set_run(unsigned int cpu);
>   
>   /*
>    * Compound pages have a destructor function.  Provide a
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 91a43e57a32e..269eb81acbe9 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -167,10 +167,12 @@ static void __exit_signal(struct task_struct *tsk)
>   static void delayed_put_task_struct(struct rcu_head *rhp)
>   {
>   	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
> +	unsigned int cpu = tsk->cpu;
>   
>   	perf_event_delayed_put(tsk);
>   	trace_sched_process_free(tsk);
>   	put_task_struct(tsk);
> +	kfreepcp_set_run(cpu);
>   }
>   
>   void put_task_struct_rcu_user(struct task_struct *task)
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index b37435c274cf..8a748ea9156b 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -72,6 +72,7 @@
>   #include <linux/padata.h>
>   #include <linux/khugepaged.h>
>   #include <linux/buffer_head.h>
> +#include <linux/smpboot.h>
>   #include <asm/sections.h>
>   #include <asm/tlbflush.h>
>   #include <asm/div64.h>
> @@ -147,6 +148,12 @@ DEFINE_PER_CPU(int, _numa_mem_);		/* Kernel "local memory" node */
>   EXPORT_PER_CPU_SYMBOL(_numa_mem_);
>   #endif
>   
> +struct freepcp_stat {
> +	struct task_struct *thread;
> +	bool should_run;
> +};
> +DEFINE_PER_CPU(struct freepcp_stat, kfreepcp);
> +
>   /* work_structs for global per-cpu drains */
>   struct pcpu_drain {
>   	struct zone *zone;
> @@ -3361,6 +3368,81 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone)
>   	return min(READ_ONCE(pcp->batch) << 2, high);
>   }
>   
> +void kfreepcp_set_run(unsigned int cpu)
> +{
> +	struct task_struct *tsk;
> +	struct freepcp_stat *stat = this_cpu_ptr(&kfreepcp);
> +
> +	tsk = stat->thread;
> +	per_cpu(kfreepcp.should_run, cpu) = true;
> +
> +	if (tsk && !task_is_running(tsk))
> +		wake_up_process(tsk);
> +}
> +EXPORT_SYMBOL_GPL(kfreepcp_set_run);
> +
> +static int kfreepcp_should_run(unsigned int cpu)
> +{
> +	struct freepcp_stat *stat = this_cpu_ptr(&kfreepcp);
> +
> +	return stat->should_run;
> +}
> +
> +static void run_kfreepcp(unsigned int cpu)
> +{
> +	struct zone *zone;
> +	struct per_cpu_pages *pcp;
> +	unsigned long flags;
> +	struct freepcp_stat *stat = this_cpu_ptr(&kfreepcp);
> +	bool need_free_more = false;
> +
> +
> +
> +again:
> +	need_free_more = false;
> +	for_each_populated_zone(zone) {
> +		pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
> +		if (pcp->count && pcp->high && pcp->count > pcp->high) {
> +			unsigned long batch = READ_ONCE(pcp->batch);
> +			int high;
> +
> +			high = nr_pcp_high(pcp, zone);
> +			local_irq_save(flags);
> +			free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch),
> +					pcp);
> +			local_irq_restore(flags);
> +			if (pcp->count > pcp->high)
> +				need_free_more = true;
> +		}
> +
> +		cond_resched();
> +	}
> +	if (need_free_more)
> +		goto again;
> +
> +	stat->should_run = false;
> +}
> +
> +static struct smp_hotplug_thread freepcp_threads = {
> +	.store                  = &kfreepcp.thread,
> +	.thread_should_run      = kfreepcp_should_run,
> +	.thread_fn              = run_kfreepcp,
> +	.thread_comm            = "kfreepcp/%u",
> +};
> +
> +static int __init freepcp_init(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		per_cpu(kfreepcp.should_run, cpu) = false;
> +
> +	BUG_ON(smpboot_register_percpu_thread(&freepcp_threads));
> +
> +	return 0;
> +}
> +late_initcall(freepcp_init);
> +
>   static void free_unref_page_commit(struct page *page, unsigned long pfn,
>   				   int migratetype, unsigned int order)
>   {
> @@ -3375,11 +3457,8 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
>   	list_add(&page->lru, &pcp->lists[pindex]);
>   	pcp->count += 1 << order;
>   	high = nr_pcp_high(pcp, zone);
> -	if (pcp->count >= high) {
> -		int batch = READ_ONCE(pcp->batch);
> -
> -		free_pcppages_bulk(zone, nr_pcp_free(pcp, high, batch), pcp);
> -	}
> +	if (pcp->count >= high)
> +		this_cpu_ptr(&kfreepcp)->should_run = false;
>   }
>   
>   /*
> 


-- 
Thanks,

David / dhildenb

