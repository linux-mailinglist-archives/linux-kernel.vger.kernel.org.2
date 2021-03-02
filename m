Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6631632A17C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1577427AbhCBGWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 01:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbhCBEM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 23:12:56 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE19C06178C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 20:11:44 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id m6so12998011pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 20:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dTU5hX7dSo+qETQUn1DDmLMvhq5bGDjnaqtqQ3lTy4=;
        b=qRqJ6bzZrq3wDEpaqKE31ddVUhORa9ffHHo+hMZlo1zzHy2oro2LDfpunQd8FtXF0z
         o833fopIeTIwDEOOhiEszwjp40I034ZrzAz7zm6KyypmznXRJuRgwa4d5aCRvqXVT3E7
         dJPq/CPZwOh1ShffR4eGEitb5ssMyB3o20nBzfLR944ri69GWGBjX8bK6He16T9vXUal
         VjK9RjD21uSzMQ9z83SrNCWs0301hWty5nH4MT8VkP+8JlgQIWJPcoLvfma28MjQEOTP
         2ehoyHz60W5I8k86mLBm+eAJCxb+VDZ3vn4wnpaQNZMGmJhz9MJv7ytJMNcPX7i15HpY
         4w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dTU5hX7dSo+qETQUn1DDmLMvhq5bGDjnaqtqQ3lTy4=;
        b=HcMiOPQoo8tC5IJnWh7ke8urkAnodn+Gzxzjcy+7dcxDDGoTVPPQajMLD5Xn7OP4kN
         EvlVTyByH6mC3zib4Au2GuBm+sFud4RPEUC5cfFEcSSC2Q6KgCTYlF+hi/CQe7UAAKA5
         rGM+R5kGNzSgOnR9cguzN6D1NSVzhoFJXPvgzwdu7M+f5xje53uE+2og2Lo1uud4f8Kh
         tUTD22HCmw+bbKV8wEOWm2dmbkyn0oJxQqWr0wjkudKi8HGW0d0tML1zIcohHTAY78tL
         UtvmYVXaA5PLatRvIR5CvATEl1lZdUrbDPzCokdFp1gdBQmZyboyl4RTocMOkG4fME22
         wzjw==
X-Gm-Message-State: AOAM532CIFazvGMDe9yL25gu2NY0tzsGH7XOg0T38UP8v07hw9acg/EX
        IKhgR+PUJTflM9kpwaC7+jW3PuMNnpFxDIR05DMt5Q==
X-Google-Smtp-Source: ABdhPJzXHPfHik31jsRovP0r1kGurXYWnLx7cNttscZk+8SPwt7O+TozGXumlX5XYg+eB0Mi7p1K0hRPQxEGm7BYQ3k=
X-Received: by 2002:a63:141e:: with SMTP id u30mr16780185pgl.31.1614658303424;
 Mon, 01 Mar 2021 20:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20210301062227.59292-1-songmuchun@bytedance.com>
 <20210301062227.59292-6-songmuchun@bytedance.com> <YD2U3rfjQ9fhx8pD@carbon.dhcp.thefacebook.com>
In-Reply-To: <YD2U3rfjQ9fhx8pD@carbon.dhcp.thefacebook.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 2 Mar 2021 12:11:06 +0800
Message-ID: <CAMZfGtUWQVy7Y9Os7T4e0d0R3G4wt7AOK9Knot8WMGaV02A8-Q@mail.gmail.com>
Subject: Re: [External] Re: [PATCH 5/5] mm: memcontrol: use object cgroup for
 remote memory cgroup charging
To:     Roman Gushchin <guro@fb.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 2, 2021 at 9:29 AM Roman Gushchin <guro@fb.com> wrote:
>
> On Mon, Mar 01, 2021 at 02:22:27PM +0800, Muchun Song wrote:
> > We spent a lot of energy to make slab accounting do not hold a refcount
> > to memory cgroup, so the dying cgroup can be freed as soon as possible
> > on cgroup offlined.
> >
> > But some users of remote memory cgroup charging (e.g. bpf and fsnotify)
> > hold a refcount to memory cgroup for charging to it later. Actually,
> > the slab core use obj_cgroup APIs for memory cgroup charing, so we can
> > hold a refcount to obj_cgroup instead of memory cgroup. In this case,
> > the infrastructure of remote meory charging also do not hold a refcount
> > to memory cgroup.
>
> -cc all except mm folks
>
> Same here, let's not switch the remote charging infra to objcg to save
> an ability to use it for user pages. If we have a real problem with bpf/...,
> let's solve it case by case.

