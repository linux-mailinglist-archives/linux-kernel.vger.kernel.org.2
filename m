Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80221434EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbhJTPNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:13:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:41910 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhJTPNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:13:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 62EA721940;
        Wed, 20 Oct 2021 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634742675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4phKG3v7AhqVm7wB1hnWNwhQ3pm7190f563uVsyAUGU=;
        b=XCs3VtZUJyt68k3+ZF1yH49d+mFBf7wGBPfvDt0szjmCz8LijBJGR4ZDBQ50t96D0bRPgV
        1rZrUwv5M9sS6dUKny9EqtlX4dX8LkvxKBcLNCB/ANcLa2oOl2fQ86Mcbta9VuQNiMFR80
        4VwKlvx9coxtqMG6rSk9AV74CvbX9wU=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0456BA3B87;
        Wed, 20 Oct 2021 15:11:10 +0000 (UTC)
Date:   Wed, 20 Oct 2021 17:11:02 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: skip current when memcg reclaim
Message-ID: <YXAxhp9tQPv9g0XJ@dhcp22.suse.cz>
References: <YW0u67o8wl3CGikP@dhcp22.suse.cz>
 <CAGWkznEO9SyNFEBqL8=JxewVTvaUhwFLPow69mi=R1MJ=XCpow@mail.gmail.com>
 <YW1rcv4bN1WWhzLD@dhcp22.suse.cz>
 <CAGWkznG65_FGx9jU7rjj5biEdyHZ=kcPwmXj6cGxxVmPy2rdKQ@mail.gmail.com>
 <YW6LSVK+NTiZ05+X@dhcp22.suse.cz>
 <CAGWkznHSPAu572BjoE510Sm+G9vGetKg-v2TkjwtcmZGo8MPVw@mail.gmail.com>
 <YW7G7znfHxd52b/T@dhcp22.suse.cz>
 <CAGWkznGb05Uykxz=9K+8uB6axS7LCo_7hMXAn7DFJXvAmkFy5Q@mail.gmail.com>
 <YW/Zf/s/CtRFlJ87@dhcp22.suse.cz>
 <CAGWkznHF8Q8VEiKmDHNXW7Lf2=37=YXC+oP0COxe7WhY4bPWiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGWkznHF8Q8VEiKmDHNXW7Lf2=37=YXC+oP0COxe7WhY4bPWiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-10-21 19:45:33, Zhaoyang Huang wrote:
> On Wed, Oct 20, 2021 at 4:55 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Wed 20-10-21 15:33:39, Zhaoyang Huang wrote:
> > [...]
> > > Do you mean that direct reclaim should succeed for the first round
> > > reclaim within which memcg get protected by memory.low and would NOT
> > > retry by setting memcg_low_reclaim to true?
> >
> > Yes, this is the semantic of low limit protection in the upstream
> > kernel. Have a look at do_try_to_free_pages and how it sets
> > memcg_low_reclaim only if there were no pages reclaimed.
> >
> > > It is not true in android
> > > like system, where reclaim always failed and introduce lmk and even
> > > OOM.
> >
> > I am not familiar with android specific changes to the upstream reclaim
> > logic. You should be investigating why the reclaim couldn't make a
> > forward progress (aka reclaim pages) from non-protected memcgs. There
> > are tracepoints you can use (generally vmscan prefix).
> Ok, I am aware of why you get confused now. I think you are analysing
> cgroup's behaviour according to a pre-defined workload and memory
> pattern, which should work according to the design, such as processes
> within root should provide memory before protected memcg get
> reclaimed. You can refer [1] as the hierarchy, where effective
> userspace workloads locate in protect groups and have rest of
> processes be non-grouped. In fact, non-grouped ones can not provide
> enough memory as they are kernel threads and the processes with few
> pages on LRU(control logic inside). The practical scenario is groupA
> launched a high-order kmalloc and introduce reclaiming(kswapd and
> direct reclaim). As I said, non-grouped ones can not provide enough
> contiguous memory blocks which let direct reclaim quickly fail for the
> first round reclaiming. What I am trying to do is that let kswapd try
> more for the target. It is also fair if groupA,B,C are trapping in
> slow path concurrently.
> 
> [1]
> root
> |                                                       |
> |              |
> non-grouped processes             groupA    groupB  groupC

I am sorry but I still do not understand your setup. I have asked
several times for more specifics. Without that I cannot really wrap my
head around your (ever changing) statements. This is not really a
productive use of time. I am sorry but I cannot really help you much
without understanding the actual problem.
-- 
Michal Hocko
SUSE Labs
