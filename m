Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1EC39CFD6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 17:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFFPmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 11:42:43 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:18275 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbhFFPmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 11:42:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622994050; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=89MZE4O0DKK8a3zBDgOlrEV4JsRzIHwqs/KoHKs7+/g=; b=CbrcZ97aCYrb5YX8JpwkhL9Nx/jSKepFCG8vxMKWNhVpYn7cFjIF027G5iiyLv6wByNuvOMS
 E89EU1G30ZY8316Q2FeFWIDzDRRDkZVtluqJRGOgX7rFA7u3f+Q/ehwxKryQBF9fWoU09OiR
 Z+e13YKZl+KObPDuaOT8VdQjr1g=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60bcec646ddc3305c420519a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 06 Jun 2021 15:40:20
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 86682C43460; Sun,  6 Jun 2021 15:40:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.181.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C52A8C433D3;
        Sun,  6 Jun 2021 15:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C52A8C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v9] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com
Cc:     vinmenon@codeaurora.org
References: <1622720932-5579-1-git-send-email-faiyazm@codeaurora.org>
 <c7b0136f-c970-010f-9c3e-33d6bb24b83a@suse.cz>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <ceeca512-52ae-64b1-a372-536607bdd2ee@codeaurora.org>
Date:   Sun, 6 Jun 2021 21:10:02 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <c7b0136f-c970-010f-9c3e-33d6bb24b83a@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/3/2021 6:32 PM, Vlastimil Babka wrote:
> On 6/3/21 1:48 PM, Faiyaz Mohammed wrote:
>> alloc_calls and free_calls implementation in sysfs have two issues,
>> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
>> to "one value per file" rule.
>>
>> To overcome this issues, move the alloc_calls and free_calls implemeation
>> to debugfs.
>>
>> Debugfs cache will be created if SLAB_STORE_USER flag is set.
>>
>> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
>> to be inline with what it does.
>>
>> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
>> ---
>> changes in v9:
>> 	- Move the debugfs_slab_release to mm/slab.h.
>> 	- Remove the global loc_track variable and using seq_file private.
>>
>> changes in v8:
>> 	- https://lore.kernel.org/linux-mm/1622542057-14632-1-git-send-email-faiyazm@codeaurora.org/
>> 	
>> changes in V7:
>> 	- https://lore.kernel.org/linux-mm/1621928285-751-1-git-send-email-faiyazm@codeaurora.org/
>>
>> changes in v6:
>> 	- https://lore.kernel.org/linux-mm/1621341949-26762-1-git-send-email-faiyazm@codeaurora.org/
>>
>> changes in v5:
>> 	- https://lore.kernel.org/linux-mm/1620296523-21922-1-git-send-email-faiyazm@codeaurora.org/
>>
>> changes in v4:
>> 	- https://lore.kernel.org/linux-mm/1618583239-18124-1-git-send-email-faiyazm@codeaurora.org/
>>
>> changes in v3:
>> 	- https://lore.kernel.org/linux-mm/1617712064-12264-1-git-send-email-faiyazm@codeaurora.org/
>>
>> changes in v2:
>> 	- https://lore.kernel.org/linux-mm/3ac1d3e6-6207-96ad-16a1-0f5139d8b2b5@codeaurora.org/
>>
>> changes in v1
>> 	- https://lore.kernel.org/linux-mm/1610443287-23933-1-git-send-email-faiyazm@codeaurora.org/
>>
>>  mm/slab.h        |   8 ++
>>  mm/slab_common.c |   2 +
>>  mm/slub.c        | 312 ++++++++++++++++++++++++++++++++++++++-----------------
>>  3 files changed, 229 insertions(+), 93 deletions(-)
>>
>> diff --git a/mm/slab.h b/mm/slab.h
>> index 18c1927..3b60925 100644
>> --- a/mm/slab.h
>> +++ b/mm/slab.h
>> @@ -630,6 +630,14 @@ static inline bool slab_want_init_on_free(struct kmem_cache *c)
>>  	return false;
>>  }
>>  
>> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
>> +void debugfs_slab_release(struct kmem_cache *);
>> +#else
>> +static inline void debugfs_slab_release(struct kmem_cache *s)
>> +{
>> +}
>> +#endif
>> +
>>  #ifdef CONFIG_PRINTK
>>  #define KS_ADDRS_COUNT 16
>>  struct kmem_obj_info {
>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index a4a5714..bca69b6 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -469,6 +469,7 @@ static int shutdown_cache(struct kmem_cache *s)
>>  	list_del(&s->list);
>>  
>>  	if (s->flags & SLAB_TYPESAFE_BY_RCU) {
>> +		debugfs_slab_release(s);
>>  #ifdef SLAB_SUPPORTS_SYSFS
>>  		sysfs_slab_unlink(s);
>>  #endif
>> @@ -476,6 +477,7 @@ static int shutdown_cache(struct kmem_cache *s)
>>  		schedule_work(&slab_caches_to_rcu_destroy_work);
>>  	} else {
>>  		kfence_shutdown_cache(s);
>> +		debugfs_slab_release(s);
>>  #ifdef SLAB_SUPPORTS_SYSFS
>>  		sysfs_slab_unlink(s);
>>  		sysfs_slab_release(s);
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 3f96e09..c00c9d5 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -36,6 +36,7 @@
>>  #include <linux/memcontrol.h>
>>  #include <linux/random.h>
>>  
>> +#include <linux/debugfs.h>
>>  #include <trace/events/kmem.h>
>>  
>>  #include "internal.h"
>> @@ -225,6 +226,12 @@ static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
>>  							{ return 0; }
>>  #endif
>>  
>> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
>> +static void debugfs_slab_add(struct kmem_cache *);
>> +#else
>> +static inline void debugfs_slab_add(struct kmem_cache *s) { }
>> +#endif
>> +
>>  static inline void stat(const struct kmem_cache *s, enum stat_item si)
>>  {
>>  #ifdef CONFIG_SLUB_STATS
>> @@ -4546,6 +4553,9 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
>>  	if (err)
>>  		__kmem_cache_release(s);
>>  
>> +	if (s->flags & SLAB_STORE_USER)
>> +		debugfs_slab_add(s);
>> +
>>  	return err;
>>  }
>>  
>> @@ -4686,6 +4696,8 @@ static long validate_slab_cache(struct kmem_cache *s)
>>  
>>  	return count;
>>  }
>> +
>> +#ifdef CONFIG_DEBUG_FS
>>  /*
>>   * Generate lists of code addresses where slabcache objects are allocated
>>   * and freed.
>> @@ -4709,6 +4721,8 @@ struct loc_track {
>>  	struct location *loc;
>>  };
>>  
>> +static struct dentry *slab_debugfs_root;
>> +
>>  static void free_loc_track(struct loc_track *t)
>>  {
>>  	if (t->max)
>> @@ -4825,82 +4839,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
>>  			add_location(t, s, get_track(s, p, alloc));
>>  	put_map(map);
>>  }
>> -
>> -static int list_locations(struct kmem_cache *s, char *buf,
>> -			  enum track_item alloc)
>> -{
>> -	int len = 0;
>> -	unsigned long i;
>> -	struct loc_track t = { 0, 0, NULL };
>> -	int node;
>> -	struct kmem_cache_node *n;
>> -
>> -	if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
>> -			     GFP_KERNEL)) {
>> -		return sysfs_emit(buf, "Out of memory\n");
>> -	}
>> -	/* Push back cpu slabs */
>> -	flush_all(s);
>> -
>> -	for_each_kmem_cache_node(s, node, n) {
>> -		unsigned long flags;
>> -		struct page *page;
>> -
>> -		if (!atomic_long_read(&n->nr_slabs))
>> -			continue;
>> -
>> -		spin_lock_irqsave(&n->list_lock, flags);
>> -		list_for_each_entry(page, &n->partial, slab_list)
>> -			process_slab(&t, s, page, alloc);
>> -		list_for_each_entry(page, &n->full, slab_list)
>> -			process_slab(&t, s, page, alloc);
>> -		spin_unlock_irqrestore(&n->list_lock, flags);
>> -	}
>> -
>> -	for (i = 0; i < t.count; i++) {
>> -		struct location *l = &t.loc[i];
>> -
>> -		len += sysfs_emit_at(buf, len, "%7ld ", l->count);
>> -
>> -		if (l->addr)
>> -			len += sysfs_emit_at(buf, len, "%pS", (void *)l->addr);
>> -		else
>> -			len += sysfs_emit_at(buf, len, "<not-available>");
>> -
>> -		if (l->sum_time != l->min_time)
>> -			len += sysfs_emit_at(buf, len, " age=%ld/%ld/%ld",
>> -					     l->min_time,
>> -					     (long)div_u64(l->sum_time,
>> -							   l->count),
>> -					     l->max_time);
>> -		else
>> -			len += sysfs_emit_at(buf, len, " age=%ld", l->min_time);
>> -
>> -		if (l->min_pid != l->max_pid)
>> -			len += sysfs_emit_at(buf, len, " pid=%ld-%ld",
>> -					     l->min_pid, l->max_pid);
>> -		else
>> -			len += sysfs_emit_at(buf, len, " pid=%ld",
>> -					     l->min_pid);
>> -
>> -		if (num_online_cpus() > 1 &&
>> -		    !cpumask_empty(to_cpumask(l->cpus)))
>> -			len += sysfs_emit_at(buf, len, " cpus=%*pbl",
>> -					     cpumask_pr_args(to_cpumask(l->cpus)));
>> -
>> -		if (nr_online_nodes > 1 && !nodes_empty(l->nodes))
>> -			len += sysfs_emit_at(buf, len, " nodes=%*pbl",
>> -					     nodemask_pr_args(&l->nodes));
>> -
>> -		len += sysfs_emit_at(buf, len, "\n");
>> -	}
>> -
>> -	free_loc_track(&t);
>> -	if (!t.count)
>> -		len += sysfs_emit_at(buf, len, "No data\n");
>> -
>> -	return len;
>> -}
>> +#endif  /* CONFIG_DEBUG_FS   */
>>  #endif	/* CONFIG_SLUB_DEBUG */
>>  
>>  #ifdef SLUB_RESILIENCY_TEST
>> @@ -5350,21 +5289,6 @@ static ssize_t validate_store(struct kmem_cache *s,
>>  }
>>  SLAB_ATTR(validate);
>>  
>> -static ssize_t alloc_calls_show(struct kmem_cache *s, char *buf)
>> -{
>> -	if (!(s->flags & SLAB_STORE_USER))
>> -		return -ENOSYS;
>> -	return list_locations(s, buf, TRACK_ALLOC);
>> -}
>> -SLAB_ATTR_RO(alloc_calls);
>> -
>> -static ssize_t free_calls_show(struct kmem_cache *s, char *buf)
>> -{
>> -	if (!(s->flags & SLAB_STORE_USER))
>> -		return -ENOSYS;
>> -	return list_locations(s, buf, TRACK_FREE);
>> -}
>> -SLAB_ATTR_RO(free_calls);
>>  #endif /* CONFIG_SLUB_DEBUG */
>>  
>>  #ifdef CONFIG_FAILSLAB
>> @@ -5528,8 +5452,6 @@ static struct attribute *slab_attrs[] = {
>>  	&poison_attr.attr,
>>  	&store_user_attr.attr,
>>  	&validate_attr.attr,
>> -	&alloc_calls_attr.attr,
>> -	&free_calls_attr.attr,
>>  #endif
>>  #ifdef CONFIG_ZONE_DMA
>>  	&cache_dma_attr.attr,
>> @@ -5818,6 +5740,210 @@ static int __init slab_sysfs_init(void)
>>  __initcall(slab_sysfs_init);
>>  #endif /* CONFIG_SYSFS */
>>  
>> +#if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
>> +static int slab_debugfs_show(struct seq_file *seq, void *v)
>> +{
>> +
>> +	struct location *l;
>> +	unsigned int idx = *(unsigned int *)v;
>> +	struct loc_track *t = seq->private;
>> +
>> +	if (idx < t->count) {
>> +		l = &t->loc[idx];
>> +
>> +		seq_printf(seq, "%7ld ", l->count);
>> +
>> +		if (l->addr)
>> +			seq_printf(seq, "%pS", (void *)l->addr);
>> +		else
>> +			seq_puts(seq, "<not-available>");
>> +
>> +		if (l->sum_time != l->min_time) {
>> +			seq_printf(seq, " age=%ld/%ld/%ld",
>> +				l->min_time,
>> +				(long)div_u64(l->sum_time, l->count),
>> +				l->max_time);
>> +		} else
>> +			seq_printf(seq, " age=%ld",
>> +				l->min_time);
>> +
>> +		if (l->min_pid != l->max_pid)
>> +			seq_printf(seq, " pid=%ld-%ld",
>> +				l->min_pid, l->max_pid);
>> +		else
>> +			seq_printf(seq, " pid=%ld",
>> +				l->min_pid);
>> +
>> +		if (num_online_cpus() > 1 &&
>> +				!cpumask_empty(to_cpumask(l->cpus)))
>> +			seq_printf(seq, " cpus=%*pbl",
>> +				 cpumask_pr_args(to_cpumask(l->cpus)));
>> +
>> +		if (nr_online_nodes > 1 && !nodes_empty(l->nodes))
>> +			seq_printf(seq, " nodes=%*pbl",
>> +				 nodemask_pr_args(&l->nodes));
>> +
>> +		seq_puts(seq, "\n");
>> +	}
>> +
>> +	if (!t->count)
>> +		seq_puts(seq, "No data\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static void slab_debugfs_stop(struct seq_file *seq, void *v)
>> +{
>> +	if ((!v) &&
>> +		((struct loc_track *)seq->private)->count == (seq->index - 1))
>> +		free_loc_track((struct loc_track *)seq->private);
> 
> Please use a local "loc_track *t" variable as elsewhere to avoid these multiple
> inline casts.
>
Okay, will update in next patch version.

> I don't think this code ever executes anything as !v is most likely never true?
> 
It will execute when slab_debugfs_next() return NULL (v will be NULL)
and slab_debugfs_next() will return NULLL, when it will completed the
t->count reading. Still, I will update in next patch version.

> Also I don't understand why the count == seq->index - 1 comparison.
> 
The count == seq->index - 1 comparision is to avoid the calling of
free_loc_track() multiple time. Still, I will update in next patch version.

> I think this function should do simply:
> 
> kfree(v);
> 
hmm, yes we can do that but when ever seq_has_overflowed() happen it
will call the ->stop(), so to avoiding that returning NULL from
slab_debugfs_next() and doing !v check in slab_debugfs_stop. Still, I
will update in next patch version.

> More on the loc_track and seq->private lifecycle below.
> 
>> +}
>> +
>> +static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
>> +{
>> +	loff_t *spos = v;
>> +	struct loc_track *t = seq->private;
>> +
>> +	if (*ppos < t->count) {
>> +		*spos = *spos + 1;
>> +		*ppos = *spos;
>> +		return spos;
>> +	}
>> +
>> +	*spos = *spos + 1;
>> +	*ppos = *spos;
>> +	return NULL;
>> +}
>> +
>> +static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
>> +{
>> +	struct kmem_cache_node *n;
>> +	struct kmem_cache *s;
>> +	enum track_item alloc;
>> +	int node;
>> +	loff_t *spos = kmalloc(sizeof(loff_t), GFP_KERNEL);
>> +
>> +	s = seq->file->f_inode->i_private;
>> +
>> +	if (!spos)
>> +		return NULL;
>> +
>> +	if (*ppos == 0) {
> 
> Hm I think it's wrong to put all this behind the *ppos = 0 condition. Somebody
> might open the file, then do a lseek() and then read. The condition should be
> "did we fill lock_track info yet?".
>>> +		if (strcmp(seq->file->f_path.dentry->d_name.name, "alloc_traces")
== 0)
>> +			alloc =  TRACK_ALLOC;
>> +		else
>> +			alloc =  TRACK_FREE;
>> +
>> +		seq->private = kmalloc(sizeof(struct loc_track), GFP_KERNEL);
> 
> This should be better allocated during open().
>
>> +		memset(seq->private, 0, sizeof(struct loc_track));
>> +
>> +		if (!alloc_loc_track((struct loc_track *)seq->private,
> 
> Again, please define a local variable for this at the top of the function.
> >> +				PAGE_SIZE / sizeof(struct location), GFP_KERNEL)) {
>> +			seq_puts(seq, "Out of memory\n");
> 
> Hmm I don't think we can should to seq from a .start function.
> Maybe just return the -ENOMEM.
> >> +			kfree(spos);
>> +			return ERR_PTR(-ENOMEM);
>> +		}
>> +		/* Push back cpu slabs */
>> +		flush_all(s);
>> +
>> +		for_each_kmem_cache_node(s, node, n) {
>> +			unsigned long flags;
>> +			struct page *page;
>> +
>> +			if (!atomic_long_read(&n->nr_slabs))
>> +				continue;
>> +
>> +			spin_lock_irqsave(&n->list_lock, flags);
>> +			list_for_each_entry(page, &n->partial, slab_list)
>> +				process_slab((struct loc_track *)seq->private, s, page, alloc);
>> +			list_for_each_entry(page, &n->full, slab_list)
>> +				process_slab((struct loc_track *)seq->private, s, page, alloc);
>> +			spin_unlock_irqrestore(&n->list_lock, flags);
>> +		}
>> +	}
>> +
>> +	if (seq->private) {
>> +		struct loc_track *t = seq->private;
>> +
>> +		if (*ppos < t->count) {
>> +			*spos = *ppos;
>> +			return spos;
>> +		}
>> +	}
>> +
>> +	kfree(spos);
>> +	kfree(seq->private);
>> +	return NULL;
>> +}
>> +
>> +static const struct seq_operations slab_debugfs_sops = {
>> +	.start  = slab_debugfs_start,
>> +	.next   = slab_debugfs_next,
>> +	.stop   = slab_debugfs_stop,
>> +	.show   = slab_debugfs_show
>> +};
> 
> So I think the seq->private lifecycle should be tied to open()/close(), not
> start()/stop() where the latter is AFAIK performed as part of each read() syscall.
> 
> So like in
> https://lore.kernel.org/linux-mm/20210521121127.24653-3-glittao@gmail.com/
> we'll need a "struct file_operations" too, with an .open function that
> __seq_open_private() to allocate seq->private and then do the initial
> alloc_loc_track().
> 
> Then we'll also need a .release function that does free_loc_track() and then
> seq_release_private().
> 
> The filling of loc_track with data could happen either in open() or in start(),
> but only once after open() and not depending on *ppos == 0 (as I mentioned above).
> 
> The next/stop should take care only of the spos object.
> 
>> +DEFINE_SEQ_ATTRIBUTE(slab_debugfs);
>> +
>> +static void debugfs_slab_add(struct kmem_cache *s)
>> +{
>> +	const char *name;
>> +	struct dentry *slab_cache_dir;
>> +	int unmergeable = slab_unmergeable(s);
>> +
>> +	if (unlikely(!slab_debugfs_root))
>> +		return;
>> +
>> +	if (!unmergeable && disable_higher_order_debug &&
>> +			(slub_debug & DEBUG_METADATA_FLAGS))
>> +		unmergeable = 1;
>> +
>> +	if (unmergeable) {
>> +		/*
>> +		 * Slabcache can never be merged so we can use the name proper.
>> +		 * This is typically the case for debug situations. In that
>> +		 * case we can catch duplicate names easily.
>> +		 */
>> +		slab_cache_dir = debugfs_lookup(s->name, slab_debugfs_root);
>> +		debugfs_remove_recursive(slab_cache_dir);
>> +		name = s->name;
>> +	} else {
>> +		/*
>> +		 * Create a unique name for the slab as a target
>> +		 * for the symlinks.
>> +		 */
>> +		name = create_unique_id(s);
>> +	}
> 
> I think here we can rely on the fact that SLAB_STORE_USER cache will return
> slab_unmergeable(s) as 1, and greatly simplify the code above.
> 
>> +	slab_cache_dir = debugfs_create_dir(name, slab_debugfs_root);
>> +
>> +	debugfs_create_file("alloc_traces", 0400,
>> +		slab_cache_dir, s, &slab_debugfs_fops);
>> +
>> +	debugfs_create_file("free_traces", 0400,
>> +		slab_cache_dir, s, &slab_debugfs_fops);
>> +}
>> +
>> +void debugfs_slab_release(struct kmem_cache *s)
>> +{
>> +	debugfs_remove_recursive(debugfs_lookup(s->name,
>> +					slab_debugfs_root));
>> +}
>> +
>> +static int __init slab_debugfs_init(void)
>> +{
>> +	struct kmem_cache *s;
>> +
>> +	slab_debugfs_root = debugfs_create_dir("slab", NULL);
>> +
>> +	list_for_each_entry(s, &slab_caches, list)
>> +		if (s->flags & SLAB_STORE_USER)
>> +			debugfs_slab_add(s);
>> +
>> +	return 0;
>> +
>> +}
>> +__initcall(slab_debugfs_init);
>> +#endif
>>  /*
>>   * The /proc/slabinfo ABI
>>   */
>>
> 
I will update in next patch version.
