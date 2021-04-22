Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23973686C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 20:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbhDVSwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 14:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236459AbhDVSwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 14:52:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30790C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 11:52:07 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id g8so73813448lfv.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 11:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EFCZMZ6hzB2RWTdL7dl13NU/E83N9mJUw195cIoPTNg=;
        b=ZFlo++KDSdJ3KzZUW2wpnPnWfV5B+ogeRTK4aG2B3kBTYdtINUwi1Vm5T5NTCH6C+8
         xwXzI27ilMDt3bqU9IXZdk8cQyptsvbTj+G+B5ZsoW69PTz/JLQggtr3dfu0D5+Qm7vp
         /9SuA+Z8C1lwWwu/PMjsU4Y1dvyE9fmY6jM4zjf4ito2m+A+26c6rlCKscRZLxxLvh5S
         T+9D3gAcX1t/ZfDxN88vLdHT1CoN0LxfQLXCUfKitJVJh3RhH+LqzbciF7kPjFSUNWKb
         90iTiOU9tE8j66uHSgOJJOq/XRWjjvfe0iv0E50whpmn5T5RfwwxXixE4NhaJUlHFgSN
         ge/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EFCZMZ6hzB2RWTdL7dl13NU/E83N9mJUw195cIoPTNg=;
        b=CDDLKPJH3Y1pBZuHanZfGh8NyLCuFmZoY3hZDhGmTVe7j+vKBq6LHQJx53bsT5W9DY
         /2yks5GjkmNT+aVy2nza4O9yJreX1OpsgqKwUCojtykYVrcSwvLfPV4nk8ZLY007Y1YJ
         BoUgN3nan9vImGzcasDODwl5Sbd121ehdc9YZUmT8ZgvtnzyhegYIHzAqC10jo1WgxoO
         hGAH6EjRYg89P344poM8qTKw/xzBmyYgb9vXtYaBhqhON/Hk6tUx9lFTqGxG+ffzYhYy
         NrJf8TMedvSjdpiaPmivudXFsSV9VYalFAHEpfNSJDIo39Unm55YrWMKOgmGKTBAcnrp
         reCA==
X-Gm-Message-State: AOAM532U0qppMZTWq3PQ3X22sZRXkM/CRD4DG/C7jMcPzsiUwI1HjvsR
        lIeLHSlydRK+//j+XzPs7lYq6MwZzGL7hfT9y5sUcR6oHZuj2w==
X-Google-Smtp-Source: ABdhPJwne+hptBVJuYjS9Z9NqksFnVrtUzFG41ZryRLcnEnoINDZM4fV3DjrKOdjEPHNPL6xeqwjvoTvtdF7e3Etox0=
X-Received: by 2002:a05:6512:2037:: with SMTP id s23mr3428130lfs.358.1619117525249;
 Thu, 22 Apr 2021 11:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com> <YIGuvh70JbE1Cx4U@google.com>
In-Reply-To: <YIGuvh70JbE1Cx4U@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 22 Apr 2021 11:51:53 -0700
Message-ID: <CALvZod5a8LdhWPwCnxtPb4t=ZJJ3ZYDtLEV_RtV9EaY3E7MgaA@mail.gmail.com>
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by too_many_isolated()
To:     Yu Zhao <yuzhao@google.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, wfg@mail.ustc.edu.cn
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:13 AM Yu Zhao <yuzhao@google.com> wrote:
>
[...]
>         spin_lock_irq(&lruvec->lru_lock);
> @@ -3302,6 +3252,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
>  unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>                                 gfp_t gfp_mask, nodemask_t *nodemask)
>  {
> +       int nr_cpus;
>         unsigned long nr_reclaimed;
>         struct scan_control sc = {
>                 .nr_to_reclaim = SWAP_CLUSTER_MAX,
> @@ -3334,8 +3285,17 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
>         set_task_reclaim_state(current, &sc.reclaim_state);
>         trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
>
> +       nr_cpus = current_is_kswapd() ? 0 : num_online_cpus();

kswapd does not call this function (directly or indirectly).

> +       while (nr_cpus && !atomic_add_unless(&pgdat->nr_reclaimers, 1, nr_cpus)) {

At most nr_nodes * nr_cpus direct reclaimers are allowed?

> +               if (schedule_timeout_killable(HZ / 10))

trace_mm_vmscan_direct_reclaim_end() and set_task_reclaim_state(NULL)?

> +                       return SWAP_CLUSTER_MAX;
> +       }
> +
>         nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
>
> +       if (nr_cpus)
> +               atomic_dec(&pgdat->nr_reclaimers);
> +
>         trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
>         set_task_reclaim_state(current, NULL);

BTW I think this approach needs to be more sophisticated. What if a
direct reclaimer within the reclaim is scheduled away and is out of
CPU quota?
