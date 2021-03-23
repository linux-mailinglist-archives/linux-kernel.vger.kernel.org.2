Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589003461DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhCWOvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbhCWOu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:50:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104E2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Pg7wqWo9GbGyOf6ruKFdy0o/AhXiWPevvjIgX9aMZf4=; b=ECz38tvMKB5jtTDsSG2TZ/iR2v
        +YHeOFi889aUNPnP08xwsJZS8LKD+dR5yg1LCArXpzruad/ZYA7t/0k9HYGd04oQgK0fAc9zcR71D
        IQ86W0ZLvaga6M3DWpuEUkSTzUpVcTLq7U5ntKV8z84ymeYLTLjtKDyKYrHiBKL0WJ1uHo2y+9gbw
        iGHQTGV6kiOYLjkXrXJy9QpJippuGE+YR0KUhHOsYuDVgM9YaYOcYrHaIazZVSiNeu6/YhAS3eJJD
        kIhWB1yKmy8fPjmniwrD5E4HLyTQNe4lmK36ex2ell6IeuGkk1Xk44xMcGqyw+UqymfAB2mHfrNcS
        0gXL9mQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOiLr-00ABYJ-SM; Tue, 23 Mar 2021 14:49:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 136A13003E1;
        Tue, 23 Mar 2021 15:49:46 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF8292360188E; Tue, 23 Mar 2021 15:49:45 +0100 (CET)
Date:   Tue, 23 Mar 2021 15:49:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2] sched/fair: reduce long-tail newly idle balance cost
Message-ID: <YFoACa0+cGBDxWSF@hirez.programming.kicks-ass.net>
References: <1614154549-116078-1-git-send-email-aubrey.li@intel.com>
 <74f65436-09f2-a4f0-345f-8887b11a51bf@linux.intel.com>
 <CAKfTPtCauiWo1yf90XnHK0HKZhS=dPVuJQ6C5gFSLF5_QA-OwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCauiWo1yf90XnHK0HKZhS=dPVuJQ6C5gFSLF5_QA-OwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 02:44:57PM +0100, Vincent Guittot wrote:
> Hi Aurey,
> 
> On Tue, 16 Mar 2021 at 05:27, Li, Aubrey <aubrey.li@linux.intel.com> wrote:
> >
> > On 2021/2/24 16:15, Aubrey Li wrote:
> > > A long-tail load balance cost is observed on the newly idle path,
> > > this is caused by a race window between the first nr_running check
> > > of the busiest runqueue and its nr_running recheck in detach_tasks.
> > >
> > > Before the busiest runqueue is locked, the tasks on the busiest
> > > runqueue could be pulled by other CPUs and nr_running of the busiest
> > > runqueu becomes 1 or even 0 if the running task becomes idle, this
> > > causes detach_tasks breaks with LBF_ALL_PINNED flag set, and triggers
> > > load_balance redo at the same sched_domain level.
> > >
> > > In order to find the new busiest sched_group and CPU, load balance will
> > > recompute and update the various load statistics, which eventually leads
> > > to the long-tail load balance cost.
> > >
> > > This patch clears LBF_ALL_PINNED flag for this race condition, and hence
> > > reduces the long-tail cost of newly idle balance.
> >
> > Ping...
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
