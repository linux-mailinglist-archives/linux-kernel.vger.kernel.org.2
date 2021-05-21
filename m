Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14E338C6CD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbhEUMtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:49:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:3470 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhEUMtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:49:00 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FmmXH4PvGzCtRC;
        Fri, 21 May 2021 20:44:47 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 20:47:35 +0800
Received: from [10.47.85.3] (10.47.85.3) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 21 May
 2021 13:47:32 +0100
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
        "Ingo Molnar" <mingo@kernel.org>, Ming Lei <ming.lei@redhat.com>
References: <b8c4be8c-1d67-c16c-570e-d3c883c77ea2@huawei.com>
 <874kfxw9zv.ffs@nanos.tec.linutronix.de>
 <871rb1w3x8.ffs@nanos.tec.linutronix.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <42e399d7-6b50-1669-b740-cf63620c30e1@huawei.com>
Date:   Fri, 21 May 2021 13:46:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <871rb1w3x8.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.85.3]
X-ClientProxiedBy: lhreml711-chm.china.huawei.com (10.201.108.62) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+

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

JFYI, A performance-related fix was recently added in the block layer, 
and I can no longer reproduce this hang.

But I have no reason to say that it no longer exists.

Thanks,
John
