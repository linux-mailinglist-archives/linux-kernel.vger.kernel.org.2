Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427C83113F5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 22:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbhBEVxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 16:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhBEVwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 16:52:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B73C061786
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 13:52:13 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id z6so9267054wrq.10
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 13:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/G/5th0PpgWzaHlGN8L+2GW8U9A9V9verMJjNjsxBWg=;
        b=Na+AIqk4zgAKp7eMiaDOjKP1QLeOQf/3wbhYQDHWywMtihMnEhxlLoXWwPWnN5BPSU
         g4FZbyfgADNpUaOfFDxN545b7zqXc1jX5Jn1pHYeCJWOyB3P8V1ixZwR5I+lF5RkOyYa
         HbBqoPCZZXeRKzNhcl91wntoBCJhWCk5Fs8MWdy0hyPNFAfJY+fL89r75lX0CKYAvKZ6
         XExlaVLbjcDjdCCwiqzK6zr0xkRhoDSxMUlQU80kRn8dzjSH64HJNB1uUDqEq8KTU5gL
         4jdnEmpjiseOXDx4bQs4a+m2tRAI28du6NthQ3Sl44lcxLjWOvzz0JPTsfwsbPDaiqEL
         mwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/G/5th0PpgWzaHlGN8L+2GW8U9A9V9verMJjNjsxBWg=;
        b=SB02jvTCu1e6OVGo0GPqDWkfKgij/4WQihsxtQcqpjnLHTl+IVnejMxkgPQWgr3Mb7
         URpqabtbDL6+yLATYvQpHGwBfLjtANWOhPqlO9mQp9uKE1jl7P3K8PawSo8H4NPRgQxh
         dXDgX6JWcDsSPhXrU+ZaQ/wGeYzzhkAtgh2puk1TzxzHc4XOeumlYYEbDpwZIgzvEQ+c
         L0fNL4FfvCl+vXiYdiJxL/7JOKVuWXDp9XJzAU2ZSkCb+pD7tq3bOH0JU0swEc0KSSff
         xQtQhqht95fFd6mkPeykPJzjnNX0L3pcPQxgNiOSKz9cZtWLUG/Omwp03aa1EKEAbzsb
         BXIg==
X-Gm-Message-State: AOAM531QMhKrfiIaJjYFw0t0IwTpN3x72sBAFuwPfo9IQsDx6Xdp2zDo
        pmuCBZY1i/QZ8sekhgNIZR9RrzKveLjxr8uYh5ArXw==
X-Google-Smtp-Source: ABdhPJzAUrSB5pmFT2HMQwGkonhVcfHyiDFDsmWm48rqHDf7yujqAHfhiV7UEF6RReh2d95xZh8aizY5B2Hd7vJGqKA=
X-Received: by 2002:adf:e50e:: with SMTP id j14mr7321998wrm.162.1612561932142;
 Fri, 05 Feb 2021 13:52:12 -0800 (PST)
MIME-Version: 1.0
References: <YByNU4Q7cc7gYwPh@google.com> <87d7ec1f-d892-0491-a2de-3d0feecca647@nvidia.com>
 <YByi/gdaGJeV/+8b@google.com> <71c4ce84-8be7-49e2-90bd-348762b320b4@nvidia.com>
 <YBzU5uUbwa+QIwBQ@google.com> <34110c61-9826-4cbe-8cd4-76f5e7612dbd@nvidia.com>
 <YBzkjh5nnuNiGb6Q@google.com> <f6e41e39-d60b-764d-0af4-8e6977663821@nvidia.com>
 <YB1vIrgI9S/5CDxL@google.com> <269689b7-3b6d-55dc-9044-fbf2984089ab@nvidia.com>
 <YB24YXMJOjwokDb5@google.com>
