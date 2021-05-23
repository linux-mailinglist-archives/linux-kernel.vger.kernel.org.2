Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3B038DD4D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 23:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhEWVcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 17:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbhEWVco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 17:32:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E56C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 14:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=pdBoqu1wu9kO7ZxSY8dv0BC1MQy+YgvrCZ8i9I2seF0=; b=oC80I33s6SRE2O1x1a0qV+AaoI
        Q7ci5M+ot3u6lLoT0+2xllK2UNaeI1l2WF5AYaXO63jn/qPslPs76XR6gqD7CXly0GE/kGaeDMp+/
        Hr1MEyaT8c2qHlThxBS17nuFJ6prXYpYp2Drbcjt2mNyVFBHxXseISN9V0zF9GgVjOoFObQSGJFhQ
        NqtmneZtolNndfKtzw1Epl6VleSy3GUNihJEkZGTkBxcAvga0b08EneCFjtwlbuq39xWBcQpWjnGy
        H1boqnxu/aMIQfaLq4uGszBZMMlmh/W6nJSxOOKboPK/Qf1h2zXO570XiwDnKW+7z3rQlGUFDxmO0
        FkQXyxfg==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkvgo-000ZzD-VP; Sun, 23 May 2021 21:31:15 +0000
Subject: Re: config SCHED_CORE
To:     Hugh Dickins <hughd@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <alpine.LSU.2.11.2105201954180.6100@eggly.anvils>
 <YKdm69K8k/ztd6BM@hirez.programming.kicks-ass.net>
 <CAEXW_YRxOqQCF2FgXAjL3xkZhRD4rdFuxvyPd-ESXYQQ78cyfQ@mail.gmail.com>
 <YKo1AOIIsZectSQt@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.11.2105231252070.29171@eggly.anvils>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6193be11-a92d-23a9-e999-ae785ffa73bb@infradead.org>
Date:   Sun, 23 May 2021 14:31:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2105231252070.29171@eggly.anvils>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/21 1:30 PM, Hugh Dickins wrote:
> On Sun, 23 May 2021, Peter Zijlstra wrote:
>> On Fri, May 21, 2021 at 07:57:35AM -0400, Joel Fernandes wrote:
>>> On Fri, May 21, 2021 at 3:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>>> +       help
>>>> +         This option enables Core scheduling, a means of coordinated task
>>>> +         selection across SMT siblings with the express purpose of creating a
>>>> +         Core wide privilidge boundary. When enabled -- see prctl(PR_SCHED_CORE)
>>>> +         -- task selection will ensure all SMT siblings will execute a task
>>>> +         from the same 'core group', forcing idle when no matching task is found.
>>>> +
>>>> +         This provides means of mitigation against a number of SMT side-channels;
>>>> +         but is, on its own, insufficient to mitigate all known side-channels.
>>>> +         Notable: the MDS class of attacks require more.
>>>> +
>>>> +         Default enabled for anything that has SCHED_SMT, when unused there should
>>>> +         be no impact on performance.
>>>
>>> This description sort of makes it sound like security is the only
>>> usecase. Perhaps we can also add here that core-scheduling can help
>>> performance of workloads where hyperthreading is undesired, such as
>>> when VM providers don't want to share hyperthreads.
>>
>> Something like so then?
> 
> Much more helpful, thanks. And I agree that you have to keep it fairly
> brief here: I think you've struck the right balance.  Some nits below.
> 
>>
>> ---
>>  kernel/Kconfig.preempt | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
>> index ea1e3331c0ba..cd497fecfd43 100644
>> --- a/kernel/Kconfig.preempt
>> +++ b/kernel/Kconfig.preempt
>> @@ -104,4 +104,18 @@ config SCHED_CORE
>>  	bool "Core Scheduling for SMT"
>>  	default y
>>  	depends on SCHED_SMT
>> +	help
>> +	  This option enables Core scheduling, a means of coordinated task
> 
> Maybe s/scheduling/Scheduling/ to match the title?
> 
> I think I got the picture once I reached the end, but was confused here
> by the stages of enablement.  s/This option enables/This option permits/
> would be clearer, I think.
> 

I like all of Hugh's suggestions...

> 
>> +	  selection across SMT siblings. When enabled -- see
>> +	  prctl(PR_SCHED_CORE) -- task selection will ensure all SMT siblings
> 
> s/will ensure/ensures that/ (it felt like too many "will"s before)

especially that one. ^^^

>> +	  will execute a task from the same 'core group', forcing idle when no
>> +	  matching task is found.
>> +
>> +	  Use of this feature includes:
>> +	   - mitigation of some (not all) SMT side channels;
>> +	   - limiting SMT interference to improve determinism and/or performance.
>> +
>> +	  Default enabled for anything that has SCHED_SMT, when unused there
> 
> "SCHED_CORE is default enabled when SCHED_SMT is enabled - when unused there"
> would be better.
> 
>> +	  should be no impact on performance.


thanks.
-- 
~Randy

