Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D462391522
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 12:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhEZKlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 06:41:09 -0400
Received: from foss.arm.com ([217.140.110.172]:42744 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234021AbhEZKlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 06:41:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BA641516;
        Wed, 26 May 2021 03:39:31 -0700 (PDT)
Received: from [10.57.31.7] (unknown [10.57.31.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 082F23F73B;
        Wed, 26 May 2021 03:39:28 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] EM / PM: Inefficient OPPs
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        dietmar.eggemann@arm.com
References: <1621616064-340235-1-git-send-email-vincent.donnefort@arm.com>
 <20210526034751.5fl4kekq73gqy2wq@vireshk-i7>
 <20210526090141.GA408481@e120877-lin.cambridge.arm.com>
 <20210526093807.sih5y4lgltsz3r74@vireshk-i7>
 <17d88121-4809-dc31-1b57-2134ec868c8b@arm.com>
Message-ID: <fb80ceef-a2af-6f70-4863-fd376a438f3e@arm.com>
Date:   Wed, 26 May 2021 11:39:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <17d88121-4809-dc31-1b57-2134ec868c8b@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/21 11:24 AM, Lukasz Luba wrote:

[snip]

>> What about disabling the OPP in the OPP core itself ? So every user 
>> will get the
>> same picture.
> 
> There are SoCs which have OPPs every 100MHz even at high freq. They are
> used e.g. when thermal kicks in. We shouldn't disable them in generic
> frameworks like OPP. They might be used to provide enough CPU capacity,
> when temp is high. Imagine you have a board which does some work:
> sends and received some UDP packets. The board has been tested in oven
> that it will still be able to handle X messages/sec but using an OPP, 
> which in our heuristic is 'inefficient'. You cannot go above, because it
> will overheat the SoC, you might go below and find first 'efficient'
> OPP. You might harm this board performance if e.g. the OPP is 20% slower
> that this 'inefficient' which was tested by engineers.
> 
>>
>>>>
>>>> Since the whole thing depends on EM and OPPs, I think we can 
>>>> actually do this.
>>>>
>>>> When the cpufreq driver registers with the EM core, lets find all the
>>>> Inefficient OPPs and disable them once and for all. Of course, this 
>>>> must be done
>>>> on voluntarily basis, a flag from the drivers will do. With this, we 
>>>> won't be
>>>> required to update any thing at any of the governors end.
>>>
>>> We still need to keep the inefficient OPPs for thermal reason.
>>
>> How will that benefit us if that OPP is never going to run anyway ? We 
>> won't be
> 
> This OPP still might be used, the Vincent heuristic is just a 'hint'.
> Schedutil will check policy->max and could clamp the 'efficient'
> returned freq to first allowed, which might be 'inefficient'
> 
>> cooling down the CPU then, isn't it ?
> 
> The 'inefficient' OPP is called from our 'energy placement' angle. For
> other folks from automotive, industrial or IoT who are stress testing
> SoCs and boards in various circumstances, they might call our
> 'inefficient' perf state as 'efficient' - for they need.
> 
> In our internal review I pointed that we are optimizing for mobiles with
> this and we might actually need a #ifdef, config or a switch for this
> heuristic.
> 

But even in mobiles, we might start facing issues e.g. during high
resolution recording, when we just disable 'inefficient' OPPs,
which were used in such use case and higher temperature.
