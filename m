Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF33735B1E7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 08:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbhDKGZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 02:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhDKGZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 02:25:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD47C061574
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 23:24:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z22-20020a17090a0156b029014d4056663fso5310577pje.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Apr 2021 23:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZU/zzhJUZ4M4YMsK8aEsYeoEHlx9HrupSDSHAYxx9F4=;
        b=a0ap3PRI9gljeJVT0H1HyuuTzKbhoQlydNntQ6LkHaSSzuaJFL81AJO2AW+6bzjvaB
         yTpY9tpX9glHTcp4igj27sTO8wIvFqdU6yKJYEIUmb56wS3W6EPERoxQ8rYPT+tO6zlV
         yX2QtoMMu7kD691blmGz2jEUkU750xjlx34wI88Fo0B6MsFZb2Myu7Y7P3zaFLNZ6wEB
         cEVtE1dIr9y2/qCYNSNA93+/Ro1sTncUeKRTnyBDv6ZgkmOenl9Pg6BDBxE4f1rXPf+c
         j1Fqv5iKi6QtDkH06kSHR42SHi+4i+E5F7QhJxWC20KGoSxWOkQJRykwzYcqHPlSSHoc
         CSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZU/zzhJUZ4M4YMsK8aEsYeoEHlx9HrupSDSHAYxx9F4=;
        b=lhuGkjrjsTkReAkvrsn3jOnOwVUuZUL72ihsMv22n5UAHjoOEmFI7Td21zSWxt44Av
         I1DdfYcHtzlQhzmD3kdVA88mid+ppp2VQ00zxyPu2MBbfMUMhc3pHnDkH/1LF09e5sJz
         T98X55FU3WWDk4zQUDj6/4qMZqoLnoJxaAqHCAnb+oqmZccxmPjp7tZ1md7BNndRMcev
         NufRVxYhJWoMBng3uZ9tzeEzsrSJozn/fAEslgugcEzN9qiq08yc2s082YuIIEGAJQGV
         NpX6slej2mBee6UkcNv3g6F4v8L9bmrNidFViZyuEtHGDyEy6b/oHTT+qffg44a0N0x8
         algQ==
X-Gm-Message-State: AOAM530lVgqDFcDxV228Ef0s6p04Il1Pp44ndDxdOYGJxZ35JQve0cUV
        sVVcE3bQEsDl+2yPzUrrJvUf73vUb10cjb1UDZKQdA==
X-Google-Smtp-Source: ABdhPJzWbIhNmiud0ovMQll9Xmo28fr5lNxq35QlvcIm31hsXGcAMqYnHwKnbcLhcB2Ls9XV79OQk+HXAdQrGbD5NzE=
X-Received: by 2002:a17:90a:901:: with SMTP id n1mr22487174pjn.147.1618122286375;
 Sat, 10 Apr 2021 23:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210409122959.82264-1-songmuchun@bytedance.com>
 <20210409122959.82264-7-songmuchun@bytedance.com> <YHCHQHrCj6rH1sD3@cmpxchg.org>
In-Reply-To: <YHCHQHrCj6rH1sD3@cmpxchg.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 11 Apr 2021 14:24:09 +0800
Message-ID: <CAMZfGtUApSk35SYOxgnD8t_ryjVY9EOv58kQ_E1Qm5HkY7HZ3A@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH v2 06/18] mm: memcontrol: move the
 objcg infrastructure out of CONFIG_MEMCG_KMEM
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     guro@fb.com, mhocko@kernel.org, akpm@linux-foundation.org,
        shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        bsingharora@gmail.com, shy828301@gmail.com,
        alex.shi@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 12:56 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Fri, Apr 09, 2021 at 08:29:47PM +0800, Muchun Song wrote:
> > Because memory allocations pinning memcgs for a long time - it exists
> > at a larger scale and is causing recurring problems in the real world:
> > page cache doesn't get reclaimed for a long time, or is used by the
> > second, third, fourth, ... instance of the same job that was restarted
> > into a new cgroup every time. Unreclaimable dying cgroups pile up,
> > waste memory, and make page reclaim very inefficient.
> >
> > We can convert LRU pages and most other raw memcg pins to the objcg
> > direction to fix this problem, and then the page->memcg will always
> > point to an object cgroup pointer.
> >
> > Therefore, the infrastructure of objcg no longer only serves
> > CONFIG_MEMCG_KMEM. In this patch, we move the infrastructure of the
> > objcg out of the scope of the CONFIG_MEMCG_KMEM so that the LRU pages
> > can reuse it to charge pages.
>
> Just an observation on this:
>
> We actually may want to remove CONFIG_MEMCG_KMEM altogether at this
> point. It used to be an optional feature, but nowadays it's not
> configurable anymore, and always on unless slob is configured.
>
> We've also added more than just slab accounting to it, like kernel
> stack pages, and it all gets disabled on slob configs just because it
> doesn't support slab object tracking.
>
> We could probably replace CONFIG_MEMCG_KMEM with CONFIG_MEMCG in most
> places, and add a couple of !CONFIG_SLOB checks in the slab callbacks.
>
> But that's beyond the scope of your patch series, so I'm also okay
> with this patch here.
>
> > We know that the LRU pages are not accounted at the root level. But the
> > page->memcg_data points to the root_mem_cgroup. So the page->memcg_data
> > of the LRU pages always points to a valid pointer. But the root_mem_cgroup
> > dose not have an object cgroup. If we use obj_cgroup APIs to charge the
> > LRU pages, we should set the page->memcg_data to a root object cgroup. So
> > we also allocate an object cgroup for the root_mem_cgroup and introduce
> > root_obj_cgroup to cache its value just like root_mem_cgroup.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Overall, the patch makes sense to me. A few comments below:
>
> > @@ -252,9 +253,14 @@ struct cgroup_subsys_state *vmpressure_to_css(struct vmpressure *vmpr)
> >       return &container_of(vmpr, struct mem_cgroup, vmpressure)->css;
> >  }
> >
> > -#ifdef CONFIG_MEMCG_KMEM
> >  extern spinlock_t css_set_lock;
> >
> > +static inline bool obj_cgroup_is_root(struct obj_cgroup *objcg)
> > +{
>   > +   return objcg == root_obj_cgroup;
> > +}
>
> This function, and by extension root_obj_cgroup, aren't used by this
> patch. Please move them to the patch that adds users for them.

