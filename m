Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECF744FD75
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 04:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhKOD2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 22:28:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51579 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236559AbhKOD2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 22:28:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636946705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=deBTIAsAlkL1c5loCCR5YUvVFcYQZfZsSo44wOme8So=;
        b=SHWaGxY9P1Ywd47GsDfdr5tV/zh4fylWbg2/QFdicvzeMM45L+7OZ8Re7lBUoVJFRqcBxO
        t7GhzkvGsILbzQYkv7VTAgphnTLUkTG2zf4/Sl+ollUfWlEzxdEwaO4Kie264icGftDBmb
        K2PoDhS41sYWr2HHRm0051sSGC+88CM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-bSxmr3U5NLamSAA32cyX6Q-1; Sun, 14 Nov 2021 22:24:59 -0500
X-MC-Unique: bSxmr3U5NLamSAA32cyX6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 10E063E74A;
        Mon, 15 Nov 2021 03:24:58 +0000 (UTC)
Received: from [10.22.16.82] (unknown [10.22.16.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B51F65DEFB;
        Mon, 15 Nov 2021 03:24:56 +0000 (UTC)
Message-ID: <e2d300c4-cc0d-47c4-3e7d-8a1cc3546719@redhat.com>
Date:   Sun, 14 Nov 2021 22:24:56 -0500
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
 <889b16c6-b6cc-63d7-a6de-8cec42c7d78c@redhat.com>
 <20211114155407.GB641268@paulmck-ThinkPad-P17-Gen-1>
 <20211115020851.GB29845@shbuild999.sh.intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211115020851.GB29845@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/14/21 21:08, Feng Tang wrote:
> Or did you have something else in mind?
>>>> I'm not sure the detail in  Waiman's cases, and in our cases (stress-ng)
>>>> the delay between watchdog's (HPET here) read were not linear, that
>>>> from debug data, sometimes the 3-2 difference could be bigger or much
>>>> bigger than the 2-1 difference.
>>>>
>>>> The reason could be the gap between 2 reads depends hugely on the system
>>>> pressure at that time that 3 HPET read happens. On our test box (a
>>>> 2-Socket Cascade Lake AP server), the 2-1 and 3-2 difference are stably
>>>> about 2.5 us,  while under the stress it could be bumped to from 6 us
>>>> to 2800 us.
>>>>
>>>> So I think checking the 3-2 difference plus increasing the max retries
>>>> to 10 may be a simple way, if the watchdog read is found to be
>>>> abnormally long, we skip this round of check.
>>> On one of the test system, I had measured that normal delay
>>> (hpet->tsc->hpet) was normally a bit over 2us. It was a bit more than 4us at
>>> bootup time. However, the same system under stress could have a delay of
>>> over 200us at bootup time. When I measured the consecutive hpet delay, it
>>> was about 180us. So hpet read did dominate the total clocksource read delay.
>> Thank you both for the data!
>>
>>> I would not suggest increasing the max retries as it may still fail in most
>>> cases because the system stress will likely not be going away within a short
>>> time. So we are likely just wasting cpu times. I believe we should just skip
>>> it if it is the watchdog read that is causing most of the delay.
>> If anything, adding that extra read would cause me to -reduce- the number
>> of retries to avoid increasing the per-watchdog overhead.
>   
> I understand Waiman's concern here, and in our test patch, the 2
> consecutive watchdog read delay check is done inside this retrying
> loop accompanying the 'cs' read, and once an abnormal delay is found,
> the watchdog check is skipped without waiting for the max-retries to
> complete.
>
> Our test data shows the consecutive delay is not always big even when
> the system is much stressed, that's why I suggest to increase the
> retries.

If we need a large number of retries to avoid triggering the unstable 
TSC message, we should consider increase the threshod instead. Right?

That is why my patch 2 makes the max skew value a configurable option so 
that we can tune it if necessary.

Cheers,
Longman

