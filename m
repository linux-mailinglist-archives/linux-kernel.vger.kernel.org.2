Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE2F36F72D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhD3Ifa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 04:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhD3If3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 04:35:29 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F816C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:34:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 26-20020a05600c22dab029013efd7879b8so1298027wmg.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 01:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qmkitn5HYPbD9glHLe6Vv2dfXzjfNgbrEk6rBtVeZ0Q=;
        b=R54E5xAqO6EK/6j0xdVnLHJryXMFXvex3ztOZtXQa+ImfJC6zVVOP1D6gftyjXQSHR
         PPOac0A+MFrqfhnxi5z7gw5SR47cx5cKmUs9QiIpw0fH2tjz8MB7D7QmioAxddxAnNQk
         7kP96Eclra8cA3zd/m4A2KHpM0ncZ0xRZvi2k4GNO55Fy5TtFvilzcJY1DOzQxHHv8AH
         5GlfDrRisgd+9Fei7h9esXQ8sW7LylqJ+DL9sJeoLRu4yCx/CKWp6TtqWZF1HTohaO89
         PuMWtVbKkdW4PVnZfttmXsOLw6zEOLMNGtfiIaX5i4kEG5sBbgB+HnWUGPLy3FVQEgds
         e5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qmkitn5HYPbD9glHLe6Vv2dfXzjfNgbrEk6rBtVeZ0Q=;
        b=VOCMx6lnRRG9ZkvYS5EpaVMZzmHFk7o9X5nJyxGKfFRWFvc1whytoPxHKxfAozttHb
         JC6uxK7yHmH7VtQphrB1rli3ekcwooC14JK/+kZ/D/52BxfZ9lYV2tw1svUzJ6MIrbH5
         wdAleMybolLNLUY9RfKhWy00aL76DkYQ58U/Zyx4H7JMgy2esF7LcfgMTosOcwfyDFvF
         /DNBuMEqyxv3cDtIdk4BC9aR6l+cwt7wdvDvmWYYEtxfDSE3MqBFvXEsYNMzrhNleQaC
         /j2HF9TCpKq9w5YtU36sbzBupxWZo7FcxHfqOA/bYNr05hWdmrdMKCw2WptDphkbPJWh
         2M+w==
X-Gm-Message-State: AOAM5302YoANpQW6Xbs3O4CXwT8mihMFKn7MO8s9WI7ofGVWT14R1ynL
        Xodh1wNYkUiwU3KyofpMG6f3fWPCW9IchjeVuaPHyY2EUXVPlQ==
X-Google-Smtp-Source: ABdhPJwQ0cQsHl4mAJQymr+Xl1TlxlGphoe2cGpDJTdjblcyeQFXpxRms38rRxVyvUJyVtYjHYFUlNHcgpW5Jcigpbw=
X-Received: by 2002:a1c:c918:: with SMTP id f24mr5010590wmb.12.1619771679787;
 Fri, 30 Apr 2021 01:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com> <YIGuvh70JbE1Cx4U@google.com>
 <YIlNKds8klSiOalo@dhcp22.suse.cz> <CAOUHufYXzYs__HSgXC2NfYJGHQzZEE6C+AZ78cvNbrZk_VyKxQ@mail.gmail.com>
 <YIqDv+dQL73KAqjm@dhcp22.suse.cz>
In-Reply-To: <YIqDv+dQL73KAqjm@dhcp22.suse.cz>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 30 Apr 2021 02:34:28 -0600
Message-ID: <CAOUHufZEAVKYvLXQJsmYVmPkX1CDrMziq4Kd=GtauMW2G30g=g@mail.gmail.com>
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by too_many_isolated()
To:     Michal Hocko <mhocko@suse.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>, wfg@mail.ustc.edu.cn,
        Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 4:00 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 28-04-21 09:05:06, Yu Zhao wrote:
