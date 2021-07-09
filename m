Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF723C2739
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 18:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhGIQDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhGIQDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 12:03:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB0DC0613E5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 09:00:53 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id c28so23667935lfp.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/xZI0OajFf5/ziUaY+H5m9Nzo8ghS9n7erS+9RJcXYI=;
        b=W8p7yxoX3G5IefHMsRi4RO40HwPkUuZKO3Wv0ZsSnEGlWk9UWvnKmQGYINVPYcChA9
         WqVnGAT7Ht7kptj0cHK+RO8ue80geR+dn9mK06BE+MSmBWZxzpFqj2liQKKsHQHwEm8/
         9adlW2sI8CwSPhxv6HJlqtEhnnly5kd4B07uwGmd8xdOgTfH1L2I0TPxkaJjN8DDlkDD
         1YtUnGHXQCYRub16v4ymPOdl3+c8L4KyEZjjF4acYce5MxvCBZ1TeeoUX+rWBAMUwjrR
         qfVOlkfEB974p6LhdqPzqpMyry1nWccBFX0SbgLebwQ9nEFcv5nZaY0H5dTUUHBoyq0a
         k+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/xZI0OajFf5/ziUaY+H5m9Nzo8ghS9n7erS+9RJcXYI=;
        b=CaVhSNlaN/SkK3d6QUJu5mwAto1vkIh7z3NY6lAuBCes4ce1E5tpyNOYG4Ya+4/T/w
         XW1FjwwW/FogJOFebz1+uM5j7mPuzQx1OlksOMigxC5ZjqVpeyQuKbhKNJ+is4EpqnNl
         T+NeWaGIeDg6/+rM/dtk9sBUfRQ2ggD2sXq9GTGcIQcFWncGF6tYvt6sMhBp91tUCwBu
         XTmTJ8iPs18Xb+Mevi9h0xcffDyyEpAjN+3efXbd8Qn22MF/uVZLINiUZYL6opcUSzjg
         j47IURZa8jHHpNL3BJqCr0GnqvGyq7ZZjB1ejpK02lth0xu3IhNrqvsY839H+4WciG7C
         QldQ==
X-Gm-Message-State: AOAM530SBhMvV6LZTmiwL2zT5oAGmcaHYYLdcuqDmnt7cSFJCnV003Fj
        hJuktbym4RpDvBjEOQo/tUUnvjZtQV9BvFPknIwmpw==
X-Google-Smtp-Source: ABdhPJzHHw49xv/agytETvqSChc4oU4k6Uy1gyLX68+KTNT1rad2pHALpVI3rzlltSe/tgTntSYsjF1LYD8VqnNkNdo=
X-Received: by 2002:a19:ad4d:: with SMTP id s13mr13304956lfd.432.1625846451059;
 Fri, 09 Jul 2021 09:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210709000509.2618345-1-surenb@google.com> <20210709000509.2618345-2-surenb@google.com>
In-Reply-To: <20210709000509.2618345-2-surenb@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 9 Jul 2021 09:00:39 -0700
Message-ID: <CALvZod7MUemu_=ffcE3tpg_=Mazcp6OB=fSJxC9Sa2-uPPLqbA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm, memcg: add mem_cgroup_disabled checks in
 vmpressure and swap-related functions
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Yang Shi <shy828301@gmail.com>, alexs@kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Minchan Kim <minchan@kernel.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 8, 2021 at 5:05 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
[...]

> --- a/mm/vmpressure.c
> +++ b/mm/vmpressure.c
> @@ -240,7 +240,12 @@ static void vmpressure_work_fn(struct work_struct *work)
>  void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>                 unsigned long scanned, unsigned long reclaimed)
>  {
> -       struct vmpressure *vmpr = memcg_to_vmpressure(memcg);
> +       struct vmpressure *vmpr;
> +
> +       if (mem_cgroup_disabled())
> +               return;
> +
> +       vmpr = memcg_to_vmpressure(memcg);

I was wondering why this was not crashing but realized that we
allocate root_mem_cgroup even in cgroup_disable=memory case.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
