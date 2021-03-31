Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF4D350A9F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 01:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbhCaXPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 19:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbhCaXOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 19:14:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88379C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:14:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bx7so24166529edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+h9iiR2ETy9snk4Rjw3/0FtbakmqcM90iNL/G5npVZ4=;
        b=oDsltAsVhMfX34nC0ya4Ses+z/aSYpIGarCGUrQBWp8KhNJg4VrgfO+34voug6kVkf
         3CLBuPVFSwQMsklZgHWBzsmpGOZQJx4gZYwWEvBfuXSy4I9Yu8R56Bp59/GcBKkPmiR+
         C+sGFkX59EQ3tDxb2Al8NdvNlqnpuwt7ZjSPsrJ7lVEUuyJEZXnCbPCZzXfOZhYMdfbt
         /q6h2r3OZhTZCjQW9S4/yW0dfNW0RO+Vjg8+FttpqsCA9Or0z0chfBbM6be1eNN4H+uW
         QzBVRrfpzVD/ECfIC9Cn+LBTHcIM9xiXcQyoUje+OOx+LrTjvfT71wjfn+cfwVcwdEm2
         Uu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+h9iiR2ETy9snk4Rjw3/0FtbakmqcM90iNL/G5npVZ4=;
        b=gKx+Zvj+VmxignM8T8npMex2uBNx/IPmw9qVZBvez/AsRnPRYaFLEQZxjjB3arDxwx
         jTEDSi40eGQKgXa9aQAN+aIoNtBefQs9Im8uJYdrLhrqurXCBO6P5O27bwyZsFuH4lT8
         vGYoQ9bST30F+4QGvq48taXxfnTXH1hATvWm3Q6YVh5ihcdC2sekmJQBzighjNP8vVrY
         jSRGPypLg94n0g4Jh2zAq5XoVbT6rjonPzTFOHTu3QPEeIfsLSRLa9MkGwAeHr41Jm9f
         auOceq5ZE4IVGwM8UM4pNBTov1K+ye0yhwImx7cmfFk+Z1r9f7pY5FpyQbeBkvRFak08
         8XFw==
X-Gm-Message-State: AOAM533JNV/DG+0XI63JkiJB0fHq5o8MNFbaRndvugxnehQe3vWAgfK4
        hv1eHCM9La7BOZJTvwgYqelOlHwJQWk4qNgVO9KHZq/g3vg=
X-Google-Smtp-Source: ABdhPJyNAFcwBS9A1HYj+d5VqPFbHKIdG+b+86D+FZP03DVlhRYynUKUHoosRaSTO2mzV+WYKx7tQ344jJfVdJ6s/dc=
X-Received: by 2002:a50:ef11:: with SMTP id m17mr6663973eds.151.1617232487296;
 Wed, 31 Mar 2021 16:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2103301640240.2584@eggly.anvils>
 <CALvZod7PQ3=1nDUKVo33o5GGh-feGNM2LyekSys-U2-kOYbrTA@mail.gmail.com>
 <CAHbLzkqDAOUjhV0-M-Mv6z7yKHk-WmuHHwJse4vvo82nJscTcA@mail.gmail.com> <alpine.LSU.2.11.2103311340080.1201@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2103311340080.1201@eggly.anvils>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 31 Mar 2021 16:14:35 -0700
