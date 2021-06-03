Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BA2399C2B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFCH6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:58:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:10556 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFCH6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:58:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622707019; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=6WRgPAl+BB4MAUcBvy9HDIQZdPB119OrpSi4TO9lRUQ=; b=h3EeflOdg5m7Del6Pcx//GiSdkQH0B7sfcxB77y1cJpPfR7c9HIFF8yHHPXEzuLy7LHHp6CG
 zbWTQUsArUUAIAOAkVGYqyQC0RVjjagk2y1JOut374qwLiQm+E3EVt2NGtuKfM9z8j5Nd03b
 QHxpk07Nr52f79Mfy305TkYiXKs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60b88b38f726fa4188568229 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 03 Jun 2021 07:56:40
 GMT
Sender: faiyazm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4A67C433D3; Thu,  3 Jun 2021 07:56:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.181.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: faiyazm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7BF52C4338A;
        Thu,  3 Jun 2021 07:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BF52C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=faiyazm@codeaurora.org
Subject: Re: [PATCH v8] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
To:     Vlastimil Babka <vbabka@suse.cz>, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com
Cc:     vinmenon@codeaurora.org
References: <1622542057-14632-1-git-send-email-faiyazm@codeaurora.org>
 <8c6db046-9f12-e670-8fe0-6d34f9328a52@suse.cz>
From:   Faiyaz Mohammed <faiyazm@codeaurora.org>
Message-ID: <3cd98e90-8373-dc4d-cc25-99fa18c2d73c@codeaurora.org>
Date:   Thu, 3 Jun 2021 13:26:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <8c6db046-9f12-e670-8fe0-6d34f9328a52@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/2021 7:01 PM, Vlastimil Babka wrote:
> On 6/1/21 12:07 PM, Faiyaz Mohammed wrote:
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
> 
> When reading the files I'm getting dmesg errors like this:
> 
> [   37.998152] seq_file: buggy .next function slab_debugfs_next did not update
> position index
> 
> Don't recall this from previous versions?
> 
slab_debugfs_next() is not updating the pos after last read, so it's
retuning null. In fs/seq_file.c if pos is not updated in ->next() fn,
it's printing the above info but I will address this in next patch version.

>> diff --git a/mm/slab_common.c b/mm/slab_common.c
>> index a4a5714..ca39e84 100644
>> --- a/mm/slab_common.c
>> +++ b/mm/slab_common.c
>> @@ -449,6 +449,7 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>>  	rcu_barrier();
>>  
>>  	list_for_each_entry_safe(s, s2, &to_destroy, list) {
>> +		debugfs_slab_release(s);
> 
> You should remove this one, you already do the release when queueing the work
> below. This is not like sysfs where we distinguish _unlink() when queueing and
> _release when processing the work.
>
oh, yes, I will update in next patch version.

>> +static struct dentry *slab_debugfs_root;
>> +struct loc_track t = { 0, 0, NULL };
> 
> Ooops, this can't be a global variable, especially when shared without any lock
> protection - but even with a protection it would be very suboptimal. You'll need
> to make it a seq_file private, see e.g. here for an example:
> https://lore.kernel.org/linux-mm/20210521121127.24653-3-glittao@gmail.com/
>
I will address this in next patch version.

>>  static void free_loc_track(struct loc_track *t)
>>  {
>>  	if (t->max)
>> @@ -4825,82 +4840,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
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
>> @@ -5350,21 +5290,6 @@ static ssize_t validate_store(struct kmem_cache *s,
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
>> @@ -5528,8 +5453,6 @@ static struct attribute *slab_attrs[] = {
>>  	&poison_attr.attr,
>>  	&store_user_attr.attr,
>>  	&validate_attr.attr,
>> -	&alloc_calls_attr.attr,
>> -	&free_calls_attr.attr,
>>  #endif
>>  #ifdef CONFIG_ZONE_DMA
>>  	&cache_dma_attr.attr,
>> @@ -5818,6 +5741,203 @@ static int __init slab_sysfs_init(void)
>>  __initcall(slab_sysfs_init);
>>  #endif /* CONFIG_SYSFS */
>>  
>> +#if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
>> +static int slab_debugfs_show(struct seq_file *seq, void *v)
>> +{
>> +
>> +	struct location *l;
>> +	unsigned int idx = *(unsigned int *)v;
>> +
>> +	if (idx < t.count) {
>> +		l = &t.loc[idx];
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
>> +	if (t.count == 0)
>> +		seq_puts(seq, "No data\n");
>> +
>> +	return 0;
>> +}
>> +
>> +static void slab_debugfs_stop(struct seq_file *seq, void *v)
>> +{
>> +	if (!v && t.max) {
>> +		free_loc_track(&t);
>> +		t.max = 0;
>> +	}
>> +}
>> +
>> +static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
>> +{
>> +	loff_t *spos = v;
>> +
>> +	if (*ppos < t.count) {
>> +		*spos = *spos + 1;
>> +		*ppos = *spos;
>> +		return spos;
>> +	}
>> +
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
>> +
>> +		t.count = 0;
>> +		t.max = 0;
>> +		t.loc = NULL;
>> +		if (strcmp(seq->file->f_path.dentry->d_name.name, "alloc_traces") == 0)
>> +			alloc =  TRACK_ALLOC;
>> +		else
>> +			alloc =  TRACK_FREE;
>> +
>> +		if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
>> +			     GFP_KERNEL)) {
>> +			seq_puts(seq, "Out of memory\n");
>> +			kfree(spos);
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
>> +				process_slab(&t, s, page, alloc);
>> +			list_for_each_entry(page, &n->full, slab_list)
>> +				process_slab(&t, s, page, alloc);
>> +			spin_unlock_irqrestore(&n->list_lock, flags);
>> +		}
>> +	}
>> +
>> +	if (*ppos < t.count) {
>> +		*spos = *ppos;
>> +		return spos;
>> +	}
>> +
>> +	kfree(spos);
>> +	return NULL;
>> +}
>> +
>> +static const struct seq_operations slab_debugfs_sops = {
>> +	.start  = slab_debugfs_start,
>> +	.next   = slab_debugfs_next,
>> +	.stop   = slab_debugfs_stop,
>> +	.show   = slab_debugfs_show
>> +};
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
>> +
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
