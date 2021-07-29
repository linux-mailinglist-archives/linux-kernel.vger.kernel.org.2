Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C9E3DAA34
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhG2RbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:31:24 -0400
Received: from foss.arm.com ([217.140.110.172]:53702 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229662AbhG2RbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:31:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26F6A1FB;
        Thu, 29 Jul 2021 10:31:19 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 739A63F73D;
        Thu, 29 Jul 2021 10:31:17 -0700 (PDT)
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
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <787ac8b6-3df6-0225-e835-c17a56a8d642@arm.com>
Date:   Thu, 29 Jul 2021 19:31:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YP6++lClPCQvTLcK@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2021 15:56, Quentin Perret wrote:
> On Thursday 22 Jul 2021 at 10:47:33 (+0200), Dietmar Eggemann wrote:

[...]

>>> @@ -7393,6 +7403,8 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
>>>  	rcu_read_unlock();
>>>  
>>>  	if (likely(p)) {
>>> +		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
>>> +			get_params(p, &attr);
>>
>> SCHED_FLAG_KEEP_PARAMS is handled here but SCHED_FLAG_KEEP_POLICY
>> outside (before) the `if (likely(p))`?
> 
> Because I need to dereference p while SCHED_FLAG_KEEP_POLICY doesn't :)

Ah, true. Looked weird though.
But then the SCHED_FLAG_KEEP_POLICY condition can be placed closer to
the SCHED_FLAG_KEEP_PARAMS condition. We don't have to set
SETPARAM_POLICY if p == NULL.

>>>  		retval = sched_setattr(p, &attr);
>>>  		put_task_struct(p);
>>>  	}

[...]
