Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138AE373130
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbhEDUHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbhEDUHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:07:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EF3C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 13:06:32 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id c3so11074964lfs.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bicsEuUz1gvZF81DYUlP6NvUpuHppuBYNALePyNxC9g=;
        b=bNvfSVbrfIgA95/qF4ZeFRRJsvGk4NJDBuE/W5Mo3pSCABnQdq0tJklynnt2iyRivt
         9xOMr5TEYWmPqYFVpqHiDwRLKNXBwFrMNDLuFGAun6YlWgWL+rtnaFljOoB6/Gx1qSIm
         iBVni8M3rbgLVuzq1Qu2Zk24kVhwOSchxgP8/xupAYXq5ju4dW2MrHTdjEWuC9C8JM/f
         RXoTLo3gqaDhyUq5y7WB3V+oHJ6W5V2ha3OD+WXseWJNokN6WU0deSL4hmToQEUOdQmn
         EcXf4Iix1oU4U1299rFyIyIhXxCYmfP5GNGSXAK+6/acAjcQxLvg4dn1/lWs/fVeR6ZF
         /Vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bicsEuUz1gvZF81DYUlP6NvUpuHppuBYNALePyNxC9g=;
        b=CZnT1qjLMtRBtCVtrxbfwMT6ipZAoOahQzbxQHim295qD+EMcP5VN1U5yHqGmJmwZK
         10YO+3BKCsQvKkUuOZZHdQ5qJGskh9Ubntwo3rtrxElYfiYEvQAZ5q5HZ2LN58cjhnb4
         5h+Ps0x20GIt64RQaK2y4zCTGKKAxF1gJ0bx/PYkmLUu6JfGUnnjtqe5SMvauvVZya00
         TEeTAotR1uHjct9D7jx/C78Q8KjZ0pu16r7bRtBzpKhmDXiXLK2vnMcnx9UAb6v89qcA
         u3flrXdUIzTSsp/Sif27ReH9y09P91k6CttT1wPSuTUQhTU7xHQeooHyF6iOKt2JgpYq
         4+rA==
X-Gm-Message-State: AOAM530lCKXpU7wBoFmHmTvMApa5V/u2yOwI+cQweruvWn5CCs4iZf3k
        VNR3nn/xQXkoYtBDKnLG/OrkI90yj0+bIhlnqmX0Uw==
X-Google-Smtp-Source: ABdhPJwKtfoljjPRo13PwAVotpRKJyTHqnYx5fpV6N1HiH3pDpyXr0DLOCZ+VOj2Zig8ET/uSnimzlZ9y/etJutPfbI=
X-Received: by 2002:a05:6512:1182:: with SMTP id g2mr8642302lfr.117.1620158790666;
 Tue, 04 May 2021 13:06:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210504132350.4693-1-longman@redhat.com> <20210504132350.4693-2-longman@redhat.com>
 <CALvZod438=YKZtV0qckoaMkdL1seu5PiLnvPPQyRzA0S60-TpQ@mail.gmail.com> <267501a0-f416-4058-70d3-e32eeec3d6da@redhat.com>
In-Reply-To: <267501a0-f416-4058-70d3-e32eeec3d6da@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 4 May 2021 13:06:19 -0700
Message-ID: <CALvZod5gakHaAZfU2gH6QVNJRcX90MVSmqBpBSgCmF-Zhpz_vw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm: memcg/slab: Properly set up gfp flags for
 objcg pointer array
To:     Waiman Long <llong@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 1:02 PM Waiman Long <llong@redhat.com> wrote:
>
> On 5/4/21 3:37 PM, Shakeel Butt wrote:
> > On Tue, May 4, 2021 at 6:24 AM Waiman Long <longman@redhat.com> wrote:
> >> Since the merging of the new slab memory controller in v5.9, the page
> >> structure may store a pointer to obj_cgroup pointer array for slab pages.
> >> Currently, only the __GFP_ACCOUNT bit is masked off. However, the array
> >> is not readily reclaimable and doesn't need to come from the DMA buffer.
> >> So those GFP bits should be masked off as well.
> >>
> >> Do the flag bit clearing at memcg_alloc_page_obj_cgroups() to make sure
> >> that it is consistently applied no matter where it is called.
> >>
> >> Fixes: 286e04b8ed7a ("mm: memcg/slab: allocate obj_cgroups for non-root slab pages")
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> >> ---
> >>   mm/memcontrol.c | 8 ++++++++
> >>   mm/slab.h       | 1 -
> >>   2 files changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> >> index c100265dc393..5e3b4f23b830 100644
> >> --- a/mm/memcontrol.c
> >> +++ b/mm/memcontrol.c
> >> @@ -2863,6 +2863,13 @@ static struct mem_cgroup *get_mem_cgroup_from_objcg(struct obj_cgroup *objcg)
> >>   }
> >>
> >>   #ifdef CONFIG_MEMCG_KMEM
> >> +/*
> >> + * The allocated objcg pointers array is not accounted directly.
> >> + * Moreover, it should not come from DMA buffer and is not readily
> >> + * reclaimable. So those GFP bits should be masked off.
> >> + */
> >> +#define OBJCGS_CLEAR_MASK      (__GFP_DMA | __GFP_RECLAIMABLE | __GFP_ACCOUNT)
> > What about __GFP_DMA32? Does it matter? It seems like DMA32 requests
> > go to normal caches.
>
> I included __GFP_DMA32 in my first draft patch. However, __GFP_DMA32 is
> not considered in determining the right kmalloc_type() (patch 2), so I
> took it out to make it consistent. I can certainly add it back.
>

No this is fine and DMA32 question is unrelated to this patch series.
