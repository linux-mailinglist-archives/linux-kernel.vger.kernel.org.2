Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454B73AB775
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 17:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhFQPaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 11:30:17 -0400
Received: from foss.arm.com ([217.140.110.172]:55450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233247AbhFQPaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 11:30:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F5AC13D5;
        Thu, 17 Jun 2021 08:28:06 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C017C3F70D;
        Thu, 17 Jun 2021 08:28:04 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] sched: Fix UCLAMP_FLAG_IDLE setting
To:     Quentin Perret <qperret@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org, qais.yousef@arm.com,
        rickyiu@google.com, wvw@google.com, patrick.bellasi@matbug.net,
        xuewen.yan94@gmail.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com
References: <20210610151306.1789549-1-qperret@google.com>
 <20210610151306.1789549-2-qperret@google.com>
 <YMJiaO0IN2pN/EYY@hirez.programming.kicks-ass.net>
 <YMMP9uqcCeDlt95F@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <23e44dd5-5229-ac16-5801-3b74f013b7f3@arm.com>
Date:   Thu, 17 Jun 2021 17:27:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YMMP9uqcCeDlt95F@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2021 09:25, Quentin Perret wrote:
> On Thursday 10 Jun 2021 at 21:05:12 (+0200), Peter Zijlstra wrote:
>> On Thu, Jun 10, 2021 at 03:13:04PM +0000, Quentin Perret wrote:
>>> The UCLAMP_FLAG_IDLE flag is set on a runqueue when dequeueing the last
>>> active task to maintain the last uclamp.max and prevent blocked util
>>> from suddenly becoming visible.
>>>
>>> However, there is an asymmetry in how the flag is set and cleared which
>>> can lead to having the flag set whilst there are active tasks on the rq.
>>> Specifically, the flag is cleared in the uclamp_rq_inc() path, which is
>>> called at enqueue time, but set in uclamp_rq_dec_id() which is called
>>> both when dequeueing a task _and_ in the update_uclamp_active() path. As
>>> a result, when both uclamp_rq_{dec,ind}_id() are called from
>>> update_uclamp_active(), the flag ends up being set but not cleared,
>>> hence leaving the runqueue in a broken state.
>>>
>>> Fix this by setting the flag in the uclamp_rq_inc_id() path to ensure
>>> things remain symmetrical.
>>
>> The code you moved is neither in uclamp_rq_inc_id(), although
>> uclamp_idle_reset() is called from there
> 
> Yep, that is what I was trying to say.
> 
>> nor does it _set_ the flag.
> 
> Ahem. That I don't have a good excuse for ...

(A) dequeue -> set

(1) dequeue_task() -> uclamp_rq_dec() ->

(2) cpu_util_update_eff() -> ... -> uclamp_update_active() ->

uclamp_rq_dec_id()

    uclamp_rq_max_value()

        /* No tasks -- default clamp values */
        uclamp_idle_value() {

            if (clamp_id == UCLAMP_MAX)
                rq->uclamp_flags |= UCLAMP_FLAG_IDLE;  <-- set
        }

---

(B) enqueue -> clear

(1) enqueue_task() ->

uclamp_rq_inc() {

(2) cpu_util_update_eff() -> ... -> uclamp_update_active() ->

    uclamp_rq_inc_id() {

        uclamp_idle_reset() {
    						     <-- new clear
       }                                                     ^
    }                                                        |
                                                             |
    if (rq->uclamp_flags & UCLAMP_FLAG_IDLE)                 |
        rq->uclamp_flags &= ~UCLAMP_FLAG_IDLE;       <-- old clear
}

---

uclamp_update_active()

    if (p->uclamp[clamp_id].active) {
        uclamp_rq_dec_id()            <-- (A2)
	uclamp_rq_inc_id()            <-- (B2)
    }

Is this existing asymmetry in setting the flag but not clearing it in
uclamp_update_active() the only issue this patch fixes?
