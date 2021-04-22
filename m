Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F93687C4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239068AbhDVUQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236915AbhDVUQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:16:17 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDABFC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:15:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s7so45945297wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wy0cnaneSmhDortv5ccTKu6/SeWDGYIABVfi/jQ1Jgs=;
        b=qlVuLFkCWHJ1JEdrPX5oKvIlDUMgdmwfa0uVKLRRWUDhSxg+DAVD7Op8+Bo1CzHyD4
         X1bIbBSs7S5Wtx0TMXxzrjEeKmOR3DDTI/QFWAVCCByhtzKyYFrX30DBJ+dLLajdOz+x
         gxaumiSasWTzKXunSSmBmfq61hZf5gSYNDbOhYgwvNGpZpgYBKHFn3JxWNfoUZ6mv0nk
         LNB06GgOlOHrfciTujIbNEeZU5Ewp1Tl3vNdfyLPe/cr0wg2+8tqn2zXqiNL/oQ+jBJh
         ENXgBL4SRXvncRciFBvEZhrKcv//ehfjvyQ1AKeCFD2SVqF5dDWKQCTCKRVSZkZnTPcc
         hosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wy0cnaneSmhDortv5ccTKu6/SeWDGYIABVfi/jQ1Jgs=;
        b=CvajuwacXOY/ic6dGDP5RDs1jy+vpJ7hNxS2axNuVMpBG/rgv7OOCS1wS1Rxo5EHcu
         SpXVj3kMWLoh1FBkvrxuoEdlIY+hN7zritz2iYwsLZvYcihbKfTBK3gEDWcb2v7QZwxb
         cBwADmRf45ouCoRH01Q3s8L0FxXJW3M1jMlFrKRErmgGFzlN4Pqbsh8bwNPIoXpAtgZA
         dZQBtGdfaxUuSKabs3iFKRmDGzFjHFpH4zm5rnYTkaSQzbwVGCEHLq2e5llVCTwINecU
         X0gv/THDJBW7FjpexZzs+30b6T+wAe1ZrXQOGebjQr/ppdRNGp9gpd1oG3wPkm9ly2Qv
         3/Xw==
X-Gm-Message-State: AOAM530Sv3ULw0sjtPpgQ1UvcOqWZDRrtUnA8gS9vXLi2QIibqZFBDHP
        zvY5/aX76hyn5nyeYQcs6iyYWPUdPIwpQdfb2tcWPdSedn3iFQ==
X-Google-Smtp-Source: ABdhPJwTvGFPTPy/4Ib9ppQI+rRLaXkNdN/bBwtBs9AI9t0J0qoZZ6FLT0mjfq3EgaFP7JWbG391Ly+nMb8wDpKc+3k=
X-Received: by 2002:adf:9148:: with SMTP id j66mr183170wrj.124.1619122539396;
 Thu, 22 Apr 2021 13:15:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com> <YIGuvh70JbE1Cx4U@google.com>
 <CALvZod5a8LdhWPwCnxtPb4t=ZJJ3ZYDtLEV_RtV9EaY3E7MgaA@mail.gmail.com>
In-Reply-To: <CALvZod5a8LdhWPwCnxtPb4t=ZJJ3ZYDtLEV_RtV9EaY3E7MgaA@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 22 Apr 2021 14:15:27 -0600
Message-ID: <CAOUHufbt6i2-Z9=+Ngjnhnk8nh8-yYkhpPBi0i_ca8xTsk9mVw@mail.gmail.com>
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by too_many_isolated()
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
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

On Thu, Apr 22, 2021 at 12:52 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Thu, Apr 22, 2021 at 10:13 AM Yu Zhao <yuzhao@google.com> wrote:
> >
> [...]
> >         spin_lock_irq(&lruvec->lru_lock);
> > @@ -3302,6 +3252,7 @@ static bool throttle_direct_reclaim(gfp_t gfp_mask, struct zonelist *zonelist,
> >  unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> >                                 gfp_t gfp_mask, nodemask_t *nodemask)
> >  {
> > +       int nr_cpus;
> >         unsigned long nr_reclaimed;
> >         struct scan_control sc = {
> >                 .nr_to_reclaim = SWAP_CLUSTER_MAX,
> > @@ -3334,8 +3285,17 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> >         set_task_reclaim_state(current, &sc.reclaim_state);
> >         trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
> >
> > +       nr_cpus = current_is_kswapd() ? 0 : num_online_cpus();
>
> kswapd does not call this function (directly or indirectly).
>
> > +       while (nr_cpus && !atomic_add_unless(&pgdat->nr_reclaimers, 1, nr_cpus)) {
>
> At most nr_nodes * nr_cpus direct reclaimers are allowed?
>
> > +               if (schedule_timeout_killable(HZ / 10))
>
> trace_mm_vmscan_direct_reclaim_end() and set_task_reclaim_state(NULL)?
>
> > +                       return SWAP_CLUSTER_MAX;
> > +       }
> > +
> >         nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
> >
> > +       if (nr_cpus)
> > +               atomic_dec(&pgdat->nr_reclaimers);
> > +
> >         trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
> >         set_task_reclaim_state(current, NULL);
>
> BTW I think this approach needs to be more sophisticated. What if a
> direct reclaimer within the reclaim is scheduled away and is out of
> CPU quota?

More sophisticated to what end?

We wouldn't worry about similar scenarios that we ran out of cpu quota
while holding resources like a mutex, Si why this one is different,
especially given that we already allow many reclaimers to run
concurrently?
