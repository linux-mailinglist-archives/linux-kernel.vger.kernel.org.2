Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAC53505FD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 20:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbhCaSHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 14:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbhCaSGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:06:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD48FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:06:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a7so31416438ejs.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 11:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bPry98kQuEJMZSqqwWzXWqlYcpUCBUTAk2E80YAvU4I=;
        b=VKnLzC4GTfPXZwNUPDlTxAcEUXvAjFdJozQ2D7TCqEMVlq5xc7+uXcF1NQ3GCeN3cn
         J+Bke+cuLbC0DEfXIXQwgK1ZtuAi1A+X96HnuTso2Df1beu4BzBTEwn+4JCzSPXV/44I
         dqKQIxFxnEjIG8WsdD1VnolxLcJS54HhC1uOM3tA9N88aJbnkdDLxCwAk/yP1Ka/9KBm
         kYZrJBYjpOHVdnfqLr+yVlqDIAa4o3v+1bzC3RgizjL9V7ENYlAMpClVUrlY3KqDlyv0
         kgQgs8PPwjLoFKN+rxLMftReKIQzC9i1xYnTMyebUrZwbpN6plKGwrhUnbjDyazc5nTN
         Z4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bPry98kQuEJMZSqqwWzXWqlYcpUCBUTAk2E80YAvU4I=;
        b=DN85wCcF8Jl1Q/lzearnWduKBYb8r5Qem2MPUcDF4oIaxQ1EnoYjQamESOJsumyzYP
         F2BaTLEi1900mu7zwqxCFFMgtsds+E3IGHXCLKE84mPB1St2wb0TcrRS/5NMJXG154/e
         jYI1SOFodHdc9yL9bGfNIs5Hk61GLfYHRuu74ooLnmyAJmdYfnMjBVaSqnvuYyIQCc7P
         ey8WQMtjfpfZRLuQn2fUNstDd15O22dWQqbuJ3CltpqZtfaZKhvw35RvxYu+57+eaQL6
         BVzKFb7vpILuyjE/x0vI6dvm78Ku6qZ5seo3sXAwzFzLNPhpkjZdsFr6T7P6xZ4gEzq5
         jAMw==
X-Gm-Message-State: AOAM532pDhAURykHUilA3IBu2+Nv3/H/TOV/JELRKLCimC6LY3jt3vPh
        TLQgxmUAqcd2uW3htqeE4AVAEfol2RxvA6nEXEE=
X-Google-Smtp-Source: ABdhPJxvUcuM7+TGuYwjesKc0OeSCCK2LQ6H3RaVWsqVduH9uEGQlWgeY/WodqmAKVfqJ6Q2Pxd/moBYJl+RhrKnZxA=
X-Received: by 2002:a17:906:4bce:: with SMTP id x14mr4829937ejv.383.1617214011464;
 Wed, 31 Mar 2021 11:06:51 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2103301640240.2584@eggly.anvils> <CALvZod7PQ3=1nDUKVo33o5GGh-feGNM2LyekSys-U2-kOYbrTA@mail.gmail.com>
In-Reply-To: <CALvZod7PQ3=1nDUKVo33o5GGh-feGNM2LyekSys-U2-kOYbrTA@mail.gmail.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 31 Mar 2021 11:06:39 -0700
Message-ID: <CAHbLzkqDAOUjhV0-M-Mv6z7yKHk-WmuHHwJse4vvo82nJscTcA@mail.gmail.com>
Subject: Re: [PATCH mmotm] mm: vmscan: fix shrinker_rwsem in free_shrinker_info()
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
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

