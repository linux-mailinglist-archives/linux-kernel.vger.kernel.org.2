Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6D934BCF3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbhC1PgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 11:36:18 -0400
Received: from outbound-smtp15.blacknight.com ([46.22.139.232]:55665 "EHLO
        outbound-smtp15.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230184AbhC1PgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 11:36:05 -0400
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp15.blacknight.com (Postfix) with ESMTPS id 26B431C59D6
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 16:36:04 +0100 (IST)
Received: (qmail 24502 invoked from network); 28 Mar 2021 15:36:03 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 28 Mar 2021 15:36:03 -0000
Date:   Sun, 28 Mar 2021 16:36:01 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v3] sched/fair: bring back select_idle_smt, but
 differently
Message-ID: <20210328153601.GU3697@techsingularity.net>
References: <20210321150358.71ef52b1@imladris.surriel.com>
 <20210322110306.GE3697@techsingularity.net>
 <20210326151932.2c187840@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210326151932.2c187840@imladris.surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 03:19:32PM -0400, Rik van Riel wrote:
> ---8<---
> sched,fair: bring back select_idle_smt, but differently
> 
> Mel Gorman did some nice work in 9fe1f127b913
> ("sched/fair: Merge select_idle_core/cpu()"), resulting in the kernel
> being more efficient at finding an idle CPU, and in tasks spending less
> time waiting to be run, both according to the schedstats run_delay
> numbers, and according to measured application latencies. Yay.
> 
> The flip side of this is that we see more task migrations (about
> 30% more), higher cache misses, higher memory bandwidth utilization,
> and higher CPU use, for the same number of requests/second.
> 
> This is most pronounced on a memcache type workload, which saw
> a consistent 1-3% increase in total CPU use on the system, due
> to those increased task migrations leading to higher L2 cache
> miss numbers, and higher memory utilization. The exclusive L3
> cache on Skylake does us no favors there.
> 
> On our web serving workload, that effect is usually negligible.
> 
> It appears that the increased number of CPU migrations is generally
> a good thing, since it leads to lower cpu_delay numbers, reflecting
> the fact that tasks get to run faster. However, the reduced locality
> and the corresponding increase in L2 cache misses hurts a little.
> 
> The patch below appears to fix the regression, while keeping the
> benefit of the lower cpu_delay numbers, by reintroducing select_idle_smt
> with a twist: when a socket has no idle cores, check to see if the
> sibling of "prev" is idle, before searching all the other CPUs.
> 
> This fixes both the occasional 9% regression on the web serving
> workload, and the continuous 2% CPU use regression on the memcache
> type workload.
> 
> With Mel's patches and this patch together, task migrations are still
> high, but L2 cache misses, memory bandwidth, and CPU time used are back
> down to what they were before. The p95 and p99 response times for the
> memcache type application improve by about 10% over what they were
> before Mel's patches got merged.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

FWIW, v3 appears to have performed faster than v2 on the few tests I ran
and the patch looks fine.

Reviewed-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
