Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB3F35A426
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbhDIQ4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbhDIQ4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:56:50 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6556BC061760
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:56:34 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id f12so4671668qtq.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=POOCHVwoWV+oDH/jdCXa9tXzaUA3TQk2iGCKYM9Uyys=;
        b=u9vj5iafkdFIMTZcPz002uALu+ZkrxBDdohbWl1nuv0RsEjjMdJZGbPO15H4hhHGhP
         9YABL3Q/nTbDhQYaaq/spMx86cd+1hQvnRgOsKTAI2EV4yyYvAT31I6m0x96aW8NLkHp
         9i0R8oKwHdkVcyTR8pCYMzLFr3hFgzfqOxbOrPTQUbgVPc14bLwKbaJbEQbO1E+noEoz
         hPPQdwP1zr0YeYHoBcTskcbfjYm0RjYktnDyubT4WWPGopcAkzHmhKOHN/cPOXjaUVcE
         nB93izEkT3JEDS2/6UlRgKmuERa1fiM6O6sSjh80k50iiwlODg0DCknfpassTmwQfs1f
         /uUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=POOCHVwoWV+oDH/jdCXa9tXzaUA3TQk2iGCKYM9Uyys=;
        b=EtvlPUXdF4W45uWsTgUbUnEjWTrxTOcao5SLkfcd/hVzpXYQQfrHSWzlLtjBiJ3niU
         /nYbTcayKdSoM/jwsmYm4S42Tw4S+oix4RGneMKPqNNbcboi1p16UqcNYyPj5FIaxnPz
         z9Igw6LL9hlxGC5JjzlVkyXx3vX3HOrxBpXDYSwQ2K5CXiBW36WvebKnKgTPM9mjMGrB
         ItdFpxx4oZ2RmmUmz+kUDppTD7ou+nLO50WyeR6WpUz8LUpHddaAOMhB41rF0oWfe/3I
         dg/IgQrbilHo+a5U68ZMy+k4+8PdbbVtjCaUP6poA49TwdDmA3tQAymQOt/EXeXsYwpy
         7+OQ==
X-Gm-Message-State: AOAM532ct2hnfI88mVf5il4fPHVAL9JeDx1FdpkhVgbXrniW4iUKZ+wn
        RA3H0GYgl6PI2trpNNHLBeGP+g==
X-Google-Smtp-Source: ABdhPJwW1btDvToXxdgF6Q6GZEBvleDAa5L7g9wL3mfLaUFhXkZTdoKOD6L5nFsmRZZURyomUSQ9CQ==
X-Received: by 2002:a05:622a:50c:: with SMTP id l12mr12881615qtx.44.1617987393622;
        Fri, 09 Apr 2021 09:56:33 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id h16sm2278486qkh.18.2021.04.09.09.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:56:33 -0700 (PDT)
Date:   Fri, 9 Apr 2021 12:56:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com
Subject: Re: [RFC PATCH v2 06/18] mm: memcontrol: move the objcg
 infrastructure out of CONFIG_MEMCG_KMEM
Message-ID: <YHCHQHrCj6rH1sD3@cmpxchg.org>
References: <20210409122959.82264-1-songmuchun@bytedance.com>
 <20210409122959.82264-7-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409122959.82264-7-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 08:29:47PM +0800, Muchun Song wrote:
> Because memory allocations pinning memcgs for a long time - it exists
> at a larger scale and is causing recurring problems in the real world:
> page cache doesn't get reclaimed for a long time, or is used by the
> second, third, fourth, ... instance of the same job that was restarted
> into a new cgroup every time. Unreclaimable dying cgroups pile up,
> waste memory, and make page reclaim very inefficient.
> 
> We can convert LRU pages and most other raw memcg pins to the objcg
> direction to fix this problem, and then the page->memcg will always
> point to an object cgroup pointer.
> 
> Therefore, the infrastructure of objcg no longer only serves
> CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
> objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
> can reuse it to charge pages.

Just an observation on this:

We actually may want to remove CONFIG_MEMCG_KMEM altogether at this
point. It used to be an optional feature, but nowadays it's not
configurable anymore, and always on unless slob is configured.

We've also added more than just slab accounting to it, like kernel
stack pages, and it all gets disabled on slob configs just because it
doesn't support slab object tracking.

We could probably replace CONFIG_MEMCG_KMEM with CONFIG_MEMCG in most
places, and add a couple of !CONFIG_SLOB checks in the slab callbacks.