Message-ID: <CAHbLzkqg_AxD12rcgNy0Va_X2LTJ79FRuOhuLSb=RTkfDbH+EA@mail.gmail.com>
Subject: Re: [PATCH mmotm] mm: vmscan: fix shrinker_rwsem in free_shrinker_info()
To:     Hugh Dickins <hughd@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 2:13 PM Hugh Dickins <hughd@google.com> wrote:
>
> On Wed, 31 Mar 2021, Yang Shi wrote:
> > On Wed, Mar 31, 2021 at 6:54 AM Shakeel Butt <shakeelb@google.com> wrote:
> > > On Tue, Mar 30, 2021 at 4:44 PM Hugh Dickins <hughd@google.com> wrote:
> > > >
> > > > Lockdep warns mm/vmscan.c: suspicious rcu_dereference_protected() usage!
> > > > when free_shrinker_info() is called from mem_cgroup_css_free(): there it
> > > > is called with no locking, whereas alloc_shrinker_info() calls it with
> > > > down_write of shrinker_rwsem - which seems appropriate.  Rearrange that
> > > > so free_shrinker_info() can manage the shrinker_rwsem for itself.
> > > >
> > > > Link: https://lkml.kernel.org/r/20210317140615.GB28839@xsang-OptiPlex-9020
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > Signed-off-by: Hugh Dickins <hughd@google.com>
> > > > Cc: Yang Shi <shy828301@gmail.com>
> > > > ---
> > > > Sorry, I've made no attempt to work out precisely where in the series
> > > > the locking went missing, nor tried to fit this in as a fix on top of
> > > > mm-vmscan-add-shrinker_info_protected-helper.patch
> > > > which Oliver reported (and which you notated in mmotm's "series" file).
> > > > This patch just adds the fix to the end of the series, after
> > > > mm-vmscan-shrink-deferred-objects-proportional-to-priority.patch
> > >
> > > The patch "mm: vmscan: add shrinker_info_protected() helper" replaces
> > > rcu_dereference_protected(shrinker_info, true) with
> > > rcu_dereference_protected(shrinker_info,
> > > lockdep_is_held(&shrinker_rwsem)).
> > >
> > > I think we don't really need shrinker_rwsem in free_shrinker_info()
> > > which is called from css_free(). The bits of the map have already been
> > > 'reparented' in css_offline. I think we can remove
> > > lockdep_is_held(&shrinker_rwsem) for free_shrinker_info().
> >
> > Thanks, Hugh and Shakeel. I missed the report.
> >
> > I think Shakeel is correct, shrinker_rwsem is not required in css_free
> > path so Shakeel's proposal should be able to fix it.
>
> Yes, looking at it again, I am sure that Shakeel is right, and
> that my patch was overkill - no need for shrinker_rwsem there.
>
> Whether it's RCU-safe to free the info there, I have not reviewed at
> all: but shrinker_rwsem would not help even if there were an issue.
>
> > I prepared a patch:
>
> Unsigned, white-space damaged, so does not apply.
>
> >
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 64bf07cc20f2..7348c26d4cac 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -251,7 +251,12 @@ void free_shrinker_info(struct mem_cgroup *memcg)
> >         for_each_node(nid) {
> >                 pn = memcg->nodeinfo[nid];
> > -               info = shrinker_info_protected(memcg, nid);
> > +               /*
> > +                * Don't use shrinker_info_protected() helper since
> > +                * free_shrinker_info() could be called by css_free()
> > +                * without holding shrinker_rwsem.
> > +                */
>
> Just because I mis-inferred from the use of shrinker_info_protected()
> that shrinker_rwsem was needed here, is no reason to add that comment:
> imagine how unhelpfully bigger the kernel source would be if we added
> a comment everywhere I had misunderstood something!

Yes, I agree the comment may incur more confusion. Better remove it.

>
> > +               info = rcu_dereference_protected(pn->shrinker_info, true);
> >                 kvfree(info);
> >                 rcu_assign_pointer(pn->shrinker_info, NULL);
> >         }
>
> That does it, but I bikeshedded with myself in the encyclopaedic
> rcupdate.h, and decided rcu_replace_pointer(pn->shrinker_info, NULL, true)
> would be best.  But now see that patch won't fit so well into your series,
> and I can't spend more time writing up a justification for it.
>
> I think Andrew should simply delete my fix patch from his queue,
> and edit out the
> @@ -232,7 +239,7 @@ void free_shrinker_info(struct mem_cgrou
>
>         for_each_node(nid) {
>                 pn = memcg->nodeinfo[nid];
> -               info = rcu_dereference_protected(pn->shrinker_info, true);
> +               info = shrinker_info_protected(memcg, nid);
>                 kvfree(info);
>                 rcu_assign_pointer(pn->shrinker_info, NULL);
>         }
> hunk from your mm-vmscan-add-shrinker_info_protected-helper.patch
> which will then restore free_shrinker_info() to what you propose above.

Yes. I saw Andrew already had this fix in -mm tree.

>
> Thanks,
> Hugh