In-Reply-To: <YB24YXMJOjwokDb5@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 5 Feb 2021 13:52:00 -0800
Message-ID: <CAJuCfpEaQqgsyGtzRvovpuLOELR0iRNvNF0rnih1bq0HQCTuww@mail.gmail.com>
Subject: Re: [PATCH] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Dias <joaodias@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 5, 2021 at 1:28 PM Minchan Kim <minchan@kernel.org> wrote:
>
> On Fri, Feb 05, 2021 at 12:25:52PM -0800, John Hubbard wrote:
> > On 2/5/21 8:15 AM, Minchan Kim wrote:
> > ...
> > > > Yes, approximately. I was wondering if this would suffice at least as a baseline:
> > > >
> > > > cma_alloc_success   125
> > > > cma_alloc_failure   25
> > >
> > > IMO, regardless of the my patch, it would be good to have such statistics
> > > in that CMA was born to replace carved out memory with dynamic allocation
> > > ideally for memory efficiency ideally so failure should regard critical
> > > so admin could notice it how the system is hurt.
> >
> > Right. So CMA failures are useful for the admin to see, understood.
> >
> > >
> > > Anyway, it's not enough for me and orthgonal with my goal.
> > >
> >
> > OK. But...what *is* your goal, and why is this useless (that's what
> > orthogonal really means here) for your goal?
>
> As I mentioned, the goal is to monitor the failure from each of CMA
> since they have each own purpose.
>
> Let's have an example.
>
> System has 5 CMA area and each CMA is associated with each
> user scenario. They have exclusive CMA area to avoid
> fragmentation problem.
>
> CMA-1 depends on bluetooh
> CMA-2 depends on WIFI
> CMA-3 depends on sensor-A
> CMA-4 depends on sensor-B
> CMA-5 depends on sensor-C
>
> With this, we could catch which module was affected but with global failure,
> I couldn't find who was affected.
>
> >
> > Also, would you be willing to try out something simple first,
> > such as providing indication that cma is active and it's overall success
> > rate, like this:
> >
> > /proc/vmstat:
> >
> > cma_alloc_success   125
> > cma_alloc_failure   25
> >
> > ...or is the only way to provide the more detailed items, complete with
> > per-CMA details, in a non-debugfs location?
> >
> >
> > > >
> > > > ...and then, to see if more is needed, some questions:
> > > >
> > > > a)  Do you know of an upper bound on how many cma areas there can be
> > > > (I think Matthew also asked that)?
> > >
> > > There is no upper bound since it's configurable.
> > >
> >
> > OK, thanks,so that pretty much rules out putting per-cma details into
> > anything other than a directory or something like it.
> >
> > > >
> > > > b) Is tracking the cma area really as valuable as other possibilities? We can put
> > > > "a few" to "several" items here, so really want to get your very favorite bits of
> > > > information in. If, for example, there can be *lots* of cma areas, then maybe tracking
> > >
> > > At this moment, allocation/failure for each CMA area since they have
> > > particular own usecase, which makes me easy to keep which module will
> > > be affected. I think it is very useful per-CMA statistics as minimum
> > > code change so I want to enable it by default under CONFIG_CMA && CONFIG_SYSFS.
> > >
> > > > by a range of allocation sizes is better...
> > >
> > > I takes your suggestion something like this.
> > >
> > > [alloc_range] could be order or range by interval
> > >
> > > /sys/kernel/mm/cma/cma-A/[alloc_range]/success
> > > /sys/kernel/mm/cma/cma-A/[alloc_range]/fail
> > > ..
> > > ..
> > > /sys/kernel/mm/cma/cma-Z/[alloc_range]/success
> > > /sys/kernel/mm/cma/cma-Z/[alloc_range]/fail

The interface above seems to me the most useful actually, if by
[alloc_range] you mean the different allocation orders. This would
cover Minchan's per-CMA failure tracking and would also allow us to
understand what kind of allocations are failing and therefore if the
problem is caused by pinning/fragmentation or by over-utilization.

> >
> > Actually, I meant, "ranges instead of cma areas", like this:
> >
> > /<path-to-cma-data/[alloc_range_1]/success
> > /<path-to-cma-data/[alloc_range_1]/fail
> > /<path-to-cma-data/[alloc_range_2]/success
> > /<path-to-cma-data/[alloc_range_2]/fail
> > ...
> > /<path-to-cma-data/[alloc_range_max]/success
> > /<path-to-cma-data/[alloc_range_max]/fail
> >
> > The idea is that knowing the allocation sizes that succeeded
> > and failed is maybe even more interesting and useful than
> > knowing the cma area that contains them.
>
> Understand your point but it would make hard to find who was
> affected by the failure. That's why I suggested to have your
> suggestion under additional config since per-cma metric with
> simple sucess/failure are enough.
>
> >
> > >
> > > I agree it would be also useful but I'd like to enable it under
> > > CONFIG_CMA_SYSFS_ALLOC_RANGE as separate patchset.
> > >
> >
> > I will stop harassing you very soon, just want to bottom out on
> > understanding the real goals first. :)
> >
>
> I hope my example makes the goal more clear for you.
