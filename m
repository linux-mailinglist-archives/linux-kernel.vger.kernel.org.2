Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5ED834138E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbhCSDkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhCSDkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:40:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9560C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:40:03 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id u10so7880810lff.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 20:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DN1htinD/rvt+eRcaheNveowyjIyAAls26Xb5z4rh3Y=;
        b=keUjPKzNyXkHT3ju6jATjlakZ+W21Mf3wMGJYydgHBGevSgtwWHJaCxwu59LAJgewI
         BhRJZ+XTepaOY2p2riwL2ezTECve6A27yXmZTIUey1H4nTEAsuzP8LfPa7Kx9VDVv8l2
         mBUOQCpPxP++/S6nhNHmwMY9HiV3uzlChv9c7mEZeiaGG7Jm+is+B4dDMYiDT57Pao0W
         j2ZJHVXC+/dBdQ2ubP2r0zHN1r9FOMiYGKbQwSlDkSHdNaWLyqzWEVr8cXmhc0AKD0mX
         7luAMpDc9mIzn9eLZk8YVsQCXty80tP1UbvzVPxxrvQINTizaXyVq0eUgl6k8KkD9W2i
         nxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DN1htinD/rvt+eRcaheNveowyjIyAAls26Xb5z4rh3Y=;
        b=R5IfMhAaf47+tTeUAox8OgKkHMwxi9mSWlygZrnnaBDzc1YYnL1E7qgLdFyLc47MPH
         R92dkmpwYxkoFuPn41ZcOE9x7femv9ok8/mJ5jpzoKjlVpvcyDduSH1rFla+cOw8FFa1
         2d56EszxMrspV0K14RwZFBmjqJVki4xVG+j+7ODrPfT6BVRUT9TenftzuENMYHIgOSA+
         cCh5k58goLJvpRZ5LSEPyz2lHIxz/7JI8p9p8L/pzNs8YHBI+vVDA7l2lnYkqaXsH7QG
         tV4E4Q4LexYbmYHtGayCOAkQdeKdUNifELZk3YPISHvDLAbC8fxKJhQ2rhmhvjmFw5gT
         tEaA==
X-Gm-Message-State: AOAM531r5JpD/rm8s7yi6USs/wo4i/wCGUf2+mNopExitJepW9MnNHxK
        pBzwYDaATdBgJoORHIwb8RDpmjGfCakRmXnyJfVCjA==
X-Google-Smtp-Source: ABdhPJw6lb+SdqDwvZaxVMgRXpD6HXSDxZKbrG0Y8YvfqUUbvNSwUfEFB4RLN9YS0xbH8E1qzhkm71susgP21Ma3TFs=
X-Received: by 2002:a05:6512:b93:: with SMTP id b19mr3286251lfv.432.1616125202132;
 Thu, 18 Mar 2021 20:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210318110658.60892-1-songmuchun@bytedance.com> <20210318110658.60892-5-songmuchun@bytedance.com>
In-Reply-To: <20210318110658.60892-5-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 18 Mar 2021 20:39:50 -0700
Message-ID: <CALvZod5RSXiUHBkW4aaWOnak6LQ6QdSiGWMh9Wk_Q++dz6Y4_Q@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] mm: memcontrol: use obj_cgroup APIs to charge kmem pages
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Roman Gushchin <guro@fb.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 4:08 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
[...]
>
> +static inline struct mem_cgroup *get_obj_cgroup_memcg(struct obj_cgroup *objcg)

I would prefer get_mem_cgroup_from_objcg().

