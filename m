Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6AE3D2026
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhGVIG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 04:06:59 -0400
Received: from foss.arm.com ([217.140.110.172]:47700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhGVIG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:06:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5605D6E;
        Thu, 22 Jul 2021 01:47:31 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3ABA03F73D;
        Thu, 22 Jul 2021 01:47:30 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] sched: Fix UCLAMP_FLAG_IDLE setting
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        qais.yousef@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20210719161656.3833943-1-qperret@google.com>
 <20210719161656.3833943-2-qperret@google.com>
 <7ef85d3f-fd2b-a192-07ef-3431b33d06ce@arm.com> <YPgck3j01cI3VzqD@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f21896e2-feae-5758-383b-6e5cd9cf8e46@arm.com>
Date:   Thu, 22 Jul 2021 10:47:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YPgck3j01cI3VzqD@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2021 15:09, Quentin Perret wrote:
> Hi Dietmar,
> 
> On Wednesday 21 Jul 2021 at 12:07:04 (+0200), Dietmar Eggemann wrote:
>> On 19/07/2021 18:16, Quentin Perret wrote:
>>> The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
>>> active task to maintain the last uclamp.max and prevent blocked util
>>
>> s/active/runnable ?
> 
> 'active' should still be correct here no? We enter uclamp_rq_max_value()
> -> uclamp_idle_value() when the last _active_ uclamp_se is decremented,
> and when all the buckets are empty, so I think that works?

Ah, it this uclamp ative `p->uclamp[clamp_id].active` which is set with
`bucket->tasks` in uclamp_rq_[inc/dec]_id.

Maybe add: last (uclamp) active task, i.e. (bucket.tasks == 0 for all
bucket_id's) ... ?

>>> from suddenly becoming visible.
>>>
>>
>> [...]
>>
>> IMHO, the main argument in v3 to do the clearing outside
>> uclamp_rq_inc_id() was a possible order change in `for_each_clamp_id()`.
>> So setting/clearing `rq->uclamp_flags` (UCLAMP_FLAG_IDLE) on UCLAMP_MAX
>> (currently the highest Uclamp constraint (UCLAMP_CNT-1)) could be
>> incorrect when UCLAMP_MIN and UCLAMP_MAX change place because the
>> same `rq->uclamp_flags` value is needed for both Uclamp constraint
>> values.
>>
>> What about decoupling rq->uclamp_flags` handling from UCLAMP_MAX and
>> doing this for 'UCLAMP_CNT - 1', i.e. always on the highest Uclamp
>> constraint?
>>
>> #define for_each_clamp_id(clamp_id) \
>>     for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
>>
>> In this case the code change can be as easy as in your original v3.
>>
>> Setting UCLAMP_FLAG_IDLE in uclamp_idle_value():
>>
>>   uclamp_rq_dec_id() -> uclamp_rq_max_value() -> *uclamp_idle_value()*
>>
>> Resetting UCLAMP_FLAG_IDLE in uclamp_idle_reset():
>>
>>   uclamp_rq_inc_id()                          -> *uclamp_idle_reset()*  
>>
>> This would be more symmetrical then uclamp_idle_value() and
>> uclamp_rq_inc()/uclamp_rq_reinc_id().
> 
> Right, thanks for the suggestion but to be fair I feel like this is a
> matter of personal preference at this point. I personally like the way
> it is in this patch -- I find it easier to reason about, but maybe
> that's because I wrote it ...
> 
> Do you feel strongly about it? If not I'd prefer to not re-spin this
> another time if possible. Let me know what you think.

No, not at all ;-) Just like it better since it would mean less code
changes and only one place to reset UCLAMP_FLAG_IDLE.

You can add a:

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

to your version in case you want to keep it.
