Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8E63713E1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 12:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhECK4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 06:56:40 -0400
Received: from foss.arm.com ([217.140.110.172]:39370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233259AbhECK4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 06:56:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74063ED1;
        Mon,  3 May 2021 03:55:45 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B9463F718;
        Mon,  3 May 2021 03:55:43 -0700 (PDT)
Subject: Re: [PATCH v3] sched: Fix out-of-bound access in uclamp
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>
References: <20210430151412.160913-1-qperret@google.com>
 <CAKfTPtCxVc+KSOJW0a3xK1mGc-qWH0v3wmAuqeB467t+wza78g@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <562004ff-9f60-bf37-df4c-547415ae2cd5@arm.com>
Date:   Mon, 3 May 2021 12:55:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCxVc+KSOJW0a3xK1mGc-qWH0v3wmAuqeB467t+wza78g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2021 17:27, Vincent Guittot wrote:
> On Fri, 30 Apr 2021 at 17:14, Quentin Perret <qperret@google.com> wrote:
>>
>> Util-clamp places tasks in different buckets based on their clamp values
>> for performance reasons. However, the size of buckets is currently
>> computed using a rounding division, which can lead to an off-by-one
>> error in some configurations.
>>
>> For instance, with 20 buckets, the bucket size will be 1024/20=51. A
>> task with a clamp of 1024 will be mapped to bucket id 1024/51=20. Sadly,
>> correct indexes are in range [0,19], hence leading to an out of bound
>> memory access.
>>
>> Clamp the bucket id to fix the issue.
>>
>> Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
>> Suggested-by: Qais Yousef <qais.yousef@arm.com>
>> Signed-off-by: Quentin Perret <qperret@google.com>
> 
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

I forgot that config UCLAMP_BUCKETS_COUNT is in range 5 ... 20.

So the error is bound to [-2 ... 5] (13/79, 20/51). I agree that we can
live with that.

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

>> ---
>> Changes in v3:
>>  - Keep rounding div to improve fairness (Vincent)
>> ---
>>  kernel/sched/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 98191218d891..c12ec648423e 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -928,7 +928,7 @@ DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
>>
>>  static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
>>  {
>> -       return clamp_value / UCLAMP_BUCKET_DELTA;
>> +       return min_t(unsigned int, clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);
>>  }
>>
>>  static inline unsigned int uclamp_none(enum uclamp_id clamp_id)
>> --
>> 2.31.1.527.g47e6f16901-goog
>>

