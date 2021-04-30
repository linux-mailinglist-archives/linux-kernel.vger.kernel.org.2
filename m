Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09F436FF25
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 19:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbhD3RFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 13:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbhD3RFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 13:05:51 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22B8C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 10:05:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id l14so1520930wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ef9fe3Au6iXOg8oECw1gAvJSq17/+FtuOxHdnbd2qQs=;
        b=cOM9YxXnZubuDxhIIhQclr+NWsfxbIv47SymfwxBPEOqNt9XlUcghOKU24KL1ydckx
         +STiiwZcwOExlo6OBZGoRcqvd34Q0mqMQVY3ioXlmC1LC3Ia65e5BccxlsBSvjlufLNK
         aDQmTS/AiPy0ihx5cHPRBESHL7AxHHs7e+LiPF57P1uZCnTC684leybf0VmVgjDtwngW
         s63XNL9xdaWeGl5/LKPWH6Y8vMlJiAn5/1j+vejyMwM6EjNktxViycRQE97XHwSi33jR
         Mj0+VNM47KdMw9iQDqfSaII216I24Ft+D2SIPJkw/Fs1BA+19FRhlYNx382HtGRQcSBz
         HTOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ef9fe3Au6iXOg8oECw1gAvJSq17/+FtuOxHdnbd2qQs=;
        b=eLDdtrdm64SCLorPTcHlDH91zlt79ZZYEiZD1r/OK97e2k5vmkdQUa6xY7dyjxmQkW
         HntL4IvjI+nDDKv2QAqtfKD8vDQ/hmWW39KSx/cTabql8FVeDdlf6wNuAcrOM1Tkcfkg
         0zwaS5CGS8NibfHz3L5QGpTQhYBQEspUGZUw4Mdc0fefLeslu0P5ptubIz1f7SsY0vpT
         7rp/JhuVbj6xhBbYKsXX4MhtVRPtS8svVxH72CMgwrwjgTAatEpDmmk6Hg7NqPQpQwAV
         ppsgC0RWvsL8RC0sXkENTt9TuBMwCszvHqpXT1rAfa/U7oiVvD1+oABLV5AhgOpDonl7
         DOUA==
X-Gm-Message-State: AOAM530ysBlEd1ZCtnRM3k/O0NsLsf3y2789WiFA1Y5tnKBPqD223JLE
        +ECEVyvBY7TPCAeWa87JEH6SavLtfl7iYKgSMvfmSg==
X-Google-Smtp-Source: ABdhPJzHYZmcpnQymDYuByc9ZujNal8ViIJt+704AIhqtiT8ouyvDBK9b7Mk4guwLGPFlDMUjbPrbfssdGFosS6oYWw=
X-Received: by 2002:a05:6000:110d:: with SMTP id z13mr8394875wrw.92.1619802301471;
 Fri, 30 Apr 2021 10:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com> <YIGuvh70JbE1Cx4U@google.com>
 <YIlNKds8klSiOalo@dhcp22.suse.cz> <CAOUHufYXzYs__HSgXC2NfYJGHQzZEE6C+AZ78cvNbrZk_VyKxQ@mail.gmail.com>
 <YIqDv+dQL73KAqjm@dhcp22.suse.cz> <CAOUHufZEAVKYvLXQJsmYVmPkX1CDrMziq4Kd=GtauMW2G30g=g@mail.gmail.com>
 <YIvLHX74rFrq0n9w@dhcp22.suse.cz>
In-Reply-To: <YIvLHX74rFrq0n9w@dhcp22.suse.cz>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 30 Apr 2021 11:04:49 -0600
Message-ID: <CAOUHufaTS+m35tQmrVvpn7FWAMXPELtWr=ZavAbR7Ew06L9OFw@mail.gmail.com>
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

