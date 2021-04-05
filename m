Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F063543F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241897AbhDEP73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238528AbhDEP71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:59:27 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B06E9613A0;
        Mon,  5 Apr 2021 15:59:19 +0000 (UTC)
Date:   Mon, 5 Apr 2021 11:59:18 -0400
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
Message-ID: <20210405115918.702a2f8b@gandalf.local.home>
In-Reply-To: <4014fe97-5875-f64a-7b68-854a2b08394e@redhat.com>
References: <20210401181030.7689-1-longman@redhat.com>
        <20210402164014.53c84f05@gandalf.local.home>
        <b5d7e93f-c594-7678-eb8d-275ddd9cd8ce@redhat.com>
        <20210404120231.13843854@oasis.local.home>
        <4014fe97-5875-f64a-7b68-854a2b08394e@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Apr 2021 21:27:00 -0400
Waiman Long <longman@redhat.com> wrote:

> Thanks for the suggestion, but it also sound complicated.

It's not that complicated. Similar tricks have been used elsewhere in the
kernel.

> 
> I think we can fix this lockup problem if we are willing to lose some 

It's not a lockup problem, it's just a delay.

> information in case of contention. As you have suggested, a trylock will 
> be used to acquire sched_debug_lock. If succeeded, all is good. 
> Otherwise, a shorter stack buffer will be used for cgroup path. The path 
> may be truncated in this case. If we detect that the full length of the 
> buffer is used, we assume truncation and add, e.g. "...", to indicate 
> there is more to the actual path.
> 
> Do you think this is an acceptable comprise?

I guess that needs to be decided by those that use this information.

-- Steve
