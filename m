Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C490D30554F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 09:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbhA0ILb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 03:11:31 -0500
Received: from mga01.intel.com ([192.55.52.88]:59362 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232076AbhA0II6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 03:08:58 -0500
IronPort-SDR: XYOC/SFo42Fl8R8HDhcSFX5wubP27cUHqOIdUbQXQB+Jk7K9IAHhCMRvFlK8fBNVaTlqpMeF8Y
 Z8j0nolO4fTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="198836118"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="xz'?scan'208";a="198836118"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 00:04:29 -0800
IronPort-SDR: krWen2EpR7hKzICNthClFsu7IZqVv9pTyGU9YKGdYdBwZ7YvpMhRnxFbJSsf0XbdvAXF44fKlf
 oGRguRKt+Qtg==
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; 
   d="xz'?scan'208";a="362327863"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.6.97]) ([10.238.6.97])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 00:04:27 -0800
Subject: Re: [workqueue] d5bff968ea:
 WARNING:at_kernel/workqueue.c:#process_one_work
To:     Hillf Danton <hdanton@sina.com>
Cc:     Oliver Sang <oliver.sang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@intel.com,
        lkp <lkp@lists.01.org>
References: <20210126073925.1962-1-hdanton@sina.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <4dce2be8-b4f7-fd33-b344-87b3f809375c@linux.intel.com>
Date:   Wed, 27 Jan 2021 16:04:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210126073925.1962-1-hdanton@sina.com>
Content-Type: multipart/mixed;
 boundary="------------40953547EFC47796CDD463EB"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------40953547EFC47796CDD463EB
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/26/2021 3:39 PM, Hillf Danton wrote:
> On 26 Jan 2021 10:45:21 +0800 Xing Zhengjun wrote:
>> On 1/25/2021 5:29 PM, Hillf Danton wrote:
>>> On 25 Jan 2021 16:31:32 +0800 Xing Zhengjun wrote:
>>>> On 1/22/2021 3:59 PM, Hillf Danton wrote:
>>>>> On Fri, 22 Jan 2021 09:48:32 +0800 Xing Zhengjun wrote:
>>>>>> On 1/21/2021 12:00 PM, Hillf Danton wrote:
>>>>>>> On Wed, 20 Jan 2021 21:46:33 +0800 Oliver Sang wrote:
>>>>>>>> On Fri, Jan 15, 2021 at 03:24:32PM +0800, Hillf Danton wrote:
>>>>>>>>> Thu, 14 Jan 2021 15:45:11 +0800
>>>>>>>>>>
>>>>>>>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>>>>>>>
>>>>>>>>>> commit: d5bff968ea9cc005e632d9369c26cbd8148c93d5 ("workqueue: break affinity initiatively")
>>>>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2021.01.11b
>>>>>>>>>>
>>>>>>>>> [...]
>>>>>>>>>>
>>>>>>>>>> [   73.794288] WARNING: CPU: 0 PID: 22 at kernel/workqueue.c:2192 process_one_work
>>>>>>>>>
>>>>>>>>> Thanks for your report.
>>>>>>>>>
>>>>>>>>> We can also break CPU affinity by checking POOL_DISASSOCIATED at attach
>>>>>>>>> time without extra cost paid; that way we have the same behavior as at
>>>>>>>>> the unbind time.
>>>>>>>>>
>>>>>>>>> What is more the change that makes kworker pcpu is cut because they are
>>>>>>>>> going to not help either hotplug or the mechanism of stop machine.
>>>>>>>>
>>>>>>>> hi, by applying below patch, the issue still happened.
>>>>>>>
>>>>>>> Thanks for your report.
>>>>>>>>
>>>>>>>> [ 4.574467] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
>>>>>>>> [ 4.575651] pci 0000:00:01.0: Activating ISA DMA hang workarounds
>>>>>>>> [ 4.576900] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
>>>>>>>> [ 4.578648] PCI: CLS 0 bytes, default 64
>>>>>>>> [ 4.579685] Unpacking initramfs...
>>>>>>>> [ 8.878031] -----------[ cut here ]-----------
>>>>>>>> [ 8.879083] WARNING: CPU: 0 PID: 22 at kernel/workqueue.c:2187 process_one_work+0x92/0x9e0
>>>>>>>> [ 8.880688] Modules linked in:
>>>>>>>> [ 8.881274] CPU: 0 PID: 22 Comm: kworker/1:0 Not tainted 5.11.0-rc3-gc213503139bb #2
>>>>>>>
>>>>>>> The kworker bond to CPU1 runs on CPU0 and triggers the warning, which
>>>>>>> shows that scheduler breaks CPU affinity, after 06249738a41a
>>>>>>> ("workqueue: Manually break affinity on hotplug"), though quite likely
>>>>>>> by kworker/1:0 for the initial workers.
>>>>>>>
>>>>>>>> [ 8.882518] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>>>>>>> [ 8.887539] Workqueue: 0x0 (events)
>>>>>>>> [ 8.887838] EIP: process_one_work+0x92/0x9e0
>>>>>>>> [ 8.887838] Code: 37 64 a1 58 54 4c 43 39 45 24 74 2c 31 c9 ba 01 00 00 00 c7 04 24 01 00 00 00 b8 08 1d f5 42 e8 74 85 13 00 ff 05 b8 30 04 43 <0f> 0b ba 01 00 00 00 eb 22 8d 74 26 00 90 c7 04 24 01 00 00 00 31
>>>>>>>> [ 8.887838] EAX: 42f51d08 EBX: 00000000 ECX: 00000000 EDX: 00000001
>>>>>>>> [ 8.887838] ESI: 43c04720 EDI: 42e45620 EBP: de7f23c0 ESP: 43d7bf08
>>>>>>>> [ 8.887838] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
>>>>>>>> [ 8.887838] CR0: 80050033 CR2: 00000000 CR3: 034e3000 CR4: 000406d0
>>>>>>>> [ 8.887838] Call Trace:
>>>>>>>> [ 8.887838] ? worker_thread+0x98/0x6a0
>>>>>>>> [ 8.887838] ? worker_thread+0x2dd/0x6a0
>>>>>>>> [ 8.887838] ? kthread+0x1ba/0x1e0
>>>>>>>> [ 8.887838] ? create_worker+0x1e0/0x1e0
>>>>>>>> [ 8.887838] ? kzalloc+0x20/0x20
>>>>>>>> [ 8.887838] ? ret_from_fork+0x1c/0x28
>>>>>>>> [ 8.887838] _warn_unseeded_randomness: 63 callbacks suppressed
>>>>>>>> [ 8.887838] random: get_random_bytes called from init_oops_id+0x2b/0x60 with crng_init=0
>>>>>>>> [ 8.887838] --[ end trace ac461b4d54c37cfa ]--
>>>>>>>
>>>>>>>
>>>>>>> Instead of creating the initial workers only on the active CPUS, rebind
>>>>>>> them (labeled pcpu) and jump to the right CPU at bootup time.
>>>>>>>
>>>>>>> --- a/kernel/workqueue.c
>>>>>>> +++ b/kernel/workqueue.c
>>>>>>> @@ -2385,6 +2385,16 @@ woke_up:
>>>>>>>      		return 0;
>>>>>>>      	}
>>>>>>>      
>>>>>>> +	if (!(pool->flags & POOL_DISASSOCIATED) && smp_processor_id() !=
>>>>>>> +								pool->cpu) {
>>>>>>> +		/* scheduler breaks CPU affinity for us, rebind it */
>>>>>>> +		raw_spin_unlock_irq(&pool->lock);
>>>>>>> +		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>>>>>>> +		/* and jump to the right seat */
>>>>>>> +		schedule_timeout_interruptible(1);
>>>>>>> +		goto woke_up;
>>>>>>> +	}
>>>>>>> +
>>>>>>>      	worker_leave_idle(worker);
>>>>>>>      recheck:
>>>>>>>      	/* no more worker necessary? */
>>>>>>> --
>>>>>>>
>>>>>> I test the patch, the warning still appears in the kernel log.
>>>>>
>>>>> Thanks for your report.
>>>>>>
>>>>>> [  230.356503] smpboot: CPU 1 is now offline
>>>>>> [  230.544652] x86: Booting SMP configuration:
>>>>>> [  230.545077] smpboot: Booting Node 0 Processor 1 APIC 0x1
>>>>>> [  230.545640] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
>>>>>> [  230.545675] masked ExtINT on CPU#1
>>>>>> [  230.593829] ------------[ cut here ]------------
>>>>>> [  230.594257] WARNING: CPU: 0 PID: 257 at kernel/workqueue.c:2192 process_one_work+0x92/0x9e0
>>>>>> [  230.594990] Modules linked in: rcutorture torture mousedev input_leds
>>>>>> led_class pcspkr psmouse evbug tiny_power_button button
>>>>>> [  230.595961] CPU: 0 PID: 257 Comm: kworker/1:3 Not tainted 5.11.0-rc3-gdcba55d9080f #2
>>>>>
>>>>> Like what was reported, kworker bond to CPU1 runs on CPU0 and triggers
>>>>> warning, due to scheduler breaking CPU affinity for us. What is new, the
>>>>> affinity was broken at offline time instead of bootup.
>>>>>
>>>>>> [  230.596621] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>>>>> [  230.597322] Workqueue:  0x0 (rcu_gp)
>>>>>> [  230.597636] EIP: process_one_work+0x92/0x9e0
>>>>>> [  230.598005] Code: 37 64 a1 58 54 4c 43 39 45 24 74 2c 31 c9 ba 01 00
>>>>>> 00 00 c7 04 24 01 00 00 00 b8 08 1d f5 42 e8 f4 85 13 00 ff 05 cc 30 04
>>>>>> 43 <0f> 0b ba 01 00 00 00 eb 22 8d 74 26 00 90 c7 04 24 01 00 00 00 31
>>>>>> [  230.599569] EAX: 42f51d08 EBX: 00000000 ECX: 00000000 EDX: 00000001
>>>>>> [  230.600100] ESI: 43d94240 EDI: df4040f4 EBP: de7f23c0 ESP: bf5f1f08
>>>>>> [  230.600629] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
>>>>>> [  230.601203] CR0: 80050033 CR2: 01bdecbc CR3: 04e2c000 CR4: 000406d0
>>>>>> [  230.601735] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
>>>>>> [  230.602265] DR6: fffe0ff0 DR7: 00000400
>>>>>> [  230.602594] Call Trace:
>>>>>> [  230.602813]  ? process_one_work+0x20e/0x9e0
>>>>>> [  230.603181]  ? worker_thread+0x32d/0x700
>>>>>> [  230.603522]  ? kthread+0x1ba/0x1e0
>>>>>> [  230.603818]  ? create_worker+0x1e0/0x1e0
>>>>>> [  230.604157]  ? kzalloc+0x20/0x20
>>>>>> [  230.604524]  ? ret_from_fork+0x1c/0x28
>>>>>> [  230.604850] ---[ end trace 06b1e66b5e17fa85 ]---
>>>>>> [  230.605504] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
>>>>>> [  230.766960] smpboot: CPU 1 is now offline
>>>>>> [  230.814803] x86: Booting SMP configuration:
>>>>>> [  230.815306] smpboot: Booting Node 0 Processor 1 APIC 0x1
>>>>>> [  230.815964] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
>>>>>
>>>>>
>>>>> Unlike the above diff that is at most papering over the problem
>>>>> sitting somewhere in the scheduler, add change to creating worker
>>>>> by skipping set_cpus_allowed_ptr() because we will wake it up after
>>>>> attaching it to worker pool.
>>>>>
>>>>> If we can ignore rescuer for now, then the allowed ptr is only
>>>>> updated at on/offline time; lets see the difference at boot time.
>>>>>
>>>>>
>>>>> --- a/kernel/workqueue.c
>>>>> +++ b/kernel/workqueue.c
>>>>> @@ -1844,16 +1844,10 @@ static struct worker *alloc_worker(int n
>>>>>      * cpu-[un]hotplugs.
>>>>>      */
>>>>>     static void worker_attach_to_pool(struct worker *worker,
>>>>> -				   struct worker_pool *pool)
>>>>> +				   struct worker_pool *pool,
>>>>> +				   int update_cpus_allowed)
>>>>>     {
>>>>>     	mutex_lock(&wq_pool_attach_mutex);
>>>>> -
>>>>> -	/*
>>>>> -	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
>>>>> -	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
>>>>> -	 */
>>>>> -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>>>>> -
>>>>>     	/*
>>>>>     	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
>>>>>     	 * stable across this function.  See the comments above the flag
>>>>> @@ -1867,6 +1861,9 @@ static void worker_attach_to_pool(struct
>>>>>     	list_add_tail(&worker->node, &pool->workers);
>>>>>     	worker->pool = pool;
>>>>>     
>>>>> +	if (update_cpus_allowed)
>>>>> +		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>>>>> +
>>>>>     	mutex_unlock(&wq_pool_attach_mutex);
>>>>>     }
>>>>>     
>>>>> @@ -1942,8 +1939,11 @@ static struct worker *create_worker(stru
>>>>>     	set_user_nice(worker->task, pool->attrs->nice);
>>>>>     	kthread_bind_mask(worker->task, pool->attrs->cpumask);
>>>>>     
>>>>> -	/* successful, attach the worker to the pool */
>>>>> -	worker_attach_to_pool(worker, pool);
>>>>> +	/*
>>>>> +	 * attach the worker to the pool without asking scheduler to
>>>>> +	 * update CPUs allowed
>>>>> +	 */
>>>>> +	worker_attach_to_pool(worker, pool, 0);
>>>>>     
>>>>>     	/* start the newly created worker */
>>>>>     	raw_spin_lock_irq(&pool->lock);
>>>>> @@ -2508,7 +2508,7 @@ repeat:
>>>>>     
>>>>>     		raw_spin_unlock_irq(&wq_mayday_lock);
>>>>>     
>>>>> -		worker_attach_to_pool(rescuer, pool);
>>>>> +		worker_attach_to_pool(rescuer, pool, 1);
>>>>>     
>>>>>     		raw_spin_lock_irq(&pool->lock);
>>>>>     
>>>>> --
>>>>>
>>>> I test the patch, the warning still appears in the kernel log.
>>>
>>> Thanks.
>>>>
>>>> [   55.754187] smpboot: Booting Node 0 Processor 1 APIC 0x1
>>>> [   55.785594] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
>>>> [   55.785646] masked ExtINT on CPU#1
>>>> [   55.920602] ------------[ cut here ]------------
>>>> [   55.921355] WARNING: CPU: 0 PID: 160 at kernel/workqueue.c:2192 process_one_work+0x92/0x9e0
>>>> [   55.922583] Modules linked in: rcutorture torture mousedev evbug
>>>> input_leds led_class tiny_power_button psmouse pcspkr button
>>>> [   55.924294] CPU: 0 PID: 160 Comm: kworker/1:2 Not tainted 5.11.0-rc3-00186-g77bf4e461cfa #2
>>>
>>> Same issue as before.
>>>
>>>> [   55.925552] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>>> [   55.926763] Workqueue:  0x0 (rcu_gp)
>>>> [   55.927298] EIP: process_one_work+0x92/0x9e0
>>>> [   55.927950] Code: 37 64 a1 58 54 4c 43 39 45 24 74 2c 31 c9 ba 01 00
>>>> 00 00 c7 04 24 01 00 00 00 b8 08 1d f5 42 e8 94 85 13 00 ff 05 b8 30 04
>>>> 43 <0f> 0b ba 01 00 00 00 eb 22 8d 74 26 00 90 c7 04 24 01 00 00 00 31
>>>> [   55.930726] EAX: 42f51d08 EBX: 00000000 ECX: 00000000 EDX: 00000001
>>>> [   55.931642] ESI: 43d90540 EDI: df48c0f4 EBP: de7f23c0 ESP: bfb47f08
>>>> [   55.932590] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
>>>> [   55.933609] CR0: 80050033 CR2: 024e994c CR3: 7fd80000 CR4: 000406d0
>>>> [   55.934555] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
>>>> [   55.935457] DR6: fffe0ff0 DR7: 00000400
>>>> [   55.936041] Call Trace:
>>>> [   55.936534]  ? process_one_work+0x20e/0x9e0
>>>> [   55.937305]  ? worker_thread+0x2dd/0x6a0
>>>> [   55.938018]  ? kthread+0x1ba/0x1e0
>>>> [   55.938598]  ? create_worker+0x1e0/0x1e0
>>>> [   55.939315]  ? kzalloc+0x20/0x20
>>>> [   55.940000]  ? ret_from_fork+0x1c/0x28
>>>> [   55.940627] ---[ end trace d155e9e6402de179 ]---
>>>> [   55.941641] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
>>>> [   56.155271] smpboot: CPU 1 is now offline
>>>> [   56.193613] x86: Booting SMP configuration:
>>>> [   56.194400] smpboot: Booting Node 0 Processor 1 APIC 0x1
>>>
>>> The changes in the diff below are
>>>
>>> 1/ at rescue time, change CPU affinity only if POOL_DISASSOCIATED
>>> is not set, and print warning the same way as offline time.
>>>
>>> 2/ at offine time, dont update allowed CPUs after setting
>>> POOL_DISASSOCIATED because we no longer have interest in affinity.
>>>
>>> 3/ at online time, mark pcpu before binding affinity.
>>>
>>> Though one change a diff is appreciated, by the WARNs, we can tell
>>> which is what if any warning goes into dmesg.
>>>
>>> --- a/kernel/workqueue.c
>>> +++ b/kernel/workqueue.c
>>> @@ -1844,25 +1844,23 @@ static struct worker *alloc_worker(int n
>>>     * cpu-[un]hotplugs.
>>>     */
>>>    static void worker_attach_to_pool(struct worker *worker,
>>> -				   struct worker_pool *pool)
>>> +				   struct worker_pool *pool, int set)
>>>    {
>>>    	mutex_lock(&wq_pool_attach_mutex);
>>>    
>>>    	/*
>>> -	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
>>> -	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
>>> -	 */
>>> -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>>> -
>>> -	/*
>>>    	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
>>>    	 * stable across this function.  See the comments above the flag
>>>    	 * definition for details.
>>>    	 */
>>>    	if (pool->flags & POOL_DISASSOCIATED)
>>>    		worker->flags |= WORKER_UNBOUND;
>>> -	else
>>> +	else {
>>>    		kthread_set_per_cpu(worker->task, true);
>>> +		if (set)
>>> +			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
>>> +						pool->attrs->cpumask) < 0);
>>> +	}
>>>    
>>>    	list_add_tail(&worker->node, &pool->workers);
>>>    	worker->pool = pool;
>>> @@ -1943,7 +1941,7 @@ static struct worker *create_worker(stru
>>>    	kthread_bind_mask(worker->task, pool->attrs->cpumask);
>>>    
>>>    	/* successful, attach the worker to the pool */
>>> -	worker_attach_to_pool(worker, pool);
>>> +	worker_attach_to_pool(worker, pool, 0);
>>>    
>>>    	/* start the newly created worker */
>>>    	raw_spin_lock_irq(&pool->lock);
>>> @@ -2508,7 +2506,7 @@ repeat:
>>>    
>>>    		raw_spin_unlock_irq(&wq_mayday_lock);
>>>    
>>> -		worker_attach_to_pool(rescuer, pool);
>>> +		worker_attach_to_pool(rescuer, pool, 1);
>>>    
>>>    		raw_spin_lock_irq(&pool->lock);
>>>    
>>> @@ -4923,7 +4921,6 @@ static void unbind_workers(int cpu)
>>>    
>>>    		for_each_pool_worker(worker, pool) {
>>>    			kthread_set_per_cpu(worker->task, false);
>>> -			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
>>>    		}
>>>    
>>>    		mutex_unlock(&wq_pool_attach_mutex);
>>> @@ -4977,9 +4974,9 @@ static void rebind_workers(struct worker
>>>    	 * from CPU_ONLINE, the following shouldn't fail.
>>>    	 */
>>>    	for_each_pool_worker(worker, pool) {
>>> +		kthread_set_per_cpu(worker->task, true);
>>>    		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
>>>    						  pool->attrs->cpumask) < 0);
>>> -		kthread_set_per_cpu(worker->task, true);
>>>    	}
>>>    
>>>    	raw_spin_lock_irq(&pool->lock);
>>> --
>>>
>> I test the patch, the warning still appears in the kernel log, but the
> 
> Thanks.
> 
>> warning is different from before.
>>
>> [    0.054803] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
>> [    0.054803] masked ExtINT on CPU#1
>> [    0.054803] smpboot: CPU 1 Converting physical 0 to logical die 1
>> [    1.890338] ------------[ cut here ]------------
>> [    1.890338] WARNING: CPU: 1 PID: 18 at kernel/kthread.c:508 kthread_set_per_cpu+0x156/0x180
>> [    1.890338] Modules linked in:
>> [    1.890338] CPU: 1 PID: 18 Comm: cpuhp/1 Not tainted 5.11.0-rc3-00186-ged03082352b2 #2
> 
> This warning is better than the one in process_one_work() which is too
> late, though, it has something to say.
> 
>> [    1.890338] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>> [    1.890338] EIP: kthread_set_per_cpu+0x156/0x180
>> [    1.890338] Code: 00 00 00 00 ff 05 68 4e 04 43 83 c4 08 5b 5e 5f c3
>> 8d 76 00 ff 05 34 50 04 43 0f 0b e9 f9 fe ff ff 8d 76 00 ff 05 2c 4e 04
>> 43 <0f> 0b eb 9d 8d b6 00 00 00 00 ff 05 40 4e 04 43 0f 0b e9 45 ff ff
>> [    1.890338] EAX: 42f52ce0 EBX: 00000001 ECX: 00000000 EDX: 00000001
>> [    1.890338] ESI: 43d76300 EDI: 43c0de00 EBP: de7f2564 ESP: 43d6beb8
>> [    1.900350] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
>> [    1.901303] CR0: 80050033 CR2: 00000000 CR3: 034e3000 CR4: 000406d0
>> [    1.902280] Call Trace:
>> [    1.902682]  ? workqueue_online_cpu+0x12b/0x640
>> [    1.903415]  ? workqueue_prepare_cpu+0xa0/0xa0
> 
> By the prepare function we know it is a warning at boot time.
> 
>> [    1.904155]  ? cpuhp_invoke_callback+0x1ed/0x1340
>> [    1.904941]  ? cpuhp_thread_fun+0x28f/0x460
>> [    1.905630]  ? cpuhp_thread_fun+0x49/0x460
>> [    1.906298]  ? smpboot_thread_fn+0x446/0x620
>> [    1.910275]  ? kthread+0x1ba/0x1e0
>> [    1.910857]  ? __smpboot_create_thread+0x260/0x260
>> [    1.911659]  ? kzalloc+0x20/0x20
>> [    1.912368]  ? ret_from_fork+0x1c/0x28
>> [    1.913016] ---[ end trace 6f6c005278241eba ]---
>> [    1.913971] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
>> [    1.920012] smp: Brought up 1 node, 2 CPUs
>> [    1.920299] smpboot: Max logical packages: 2
>> [    1.921019] smpboot: Total of 2 processors activated (10774.03 BogoMIPS)
> 
> After staring at it again, the change added in rebind_workers() is
> incorrect for a CPU getting back online after bootup, because the
> CPU affinity has been broken at offline time.
> 
> But the warning in the latest report occurs at boot time, after going
> through steps like,
> 
> 	kthread_create_on_node();
> 
> 	kthread_bind_mask(worker->task, pool->attrs->cpumask);
> 
> 	/* successful, attach the worker to the pool */
> 	worker_attach_to_pool(worker, pool, 0);
> 
> 	/* start the newly created worker */
> 	wake_up_process(worker->task);
> 
> 
> without triggering the warning at kernel/kthread.c:507.
> 
> Before finding an answer (wake_up_new_task()) to the question,
> who changed the allowed ptr?  revert the change at online time,
> and as a compensation, clear POOL_DISASSOCIATED as early as we can.
> 
> 
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -1844,25 +1844,23 @@ static struct worker *alloc_worker(int n
>    * cpu-[un]hotplugs.
>    */
>   static void worker_attach_to_pool(struct worker *worker,
> -				   struct worker_pool *pool)
> +				   struct worker_pool *pool, int set)
>   {
>   	mutex_lock(&wq_pool_attach_mutex);
>   
>   	/*
> -	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
> -	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
> -	 */
> -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
> -
> -	/*
>   	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
>   	 * stable across this function.  See the comments above the flag
>   	 * definition for details.
>   	 */
>   	if (pool->flags & POOL_DISASSOCIATED)
>   		worker->flags |= WORKER_UNBOUND;
> -	else
> +	else {
>   		kthread_set_per_cpu(worker->task, true);
> +		if (set)
> +			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
> +						pool->attrs->cpumask) < 0);
> +	}
>   
>   	list_add_tail(&worker->node, &pool->workers);
>   	worker->pool = pool;
> @@ -1943,7 +1941,7 @@ static struct worker *create_worker(stru
>   	kthread_bind_mask(worker->task, pool->attrs->cpumask);
>   
>   	/* successful, attach the worker to the pool */
> -	worker_attach_to_pool(worker, pool);
> +	worker_attach_to_pool(worker, pool, 0);
>   
>   	/* start the newly created worker */
>   	raw_spin_lock_irq(&pool->lock);
> @@ -2508,7 +2506,7 @@ repeat:
>   
>   		raw_spin_unlock_irq(&wq_mayday_lock);
>   
> -		worker_attach_to_pool(rescuer, pool);
> +		worker_attach_to_pool(rescuer, pool, 1);
>   
>   		raw_spin_lock_irq(&pool->lock);
>   
> @@ -4923,7 +4921,6 @@ static void unbind_workers(int cpu)
>   
>   		for_each_pool_worker(worker, pool) {
>   			kthread_set_per_cpu(worker->task, false);
> -			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
>   		}
>   
>   		mutex_unlock(&wq_pool_attach_mutex);
> @@ -5954,6 +5951,7 @@ void __init workqueue_init_early(void)
>   		i = 0;
>   		for_each_cpu_worker_pool(pool, cpu) {
>   			BUG_ON(init_worker_pool(pool));
> +			pool->flags &= ~POOL_DISASSOCIATED;
>   			pool->cpu = cpu;
>   			cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
>   			pool->attrs->nice = std_nice[i++];
> --
> 
I test the patch, the warning still appears in the kernel log.

[    0.043584] masked ExtINT on CPU#1
[    0.043584] smpboot: CPU 1 Converting physical 0 to logical die 1
[    1.681867] ------------[ cut here ]------------
[    1.681867] WARNING: CPU: 1 PID: 18 at kernel/workqueue.c:5015 
workqueue_online_cpu+0x336/0x640
[    1.681867] Modules linked in:
[    1.681867] CPU: 1 PID: 18 Comm: cpuhp/1 Not tainted 
5.11.0-rc3-00186-g178826956ca7 #2
[    1.681867] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.12.0-1 04/01/2014
[    1.681867] EIP: workqueue_online_cpu+0x336/0x640
[    1.681867] Code: 01 00 00 00 eb 89 8d b6 00 00 00 00 8b 5c 24 0c 89 
d8 e8 3d 39 19 01 e9 1c fd ff ff 8d b4 26 00 00 00 00 90 ff 05 dc 20 04 
43 <0f> 0b e9 07 ff ff ff 8d 76 00 ff 05 2c 21 04 43 0f 0b e9 12 fe ff
[    1.681867] EAX: 42f51168 EBX: 0000000c ECX: 00000000 EDX: 00000001
[    1.681867] ESI: 00000000 EDI: 43c04720 EBP: de7f2564 ESP: 43d6bed0
[    1.681867] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
[    1.681867] CR0: 80050033 CR2: 00000000 CR3: 034e3000 CR4: 000406d0
[    1.681867] Call Trace:
[    1.681867]  ? workqueue_prepare_cpu+0xa0/0xa0
[    1.681867]  ? cpuhp_invoke_callback+0x1ed/0x1340
[    1.681867]  ? cpuhp_thread_fun+0x28f/0x460
[    1.681867]  ? cpuhp_thread_fun+0x49/0x460
[    1.681867]  ? smpboot_thread_fn+0x446/0x620
[    1.681867]  ? kthread+0x1ba/0x1e0
[    1.681867]  ? __smpboot_create_thread+0x260/0x260
[    1.681867]  ? kzalloc+0x20/0x20
[    1.681867]  ? ret_from_fork+0x1c/0x28
[    1.681867] ---[ end trace 3e853d8ad82e44ac ]---
[    1.691939] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[    1.705909] smp: Brought up 1 node, 2 CPUs
[    1.706605] smpboot: Max logical packages: 2

[   85.402803] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   85.442465] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
[   85.442602] masked ExtINT on CPU#1
[   85.541391] ------------[ cut here ]------------
[   85.542250] WARNING: CPU: 1 PID: 18 at kernel/kthread.c:508 
kthread_set_per_cpu+0x156/0x180
[   85.543664] Modules linked in: rcutorture torture mousedev evbug 
input_leds led_class psmouse pcspkr tiny_power_button button
[   85.545530] CPU: 1 PID: 18 Comm: cpuhp/1 Tainted: G        W 
5.11.0-rc3-00186-g178826956ca7 #2
[   85.547006] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.12.0-1 04/01/2014
[   85.548454] EIP: kthread_set_per_cpu+0x156/0x180
[   85.549231] Code: 00 00 00 00 ff 05 68 4e 04 43 83 c4 08 5b 5e 5f c3 
8d 76 00 ff 05 34 50 04 43 0f 0b e9 f9 fe ff ff 8d 76 00 ff 05 2c 4e 04 
43 <0f> 0b eb 9d 8d b6 00 00 00 00 ff 05 40 4e 04 43 0f 0b e9 45 ff ff
[   85.552236] EAX: 42f52ce0 EBX: 00000001 ECX: 00000000 EDX: 00000001
[   85.556663] ESI: bfb70000 EDI: 45e61000 EBP: de7f2564 ESP: 43d6beb8
[   85.559168] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
[   85.561991] CR0: 80050033 CR2: 00000000 CR3: 034e3000 CR4: 000406d0
[   85.563040] Call Trace:
[   85.563463]  ? workqueue_online_cpu+0x17f/0x640
[   85.564222]  ? rapl_cpu_online+0xb7/0x1a0
[   85.564904]  ? workqueue_prepare_cpu+0xa0/0xa0
[   85.565643]  ? cpuhp_invoke_callback+0x1ed/0x1340
[   85.566424]  ? cpuhp_thread_fun+0x28f/0x460
[   85.567140]  ? cpuhp_thread_fun+0x49/0x460
[   85.567844]  ? smpboot_thread_fn+0x446/0x620
[   85.568569]  ? kthread+0x1ba/0x1e0
[   85.569162]  ? __smpboot_create_thread+0x260/0x260
[   85.569961]  ? kzalloc+0x20/0x20
[   85.570918]  ? ret_from_fork+0x1c/0x28
[   85.575418] ---[ end trace 3e853d8ad82e44ae ]---
[   85.577919] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
[   85.580973] ------------[ cut here ]------------
[   85.581747] WARNING: CPU: 0 PID: 87 at kernel/workqueue.c:2190 
process_one_work+0x92/0x9e0
[   85.583058] Modules linked in: rcutorture torture mousedev evbug 
input_leds led_class psmouse pcspkr tiny_power_button button
[   85.584850] CPU: 0 PID: 87 Comm: kworker/1:2 Tainted: G        W 
     5.11.0-rc3-00186-g178826956ca7 #2
[   85.586456] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS 1.12.0-1 04/01/2014
[   85.587753] Workqueue:  0x0 (rcu_gp)
[   85.588347] EIP: process_one_work+0x92/0x9e0
[   85.589018] Code: 37 64 a1 58 54 4c 43 39 45 24 74 2c 31 c9 ba 01 00 
00 00 c7 04 24 01 00 00 00 b8 d8 1c f5 42 e8 14 85 13 00 ff 05 a4 30 04 
43 <0f> 0b ba 01 00 00 00 eb 22 8d 74 26 00 90 c7 04 24 01 00 00 00 31
[   85.595358] EAX: 42f51cd8 EBX: df4080f8 ECX: 00000000 EDX: 00000001
[   85.596319] ESI: 43d94840 EDI: df4080f4 EBP: de7f23c0 ESP: 45505f08
[   85.597291] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
[   85.598410] CR0: 80050033 CR2: 372c2004 CR3: 7fa9f000 CR4: 000406d0
[   85.599401] Call Trace:
[   85.599804]  ? process_one_work+0x20e/0x9e0
[   85.600474]  ? worker_thread+0x40d/0x6a0
[   85.601096]  ? kthread+0x1ba/0x1e0
[   85.601635]  ? create_worker+0x1e0/0x1e0
[   85.602246]  ? kzalloc+0x20/0x20
[   85.602907]  ? ret_from_fork+0x1c/0x28
[   85.603512] ---[ end trace 3e853d8ad82e44af ]---
[   85.699976] smpboot: CPU 1 is now offline
[   85.771891] x86: Booting SMP configuration:
[   85.772532] smpboot: Booting Node 0 Processor 1 APIC 0x1



-- 
Zhengjun Xing

--------------40953547EFC47796CDD463EB
Content-Type: application/octet-stream;
 name="dmesg.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg.xz"

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
--------------40953547EFC47796CDD463EB--
