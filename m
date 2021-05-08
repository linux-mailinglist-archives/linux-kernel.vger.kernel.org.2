Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C73377079
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhEHHxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 03:53:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:17159 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhEHHxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 03:53:37 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FcfbJ3r6jzncJJ;
        Sat,  8 May 2021 15:49:16 +0800 (CST)
Received: from [10.67.110.238] (10.67.110.238) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 15:52:25 +0800
Subject: Re: Virtio-scsi multiqueue irq affinity
To:     Ming Lei <ming.lei@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
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
From:   xuyihang <xuyihang@huawei.com>
Message-ID: <0f6c8a5f-ad33-1199-f313-53fe9187a672@huawei.com>
Date:   Sat, 8 May 2021 15:52:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20190325095011.GA23225@ming.t460p>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.238]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2019/3/25 17:50, Ming Lei Ð´µÀ:
> On Mon, Mar 25, 2019 at 09:53:28AM +0100, Thomas Gleixner wrote:
>> Ming,
>>
>> On Mon, 25 Mar 2019, Ming Lei wrote:
>>> On Mon, Mar 25, 2019 at 01:02:13PM +0800, Peter Xu wrote:
>>>> One thing I can think of is the real-time scenario where "isolcpus="
>>>> is provided, then logically we should not allow any isolated CPUs to
>>>> be bound to any of the multi-queue IRQs.  Though Ming Lei and I had a
>>> So far, this behaviour is made by user-space.
>>>
>>> >From my understanding, IRQ subsystem doesn't handle "isolcpus=", even
>>> though the Kconfig help doesn't mention irq affinity affect:
>>>
>>>            Make sure that CPUs running critical tasks are not disturbed by
>>>            any source of "noise" such as unbound workqueues, timers, kthreads...
>>>            Unbound jobs get offloaded to housekeeping CPUs. This is driven by
>>>            the "isolcpus=" boot parameter.
>> isolcpus has no effect on the interupts. That's what 'irqaffinity=' is for.
> Indeed.
>
> irq_default_affinity is built from 'irqaffinity=', however, we don't
> consider irq_default_affinity for managed IRQ affinity.
>
> Looks Peter wants to exclude some CPUs from the spread on managed IRQ.


Hi Ming and Thomas,


We are dealing with a scenario which may need to assign a default 
irqaffinity

for managed IRQ.


Assume we have a full CPU usage RT thread running binded to a specific CPU.

In the mean while, interrupt handler registered by a device which is 
ksoftirqd

may never have a chance to run. (And we don't want to use isolate CPU)


There could be a couple way to deal with this problem:

1. Adjust priority of ksoftirqd or RT thread, so the interrupt handler 
could preempt

RT thread. However, I am not sure whether it could have some side 
effects or not.

2. Adjust interrupt CPU affinity or RT thread affinity. But managed IRQ 
seems

design to forbid user from manipulating interrupt affinity.


It seems managed IRQ is coupled with user side application to me.

Would you share your thoughts about this issue please?


Thanks,

Yihang