On Fri, Apr 30, 2021 at 3:17 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 30-04-21 02:34:28, Yu Zhao wrote:
> > On Thu, Apr 29, 2021 at 4:00 AM Michal Hocko <mhocko@suse.com> wrote:
> [...]
> > > Still, I do not think that the above heuristic will work properly.
> > > Different reclaimers have a different reclaim target (e.g. lower zones
> > > and/or numa node mask) and strength (e.g.  GFP_NOFS vs. GFP_KERNEL). A
> > > simple count based throttling would be be prone to different sorts of
> > > priority inversions.
> >
> > I see where your concern is coming from. Let's look at it from
> > multiple angles, and hopefully this will clear things up.
> >
> > 1, looking into this approach:
> > This approach limits the number of direct reclaimers without any bias.
> > It doesn't favor or disfavor anybody. IOW, everyone has an equal
> > chance to run, regardless of the reclaim parameters. So where does the
> > inversion come from?
>
> Say you have a flood of GFP_KERNEL allocations contending with *MOVABLE
> allocations. The former will not be able to reclaim for any non-kernel
> zones. Similar effect would be contention of a heavy GFP_NOFS workload
> condending with others but not being able to release filesystem
> metadata.
>
> > 2, comparing it with the existing code:
> > Both try to limit direct reclaims,: one by the number of isolated
> > pages and the other by the number of concurrent direct reclaimers.
> > Neither numbers are correlated with any parameters you mentioned above
> > except the following:
> >
> > too_many_isolated()
> > {
> > ...
> >         /*
> >          * GFP_NOIO/GFP_NOFS callers are allowed to isolate more pages, so they
> >          * won't get blocked by normal direct-reclaimers, forming a circular
> >          * deadlock.
> >          */
> >         if ((sc->gfp_mask & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS))
> >                 inactive >>= 3;
> > ...
> > }
> >
> > Let's at the commit that added the above:
> >
> > commit 3cf23841b4b7 ("mm/vmscan.c: avoid possible deadlock caused by
> > too_many_isolated()"):
> > Date:   Tue Dec 18 14:23:31 2012 -0800
> >
> >     Neil found that if too_many_isolated() returns true while performing
> >     direct reclaim we can end up waiting for other threads to complete their
> >     direct reclaim.  If those threads are allowed to enter the FS or IO to
> >     free memory, but this thread is not, then it is possible that those
> >     threads will be waiting on this thread and so we get a circular deadlock.
> >
> >     some task enters direct reclaim with GFP_KERNEL
> >       => too_many_isolated() false
> >         => vmscan and run into dirty pages
> >           => pageout()
> >             => take some FS lock
> >               => fs/block code does GFP_NOIO allocation
> >                 => enter direct reclaim again
> >                   => too_many_isolated() true
> >                     => waiting for others to progress, however the other
> >                        tasks may be circular waiting for the FS lock..
> >
> > Hmm, how could reclaim be recursive nowadays?
>
> I do not think it is. And I doubt it was back then and I also think the
> above is not suggesting a recursion really. I tries to avoid a situation
> when fs/block layer cannot make a fwd progress because it is being
> blocked.
>
> > __alloc_pages_slowpath()
> > {
> > ...
> >
> >         /* Avoid recursion of direct reclaim */
> >         if (current->flags & PF_MEMALLOC)
> >                 goto nopage;
> >
> >         /* Try direct reclaim and then allocating */
> >         page = __alloc_pages_direct_reclaim()
> > ...
> > }
> >
> > Let's assume it still could, do you remember the following commit?
> >
> > commit db73ee0d4637 ("mm, vmscan: do not loop on too_many_isolated for ever")
> > Date:   Wed Sep 6 16:21:11 2017 -0700
> >
> > If too_many_isolated() does loop forever anymore, how could the above
> > deadlock happen? IOW, why would we need the first commit nowadays?
>
> Whether the Neil's commit is still needed would require a deeper
> analysis. Even back then we didn't perform pageout for fs dirty pages
> from the direct reclaim IIRC.
>
> > If you don't remember the second commit, let me jog your memory:
>
> Yes i do remember that one and that was handling a dependency between
> kswapd (which is allowed to perform pageout on diryt fs data) which
> is blocked and it prevents direct reclaimers to make a fwd progress e.g.
> by declaring OOM. This was mostly a band aid rather than a systematic
> solution. And it clearly shows limits of the existing approach. Please
> note that I am not trying to defend what we have now. I am just pointing
> out that strict count based approach will hit other problems.
>
> > Author: Michal Hocko <mhocko@suse.com>
> >
> > 3, thinking abstractly
> > A problem hard to solve in one domain can become a walk in the park in
> > another domain. This problem is a perfect example: it's different to
> > solve based on the number of isolated pages; but it becomes a lot
> > easier based on the number of direct reclaimers.
>
> This would be really true if all those reclaimers where equal in their
> capabilities. But they are not due to reclaim constrains if nothing
> else.

Thanks for the clarification above.

> IMHO the best way forward would be removing the throttling from the
> reclaim path altogether. The reclaim should be only throttled by the
> work it does. Both allocator and memcg charging path implement some sort
> of retry logic and I believe this would be much better suited to
> implement any backoff.

I completely agree with this.
