Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD896328A18
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 19:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239258AbhCASMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 13:12:07 -0500
Received: from foss.arm.com ([217.140.110.172]:33554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234461AbhCAQfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:35:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 200571063;
        Mon,  1 Mar 2021 08:34:13 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92B263F73C;
        Mon,  1 Mar 2021 08:34:11 -0800 (PST)
Subject: Re: [PATCH v2] sched/pelt: Fix task util_est update filtering
To:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     mingo@readhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com
References: <20210225165820.1377125-1-vincent.donnefort@arm.com>
 <YDi0Ip11fpOubQqz@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b1471e3a-e8c5-3ab4-5db4-0084612ade55@arm.com>
Date:   Mon, 1 Mar 2021 17:34:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YDi0Ip11fpOubQqz@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2021 09:41, Peter Zijlstra wrote:
> On Thu, Feb 25, 2021 at 04:58:20PM +0000, Vincent Donnefort wrote:
>> +#define UTIL_EST_MARGIN (SCHED_CAPACITY_SCALE / 100)
>> +
>>  /*
>> - * Check if a (signed) value is within a specified (unsigned) margin,
>> + * Check if a (signed) value is within the (unsigned) util_est margin,
>>   * based on the observation that:
>>   *
>>   *     abs(x) < y := (unsigned)(x + y - 1) < (2 * y - 1)
>>   *
>> - * NOTE: this only works when value + maring < INT_MAX.
>> + * NOTE: this only works when value + UTIL_EST_MARGIN < INT_MAX.
>>   */
>> -static inline bool within_margin(int value, int margin)
>> +static inline bool util_est_within_margin(int value)
>>  {
>> -	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
>> +	return ((unsigned int)(value + UTIL_EST_MARGIN - 1) <
>> +		(2 * UTIL_EST_MARGIN - 1));
>>  }
> 
>> -	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
>> +	if (util_est_within_margin(last_ewma_diff)) {
> 
> What was the purpose of this change? What was a generic helper is now
> super specific.

I guess because it was only ever used in util_est for last_ewma_diff.

It's now used for last_ewma_diff and last_enqueued_diff, still only for
util_est though and both times with the same margin
(SCHED_CAPACITY_SCALE / 100)).

Vincent D. should be back on Wed from hols.
