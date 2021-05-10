Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F785377E8E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhEJItq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:49:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2427 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhEJIto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:49:44 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fdvlq5P1yzCr9l;
        Mon, 10 May 2021 16:45:59 +0800 (CST)
Received: from [10.67.110.238] (10.67.110.238) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 16:48:31 +0800
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
From:   xuyihang <xuyihang@huawei.com>
Message-ID: <963e38b0-a7d6-0b13-af89-81b03028d1ae@huawei.com>
Date:   Mon, 10 May 2021 16:48:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87zgx5l8ck.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.238]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,

在 2021/5/8 20:26, Thomas Gleixner 写道:
> Yihang,
>
> On Sat, May 08 2021 at 15:52, xuyihang wrote:
>> We are dealing with a scenario which may need to assign a default
>> irqaffinity for managed IRQ.
>>
>> Assume we have a full CPU usage RT thread running binded to a specific
>> CPU.
>>
>> In the mean while, interrupt handler registered by a device which is
>> ksoftirqd may never have a chance to run. (And we don't want to use
>> isolate CPU)
> A device cannot register and interrupt handler in ksoftirqd.
>
>> There could be a couple way to deal with this problem:
>>
>> 1. Adjust priority of ksoftirqd or RT thread, so the interrupt handler
>> could preempt
>>
>> RT thread. However, I am not sure whether it could have some side
>> effects or not.
>>
>> 2. Adjust interrupt CPU affinity or RT thread affinity. But managed IRQ
>> seems design to forbid user from manipulating interrupt affinity.
>>
>> It seems managed IRQ is coupled with user side application to me.
>>
>> Would you share your thoughts about this issue please?
> Can you please provide a more detailed description of your system?
>
>      - Number of CPUs
It's a 4 CPU x86 VM.
>      - Kernel version
This experiment run on linux-4.19
>      - Is NOHZ full enabled?
nohz=off
>      - Any isolation mechanisms enabled, and if so how are they
>        configured (e.g. on the kernel command line)?

Some core is isolated by command line (such as : isolcpus=3), and bind

with RT thread, and no other isolation configure.

>      - Number of queues in the multiqueue device

Only one queue.

[root@localhost ~]# cat /proc/interrupts | grep request
  27:       5499          0          0          0   PCI-MSI 
65539-edge      virtio1-request

This environment is a virtual machine and it's a virtio device, I guess it

should not make any difference in this case.

>      - Is the RT thread issuing I/O to the multiqueue device?

The RT thread doesn't issue IO.



We simplified the reproduce procedure:

1. Start a busy loopping program that have near 100% cpu usage, named print

./print 1 1 &


2. Make the program become realtime application

chrt -f -p 1 11514


3. Bind the RT process to the **managed irq** core

taskset -cpa 0 11514


4. Use dd to write to hard drive, and dd could not finish and return.

dd if=/dev/zero of=/test.img bs=1K count=1 oflag=direct,sync &


Since CPU is fully utilized by RT application, and hard drive driver choose

CPU0 to handle it's softirq, there is no chance for dd to run.

     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM TIME+ COMMAND
   11514 root      -2   0    2228    740    676 R 100.0   0.0 3:26.70 print


If we make some change on this experiment:

1.  Make this RT application use less CPU time instead of 100%, the problem

disappear.

2, If we change rq_affinity to 2, in order to avoid handle softirq on 
the same

core of RT thread, the problem also disappear. However, this approach

result in about 10%-30% random write proformance deduction comparing

to rq_affinity = 1, since it may has better cache utilization.

echo 2 > /sys/block/sda/queue/rq_affinity


Therefore, I want to exclude some CPU from managed irq on boot parameter,

which has simliar approach to 11ea68f553e2 ("genirq, sched/isolation: 
Isolate

from handling managed interrupts").


Thanks,

Yihang