> +{
> +       struct mem_cgroup *memcg;
> +
> +       rcu_read_lock();
> +retry:
> +       memcg = obj_cgroup_memcg(objcg);
> +       if (unlikely(!css_tryget(&memcg->css)))
> +               goto retry;
> +       rcu_read_unlock();
> +
> +       return memcg;
> +}
> +
>  #ifdef CONFIG_MEMCG_KMEM
>  int memcg_alloc_page_obj_cgroups(struct page *page, struct kmem_cache *s,
>                                  gfp_t gfp, bool new_page)
> @@ -3070,15 +3088,8 @@ static int obj_cgroup_charge_pages(struct obj_cgroup *objcg, gfp_t gfp,
>         struct mem_cgroup *memcg;
>         int ret;
>
> -       rcu_read_lock();
> -retry:
> -       memcg = obj_cgroup_memcg(objcg);
> -       if (unlikely(!css_tryget(&memcg->css)))
> -               goto retry;
> -       rcu_read_unlock();
> -
> +       memcg = get_obj_cgroup_memcg(objcg);
>         ret = __memcg_kmem_charge(memcg, gfp, nr_pages);

Why not manually inline __memcg_kmem_charge() here? This is the only user.

Similarly manually inline __memcg_kmem_uncharge() into
obj_cgroup_uncharge_pages() and call obj_cgroup_uncharge_pages() in
obj_cgroup_release().

> -
>         css_put(&memcg->css);
>
>         return ret;
> @@ -3143,18 +3154,18 @@ static void __memcg_kmem_uncharge(struct mem_cgroup *memcg, unsigned int nr_page
>   */
>  int __memcg_kmem_charge_page(struct page *page, gfp_t gfp, int order)
>  {
> -       struct mem_cgroup *memcg;
> +       struct obj_cgroup *objcg;
>         int ret = 0;
>
> -       memcg = get_mem_cgroup_from_current();

This was the only use of get_mem_cgroup_from_current(). Why not remove it?

> -       if (memcg && !mem_cgroup_is_root(memcg)) {
> -               ret = __memcg_kmem_charge(memcg, gfp, 1 << order);
> +       objcg = get_obj_cgroup_from_current();
> +       if (objcg) {
> +               ret = obj_cgroup_charge_pages(objcg, gfp, 1 << order);
>                 if (!ret) {
> -                       page->memcg_data = (unsigned long)memcg |
> +                       page->memcg_data = (unsigned long)objcg |
>                                 MEMCG_DATA_KMEM;
>                         return 0;
>                 }
> -               css_put(&memcg->css);
> +               obj_cgroup_put(objcg);
>         }
>         return ret;
>  }
[...]
>  static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  {
>         unsigned long nr_pages;
> +       struct mem_cgroup *memcg;
> +       struct obj_cgroup *objcg;
>
>         VM_BUG_ON_PAGE(PageLRU(page), page);
>
> -       if (!page_memcg(page))
> -               return;
> -
>         /*
>          * Nobody should be changing or seriously looking at
> -        * page_memcg(page) at this point, we have fully
> +        * page memcg or objcg at this point, we have fully
>          * exclusive access to the page.
>          */
> +       if (PageMemcgKmem(page)) {
> +               objcg = __page_objcg(page);
> +               memcg = get_obj_cgroup_memcg(objcg);

Can you add a comment that this get matches the put at the end of the
function and kmem pages do not hold memcg references anymore.

> +       } else {
> +               memcg = __page_memcg(page);
> +       }
> +
> +       if (!memcg)
> +               return;
>
> -       if (ug->memcg != page_memcg(page)) {
> +       if (ug->memcg != memcg) {
>                 if (ug->memcg) {
>                         uncharge_batch(ug);
>                         uncharge_gather_clear(ug);
>                 }
> -               ug->memcg = page_memcg(page);
> +               ug->memcg = memcg;
>                 ug->dummy_page = page;
>
>                 /* pairs with css_put in uncharge_batch */
> -               css_get(&ug->memcg->css);
> +               css_get(&memcg->css);
>         }
>
>         nr_pages = compound_nr(page);
> -       ug->nr_pages += nr_pages;
>
> -       if (PageMemcgKmem(page))
> +       if (PageMemcgKmem(page)) {
> +               ug->nr_memory += nr_pages;
>                 ug->nr_kmem += nr_pages;
> -       else
> +
> +               page->memcg_data = 0;
> +               obj_cgroup_put(objcg);
> +       } else {
> +               /* LRU pages aren't accounted at the root level */
> +               if (!mem_cgroup_is_root(memcg))
> +                       ug->nr_memory += nr_pages;
>                 ug->pgpgout++;
>
> -       page->memcg_data = 0;
> -       css_put(&ug->memcg->css);
> +               page->memcg_data = 0;
> +       }
> +
> +       css_put(&memcg->css);
>  }
>
>  /**
> --
> 2.11.0
>