On Wed, Mar 31, 2021 at 6:54 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Tue, Mar 30, 2021 at 4:44 PM Hugh Dickins <hughd@google.com> wrote:
> >
> > Lockdep warns mm/vmscan.c: suspicious rcu_dereference_protected() usage!
> > when free_shrinker_info() is called from mem_cgroup_css_free(): there it
> > is called with no locking, whereas alloc_shrinker_info() calls it with
> > down_write of shrinker_rwsem - which seems appropriate.  Rearrange that
> > so free_shrinker_info() can manage the shrinker_rwsem for itself.
> >
> > Link: https://lkml.kernel.org/r/20210317140615.GB28839@xsang-OptiPlex-9020
> > Reported-by: kernel test robot <oliver.sang@intel.com>
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Cc: Yang Shi <shy828301@gmail.com>
> > ---
> > Sorry, I've made no attempt to work out precisely where in the series
> > the locking went missing, nor tried to fit this in as a fix on top of
> > mm-vmscan-add-shrinker_info_protected-helper.patch
> > which Oliver reported (and which you notated in mmotm's "series" file).
> > This patch just adds the fix to the end of the series, after
> > mm-vmscan-shrink-deferred-objects-proportional-to-priority.patch
>
> The patch "mm: vmscan: add shrinker_info_protected() helper" replaces
> rcu_dereference_protected(shrinker_info, true) with
> rcu_dereference_protected(shrinker_info,
> lockdep_is_held(&shrinker_rwsem)).
>
> I think we don't really need shrinker_rwsem in free_shrinker_info()
> which is called from css_free(). The bits of the map have already been
> 'reparented' in css_offline. I think we can remove
> lockdep_is_held(&shrinker_rwsem) for free_shrinker_info().

Thanks, Hugh and Shakeel. I missed the report.

I think Shakeel is correct, shrinker_rwsem is not required in css_free
path so Shakeel's proposal should be able to fix it. I prepared a
patch:

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 64bf07cc20f2..7348c26d4cac 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -251,7 +251,12 @@ void free_shrinker_info(struct mem_cgroup *memcg)
        for_each_node(nid) {
                pn = memcg->nodeinfo[nid];
-               info = shrinker_info_protected(memcg, nid);
+               /*
+                * Don't use shrinker_info_protected() helper since
+                * free_shrinker_info() could be called by css_free()
+                * without holding shrinker_rwsem.
+                */
+               info = rcu_dereference_protected(pn->shrinker_info, true);
                kvfree(info);
                rcu_assign_pointer(pn->shrinker_info, NULL);
        }
>
> >
> >  mm/vmscan.c |   10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > --- mmotm/mm/vmscan.c   2021-03-28 17:26:54.935553064 -0700
> > +++ linux/mm/vmscan.c   2021-03-30 15:55:13.374459559 -0700
> > @@ -249,18 +249,20 @@ void free_shrinker_info(struct mem_cgrou
> >         struct shrinker_info *info;
> >         int nid;
> >
> > +       down_write(&shrinker_rwsem);
> >         for_each_node(nid) {
> >                 pn = memcg->nodeinfo[nid];
> >                 info = shrinker_info_protected(memcg, nid);
> >                 kvfree(info);
> >                 rcu_assign_pointer(pn->shrinker_info, NULL);
> >         }
> > +       up_write(&shrinker_rwsem);
> >  }
> >
> >  int alloc_shrinker_info(struct mem_cgroup *memcg)
> >  {
> >         struct shrinker_info *info;
> > -       int nid, size, ret = 0;
> > +       int nid, size;
> >         int map_size, defer_size = 0;
> >
> >         down_write(&shrinker_rwsem);
> > @@ -270,9 +272,9 @@ int alloc_shrinker_info(struct mem_cgrou
> >         for_each_node(nid) {
> >                 info = kvzalloc_node(sizeof(*info) + size, GFP_KERNEL, nid);
> >                 if (!info) {
> > +                       up_write(&shrinker_rwsem);
> >                         free_shrinker_info(memcg);
> > -                       ret = -ENOMEM;
> > -                       break;
> > +                       return -ENOMEM;
> >                 }
> >                 info->nr_deferred = (atomic_long_t *)(info + 1);
> >                 info->map = (void *)info->nr_deferred + defer_size;
> > @@ -280,7 +282,7 @@ int alloc_shrinker_info(struct mem_cgrou
> >         }
> >         up_write(&shrinker_rwsem);
> >
> > -       return ret;
> > +       return 0;
> >  }
> >
> >  static inline bool need_expand(int nr_max)
