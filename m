Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426F532BFB6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835934AbhCCSFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383671AbhCCPdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:33:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6855C061764
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e9mU42REF7rducrlu85KQrpNto0juZXUGEZjTSHm4X8=; b=cvPEwcHwgEcagrnePc4uqYaFss
        sxMU7RumdtYt4QAF1y+7KcHSsLAPRv5WJcdIqBeVXMITdY4zpTvD4NLY9S6PCz9WK4Cn8t6Y3Ejyw
        5h8R+o52ZoMwFJni6nCapje4arlIwOqh6e96nLKLpwzmTrNwkuTfn+y4uqgv7HBuFUsXYGif/g3aB
        TkmrqZeSq3W7x13VdwkGQ0OpMvpNWx+e5SUK5a4FAT4vnX0Gq3HT89Kc+B3wQXsWZcBC7Blbv4dsw
        eTTicS7AVz91FgarqJXvQy/nrJzv+JOgwFdZZeTdvAALFJ2x32tN39iMS5YrBannlPp9OqFPyUHSe
        HMr7i5KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHTU5-003DyC-GI; Wed, 03 Mar 2021 15:32:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 04FF830018A;
        Wed,  3 Mar 2021 16:32:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B5C5F20C8A4A6; Wed,  3 Mar 2021 16:32:18 +0100 (CET)
Date:   Wed, 3 Mar 2021 16:32:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com
Subject: Re: [PATCH v2 0/4] psi: Add PSI_CPU_FULL state and some code
 optimization
Message-ID: <YD+sAnZ+Ep0il5lp@hirez.programming.kicks-ass.net>
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
 <YD+kP0z0yWm9UeDK@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YD+kP0z0yWm9UeDK@cmpxchg.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 09:59:11AM -0500, Johannes Weiner wrote:
> On Wed, Mar 03, 2021 at 11:46:55AM +0800, Chengming Zhou wrote:
> > This patch series is RESEND of the previous patches on psi subsystem. A few
> > weeks passed since the last review, so I put them together and resend for
> > more convenient review and merge.
> > 
> > Patch 1 add PSI_CPU_FULL state means all non-idle tasks in a cgroup are delayed
> > on the CPU resource which used by others outside of the cgroup or throttled
> > by the cgroup cpu.max configuration.
> > 
> > Patch 2 use ONCPU state and the current in_memstall flag to detect reclaim,
> > remove the hook in timer tick to make code more concise and maintainable.
> > And patch 3 adds unlikely() annotations to move the pressure state branches
> > out of line to eliminate undesirable jumps during wakeup and sleeps.
> > 
> > Patch 4 optimize the voluntary sleep switch by remove one call of
> > psi_group_change() for every common cgroup ancestor of the two tasks.
> > 
> > Chengming Zhou (3):
> >   psi: Add PSI_CPU_FULL state
> >   psi: Use ONCPU state tracking machinery to detect reclaim
> >   psi: Optimize task switch inside shared cgroups
> > 
> > Johannes Weiner (1):
> >   psi: pressure states are unlikely
> 
> Peter, would you mind routing these through the sched tree for 5.13?

Yes, I can do that. Thanks!
