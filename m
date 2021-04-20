Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4781365DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 18:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhDTQ7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 12:59:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:47326 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232473AbhDTQ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 12:58:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 315D7AE5C;
        Tue, 20 Apr 2021 16:58:24 +0000 (UTC)
Subject: Re: [PATCH] mm/slub: use stackdepot to save stack trace in objects
To:     glittao@gmail.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20210414163434.4376-1-glittao@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <5eb31e87-f928-9a5a-c937-be748ac3bafa@suse.cz>
Date:   Tue, 20 Apr 2021 18:58:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210414163434.4376-1-glittao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/21 6:34 PM, glittao@gmail.com wrote:
> From: Oliver Glitta <glittao@gmail.com>
> 
> Many stack traces are similar so there are many similar arrays.
> Stackdepot saves each unique stack only once.
> 
> Replace field addrs in struct track with depot_stack_handle_t handle.
> Use stackdepot to save stack trace.
> 
> The benefits are smaller memory overhead and possibility to aggregate
> per-cache statistics in the future using the stackdepot handle
> instead of matching stacks manually.
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

(again with a disclaimer that I'm the advisor of Oliver's student project)

> ---
>  init/Kconfig |  1 +
>  mm/slub.c    | 79 ++++++++++++++++++++++++++++++++--------------------
>  2 files changed, 50 insertions(+), 30 deletions(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 37a17853433a..a4ed2daa6c41 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1891,6 +1891,7 @@ config SLUB_DEBUG
>  	default y
>  	bool "Enable SLUB debugging support" if EXPERT
>  	depends on SLUB && SYSFS
> +	select STACKDEPOT if STACKTRACE_SUPPORT
>  	help
>  	  SLUB has extensive debug support features. Disabling these can
>  	  result in significant savings in code size. This also disables
> diff --git a/mm/slub.c b/mm/slub.c
> index 9c0e26ddf300..4b18499726eb 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -35,6 +35,7 @@
>  #include <linux/prefetch.h>
>  #include <linux/memcontrol.h>
>  #include <linux/random.h>
> +#include <linux/stackdepot.h>
>  
>  #include <trace/events/kmem.h>
>  
> @@ -203,8 +204,8 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
>  #define TRACK_ADDRS_COUNT 16
>  struct track {
>  	unsigned long addr;	/* Called from address */
> -#ifdef CONFIG_STACKTRACE
> -	unsigned long addrs[TRACK_ADDRS_COUNT];	/* Called from address */
> +#ifdef CONFIG_STACKDEPOT
> +	depot_stack_handle_t handle;
>  #endif
>  	int cpu;		/* Was running on cpu */
>  	int pid;		/* Pid context */
> @@ -581,22 +582,27 @@ static struct track *get_track(struct kmem_cache *s, void *object,
>  	return kasan_reset_tag(p + alloc);
>  }
>  
> +#ifdef CONFIG_STACKDEPOT
> +static depot_stack_handle_t save_stack_trace(gfp_t flags)
> +{
> +	unsigned long entries[TRACK_ADDRS_COUNT];
> +	depot_stack_handle_t handle;
> +	unsigned int nr_entries;
> +
> +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 4);
> +	handle = stack_depot_save(entries, nr_entries, flags);
> +	return handle;
> +}
> +#endif
> +
>  static void set_track(struct kmem_cache *s, void *object,
>  			enum track_item alloc, unsigned long addr)
>  {
>  	struct track *p = get_track(s, object, alloc);
>  
>  	if (addr) {
> -#ifdef CONFIG_STACKTRACE
> -		unsigned int nr_entries;
> -
> -		metadata_access_enable();
> -		nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
> -					      TRACK_ADDRS_COUNT, 3);
> -		metadata_access_disable();
> -
> -		if (nr_entries < TRACK_ADDRS_COUNT)
> -			p->addrs[nr_entries] = 0;
> +#ifdef CONFIG_STACKDEPOT
> +		p->handle = save_stack_trace(GFP_KERNEL);
>  #endif
>  		p->addr = addr;
>  		p->cpu = smp_processor_id();
> @@ -623,14 +629,19 @@ static void print_track(const char *s, struct track *t, unsigned long pr_time)
>  
>  	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
>  	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
> -#ifdef CONFIG_STACKTRACE
> +#ifdef CONFIG_STACKDEPOT
>  	{
> -		int i;
> -		for (i = 0; i < TRACK_ADDRS_COUNT; i++)
> -			if (t->addrs[i])
> -				pr_err("\t%pS\n", (void *)t->addrs[i]);
> -			else
> -				break;
> +		depot_stack_handle_t handle;
> +		unsigned long *entries;
> +		unsigned int nr_entries;
> +
> +		handle = READ_ONCE(t->handle);
> +		if (!handle) {
> +			pr_err("object allocation/free stack trace missing\n");
> +		} else {
> +			nr_entries = stack_depot_fetch(handle, &entries);
> +			stack_trace_print(entries, nr_entries, 0);
> +		}
>  	}
>  #endif
>  }
> @@ -4017,18 +4028,26 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct page *page)
>  	objp = fixup_red_left(s, objp);
>  	trackp = get_track(s, objp, TRACK_ALLOC);
>  	kpp->kp_ret = (void *)trackp->addr;
> -#ifdef CONFIG_STACKTRACE
> -	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
> -		kpp->kp_stack[i] = (void *)trackp->addrs[i];
> -		if (!kpp->kp_stack[i])
> -			break;
> -	}
> +#ifdef CONFIG_STACKDEPOT
> +	{
> +		depot_stack_handle_t handle;
> +		unsigned long *entries;
> +		unsigned int nr_entries;
>  
> -	trackp = get_track(s, objp, TRACK_FREE);
> -	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
> -		kpp->kp_free_stack[i] = (void *)trackp->addrs[i];
> -		if (!kpp->kp_free_stack[i])
> -			break;
> +		handle = READ_ONCE(trackp->handle);
> +		if (handle) {
> +			nr_entries = stack_depot_fetch(handle, &entries);
> +			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
> +				kpp->kp_stack[i] = (void *)entries[i];
> +		}
> +
> +		trackp = get_track(s, objp, TRACK_FREE);
> +		handle = READ_ONCE(trackp->handle);
> +		if (handle) {
> +			nr_entries = stack_depot_fetch(handle, &entries);
> +			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
> +				kpp->kp_free_stack[i] = (void *)entries[i];
> +		}
>  	}
>  #endif
>  #endif
> 

