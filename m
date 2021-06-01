Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4C539743E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbhFANdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:33:18 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44770 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbhFANdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:33:16 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 114482192F;
        Tue,  1 Jun 2021 13:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622554294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kxolnSznagQnuCu9jRXmV8OGgEUIUpt0/kwE2bQdQw=;
        b=ugGTMWzjk3Hrq4+70ol/sxlPSoaxjtn7/6IhPdg6oU6rHD+JFLmPkCxXREZgJfsFif8OnD
        8U7v4kX54bXwhFw9DCU+mS6PLfLhFZ1Bexo2ME7gM3n9m9Fui+RZ++vSYJyYf39JyQVVxA
        t16vytLtFeJmG/XGl3K4S9IHd1EFLj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622554294;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kxolnSznagQnuCu9jRXmV8OGgEUIUpt0/kwE2bQdQw=;
        b=v8l0nBCKYhztJYN/oYLYY3uCkfL4O7/e0Tv+BYHGphqXBqULrR8xjS5kZXSK1iOCPuUHXG
        //nnHvQ7HobS/rCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id D8AA5118DD;
        Tue,  1 Jun 2021 13:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1622554294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kxolnSznagQnuCu9jRXmV8OGgEUIUpt0/kwE2bQdQw=;
        b=ugGTMWzjk3Hrq4+70ol/sxlPSoaxjtn7/6IhPdg6oU6rHD+JFLmPkCxXREZgJfsFif8OnD
        8U7v4kX54bXwhFw9DCU+mS6PLfLhFZ1Bexo2ME7gM3n9m9Fui+RZ++vSYJyYf39JyQVVxA
        t16vytLtFeJmG/XGl3K4S9IHd1EFLj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1622554294;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kxolnSznagQnuCu9jRXmV8OGgEUIUpt0/kwE2bQdQw=;
        b=v8l0nBCKYhztJYN/oYLYY3uCkfL4O7/e0Tv+BYHGphqXBqULrR8xjS5kZXSK1iOCPuUHXG
        //nnHvQ7HobS/rCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id aFY0NLU2tmCACQAALh3uQQ
        (envelope-from <vbabka@suse.cz>); Tue, 01 Jun 2021 13:31:33 +0000
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, greg@kroah.com, glittao@gmail.com
Cc:     vinmenon@codeaurora.org
References: <1622542057-14632-1-git-send-email-faiyazm@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v8] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <8c6db046-9f12-e670-8fe0-6d34f9328a52@suse.cz>
Date:   Tue, 1 Jun 2021 15:31:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <1622542057-14632-1-git-send-email-faiyazm@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/21 12:07 PM, Faiyaz Mohammed wrote:
> alloc_calls and free_calls implementation in sysfs have two issues,
> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
> to "one value per file" rule.
> 
> To overcome this issues, move the alloc_calls and free_calls implemeation
> to debugfs.
> 
> Debugfs cache will be created if SLAB_STORE_USER flag is set.
> 
> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> to be inline with what it does.
> 
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>

When reading the files I'm getting dmesg errors like this:

[   37.998152] seq_file: buggy .next function slab_debugfs_next did not update
position index

