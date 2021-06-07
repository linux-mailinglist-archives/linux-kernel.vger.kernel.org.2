Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF9D39E790
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 21:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhFGTim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 15:38:42 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51228 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFGTij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 15:38:39 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 88AFC219C1;
        Mon,  7 Jun 2021 19:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623094607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dMYKPJur+bblV8fB0rrtyqM/Pi0SpR71lsEX2LI8jjQ=;
        b=HZllzxztpoQLS++JYoiC3sW9cqieN0oZjMAL+7D5NxhhLT9rRvvzQ8jNo5AoqGHa3t970W
        SVc4F7bUolKY8B38Q57jAY1a/S8VGTd6L4e3rVnUojkYcjagDfpI9Gkg89sMllCfH7L8fA
        VF8I2jSzhJB/1pYkm2jmbKFtuli080M=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 57D5CA3BD1;
        Mon,  7 Jun 2021 19:36:47 +0000 (UTC)
Date:   Mon, 7 Jun 2021 21:36:46 +0200
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
Message-ID: <YL51Tp/3jVHUrpuj@dhcp22.suse.cz>
References: <20210607163103.632681-1-atomlin@redhat.com>
 <c16893a9-35e2-7625-d7f3-83488f874040@redhat.com>
 <CALvZod4eUoquGTQ5AsWgbWTQyqtCNNwb-9+fRw_ZPavH-r9dbA@mail.gmail.com>
 <dc7f54eb-933e-5bbb-7959-815dfbfcc836@redhat.com>
 <YL5tqdw+iWLLavxV@dhcp22.suse.cz>
 <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d23ce58-4c4b-116a-6d74-c2cf4947492b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07-06-21 15:18:38, Waiman Long wrote:
> On 6/7/21 3:04 PM, Michal Hocko wrote:
> > On Mon 07-06-21 14:51:05, Waiman Long wrote:
> > > On 6/7/21 2:43 PM, Shakeel Butt wrote:
> > > > On Mon, Jun 7, 2021 at 9:45 AM Waiman Long <llong@redhat.com> wrote:
> > > > > On 6/7/21 12:31 PM, Aaron Tomlin wrote:
> > > > > > At the present time, in the context of memcg OOM, even when
> > > > > > sysctl_oom_kill_allocating_task is enabled/or set, the "allocating"
> > > > > > task cannot be selected, as a target for the OOM killer.
> > > > > > 
> > > > > > This patch removes the restriction entirely.
> > > > > > 
> > > > > > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > > > > > ---
> > > > > >     mm/oom_kill.c | 6 +++---
> > > > > >     1 file changed, 3 insertions(+), 3 deletions(-)
> > > > > > 
> > > > > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > > > > index eefd3f5fde46..3bae33e2d9c2 100644
> > > > > > --- a/mm/oom_kill.c
> > > > > > +++ b/mm/oom_kill.c
> > > > > > @@ -1089,9 +1089,9 @@ bool out_of_memory(struct oom_control *oc)
> > > > > >                 oc->nodemask = NULL;
> > > > > >         check_panic_on_oom(oc);
> > > > > > 
> > > > > > -     if (!is_memcg_oom(oc) && sysctl_oom_kill_allocating_task &&
> > > > > > -         current->mm && !oom_unkillable_task(current) &&
> > > > > > -         oom_cpuset_eligible(current, oc) &&
> > > > > > +     if (sysctl_oom_kill_allocating_task && current->mm &&
> > > > > > +            !oom_unkillable_task(current) &&
> > > > > > +            oom_cpuset_eligible(current, oc) &&
> > > > > >             current->signal->oom_score_adj != OOM_SCORE_ADJ_MIN) {
> > > > > >                 get_task_struct(current);
> > > > > >                 oc->chosen = current;
> > > > > To provide more context for this patch, we are actually seeing that in a
> > > > > customer report about OOM happened in a container where the dominating
> > > > > task used up most of the memory and it happened to be the task that
> > > > > triggered the OOM with the result that no killable process could be
> > > > > found.
> > > > Why was there no killable process? What about the process allocating
> > > > the memory or is this remote memcg charging?
> > > It is because the other processes have a oom_adjust_score of -1000. So they
> > > are non-killable. Anyway, they don't consume that much memory and killing
> > > them won't free up that much.
> > > 
> > > The other process that uses most of the memory is the one that trigger the
> > > OOM kill in the first place because the memory limit has been reached in new
> > > memory allocation. Based on the current logic, this process cannot be killed
> > > at all even if we set the oom_kill_allocating_task to 1 if the OOM happens
> > > only within the memcg context, not in a global OOM situation. This patch is
> > > to allow this process to be killed under this circumstance.
> > Do you have the oom report? I do not see why the allocating task hasn't
> > been chosen.
> 
> A partial OOM report below:

Do you happen to have the full report?

> [ 8221.433608] memory: usage 21280kB, limit 204800kB, failcnt 49116
>   :
> [ 8227.239769] [ pid ]   uid  tgid total_vm      rss pgtables_bytes swapents  oom_score_adj name
> [ 8227.242495] [1611298]     0 1611298    35869      635 167936        0         -1000 conmon
> [ 8227.242518] [1702509]     0 1702509    35869      701 176128        0         -1000 conmon
> [ 8227.242522] [1703345] 1001050000 1703294   183440        0 2125824        0           999 node
> [ 8227.242706] Out of memory and no killable processes...
> [ 8227.242731] node invoked oom-killer: gfp_mask=0x6000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=999
> [ 8227.242732] node cpuset=crio-b8ac7e23f7b520c0365461defb66738231918243586e287bfb9e206bb3a0227a.scope mems_allowed=0-1
> 
> So in this case, node cannot kill itself and no other processes are
> available to be killed.

The process is clearly listed as eligible so the oom killer should find
it and if it hasn't then this should be investigated. Which kernel is
this?
-- 
Michal Hocko
SUSE Labs
