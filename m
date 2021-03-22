Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97CE343B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 09:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCVINK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 04:13:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:47597 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230084AbhCVIMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 04:12:33 -0400
IronPort-SDR: BIJVyEQeTFGZAubgkD/ex/huaacF/rszT56eksHgX1wMJ1YmxvdQI/RsY5sJjDNbtBrLzCxDyh
 VTHbpihitE9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="275317210"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="275317210"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 01:12:30 -0700
IronPort-SDR: AU26YGdKix0HcaDhAo9g4bthVQzuaK3G9gdTzRuZTiKGUICqCGx4i7siTkSyMNe8mnIvyo0V9Q
 j40y5hhmS93w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="441062304"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2021 01:12:18 -0700
Subject: Re: [PATCH 1/6] sched: migration changes for core scheduling
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        torvalds@linux-foundation.org, fweisbec@gmail.com,
        keescook@chromium.org, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>, chris.hyser@oracle.com,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@intel.com>
References: <20210319203253.3352417-1-joel@joelfernandes.org>
 <20210319203253.3352417-2-joel@joelfernandes.org>
 <20210320153457.GX4746@worktop.programming.kicks-ass.net>
 <28e13609-c526-c6ee-22a3-898652aed5e6@linux.intel.com>
 <YFhL4CMPB+Pfo965@hirez.programming.kicks-ass.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <af3f6ea6-2c71-233f-fc6b-af039b004923@linux.intel.com>
Date:   Mon, 22 Mar 2021 16:12:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFhL4CMPB+Pfo965@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/22 15:48, Peter Zijlstra wrote:
> On Sun, Mar 21, 2021 at 09:34:00PM +0800, Li, Aubrey wrote:
>> Hi Peter,
>>
>> On 2021/3/20 23:34, Peter Zijlstra wrote:
>>> On Fri, Mar 19, 2021 at 04:32:48PM -0400, Joel Fernandes (Google) wrote:
>>>> @@ -7530,8 +7543,9 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>>>  	 * We do not migrate tasks that are:
>>>>  	 * 1) throttled_lb_pair, or
>>>>  	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
>>>> -	 * 3) running (obviously), or
>>>> -	 * 4) are cache-hot on their current CPU.
>>>> +	 * 3) task's cookie does not match with this CPU's core cookie
>>>> +	 * 4) running (obviously), or
>>>> +	 * 5) are cache-hot on their current CPU.
>>>>  	 */
>>>>  	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
>>>>  		return 0;
>>>> @@ -7566,6 +7580,13 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
>>>>  		return 0;
>>>>  	}
>>>>  
>>>> +	/*
>>>> +	 * Don't migrate task if the task's cookie does not match
>>>> +	 * with the destination CPU's core cookie.
>>>> +	 */
>>>> +	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
>>>> +		return 0;
>>>> +
>>>>  	/* Record that we found atleast one task that could run on dst_cpu */
>>>>  	env->flags &= ~LBF_ALL_PINNED;
>>>>  
>>>
>>> This one is too strong.. persistent imbalance should be able to override
>>> it.
>>>
>>
>> IIRC, this change can avoid the following scenario:
>>
>> One sysbench cpu thread(cookieA) and sysbench mysql thread(cookieB) running
>> on the two siblings of core_1, the other sysbench cpu thread(cookieA) and
>> sysbench mysql thread(cookieB) running on the two siblings of core2, which
>> causes 50% force idle.
>>
>> This is not an imbalance case.
> 
> But suppose there is an imbalance; then this cookie crud can forever
> stall balance.
> 
> Imagine this cpu running a while(1); with a uniqie cookie on, then it
> will _never_ accept other tasks == BAD.
> 

How about putting the following check in sched_core_cookie_match()?

+	/*
+	 * Ignore cookie match if there is a big imbalance between the src rq
+	 * and dst rq.
+	 */
+	if ((src_rq->cfs.h_nr_running - rq->cfs.h_nr_running) > 1)
+		return true;

This change has significant impact of my sysbench cpu+mysql colocation.

- with this change,
  sysbench cpu tput = 2796 events/s, sysbench mysql = 1315 events/s

- without it, 
  sysbench cpu tput= 3513 events/s, sysbench mysql = 646 events.

Do you have any suggestions before we drop it?

Thanks,
-Aubrey
