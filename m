Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FF93D9361
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhG1QnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 12:43:12 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58028 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhG1QnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 12:43:11 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9AC4A22331;
        Wed, 28 Jul 2021 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627490588; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=03doPF0Hm9VX9+U1BaRb0OdFxpJZ53fMHg22McZ99ig=;
        b=eaol6RxXf7+m2YKwFbYesAbm4xgVs/1VQcxOfo++HD7LxE1zGg6ukvWgka8lVscyStIBep
        e6F0QMB3gKyfxylz7xo9HPQ0proQV82xTS1TyNw0T6g1c0hz0J+T4LZL2hYtLcrqG9dF85
        db4KjKnW2o2SWDr5LuCOQWBurbOrTOs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 918D4A3B83;
        Wed, 28 Jul 2021 16:43:07 +0000 (UTC)
Date:   Wed, 28 Jul 2021 18:43:07 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Roman Gushchin <guro@fb.com>, Wang Hai <wanghai38@huawei.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexei Starovoitov <ast@kernel.org>,
        wangkefeng.wang@huawei.com, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/memcg: fix NULL pointer dereference in
 memcg_slab_free_hook()
Message-ID: <YQGJG6BWQIYWeiK2@dhcp22.suse.cz>
References: <20210728091348.272714-1-wanghai38@huawei.com>
 <YQFaPwYzzy0UPzNI@dhcp22.suse.cz>
 <CALvZod7PzQ8dCpcBr7F1eKCDWCZ+RhHCzHj3pC3QS_CJAYSfDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7PzQ8dCpcBr7F1eKCDWCZ+RhHCzHj3pC3QS_CJAYSfDw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-07-21 07:10:26, Shakeel Butt wrote:
> +Roman
> 
> On Wed, Jul 28, 2021 at 6:23 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 28-07-21 17:13:48, Wang Hai wrote:
> > > When I use kfree_rcu() to free a large memory allocated by
> > > kmalloc_node(), the following dump occurs.
> > >
> > > BUG: kernel NULL pointer dereference, address: 0000000000000020
> > > [...]
> > > Oops: 0000 [#1] SMP
> > > [...]
> > > Workqueue: events kfree_rcu_work
> > > RIP: 0010:__obj_to_index include/linux/slub_def.h:182 [inline]
> > > RIP: 0010:obj_to_index include/linux/slub_def.h:191 [inline]
> > > RIP: 0010:memcg_slab_free_hook+0x120/0x260 mm/slab.h:363
> > > [...]
> > > Call Trace:
> > >  kmem_cache_free_bulk+0x58/0x630 mm/slub.c:3293
> > >  kfree_bulk include/linux/slab.h:413 [inline]
> > >  kfree_rcu_work+0x1ab/0x200 kernel/rcu/tree.c:3300
> > >  process_one_work+0x207/0x530 kernel/workqueue.c:2276
> > >  worker_thread+0x320/0x610 kernel/workqueue.c:2422
> > >  kthread+0x13d/0x160 kernel/kthread.c:313
> > >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> > >
> > > When kmalloc_node() a large memory, page is allocated, not slab,
> > > so when freeing memory via kfree_rcu(), this large memory should not
> > > be used by memcg_slab_free_hook(), because memcg_slab_free_hook() is
> > > is used for slab.
> > >
> > > So in this case, there is no need to do anything with this large
> > > page in memcg_slab_free_hook(), just skip it.
> > >
> > > Fixes: 270c6a71460e ("mm: memcontrol/slab: Use helpers to access slab page's memcg_data")
> >
> > Are you sure that this commit is really breaking the code. Unless I have
> > missed something there shouldn't be any real change wrt. large
> > allocations here. page_has_obj_cgroups is just a different name for what
> > what page_objcgs is giving us.
> 
> Actually they are different. For MEMCG_DATA_KMEM page,
> page_has_obj_cgroups() will return false while page_objcgs() on
> non-VM_DEBUG kernels will return "struct obj_cgroup *" instead of
> "struct obj_cgroup **".

Right. Thanks for the clarification. I have missed that subtle
difference.
-- 
Michal Hocko
SUSE Labs
