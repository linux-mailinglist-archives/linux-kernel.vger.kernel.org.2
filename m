Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5A736FB19
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 15:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhD3NAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 09:00:54 -0400
Received: from foss.arm.com ([217.140.110.172]:47844 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231696AbhD3NAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 09:00:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 89488ED1;
        Fri, 30 Apr 2021 06:00:04 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA9C3F73B;
        Fri, 30 Apr 2021 06:00:01 -0700 (PDT)
Subject: Re: [PATCH v2] sched: Fix out-of-bound access in uclamp
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
References: <20210429152656.4118460-1-qperret@google.com>
 <CAKfTPtAfgVnMYkY_M+SDmNQDb_EsxSctQw-fkt2WJhczZakOjQ@mail.gmail.com>
 <YIu/EjZ8QsEl9sum@google.com>
 <CAKfTPtDOuB0UzZM5OtNzCUABftz_A40Z4W1z9OAORzFitfPDEQ@mail.gmail.com>
 <YIvQoG52Vk96DJQ/@google.com>
 <CAKfTPtB-0N7ogk0snCgj78zDrXRWgFUL=G7MoRDn+Bg8Hnk-PQ@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b6737247-ca02-e197-70c7-020952d95c1b@arm.com>
Date:   Fri, 30 Apr 2021 15:00:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <CAKfTPtB-0N7ogk0snCgj78zDrXRWgFUL=G7MoRDn+Bg8Hnk-PQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2021 14:03, Vincent Guittot wrote:
> On Fri, 30 Apr 2021 at 11:40, Quentin Perret <qperret@google.com> wrote:
>>
>> On Friday 30 Apr 2021 at 10:49:50 (+0200), Vincent Guittot wrote:
>>> 20 buckets is probably not the best example because of the rounding of
>>> the division. With 16 buckets, each bucket should be exactly 64 steps
>>> large except the last one which will have 65 steps because of the
>>> value 1024. With your change, buckets will be 65 large and the last
>>> one will be only 49 large
>>
>> OK, so what do you think of this?
> 
> Looks good to me

+1

>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index c5fb230dc604..dceeb5821797 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -920,14 +920,14 @@ static struct uclamp_se uclamp_default[UCLAMP_CNT];
>>   */
>>  DEFINE_STATIC_KEY_FALSE(sched_uclamp_used);
>>
>> -#define UCLAMP_BUCKET_DELTA (SCHED_CAPACITY_SCALE / UCLAMP_BUCKETS + 1)
>> +#define UCLAMP_BUCKET_DELTA DIV_ROUND_CLOSEST(SCHED_CAPACITY_SCALE, UCLAMP_BUCKETS)
>>
>>  #define for_each_clamp_id(clamp_id) \
>>         for ((clamp_id) = 0; (clamp_id) < UCLAMP_CNT; (clamp_id)++)
>>
>>  static inline unsigned int uclamp_bucket_id(unsigned int clamp_value)
>>  {
>> -       return clamp_value / UCLAMP_BUCKET_DELTA;
>> +       return min(clamp_value / UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS - 1);

IMHO, this asks for

min_t(unsigned int, clamp_value/UCLAMP_BUCKET_DELTA, UCLAMP_BUCKETS-1);

>>  }
>>
>>  static inline unsigned int uclamp_none(enum uclamp_id clamp_id)

Looks like this will fix a lot of possible configs:

nbr buckets 1-4, 7-8, 10-12, 14-17, *20*, 26, 29-32 ...

We would still introduce larger last buckets, right?

Examples:

nbr_buckets 	delta	last bucket size

20 		51	 +5 = 56

26		39	+10 = 49

29		35	 +9 = 44

...
