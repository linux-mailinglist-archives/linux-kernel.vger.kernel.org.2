Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1006039E72B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhFGTGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:06:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:37996 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhFGTGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:06:02 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2254C1FD33;
        Mon,  7 Jun 2021 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623092650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MIqVGJKzmXDAXOFL3y218dPmkQhomVPxHjxGP6cf2oI=;
        b=GZMRzh8DRwl34CCsYB7uzZzw7/3QHpZPSy/CukU5wHHXg4ADhpNopRhKVM2v0vP1/LyBfY
        TQ0Y6v/E9puRcL8+Ez8cYRIDnHDdp1dhwc0QDaYCzYY2z3+DqkFCR3mUZU+1RkBGRUjRnS
        RUX9aRoLcCn+q7h59A0NqY5diXpRuD0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EA41DA3BDE;
        Mon,  7 Jun 2021 19:04:09 +0000 (UTC)
Date:   Mon, 7 Jun 2021 21:04:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Waiman Long <llong@redhat.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm/oom_kill: allow oom kill allocating task for
 non-global case
Message-ID: <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
References: <20210607163103.632681-1-atomlin@redhat.com>
 <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-06-21 14:51:05, Waiman Long wrote:
> On 6/7/21 2:43 PM, Shakeel Butt wrote:
> > On Mon, Jun 7, 2021 at 9:45 AM Waiman Long <llong@redhat.com> wrote:
> > > On 6/7/21 12:31 PM, Aaron Tomlin wrote:
> > > > At the present time, in the context of memcg OOM, even when
> > > > sysctl_oom_kill_allocating_task is enabled/or set, the "allocating"
> > > > task cannot be selected, as a target for the OOM killer.
> > > > 
> > > > This patch removes the restriction entirely.
> > > > 
> > > > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > > > ---
> > > >    mm/oom_kill.c | 6 +++---
> > > >    1 file changed, 3 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > > index eefd3f5fde46..3bae33e2d9c2 100644
> > > > --- a/mm/oom_kill.c
> > > > +++ b/mm/oom_kill.c
> > > > @@ -1089,9 +1089,9 @@ bool out_of_memory(struct oom_control *oc)
> > > >                oc->nodemask = NULL;
> > > >        check_panic_on_oom(oc);
> > > > 
> > > > -     if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
> > > > -         current->mm && !oom_unkillable_task(current) &&
> > > > -         oom_cpuset_eligible(current, oc) &&
> > > > +     if (sysctl_oom_kill_allocating_task && current->mm &&
> > > > +            !oom_unkillable_task(current) &&
> > > > +            oom_cpuset_eligible(current, oc) &&
> > > >            current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
> > > >                get_task_struct(current);
> > > >                oc->chosen = current;
> > > To provide more context for this patch, we are actually seeing that in a
> > > customer report about OOM happened in a container where the dominating
> > > task used up most of the memory and it happened to be the task that
> > > triggered the OOM with the result that no killable process could be
> > > found.
> > Why was there no killable process? What about the process allocating
> > the memory or is this remote memcg charging?
> 
> It is because the other processes have a oom_adjust_score of -1000. So they
> are non-killable. Anyway, they don't consume that much memory and killing
> them won't free up that much.
> 
> The other process that uses most of the memory is the one that trigger the
> OOM kill in the first place because the memory limit has been reached in new
> memory allocation. Based on the current logic, this process cannot be killed
> at all even if we set the oom_kill_allocating_task to 1 if the OOM happens
> only within the memcg context, not in a global OOM situation. This patch is
> to allow this process to be killed under this circumstance.

Do you have the oom report? I do not see why the allocating task hasn't
been chosen.
-- 
Michal Hocko
SUSE Labs
