Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5465B322D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 16:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbhBWPU0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 10:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbhBWPT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 10:19:58 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48D0C061797
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:18:58 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id c8so63401144ljd.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 07:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gQTPFz0KpYE2dWkk3abN3T0OszgB57hAvGOE8ZYtgAA=;
        b=o+//MZFFfHtdHG0DGPb2hEKrGlrSgOgpcvlv8EkAotugJY4tPbXDcnXMc/VzRl1B3v
         8Se2eEU44z6Q2HXZys/VPsHf2iTTAXagOhaMxbzKf/kYTJgl/71uLPYbBHMQVhMIiqf6
         lXh+kxA8+09dEncWcHnEJKWScOXu2/9+AcCwK4jrjBqPzowQtoohRQyVHx7jfl3vv4Fs
         Fijdk/U3Vezsc6EkpisJM7UVqdp7xiKs5x6ThOTcy4dnDSq/zFQA67Frm2NFaB8YAD1Q
         Mclf3NnaduBtsQcwblXZrVEVZ3XJAYcht0XC3zb/ADdnOxPytBSC2EUz+zidmXWF86UY
         bhHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gQTPFz0KpYE2dWkk3abN3T0OszgB57hAvGOE8ZYtgAA=;
        b=d650anP2eotnUVajRvusQJSkX6btLOdOJdX4OamZA+/BYlHxt2D5q6fCuQ7tTbRH9E
         Qwa9X5wQXgmWW+NBkgTfuAJjW/OeA17P4BQ6aE9m6GCXjJzf8FlJUKDBVQMofrhjF2F8
         RR5lc4tac+Br2Wm5ZpO2uyS5KzmJghSCDD1a32YLJ89olP9w7UQfulZQ0QdNquhz6nQr
         bAlWc7wyZZzWbcGI9bTrHYqGH2/ZB0xfyDpqvK0CNIAgBG7k6rnNuY/9dpRft1O4sEBD
         3bfJWnshAy/Zd5WmGtevJkOuijI12awnMIPj65yKDIE6GO5t+kxr3P/Vxmzydyv+ZqC+
         38xA==
X-Gm-Message-State: AOAM532SGg2fnRhxr13/A2pwz5Dc9wlm19FIX969XAzIvUT54UKPwoYa
        MDm/F5dJG4PTqAsgoIEBUSXh9rRcRXf146TKCHqt+A==
X-Google-Smtp-Source: ABdhPJytWIbvd5HdX9yo4bjjPo/hvJHu1yFtuH+7/DLHUFKLmC0yaai2hO26aAUsmhtGLUPJJv5KQJLr6A7968Nlm1M=
X-Received: by 2002:a2e:5c02:: with SMTP id q2mr15091026ljb.81.1614093537053;
 Tue, 23 Feb 2021 07:18:57 -0800 (PST)
MIME-Version: 1.0
References: <20210223091101.42150-1-songmuchun@bytedance.com>
In-Reply-To: <20210223091101.42150-1-songmuchun@bytedance.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Feb 2021 07:18:46 -0800
Message-ID: <CALvZod6=TYHPC3g3RzX84KeR8p74RH5PdbT+aNy+m5n2Yboskw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcontrol: fix get_active_memcg return value
To:     Muchun Song <songmuchun@bytedance.com>, stable@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 1:14 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> We use a global percpu int_active_memcg variable to store the remote
> memcg when we are in the interrupt context. But get_active_memcg always
> return the current->active_memcg or root_mem_cgroup. The remote memcg
> (set in the interrupt context) is ignored. This is not what we want.
> So fix it.
>
> Fixes: 37d5985c003d ("mm: kmem: prepare remote memcg charging infra for interrupt contexts")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Good catch.
Cc: stable@vger.kernel.org

Reviewed-by: Shakeel Butt <shakeelb@google.com>

> ---
>  mm/memcontrol.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index be6bc5044150..bbe25655f7eb 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1061,13 +1061,9 @@ static __always_inline struct mem_cgroup *get_active_memcg(void)
>
>         rcu_read_lock();
>         memcg = active_memcg();
> -       if (memcg) {
> -               /* current->active_memcg must hold a ref. */
> -               if (WARN_ON_ONCE(!css_tryget(&memcg->css)))
> -                       memcg = root_mem_cgroup;
> -               else
> -                       memcg = current->active_memcg;
> -       }
> +       /* remote memcg must hold a ref. */
> +       if (memcg && WARN_ON_ONCE(!css_tryget(&memcg->css)))
> +               memcg = root_mem_cgroup;
>         rcu_read_unlock();
>
>         return memcg;
> --
> 2.11.0
>
