Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8503879ED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244616AbhERNaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:30:01 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:36009 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241144AbhERN37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:29:59 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 9E28A1355;
        Tue, 18 May 2021 09:28:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 18 May 2021 09:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=5sNCjnsFLWuEKWENPV5fxNZgst6
        i2pbsLzwwf5x1z0s=; b=Ixy7iumjFKsgwwM8e6bJ+UUCe2BjYoCqe1MAg0bSa+u
        ZUP7SrA/qSgqTFudnbqt26ssXo7dvd5AOYyfHHv7Bpfpa6idNyYJZxkWJ9YyPNlt
        r81vsS60+IEq8hp18uTxQaIxkxZfVIBwUWcGSEcqW/z2tN7cI3XtnlZ5elwmmVHT
        DRT2YQchzf4CXAzdv+FaL7/pvzY/C4RA/nDPLag1mIqSp/RlQvrt0Z7ji3IGTvwS
        VA9tKPgmylC4nLBJ52EKOdLs4k1McLw4Mu+MrjAOEzLZjGZfBIQxUzeMLwRYxlYT
        Po73ydKiQNo1hReA1K0E5JsSv+X3TNAVmL3A1RS+IXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=5sNCjn
        sFLWuEKWENPV5fxNZgst6i2pbsLzwwf5x1z0s=; b=cSRxYWGhlozFYOcn+iuPzv
        KFLRDMzs7P/nkrYbHV1IP6bJaamw4wixddJTDbjunDmUVnoO6GjAPOyt4L2WWL5J
        9k7NnppRDWgZ8metqS2uEvGRS91Mg9gYyKd9zKiJPEMSzwm3IWsc0FeNQeFxLFpD
        3hOXdYeLrHtI3zYzNtxzX38a3/TvWj2G72hQ/9rJHBeYT+VSMgfJwpmp/DvPl62G
        UFUilqHfQaMN1f/ndxGMmrADqmGHRKjn18S1egWu9qPUIo4OFjB+UwTB/Af/IJK1
        /yJu5hwkpSN5YI0vcuhSIXOPai14fQt84xEVd4aKTQgh8XeC8caKWJ0+g9WLi/WQ
        ==
X-ME-Sender: <xms:BMGjYM1vrFxRPnpa8yqyszBAHVwC3onqW3q22q1Fg4ugvSIJew_bQQ>
    <xme:BMGjYHHkz4A6OpYppKKPeRNRK8aQm1vZ2o4oWwuiCvygngvNGYQ6ACuGYUS8V8hKe
    21s-rDt8ejIgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeijedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeevueehje
    fgfffgiedvudekvdektdelleelgefhleejieeugeegveeuuddukedvteenucfkphepkeef
    rdekiedrjeegrdeigeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:BMGjYE4iTi0yWrDi5xxR-tRGyPzqMjCLa5ZcQjfzEhNZEgUu4tTX_w>
    <xmx:BMGjYF0b4gVzJQpc170_NM6GQJPjM1w6RpilvXKAJ_-a1O8KGeMLNQ>
    <xmx:BMGjYPH42sEENihdYaVN7ovgk14X27CbX6rtk0lg_GD4ke2kciaAKw>
    <xmx:B8GjYLK9yFTZYwlyKD6bgTr6wPGxkN2KkFmY06yYizvgms0TjvnDvP50h4Q>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 18 May 2021 09:28:35 -0400 (EDT)
Date:   Tue, 18 May 2021 15:28:33 +0200
From:   Greg KH <greg@kroah.com>
To:     Faiyaz Mohammed <faiyazm@codeaurora.org>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        glittao@gmail.com, vinmenon@codeaurora.org
Subject: Re: [PATCH v6] mm: slub: move sysfs slab alloc/free interfaces to
 debugfs
