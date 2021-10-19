Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A59432EC8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhJSHDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbhJSHDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:03:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C24C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:01:35 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id om14so13967098pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 00:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=e7ZAdLC/CfIKx+xzdbsajp9sAGRixVWxt7voVYsHGP8=;
        b=n3aCxcEX4TORFJk0t2/q0eufJoNJAEoAAaqLw83rnWnqtPwjIYev1tVf8/PeeaBlZU
         54jsBJYsNXFKUHGxuKdQSJDf0xWlfbSZHAqVgldpkPZ2I56Q+Eh8gI73qgUH2Si3FEba
         +LTgoRx5hrOdYTgf+d5OsrrSNHPs+tDQPrUCh04OfslFG9tkqagTNrMxTfpHj1n5iYo0
         1mEnrRTBkeYvjfFXfnP5QkZ1gV+tswTxdYevvDn5Ktkw6CVXFwLDN+LKEyQxZHc0MGOM
         rxGH/K2CBbnQTfR85RcYSHwkjrF1BFwlYuiVcqBWO+K1tQ6IzTDy+ox2f7mMmMnNRh3H
         Tpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=e7ZAdLC/CfIKx+xzdbsajp9sAGRixVWxt7voVYsHGP8=;
        b=6ZJ8nPwOQNtmkW++ox+GPRN3pdrgRLJIT/B/1T+c25qaQP6CX8J1IUuJYSpY9MukzO
         tzDXOzYyaGdwdIf0Qsb9XHIXJYvjJbLvDhDmrWEwEMzHheReBmZawTBdn18tNxboyjW0
         kLep4+iM9OiFz2qT6NPt3zSiXDskQoA00ga7x6th8WkSEBMfAqHFX8YUUheMswyI+kiU
         em6oyICg7e7Vrjrb++rCpZUNHFM9uMPCzC1cFruM4bNILnnsl4AOjDavd+uzEBUFmqnL
         MwlCwxhoDRmNUMtSJ59xED19xDMjqmEP3A0c8EwCe627ZH8XBvAREWWYpLBdIRVwsdqF
         1pOQ==
X-Gm-Message-State: AOAM530GqPhsREAHtBzreHW4EY7s6TEFfIfIQP6PcVBMFYrIjJyVOVZ0
        xebcFffV43JTh76EO4CYHgv6P6TnRG5ymw==
X-Google-Smtp-Source: ABdhPJx5CoJbDpc87ftVQmLq3bwjhMs/St/Hak2Zk+FtX1W73e6zZLkEBg+XqYJju72OfJm/+DPQWA==
X-Received: by 2002:a17:902:dac4:b0:13e:fcb8:eaf1 with SMTP id q4-20020a170902dac400b0013efcb8eaf1mr32082727plx.50.1634626894445;
        Tue, 19 Oct 2021 00:01:34 -0700 (PDT)
Received: from ?IPV6:2601:645:8400:1:ffb7:9e6f:baa:dfce? ([2601:645:8400:1:ffb7:9e6f:baa:dfce])
        by smtp.gmail.com with ESMTPSA id q8sm1512133pja.52.2021.10.19.00.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 00:01:34 -0700 (PDT)
Message-ID: <ae2debfb-c780-7164-09ee-ea295004d173@gmail.com>
Date:   Tue, 19 Oct 2021 00:01:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: Performance regression: thread wakeup time (latency) increased up
 to 3x
Content-Language: en-US
From:   Norbert <nbrtt01@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, frederic@kernel.org
References: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com>
 <YWlBUVDy9gOMiXls@hirez.programming.kicks-ass.net>
 <5fe0ffa5-f2db-ca79-5a10-305310066ff9@gmail.com>
 <20211015100401.45833169@gandalf.local.home>
 <8691a8ec-410d-afe8-f468-eefe698c6751@gmail.com>
 <YW1ZjroFfmKM9HJe@hirez.programming.kicks-ass.net>
 <fff246da-2a10-3463-614c-e54cd8cf78e7@gmail.com>
