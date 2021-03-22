Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B43445A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhCVNY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:24:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:26785 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233262AbhCVNWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:22:41 -0400
IronPort-SDR: dEXUgLbnhNDvENzKxjUUmenDPP/o+WObGG+blwqV23szVds7YkcH0ibooKcRglADL+NNCZnfC8
 pEQpmF9BYibg==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="190296640"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="190296640"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 06:17:26 -0700
IronPort-SDR: vfXsgkkiu84WUlsDvbom8XwEQVfN8YWP1euoSUNWr7A+CW2fhOfex0pfvlcx4Qwhw+XEjBsYa8
 qpGcM1d3MiOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="441169997"
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.125]) ([10.239.161.125])
  by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2021 06:17:12 -0700
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
 <af3f6ea6-2c71-233f-fc6b-af039b004923@linux.intel.com>
 <YFhcD/jz7kC8jaXa@hirez.programming.kicks-ass.net>
 <bb075bed-150c-8ea0-3035-0a8c3c98e572@linux.intel.com>
 <YFiT4/mmisnBFJ96@hirez.programming.kicks-ass.net>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <9398a329-5989-0e3f-26d4-4193b25e7958@linux.intel.com>
Date:   Mon, 22 Mar 2021 21:17:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YFiT4/mmisnBFJ96@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/3/22 20:56, Peter Zijlstra wrote:
> On Mon, Mar 22, 2021 at 08:31:09PM +0800, Li, Aubrey wrote:
>> Please let me know if I put cookie match check at the right position
>> in task_hot(), if so, I'll obtain some performance data of it.
>>
>> Thanks,
>> -Aubrey
>>
>> =======================================================
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7f2fb08..d4bdcf9 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -1912,6 +1912,13 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>>  		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
>>  			continue;
>>  
>> +		/*
>> +		 * Skip this cpu if source task's cookie does not match
>> +		 * with CPU's core cookie.
>> +		 */
>> +		if (!sched_core_cookie_match(cpu_rq(cpu), env->p))
>> +			continue;
>> +
>>  		env->dst_cpu = cpu;
>>  		if (task_numa_compare(env, taskimp, groupimp, maymove))
>>  			break;
> 
> This one might need a little help too, I've not fully considered NUMA
> balancing though.
> 
>> @@ -6109,7 +6120,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>>  	for_each_cpu_wrap(cpu, cpus, target) {
>>  		if (!--nr)
>>  			return -1;
>> -		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>> +
>> +		if ((available_idle_cpu(cpu) || sched_idle_cpu(cpu)) &&
>> +		    sched_cpu_cookie_match(cpu_rq(cpu), p))
>>  			break;
>>  	}
>>  
> 
> This doesn't even apply... That code has changed.
> 
>> @@ -7427,6 +7440,14 @@ static int task_hot(struct task_struct *p, struct lb_env *env)
>>  
>>  	if (sysctl_sched_migration_cost == -1)
>>  		return 1;
>> +
>> +	/*
>> +	 * Don't migrate task if the task's cookie does not match
>> +	 * with the destination CPU's core cookie.
>> +	 */
>> +	if (!sched_core_cookie_match(cpu_rq(env->dst_cpu), p))
>> +		return 1;
>> +
>>  	if (sysctl_sched_migration_cost == 0)
>>  		return 0;
>>  
> 
> Should work I think, but you've put it in a weird spot for breaking up
> that sysctl_sched_migration_cost thing. I'd have put it either in front
> or after that other SMT thing we have there.
> 

I did it on purpose.

If migration cost is huge, the task should not migrate, no matter the
cookie is matched or not. So have to after sysctl_sched_migration_cost == -1.

And if migration cost = 0 or delta < migrate cost , the task can be migrated,
but before migrate, We need to check whether cookie is matched or not. So before
sysctl_sched_migration_cost == 0.

Please correct me if I was wrong.

Thanks,
-Aubrey
