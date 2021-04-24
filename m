Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6178936A08A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhDXJap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:30:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:44946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhDXJal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:30:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE60EACF6;
        Sat, 24 Apr 2021 09:30:02 +0000 (UTC)
Date:   Sat, 24 Apr 2021 10:30:00 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v4] sched,fair: Skip newidle_balance if a wakeup is
 pending
Message-ID: <20210424093000.GA4171@suse.de>
References: <20210422130236.0bb353df@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210422130236.0bb353df@imladris.surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 01:02:36PM -0400, Rik van Riel wrote:
> The try_to_wake_up function has an optimization where it can queue
> a task for wakeup on its previous CPU, if the task is still in the
> middle of going to sleep inside schedule().
> 
> Once schedule() re-enables IRQs, the task will be woken up with an
> IPI, and placed back on the runqueue.
> 
> If we have such a wakeup pending, there is no need to search other
> CPUs for runnable tasks. Just skip (or bail out early from) newidle
> balancing, and run the just woken up task.
> 
> For a memcache like workload test, this reduces total CPU use by
> about 2%, proportionally split between user and system time,
> and p99 and p95 application response time by 10% on average.
> The schedstats run_delay number shows a similar improvement.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