Message-ID: <YKPBAVRPq2JUliNO@kroah.com>
References: <1621341949-26762-1-git-send-email-faiyazm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621341949-26762-1-git-send-email-faiyazm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 06:15:49PM +0530, Faiyaz Mohammed wrote:
> alloc_calls and free_calls implementation in sysfs have two issues,
> one is PAGE_SIZE limitiation of sysfs and other is it does not adhere
> to "one value per file" rule.
> 
> To overcome this issues, move the alloc_calls and free_calls implemeation
> to debugfs.
> 
> Rename the alloc_calls/free_calls to alloc_traces/free_traces,
> to be inline with what it does.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Faiyaz Mohammed <faiyazm@codeaurora.org>
> ---
>  include/linux/slub_def.h |   8 ++
>  mm/slab_common.c         |   9 ++
>  mm/slub.c                | 359 ++++++++++++++++++++++++++++++++++++-----------
>  3 files changed, 294 insertions(+), 82 deletions(-)
> 
> diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
> index dcde82a..b413ebe 100644
> --- a/include/linux/slub_def.h
> +++ b/include/linux/slub_def.h
> @@ -159,6 +159,14 @@ static inline void sysfs_slab_release(struct kmem_cache *s)
>  }
>  #endif
>  
> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
> +#define SLAB_SUPPORTS_DEBUGFS
> +void debugfs_slab_release(struct kmem_cache *);
> +#else
> +static inline void debugfs_slab_release(struct kmem_cache *s)
> +{
> +}
> +#endif
>  void object_err(struct kmem_cache *s, struct page *page,
>  		u8 *object, char *reason);
>  
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index a4a5714..873dd79 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -455,6 +455,9 @@ static void slab_caches_to_rcu_destroy_workfn(struct work_struct *work)
>  #else
>  		slab_kmem_cache_release(s);
>  #endif
> +#ifdef SLAB_SUPPORTS_DEBUGFS
> +		debugfs_slab_release(s);
> +#endif

If you write your .h file correctly, there's no need for #ifdef in .c
files.  Please fix this up, it shoudl be trivial given the above changes
in the .h file.


>  	}
>  }
>  
> @@ -472,6 +475,9 @@ static int shutdown_cache(struct kmem_cache *s)
>  #ifdef SLAB_SUPPORTS_SYSFS
>  		sysfs_slab_unlink(s);
>  #endif
> +#ifdef SLAB_SUPPORTS_DEBUGFS
> +		debugfs_slab_release(s);
> +#endif
>  		list_add_tail(&s->list, &slab_caches_to_rcu_destroy);
>  		schedule_work(&slab_caches_to_rcu_destroy_work);
>  	} else {
> @@ -482,6 +488,9 @@ static int shutdown_cache(struct kmem_cache *s)
>  #else
>  		slab_kmem_cache_release(s);
>  #endif
> +#ifdef SLAB_SUPPORTS_DEBUGFS
> +		debugfs_slab_release(s);
> +#endif
>  	}
>  
>  	return 0;
> diff --git a/mm/slub.c b/mm/slub.c
> index 438fa8d..f470a29 100644
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
> @@ -225,6 +226,15 @@ static inline int sysfs_slab_alias(struct kmem_cache *s, const char *p)
>  							{ return 0; }
>  #endif
>  
> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_SLUB_DEBUG)
> +static void debugfs_slab_add(struct kmem_cache *);
> +static int debugfs_slab_alias(struct kmem_cache *, const char *);

Why does this have to return an int?  What are you going to do if it
fails?

> +#else
> +static inline void debugfs_slab_add(struct kmem_cache *s) { }
> +static inline int debugfs_slab_alias(struct kmem_cache *s, const char *p)
> +							{ return 0; }
> +#endif
> +
>  static inline void stat(const struct kmem_cache *s, enum stat_item si)
>  {
>  #ifdef CONFIG_SLUB_STATS
> @@ -4524,6 +4534,8 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>  			s->refcount--;
>  			s = NULL;
>  		}
> +
> +		debugfs_slab_alias(s, name);

See, like you do so here.

