Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9238644CDC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 00:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhKJX2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 18:28:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47360 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233965AbhKJX2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 18:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636586721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AzAB+Kqpxu5YXTt/hX4iRHES0vaHqUHxVYdvPknvBGU=;
        b=Y2sgk7OgzihVQ4Esr/C6glATmwvkreJoKC8IxlmFVk7F0UHmRo2u6PvPfaX2z1EDb+udZd
        F4OXSV1lBXdQ4SvjdqXAYPGi+X04WikGBZ/qAw4aK6UIJKBDybDiNEjTnT0+Z86r3YTgTN
        M3psc7n8oR+FtHDvoCTyx8ePq80UfSg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-aVjNzJ23NUWdEQSSR72g3Q-1; Wed, 10 Nov 2021 18:25:18 -0500
X-MC-Unique: aVjNzJ23NUWdEQSSR72g3Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B4E51023F4E;
        Wed, 10 Nov 2021 23:25:16 +0000 (UTC)
Received: from [10.22.17.102] (unknown [10.22.17.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6905467849;
        Wed, 10 Nov 2021 23:25:15 +0000 (UTC)
Message-ID: <1f43bfad-434f-88d5-b794-4cf1116e9924@redhat.com>
Date:   Wed, 10 Nov 2021 18:25:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/2] clocksource: Avoid incorrect hpet fallback
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Feng Tang <feng.tang@intel.com>
References: <20211110221732.272986-1-longman@redhat.com>
 <20211110223250.GG641268@paulmck-ThinkPad-P17-Gen-1>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211110223250.GG641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/21 17:32, Paul E. McKenney wrote:
> On Wed, Nov 10, 2021 at 05:17:30PM -0500, Waiman Long wrote:
>> It was found that when an x86 system was being stressed by running
>> various different benchmark suites, the clocksource watchdog might
>> occasionally mark TSC as unstable and fall back to hpet which will
>> have a signficant impact on system performance.
>>
>> The current watchdog clocksource skew threshold of 50us is found to be
>> insufficient. So it is changed back to 100us before commit 2e27e793e280
>> ("clocksource: Reduce clocksource-skew threshold") in patch 1. Patch 2
>> adds a Kconfig option to allow kernel builder to control the actual
>> threshold to be used.
>>
>> Waiman Long (2):
>>    clocksource: Avoid accidental unstable marking of clocksources
>>    clocksource: Add a Kconfig option for WATCHDOG_MAX_SKEW
> The ability to control the fine-grained threshold seems useful, but is
> the TSC still marked unstable when this commit from -rcu is applied?
> It has passed significant testing on other workloads.
>
> 2a43fb0479aa ("clocksource: Forgive repeated long-latency watchdog clocksource reads")
>
> If the patch below takes care of your situation, my thought is to
> also take your second patch, which would allow people to set the
> cutoff more loosely or more tightly, as their situation dictates.
>
> Thoughts?

That is commit 14dbb29eda51 ("clocksource: Forgive repeated long-latency 
watchdog clocksource reads") in your linux-rcu git tree. From reading 
the patch, I believe it should be able to address the hpet fallback 
problem that Red Hat had encountered. Your patch said it was an 
out-of-tree patch. Are you planning to mainline it?

Patch 1 of this series contains some testing data that caused hpet 
fallback in our testing runs. In summary, a clock skew of 100us is found 
to be enough to avoid the problem with benchmark runs. However, we have 
some cases where TSC was marked unstable at bootup time with a skew of 
200us or more which, I believe, was caused by the thermal stress that 
the system was experiencing after running stressful benchmarks for hours.

At the end, we have to revert your clocksource patches before shipping 
RHEL9 beta last week.

Cheers,
Longman