OK. Will do.

>
> > @@ -298,6 +304,20 @@ static void obj_cgroup_release(struct percpu_ref *ref)
> >       percpu_ref_exit(ref);
> >       kfree_rcu(objcg, rcu);
> >  }
> > +#else
> > +static void obj_cgroup_release(struct percpu_ref *ref)
> > +{
> > +     struct obj_cgroup *objcg = container_of(ref, struct obj_cgroup, refcnt);
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&css_set_lock, flags);
> > +     list_del(&objcg->list);
> > +     spin_unlock_irqrestore(&css_set_lock, flags);
> > +
> > +     percpu_ref_exit(ref);
> > +     kfree_rcu(objcg, rcu);
> > +}
> > +#endif
>
> Having two separate functions for if and else is good when the else
> branch is a completely empty dummy function. In this case you end up
> duplicating code, so it's better to have just one function and put the
> ifdef around the nr_charged_bytes handling in it.

Make sense. I will rework the code here.

>
> > @@ -318,10 +338,14 @@ static struct obj_cgroup *obj_cgroup_alloc(void)
> >       return objcg;
> >  }
> >
> > -static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
> > -                               struct mem_cgroup *parent)
> > +static void memcg_reparent_objcgs(struct mem_cgroup *memcg)
> >  {
> >       struct obj_cgroup *objcg, *iter;
> > +     struct mem_cgroup *parent;
> > +
> > +     parent = parent_mem_cgroup(memcg);
> > +     if (!parent)
> > +             parent = root_mem_cgroup;
> >
> >       objcg = rcu_replace_pointer(memcg->objcg, NULL, true);
> >
> > @@ -342,6 +366,27 @@ static void memcg_reparent_objcgs(struct mem_cgroup *memcg,
> >       percpu_ref_kill(&objcg->refcnt);
> >  }
> >
> > +static int memcg_obj_cgroup_alloc(struct mem_cgroup *memcg)
> > +{
> > +     struct obj_cgroup *objcg;
> > +
> > +     objcg = obj_cgroup_alloc();
> > +     if (!objcg)
> > +             return -ENOMEM;
> > +
> > +     objcg->memcg = memcg;
> > +     rcu_assign_pointer(memcg->objcg, objcg);
> > +
> > +     return 0;
> > +}
> > +
> > +static void memcg_obj_cgroup_free(struct mem_cgroup *memcg)
> > +{
> > +     if (unlikely(memcg->objcg))
> > +             memcg_reparent_objcgs(memcg);
> > +}
>
> It's confusing to have a 'free' function not free the object it's
> called on.
>
> But rather than search for a fitting name, I think it might be better
> to just fold both of these short functions into their only callsites.

OK. Will do.

>
> Also, since memcg->objcg is reparented, and the pointer cleared, on
> offlining, when could this ever be non-NULL? This deserves a comment.

css_alloc() failed, offlining didn't happen. In this case, memcg->objcg
could be non-NULL (Just like memcg_free_kmem() dose). I will move
memcg_obj_cgroup_alloc() to the mem_cgroup_css_online() so that
we do not need memcg_obj_cgroup_free.

>
> > @@ -3444,7 +3489,6 @@ static u64 mem_cgroup_read_u64(struct cgroup_subsys_state *css,
> >  #ifdef CONFIG_MEMCG_KMEM
> >  static int memcg_online_kmem(struct mem_cgroup *memcg)
> >  {
> > -     struct obj_cgroup *objcg;
> >       int memcg_id;
> >
> >       if (cgroup_memory_nokmem)
> > @@ -3457,14 +3501,6 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
> >       if (memcg_id < 0)
> >               return memcg_id;
> >
> > -     objcg = obj_cgroup_alloc();
> > -     if (!objcg) {
> > -             memcg_free_cache_id(memcg_id);
> > -             return -ENOMEM;
> > -     }
> > -     objcg->memcg = memcg;
> > -     rcu_assign_pointer(memcg->objcg, objcg);
> > -
> >       static_branch_enable(&memcg_kmem_enabled_key);
> >
> >       memcg->kmemcg_id = memcg_id;
> > @@ -3488,7 +3524,7 @@ static void memcg_offline_kmem(struct mem_cgroup *memcg)
> >       if (!parent)
> >               parent = root_mem_cgroup;
> >
> > -     memcg_reparent_objcgs(memcg, parent);
> > +     memcg_reparent_objcgs(memcg);
>
> Since the objcg is no longer tied to kmem, this should move to
> mem_cgroup_css_offline() instead.

LGTM, will do.

Thanks for your all suggestions.
