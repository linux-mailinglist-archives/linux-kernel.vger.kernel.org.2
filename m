Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009C742A81B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 17:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhJLPV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 11:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232952AbhJLPVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:21:55 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6D9C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 08:19:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r19so86334921lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fx9uh/yFwWPf1RvBOli1EjuO7bkG9IU/pBATiSWlqFg=;
        b=cYIERjdR5CU0zvc71v6OTruL+l9CA0jtutGtJNcw5rM9NzYLi+qEbTWlx7zJiFwVQu
         fEnrBA8rNpJVoW7q4RjuQO3im36raES3rst2dxsb5yzIEIEhaPuJxlmD1rtweHLiY47E
         KNm7Uw8pkCbNdQLqotnFg5fS0pjqPLvp/BR3eJgCT+vdxiXU34JNakFxh+rTQueP2V2M
         uQq+OwJmWZff2M2HTDJaxk9eE5zuukn9Ayx3iL8IjqrPquUOrvP9RLZKwJBmSQ5K98gY
         L2Vvi61nOZ6bNigRmyg48XKPolU1XsIKM7JtlIaiqMznD8pDtk3VxaflYz4MzIjWAiNX
         qGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fx9uh/yFwWPf1RvBOli1EjuO7bkG9IU/pBATiSWlqFg=;
        b=RpnUDzQfCTY+Ok5CXEYJ1uDwbS3NL31r8JuVETXonr2a0f+u+du+EEq1Y9sBjiwluD
         o5SkGkduRDPGhh9EdlhtvIRHekEH3eK6UH862U7KYNOt0h3dKJP026nAECmKtUL6XJ8W
         sbVFfvnUORw/mIVilHjPjahV5QawZh8k61IfwMokmhO4/Ivs3AcYWpwfXi/njQ4WSp7A
         hpadhuwa/7RKCcMRGJ42DuLTHWQAN78VEZ47wqXgAgspnLWqBJHf/x5cShLpVHGCC00K
         xcaO3LsBBswmNGLRAK1b3vPOfp20aixcIt5VQfdDZclL+iN5ATgBbxAEKkeu7tTVkekM
         JLIA==
X-Gm-Message-State: AOAM533ZGNDMraJ9ZdzfOvJEQZBKzQdvyaUiFeQ6l6XQ95ofAji37Yrv
        /34WVVPr132hfFPBj2Y3x3c2LjFCV5MnwQvqyDdJ3A==
X-Google-Smtp-Source: ABdhPJygTv0WVFyli9c32ftyIVOz3+eDs6Nwsjk9acVmziW6PQMjljVAJdA2/Uc38ewDDmTtmeUNRPsaX+ntjFwF1UE=
X-Received: by 2002:a2e:9e07:: with SMTP id e7mr29055698ljk.6.1634051989099;
 Tue, 12 Oct 2021 08:19:49 -0700 (PDT)
MIME-Version: 1.0
References: <0baa2b26-a41b-acab-b75d-72ec241f5151@virtuozzo.com> <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com>
In-Reply-To: <60df0efd-f458-a13c-7c89-749bdab21d1d@virtuozzo.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 12 Oct 2021 08:19:37 -0700
Message-ID: <CALvZod69v-D-WtwEPNPRTUzt5us0oCOueH-ED-WjmTCfs5qVTA@mail.gmail.com>
Subject: Re: [PATCH mm v3] memcg: enable memory accounting in __alloc_pages_bulk
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Roman Gushchin <guro@fb.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@openvz.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 7:58 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Enable memory accounting for bulk page allocator.
>
> Fixes: 387ba26fb1cb ("mm/page_alloc: add a bulk page allocator")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
> v3: added comments,
>     removed call of post charge hook for nr_pages = 0
> v2: modified according to Shakeel Butt's remarks
> ---
>  include/linux/memcontrol.h | 11 +++++++++
>  mm/memcontrol.c            | 48 +++++++++++++++++++++++++++++++++++++-
>  mm/page_alloc.c            | 21 ++++++++++++++++-
>  3 files changed, 78 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 3096c9a0ee01..990acd70c846 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -810,6 +810,12 @@ static inline void obj_cgroup_put(struct obj_cgroup *objcg)
>         percpu_ref_put(&objcg->refcnt);
>  }
>
> +static inline void obj_cgroup_put_many(struct obj_cgroup *objcg,
> +                                      unsigned long nr)
> +{
> +       percpu_ref_put_many(&objcg->refcnt, nr);
> +}
> +
>  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
>  {
>         if (memcg)
> @@ -1746,4 +1752,9 @@ static inline struct mem_cgroup *mem_cgroup_from_obj(void *p)
>
>  #endif /* CONFIG_MEMCG_KMEM */
>
> +bool memcg_bulk_pre_charge_hook(struct obj_cgroup **objcgp, gfp_t gfp,
> +                               unsigned int nr_pages);
> +void memcg_bulk_charge_hook(struct obj_cgroup *objcgp, struct page *page);
> +void memcg_bulk_post_charge_hook(struct obj_cgroup *objcg,
> +                                unsigned int nr_pages);
>  #endif /* _LINUX_MEMCONTROL_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 87e41c3cac10..16fe3384c12c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3239,7 +3239,53 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, size_t size)
>         refill_obj_stock(objcg, size, true);
>  }
>
> -#endif /* CONFIG_MEMCG_KMEM */
> +bool memcg_bulk_pre_charge_hook(struct obj_cgroup **objcgp, gfp_t gfp,
> +                               unsigned int nr_pages)
> +{
> +       struct obj_cgroup *objcg = NULL;

No need to explicitly set it to NULL.

> +
> +       if (!memcg_kmem_enabled() || !(gfp & __GFP_ACCOUNT))
> +               return true;
> +
> +       objcg = get_obj_cgroup_from_current();
> +
> +       if (objcg && obj_cgroup_charge_pages(objcg, gfp, nr_pages)) {
> +               obj_cgroup_put(objcg);
> +               return false;
> +       }

get_obj_cgroup_from_current() can return NULL, so you would need to
return true early for that condition.

> +       obj_cgroup_get_many(objcg, nr_pages - 1);
> +       *objcgp = objcg;
> +       return true;
> +}
> +
> +void memcg_bulk_charge_hook(struct obj_cgroup *objcg, struct page *page)
> +{
> +       page->memcg_data = (unsigned long)objcg | MEMCG_DATA_KMEM;
> +}
> +
> +void memcg_bulk_post_charge_hook(struct obj_cgroup *objcg,
> +                                unsigned int nr_pages)
> +{
> +       obj_cgroup_uncharge_pages(objcg, nr_pages);
> +       obj_cgroup_put_many(objcg, nr_pages);
> +}

You can keep the following '#else' code block in the header file.

> +#else /* !CONFIG_MEMCG_KMEM */
> +bool memcg_bulk_pre_charge_hook(struct obj_cgroup **objcgp, gfp_t gfp,
> +                               unsigned int nr_pages)
> +{
> +       return true;
> +}
> +
> +void memcg_bulk_charge_hook(struct obj_cgroup *objcgp, struct page *page)
> +{
> +}
> +
> +void memcg_bulk_post_charge_hook(struct obj_cgroup *objcg,
> +                                unsigned int nr_pages)
> +{
> +}
> +#endif
> +