Don't recall this from previous versions?

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index a4a5714..ca39e84 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -449,6 +449,7 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>  	rcu_barrier();
>  
>  	list_for_each_entry_safe(s, s2, &to_destroy, list) {
> +		debugfs_slab_release(s);

You should remove this one, you already do the release when queueing the work
below. This is not like sysfs where we distinguish _unlink() when queueing and
_release when processing the work.

> +static struct dentry *slab_debugfs_root;
> +struct loc_track t = { 0, 0, NULL };

Ooops, this can't be a global variable, especially when shared without any lock
protection - but even with a protection it would be very suboptimal. You'll need
to make it a seq_file private, see e.g. here for an example:
https://lore.kernel.org/linux-mm/20210521121127.24653-3-glittao@gmail.com/

>  static void free_loc_track(struct loc_track *t)
>  {
>  	if (t->max)
> @@ -4825,82 +4840,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
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
> @@ -5350,21 +5290,6 @@ static ssize_t validate_store(struct kmem_cache *s,
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
> @@ -5528,8 +5453,6 @@ static struct attribute *slab_attrs[] = {
>  	&poison_attr.attr,
>  	&store_user_attr.attr,
>  	&validate_attr.attr,
> -	&alloc_calls_attr.attr,
> -	&free_calls_attr.attr,
>  #endif
>  #ifdef CONFIG_ZONE_DMA
>  	&cache_dma_attr.attr,
> @@ -5818,6 +5741,203 @@ static int __init slab_sysfs_init(void)
>  __initcall(slab_sysfs_init);
>  #endif /* CONFIG_SYSFS */
>  
> +#if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
> +static int slab_debugfs_show(struct seq_file *seq, void *v)
> +{
> +
> +	struct location *l;
> +	unsigned int idx = *(unsigned int *)v;
> +
> +	if (idx < t.count) {
> +		l = &t.loc[idx];
> +
> +		seq_printf(seq, "%7ld ", l->count);
> +
> +		if (l->addr)
> +			seq_printf(seq, "%pS", (void *)l->addr);
> +		else
> +			seq_puts(seq, "<not-available>");
> +
> +		if (l->sum_time != l->min_time) {
> +			seq_printf(seq, " age=%ld/%ld/%ld",
> +				l->min_time,
> +				(long)div_u64(l->sum_time, l->count),
> +				l->max_time);
> +		} else
> +			seq_printf(seq, " age=%ld",
> +				l->min_time);
> +
> +		if (l->min_pid != l->max_pid)
> +			seq_printf(seq, " pid=%ld-%ld",
> +				l->min_pid, l->max_pid);
> +		else
> +			seq_printf(seq, " pid=%ld",
> +				l->min_pid);
> +
> +		if (num_online_cpus() > 1 &&
> +				!cpumask_empty(to_cpumask(l->cpus)))
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
> +	if (t.count == 0)
> +		seq_puts(seq, "No data\n");
> +
> +	return 0;
> +}
> +
> +static void slab_debugfs_stop(struct seq_file *seq, void *v)
> +{
> +	if (!v && t.max) {
> +		free_loc_track(&t);
> +		t.max = 0;
> +	}
> +}
> +
> +static void *slab_debugfs_next(struct seq_file *seq, void *v, loff_t *ppos)
> +{
> +	loff_t *spos = v;
> +
> +	if (*ppos < t.count) {
> +		*spos = *spos + 1;
> +		*ppos = *spos;
> +		return spos;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void *slab_debugfs_start(struct seq_file *seq, loff_t *ppos)
> +{
> +	struct kmem_cache_node *n;
> +	struct kmem_cache *s;
> +	enum track_item alloc;
> +	int node;
> +	loff_t *spos = kmalloc(sizeof(loff_t), GFP_KERNEL);
> +
> +	s = seq->file->f_inode->i_private;
> +
> +	if (!spos)
> +		return NULL;
> +
> +	if (*ppos == 0) {
> +
> +		t.count = 0;
> +		t.max = 0;
> +		t.loc = NULL;
> +		if (strcmp(seq->file->f_path.dentry->d_name.name, "alloc_traces") == 0)
> +			alloc =  TRACK_ALLOC;
> +		else
> +			alloc =  TRACK_FREE;
> +
> +		if (!alloc_loc_track(&t, PAGE_SIZE / sizeof(struct location),
> +			     GFP_KERNEL)) {
> +			seq_puts(seq, "Out of memory\n");
> +			kfree(spos);
> +			return ERR_PTR(-ENOMEM);
> +		}
> +		/* Push back cpu slabs */
> +		flush_all(s);
> +
> +		for_each_kmem_cache_node(s, node, n) {
> +			unsigned long flags;
> +			struct page *page;
> +
> +			if (!atomic_long_read(&n->nr_slabs))
> +				continue;
> +
> +			spin_lock_irqsave(&n->list_lock, flags);
> +			list_for_each_entry(page, &n->partial, slab_list)
> +				process_slab(&t, s, page, alloc);
> +			list_for_each_entry(page, &n->full, slab_list)
> +				process_slab(&t, s, page, alloc);
> +			spin_unlock_irqrestore(&n->list_lock, flags);
> +		}
> +	}
> +
> +	if (*ppos < t.count) {
> +		*spos = *ppos;
> +		return spos;
> +	}
> +
> +	kfree(spos);
> +	return NULL;
> +}
> +
> +static const struct seq_operations slab_debugfs_sops = {
> +	.start  = slab_debugfs_start,
> +	.next   = slab_debugfs_next,
> +	.stop   = slab_debugfs_stop,
> +	.show   = slab_debugfs_show
> +};
> +DEFINE_SEQ_ATTRIBUTE(slab_debugfs);
> +
> +static void debugfs_slab_add(struct kmem_cache *s)
> +{
> +	const char *name;
> +	struct dentry *slab_cache_dir;
> +	int unmergeable = slab_unmergeable(s);
> +
> +	if (unlikely(!slab_debugfs_root))
> +		return;
> +
> +	if (!unmergeable && disable_higher_order_debug &&
> +			(slub_debug & DEBUG_METADATA_FLAGS))
> +		unmergeable = 1;
> +
> +	if (unmergeable) {
> +		/*
> +		 * Slabcache can never be merged so we can use the name proper.
> +		 * This is typically the case for debug situations. In that
> +		 * case we can catch duplicate names easily.
> +		 */
> +		slab_cache_dir = debugfs_lookup(s->name, slab_debugfs_root);
> +		debugfs_remove_recursive(slab_cache_dir);
> +		name = s->name;
> +	} else {
> +		/*
> +		 * Create a unique name for the slab as a target
> +		 * for the symlinks.
> +		 */
> +		name = create_unique_id(s);
> +	}
> +
> +	slab_cache_dir = debugfs_create_dir(name, slab_debugfs_root);
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
> +	debugfs_remove_recursive(debugfs_lookup(s->name,
> +					slab_debugfs_root));
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

