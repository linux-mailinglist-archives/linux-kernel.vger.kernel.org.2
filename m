Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FAD3A85D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 17:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbhFOQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:01:00 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:13713 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231815AbhFOQAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1623772697; x=1655308697;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Y7I038CP0sLHvN3RpdyLi0/1jsHbGhNJt3x/QcSXiN8=;
  b=SZS5R0PRGeu80OGtTdpbxxCefirQPYYmitg7ptSJT3wxo2mAxSMYBpjc
   yIFu76ZuvO7BVnEkYXl4miu1ZVwEkw4j3jj4Gf/ReAreRAvHHrw8lg5B6
   lesUlSnnLzHX6LAtHikn0+56v8C9B/L9wHNxrfcisOqLIr6CwXIivKqM6
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jun 2021 08:58:15 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Jun 2021 08:58:15 -0700
Received: from [10.111.175.185] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Jun
 2021 08:58:13 -0700
Subject: Re: [PATCH v12] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>, <cl@linux.com>,
        <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <greg@kroah.com>,
        <glittao@gmail.com>, <andy.shevchenko@gmail.com>
CC:     <vinmenon@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <1623438200-19361-1-git-send-email-faiyazm@codeaurora.org>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <8c821abf-8fa6-b78b-cea4-b7d3b3b74a69@quicinc.com>
Date:   Tue, 15 Jun 2021 11:58:12 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1623438200-19361-1-git-send-email-faiyazm@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03a.na.qualcomm.com (10.85.0.103) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/2021 3:03 PM, Faiyaz Mohammed wrote:
> alloc_calls and free_calls implementation in sysfs have two issues,
> one is PAGE_SIZE limitation of sysfs and other is it does not adhere
> to "one value per file" rule.
> 
> To overcome this issues, move the alloc_calls and free_calls
> implementation to debugfs.
> 
> Debugfs cache will be created if SLAB_STORE_USER flag is set.
> 
> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> to be inline with what it does.
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>

Reverting this commit on today's linux-next fixed all leaks (hundreds) reported by kmemleak like below,

unreferenced object 0xffff00091ae1b540 (size 64):
  comm "lsbug", pid 1607, jiffies 4294958291 (age 1476.340s)
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 6b 6b 6b 6b 6b 6b 6b 6b  ........kkkkkkkk
    6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b  kkkkkkkkkkkkkkkk
  backtrace:
    [<ffff8000106b06b8>] slab_post_alloc_hook+0xa0/0x418
    [<ffff8000106b5c7c>] kmem_cache_alloc_trace+0x1e4/0x378
    [<ffff8000106b5e40>] slab_debugfs_start+0x30/0x50
    slab_debugfs_start at /usr/src/linux-next/mm/slub.c:5831
    [<ffff8000107b3dbc>] seq_read_iter+0x214/0xd50
    [<ffff8000107b4b84>] seq_read+0x28c/0x418
    [<ffff8000109560b4>] full_proxy_read+0xdc/0x148
    [<ffff800010738f24>] vfs_read+0x104/0x340
    [<ffff800010739ee0>] ksys_read+0xf8/0x1e0
    [<ffff80001073a03c>] __arm64_sys_read+0x74/0xa8
    [<ffff8000100358d4>] invoke_syscall.constprop.0+0xdc/0x1d8
    [<ffff800010035ab4>] do_el0_svc+0xe4/0x298
    [<ffff800011138528>] el0_svc+0x20/0x30
    [<ffff800011138b08>] el0t_64_sync_handler+0xb0/0xb8
    [<ffff80001001259c>] el0t_64_sync+0x178/0x17c

