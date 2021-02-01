Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8BB309FE0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 02:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhBABPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 20:15:17 -0500
Received: from mga09.intel.com ([134.134.136.24]:51743 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhBABPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 20:15:07 -0500
IronPort-SDR: Q55Z3udlBtsQ+8loVk5MYU0/aMPHn8DjH6nHLbmmHa7ugg4+RjyL9t/m46FriJY6DAJQBs15iy
 ywW5SfT7JVQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="180765017"
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="180765017"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2021 17:13:18 -0800
IronPort-SDR: 7iL5qJQpqtduVUSEfG4raa+kdnIf5iYU1sKhW9hU7qz23WiyYf+5kq2jXOufGLDp7IwJ6FWQiv
 3BgnHecTfUJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,391,1602572400"; 
   d="scan'208";a="395443267"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by orsmga007.jf.intel.com with ESMTP; 31 Jan 2021 17:13:17 -0800
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Subject: Re: [PATCH v5 0/4] Scan for an idle sibling in a single pass
To:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210127135203.19633-1-mgorman@techsingularity.net>
Message-ID: <cec31f9f-0eda-706e-235d-5bd2bfad6c2c@linux.intel.com>
Date:   Mon, 1 Feb 2021 09:13:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210127135203.19633-1-mgorman@techsingularity.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/27 21:51, Mel Gorman wrote:
> Changelog since v4
> o Avoid use of intermediate variable during select_idle_cpu
> 
> Changelog since v3
> o Drop scanning based on cores, SMT4 results showed problems
> 
> Changelog since v2
> o Remove unnecessary parameters
> o Update nr during scan only when scanning for cpus
> 
> Changlog since v1
> o Move extern declaration to header for coding style
> o Remove unnecessary parameter from __select_idle_cpu
> 
> This series of 4 patches reposts three patches from Peter entitled
> "select_idle_sibling() wreckage". It only scans the runqueues in a single
> pass when searching for an idle sibling.
> 
> Three patches from Peter were dropped. The first patch altered how scan
> depth was calculated. Scan depth deletion is a random number generator
> with two major limitations. The avg_idle time is based on the time
> between a CPU going idle and being woken up clamped approximately by
> 2*sysctl_sched_migration_cost.  This is difficult to compare in a sensible
> fashion to avg_scan_cost. The second issue is that only the avg_scan_cost
> of scan failures is recorded and it does not decay.  This requires deeper
> surgery that would justify a patch on its own although Peter notes that
> https://lkml.kernel.org/r/20180530143105.977759909@infradead.org is
> potentially useful for an alternative avg_idle metric.
> 
> The second patch dropped scanned based on cores instead of CPUs as it
> rationalised the difference between core scanning and CPU scanning.
> Unfortunately, Vincent reported problems with SMT4 so it's dropped
> for now until depth searching can be fixed.
> 
> The third patch dropped converted the idle core scan throttling mechanism
> to SIS_PROP. While this would unify the throttling of core and CPU
> scanning, it was not free of regressions and has_idle_cores is a fairly
> effective throttling mechanism with the caveat that it can have a lot of
> false positives for workloads like hackbench.
> 
> Peter's series tried to solve three problems at once, this subset addresses
> one problem.
> 
>  kernel/sched/fair.c     | 151 +++++++++++++++++++---------------------
>  kernel/sched/features.h |   1 -
>  2 files changed, 70 insertions(+), 82 deletions(-)
> 

4 benchmarks measured on a x86 4s system with 24 cores per socket and
2 HTs per core, total 192 CPUs. 

The load level is [25%, 50%, 75%, 100%].

- hackbench almost has a universal win.
- netperf high load has notable changes, as well as tbench 50% load.

Details below:

hackbench: 10 iterations, 10000 loops, 40 fds per group
======================================================

- pipe process

	group	base	%std	v5	%std
	3	1	19.18	1.0266	9.06
	6	1	9.17	0.987	13.03
	9	1	7.11	1.0195	4.61
	12	1	1.07	0.9927	1.43

- pipe thread

	group	base	%std	v5	%std
	3	1	11.14	0.9742	7.27
	6	1	9.15	0.9572	7.48
	9	1	2.95	0.986	4.05
	12	1	1.75	0.9992	1.68

- socket process

	group	base	%std	v5	%std
	3	1	2.9	0.9586	2.39
	6	1	0.68	0.9641	1.3
	9	1	0.64	0.9388	0.76
	12	1	0.56	0.9375	0.55

- socket thread

	group	base	%std	v5	%std
	3	1	3.82	0.9686	2.97
	6	1	2.06	0.9667	1.91
	9	1	0.44	0.9354	1.25
	12	1	0.54	0.9362	0.6

netperf: 10 iterations x 100 seconds, transactions rate / sec
=============================================================

- tcp request/response performance

	thread	base	%std	v4	%std
	25%	1	5.34	1.0039	5.13
	50%	1	4.97	1.0115	6.3
	75%	1	5.09	0.9257	6.75
	100%	1	4.53	0.908	4.83



- udp request/response performance

	thread	base	%std	v4	%std
	25%	1	6.18	0.9896	6.09
	50%	1	5.88	1.0198	8.92
	75%	1	24.38	0.9236	29.14
	100%	1	26.16	0.9063	22.16

tbench: 10 iterations x 100 seconds, throughput / sec
=====================================================

	thread	base	%std	v4	%std
	25%	1	0.45	1.003	1.48
	50%	1	1.71	0.9286	0.82
	75%	1	0.84	0.9928	0.94
	100%	1	0.76	0.9762	0.59

schbench: 10 iterations x 100 seconds, 99th percentile latency
==============================================================

	mthread	base	%std	v4	%std
	25%	1	2.89	0.9884	7.34
	50%	1	40.38	1.0055	38.37
	75%	1	4.76	1.0095	4.62
	100%	1	10.09	1.0083	8.03

Thanks,
-Aubrey
