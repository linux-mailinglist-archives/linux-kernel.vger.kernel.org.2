Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD8C36F5E2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 08:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhD3GsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 02:48:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:49771 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230380AbhD3GsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 02:48:07 -0400
IronPort-SDR: KDEtbdC2Qa8sck0elFTOml1gb7KOGLPC7hhP9MX2GUl2bYdIwf8CfuTXenAuLivgMzp65OJA5Q
 A0zOKDAYL9XA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="282553786"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="282553786"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 23:47:19 -0700
IronPort-SDR: u2p7OWvqmQgTFrdpJhl5YmbcyD4bBFh+TkqKl1qz1UlrTlCkaIcRXaVVtjcuAMC2toXOibNmOm
 4ijxR+6bjkdg==
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="424720482"
Received: from hongyuni-mobl1.ccr.corp.intel.com (HELO [10.238.1.82]) ([10.238.1.82])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 23:47:16 -0700
Subject: Re: [PATCH 00/19] sched: Core Scheduling
To:     Peter Zijlstra <peterz@infradead.org>, joel@joelfernandes.org,
        chris.hyser@oracle.com, joshdon@google.com, mingo@kernel.org,
        vincent.guittot@linaro.org, valentin.schneider@arm.com,
        mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20210422120459.447350175@infradead.org>
From:   "Ning, Hongyu" <hongyu.ning@linux.intel.com>
Message-ID: <a49ea23a-998e-2282-4c93-5c6c94f2c28d@linux.intel.com>
Date:   Fri, 30 Apr 2021 14:47:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210422120459.447350175@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/4/22 20:04, Peter Zijlstra wrote:
> Hai,
> 
> This is an agressive fold of all the core-scheduling work so far. I've stripped
> a whole bunch of tags along the way (hopefully not too many, please yell if you
> feel I made a mistake), including tested-by. Please retest.
> 
> Changes since the last partial post is dropping all the cgroup stuff and
> PR_SCHED_CORE_CLEAR as well as that exec() behaviour in order to later resolve
> the cgroup issue.
> 
> Since we're really rather late for the coming merge window, my plan was to
> merge the lot right after the merge window.
> 
> Again, please test.
> 
> These patches should shortly be available in my queue.git.
> 
> ---
>  b/kernel/sched/core_sched.c                     |  229 ++++++
>  b/tools/testing/selftests/sched/.gitignore      |    1 
>  b/tools/testing/selftests/sched/Makefile        |   14 
>  b/tools/testing/selftests/sched/config          |    1 
>  b/tools/testing/selftests/sched/cs_prctl_test.c |  338 +++++++++
>  include/linux/sched.h                           |   19 
>  include/uapi/linux/prctl.h                      |    8 
>  kernel/Kconfig.preempt                          |    6 
>  kernel/fork.c                                   |    4 
>  kernel/sched/Makefile                           |    1 
>  kernel/sched/core.c                             |  858 ++++++++++++++++++++++--
>  kernel/sched/cpuacct.c                          |   12 
>  kernel/sched/deadline.c                         |   38 -
>  kernel/sched/debug.c                            |    4 
>  kernel/sched/fair.c                             |  276 +++++--
>  kernel/sched/idle.c                             |   13 
>  kernel/sched/pelt.h                             |    2 
>  kernel/sched/rt.c                               |   31 
>  kernel/sched/sched.h                            |  393 ++++++++--
>  kernel/sched/stop_task.c                        |   14 
>  kernel/sched/topology.c                         |    4 
>  kernel/sys.c                                    |    5 
>  tools/include/uapi/linux/prctl.h                |    8 
>  23 files changed, 2057 insertions(+), 222 deletions(-)
> 


Adding sysbench/uperf/wis performance results for reference:

- kernel under test:
	-- above patchset of core-scheduling + local fix for softlockup issue: https://lore.kernel.org/lkml/5c289c5a-a120-a1d0-ca89-2724a1445fe8@linux.intel.com/
	-- coresched_v10 kernel source: https://github.com/digitalocean/linux-coresched/commits/coresched/v10-v5.10.y

- workloads: 
	-- A. sysbench cpu (192 threads) + sysbench cpu (192 threads)
	-- B. sysbench cpu (192 threads) + sysbench mysql (192 threads)
	-- C. uperf netperf.xml (192 threads over TCP or UDP protocol separately)
	-- D. will-it-scale context_switch via pipe (192 threads)

- test machine setup: 
	CPU(s):              192
	On-line CPU(s) list: 0-191
	Thread(s) per core:  2
	Core(s) per socket:  48
	Socket(s):           2
	NUMA node(s):        4

- performance change key info:
	--workload B: coresched (cs_on), sysbench mysql performance drop around 20% vs coresched_v10
	--workload C, coresched (cs_on), uperf performance increased almost double vs coresched_v10
	--workload C, default (cs_off), uperf performance drop over 20% vs coresched_v10, same issue seen on v5.12-rc8 base (w/o coresched patchset)
	--workload D, coresched (cs_on), wis performance increased almost double vs coresched_v10

