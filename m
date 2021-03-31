Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26BE3508FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 23:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbhCaVNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 17:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbhCaVNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 17:13:01 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 384FDC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:13:01 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id x9so4269qto.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=7ZNFgcsyvkRXWIbvwYMY03RQW5khQN/vbd/frFG/nUU=;
        b=s08LYvlJvhn6Snkowhi+e/QiTlMojStP5ZCr99DF6cd0W7h+JSpge4UyYmTjdxJlDE
         vK2Ee5fYWroXeMzqQ9lpiz/UeppjHK+QwiHN44goCfrX5dS9Dv6sjSHKkhvI6k9FtSh5
         utgLT/c5JquNraVvUVVBIk0pGvd/8JEboRMiTZNmc4tcXQEoNvxZYXltIY7JiBsU1ZDx
         F20oI7K97o7OslxraIKh5/b6FE3/TIdjpsaCuRDRPzL/f+pUilTSrq6vWA9rhIEgUmAU
         AKspx/xL86InAzl7u695FPCDrHMQ9JC7OnbUn7DqgnwMQQJQxoVRRFR6FqGS/b3EybPU
         8ghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=7ZNFgcsyvkRXWIbvwYMY03RQW5khQN/vbd/frFG/nUU=;
        b=jmxoZKvsjUXzSclNzwcL/4tycqZw7DJD4iDmftNTNUHlw4m9eySjqjJf30Kd8K3g6B
         CPk7f/Qd0Con1UEKV0tJXI8kVbJxK+5W8ko9YhFseBmX4pYiFJNUjpPKqiB5hYXSFZ/f
         K5WYQ2qispEkI9FkzkQ9FQ/Y95y/dEa2vRTW4cvfzoO1cEmDIl99E97oAmI4ph5lSSye
         YHUXh2KOgsIwuNdIuQhLy1xIELKHQTSnHUF+mlSpTDtqH44NfIIJgS8qBq9wmmGy/lJO
         FoJOQjve2fBrWrPujuOOV/o6Dy2Zws99FbHv5a32cijhWrqV/39QAK9OQsJEFBwRYMZk
         2SfQ==
X-Gm-Message-State: AOAM5325tQV6r1wmBAgkEq2PZaLT9xtyGnHWfLNI0yJ4NSlvlo3XKYvb
        SOo9JuCxLp+ToYRh6aeru7Lixw==
X-Google-Smtp-Source: ABdhPJypuvcI13xS3gv2XogUYnau5xzu0OLfJoKlAsPJGfjyyA9wWQZV+IqmclZEIKYhTdv+YWlbSA==
X-Received: by 2002:ac8:5510:: with SMTP id j16mr4224125qtq.339.1617225180064;
        Wed, 31 Mar 2021 14:13:00 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id g11sm2396778qkk.5.2021.03.31.14.12.58
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 31 Mar 2021 14:12:59 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:12:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Roman Gushchin <guro@fb.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH mmotm] mm: vmscan: fix shrinker_rwsem in
 free_shrinker_info()