How about rename current->active_memcg to current->active_memcg_data?
If the lowest bit of active_memcg_data  is one, it points to an object cgroup.
Otherwise, it points to a memoy cgroup. Just like page->memcg_data.
In this case, we can charge objects by using obj_cgroup APIs.
Just my thought.

Thanks.

>
> Thanks!
>
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  fs/buffer.c                          | 10 ++++--
> >  fs/notify/fanotify/fanotify.c        |  6 ++--
> >  fs/notify/fanotify/fanotify_user.c   |  2 +-
> >  fs/notify/group.c                    |  3 +-
> >  fs/notify/inotify/inotify_fsnotify.c |  8 ++---
> >  fs/notify/inotify/inotify_user.c     |  2 +-
> >  include/linux/bpf.h                  |  2 +-
> >  include/linux/fsnotify_backend.h     |  2 +-
> >  include/linux/memcontrol.h           | 15 ++++++++
> >  include/linux/sched.h                |  4 +--
> >  include/linux/sched/mm.h             | 28 +++++++--------
> >  kernel/bpf/syscall.c                 | 35 +++++++++----------
> >  kernel/fork.c                        |  2 +-
> >  mm/memcontrol.c                      | 66 ++++++++++++++++++++++++++++--------
> >  14 files changed, 121 insertions(+), 64 deletions(-)
> >
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 591547779dbd..cc99fcf66368 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -842,14 +842,16 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
> >       struct buffer_head *bh, *head;
> >       gfp_t gfp = GFP_NOFS | __GFP_ACCOUNT;
> >       long offset;
> > -     struct mem_cgroup *memcg, *old_memcg;
> > +     struct mem_cgroup *memcg;
> > +     struct obj_cgroup *objcg, *old_objcg;
> >
> >       if (retry)
> >               gfp |= __GFP_NOFAIL;
> >
> >       /* The page lock pins the memcg */
> >       memcg = page_memcg(page);
> > -     old_memcg = set_active_memcg(memcg);
> > +     objcg = get_obj_cgroup_from_mem_cgroup(memcg);
> > +     old_objcg = set_active_obj_cgroup(objcg);
> >
> >       head = NULL;
> >       offset = PAGE_SIZE;
> > @@ -868,7 +870,9 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size,
> >               set_bh_page(bh, page, offset);
> >       }
> >  out:
> > -     set_active_memcg(old_memcg);
> > +     set_active_obj_cgroup(old_objcg);
> > +     if (objcg)
> > +             obj_cgroup_put(objcg);
> >       return head;
> >  /*
> >   * In case anything failed, we just free everything we got.
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> > index 1192c9953620..04d24acfffc7 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -530,7 +530,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
> >       struct inode *dirid = fanotify_dfid_inode(mask, data, data_type, dir);
> >       const struct path *path = fsnotify_data_path(data, data_type);
> >       unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> > -     struct mem_cgroup *old_memcg;
> > +     struct obj_cgroup *old_objcg;
> >       struct inode *child = NULL;
> >       bool name_event = false;
> >
> > @@ -580,7 +580,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
> >               gfp |= __GFP_RETRY_MAYFAIL;
> >
> >       /* Whoever is interested in the event, pays for the allocation. */
> > -     old_memcg = set_active_memcg(group->memcg);
> > +     old_objcg = set_active_obj_cgroup(group->objcg);
> >
> >       if (fanotify_is_perm_event(mask)) {
> >               event = fanotify_alloc_perm_event(path, gfp);
> > @@ -608,7 +608,7 @@ static struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
> >               event->pid = get_pid(task_tgid(current));
> >
> >  out:
> > -     set_active_memcg(old_memcg);
> > +     set_active_obj_cgroup(old_objcg);
> >       return event;
> >  }
> >
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 9e0c1afac8bd..055ca36d4e0e 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -985,7 +985,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
> >       group->fanotify_data.user = user;
> >       group->fanotify_data.flags = flags;
> >       atomic_inc(&user->fanotify_listeners);
> > -     group->memcg = get_mem_cgroup_from_mm(current->mm);
> > +     group->objcg = get_obj_cgroup_from_current();
> >
> >       group->overflow_event = fanotify_alloc_overflow_event();
> >       if (unlikely(!group->overflow_event)) {
> > diff --git a/fs/notify/group.c b/fs/notify/group.c
> > index ffd723ffe46d..fac46b92c16f 100644
> > --- a/fs/notify/group.c
> > +++ b/fs/notify/group.c
> > @@ -24,7 +24,8 @@ static void fsnotify_final_destroy_group(struct fsnotify_group *group)
> >       if (group->ops->free_group_priv)
> >               group->ops->free_group_priv(group);
> >
> > -     mem_cgroup_put(group->memcg);
> > +     if (group->objcg)
> > +             obj_cgroup_put(group->objcg);
> >       mutex_destroy(&group->mark_mutex);
> >
> >       kfree(group);
> > diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> > index 1901d799909b..20835554819a 100644
> > --- a/fs/notify/inotify/inotify_fsnotify.c
> > +++ b/fs/notify/inotify/inotify_fsnotify.c
> > @@ -66,7 +66,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
> >       int ret;
> >       int len = 0;
> >       int alloc_len = sizeof(struct inotify_event_info);
> > -     struct mem_cgroup *old_memcg;
> > +     struct obj_cgroup *old_objcg;
> >
> >       if (name) {
> >               len = name->len;
> > @@ -81,12 +81,12 @@ int inotify_handle_inode_event(struct fsnotify_mark *inode_mark, u32 mask,
> >
> >       /*
> >        * Whoever is interested in the event, pays for the allocation. Do not
> > -      * trigger OOM killer in the target monitoring memcg as it may have
> > +      * trigger OOM killer in the target monitoring objcg as it may have
> >        * security repercussion.
> >        */
> > -     old_memcg = set_active_memcg(group->memcg);
> > +     old_objcg = set_active_obj_cgroup(group->objcg);
> >       event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
> > -     set_active_memcg(old_memcg);
> > +     set_active_obj_cgroup(old_objcg);
> >
> >       if (unlikely(!event)) {
> >               /*
> > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> > index c71be4fb7dc5..5b4de477fcac 100644
> > --- a/fs/notify/inotify/inotify_user.c
> > +++ b/fs/notify/inotify/inotify_user.c
> > @@ -649,7 +649,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
> >       oevent->name_len = 0;
> >
> >       group->max_events = max_events;
> > -     group->memcg = get_mem_cgroup_from_mm(current->mm);
> > +     group->objcg = get_obj_cgroup_from_current();
> >
> >       spin_lock_init(&group->inotify_data.idr_lock);
> >       idr_init(&group->inotify_data.idr);
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index cccaef1088ea..b6894e3cd095 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -158,7 +158,7 @@ struct bpf_map {
> >       u32 btf_value_type_id;
> >       struct btf *btf;
> >  #ifdef CONFIG_MEMCG_KMEM
> > -     struct mem_cgroup *memcg;
> > +     struct obj_cgroup *objcg;
> >  #endif
> >       char name[BPF_OBJ_NAME_LEN];
> >       u32 btf_vmlinux_value_type_id;
> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> > index e5409b83e731..d0303f634da6 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -220,7 +220,7 @@ struct fsnotify_group {
> >                                                * notification list is too
> >                                                * full */
> >
> > -     struct mem_cgroup *memcg;       /* memcg to charge allocations */
> > +     struct obj_cgroup *objcg;       /* objcg to charge allocations */
> >
> >       /* groups can define private fields here or use the void *private */
> >       union {
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 27043478220f..96e63ec7274a 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1642,6 +1642,7 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
> >  int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order);
> >  void __memcg_kmem_uncharge_page(struct page *page, int order);
> >
> > +struct obj_cgroup *get_obj_cgroup_from_mem_cgroup(struct mem_cgroup *memcg);
> >  struct obj_cgroup *get_obj_cgroup_from_current(void);
> >
> >  int obj_cgroup_charge(struct obj_cgroup *objcg, gfp_t gfp, size_t size);
> > @@ -1692,6 +1693,20 @@ static inline int memcg_cache_id(struct mem_cgroup *memcg)
> >  struct mem_cgroup *mem_cgroup_from_obj(void *p);
> >
> >  #else
> > +static inline
> > +struct obj_cgroup *get_obj_cgroup_from_mem_cgroup(struct mem_cgroup *memcg)
> > +{
> > +     return NULL;
> > +}
> > +
> > +static inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> > +{
> > +     return NULL;
> > +}
> > +
> > +static inline void obj_cgroup_put(struct obj_cgroup *objcg)
> > +{
> > +}
> >
> >  static inline int memcg_kmem_charge_page(struct page *page, gfp_t gfp,
> >                                        int order)
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index c2d488eddf85..75d5b571edcb 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1317,8 +1317,8 @@ struct task_struct {
> >  #endif
> >
> >  #ifdef CONFIG_MEMCG_KMEM
> > -     /* Used by memcontrol for targeted memcg charge: */
> > -     struct mem_cgroup               *active_memcg;
> > +     /* Used by memcontrol for targeted object cgroup charge: */
> > +     struct obj_cgroup               *active_objcg;
> >  #endif
> >
> >  #ifdef CONFIG_BLK_CGROUP
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index 64a72975270e..e713f4290914 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -295,36 +295,34 @@ static inline void memalloc_nocma_restore(unsigned int flags)
> >  #endif
> >
> >  #ifdef CONFIG_MEMCG_KMEM
> > -DECLARE_PER_CPU(struct mem_cgroup *, int_active_memcg);
> > +DECLARE_PER_CPU(struct obj_cgroup *, int_active_objcg);
> >  /**
> > - * set_active_memcg - Starts the remote memcg charging scope.
> > - * @memcg: memcg to charge.
> > + * set_active_obj_cgroup - Starts the remote object cgroup charging scope.
> > + * @objcg: object cgroup to charge.
> >   *
> > - * This function marks the beginning of the remote memcg charging scope. All the
> > - * __GFP_ACCOUNT allocations till the end of the scope will be charged to the
> > - * given memcg.
> > + * This function marks the beginning of the remote object cgroup charging scope.
> > + * All the __GFP_ACCOUNT allocations till the end of the scope will be charged
> > + * to the given object cgroup.
> >   *
> >   * NOTE: This function can nest. Users must save the return value and
> >   * reset the previous value after their own charging scope is over.
> >   */
> > -static inline struct mem_cgroup *
> > -set_active_memcg(struct mem_cgroup *memcg)
> > +static inline struct obj_cgroup *set_active_obj_cgroup(struct obj_cgroup *objcg)
> >  {
> > -     struct mem_cgroup *old;
> > +     struct obj_cgroup *old;
> >
> >       if (in_interrupt()) {
> > -             old = this_cpu_read(int_active_memcg);
> > -             this_cpu_write(int_active_memcg, memcg);
> > +             old = this_cpu_read(int_active_objcg);
> > +             this_cpu_write(int_active_objcg, objcg);
> >       } else {
> > -             old = current->active_memcg;
> > -             current->active_memcg = memcg;
> > +             old = current->active_objcg;
> > +             current->active_objcg = objcg;
> >       }
> >
> >       return old;
> >  }
> >  #else
> > -static inline struct mem_cgroup *
> > -set_active_memcg(struct mem_cgroup *memcg)
> > +static inline struct obj_cgroup *set_active_obj_cgroup(struct obj_cgroup *objcg)
> >  {
> >       return NULL;
> >  }
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index c859bc46d06c..1b078eddf083 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -390,37 +390,38 @@ void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock)
> >  }
> >
> >  #ifdef CONFIG_MEMCG_KMEM
> > -static void bpf_map_save_memcg(struct bpf_map *map)
> > +static void bpf_map_save_objcg(struct bpf_map *map)
> >  {
> > -     map->memcg = get_mem_cgroup_from_mm(current->mm);
> > +     map->objcg = get_obj_cgroup_from_current();
> >  }
> >
> > -static void bpf_map_release_memcg(struct bpf_map *map)
> > +static void bpf_map_release_objcg(struct bpf_map *map)
> >  {
> > -     mem_cgroup_put(map->memcg);
> > +     if (map->objcg)
> > +             obj_cgroup_put(map->objcg);
> >  }
> >
> >  void *bpf_map_kmalloc_node(const struct bpf_map *map, size_t size, gfp_t flags,
> >                          int node)
> >  {
> > -     struct mem_cgroup *old_memcg;
> > +     struct obj_cgroup *old_objcg;
> >       void *ptr;
> >
> > -     old_memcg = set_active_memcg(map->memcg);
> > +     old_objcg = set_active_obj_cgroup(map->objcg);
> >       ptr = kmalloc_node(size, flags | __GFP_ACCOUNT, node);
> > -     set_active_memcg(old_memcg);
> > +     set_active_obj_cgroup(old_objcg);
> >
> >       return ptr;
> >  }
> >
> >  void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
> >  {
> > -     struct mem_cgroup *old_memcg;
> > +     struct obj_cgroup *old_objcg;
> >       void *ptr;
> >
> > -     old_memcg = set_active_memcg(map->memcg);
> > +     old_objcg = set_active_obj_cgroup(map->objcg);
> >       ptr = kzalloc(size, flags | __GFP_ACCOUNT);
> > -     set_active_memcg(old_memcg);
> > +     set_active_obj_cgroup(old_objcg);
> >
> >       return ptr;
> >  }
> > @@ -428,22 +429,22 @@ void *bpf_map_kzalloc(const struct bpf_map *map, size_t size, gfp_t flags)
> >  void __percpu *bpf_map_alloc_percpu(const struct bpf_map *map, size_t size,
> >                                   size_t align, gfp_t flags)
> >  {
> > -     struct mem_cgroup *old_memcg;
> > +     struct obj_cgroup *old_objcg;
> >       void __percpu *ptr;
> >
> > -     old_memcg = set_active_memcg(map->memcg);
> > +     old_objcg = set_active_obj_cgroup(map->objcg);
> >       ptr = __alloc_percpu_gfp(size, align, flags | __GFP_ACCOUNT);
> > -     set_active_memcg(old_memcg);
> > +     set_active_obj_cgroup(old_objcg);
> >
> >       return ptr;
> >  }
> >
> >  #else
> > -static void bpf_map_save_memcg(struct bpf_map *map)
> > +static void bpf_map_save_objcg(struct bpf_map *map)
> >  {
> >  }
> >
> > -static void bpf_map_release_memcg(struct bpf_map *map)
> > +static void bpf_map_release_objcg(struct bpf_map *map)
> >  {
> >  }
> >  #endif
> > @@ -454,7 +455,7 @@ static void bpf_map_free_deferred(struct work_struct *work)
> >       struct bpf_map *map = container_of(work, struct bpf_map, work);
> >
> >       security_bpf_map_free(map);
> > -     bpf_map_release_memcg(map);
> > +     bpf_map_release_objcg(map);
> >       /* implementation dependent freeing */
> >       map->ops->map_free(map);
> >  }
> > @@ -877,7 +878,7 @@ static int map_create(union bpf_attr *attr)
> >       if (err)
> >               goto free_map_sec;
> >
> > -     bpf_map_save_memcg(map);
> > +     bpf_map_save_objcg(map);
> >
> >       err = bpf_map_new_fd(map, f_flags);
> >       if (err < 0) {
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index d66718bc82d5..5a800916ad8d 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -943,7 +943,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
> >  #endif
> >
> >  #ifdef CONFIG_MEMCG_KMEM
> > -     tsk->active_memcg = NULL;
> > +     tsk->active_objcg = NULL;
> >  #endif
> >       return tsk;
> >
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 092dc4588b43..024a0f377eb7 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -77,8 +77,8 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
> >  struct mem_cgroup *root_mem_cgroup __read_mostly;
> >
> >  #ifdef CONFIG_MEMCG_KMEM
> > -/* Active memory cgroup to use from an interrupt context */
> > -DEFINE_PER_CPU(struct mem_cgroup *, int_active_memcg);
> > +/* Active object cgroup to use from an interrupt context */
> > +DEFINE_PER_CPU(struct obj_cgroup *, int_active_objcg);
> >  #endif
> >
> >  /* Socket memory accounting disabled? */
> > @@ -1057,18 +1057,18 @@ struct mem_cgroup *get_mem_cgroup_from_mm(struct mm_struct *mm)
> >  EXPORT_SYMBOL(get_mem_cgroup_from_mm);
> >
> >  #ifdef CONFIG_MEMCG_KMEM
> > -static __always_inline struct mem_cgroup *active_memcg(void)
> > +static __always_inline struct obj_cgroup *active_obj_cgroup(void)
> >  {
> >       if (in_interrupt())
> > -             return this_cpu_read(int_active_memcg);
> > +             return this_cpu_read(int_active_objcg);
> >       else
> > -             return current->active_memcg;
> > +             return current->active_objcg;
> >  }
> >
> >  static __always_inline bool memcg_kmem_bypass(void)
> >  {
> >       /* Allow remote memcg charging from any context. */
> > -     if (unlikely(active_memcg()))
> > +     if (unlikely(active_obj_cgroup()))
> >               return false;
> >
> >       /* Memcg to charge can't be determined. */
> > @@ -2971,26 +2971,47 @@ struct mem_cgroup *mem_cgroup_from_obj(void *p)
> >       return page_memcg_check(page);
> >  }
> >
> > -__always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> > +__always_inline
> > +struct obj_cgroup *get_obj_cgroup_from_mem_cgroup(struct mem_cgroup *memcg)
> >  {
> >       struct obj_cgroup *objcg = NULL;
> > +
> > +     rcu_read_lock();
> > +     for (; !mem_cgroup_is_root(memcg); memcg = parent_mem_cgroup(memcg)) {
> > +             objcg = rcu_dereference(memcg->objcg);
> > +             if (objcg && obj_cgroup_tryget(objcg))
> > +                     break;
> > +             objcg = NULL;
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     return objcg;
> > +}
> > +
> > +__always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> > +{
> > +     struct obj_cgroup *objcg;
> >       struct mem_cgroup *memcg;
> >
> >       if (memcg_kmem_bypass())
> >               return NULL;
> >
> >       rcu_read_lock();
> > -     if (unlikely(active_memcg()))
> > -             memcg = active_memcg();
> > -     else
> > -             memcg = mem_cgroup_from_task(current);
> > +     objcg = active_obj_cgroup();
> > +     if (unlikely(objcg)) {
> > +             /* remote object cgroup must hold a reference. */
> > +             obj_cgroup_get(objcg);
> > +             goto out;
> > +     }
> >
> > +     memcg = mem_cgroup_from_task(current);
> >       for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> >               objcg = rcu_dereference(memcg->objcg);
> >               if (objcg && obj_cgroup_tryget(objcg))
> >                       break;
> >               objcg = NULL;
> >       }
> > +out:
> >       rcu_read_unlock();
> >
> >       return objcg;
> > @@ -5296,16 +5317,33 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
> >       return ERR_PTR(error);
> >  }
> >
> > +#ifdef CONFIG_MEMCG_KMEM
> > +static inline struct obj_cgroup *memcg_obj_cgroup(struct mem_cgroup *memcg)
> > +{
> > +     return memcg ? memcg->objcg : NULL;
> > +}
> > +#else
> > +static inline struct obj_cgroup *memcg_obj_cgroup(struct mem_cgroup *memcg)
> > +{
> > +     return NULL;
> > +}
> > +#endif
> > +
> >  static struct cgroup_subsys_state * __ref
> >  mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
> >  {
> >       struct mem_cgroup *parent = mem_cgroup_from_css(parent_css);
> > -     struct mem_cgroup *memcg, *old_memcg;
> > +     struct mem_cgroup *memcg;
> > +     struct obj_cgroup *old_objcg;
> >       long error = -ENOMEM;
> >
> > -     old_memcg = set_active_memcg(parent);
> > +     /*
> > +      * The @parent cannot be offlined, so @parent->objcg cannot be freed
> > +      * under us.
> > +      */
> > +     old_objcg = set_active_obj_cgroup(memcg_obj_cgroup(parent));
> >       memcg = mem_cgroup_alloc();
> > -     set_active_memcg(old_memcg);
> > +     set_active_obj_cgroup(old_objcg);
> >       if (IS_ERR(memcg))
> >               return ERR_CAST(memcg);
> >
> > --
> > 2.11.0
> >
