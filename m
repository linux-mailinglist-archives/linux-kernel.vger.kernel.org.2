Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077F836E849
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237378AbhD2KBU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:01:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:56660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhD2KBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:01:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619690432; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31407DLnmLwejk27vgVXyGGJg2ufhzGONjmkzpsZya8=;
        b=M0Q8tIwfVwl5DPf9Ho2jPPMdkzpxIM8VdLVeTYuZakKBJlHgwdFIAaTjx6no2zCsxCfk7z
        DU20ipaDet4ukmls9qtk0rbOefE5SZ24uCO17eKrWxoPZBGGWFTRJYvy9ZdZt51jKj2f3j
        567IViBm361RLgAle5Q3R+IpEzGgZ/Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52EFFAE58;
        Thu, 29 Apr 2021 10:00:32 +0000 (UTC)
Date:   Thu, 29 Apr 2021 12:00:31 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>, wfg@mail.ustc.edu.cn,
        Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by
 too_many_isolated()
Message-ID: <YIqDv+dQL73KAqjm@dhcp22.suse.cz>
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com>
 <YIGuvh70JbE1Cx4U@google.com>
 <YIlNKds8klSiOalo@dhcp22.suse.cz>
 <CAOUHufYXzYs__HSgXC2NfYJGHQzZEE6C+AZ78cvNbrZk_VyKxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOUHufYXzYs__HSgXC2NfYJGHQzZEE6C+AZ78cvNbrZk_VyKxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 28-04-21 09:05:06, Yu Zhao wrote:
> On Wed, Apr 28, 2021 at 5:55 AM Michal Hocko <mhocko@suse.com> wrote:
[...]
> > > @@ -3334,8 +3285,17 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> > >       set_task_reclaim_state(current, &sc.reclaim_state);
> > >       trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
> > >
> > > +     nr_cpus = current_is_kswapd() ? 0 : num_online_cpus();
> > > +     while (nr_cpus && !atomic_add_unless(&pgdat->nr_reclaimers, 1, nr_cpus)) {
> > > +             if (schedule_timeout_killable(HZ / 10))
> > > +                     return SWAP_CLUSTER_MAX;
> > > +     }
> > > +
> > >       nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
> > >
> > > +     if (nr_cpus)
> > > +             atomic_dec(&pgdat->nr_reclaimers);
> > > +
> > >       trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
> > >       set_task_reclaim_state(current, NULL);
> >
> > This will surely break any memcg direct reclaim.
> 
> Mind elaborating how it will "surely" break any memcg direct reclaim?

I was wrong here. I though this is done in a common path for all direct
reclaimers (likely mixed up try_to_free_pages with do_try_free_pages).
Sorry about the confusion.

Still, I do not think that the above heuristic will work properly.
Different reclaimers have a different reclaim target (e.g. lower zones
and/or numa node mask) and strength (e.g.  GFP_NOFS vs. GFP_KERNEL). A
simple count based throttling would be be prone to different sorts of
priority inversions. 
-- 
Michal Hocko
SUSE Labs