In-Reply-To: <fff246da-2a10-3463-614c-e54cd8cf78e7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 18:56, Norbert wrote:
> On 10/18/21 04:25, Peter Zijlstra wrote:
>> On Fri, Oct 15, 2021 at 09:08:58PM -0700, Norbert wrote:
>>
>>>>>> On Fri, Oct 15, 2021 at 12:43:45AM -0700, Norbert wrote:
>>>>>>> Performance regression: thread wakeup time (latency) increased up 
>>>>>>> to 3x.
>>>>>>>
>>>>>>> Happened between 5.13.8 and 5.14.0. Still happening at least on 
>>>>>>> 5.14.11.
>>
>>> So git-bisect finally identified the following commit.
>>> The performance difference came in a single step. Times were 
>>> consistent with
>>> my first post either the slow time or the fast time,
>>> as far as I could tell during the bisection.
>>>
>>> It is a bit unfortunate that this comes from an attempt to reduce OS 
>>> noise.
>>>
>>> -----------------------------------------------------
>>> commit a5183862e76fdc25f36b39c2489b816a5c66e2e5
>>> Author: Yunfeng Ye <yeyunfeng@huawei.com>
>>> Date:   Thu May 13 01:29:16 2021 +0200
>>>
>>>      tick/nohz: Conditionally restart tick on idle exit
>>>
>>>      In nohz_full mode, switching from idle to a task will 
>>> unconditionally
>>>      issue a tick restart. If the task is alone in the runqueue or is 
>>> the
>>>      highest priority, the tick will fire once then eventually stop. 
>>> But that
>>>      alone is still undesired noise.
>>>
>>>      Therefore, only restart the tick on idle exit when it's strictly
>>>      necessary.
>>>
>>>      Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>>>      Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>>      Signed-off-by: Ingo Molnar <mingo@kernel.org>
>>>      Acked-by: Peter Zijlstra <peterz@infradead.org>
>>>      Link:
>>> https://lore.kernel.org/r/20210512232924.150322-3-frederic@kernel.org
>>> -----------------------------------------------------
>>>
>>> Is there anything else to do to complete this report?
>>
>> So it _could_ be you're seeing increased use of deeper idle states due
>> to less noise. I'm forever forgetting what the most friendly tool is for
>> checking that (powertop can I think), Rafael?
>>
>> One thing to try is boot with idle=halt and see if that makes a
>> different.
>>
>> Also, let me Cc all the people involved.. the thread starts:
>>
>>    
>> https://lkml.kernel.org/r/035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com
>>
> 
> 
> Booting with idle=halt results in a thread wakeup time of around 2000 
> ns, so in the middle between the kernel 5.13 value of 1080 ns and the 
> kernel 5.14/5.15 value of around 3550 ns. The wake call time remains at 
> 740 ns (meaning as bad as without this setting). I'm not sure how much 
> that says or doesn't say. By the way, using cpufreq.off=1 seems to have 
> no effect at all.
> 
> In the meantime I verified the finding from the git bisection by 
> manually reverting the changes from this commit in the source code of 
> the 5.15-rc5 code base. By doing so the timings for the 
> isolated/nohz_full CPUs come back almost to the (good) 5.13 values (both 
> wakeup and wake-call).
> 
> However the timings for the non-isolated CPUs are unaffected and remain
> with the worse performance of 1.3x for the wakeup and 1.4x for the wake 
> call. So this apparently requires a separate independent git-bisect and 
> is probably a second separate issue (if it is also due to a single change).
> 
> I've tried a bit to narrow down the cause of the 3.3x slowdown but am 
> still trying to find my way through the maze of little functions... :-).


On the thought that it might enter deeper idle/wait/sleep states:

The benchmark executes this test in a quite tight loop, except that so 
far it waited 1000 ns (with a mix of pause and rdtsc) before calling 
futex-wake, to make sure the other thread fully enters the futex-wait 
without taking any shortcuts.

Except when this "prepare time" is reduced to less than even 350 ns or 
so, the timings remain the same (they go up before they start going 
down). Surely in this situation the thread is at least not supposed to 
enter deeper states for such short waiting times.

Best, Norbert
