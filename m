Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2F377A76
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhEJDU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:20:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2733 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbhEJDUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:20:55 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FdmRf71BLzqTmQ;
        Mon, 10 May 2021 11:16:30 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 11:19:42 +0800
Subject: Re: Virtio-scsi multiqueue irq affinity
To:     Thomas Gleixner <tglx@linutronix.de>,
        xuyihang <xuyihang@huawei.com>, "Ming Lei" <ming.lei@redhat.com>
CC:     Peter Xu <peterx@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jason Wang <jasowang@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, <minlei@redhat.com>
References: <20190318062150.GC6654@xz-x1>
 <alpine.DEB.2.21.1903231805310.1798@nanos.tec.linutronix.de>
 <20190325050213.GH9149@xz-x1> <20190325070616.GA9642@ming.t460p>
 <alpine.DEB.2.21.1903250948490.1798@nanos.tec.linutronix.de>
 <20190325095011.GA23225@ming.t460p>
 <0f6c8a5f-ad33-1199-f313-53fe9187a672@huawei.com>
 <87zgx5l8ck.ffs@nanos.tec.linutronix.de>
From:   "liaochang (A)" <liaochang1@huawei.com>
Message-ID: <9903df53-8a84-fe89-7ae0-aac8e6d3f42f@huawei.com>
Date:   Mon, 10 May 2021 11:19:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <87zgx5l8ck.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

ÔÚ 2021/5/8 20:26, Thomas Gleixner Ð´µÀ:
> Yihang,
> 
> On Sat, May 08 2021 at 15:52, xuyihang wrote:
>>
>> We are dealing with a scenario which may need to assign a default 
>> irqaffinity for managed IRQ.
>>
>> Assume we have a full CPU usage RT thread running binded to a specific
>> CPU.
>>
>> In the mean while, interrupt handler registered by a device which is
>> ksoftirqd may never have a chance to run. (And we don't want to use
>> isolate CPU)
> 
> A device cannot register and interrupt handler in ksoftirqd.

I learn the scenario further after communicate with Yihang offline:
1.We have a machine with 36 CPUs,and assign several RT threads to last two CPUs(CPU-34, CPU-35).
2.I/O device driver create single managed irq, the affinity of which includes CPU-34 and CPU-35.
3.Another regular application launch I/O operation at different CPUs with the ones RT threads use,
  then CPU-34/35 will receive hardware interrupt and wakeup ksoftirqd to deal with real I/O stuff.
4.Cause the priority and schedule policy of RT thread overwhlem per-cpu ksoftirqd, it looks like
  ksoftirqd has no chance to run at CPU-34/35,which leads to I/O processing can't finish at time,
  and application get stuck.

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
> 
> Can you please provide a more detailed description of your system?
> 
>     - Number of CPUs
> 
>     - Kernel version
>     - Is NOHZ full enabled?
>     - Any isolation mechanisms enabled, and if so how are they
>       configured (e.g. on the kernel command line)?
> 
>     - Number of queues in the multiqueue device
>           
>     - Is the RT thread issuing I/O to the multiqueue device?
> 
> Thanks,
> 
>         tglx
> .
> 
BR,
Liao Chang