> > On Wed, Apr 28, 2021 at 5:55 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > > @@ -3334,8 +3285,17 @@ unsigned long try_to_free_pages(struct zonelist *zonelist, int order,
> > > >       set_task_reclaim_state(current, &sc.reclaim_state);
> > > >       trace_mm_vmscan_direct_reclaim_begin(order, sc.gfp_mask);
> > > >
> > > > +     nr_cpus = current_is_kswapd() ? 0 : num_online_cpus();
> > > > +     while (nr_cpus && !atomic_add_unless(&pgdat->nr_reclaimers, 1, nr_cpus)) {
> > > > +             if (schedule_timeout_killable(HZ / 10))
> > > > +                     return SWAP_CLUSTER_MAX;
> > > > +     }
> > > > +
> > > >       nr_reclaimed = do_try_to_free_pages(zonelist, &sc);
> > > >
> > > > +     if (nr_cpus)
> > > > +             atomic_dec(&pgdat->nr_reclaimers);
> > > > +
> > > >       trace_mm_vmscan_direct_reclaim_end(nr_reclaimed);
> > > >       set_task_reclaim_state(current, NULL);
> > >
> > > This will surely break any memcg direct reclaim.
> >
> > Mind elaborating how it will "surely" break any memcg direct reclaim?
>
> I was wrong here. I though this is done in a common path for all direct
> reclaimers (likely mixed up try_to_free_pages with do_try_free_pages).
> Sorry about the confusion.
>
> Still, I do not think that the above heuristic will work properly.
> Different reclaimers have a different reclaim target (e.g. lower zones
> and/or numa node mask) and strength (e.g.  GFP_NOFS vs. GFP_KERNEL). A
> simple count based throttling would be be prone to different sorts of
> priority inversions.

I see where your concern is coming from. Let's look at it from
multiple angles, and hopefully this will clear things up.

1, looking into this approach:
This approach limits the number of direct reclaimers without any bias.
It doesn't favor or disfavor anybody. IOW, everyone has an equal
chance to run, regardless of the reclaim parameters. So where does the
inversion come from?

2, comparing it with the existing code:
Both try to limit direct reclaims,: one by the number of isolated
pages and the other by the number of concurrent direct reclaimers.
Neither numbers are correlated with any parameters you mentioned above
except the following:

too_many_isolated()
{
...
        /*
         * GFP_NOIO/GFP_NOFS callers are allowed to isolate more pages, so they
         * won't get blocked by normal direct-reclaimers, forming a circular
         * deadlock.
         */
        if ((sc->gfp_mask & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS))
                inactive >>= 3;
...
}

Let's at the commit that added the above:

commit 3cf23841b4b7 ("mm/vmscan.c: avoid possible deadlock caused by
too_many_isolated()"):
Date:   Tue Dec 18 14:23:31 2012 -0800

    Neil found that if too_many_isolated() returns true while performing
    direct reclaim we can end up waiting for other threads to complete their
    direct reclaim.  If those threads are allowed to enter the FS or IO to
    free memory, but this thread is not, then it is possible that those
    threads will be waiting on this thread and so we get a circular deadlock.

    some task enters direct reclaim with GFP_KERNEL
      => too_many_isolated() false
        => vmscan and run into dirty pages
          => pageout()
            => take some FS lock
              => fs/block code does GFP_NOIO allocation
                => enter direct reclaim again
                  => too_many_isolated() true
                    => waiting for others to progress, however the other
                       tasks may be circular waiting for the FS lock..

Hmm, how could reclaim be recursive nowadays?

__alloc_pages_slowpath()
{
...

        /* Avoid recursion of direct reclaim */
        if (current->flags & PF_MEMALLOC)
                goto nopage;

        /* Try direct reclaim and then allocating */
        page = __alloc_pages_direct_reclaim()
...
}

Let's assume it still could, do you remember the following commit?

commit db73ee0d4637 ("mm, vmscan: do not loop on too_many_isolated for ever")
Date:   Wed Sep 6 16:21:11 2017 -0700

If too_many_isolated() does loop forever anymore, how could the above
deadlock happen? IOW, why would we need the first commit nowadays?

If you don't remember the second commit, let me jog your memory:

Author: Michal Hocko <mhocko@suse.com>

3, thinking abstractly
A problem hard to solve in one domain can become a walk in the park in
another domain. This problem is a perfect example: it's different to
solve based on the number of isolated pages; but it becomes a lot
easier based on the number of direct reclaimers.

But there is a caveat: when we transform to a new domain, we need to
preserve the "reclaim target and strength" you mentioned. Fortunately,
there is nothing to preserve, because the existing code has none,
given that the "__GFP_IO | __GFP_FS" check in too_many_isolated() is
obsolete.

Does it make sense?
