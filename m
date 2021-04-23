Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE7836958B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242995AbhDWPE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:04:26 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2913 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243318AbhDWPEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:04:15 -0400
Received: from fraeml705-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FRcq22VPyz70gkc;
        Fri, 23 Apr 2021 22:58:06 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml705-chm.china.huawei.com (10.206.15.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 23 Apr 2021 17:03:36 +0200
Received: from [10.47.95.78] (10.47.95.78) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 23 Apr
 2021 16:03:35 +0100
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
 <871rb1w3x8.ffs@nanos.tec.linutronix.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e260dfb0-95c5-778e-2652-f563784cb984@huawei.com>
Date:   Fri, 23 Apr 2021 16:00:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <871rb1w3x8.ffs@nanos.tec.linutronix.de>
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

Hi Thomas,

On 23/04/2021 14:01, Thomas Gleixner wrote:
> On Fri, Apr 23 2021 at 12:50, Thomas Gleixner wrote:
>> On Thu, Apr 22 2021 at 17:10, John Garry wrote:
>> OTOH, the way how you splitted the handling into hard/thread context
>> provides already the base for this.
>>
>> The missing piece is infrastructure at the irq/scheduler core level to
>> handle this transparently.
>>
>> I have some horrible ideas how to solve that, but I'm sure the scheduler
>> wizards can come up with a reasonable and generic solution.
> So one thing I forgot to ask is:
> 
> Is the thread simply stuck in the while() loop forever or is
> this just an endless hardirq/thread/hardirq/thread stream?

The thread will process all available completions and then return. I 
added some debug there, and at most we handle maybe max 150-300 
completions per thread run.

So I figure that we have the endless hardirq/thread/hardirq/thread stream.

Thanks,
John