>  	}
>  
>  	return s;
> @@ -4545,6 +4557,8 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
>  	if (err)
>  		__kmem_cache_release(s);
>  
> +	debugfs_slab_add(s);
> +
>  	return err;
>  }
>  
> @@ -4685,6 +4699,8 @@ static long validate_slab_cache(struct kmem_cache *s)
>  
>  	return count;
>  }
> +
> +#ifdef CONFIG_DEBUG_FS
>  /*
>   * Generate lists of code addresses where slabcache objects are allocated
>   * and freed.
> @@ -4708,6 +4724,9 @@ struct loc_track {
>  	struct location *loc;
>  };
>  
> +static struct dentry *slab_debugfs_root;
> +struct loc_track t = { 0, 0, NULL };
> +
>  static void free_loc_track(struct loc_track *t)
>  {
>  	if (t->max)
> @@ -4824,82 +4843,7 @@ static void process_slab(struct loc_track *t, struct kmem_cache *s,
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
> @@ -5351,17 +5295,25 @@ SLAB_ATTR(validate);
>  
>  static ssize_t alloc_calls_show(struct kmem_cache *s, char *buf)
>  {
> -	if (!(s->flags & SLAB_STORE_USER))
> -		return -ENOSYS;
> -	return list_locations(s, buf, TRACK_ALLOC);
> +	int len = 0;
> +
> +	len += sprintf(buf + len, "Deprecated, use the equvalent under\n");
> +	len += sprintf(buf + len, "<debugfs_mount_point>/slab/%s/alloc_traces\n",
> +			s->name);

No, just drop the sysfs file.  Userspace ALWAYS has to be able to handle
a sysfs file present or not present, that's the way sysfs operates and
why we have "one value per file".

If userspace can not handle it, well, someone messed up and printing a
huge message like this is not going to help either, just return an
error.

> +
> +	return len;
>  }
>  SLAB_ATTR_RO(alloc_calls);
>  
>  static ssize_t free_calls_show(struct kmem_cache *s, char *buf)
>  {
> -	if (!(s->flags & SLAB_STORE_USER))
> -		return -ENOSYS;
> -	return list_locations(s, buf, TRACK_FREE);
> +	int len = 0;
> +
> +	len += sprintf(buf + len, "Deprecated, use the equvalent under\n");
> +	len += sprintf(buf + len, "<debugfs_mount_point>/slab/%s/alloc_traces\n",
> +			s->name);

Same here, drop it please.

> +
> +	return len;
>  }
>  SLAB_ATTR_RO(free_calls);
>  #endif /* CONFIG_SLUB_DEBUG */
> @@ -5817,6 +5769,249 @@ static int __init slab_sysfs_init(void)
>  __initcall(slab_sysfs_init);
>  #endif /* CONFIG_SYSFS */
>  
> +#if defined(CONFIG_SLUB_DEBUG) && defined(CONFIG_DEBUG_FS)
> +static int debugfs_slab_alias(struct kmem_cache *s, const char *name)
> +{
> +	struct saved_alias *al;
> +	struct dentry *slab_cache_dir;
> +
> +	if (slab_state == FULL) {
> +		/*
> +		 * If we have a leftover link then remove it.
> +		 */
> +		slab_cache_dir = debugfs_lookup(s->name, slab_debugfs_root);
> +		debugfs_remove(slab_cache_dir);
> +		debugfs_create_symlink(name, slab_debugfs_root, NULL);
> +	}
> +
> +	al = kmalloc(sizeof(struct saved_alias), GFP_KERNEL);
> +	if (!al)
> +		return -ENOMEM;

Why do you care if you have no memory or not?

> +
> +	al->s = s;
> +	al->name = name;
> +	al->next = alias_list;
> +	alias_list = al;
> +	return 0;
> +}
> +
> +static int slab_debugfs_show(struct seq_file *seq, void *v)
> +{
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
> +	if (!(s->flags & SLAB_STORE_USER)) {
> +		kfree(spos);
> +		return ERR_PTR(-EOPNOTSUPP);
> +	}
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
> +
> +	if (!unmergeable)
> +		/* Setup first alias */
> +		debugfs_slab_alias(s, s->name);
> +}
> +
> +void debugfs_slab_release(struct kmem_cache *s)
> +{
> +	struct dentry *slab_cache_dir;
> +
> +	slab_cache_dir = debugfs_lookup(s->name, slab_debugfs_root);
> +	debugfs_remove_recursive(slab_cache_dir);

This whole function can be 1 line long, right?

> +}
> +
> +static int __init slab_debugfs_init(void)
> +{
> +	struct kmem_cache *s;
> +
> +	slab_debugfs_root = debugfs_create_dir("slab", NULL);
> +
> +	slab_state = FULL;
> +
> +	list_for_each_entry(s, &slab_caches, list)
> +		debugfs_slab_add(s);
> +
> +	while (alias_list) {
> +		struct saved_alias *al = alias_list;
> +
> +		alias_list = alias_list->next;

Why isn't this a "normal" linked list?

thanks,

greg k-h
