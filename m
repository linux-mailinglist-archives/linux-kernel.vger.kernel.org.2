Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037803DAA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhG2ReX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:34:23 -0400
Received: from foss.arm.com ([217.140.110.172]:53828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229947AbhG2ReV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:34:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 961571FB;
        Thu, 29 Jul 2021 10:34:17 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2C003F73D;
        Thu, 29 Jul 2021 10:34:15 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] sched: Skip priority checks with
 SCHED_FLAG_KEEP_PARAMS
To:     Quentin Perret <qperret@google.com>
Cc:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        qais.yousef@arm.com, rickyiu@google.com, wvw@google.com,
        patrick.bellasi@matbug.net, xuewen.yan94@gmail.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
References: <20210719161656.3833943-1-qperret@google.com>
 <20210719161656.3833943-3-qperret@google.com>
 <ad30be79-8fb2-023d-9936-01f7173164e4@arm.com> <YP6++lClPCQvTLcK@google.com>
 <YP/dEMeULqozIqZd@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <cb6aaa1d-0bf4-eebc-5ffc-c1e7971564a8@arm.com>
Date:   Thu, 29 Jul 2021 19:34:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP/dEMeULqozIqZd@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2021 12:16, Quentin Perret wrote:
> On Monday 26 Jul 2021 at 14:56:10 (+0100), Quentin Perret wrote:
>> On Thursday 22 Jul 2021 at 10:47:33 (+0200), Dietmar Eggemann wrote:
>>> (*) This changes the behaviour when setting uclamp values on a DL task.
>>>
>>> Before uclamp values could be set but now, because of
>>>
>>>   void __getparam_dl(struct task_struct *p, struct sched_attr *attr)
>>>     ..
>>>     attr->sched_flags = dl_se->flags
>>>
>>> SCHED_FLAG_UTIL_CLAMP gets overwritten and  __sched_setscheduler() bails in:
>>>
>>>     if (unlikely(policy == p->policy)) {
>>>       ...
>>>       retval = 0;
>>>       goto unlock;
>>>     }
>>>   change:
>>>
>>> I.e. the:
>>>
>>>       if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
>>>         goto change;
>>>
>>> can't trigger anymore.
>>
>> Bah, as you said it doesn't seem to be a big deal, but clearly that was
>> unintentional. Let me try and fix this.
> 
> While looking at this I found existing bugs in the area. Fixes are here:
> 
> https://lore.kernel.org/lkml/20210727101103.2729607-1-qperret@google.com/
> 
> And with the above series applied this patch should behave correctly
> now.

It does. Like depicted in

https://lkml.kernel.org/r/e6d103f1-f8ee-cad9-c7c0-c9ea5d0f099a@arm.com

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
