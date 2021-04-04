Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352333538C5
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 18:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhDDQCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 12:02:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229861AbhDDQCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 12:02:38 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBF9C61368;
        Sun,  4 Apr 2021 16:02:32 +0000 (UTC)
Date:   Sun, 4 Apr 2021 12:02:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Bharata B Rao <bharata@linux.vnet.ibm.com>,
        Phil Auld <pauld@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/debug: Use sched_debug_lock to serialize use
 of cgroup_path[] only
Message-ID: <20210404120231.13843854@oasis.local.home>
In-Reply-To: <b5d7e93f-c594-7678-eb8d-275ddd9cd8ce@redhat.com>
References: <20210401181030.7689-1-longman@redhat.com>
        <20210402164014.53c84f05@gandalf.local.home>
        <b5d7e93f-c594-7678-eb8d-275ddd9cd8ce@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Apr 2021 23:09:09 -0400
Waiman Long <longman@redhat.com> wrote:

> The main problem with sched_debug_lock is that under certain 
> circumstances, a lock waiter may wait a long time to acquire the lock 
> (in seconds). We can't insert touch_nmi_watchdog() while the cpu is 
> waiting for the spinlock.

The problem I have with the patch is that it seems to be a hack (as it
doesn't fix the issue in all cases). Since sched_debug_lock is
"special", perhaps we can add wrappers to take it, and instead of doing
the spin_lock_irqsave(), do a trylock loop. Add lockdep annotation to
tell lockdep that this is not a try lock (so that it can still detect
deadlocks).

Then have the strategically placed touch_nmi_watchdog() also increment
a counter. Then in that trylock loop, if it sees the counter get
incremented, it knows that forward progress is being made by the lock
holder, and it too can call touch_nmi_watchdog().

-- Steve
