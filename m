Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0876039E6CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 20:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhFGSqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 14:46:37 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:34420 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhFGSqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 14:46:34 -0400
Received: by mail-lj1-f181.google.com with SMTP id bn21so23608909ljb.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 11:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9B3Sx0V5Yfw+vtWDBKV2BfxkUflJbs+2GKJxnszO55Y=;
        b=JVjhJug0KdhaJOBiBHpFvDeRVhgV0Ul6evOlc+aRMWWUbUNSFW3lOXdde7k4daaLg0
         wQB/N5wqPD4Og71CI6zSqWbK+MK7XDWK7hlPbyCWMftSlB28YgyUOnLBPmIEw7uSj7Iv
         g0yyuf5bNvBLryh8AAgJrOY9yKHD7mHu1OcjGMaox/aRqja9dX0M/3ulloZ+eBBzEDG4
         7V/A/7wVr/Ywi4+M1PHGyXhsbLxSIK+lfzoltUKaSntmOPcKM9oF59Qhc4KhTmcfJLvg
         ytDz4Y23NI5Sga5/V0sKt67h1p/blm/DkPGezDsTaYBfYimNV2DENBiHI2/mmhPt1eFb
         lt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9B3Sx0V5Yfw+vtWDBKV2BfxkUflJbs+2GKJxnszO55Y=;
        b=keRZGUJHV8j4nKl6i8fU+EY6RAtGtyMTam2MPfC2M5B7QrnDhw2RmTNsEGZtIFgWOH
         245Aa/l2IUeHqAW1wTTjitKvToR3woQBtvwNirpCnBaJealSyfQQM9V1yeLmNVLe06Dt
         N9RjaC+hjJ375pdAj8nCW+YL2nkRLFysBL8rGlluFy6Dc8GpGa0MwYJkt2r1KsKYvIYO
         o3XUIt0RAGcVehuPbZdJSVj5VX4ZJ0/GuhEeqtiowpsK643NpXResZfUwNQjbxu6N9IY
         sjOM9FV4hdl3y9WcEpwDI8zMT5T+kbEDkg/skO7Yct2RA92zXcTHCGxZ5/HzLNMbIPSG
         xI0A==
X-Gm-Message-State: AOAM530qoUrnWN8sNbRaCU5jFp4r8A1s/rzh6jzRznnvyu/i6fL5f+4U
        df0qV3P5ohbi6ZvlvX4ZG/lw/R3QkJjrdpg3cIeuYIFoW5Q=
X-Google-Smtp-Source: ABdhPJyvqnABqg6mvaB/IbD/smKfWMJZsFMwS1ZAqErX+JwSU0e7UktY4aOeeU9ILrsrfbcqpnXh5UkwWjrXTTlySGo=
X-Received: by 2002:a05:651c:b1f:: with SMTP id b31mr16093698ljr.0.1623091410157;
 Mon, 07 Jun 2021 11:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210607163103.632681-1-atomlin@redhat.com> <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
In-Reply-To: <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 7 Jun 2021 11:43:19 -0700
Message-ID: <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
To:     Waiman Long <llong@redhat.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 9:45 AM Waiman Long <llong@redhat.com> wrote:
>
> On 6/7/21 12:31 PM, Aaron Tomlin wrote:
> > At the present time, in the context of memcg OOM, even when
> > sysctl_oom_kill_allocating_task is enabled/or set, the "allocating"
> > task cannot be selected, as a target for the OOM killer.
> >
> > This patch removes the restriction entirely.
> >
> > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > ---
> >   mm/oom_kill.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index eefd3f5fde46..3bae33e2d9c2 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -1089,9 +1089,9 @@ bool out_of_memory(struct oom_control *oc)
> >               oc->nodemask = NULL;
> >       check_panic_on_oom(oc);
> >
> > -     if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
> > -         current->mm && !oom_unkillable_task(current) &&
> > -         oom_cpuset_eligible(current, oc) &&
> > +     if (sysctl_oom_kill_allocating_task && current->mm &&
> > +            !oom_unkillable_task(current) &&
> > +            oom_cpuset_eligible(current, oc) &&
> >           current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
> >               get_task_struct(current);
> >               oc->chosen = current;
>
> To provide more context for this patch, we are actually seeing that in a
> customer report about OOM happened in a container where the dominating
> task used up most of the memory and it happened to be the task that
> triggered the OOM with the result that no killable process could be
> found.

Why was there no killable process? What about the process allocating
the memory or is this remote memcg charging?

> I don't see a reason why this should be limited to a global OOM only.
>
> Acked-by: Waiman Long <longman@redhat.com>
>
> Cheers,
> Longman
>