But that's beyond the scope of your patch series, so I'm also okay
with this patch here.

> We know that the LRU pages are not accounted at the root level. But the
> page->memcg_data points to the root_mem_cgroup. So the page->memcg_data
> of the LRU pages always points to a valid pointer. But the root_mem_cgroup
> dose not have an object cgroup. If we use obj_cgroup APIs to charge the
> LRU pages, we should set the page->memcg_data to a root object cgroup. So
> we also allocate an object cgroup for the root_mem_cgroup and introduce
> root_obj_cgroup to cache its value just like root_mem_cgroup.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Overall, the patch makes sense to me. A few comments below:

> @@ -252,9 +253,14 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
>  	return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
>  }
>  
> -#ifdef CONFIG_MEMCG_KMEM
>  extern spinlock_t css_set_lock;
>  
> +static inline bool obj_cgroup_is_root(struct obj_cgroup *objcg)
> +{
  > +	return objcg == root_obj_cgroup;
> +}

This function, and by extension root_obj_cgroup, aren't used by this
patch. Please move them to the patch that adds users for them.

> @@ -298,6 +304,20 @@ static void obj_cgroup_release(struct percpu_ref *ref)
>  	percpu_ref_exit(ref);
>  	kfree_rcu(objcg, rcu);
>  }
> +#else
> +static void obj_cgroup_release(struct percpu_ref *ref)
> +{
> +	struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&css_set_lock, flags);
> +	list_del(&objcg->list);
> +	spin_unlock_irqrestore(&css_set_lock, flags);
> +
> +	percpu_ref_exit(ref);
> +	kfree_rcu(objcg, rcu);
> +}
> +#endif

Having two separate functions for if and else is good when the else
branch is a completely empty dummy function. In this case you end up
duplicating code, so it's better to have just one function and put the
ifdef around the nr_charged_bytes handling in it.

> @@ -318,10 +338,14 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
>  	return objcg;
>  }
>  
> -static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
> -				  struct mem_cgroup *parent)
> +static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
>  {
>  	struct obj_cgroup *objcg, *iter;
> +	struct mem_cgroup *parent;
> +
> +	parent = parent_mem_cgroup(memcg);
> +	if (!parent)
> +		parent = root_mem_cgroup;
>  
>  	objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
>  
> @@ -342,6 +366,27 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
>  	percpu_ref_kill(&objcg->refcnt);
>  }
>  
> +static int memcg_obj_cgroup_alloc(struct mem_cgroup *memcg)
> +{
> +	struct obj_cgroup *objcg;
> +
> +	objcg = obj_cgroup_alloc();
> +	if (!objcg)
> +		return -ENOMEM;
> +
> +	objcg->memcg = memcg;
> +	rcu_assign_pointer(memcg->objcg, objcg);
> +
> +	return 0;
> +}
> +
> +static void memcg_obj_cgroup_free(struct mem_cgroup *memcg)
> +{
> +	if (unlikely(memcg->objcg))
> +		memcg_reparent_objcgs(memcg);
> +}

It's confusing to have a 'free' function not free the object it's
called on.

But rather than search for a fitting name, I think it might be better
to just fold both of these short functions into their only callsites.

Also, since memcg->objcg is reparented, and the pointer cleared, on
offlining, when could this ever be non-NULL? This deserves a comment.

> @@ -3444,7 +3489,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
>  #ifdef CONFIG_MEMCG_KMEM
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
>  {
> -	struct obj_cgroup *objcg;
>  	int memcg_id;
>  
>  	if (cgroup_memory_nokmem)
> @@ -3457,14 +3501,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
>  	if (memcg_id < 0)
>  		return memcg_id;
>  
> -	objcg = obj_cgroup_alloc();
> -	if (!objcg) {
> -		memcg_free_cache_id(memcg_id);
> -		return -ENOMEM;
> -	}
> -	objcg->memcg = memcg;
> -	rcu_assign_pointer(memcg->objcg, objcg);
> -
>  	static_branch_enable(&memcg_kmem_enabled_key);
>  
>  	memcg->kmemcg_id = memcg_id;
> @@ -3488,7 +3524,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
>  	if (!parent)
>  		parent = root_mem_cgroup;
>  
> -	memcg_reparent_objcgs(memcg, parent);
> +	memcg_reparent_objcgs(memcg);

Since the objcg is no longer tied to kmem, this should move to
mem_cgroup_css_offline() instead.