> ---
> changes in v12:
> 	- To avoid confusion updated the patch version.
> 
> changes in v11:
> 	- https://lore.kernel.org/linux-mm/1623141934-7699-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v10:
> 	- https://lore.kernel.org/linux-mm/1622996045-25826-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v9:
> 	- https://lore.kernel.org/linux-mm/1622556633-29785-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v8:
> 	- https://lore.kernel.org/linux-mm/1622542057-14632-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in V7:
> 	- https://lore.kernel.org/linux-mm/1621928285-751-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v6:
> 	- https://lore.kernel.org/linux-mm/1621341949-26762-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v5:
> 	- https://lore.kernel.org/linux-mm/1620296523-21922-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v4:
> 	- https://lore.kernel.org/linux-mm/1618583239-18124-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v3:
> 	- https://lore.kernel.org/linux-mm/1617712064-12264-1-git-send-email-faiyazm@codeaurora.org/
> 
> changes in v2:
> 	- https://lore.kernel.org/linux-mm/3ac1d3e6-6207-96ad-16a1-0f5139d8b2b5@codeaurora.org/
> 
> changes in v1
> 	- https://lore.kernel.org/linux-mm/1610443287-23933-1-git-send-email-faiyazm@codeaurora.org/
> 
>  mm/slab.h        |   6 ++
>  mm/slab_common.c |   2 +
>  mm/slub.c        | 283 +++++++++++++++++++++++++++++++++++++------------------
>  3 files changed, 198 insertions(+), 93 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 18c1927..60d4f4b 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -630,6 +630,12 @@ static inline bool slab_want_init_on_free(struct kmem_cache *c)
>  	return false;
>  }
>  
> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
> +void debugfs_slab_release(struct kmem_cache *);
> +#else
> +static inline void debugfs_slab_release(struct kmem_cache *s) { }
> +#endif
> +
>  #ifdef CONFIG_PRINTK
>  #define KS_ADDRS_COUNT 16
>  struct kmem_obj_info {
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index a4a5714..ee5456f 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -449,6 +449,7 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>  	rcu_barrier();
>  
>  	list_for_each_entry_safe(s, s2, &to_destroy, list) {
> +		debugfs_slab_release(s);
>  		kfence_shutdown_cache(s);
>  #ifdef SLAB_SUPPORTS_SYSFS
>  		sysfs_slab_release(s);
> @@ -476,6 +477,7 @@ static int shutdown_cache(struct kmem_cache *s)
>  		schedule_work(&slab_caches_to_rcu_destroy_work);
>  	} else {
>  		kfence_shutdown_cache(s);
> +		debugfs_slab_release(s);
>  #ifdef SLAB_SUPPORTS_SYSFS
>  		sysfs_slab_unlink(s);
>  		sysfs_slab_release(s);
> diff --git a/mm/slub.c b/mm/slub.c
> index 3f96e09..ee0a357 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -36,6 +36,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/random.h>
>  
> +#include <linux/debugfs.h>
>  #include <trace/events/kmem.h>
>  
>  #include "internal.h"
> @@ -225,6 +226,12 @@ static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
>  							{ return 0; }
>  #endif
>  
> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
> +static void debugfs_slab_add(struct kmem_cache *);
> +#else
> +static inline void debugfs_slab_add(struct kmem_cache *s) { }
> +#endif
> +
>  static inline void stat(const struct kmem_cache *s, enum stat_item si)
>  {
>  #ifdef CONFIG_SLUB_STATS
> @@ -4546,6 +4553,9 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
>  	if (err)
>  		__kmem_cache_release(s);
>  
> +	if (s->flags & SLAB_STORE_USER)
> +		debugfs_slab_add(s);
> +
>  	return err;
>  }
>  
> @@ -4686,6 +4696,8 @@ static long validate_slab_cache(struct kmem_cache *s)
>  
>  	return count;
>  }
> +
> +#ifdef CONFIG_DEBUG_FS
>  /*
>   * Generate lists of code addresses where slabcache objects are allocated
>   * and freed.
> @@ -4709,6 +4721,8 @@ struct loc_track {
>  	struct location *loc;
>  };
>  
> +static struct dentry *slab_debugfs_root;
> +
>  static void free_loc_track(struct loc_track *t)
>  {
>  	if (t->max)
> @@ -4825,82 +4839,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
>  			add_location(t, s, get_track(s, p, alloc));
>  	put_map(map);
>  }
> -
> -static int list_locations(struct kmem_cache *s, char *buf,
> -			  enum track_item alloc)
> -{
> -	int len = 0;
> -	unsigned long i;
> -	struct loc_track t = { 0, 0, NULL };
> -	int node;
> -	struct kmem_cache_node *n;
> -
> -	if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
> -			     GFP_KERNEL)) {
> -		return sysfs_emit(buf, "Out of memory\n");
> -	}
> -	/* Push back cpu slabs */
> -	flush_all(s);
> -
> -	for_each_kmem_cache_node(s, node, n) {
> -		unsigned long flags;
> -		struct page *page;
> -
> -		if (!atomic_long_read(&n->nr_slabs))
> -			continue;
> -
> -		spin_lock_irqsave(&n->list_lock, flags);
> -		list_for_each_entry(page, &n->partial, slab_list)
> -			process_slab(&t, s, page, alloc);
> -		list_for_each_entry(page, &n->full, slab_list)
> -			process_slab(&t, s, page, alloc);
> -		spin_unlock_irqrestore(&n->list_lock, flags);
> -	}
> -
> -	for (i = 0; i < t.count; i++) {
> -		struct location *l = &t.loc[i];
> -
> -		len += sysfs_emit_at(buf, len, "%7ld ", l->count);
> -
> -		if (l->addr)
> -			len += sysfs_emit_at(buf, len, "%pS", (void *)l->addr);
> -		else
> -			len += sysfs_emit_at(buf, len, "<not-available>");
> -
> -		if (l->sum_time != l->min_time)
> -			len += sysfs_emit_at(buf, len, " age=%ld/%ld/%ld",
> -					     l->min_time,
> -					     (long)div_u64(l->sum_time,
> -							   l->count),
> -					     l->max_time);
> -		else
> -			len += sysfs_emit_at(buf, len, " age=%ld", l->min_time);
> -
> -		if (l->min_pid != l->max_pid)
> -			len += sysfs_emit_at(buf, len, " pid=%ld-%ld",
> -					     l->min_pid, l->max_pid);
> -		else
> -			len += sysfs_emit_at(buf, len, " pid=%ld",
> -					     l->min_pid);
> -
> -		if (num_online_cpus() > 1 &&
> -		    !cpumask_empty(to_cpumask(l->cpus)))
> -			len += sysfs_emit_at(buf, len, " cpus=%*pbl",
> -					     cpumask_pr_args(to_cpumask(l->cpus)));
> -
> -		if (nr_online_nodes > 1 && !nodes_empty(l->nodes))
> -			len += sysfs_emit_at(buf, len, " nodes=%*pbl",
> -					     nodemask_pr_args(&l->nodes));
> -
> -		len += sysfs_emit_at(buf, len, "\n");
> -	}
> -
> -	free_loc_track(&t);
> -	if (!t.count)
> -		len += sysfs_emit_at(buf, len, "No data\n");
> -
> -	return len;
> -}
> +#endif  /* CONFIG_DEBUG_FS   */
>  #endif	/* CONFIG_SLUB_DEBUG */
>  
>  #ifdef SLUB_RESILIENCY_TEST
> @@ -5350,21 +5289,6 @@ static ssize_t validate_store(struct kmem_cache *s,
>  }
>  SLAB_ATTR(validate);
>  
> -static ssize_t alloc_calls_show(struct kmem_cache *s, char *buf)
> -{
> -	if (!(s->flags & SLAB_STORE_USER))
> -		return -ENOSYS;
> -	return list_locations(s, buf, TRACK_ALLOC);
> -}
> -SLAB_ATTR_RO(alloc_calls);
> -
> -static ssize_t free_calls_show(struct kmem_cache *s, char *buf)
> -{
> -	if (!(s->flags & SLAB_STORE_USER))
> -		return -ENOSYS;
> -	return list_locations(s, buf, TRACK_FREE);
> -}
> -SLAB_ATTR_RO(free_calls);
>  #endif /* CONFIG_SLUB_DEBUG */
>  
>  #ifdef CONFIG_FAILSLAB
> @@ -5528,8 +5452,6 @@ static struct attribute *slab_attrs[] = {
>  	&poison_attr.attr,
>  	&store_user_attr.attr,
>  	&validate_attr.attr,
> -	&alloc_calls_attr.attr,
> -	&free_calls_attr.attr,
>  #endif
>  #ifdef CONFIG_ZONE_DMA
>  	&cache_dma_attr.attr,
> @@ -5818,6 +5740,181 @@ static int __init slab_sysfs_init(void)
>  __initcall(slab_sysfs_init);
>  #endif /* CONFIG_SYSFS */
>  
> +#if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
> +static int slab_debugfs_show(struct seq_file *seq, void *v)
> +{
> +
> +	struct location *l;
> +	unsigned int idx = *(unsigned int *)v;
> +	struct loc_track *t = seq->private;
> +
> +	if (idx < t->count) {
> +		l = &t->loc[idx];
> +
> +		seq_printf(seq, "%7ld ", l->count);
> +
> +		if (l->addr)
> +			seq_printf(seq, "%pS", (void *)l->addr);
> +		else
> +			seq_puts(seq, "<not-available>");
> +
> +		if (l->sum_time != l->min_time) {
> +			seq_printf(seq, " age=%ld/%llu/%ld",
> +				l->min_time, div_u64(l->sum_time, l->count),
> +				l->max_time);
> +		} else
> +			seq_printf(seq, " age=%ld", l->min_time);
> +
> +		if (l->min_pid != l->max_pid)
> +			seq_printf(seq, " pid=%ld-%ld", l->min_pid, l->max_pid);
> +		else
> +			seq_printf(seq, " pid=%ld",
> +				l->min_pid);
> +
> +		if (num_online_cpus() > 1 && !cpumask_empty(to_cpumask(l->cpus)))
> +			seq_printf(seq, " cpus=%*pbl",
> +				 cpumask_pr_args(to_cpumask(l->cpus)));
> +
> +		if (nr_online_nodes > 1 && !nodes_empty(l->nodes))
> +			seq_printf(seq, " nodes=%*pbl",
> +				 nodemask_pr_args(&l->nodes));
> +
> +		seq_puts(seq, "\n");
> +	}
> +
> +	if (!idx && !t->count)
> +		seq_puts(seq, "No data\n");
> +
> +	return 0;
> +}
> +
> +static void slab_debugfs_stop(struct seq_file *seq, void *v)
> +{
> +	kfree(v);
> +}
> +
> +static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
> +{
> +	loff_t *spos = v;
> +	struct loc_track *t = seq->private;
> +
> +	if (*ppos < t->count) {
> +		*ppos = ++*spos;
> +		return spos;
> +	}
> +	*ppos = ++*spos;
> +	return NULL;
> +}
> +
> +static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
> +{
> +	loff_t *spos = kmalloc(sizeof(loff_t), GFP_KERNEL);
> +
> +	if (!spos)
> +		return NULL;
> +
> +	*spos = *ppos;
> +	return spos;
> +}
> +
> +static const struct seq_operations slab_debugfs_sops = {
> +	.start  = slab_debugfs_start,
> +	.next   = slab_debugfs_next,
> +	.stop   = slab_debugfs_stop,
> +	.show   = slab_debugfs_show,
> +};
> +
> +static int slab_debug_trace_open(struct inode *inode, struct file *filep)
> +{
> +
> +	struct kmem_cache_node *n;
> +	enum track_item alloc;
> +	int node;
> +	struct loc_track *t = __seq_open_private(filep, &slab_debugfs_sops,
> +						sizeof(struct loc_track));
> +	struct kmem_cache *s = file_inode(filep)->i_private;
> +
> +	if (strcmp(filep->f_path.dentry->d_name.name, "alloc_traces") == 0)
> +		alloc = TRACK_ALLOC;
> +	else
> +		alloc = TRACK_FREE;
> +
> +	if (!alloc_loc_track(t, PAGE_SIZE / sizeof(struct location), GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	/* Push back cpu slabs */
> +	flush_all(s);
> +
> +	for_each_kmem_cache_node(s, node, n) {
> +		unsigned long flags;
> +		struct page *page;
> +
> +		if (!atomic_long_read(&n->nr_slabs))
> +			continue;
> +
> +		spin_lock_irqsave(&n->list_lock, flags);
> +		list_for_each_entry(page, &n->partial, slab_list)
> +			process_slab(t, s, page, alloc);
> +		list_for_each_entry(page, &n->full, slab_list)
> +			process_slab(t, s, page, alloc);
> +		spin_unlock_irqrestore(&n->list_lock, flags);
> +	}
> +
> +	return 0;
> +}
> +
> +static int slab_debug_trace_release(struct inode *inode, struct file *file)
> +{
> +	struct seq_file *seq = file->private_data;
> +	struct loc_track *t = seq->private;
> +
> +	free_loc_track(t);
> +	return seq_release_private(inode, file);
> +}
> +
> +static const struct file_operations slab_debugfs_fops = {
> +	.open    = slab_debug_trace_open,
> +	.read    = seq_read,
> +	.llseek  = seq_lseek,
> +	.release = slab_debug_trace_release,
> +};
> +
> +static void debugfs_slab_add(struct kmem_cache *s)
> +{
> +	struct dentry *slab_cache_dir;
> +
> +	if (unlikely(!slab_debugfs_root))
> +		return;
> +
> +	slab_cache_dir = debugfs_create_dir(s->name, slab_debugfs_root);
> +
> +	debugfs_create_file("alloc_traces", 0400,
> +		slab_cache_dir, s, &slab_debugfs_fops);
> +
> +	debugfs_create_file("free_traces", 0400,
> +		slab_cache_dir, s, &slab_debugfs_fops);
> +}
> +
> +void debugfs_slab_release(struct kmem_cache *s)
> +{
> +	debugfs_remove_recursive(debugfs_lookup(s->name, slab_debugfs_root));
> +}
> +
> +static int __init slab_debugfs_init(void)
> +{
> +	struct kmem_cache *s;
> +
> +	slab_debugfs_root = debugfs_create_dir("slab", NULL);
> +
> +	list_for_each_entry(s, &slab_caches, list)
> +		if (s->flags & SLAB_STORE_USER)
> +			debugfs_slab_add(s);
> +
> +	return 0;
> +
> +}
> +__initcall(slab_debugfs_init);
> +#endif
>  /*
>   * The /proc/slabinfo ABI
>   */
> 
