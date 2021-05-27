Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 241953938C1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 00:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhE0Wjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 18:39:51 -0400
Received: from foss.arm.com ([217.140.110.172]:34840 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233203AbhE0Wjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 18:39:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 47AD114FF;
        Thu, 27 May 2021 15:38:14 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B10EF3F719;
        Thu, 27 May 2021 15:38:12 -0700 (PDT)
Subject: Re: [PATCH] sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Quentin Perret <qperret@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20210514103748.737809-1-dietmar.eggemann@arm.com>
 <20210519160633.GA230499@e120877-lin.cambridge.arm.com>
 <cb72557a-6039-df95-7e25-a7f37d3f9cef@arm.com>
 <CAB8ipk8POOzM2Dut0gcqsgNO0r2585GGv4SG+a1mOmMnrW=Vrw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <a8ab9455-a9be-2349-d23a-676aa89fbf2d@arm.com>
Date:   Fri, 28 May 2021 00:38:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAB8ipk8POOzM2Dut0gcqsgNO0r2585GGv4SG+a1mOmMnrW=Vrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2021 07:41, Xuewen Yan wrote:
> Hi
> 
> On Wed, May 26, 2021 at 10:59 PM Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>>
>> On 19/05/2021 18:06, Vincent Donnefort wrote:
>>> On Fri, May 14, 2021 at 12:37:48PM +0200, Dietmar Eggemann wrote:

[...]

>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index c7e7d50e2fdc..0a0bca694536 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -357,6 +357,16 @@ struct util_est {
>>  #define UTIL_EST_WEIGHT_SHIFT          2
>>  } __attribute__((__aligned__(sizeof(u64))));
>>
>> +/*
>> + * This flag is used to synchronize util_est with util_avg updates.
>> + * When a task is dequeued, its util_est should not be updated if its util_avg
>> + * has not been updated in the meantime.
>> + * This information is mapped into the MSB bit of util_est.enqueued at dequeue
>> + * time. Since max value of util_est.enqueued for a task is 1024 (PELT util_avg
>> + * for a task) it is safe to use MSB.
>> + */
>> +#define UTIL_AVG_UNCHANGED 0x80000000
>> +
> 
> IMHO, Maybe it would be better to put it in the util_est structure
> just like UTIL_EST_WEIGHT_SHIFT?

Yeah, can do.

I just realized that 'kernel/sched/pelt.h' does not include
<linux/sched.h> directly (or indirectly via "sched.h". But I can easily
move cfs_se_util_change() (which uses UTIL_AVG_UNCHANGED) from pelt.h to
pelt.c, its only consumer anyway.
