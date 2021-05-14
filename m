Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7773802AC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 06:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhENENq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 00:13:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:44441 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231171AbhENENp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 00:13:45 -0400
IronPort-SDR: rVhVUzAY4F+N5X7tT5Lh38+zZPoWBLLjxtxCivMHxOYxgz3a4mfisELiEOCGS5ifNxFVAU+s22
 bcQui/ow95oA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="221117157"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="221117157"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 21:11:50 -0700
IronPort-SDR: hYRIpW6aBE6MiqIDrdQnVlOo012hB3FulWhH36IyRxk+56BPaqBvkld8Dj9vmNapbRIuUwZNso
 mmE/0tQ0AEBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="456942727"
Received: from aubrey-app.sh.intel.com (HELO [10.239.53.25]) ([10.239.53.25])
  by fmsmga004.fm.intel.com with ESMTP; 13 May 2021 21:11:47 -0700
Subject: Re: [PATCH v2 6/8] sched/idle: Move busy_cpu accounting to idle
 callback
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
References: <20210506164543.90688-1-srikar@linux.vnet.ibm.com>
 <20210506164543.90688-7-srikar@linux.vnet.ibm.com>
 <47d29f1d-cea6-492a-5125-85db6bce0fa7@linux.intel.com>
 <20210513073112.GV2633526@linux.vnet.ibm.com>
From:   Aubrey Li <aubrey.li@linux.intel.com>
Message-ID: <5823f298-6fae-5a73-3ab8-f708d90a7e52@linux.intel.com>
Date:   Fri, 14 May 2021 12:11:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210513073112.GV2633526@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/21 3:31 PM, Srikar Dronamraju wrote:
> * Aubrey Li <aubrey.li@linux.intel.com> [2021-05-12 16:08:24]:
> 
>> On 5/7/21 12:45 AM, Srikar Dronamraju wrote:
>>> Currently we account nr_busy_cpus in no_hz idle functions.
>>> There is no reason why nr_busy_cpus should updated be in NO_HZ_COMMON
>>> configs only. Also scheduler can mark a CPU as non-busy as soon as an
>>> idle class task starts to run. Scheduler can then mark a CPU as busy
>>> as soon as its woken up from idle or a new task is placed on it's
>>> runqueue.
>>
>> IIRC, we discussed this before, if a SCHED_IDLE task is placed on the
>> CPU's runqueue, this CPU should be still taken as a wakeup target.
>>
> 
> Yes, this CPU is still a wakeup target, its only when this CPU is busy, that
> we look at other CPUs
> 
>> Also, for those frequent context-switching tasks with very short idle,
>> it's expensive for scheduler to mark idle/busy every time, that's why
>> my patch only marks idle every time and marks busy ratelimited in
>> scheduler tick.
>>
> 
> I have tried few tasks with very short idle times and updating nr_busy
> everytime, doesnt seem to be impacting. Infact, it seems to help in picking
> the idler-llc more often.
> 

How many CPUs in your LLC?

This is a system with 192 CPUs, 4 nodes and each node has 48 CPUs in LLC
domain.

It looks like for netperf both TCP and UDP cases have the notable change
under 2 x overcommit, it may be not interesting though.


hackbench(48 tasks per group)
=========
case            	load    	baseline(std%)	compare%( std%)
process-pipe    	group-1 	 1.00 (  6.74)	 -4.61 (  8.97)
process-pipe    	group-2 	 1.00 ( 36.84)	+11.53 ( 26.35)
process-pipe    	group-3 	 1.00 ( 24.97)	+12.21 ( 19.05)
process-pipe    	group-4 	 1.00 ( 18.27)	 -2.62 ( 17.60)
process-pipe    	group-8 	 1.00 (  4.33)	 -2.22 (  3.08)
process-sockets 	group-1 	 1.00 (  7.88)	-20.26 ( 15.97)
process-sockets 	group-2 	 1.00 (  5.38)	-19.41 (  9.25)
process-sockets 	group-3 	 1.00 (  4.22)	 -5.70 (  3.00)
process-sockets 	group-4 	 1.00 (  1.44)	 -1.80 (  0.79)
process-sockets 	group-8 	 1.00 (  0.44)	 -2.86 (  0.06)
threads-pipe    	group-1 	 1.00 (  5.43)	 -3.69 (  3.59)
threads-pipe    	group-2 	 1.00 ( 18.00)	 -2.69 ( 16.79)
threads-pipe    	group-3 	 1.00 ( 21.72)	 -9.01 ( 21.34)
threads-pipe    	group-4 	 1.00 ( 21.58)	 -6.43 ( 16.26)
threads-pipe    	group-8 	 1.00 (  3.05)	 -0.15 (  2.31)
threads-sockets 	group-1 	 1.00 ( 14.51)	 -5.35 ( 13.85)
threads-sockets 	group-2 	 1.00 (  3.97)	-24.15 (  4.40)
threads-sockets 	group-3 	 1.00 (  4.97)	 -9.05 (  2.46)
threads-sockets 	group-4 	 1.00 (  1.98)	 -3.44 (  0.49)
threads-sockets 	group-8 	 1.00 (  0.37)	 -2.13 (  0.20)

netperf
=======
case            	load    	baseline(std%)	compare%( std%)
TCP_RR          	thread-48	 1.00 (  3.84)	 -2.20 (  3.83)
TCP_RR          	thread-96	 1.00 (  5.22)	 -4.97 (  3.90)
TCP_RR          	thread-144	 1.00 (  7.97)	 -0.75 (  4.39)
TCP_RR          	thread-192	 1.00 (  3.03)	 -0.67 (  4.40)
TCP_RR          	thread-384	 1.00 ( 22.27)	-14.15 ( 36.28)
UDP_RR          	thread-48	 1.00 (  2.08)	 -0.39 (  2.29)
UDP_RR          	thread-96	 1.00 (  2.48)	 -4.26 ( 16.06)
UDP_RR          	thread-144	 1.00 ( 49.50)	 -3.28 ( 34.86)
UDP_RR          	thread-192	 1.00 (  6.39)	 +8.07 ( 88.15)
UDP_RR          	thread-384	 1.00 ( 31.54)	-12.76 ( 35.98)
