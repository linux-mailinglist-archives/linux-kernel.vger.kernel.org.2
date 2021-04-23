Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4B7E3691BA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 14:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbhDWMGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 08:06:19 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2912 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWMGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 08:06:18 -0400
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FRXm842BZz689Dm;
        Fri, 23 Apr 2021 19:55:20 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 23 Apr 2021 14:05:40 +0200
Received: from [10.47.95.78] (10.47.95.78) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 23 Apr
 2021 13:05:39 +0100
Subject: Re: Question on threaded handlers for managed interrupts
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Marc Zyngier" <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Ingo Molnar" <mingo@kernel.org>
References: <b8c4be8c-1d67-c16c-570e-d3c883c77ea2@huawei.com>
 <874kfxw9zv.ffs@nanos.tec.linutronix.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c297d618-1378-f51b-45db-605a3fc15336@huawei.com>
Date:   Fri, 23 Apr 2021 13:02:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <874kfxw9zv.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.95.78]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/2021 11:50, Thomas Gleixner wrote:

Hi Thomas,

>> The multi-queue storage controller (see [1] for memory refresh, but
>> note that I can also trigger on PCI device host controller as well) is
>> using managed interrupts and threaded handlers. Since the threaded
>> handler uses SCHED_FIFO, aren't we always vulnerable to this situation
>> with the managed interrupt and threaded handler combo? Would the
>> advice be to just use irq polling here?
> This is a really good question. Most interrupt handlers are not running
> exceedingly long or come in with high frequency, but of course this
> problem exists.
> 
> The network people have solved it with NAPI which disables the interrupt
> in the device and polls it from softirq context (which might be then
> delegated to ksoftirqd) until it's drained.
> 
> I'm not familiar with the block/multiqueue layer to be able to tell
> whether such a concept exists there as well.
> 

Other MQ SCSI drivers have had similar problems. They were handling all 
completion interrupts in hard irq context, the handlers would not exit 
for high throughput scenarios, and they were then getting lockups.

Their solution was to switch over to using irq_poll for when per-queue 
completions got above a certain rate.

> OTOH, the way how you splitted the handling into hard/thread context
> provides already the base for this.
>

Right, so I could switch to a similar scheme, above, but just think that 
what I have in using a threaded handler would already suffice.

> The missing piece is infrastructure at the irq/scheduler core level to
> handle this transparently.
> 
> I have some horrible ideas how to solve that, but I'm sure the scheduler
> wizards can come up with a reasonable and generic solution.

That would be great.

Thanks,
John
