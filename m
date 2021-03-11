Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075CB336982
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 02:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbhCKBUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 20:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCKBUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 20:20:09 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C136FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:20:08 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x7so9945122pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 17:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0ZkhEPXNpdhd7EV60+uxO7+s4em392s377dpq/Miruo=;
        b=EBBjJgEO35RWOBXTBuXClQYEGc1+xzuOlvc/7LHXyZG4dDzcfOuaRT7myDPt+gjRfT
         U3LNnOU7ejYFJXHfrysZ8b0p0SG1KWnwDTJ/lIdAstRg0sRN3KalQI6pcHXILu5rbskc
         9RoiLLBUQHxjN5hcSpt0TvVmIN91IZYjAxB4tYIpzN+X7qpvXQ5AAOlcSmK5Jcxnkak7
         Z6ffKi41Ho/GJUKO2u4bxgBoeNLYgZJHISf+JOBy2Q0+ytL7OOUL/bm5ThCTVxsa6QWz
         LFzGXy1QD36ZUtTL+uAxePmi1n7l1NgFoOVUFxzNUHzhDkGHKimDIgoTBIDJ5D7r4cZw
         NxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ZkhEPXNpdhd7EV60+uxO7+s4em392s377dpq/Miruo=;
        b=TJzGw4I6nkIYUXSkbR2luknjM72cO917n0cOSVTrOju+71rLgoxSmv83IhVPsUwsZ8
         IPrcdAt/8EBfThhgbhlyLIXiFG2lWCy2hN15sDJznrK6UWo/VJ1PojL/YpfBq0nkz8RK
         53Pe133wlRwd5sK/UqCm4M1TvSrOaaFfARbtLseSWyqt6bKs6AiJWTk3HwwvF4wtGsEM
         P/h7BePipzxB0aTSqYFZ3ZtlbXb8IvWM1llvTLxP2PvO5iUZDtQvEVoLnI3C9sLL3MC4
         99Lez3x8vyFZSc/r8Fm9xmxGd+EkZwyXHxKv79lmdjRN04OrDKjOZeSpoUs4NnOl3OP+
         hqmg==
X-Gm-Message-State: AOAM532kKO8qybdi8RK4qofHQigMC2Y875KcxOQh3zat1nzWTliizpDQ
        VD/WuIqgf+viUm1QecNGA4pNNQ==
X-Google-Smtp-Source: ABdhPJy4oEPMcOroAyrlq+q9+5qM78TC1A3maqhY2DW8jxRIhcTfNtx+tLADENdj5/ze8zkDolTo+g==
X-Received: by 2002:a63:ce18:: with SMTP id y24mr5100261pgf.246.1615425608150;
        Wed, 10 Mar 2021 17:20:08 -0800 (PST)
Received: from google.com ([2620:15c:f:10:c4e3:28f1:33df:26ba])
        by smtp.gmail.com with ESMTPSA id 35sm638412pgr.14.2021.03.10.17.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 17:20:07 -0800 (PST)
Date:   Wed, 10 Mar 2021 17:20:01 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Ben Gardon <bgardon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>
Subject: Re: [PATCH] mm/oom_kill: Ensure MMU notifier range_end() is paired
 with range_start()
Message-ID: <YElwQU9mPUNwPg7q@google.com>
References: <20210310213117.1444147-1-seanjc@google.com>
 <20210311002807.GQ444867@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311002807.GQ444867@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021, Jason Gunthorpe wrote:
> On Wed, Mar 10, 2021 at 01:31:17PM -0800, Sean Christopherson wrote:
> > Invoke the MMU notifier's .invalidate_range_end() callbacks even if one
> > of the .invalidate_range_start() callbacks failed.  If there are multiple
> > notifiers, the notifier that did not fail may have performed actions in
> > its ...start() that it expects to unwind via ...end().  Per the
> > mmu_notifier_ops documentation, ...start() and ...end() must be paired.
> 
> No this is not OK, if invalidate_start returns EBUSY invalidate_end
> should *not* be called.
> 
> As you observed:
>  
> > The only in-kernel usage that is fatally broken is the SGI UV GRU driver,
> > which effectively blocks and sleeps fault handlers during ...start(), and
> > unblocks/wakes the handlers during ...end().  But, the only users that
> > can fail ...start() are the i915 and Nouveau drivers, which are unlikely
> > to collide with the SGI driver.
> 
> It used to be worse but I've since moved most of the other problematic
> users to the itree notifier which doesn't have the problem.
> 
> > KVM is the only other user of ...end(), and while KVM also blocks fault
> > handlers in ...start(), the fault handlers do not sleep and originate in
> 
> KVM will have its mmu_notifier_count become imbalanced:
> 
> static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>                                         const struct mmu_notifier_range *range)
> {
>         kvm->mmu_notifier_count++;
> 
> static void kvm_mmu_notifier_invalidate_range_end(struct mmu_notifier *mn,
>                                         const struct mmu_notifier_range *range)
> {
>         kvm->mmu_notifier_count--;
> 
> Which I believe is fatal to kvm? These notifiers certainly do not only
> happen at process exit.

My point about the process dying is that the existing bug that causes
mmu_notifier_count to become imbalanced is benign only because the process is
being killed, and thus KVM will stop running its vCPUs.

> So, both of the remaining _end users become corrupted with this patch!

I don't follow.  mn_hlist_invalidate_range_start() iterates over all notifiers,
even if a notifier earlier in the chain failed.  How will KVM become imbalanced?

The existing _end users never fail their _start.  If KVM started failing its
start, then yes, it could get corrupted.  But my assumption/expection is that,
if KVM were to ever reject _start, it would be responsible for knowing that it
must also skip _end.  I'm happy to kick that one down the road though, as I
can't think of a scenario where KVM would _need_ to sleep.

> I've tried to fix this before, the only thing that seems like it will
> work is to sort the hlist and only call ends that have succeeded their
> starts by comparing pointers with <.
> 
> This is because the hlist can have items removed concurrently under
> SRCU so there is no easy way to compute the subset that succeeded in
> calling start.
> 
> I had a prior effort to just ban more than 1 hlist notifier with end,
> but it turns out kvm on ARM uses two all the time (IIRC)
> 
> > Found by inspection.  Verified by adding a second notifier in KVM
> > that
> 
> AFAIK it is a non-problem in real life because kvm is not mixed with
> notifier_start's that fail (and GRU is dead?). Everything else was
> fixed by moving to itree.
> 
> Jason
