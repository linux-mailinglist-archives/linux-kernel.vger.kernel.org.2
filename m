Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2629839E72E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhFGTHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhFGTHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:07:00 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BC3C061766
        for <linux-kernel@vger.kernel.org>; Mon,  7 Jun 2021 12:05:00 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id e2so23689131ljk.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 12:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=584/gWVYBmFQLj3IQ5zyJ4dNtEgEGoArMTADKdS4gTk=;
        b=p3L92naUFwi467EouA6JNCUQ4u8umdXEj3NG5PyEzPzphb+xmuCHY/zFXNnB+bKsOw
         zPVvblzivgT2Q68UNRrqJWbfJtnXmsLY1VDwKjpyK+9wECPAohRm0SbjJ6Q9RKPu6Vyl
         gS+z01ttu3j4Z34XZxiub1BSXOTC4sTCvxfn5i84oEB4nWYdXBSV1i5r6CiTZMf/foB5
         PEMDjSNA2Lg8m0BQBDTGsHMYrZ2DCz9paW5JRhHHhU1KBzzL2jhyLo3hBAl+QT9ic7O2
         S8M4oObpIxS86CoxCQMgOwX3JSwwRn+tnV+wx8DF/8Fh2rKLusj+dGL/G74ubmv2Os79
         UNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=584/gWVYBmFQLj3IQ5zyJ4dNtEgEGoArMTADKdS4gTk=;
        b=qzIYTQ0cEkCF5j8H5LXKC80QRojVIX0bJykqidL03vKYo1wPpHUDGmHcmKisSTHdnl
         UR2o9KHjCcigQ6WcvzivvjbLU5t9rGR2jLM5HcMqjhZTlIwkSn+VnvHFl15cH1oeXOz6
         87vawi3WiLw5LUMW+7pcogHALQDzVNN8WSx0IA4FQkeeYbe4YJ/8yhFAP69oOYHRt01I
         aqyHqKB4wVQNtTgWkFHTFY5MZrnq+xo/B9ZE0l4mDpXbfCyfASxYtURl/jWxHkpD616c
         tnBFBqFTFexjkNhN5ba4/388JAyliTDCZt8QPUsvlTpbpBrforyFz1Ja2eAaX78l9Ul+
         T5jg==
X-Gm-Message-State: AOAM531UF94p0Qn77NATTcN1+1gU5xszAmjacXU1YIY9r4JBmQ41pNwx
        ZRpH1yN5YHxA1rPXGqFDhT38vVnAst/bcSOfri4gLjLPzOKHMA==
X-Google-Smtp-Source: ABdhPJzEwN4BlseyqFQcJajb/NDLov6wrlyFqwxTzjDUEUqd3pWDJjwZZIfZBi8HNeR0LzFyGqbeh6qhJTEc6fBoBko=
X-Received: by 2002:a05:651c:b1f:: with SMTP id b31mr16143742ljr.0.1623092698491;
 Mon, 07 Jun 2021 12:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210607163103.632681-1-atomlin@redhat.com> <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com> <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
In-Reply-To: <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 7 Jun 2021 12:04:47 -0700
Message-ID: <CALvZod71SyjvC7sRtkD7dSEeAbYH_ynvO_hDS=tY6KCt-kRJkQ@mail.gmail.com>
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

On Mon, Jun 7, 2021 at 11:51 AM Waiman Long <llong@redhat.com> wrote:
>
> On 6/7/21 2:43 PM, Shakeel Butt wrote:
> > On Mon, Jun 7, 2021 at 9:45 AM Waiman Long <llong@redhat.com> wrote:
> >> On 6/7/21 12:31 PM, Aaron Tomlin wrote:
> >>> At the present time, in the context of memcg OOM, even when
> >>> sysctl_oom_kill_allocating_task is enabled/or set, the "allocating"
> >>> task cannot be selected, as a target for the OOM killer.
> >>>
> >>> This patch removes the restriction entirely.
> >>>
> >>> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> >>> ---
> >>>    mm/oom_kill.c | 6 +++---
> >>>    1 file changed, 3 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> >>> index eefd3f5fde46..3bae33e2d9c2 100644
> >>> --- a/mm/oom_kill.c
> >>> +++ b/mm/oom_kill.c
> >>> @@ -1089,9 +1089,9 @@ bool out_of_memory(struct oom_control *oc)
> >>>                oc->nodemask = NULL;
> >>>        check_panic_on_oom(oc);
> >>>
> >>> -     if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
> >>> -         current->mm && !oom_unkillable_task(current) &&
> >>> -         oom_cpuset_eligible(current, oc) &&
> >>> +     if (sysctl_oom_kill_allocating_task && current->mm &&
> >>> +            !oom_unkillable_task(current) &&
> >>> +            oom_cpuset_eligible(current, oc) &&
> >>>            current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
> >>>                get_task_struct(current);
> >>>                oc->chosen = current;
> >> To provide more context for this patch, we are actually seeing that in a
> >> customer report about OOM happened in a container where the dominating
> >> task used up most of the memory and it happened to be the task that
> >> triggered the OOM with the result that no killable process could be
> >> found.
> > Why was there no killable process? What about the process allocating
> > the memory or is this remote memcg charging?
>
> It is because the other processes have a oom_adjust_score of -1000. So
> they are non-killable. Anyway, they don't consume that much memory and
> killing them won't free up that much.
>
> The other process that uses most of the memory is the one that trigger
> the OOM kill in the first place because the memory limit has been
> reached in new memory allocation. Based on the current logic, this
> process cannot be killed at all even if we set the
> oom_kill_allocating_task to 1 if the OOM happens only within the memcg
> context, not in a global OOM situation.

I am not really against the patch but I am still not able to
understand why select_bad_process() was not able to select the current
process. mem_cgroup_scan_tasks() traverses all the processes in the
target memcg hierarchy, so why the current was skipped.

> This patch is to allow this
> process to be killed under this circumstance.
>
> Cheers,
> Longman
>
