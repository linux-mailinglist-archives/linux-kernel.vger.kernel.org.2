Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A633AD02B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 18:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbhFRQQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 12:16:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:11556 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235572AbhFRQQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 12:16:53 -0400
IronPort-SDR: G5igGP8NHH4zqzEUR4m6z+kAHV3PRbssP8k69h2lqTstNYv4O5Bdyt6FM2uqPzHLFQtMUy8hat
 GLi6kmT8GeoA==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="228107989"
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="228107989"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 09:14:09 -0700
IronPort-SDR: grecWCbWLShL3k2D500boaEDGhZ/XvdIqKc1m8uoOBzd3fFDwJz8dyVlzGkOYCdlnc/jssRQGA
 0ueJBctZGTqQ==
X-IronPort-AV: E=Sophos;i="5.83,284,1616482800"; 
   d="scan'208";a="640748206"
Received: from salmansi-mobl1.amr.corp.intel.com (HELO schen9-mobl.amr.corp.intel.com) ([10.212.173.244])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 09:14:08 -0700
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Neeraj upadhyay <neeraj.iitr10@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
References: <efad4771-c9d1-5103-de9c-0ec5fa78ee24@linux.intel.com>
 <CAKfTPtDsya_zdUB1ARmoxQs5xWS8o-XrrzyNx5R1iSNrchUXtg@mail.gmail.com>
 <fc0efe4e-0a81-03b8-08cb-029468c57782@linux.intel.com>
 <CAKfTPtCKavGWja42NdTmb+95ppG-WxYzoTJMmtgkCQcA-btfBw@mail.gmail.com>
 <4aa674d9-db49-83d5-356f-a20f9e2a7935@linux.intel.com>
 <CAKfTPtDJaTr_HR2t=9CQ-9x6keu-qzx6okci92AdW5cJG8J9zg@mail.gmail.com>
 <2d2294ce-f1d1-f827-754b-4541c1b43be8@linux.intel.com>
 <ade18978-cd67-6215-28f0-4857c66a99fb@linux.intel.com>
 <CAKfTPtA8nr-fgt4Nw6XqQyT_TEx4uL3nK-ba0xGfkONO+BPG3Q@mail.gmail.com>
 <577b0aae-0111-97aa-0c99-c2a2fcfb5e2e@linux.intel.com>
 <20210512135955.suzvxxfilvwg33y2@e107158-lin.cambridge.arm.com>
 <729718fd-bd2c-2e0e-46f5-8027281e5821@linux.intel.com>
 <CAKfTPtCYU2AW3sJ-=QJ=hE+tFHS8wUBZ9vSsZp8q2AozxeA5mQ@mail.gmail.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <366aa93b-ecbf-ac0f-cd9e-3376b20d4929@linux.intel.com>
Date:   Fri, 18 Jun 2021 09:14:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCYU2AW3sJ-=QJ=hE+tFHS8wUBZ9vSsZp8q2AozxeA5mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/18/21 3:28 AM, Vincent Guittot wrote:

>>
>> The current logic is when a CPU becomes idle, next_balance occur very
>> shortly (usually in the next jiffie) as get_sd_balance_interval returns
>> the next_balance in the next jiffie if the CPU is idle.  However, in
>> reality, I saw most CPUs are 95% busy on average for my workload and
>> a task will wake up on an idle CPU shortly.  So having frequent idle
>> balancing towards shortly idle CPUs is counter productive and simply
>> increase overhead and does not improve performance.
> 
> Just to make sure that I understand your problem correctly:  Your problem is:
> - that we have an ilb happening on the idle CPU and consume cycle

That's right.  The cycles are consumed heavily in update_blocked_averages()
when cgroup is enabled.

> - or that the ilb will pull a task on an idle CPU on which a task will
> shortly wakeup which ends to 2 tasks competing for the same CPU.
> 

Because for the OLTP workload I'm looking at, we have tasks that sleep 
for a short while and wake again very shortly (i.e. the CPU actually
is ~95% busy on average), pulling tasks to such a CPU is really not
helpful to improve overall CPU utilization in the system.  So my
intuition is for such almost fully busy CPU, we should defer load
balancing to it (see prototype patch 3).

Tim 