- performance info of workloads, normalized based on coresched_v10 results
	--workload A:
	Note: 
	* no performance change compared to coresched_v10
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
|                                       | **   | coresched_peterz_aubrey_fix_base_v5.12-rc8   | coresched_peterz_aubrey_fix_base_v5.12-rc8     | ***   | coresched_v10_base_v5.10.11   | coresched_v10_base_v5.10.11     |
+=======================================+======+==============================================+================================================+=======+===============================+=================================+
| workload                              | **   | sysbench cpu * 192                           | sysbench cpu * 192                             | ***   | sysbench cpu * 192            | sysbench cpu * 192              |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| prctl/cgroup                          | **   | prctl on workload cpu_0                      | prctl on workload cpu_1                        | ***   | cg_sysbench_cpu_0             | cg_sysbench_cpu_1               |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| record_item                           | **   | Tput_avg (events/s)                          | Tput_avg (events/s)                            | ***   | Tput_avg (events/s)           | Tput_avg (events/s)             |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| coresched normalized vs coresched_v10 | **   | 0.99                                         | 1.01                                           | ***   | 1                             | 1                               |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| default normalized vs coresched_v10   | **   | 1.03                                         | 0.98                                           | ***   | 1                             | 1                               |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| smtoff normalized vs coresched_v10    | **   | 1.01                                         | 0.99                                           | ***   | 1                             | 1                               |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+

	--workload B:
	Note: 
	* coresched (cs_on), sysbench mysql performance drop around 20% vs coresched_v10
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
|                                       | **   | coresched_peterz_aubrey_fix_base_v5.12-rc8   | coresched_peterz_aubrey_fix_base_v5.12-rc8     | ***   | coresched_v10_base_v5.10.11   | coresched_v10_base_v5.10.11     |
+=======================================+======+==============================================+================================================+=======+===============================+=================================+
| workload                              | **   | sysbench cpu * 192                           | sysbench mysql * 192                           | ***   | sysbench cpu * 192            | sysbench mysql * 192            |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| prctl/cgroup                          | **   | prctl on workload cpu_0                      | prctl on workload mysql_0                      | ***   | cg_sysbench_cpu_0             | cg_sysbench_mysql_0             |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| record_item                           | **   | Tput_avg (events/s)                          | Tput_avg (events/s)                            | ***   | Tput_avg (events/s)           | Tput_avg (events/s)             |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| coresched normalized vs coresched_v10 | **   | 1.03                                         | 0.77                                           | ***   | 1                             | 1                               |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| default normalized vs coresched_v10   | **   | 1.02                                         | 0.9                                            | ***   | 1                             | 1                               |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| smtoff normalized vs coresched_v10    | **   | 0.94                                         | 1.14                                           | ***   | 1                             | 1                               |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
	
	--workload C:
	Note: 
	* coresched (cs_on), uperf performance increased almost double vs coresched_v10
	* default (cs_off), uperf performance drop over 20% vs coresched_v10, same issue seen on v5.12-rc8 base (w/o coresched patchset)
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
|                                       | **   | coresched_peterz_aubrey_fix_base_v5.12-rc8   | coresched_peterz_aubrey_fix_base_v5.12-rc8     | ***   | coresched_v10_base_v5.10.11   | coresched_v10_base_v5.10.11     |
+=======================================+======+==============================================+================================================+=======+===============================+=================================+
| workload                              | **   | uperf netperf TCP * 192                      | uperf netperf UDP * 192                        | ***   | uperf netperf TCP * 192       | uperf netperf UDP * 192         |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| prctl/cgroup                          | **   | prctl on workload uperf                      | prctl on workload uperf                        | ***   | cg_uperf                      | cg_uperf                        |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| record_item                           | **   | Tput_avg (Gb/s)                              | Tput_avg (Gb/s)                                | ***   | Tput_avg (Gb/s)               | Tput_avg (Gb/s)                 |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| coresched normalized vs coresched_v10 | **   | 1.87                                         | 1.99                                           | ***   | 1                             | 1                               |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| default normalized vs coresched_v10   | **   | 0.78                                         | 0.74                                           | ***   | 1                             | 1                               |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+
| smtoff normalized vs coresched_v10    | **   | 0.87                                         | 0.95                                           | ***   | 1                             | 1                               |
+---------------------------------------+------+----------------------------------------------+------------------------------------------------+-------+-------------------------------+---------------------------------+

	--workload D:
	Note: 
	* coresched (cs_on), wis performance increased almost double vs coresched_v10
+---------------------------------------+------+----------------------------------------------+-------+-------------------------------+
|                                       | **   | coresched_peterz_aubrey_fix_base_v5.12-rc8   | ***   | coresched_v10_base_v5.10.11   |
+=======================================+======+==============================================+=======+===============================+
| workload                              | **   | will-it-scale  * 192                         | ***   | will-it-scale  * 192          |
|                                       |      | (pipe based context_switch)                  |       | (pipe based context_switch)   |
+---------------------------------------+------+----------------------------------------------+-------+-------------------------------+
| prctl/cgroup                          | **   | prctl on workload wis                        | ***   | cg_wis                        |
+---------------------------------------+------+----------------------------------------------+-------+-------------------------------+
| record_item                           | **   | threads_avg                                  | ***   | threads_avg                   |
+---------------------------------------+------+----------------------------------------------+-------+-------------------------------+
| coresched normalized vs coresched_v10 | **   | 1.98                                         | ***   | 1                             |
+---------------------------------------+------+----------------------------------------------+-------+-------------------------------+
| default normalized vs coresched_v10   | **   | 1.13                                         | ***   | 1                             |
+---------------------------------------+------+----------------------------------------------+-------+-------------------------------+
| smtoff normalized vs coresched_v10    | **   | 1.32                                         | ***   | 1                             |
+---------------------------------------+------+----------------------------------------------+-------+-------------------------------+

	-- notes on record_item:
	* coresched normalized vs coresched_v10: smton, cs enabled, test result normalized by result of coresched_v10 under same config
	* default normalized vs coresched_v10: smton, cs disabled, test result normalized by result of coresched_v10 under same config
	* smtoff normalized vs coresched_v10: smtoff, test result normalized by result of coresched_v10 under same config

Hongyu
