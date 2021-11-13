Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9DD644F116
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 04:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235649AbhKMDqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 22:46:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32578 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232113AbhKMDqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 22:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636775003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SmlGc1AnnP8jkr12IdGrXkJsXLjR708dzHG5hUo8F6M=;
        b=SqAppHQ1ma6oz/9UoDidQJjEZ3pTq9wlWqg6iFo23XnSDGi82TQDmRih9Xpc1Vq6gtJVYO
        ayZ4fVT11UlKWJBDCNoE8PFMj/YaZ8IQxqQkD5JT5MbTNcnVZB+UHctRO2L2TtJj54aOmN
        6TiZDzTNX9h/yg2oE0afh59D2wIbf/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-TiuMfSklPJW9PyJYPB5lsQ-1; Fri, 12 Nov 2021 22:43:19 -0500
X-MC-Unique: TiuMfSklPJW9PyJYPB5lsQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2315802C8F;
        Sat, 13 Nov 2021 03:43:17 +0000 (UTC)
Received: from [10.22.16.14] (unknown [10.22.16.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66EE818A50;
        Sat, 13 Nov 2021 03:43:16 +0000 (UTC)
Message-ID: <889b16c6-b6cc-63d7-a6de-8cec42c7d78c@redhat.com>
Date:   Fri, 12 Nov 2021 22:43:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 1/2] clocksource: Avoid accidental unstable marking of
 clocksources
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Colin Ian King <colin.king@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20211110221732.272986-1-longman@redhat.com>
 <20211110221732.272986-2-longman@redhat.com>
 <20211111045703.GA15896@shbuild999.sh.intel.com>
 <20211111144311.GK641268@paulmck-ThinkPad-P17-Gen-1>
 <20211112054417.GA29845@shbuild999.sh.intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211112054417.GA29845@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/21 00:44, Feng Tang wrote:
> On Thu, Nov 11, 2021 at 06:43:11AM -0800, Paul E. McKenney wrote:
>> On Thu, Nov 11, 2021 at 12:57:03PM +0800, Feng Tang wrote:
>>> On Wed, Nov 10, 2021 at 05:17:31PM -0500, Waiman Long wrote:
>>>> Since commit db3a34e17433 ("clocksource: Retry clock read if long delays
>>>> detected") and commit 2e27e793e280 ("clocksource: Reduce clocksource-skew
>>>> threshold"), it is found that tsc clocksource fallback to hpet can
>>>> sometimes happen on both Intel and AMD systems especially when they are
>>>> running stressful benchmarking workloads. Of the 23 systems tested with
>>>> a v5.14 kernel, 10 of them have switched to hpet clock source during
>>>> the test run.
>>>>
>>>> The result of falling back to hpet is a drastic reduction of performance
>>>> when running benchmarks. For example, the fio performance tests can
>>>> drop up to 70% whereas the iperf3 performance can drop up to 80%.
>>>>
>>>> 4 hpet fallbacks happened during bootup. They were:
>>>>
>>>>    [    8.749399] clocksource: timekeeping watchdog on CPU13: hpet read-back delay of 263750ns, attempt 4, marking unstable
>>>>    [   12.044610] clocksource: timekeeping watchdog on CPU19: hpet read-back delay of 186166ns, attempt 4, marking unstable
>>>>    [   17.336941] clocksource: timekeeping watchdog on CPU28: hpet read-back delay of 182291ns, attempt 4, marking unstable
>>>>    [   17.518565] clocksource: timekeeping watchdog on CPU34: hpet read-back delay of 252196ns, attempt 4, marking unstable
>>>>
>>>> Other fallbacks happen when the systems were running stressful
>>>> benchmarks. For example:
>>>>
>>>>    [ 2685.867873] clocksource: timekeeping watchdog on CPU117: hpet read-back delay of 57269ns, attempt 4, marking unstable
>>>>    [46215.471228] clocksource: timekeeping watchdog on CPU8: hpet read-back delay of 61460ns, attempt 4, marking unstable
>>>>
>>>> Commit 2e27e793e280 ("clocksource: Reduce clocksource-skew threshold"),
>>>> changed the skew margin from 100us to 50us. I think this is too small
>>>> and can easily be exceeded when running some stressful workloads on
>>>> a thermally stressed system.  So it is switched back to 100us. On
>>>> the other hand, it doesn't look like we need to increase the minimum
>>>> uncertainty margin. So it is kept the same at 100us too.
>>>>
>>>> Even a maximum skew margin of 100us may be too small in for some systems
>>>> when booting up especially if those systems are under thermal stress. To
>>>> eliminate the case that the large skew is due to the system being too
>>>> busy slowing down the reading of both the watchdog and the clocksource,
>>>> a final check is done by reading watchdog time again and comparing the
>>>> consecutive watchdog timing read delay against WATCHDOG_MAX_SKEW/2. If
>>>> that delay exceeds the limit, we assume that the system is just too
>>>> busy. A warning will be printed to the console and the watchdog check
>>>> is then skipped for this round. For example:
>>>>
>>>>    [    8.789316] clocksource: timekeeping watchdog on CPU13: hpet consecutive read-back delay of 174541ns, system too busy
>>>   
>>>
>>> I think it may be better to add more details about the root cause, other
>>> than that it looks good to me, as we tested similar patch on our test
>>> platforms.
>>>
>>> Reviewed-by: Feng Tang <feng.tang@intel.com>
>> Thank you both!
>>
>> I agree on the bit about root cause.  Would it make sense to compare the
>> difference between HPET reads 1 and 2 (containing the read of the TSC)
>> and the difference between HPET reads 2 and 3?  If the 2-1 difference was
>> no more than (say) 8/7ths of the 3-2 difference, or the 2-1 difference
>> was no more than (say) 20 microseconds more than the 3-2 difference,
>> this could be considered a good-as-it-gets read, ending the retry loop.
>> Then if the 3-1 difference was greater than the default (100 microseconds
>> in current -rcu), that difference could be substituted for that particular
>> clocksource watchdog check.  With a console message noting the unusually
>> high overhead (but not a splat).
>>
>> So if it took 75 microseconds for each HPET read and 1 microsecond for
>> the TSC read, then 226 microseconds would be substituted for the default
>> of 100 microseconds for that cycle's skew cutoff.  Unless the previous
>> skew cutoff was larger, in which case the previous cutoff should be
>> used instead.  Either way, the current cutoff is recorded for comparison
>> for the next clocksource watchdog check.
>>
>> If the 3-1 difference was greater than 62.5 milliseconds, a warning should
>> probably be emitted anyway.
>   
> I can test the patch with our cases that could reproduce the problem.
>
>> Or did you have something else in mind?
> I'm not sure the detail in  Waiman's cases, and in our cases (stress-ng)
> the delay between watchdog's (HPET here) read were not linear, that
> from debug data, sometimes the 3-2 difference could be bigger or much
> bigger than the 2-1 difference.
>
> The reason could be the gap between 2 reads depends hugely on the system
> pressure at that time that 3 HPET read happens. On our test box (a
> 2-Socket Cascade Lake AP server), the 2-1 and 3-2 difference are stably
> about 2.5 us,  while under the stress it could be bumped to from 6 us
> to 2800 us.
>
> So I think checking the 3-2 difference plus increasing the max retries
> to 10 may be a simple way, if the watchdog read is found to be
> abnormally long, we skip this round of check.

On one of the test system, I had measured that normal delay 
(hpet->tsc->hpet) was normally a bit over 2us. It was a bit more than 
4us at bootup time. However, the same system under stress could have a 
delay of over 200us at bootup time. When I measured the consecutive hpet 
delay, it was about 180us. So hpet read did dominate the total 
clocksource read delay.

I would not suggest increasing the max retries as it may still fail in 
most cases because the system stress will likely not be going away 
within a short time. So we are likely just wasting cpu times. I believe 
we should just skip it if it is the watchdog read that is causing most 
of the delay.

Cheers,
Longman