In-Reply-To: <CAHbLzkqDAOUjhV0-M-Mv6z7yKHk-WmuHHwJse4vvo82nJscTcA@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2103311340080.1201@eggly.anvils>
References: <alpine.LSU.2.11.2103301640240.2584@eggly.anvils> <CALvZod7PQ3=1nDUKVo33o5GGh-feGNM2LyekSys-U2-kOYbrTA@mail.gmail.com> <CAHbLzkqDAOUjhV0-M-Mv6z7yKHk-WmuHHwJse4vvo82nJscTcA@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021, Yang Shi wrote:
> On Wed, Mar 31, 2021 at 6:54 AM Shakeel Butt <shakeelb@google.com> wrote:
> > On Tue, Mar 30, 2021 at 4:44 PM Hugh Dickins <hughd@google.com> wrote:
> > >
> > > Lockdep warns mm/vmscan.c: suspicious rcu_dereference_protected() usage!
> > > when free_shrinker_info() is called from mem_cgroup_css_free(): there it
> > > is called with no locking, whereas alloc_shrinker_info() calls it with
> > > down_write of shrinker_rwsem - which seems appropriate.  Rearrange that
> > > so free_shrinker_info() can manage the shrinker_rwsem for itself.
> > >
> > > Link: https://lkml.kernel.org/r/20210317140615.GB28839@xsang-OptiPlex-9020
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > Cc: Yang Shi <shy828301@gmail.com>
> > > ---
> > > Sorry, I've made no attempt to work out precisely where in the series
> > > the locking went missing, nor tried to fit this in as a fix on top of
> > > mm-vmscan-add-shrinker_info_protected-helper.patch
> > > which Oliver reported (and which you notated in mmotm's "series" file).
> > > This patch just adds the fix to the end of the series, after
> > > mm-vmscan-shrink-deferred-objects-proportional-to-priority.patch
> >
> > The patch "mm: vmscan: add shrinker_info_protected() helper" replaces
> > rcu_dereference_protected(shrinker_info, true) with
> > rcu_dereference_protected(shrinker_info,
> > lockdep_is_held(&shrinker_rwsem)).
> >
> > I think we don't really need shrinker_rwsem in free_shrinker_info()
> > which is called from css_free(). The bits of the map have already been
> > 'reparented' in css_offline. I think we can remove
> > lockdep_is_held(&shrinker_rwsem) for free_shrinker_info().
> 
> Thanks, Hugh and Shakeel. I missed the report.
> 
> I think Shakeel is correct, shrinker_rwsem is not required in css_free
> path so Shakeel's proposal should be able to fix it.

Yes, looking at it again, I am sure that Shakeel is right, and
that my patch was overkill - no need for shrinker_rwsem there.

Whether it's RCU-safe to free the info there, I have not reviewed at
all: but shrinker_rwsem would not help even if there were an issue.

> I prepared a patch:

Unsigned, white-space damaged, so does not apply.

> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 64bf07cc20f2..7348c26d4cac 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -251,7 +251,12 @@ void free_shrinker_info(struct mem_cgroup *memcg)
>         for_each_node(nid) {
>                 pn = memcg->nodeinfo[nid];
> -               info = shrinker_info_protected(memcg, nid);
> +               /*
> +                * Don't use shrinker_info_protected() helper since
> +                * free_shrinker_info() could be called by css_free()
> +                * without holding shrinker_rwsem.
> +                */

Just because I mis-inferred from the use of shrinker_info_protected()
that shrinker_rwsem was needed here, is no reason to add that comment:
imagine how unhelpfully bigger the kernel source would be if we added
a comment everywhere I had misunderstood something!

> +               info = rcu_dereference_protected(pn->shrinker_info, true);
>                 kvfree(info);
>                 rcu_assign_pointer(pn->shrinker_info, NULL);
>         }

That does it, but I bikeshedded with myself in the encyclopaedic
rcupdate.h, and decided rcu_replace_pointer(pn->shrinker_info, NULL, true)
would be best.  But now see that patch won't fit so well into your series,
and I can't spend more time writing up a justification for it.

I think Andrew should simply delete my fix patch from his queue,
and edit out the
@@ -232,7 +239,7 @@ void free_shrinker_info(struct mem_cgrou
 
 	for_each_node(nid) {
 		pn = memcg->nodeinfo[nid];
-		info = rcu_dereference_protected(pn->shrinker_info, true);
+		info = shrinker_info_protected(memcg, nid);
 		kvfree(info);
 		rcu_assign_pointer(pn->shrinker_info, NULL);
 	}
hunk from your mm-vmscan-add-shrinker_info_protected-helper.patch
which will then restore free_shrinker_info() to what you propose above.

Thanks,
Hugh
