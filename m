Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDD036AF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbhDZH6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236421AbhDZHzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:55:32 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815E4C06137C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 00:50:23 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id w20so644056pge.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 00:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RSEb31wWGXReNK5o1Di9EAbb2yv22MfNR6i10yaB7II=;
        b=PQxAdZTfhtse3v51/fpEXILWWJLtz6AG6B2+uB8ETdn/kSfgtv4lDD8RvF8GiMMbUH
         NHwRDvFWJbTxPb9Psw37146jJrm8C6XqUkXbW8okYLqwhAUfZNuVeAzSKSDro2CsmUDL
         QYERjj6jR/qZw3SCnrPrWOSJMjbqvpbb8TpM9z1SKsrThc2f8rHQKZqBuJlOIaN/EC2B
         OF0pXfqL+Z+dAp0bFlscJgkLWyN4L3gK7pZSFEkR5WncRVeW18u/Z+xoiWzOJ9roqj8j
         KvPKvzNTncI1ApZIB49Z6umz1KLUj1DXhAmVS2RdkmQY9vx6tKn45bImHjczbARZexaz
         +2gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RSEb31wWGXReNK5o1Di9EAbb2yv22MfNR6i10yaB7II=;
        b=lr6gJjxCHoALUIA4TiVPk3l1uY6vNNEFwFkPkRSy8YktCdLJXj5ut7ys7d+6zfCw2j
         GEuD/MBf9Q2yngiI9DJsUtRtg9au+gNI4WGaj6ZPFXWCHp+tZv4JVaF2oRuHEwXPNKe2
         Mc+hIiH2clsSh/86iRyH0mxQW1hCOJ8ABF7gJd6TCzrvU2gQ6sAWenLOQx8cLtBY3+JU
         WH8UujEDz3IOVKmJbH1euynCFGTRyBdQEzcMOnyK2Ph0HIRh/23Q7o2KY7CE6E+Aj2op
         rn4QOmjGRS7ol1vUI3oZwEPvmoUagwfr8sAakTQqJ66imveduuNTPcabo2TTVTjNK/7v
         bW3w==
X-Gm-Message-State: AOAM533TyTKfdHAVhdNhhm3tk0ZVWuzuPybwAnybzOdL1ocisVW6qQYa
        dv8K520oS6ouhNKWouzRVK/pgVZc8Ee2jbClG6Evow==
X-Google-Smtp-Source: ABdhPJyUTsrpL/aAnkNFZ4s16Wdt/xjloo9acRdtHc7o2IokHZP3Sz/w5/RveaSLf7PObJIL3QGraE1I2lb5GKtIfEk=
X-Received: by 2002:a63:f07:: with SMTP id e7mr16003525pgl.341.1619423423083;
 Mon, 26 Apr 2021 00:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210417043538.9793-1-songmuchun@bytedance.com>
In-Reply-To: <20210417043538.9793-1-songmuchun@bytedance.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 26 Apr 2021 15:49:47 +0800
Message-ID: <CAMZfGtXmav_HoafN4HjDoK6GwzyeuFxLmd3+0QdiZS0ONdYDJg@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] memcontrol code cleanup and simplification
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 12:37 PM Muchun Song <songmuchun@bytedance.com> wrote:
>
> This patch series is part of [1] patch series. Because those patches are
> code cleanup or simplification. I gather those patches into a separate
> series to make it easier to review.
>
> [1] https://lore.kernel.org/linux-mm/20210409122959.82264-1-songmuchun@bytedance.com/
>

Hi Andrew,

Since all the patches in this series have at least three
Acked-by/Reviewed-by tags, I think that it is ready to
merge this to mm-tree. Maybe you forgot this. So this
is a reminder. :-) Thanks.


> Changlogs in v3:
>   1. Collect Acked-by and Review-by tags.
>   2. Add a comment to patch 5 (suggested by Johannes).
>
>   Thanks to Johannes, Shakeel and Michal's review.
>
> Changlogs in v2:
>   1. Collect Acked-by and Review-by tags.
>   2. Add a new patch to rename lruvec_holds_page_lru_lock to page_matches_lruvec.
>   3. Add a comment to patch 2.
>
>   Thanks to Roman, Johannes, Shakeel and Michal's review.
>
> Muchun Song (8):
>   mm: memcontrol: fix page charging in page replacement
>   mm: memcontrol: bail out early when !mm in get_mem_cgroup_from_mm
>   mm: memcontrol: remove the pgdata parameter of mem_cgroup_page_lruvec
>   mm: memcontrol: simplify lruvec_holds_page_lru_lock
>   mm: memcontrol: rename lruvec_holds_page_lru_lock to
>     page_matches_lruvec
>   mm: memcontrol: simplify the logic of objcg pinning memcg
>   mm: memcontrol: move obj_cgroup_uncharge_pages() out of css_set_lock
>   mm: vmscan: remove noinline_for_stack
>
>  include/linux/memcontrol.h | 43 ++++++++++--------------------
>  mm/compaction.c            |  2 +-
>  mm/memcontrol.c            | 65 +++++++++++++++++++++-------------------------
>  mm/swap.c                  |  2 +-
>  mm/vmscan.c                |  8 +++---
>  mm/workingset.c            |  2 +-
>  6 files changed, 50 insertions(+), 72 deletions(-)
>
> --
> 2.11.0
>
