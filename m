Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC36347D42
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 17:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhCXQF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 12:05:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:39449 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236945AbhCXQFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 12:05:49 -0400
IronPort-SDR: mIXDIwNuNSNww3tqiDEKRXhG9uIWigDVwDQjodkHW802SLVxJoqV/9n9dq/8X8O9MQeNIxNs8W
 SmSMZXpSQqlw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190155627"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190155627"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 09:05:46 -0700
IronPort-SDR: ihobvkSHEzABqpoTdtN8IMvlv+aBrg0xYM69wLElOD+RCg7CUwlr3wKwgHKKa2aQVtfWuSdjdy
 FSShduImxACw==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="413835847"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.92.177])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 09:05:46 -0700
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
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
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com>
 <CAKfTPtBWoRuwwkaqQKNgHTnQBE4fevyYqEoeGc5RpCsBbOS1sQ@mail.gmail.com>
 <YBG0W5PFGtGRCEuB@google.com>
 <CAKfTPtBqj5A_7QmxhhmkNTc3+VT6+AqWgw1GDYrgy1V5+PJMmQ@mail.gmail.com>
 <CAEXW_YRrhEfGcLN5yrLJZm6HrB15M_R5xfpMReG2wE2rSmVWdA@mail.gmail.com>
 <CAKfTPtBvwm9vZb5C=2oTF6N-Ht6Rvip4Lv18yi7O3G8e-_ZWdg@mail.gmail.com>
 <20210129172727.GA30719@vingu-book>
 <274d8ae5-8f4d-7662-0e04-2fbc92b416fc@linux.intel.com>
 <20210324134437.GA17675@vingu-book>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <efad4771-c9d1-5103-de9c-0ec5fa78ee24@linux.intel.com>
Date:   Wed, 24 Mar 2021 09:05:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20210324134437.GA17675@vingu-book>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/21 6:44 AM, Vincent Guittot wrote:
> Hi Tim,

> 
> IIUC your problem, we call update_blocked_averages() but because of:
> 
> 		if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
> 			update_next_balance(sd, &next_balance);
> 			break;
> 		}
> 
> the for_each_domain loop stops even before running load_balance on the 1st
> sched domain level which means that update_blocked_averages() was called
> unnecessarily. 
> 

That's right

> And this is even more true with a small sysctl_sched_migration_cost which allows newly
> idle LB for very small this_rq->avg_idle. We could wonder why you set such a low value 
> for sysctl_sched_migration_cost which is lower than the max_newidle_lb_cost of the
> smallest domain but that's probably because of task_hot().
> 
> if avg_idle is lower than the sd->max_newidle_lb_cost of the 1st sched_domain, we should
> skip spin_unlock/lock and for_each_domain() loop entirely
> 
> Maybe something like below:
> 

The patch makes sense.  I'll ask our benchmark team to queue this patch for testing.

Tim


