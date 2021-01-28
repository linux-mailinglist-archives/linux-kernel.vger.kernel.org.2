Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D328307056
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhA1HzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:55:18 -0500
Received: from mga14.intel.com ([192.55.52.115]:14302 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231603AbhA1Hyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:54:37 -0500
IronPort-SDR: 4Cd/1w3Lz18WMBAAg+6IbnI6SCk7o0KKLODQFIwnVl+RM+dauReAc30yx/xLe9lMTyiz7cdQFD
 vLk/BHa0t6Gw==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="179412244"
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="xz'?scan'208";a="179412244"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 23:52:45 -0800
IronPort-SDR: 3UDZgtkZLCBI9VUl0a2Zfyc6+RkSUZMGScIVRAq2RpUn5Y/j8lsH4ivrEuSCAogCSNS2X7Cb2M
 4NixgaY6pg+g==
X-IronPort-AV: E=Sophos;i="5.79,381,1602572400"; 
   d="xz'?scan'208";a="388653681"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.6.97]) ([10.238.6.97])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 23:52:42 -0800
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
 <20210127092128.2299-1-hdanton@sina.com>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <a69a62ca-b7b1-bb4c-5c6f-8e186109b920@linux.intel.com>
Date:   Thu, 28 Jan 2021 15:52:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210127092128.2299-1-hdanton@sina.com>
Content-Type: multipart/mixed;
 boundary="------------F7844E47A2BC46B7F8E42325"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F7844E47A2BC46B7F8E42325
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/27/2021 5:21 PM, Hillf Danton wrote:
> On Wed, 27 Jan 2021 16:04:25 +0800 Xing Zhengjun wrote:
>> On 1/26/2021 3:39 PM, Hillf Danton wrote:
>>> On 26 Jan 2021 10:45:21 +0800 Xing Zhengjun wrote:
>>>> On 1/25/2021 5:29 PM, Hillf Danton wrote:
>>>>> On 25 Jan 2021 16:31:32 +0800 Xing Zhengjun wrote:
>>>>>> On 1/22/2021 3:59 PM, Hillf Danton wrote:
>>>>>>> On Fri, 22 Jan 2021 09:48:32 +0800 Xing Zhengjun wrote:
>>>>>>>> On 1/21/2021 12:00 PM, Hillf Danton wrote:
>>>>>>>>> On Wed, 20 Jan 2021 21:46:33 +0800 Oliver Sang wrote:
>>>>>>>>>> On Fri, Jan 15, 2021 at 03:24:32PM +0800, Hillf Danton wrote:
>>>>>>>>>>> Thu, 14 Jan 2021 15:45:11 +0800
>>>>>>>>>>>>
>>>>>>>>>>>> FYI, we noticed the following commit (built with gcc-9):
>>>>>>>>>>>>
>>>>>>>>>>>> commit: d5bff968ea9cc005e632d9369c26cbd8148c93d5 ("workqueue: break affinity initiatively")
>>>>>>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2021.01.11b
>>>>>>>>>>>>
>>>>>>>>>>> [...]
>>>>>>>>>>>>
>>>>>>>>>>>> [   73.794288] WARNING: CPU: 0 PID: 22 at kernel/workqueue.c:2192 process_one_work
>>>>>>>>>>>
>>>>>>>>>>> Thanks for your report.
>>>>>>>>>>>
>>>>>>>>>>> We can also break CPU affinity by checking POOL_DISASSOCIATED at attach
>>>>>>>>>>> time without extra cost paid; that way we have the same behavior as at
>>>>>>>>>>> the unbind time.
>>>>>>>>>>>
>>>>>>>>>>> What is more the change that makes kworker pcpu is cut because they are
>>>>>>>>>>> going to not help either hotplug or the mechanism of stop machine.
>>>>>>>>>>
>>>>>>>>>> hi, by applying below patch, the issue still happened.
>>>>>>>>>
>>>>>>>>> Thanks for your report.
>>>>>>>>>>
>>>>>>>>>> [ 4.574467] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
>>>>>>>>>> [ 4.575651] pci 0000:00:01.0: Activating ISA DMA hang workarounds
>>>>>>>>>> [ 4.576900] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
>>>>>>>>>> [ 4.578648] PCI: CLS 0 bytes, default 64
>>>>>>>>>> [ 4.579685] Unpacking initramfs...
>>>>>>>>>> [ 8.878031] -----------[ cut here ]-----------
>>>>>>>>>> [ 8.879083] WARNING: CPU: 0 PID: 22 at kernel/workqueue.c:2187 process_one_work+0x92/0x9e0
>>>>>>>>>> [ 8.880688] Modules linked in:
>>>>>>>>>> [ 8.881274] CPU: 0 PID: 22 Comm: kworker/1:0 Not tainted 5.11.0-rc3-gc213503139bb #2
>>>>>>>>>
>>>>>>>>> The kworker bond to CPU1 runs on CPU0 and triggers the warning, which
>>>>>>>>> shows that scheduler breaks CPU affinity, after 06249738a41a
>>>>>>>>> ("workqueue: Manually break affinity on hotplug"), though quite likely
>>>>>>>>> by kworker/1:0 for the initial workers.
>>>>>>>>>
>>>>>>>>>> [ 8.882518] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>>>>>>>>> [ 8.887539] Workqueue: 0x0 (events)
>>>>>>>>>> [ 8.887838] EIP: process_one_work+0x92/0x9e0
>>>>>>>>>> [ 8.887838] Code: 37 64 a1 58 54 4c 43 39 45 24 74 2c 31 c9 ba 01 00 00 00 c7 04 24 01 00 00 00 b8 08 1d f5 42 e8 74 85 13 00 ff 05 b8 30 04 43 <0f> 0b ba 01 00 00 00 eb 22 8d 74 26 00 90 c7 04 24 01 00 00 00 31
>>>>>>>>>> [ 8.887838] EAX: 42f51d08 EBX: 00000000 ECX: 00000000 EDX: 00000001
>>>>>>>>>> [ 8.887838] ESI: 43c04720 EDI: 42e45620 EBP: de7f23c0 ESP: 43d7bf08
>>>>>>>>>> [ 8.887838] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
>>>>>>>>>> [ 8.887838] CR0: 80050033 CR2: 00000000 CR3: 034e3000 CR4: 000406d0
>>>>>>>>>> [ 8.887838] Call Trace:
>>>>>>>>>> [ 8.887838] ? worker_thread+0x98/0x6a0
>>>>>>>>>> [ 8.887838] ? worker_thread+0x2dd/0x6a0
>>>>>>>>>> [ 8.887838] ? kthread+0x1ba/0x1e0
>>>>>>>>>> [ 8.887838] ? create_worker+0x1e0/0x1e0
>>>>>>>>>> [ 8.887838] ? kzalloc+0x20/0x20
>>>>>>>>>> [ 8.887838] ? ret_from_fork+0x1c/0x28
>>>>>>>>>> [ 8.887838] _warn_unseeded_randomness: 63 callbacks suppressed
>>>>>>>>>> [ 8.887838] random: get_random_bytes called from init_oops_id+0x2b/0x60 with crng_init=0
>>>>>>>>>> [ 8.887838] --[ end trace ac461b4d54c37cfa ]--
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Instead of creating the initial workers only on the active CPUS, rebind
>>>>>>>>> them (labeled pcpu) and jump to the right CPU at bootup time.
>>>>>>>>>
>>>>>>>>> --- a/kernel/workqueue.c
>>>>>>>>> +++ b/kernel/workqueue.c
>>>>>>>>> @@ -2385,6 +2385,16 @@ woke_up:
>>>>>>>>>       		return 0;
>>>>>>>>>       	}
>>>>>>>>>       
>>>>>>>>> +	if (!(pool->flags & POOL_DISASSOCIATED) && smp_processor_id() !=
>>>>>>>>> +								pool->cpu) {
>>>>>>>>> +		/* scheduler breaks CPU affinity for us, rebind it */
>>>>>>>>> +		raw_spin_unlock_irq(&pool->lock);
>>>>>>>>> +		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>>>>>>>>> +		/* and jump to the right seat */
>>>>>>>>> +		schedule_timeout_interruptible(1);
>>>>>>>>> +		goto woke_up;
>>>>>>>>> +	}
>>>>>>>>> +
>>>>>>>>>       	worker_leave_idle(worker);
>>>>>>>>>       recheck:
>>>>>>>>>       	/* no more worker necessary? */
>>>>>>>>> --
>>>>>>>>>
>>>>>>>> I test the patch, the warning still appears in the kernel log.
>>>>>>>
>>>>>>> Thanks for your report.
>>>>>>>>
>>>>>>>> [  230.356503] smpboot: CPU 1 is now offline
>>>>>>>> [  230.544652] x86: Booting SMP configuration:
>>>>>>>> [  230.545077] smpboot: Booting Node 0 Processor 1 APIC 0x1
>>>>>>>> [  230.545640] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
>>>>>>>> [  230.545675] masked ExtINT on CPU#1
>>>>>>>> [  230.593829] ------------[ cut here ]------------
>>>>>>>> [  230.594257] WARNING: CPU: 0 PID: 257 at kernel/workqueue.c:2192 process_one_work+0x92/0x9e0
>>>>>>>> [  230.594990] Modules linked in: rcutorture torture mousedev input_leds
>>>>>>>> led_class pcspkr psmouse evbug tiny_power_button button
>>>>>>>> [  230.595961] CPU: 0 PID: 257 Comm: kworker/1:3 Not tainted 5.11.0-rc3-gdcba55d9080f #2
>>>>>>>
>>>>>>> Like what was reported, kworker bond to CPU1 runs on CPU0 and triggers
>>>>>>> warning, due to scheduler breaking CPU affinity for us. What is new, the
>>>>>>> affinity was broken at offline time instead of bootup.
>>>>>>>
>>>>>>>> [  230.596621] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>>>>>>> [  230.597322] Workqueue:  0x0 (rcu_gp)
>>>>>>>> [  230.597636] EIP: process_one_work+0x92/0x9e0
>>>>>>>> [  230.598005] Code: 37 64 a1 58 54 4c 43 39 45 24 74 2c 31 c9 ba 01 00
>>>>>>>> 00 00 c7 04 24 01 00 00 00 b8 08 1d f5 42 e8 f4 85 13 00 ff 05 cc 30 04
>>>>>>>> 43 <0f> 0b ba 01 00 00 00 eb 22 8d 74 26 00 90 c7 04 24 01 00 00 00 31
>>>>>>>> [  230.599569] EAX: 42f51d08 EBX: 00000000 ECX: 00000000 EDX: 00000001
>>>>>>>> [  230.600100] ESI: 43d94240 EDI: df4040f4 EBP: de7f23c0 ESP: bf5f1f08
>>>>>>>> [  230.600629] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
>>>>>>>> [  230.601203] CR0: 80050033 CR2: 01bdecbc CR3: 04e2c000 CR4: 000406d0
>>>>>>>> [  230.601735] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
>>>>>>>> [  230.602265] DR6: fffe0ff0 DR7: 00000400
>>>>>>>> [  230.602594] Call Trace:
>>>>>>>> [  230.602813]  ? process_one_work+0x20e/0x9e0
>>>>>>>> [  230.603181]  ? worker_thread+0x32d/0x700
>>>>>>>> [  230.603522]  ? kthread+0x1ba/0x1e0
>>>>>>>> [  230.603818]  ? create_worker+0x1e0/0x1e0
>>>>>>>> [  230.604157]  ? kzalloc+0x20/0x20
>>>>>>>> [  230.604524]  ? ret_from_fork+0x1c/0x28
>>>>>>>> [  230.604850] ---[ end trace 06b1e66b5e17fa85 ]---
>>>>>>>> [  230.605504] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
>>>>>>>> [  230.766960] smpboot: CPU 1 is now offline
>>>>>>>> [  230.814803] x86: Booting SMP configuration:
>>>>>>>> [  230.815306] smpboot: Booting Node 0 Processor 1 APIC 0x1
>>>>>>>> [  230.815964] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
>>>>>>>
>>>>>>>
>>>>>>> Unlike the above diff that is at most papering over the problem
>>>>>>> sitting somewhere in the scheduler, add change to creating worker
>>>>>>> by skipping set_cpus_allowed_ptr() because we will wake it up after
>>>>>>> attaching it to worker pool.
>>>>>>>
>>>>>>> If we can ignore rescuer for now, then the allowed ptr is only
>>>>>>> updated at on/offline time; lets see the difference at boot time.
>>>>>>>
>>>>>>>
>>>>>>> --- a/kernel/workqueue.c
>>>>>>> +++ b/kernel/workqueue.c
>>>>>>> @@ -1844,16 +1844,10 @@ static struct worker *alloc_worker(int n
>>>>>>>       * cpu-[un]hotplugs.
>>>>>>>       */
>>>>>>>      static void worker_attach_to_pool(struct worker *worker,
>>>>>>> -				   struct worker_pool *pool)
>>>>>>> +				   struct worker_pool *pool,
>>>>>>> +				   int update_cpus_allowed)
>>>>>>>      {
>>>>>>>      	mutex_lock(&wq_pool_attach_mutex);
>>>>>>> -
>>>>>>> -	/*
>>>>>>> -	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
>>>>>>> -	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
>>>>>>> -	 */
>>>>>>> -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>>>>>>> -
>>>>>>>      	/*
>>>>>>>      	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
>>>>>>>      	 * stable across this function.  See the comments above the flag
>>>>>>> @@ -1867,6 +1861,9 @@ static void worker_attach_to_pool(struct
>>>>>>>      	list_add_tail(&worker->node, &pool->workers);
>>>>>>>      	worker->pool = pool;
>>>>>>>      
>>>>>>> +	if (update_cpus_allowed)
>>>>>>> +		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>>>>>>> +
>>>>>>>      	mutex_unlock(&wq_pool_attach_mutex);
>>>>>>>      }
>>>>>>>      
>>>>>>> @@ -1942,8 +1939,11 @@ static struct worker *create_worker(stru
>>>>>>>      	set_user_nice(worker->task, pool->attrs->nice);
>>>>>>>      	kthread_bind_mask(worker->task, pool->attrs->cpumask);
>>>>>>>      
>>>>>>> -	/* successful, attach the worker to the pool */
>>>>>>> -	worker_attach_to_pool(worker, pool);
>>>>>>> +	/*
>>>>>>> +	 * attach the worker to the pool without asking scheduler to
>>>>>>> +	 * update CPUs allowed
>>>>>>> +	 */
>>>>>>> +	worker_attach_to_pool(worker, pool, 0);
>>>>>>>      
>>>>>>>      	/* start the newly created worker */
>>>>>>>      	raw_spin_lock_irq(&pool->lock);
>>>>>>> @@ -2508,7 +2508,7 @@ repeat:
>>>>>>>      
>>>>>>>      		raw_spin_unlock_irq(&wq_mayday_lock);
>>>>>>>      
>>>>>>> -		worker_attach_to_pool(rescuer, pool);
>>>>>>> +		worker_attach_to_pool(rescuer, pool, 1);
>>>>>>>      
>>>>>>>      		raw_spin_lock_irq(&pool->lock);
>>>>>>>      
>>>>>>> --
>>>>>>>
>>>>>> I test the patch, the warning still appears in the kernel log.
>>>>>
>>>>> Thanks.
>>>>>>
>>>>>> [   55.754187] smpboot: Booting Node 0 Processor 1 APIC 0x1
>>>>>> [   55.785594] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
>>>>>> [   55.785646] masked ExtINT on CPU#1
>>>>>> [   55.920602] ------------[ cut here ]------------
>>>>>> [   55.921355] WARNING: CPU: 0 PID: 160 at kernel/workqueue.c:2192 process_one_work+0x92/0x9e0
>>>>>> [   55.922583] Modules linked in: rcutorture torture mousedev evbug
>>>>>> input_leds led_class tiny_power_button psmouse pcspkr button
>>>>>> [   55.924294] CPU: 0 PID: 160 Comm: kworker/1:2 Not tainted 5.11.0-rc3-00186-g77bf4e461cfa #2
>>>>>
>>>>> Same issue as before.
>>>>>
>>>>>> [   55.925552] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>>>>> [   55.926763] Workqueue:  0x0 (rcu_gp)
>>>>>> [   55.927298] EIP: process_one_work+0x92/0x9e0
>>>>>> [   55.927950] Code: 37 64 a1 58 54 4c 43 39 45 24 74 2c 31 c9 ba 01 00
>>>>>> 00 00 c7 04 24 01 00 00 00 b8 08 1d f5 42 e8 94 85 13 00 ff 05 b8 30 04
>>>>>> 43 <0f> 0b ba 01 00 00 00 eb 22 8d 74 26 00 90 c7 04 24 01 00 00 00 31
>>>>>> [   55.930726] EAX: 42f51d08 EBX: 00000000 ECX: 00000000 EDX: 00000001
>>>>>> [   55.931642] ESI: 43d90540 EDI: df48c0f4 EBP: de7f23c0 ESP: bfb47f08
>>>>>> [   55.932590] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
>>>>>> [   55.933609] CR0: 80050033 CR2: 024e994c CR3: 7fd80000 CR4: 000406d0
>>>>>> [   55.934555] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
>>>>>> [   55.935457] DR6: fffe0ff0 DR7: 00000400
>>>>>> [   55.936041] Call Trace:
>>>>>> [   55.936534]  ? process_one_work+0x20e/0x9e0
>>>>>> [   55.937305]  ? worker_thread+0x2dd/0x6a0
>>>>>> [   55.938018]  ? kthread+0x1ba/0x1e0
>>>>>> [   55.938598]  ? create_worker+0x1e0/0x1e0
>>>>>> [   55.939315]  ? kzalloc+0x20/0x20
>>>>>> [   55.940000]  ? ret_from_fork+0x1c/0x28
>>>>>> [   55.940627] ---[ end trace d155e9e6402de179 ]---
>>>>>> [   55.941641] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
>>>>>> [   56.155271] smpboot: CPU 1 is now offline
>>>>>> [   56.193613] x86: Booting SMP configuration:
>>>>>> [   56.194400] smpboot: Booting Node 0 Processor 1 APIC 0x1
>>>>>
>>>>> The changes in the diff below are
>>>>>
>>>>> 1/ at rescue time, change CPU affinity only if POOL_DISASSOCIATED
>>>>> is not set, and print warning the same way as offline time.
>>>>>
>>>>> 2/ at offine time, dont update allowed CPUs after setting
>>>>> POOL_DISASSOCIATED because we no longer have interest in affinity.
>>>>>
>>>>> 3/ at online time, mark pcpu before binding affinity.
>>>>>
>>>>> Though one change a diff is appreciated, by the WARNs, we can tell
>>>>> which is what if any warning goes into dmesg.
>>>>>
>>>>> --- a/kernel/workqueue.c
>>>>> +++ b/kernel/workqueue.c
>>>>> @@ -1844,25 +1844,23 @@ static struct worker *alloc_worker(int n
>>>>>      * cpu-[un]hotplugs.
>>>>>      */
>>>>>     static void worker_attach_to_pool(struct worker *worker,
>>>>> -				   struct worker_pool *pool)
>>>>> +				   struct worker_pool *pool, int set)
>>>>>     {
>>>>>     	mutex_lock(&wq_pool_attach_mutex);
>>>>>     
>>>>>     	/*
>>>>> -	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
>>>>> -	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
>>>>> -	 */
>>>>> -	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
>>>>> -
>>>>> -	/*
>>>>>     	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
>>>>>     	 * stable across this function.  See the comments above the flag
>>>>>     	 * definition for details.
>>>>>     	 */
>>>>>     	if (pool->flags & POOL_DISASSOCIATED)
>>>>>     		worker->flags |= WORKER_UNBOUND;
>>>>> -	else
>>>>> +	else {
>>>>>     		kthread_set_per_cpu(worker->task, true);
>>>>> +		if (set)
>>>>> +			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
>>>>> +						pool->attrs->cpumask) < 0);
>>>>> +	}
>>>>>     
>>>>>     	list_add_tail(&worker->node, &pool->workers);
>>>>>     	worker->pool = pool;
>>>>> @@ -1943,7 +1941,7 @@ static struct worker *create_worker(stru
>>>>>     	kthread_bind_mask(worker->task, pool->attrs->cpumask);
>>>>>     
>>>>>     	/* successful, attach the worker to the pool */
>>>>> -	worker_attach_to_pool(worker, pool);
>>>>> +	worker_attach_to_pool(worker, pool, 0);
>>>>>     
>>>>>     	/* start the newly created worker */
>>>>>     	raw_spin_lock_irq(&pool->lock);
>>>>> @@ -2508,7 +2506,7 @@ repeat:
>>>>>     
>>>>>     		raw_spin_unlock_irq(&wq_mayday_lock);
>>>>>     
>>>>> -		worker_attach_to_pool(rescuer, pool);
>>>>> +		worker_attach_to_pool(rescuer, pool, 1);
>>>>>     
>>>>>     		raw_spin_lock_irq(&pool->lock);
>>>>>     
>>>>> @@ -4923,7 +4921,6 @@ static void unbind_workers(int cpu)
>>>>>     
>>>>>     		for_each_pool_worker(worker, pool) {
>>>>>     			kthread_set_per_cpu(worker->task, false);
>>>>> -			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
>>>>>     		}
>>>>>     
>>>>>     		mutex_unlock(&wq_pool_attach_mutex);
>>>>> @@ -4977,9 +4974,9 @@ static void rebind_workers(struct worker
>>>>>     	 * from CPU_ONLINE, the following shouldn't fail.
>>>>>     	 */
>>>>>     	for_each_pool_worker(worker, pool) {
>>>>> +		kthread_set_per_cpu(worker->task, true);
>>>>>     		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
>>>>>     						  pool->attrs->cpumask) < 0);
>>>>> -		kthread_set_per_cpu(worker->task, true);
>>>>>     	}
>>>>>     
>>>>>     	raw_spin_lock_irq(&pool->lock);
>>>>> --
>>>>>
>>>> I test the patch, the warning still appears in the kernel log, but the
>>>
>>> Thanks.
>>>
>>>> warning is different from before.
>>>>
>>>> [    0.054803] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
>>>> [    0.054803] masked ExtINT on CPU#1
>>>> [    0.054803] smpboot: CPU 1 Converting physical 0 to logical die 1
>>>> [    1.890338] ------------[ cut here ]------------
>>>> [    1.890338] WARNING: CPU: 1 PID: 18 at kernel/kthread.c:508 kthread_set_per_cpu+0x156/0x180
>>>> [    1.890338] Modules linked in:
>>>> [    1.890338] CPU: 1 PID: 18 Comm: cpuhp/1 Not tainted 5.11.0-rc3-00186-ged03082352b2 #2
>>>
>>> This warning is better than the one in process_one_work() which is too
>>> late, though, it has something to say.
>>>
>>>> [    1.890338] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>>>> [    1.890338] EIP: kthread_set_per_cpu+0x156/0x180
>>>> [    1.890338] Code: 00 00 00 00 ff 05 68 4e 04 43 83 c4 08 5b 5e 5f c3
>>>> 8d 76 00 ff 05 34 50 04 43 0f 0b e9 f9 fe ff ff 8d 76 00 ff 05 2c 4e 04
>>>> 43 <0f> 0b eb 9d 8d b6 00 00 00 00 ff 05 40 4e 04 43 0f 0b e9 45 ff ff
>>>> [    1.890338] EAX: 42f52ce0 EBX: 00000001 ECX: 00000000 EDX: 00000001
>>>> [    1.890338] ESI: 43d76300 EDI: 43c0de00 EBP: de7f2564 ESP: 43d6beb8
>>>> [    1.900350] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
>>>> [    1.901303] CR0: 80050033 CR2: 00000000 CR3: 034e3000 CR4: 000406d0
>>>> [    1.902280] Call Trace:
>>>> [    1.902682]  ? workqueue_online_cpu+0x12b/0x640
>>>> [    1.903415]  ? workqueue_prepare_cpu+0xa0/0xa0
>>>
>>> By the prepare function we know it is a warning at boot time.
>>>
>>>> [    1.904155]  ? cpuhp_invoke_callback+0x1ed/0x1340
>>>> [    1.904941]  ? cpuhp_thread_fun+0x28f/0x460
>>>> [    1.905630]  ? cpuhp_thread_fun+0x49/0x460
>>>> [    1.906298]  ? smpboot_thread_fn+0x446/0x620
>>>> [    1.910275]  ? kthread+0x1ba/0x1e0
>>>> [    1.910857]  ? __smpboot_create_thread+0x260/0x260
>>>> [    1.911659]  ? kzalloc+0x20/0x20
>>>> [    1.912368]  ? ret_from_fork+0x1c/0x28
>>>> [    1.913016] ---[ end trace 6f6c005278241eba ]---
>>>> [    1.913971] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
>>>> [    1.920012] smp: Brought up 1 node, 2 CPUs
>>>> [    1.920299] smpboot: Max logical packages: 2
>>>> [    1.921019] smpboot: Total of 2 processors activated (10774.03 BogoMIPS)
>>>
>>> After staring at it again, the change added in rebind_workers() is
>>> incorrect for a CPU getting back online after bootup, because the
>>> CPU affinity has been broken at offline time.
>>>
>>> But the warning in the latest report occurs at boot time, after going
>>> through steps like,
>>>
>>> 	kthread_create_on_node();
>>>
>>> 	kthread_bind_mask(worker->task, pool->attrs->cpumask);
>>>
>>> 	/* successful, attach the worker to the pool */
>>> 	worker_attach_to_pool(worker, pool, 0);
>>>
>>> 	/* start the newly created worker */
>>> 	wake_up_process(worker->task);
>>>
>>>
>>> without triggering the warning at kernel/kthread.c:507.
>>>
>>> Before finding an answer (wake_up_new_task()) to the question,
>>> who changed the allowed ptr?  revert the change at online time,
>>> and as a compensation, clear POOL_DISASSOCIATED as early as we can.
>>>
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
>>> @@ -5954,6 +5951,7 @@ void __init workqueue_init_early(void)
>>>    		i = 0;
>>>    		for_each_cpu_worker_pool(pool, cpu) {
>>>    			BUG_ON(init_worker_pool(pool));
>>> +			pool->flags &= ~POOL_DISASSOCIATED;
>>>    			pool->cpu = cpu;
>>>    			cpumask_copy(pool->attrs->cpumask, cpumask_of(cpu));
>>>    			pool->attrs->nice = std_nice[i++];
>>> --
>>>
>> I test the patch, the warning still appears in the kernel log.
> 
> Thanks.
>>
>> [    0.043584] masked ExtINT on CPU#1
>> [    0.043584] smpboot: CPU 1 Converting physical 0 to logical die 1
>> [    1.681867] ------------[ cut here ]------------
>> [    1.681867] WARNING: CPU: 1 PID: 18 at kernel/workqueue.c:5015 workqueue_online_cpu+0x336/0x640
> 
> This is a new one at boot time.
> 
>> [    1.681867] Modules linked in:
>> [    1.681867] CPU: 1 PID: 18 Comm: cpuhp/1 Not tainted 5.11.0-rc3-00186-g178826956ca7 #2
>> [    1.681867] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
>> [    1.681867] EIP: workqueue_online_cpu+0x336/0x640
>> [    1.681867] Code: 01 00 00 00 eb 89 8d b6 00 00 00 00 8b 5c 24 0c 89
>> d8 e8 3d 39 19 01 e9 1c fd ff ff 8d b4 26 00 00 00 00 90 ff 05 dc 20 04
>> 43 <0f> 0b e9 07 ff ff ff 8d 76 00 ff 05 2c 21 04 43 0f 0b e9 12 fe ff
>> [    1.681867] EAX: 42f51168 EBX: 0000000c ECX: 00000000 EDX: 00000001
>> [    1.681867] ESI: 00000000 EDI: 43c04720 EBP: de7f2564 ESP: 43d6bed0
>> [    1.681867] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
>> [    1.681867] CR0: 80050033 CR2: 00000000 CR3: 034e3000 CR4: 000406d0
>> [    1.681867] Call Trace:
>> [    1.681867]  ? workqueue_prepare_cpu+0xa0/0xa0
>> [    1.681867]  ? cpuhp_invoke_callback+0x1ed/0x1340
>> [    1.681867]  ? cpuhp_thread_fun+0x28f/0x460
>> [    1.681867]  ? cpuhp_thread_fun+0x49/0x460
>> [    1.681867]  ? smpboot_thread_fn+0x446/0x620
>> [    1.681867]  ? kthread+0x1ba/0x1e0
>> [    1.681867]  ? __smpboot_create_thread+0x260/0x260
>> [    1.681867]  ? kzalloc+0x20/0x20
>> [    1.681867]  ? ret_from_fork+0x1c/0x28
>> [    1.681867] ---[ end trace 3e853d8ad82e44ac ]---
>> [    1.691939] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
>> [    1.705909] smp: Brought up 1 node, 2 CPUs
>> [    1.706605] smpboot: Max logical packages: 2
>>
>> [   85.402803] smpboot: Booting Node 0 Processor 1 APIC 0x1
>> [   85.442465] kvm-clock: cpu 1, msr 34f6021, secondary cpu clock
>> [   85.442602] masked ExtINT on CPU#1
>> [   85.541391] ------------[ cut here ]------------
>> [   85.542250] WARNING: CPU: 1 PID: 18 at kernel/kthread.c:508 kthread_set_per_cpu+0x156/0x180
> 
> This is a known one.
> 
>> [   85.543664] Modules linked in: rcutorture torture mousedev evbug
>> input_leds led_class psmouse pcspkr tiny_power_button button
>> [   85.545530] CPU: 1 PID: 18 Comm: cpuhp/1 Tainted: G        W
>> 5.11.0-rc3-00186-g178826956ca7 #2
>> [   85.547006] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.12.0-1 04/01/2014
>> [   85.548454] EIP: kthread_set_per_cpu+0x156/0x180
>> [   85.549231] Code: 00 00 00 00 ff 05 68 4e 04 43 83 c4 08 5b 5e 5f c3
>> 8d 76 00 ff 05 34 50 04 43 0f 0b e9 f9 fe ff ff 8d 76 00 ff 05 2c 4e 04
>> 43 <0f> 0b eb 9d 8d b6 00 00 00 00 ff 05 40 4e 04 43 0f 0b e9 45 ff ff
>> [   85.552236] EAX: 42f52ce0 EBX: 00000001 ECX: 00000000 EDX: 00000001
>> [   85.556663] ESI: bfb70000 EDI: 45e61000 EBP: de7f2564 ESP: 43d6beb8
>> [   85.559168] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010202
>> [   85.561991] CR0: 80050033 CR2: 00000000 CR3: 034e3000 CR4: 000406d0
>> [   85.563040] Call Trace:
>> [   85.563463]  ? workqueue_online_cpu+0x17f/0x640
>> [   85.564222]  ? rapl_cpu_online+0xb7/0x1a0
>> [   85.564904]  ? workqueue_prepare_cpu+0xa0/0xa0
>> [   85.565643]  ? cpuhp_invoke_callback+0x1ed/0x1340
>> [   85.566424]  ? cpuhp_thread_fun+0x28f/0x460
>> [   85.567140]  ? cpuhp_thread_fun+0x49/0x460
>> [   85.567844]  ? smpboot_thread_fn+0x446/0x620
>> [   85.568569]  ? kthread+0x1ba/0x1e0
>> [   85.569162]  ? __smpboot_create_thread+0x260/0x260
>> [   85.569961]  ? kzalloc+0x20/0x20
>> [   85.570918]  ? ret_from_fork+0x1c/0x28
>> [   85.575418] ---[ end trace 3e853d8ad82e44ae ]---
>> [   85.577919] kvm-guest: stealtime: cpu 1, msr 9e7e6ec0
>> [   85.580973] ------------[ cut here ]------------
>> [   85.581747] WARNING: CPU: 0 PID: 87 at kernel/workqueue.c:2190 process_one_work+0x92/0x9e0
>> [   85.583058] Modules linked in: rcutorture torture mousedev evbug
>> input_leds led_class psmouse pcspkr tiny_power_button button
>> [   85.584850] CPU: 0 PID: 87 Comm: kworker/1:2 Tainted: G        W 5.11.0-rc3-00186-g178826956ca7 #2
> 
> This is a big regression.
> 
>> [   85.586456] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
>> BIOS 1.12.0-1 04/01/2014
>> [   85.587753] Workqueue:  0x0 (rcu_gp)
>> [   85.588347] EIP: process_one_work+0x92/0x9e0
>> [   85.589018] Code: 37 64 a1 58 54 4c 43 39 45 24 74 2c 31 c9 ba 01 00
>> 00 00 c7 04 24 01 00 00 00 b8 d8 1c f5 42 e8 14 85 13 00 ff 05 a4 30 04
>> 43 <0f> 0b ba 01 00 00 00 eb 22 8d 74 26 00 90 c7 04 24 01 00 00 00 31
>> [   85.595358] EAX: 42f51cd8 EBX: df4080f8 ECX: 00000000 EDX: 00000001
>> [   85.596319] ESI: 43d94840 EDI: df4080f4 EBP: de7f23c0 ESP: 45505f08
>> [   85.597291] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00010002
>> [   85.598410] CR0: 80050033 CR2: 372c2004 CR3: 7fa9f000 CR4: 000406d0
>> [   85.599401] Call Trace:
>> [   85.599804]  ? process_one_work+0x20e/0x9e0
>> [   85.600474]  ? worker_thread+0x40d/0x6a0
>> [   85.601096]  ? kthread+0x1ba/0x1e0
>> [   85.601635]  ? create_worker+0x1e0/0x1e0
>> [   85.602246]  ? kzalloc+0x20/0x20
>> [   85.602907]  ? ret_from_fork+0x1c/0x28
>> [   85.603512] ---[ end trace 3e853d8ad82e44af ]---
>> [   85.699976] smpboot: CPU 1 is now offline
>> [   85.771891] x86: Booting SMP configuration:
>> [   85.772532] smpboot: Booting Node 0 Processor 1 APIC 0x1
> 
> 1/ to fix the regression, roll back to the version without warning in
> process_one_work().
> 
> 2/ to see if that version is utterly anything of a blind cat heading
> on a blind rat, quiesce the 508 warning for kworkers now.
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
> @@ -4977,9 +4974,9 @@ static void rebind_workers(struct worker
>   	 * from CPU_ONLINE, the following shouldn't fail.
>   	 */
>   	for_each_pool_worker(worker, pool) {
> +		kthread_set_per_cpu(worker->task, true);
>   		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
>   						  pool->attrs->cpumask) < 0);
> -		kthread_set_per_cpu(worker->task, true);
>   	}
>   
>   	raw_spin_lock_irq(&pool->lock);
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -505,7 +505,7 @@ void kthread_set_per_cpu(struct task_str
>   
>   	if (set) {
>   		WARN_ON_ONCE(!(k->flags & PF_NO_SETAFFINITY));
> -		WARN_ON_ONCE(k->nr_cpus_allowed != 1);
> +		WARN_ON_ONCE(k->nr_cpus_allowed != 1 && !(k->flags & PF_WQ_WORKER));
>   		set_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
>   	} else {
>   		clear_bit(KTHREAD_IS_PER_CPU, &kthread->flags);
> --
> 

I test the patch 4 times, no warning appears in the kernel log.

-- 
Zhengjun Xing

--------------F7844E47A2BC46B7F8E42325
Content-Type: application/octet-stream;
 name="dmesg.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg.xz"

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
AAAABFla
--------------F7844E47A2BC46B7F8E42325--
