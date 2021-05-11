Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32F937A6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 14:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhEKMj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 08:39:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2699 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhEKMj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 08:39:58 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ffcpz6rlcz1BLNt;
        Tue, 11 May 2021 20:36:11 +0800 (CST)
Received: from [10.67.110.238] (10.67.110.238) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.498.0; Tue, 11 May 2021 20:38:43 +0800
Subject: Re: Virtio-scsi multiqueue irq affinity
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ming Lei <ming.lei@redhat.com>
CC:     Peter Xu <peterx@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, <minlei@redhat.com>,
        <liaochang1@huawei.com>
References: <20190318062150.GC6654@xz-x1>
 <alpine.DEB.2.21.1903231805310.1798@nanos.tec.linutronix.de>
 <20190325050213.GH9149@xz-x1> <20190325070616.GA9642@ming.t460p>
 <alpine.DEB.2.21.1903250948490.1798@nanos.tec.linutronix.de>
 <20190325095011.GA23225@ming.t460p>
 <0f6c8a5f-ad33-1199-f313-53fe9187a672@huawei.com>
 <87zgx5l8ck.ffs@nanos.tec.linutronix.de>
 <963e38b0-a7d6-0b13-af89-81b03028d1ae@huawei.com>
 <87wns6gy67.ffs@nanos.tec.linutronix.de>
From:   xuyihang <xuyihang@huawei.com>
Message-ID: <6ab54d90-dcfb-c913-0b09-f5c6c9141081@huawei.com>
Date:   Tue, 11 May 2021 20:38:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87wns6gy67.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.238]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,


The previous experiment require a device driver to enable managed irq,

which I could not easily install on a most recent branch of OS.

Actually what I was asking is whether we could change the managed irq

behaviour a little bit, rather than reporting a bug.

So, to better illustrate this problem I do another test to simulate this 
scenario.


This time I wrote a kernel module, and in the module_init function, I use

request_irq to register a irq. In the irq_handler it put a work in the 
workqueue.

And the work_handler would print "work handler called".


1. Register a irq for a fake new deivce and queue a work_handler

when irq arrives.

/ # insmod request_irq.ko

2. Bind the irq to CPU3

/ # echo 8 > /proc/irq/7/smp_affinity

3. Start a full CPU usage RT process and bind to CPU3

./test.sh &

/ # taskset -p 8 100
pid 100's current affinity mask: f
pid 100's new affinity mask: 8

/ # chrt -f -p 1 100
pid 100's current scheduling policy: SCHED_OTHER
pid 100's current scheduling priority: 0
pid 100's new scheduling policy: SCHED_FIFO
pid 100's new scheduling priority: 1
/ # echo -1 >/proc/sys/kernel/sched_rt_runtime_us
/ # echo -1 >/proc/sys/kernel/sched_rt_period_us

/ # top

Mem: 27376K used, 73224K free, 0K shrd, 0K buff, 8368K cached
CPU0:  0.0% usr  0.0% sys  0.0% nic  100% idle  0.0% io  0.0% irq 0.0% sirq
CPU1:  0.0% usr  0.0% sys  0.0% nic  100% idle  0.0% io  0.0% irq 0.0% sirq
CPU2:  0.0% usr  0.0% sys  0.0% nic  100% idle  0.0% io  0.0% irq 0.0% sirq
CPU3:  100% usr  0.0% sys  0.0% nic  0.0% idle  0.0% io  0.0% irq 0.0% sirq
Load average: 4.00 4.00 4.00 5/62 126
   PID  PPID USER     STAT   VSZ %VSZ CPU %CPU COMMAND
   100     1 0        R     3252  3.2   3 26.3 {exe} ash ./test.sh
   126     1 0        R     3252  3.2   1  0.8 top

...

/ # echo -n trigger > /sys/kernel/debug/irq/irqs/7

 From the demsg we can tell the queued work_handler is not called.


I could understand the behaviour is as expected, but in pratice, let's say

people work on the RT team could be a totally different team for device

driver. It feels like it is nice to have a feature to exclude some CPU from

managed irq driver.


在 2021/5/11 3:56, Thomas Gleixner 写道:
>
> Again. Please provide reports against the most recent mainline version
> and not against some randomly picked kernel variant.
This time I try it on current master branch.
Linux (none) 5.12.0-next-20210506+ #3 SMP Tue May 11 14:53:58 HKT 2021 
x86_64 GNU/Linux

>> If we make some change on this experiment:
>>
>> 1.  Make this RT application use less CPU time instead of 100%, the problem
>> disappear.
>>
>> 2, If we change rq_affinity to 2, in order to avoid handle softirq on
>> the same core of RT thread, the problem also disappear. However, this approach
>> result in about 10%-30% random write proformance deduction comparing
>> to rq_affinity = 1, since it may has better cache utilization.
>> echo 2 > /sys/block/sda/queue/rq_affinity
>>
>> Therefore, I want to exclude some CPU from managed irq on boot
>> parameter,
> Why has this realtime thread to run on CPU0 and cannot move to some
> other CPU?

Yes, this realtime thread could move to other CPU, but I think maybe it's

not so good to dodge the managed irq CPU. It also seems OS does not

give so much hint to indicate RT thread should not run on this CPU. I

think the kernel should be able to schedule the irq workqueue handler

a little bit, since RT thread is more like a user application and driver 
works

within kernel space.

>> which has simliar approach to 11ea68f553e2 ("genirq, sched/isolation:
>> Isolate from handling managed interrupts").
> Why can't you use the existing isolation mechanisms?

Isolation of CPU forbids other process from utilizing this CPU. Sometimes

the RT thread may not use up all CPU time, so other process could schedule

to this CPU and run for a little while.


Thanks for your time,

Yihang

