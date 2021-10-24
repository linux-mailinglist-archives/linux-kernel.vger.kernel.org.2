Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0B9438709
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 07:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbhJXFMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 01:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJXFMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 01:12:05 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE54C061764
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 22:09:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 83so1235510pgc.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 22:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=iQOoUomu5u7O+9jNIBVEhjeirOWfT680Wvu7Xb55Ynw=;
        b=dKaKdMsOnagMbk2ihui+by5d1ZBfpF2ubFoq3m8U1b9fnJa8pXI5Dz4tCiidexr2+C
         CVkC9CRL9AYKjB4eTAA+2+2sOlsxl7iJixtDUFTEMzMzbUIk454ZSVPZcxkSsrQ4EXib
         V5xosF+FVbGtpKRG1p8SViDLXE7xbY19MfET3RRnSegMsZ45AyxHedvm77zXzkYe1Gjt
         3200BGAHyEtrBgiEEIqMCBb4ELdd7aBLuVXE4clv4r0MG7UyYUKDIUe3kW+2/Oh47lc2
         Dy4/XQYFb+AzeL+fyhiFVCnx4BexrFuvz2Uor0ybst987uCfQ4I8oenRJQHis+uDqzms
         VXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=iQOoUomu5u7O+9jNIBVEhjeirOWfT680Wvu7Xb55Ynw=;
        b=3QCqlNDOScVnIlzSOjhtBmT9RDBvwrZ1j81yB1YC5KmF0GwfY4op6cgYl+k37yMtH/
         ReKBhUOkvEGwXxBnmCpeC8zATWLe1qa9MMwJmylYpfJIsQbi4nrRTKYGstxVVfMMGupQ
         ybb2tWhLXmI6ilqnyf9JXMLAvYEOFd0DzN6hZBNu1tgZLdpnlNLNNyp/Wu0iFrelf0FI
         bTLXJv0rDhr5OeoJFYOiVmdoGkAZpTgwzmAuv+to6+qEN4dIfCvGfkpOi+0D0sE2puF8
         LeX4hTbf2qc8eEJbRcai5+1gjYplQdFfp64WU5Sf1eu+baWOVc9xYQ6PjIqfoG8sJM6J
         Ejsg==
X-Gm-Message-State: AOAM531DXE4F52cySn2QaCAcUms4YGMcx0qxLqpyLZ5++/oaNAkEKCHu
        W1suc2frugI6IhPCZiIrvqI=
X-Google-Smtp-Source: ABdhPJx8TxkmJ0u/hUSBnbF9oJoQaMUndQ9vY3czBV2K7Rtg4O8uH4qATR4EBdOEhosPh04tCa6F7w==
X-Received: by 2002:a63:7c52:: with SMTP id l18mr1280257pgn.112.1635052184553;
        Sat, 23 Oct 2021 22:09:44 -0700 (PDT)
Received: from ?IPV6:2601:645:8400:1:ffb7:9e6f:baa:dfce? ([2601:645:8400:1:ffb7:9e6f:baa:dfce])
        by smtp.gmail.com with ESMTPSA id d6sm14793188pfa.39.2021.10.23.22.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Oct 2021 22:09:44 -0700 (PDT)
Message-ID: <70998f86-74d7-7ced-867e-f17695bc88e7@gmail.com>
Date:   Sat, 23 Oct 2021 22:09:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
From:   Norbert <nbrtt01@gmail.com>
Subject: Re: Performance regression: thread wakeup time (latency) increased up
 to 3x
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>, frederic@kernel.org
References: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com>
 <8691a8ec-410d-afe8-f468-eefe698c6751@gmail.com>
 <YW1ZjroFfmKM9HJe@hirez.programming.kicks-ass.net>
 <4674203.GXAFRqVoOG@kreacher>
Content-Language: en-US
In-Reply-To: <4674203.GXAFRqVoOG@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/21 06:03, Rafael J. Wysocki wrote:
> On Monday, October 18, 2021 1:25:02 PM CEST Peter Zijlstra wrote:
>> On Fri, Oct 15, 2021 at 09:08:58PM -0700, Norbert wrote:
>>
>>>>>> On Fri, Oct 15, 2021 at 12:43:45AM -0700, Norbert wrote:
>>>>>>> Performance regression: thread wakeup time (latency) increased up to 3x.
>>>>>>>
>>>>>>> Happened between 5.13.8 and 5.14.0. Still happening at least on 5.14.11.
>>
>>> So git-bisect finally identified the following commit.
>>> The performance difference came in a single step. Times were consistent with
>>> my first post either the slow time or the fast time,
>>> as far as I could tell during the bisection.
>>>
>>> It is a bit unfortunate that this comes from an attempt to reduce OS noise.
>>>
>>> -----------------------------------------------------
>>> commit a5183862e76fdc25f36b39c2489b816a5c66e2e5
>>> Author: Yunfeng Ye <yeyunfeng@huawei.com>
>>> Date:   Thu May 13 01:29:16 2021 +0200
>>>
>>>      tick/nohz: Conditionally restart tick on idle exit
>>>
>>>      In nohz_full mode, switching from idle to a task will unconditionally
>>>      issue a tick restart. If the task is alone in the runqueue or is the
>>>      highest priority, the tick will fire once then eventually stop. But that
>>>      alone is still undesired noise.
>>>
>>>      Therefore, only restart the tick on idle exit when it's strictly
>>>      necessary.
>>>
>>>      Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>>>      Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>>      Signed-off-by: Ingo Molnar <mingo@kernel.org>
>>>      Acked-by: Peter Zijlstra <peterz@infradead.org>
>>>      Link:
>>> https://lore.kernel.org/r/20210512232924.150322-3-frederic@kernel.org
>>> -----------------------------------------------------
>>>
>>> Is there anything else to do to complete this report?
>>
>> So it _could_ be you're seeing increased use of deeper idle states due
>> to less noise. I'm forever forgetting what the most friendly tool is for
>> checking that (powertop can I think), Rafael?
> 
> You can use turbostat too.
> 
>> One thing to try is boot with idle=halt and see if that makes a
>> different.
>>
>> Also, let me Cc all the people involved.. the thread starts:
>>
>>    https://lkml.kernel.org/r/035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com
>>
> 
> 
> 
> 


Measuring Idle states being used:

Since I've been running tests frequently and under various conditions, I 
wanted to integrate this into the benchmark, to automatically get 
precise numbers in so far as possible. So it is now reading sysfs values 
for idle state usage within the benchmark, right before and right after 
the test loop, and prints out the delta.

My processor/system has 3 idle states: POLL, C1 and C2.

Running the benchmark with the post-patch version of the kernel code, 
almost 100% of the idle states are C2 (more details below). This is 
regardless of the trigger time ("trigger time" means the FUTEX_WAKE call 
comes 50,000 ns after the other thread goes into FUTEX_WAIT), where I 
have measured 1,000 ns and 50,000 ns.

For the pre-patch version, the older faster one, the idle state used 
depends on the trigger time. For a a trigger time of 1000 ns, the idle 
states are almost 100% POLL. For a trigger time of 50,000 ns, the idle 
states shift almost 100% to C1.

All numbers are on isolated, nohz_full CPUs with SCHED_FIFO. (The more 
important part being SCHED_FIFO.) Measured with multi-user.target right 
after boot, on a modified 5.14.14 kernel which runs old or new code 
depending on the CPU number of the isolated CPU. Also using cgroups.

Detailed data is further below.

So each idle state is being used under some condition. :)


--- More details from sysfs: (I hope this provides the data that you 
were expecting from powertop or turbostat, otherwise please let me know.)

Initial data:

idle: available_governors : menu
    idle: current_governor : menu
idle: current_governor_ro : menu
      idle: current_driver : acpi_idle

Idle States at beginning of test for cpu 31 :

           idle state name : POLL
                      desc : CPUIDLE CORE POLL IDLE
                   latency : 0
                 residency : 0
                  rejected : 0
                     usage : 0
                      time : 0

           idle state name : C1
                      desc : ACPI FFH MWAIT 0x0
                   latency : 1
                 residency : 2
                  rejected : 0
                     usage : 0
                      time : 0

           idle state name : C2
                      desc : ACPI IOPORT 0x814
                   latency : 400
                 residency : 800
                  rejected : 0
                     usage : 4954
                      time : 264964543


Below, "Delta usage" is the difference in idle state usage between 
before and after the test loop. The test loop runs exactly 1,000,000 
iterations each time.

----- Output for post-patch, trigger time 1000 ns: -----

Testrun with cpu 31, iterations 1000000, non-aborted futex-waits 999999, 
trigger time 1000 ns.

3540.954890 ns wakeup latency, 757.503257 ns wake call time.

idle state POLL   delta usage:     45    delta time:      36
idle state C1     delta usage:   1038    delta time:     781
idle state C2     delta usage: 998890    delta time: 2845938


----- Output for pre-patch, trigger time 1000 ns: -----

Testrun with cpu 28, iterations 1000000, non-aborted futex-waits 999861, 
trigger time 1000 ns.

1071.148085 ns wakeup latency, 540.017857 ns wake call time.

idle state POLL   delta usage: 997960    delta time: 682471
idle state C1     delta usage:      1    delta time:      0
idle state C2     delta usage:   1244    delta time:   3411


--- Output for post-patch, trigger time 50,000 ns:

Testrun with cpu 31, iterations 1000000, non-aborted futex-waits 
1000000, trigger time 50000 ns.

3554.147479 ns latency, 740.034589 wake call.

idle state POLL   delta usage:       0    delta time:        0
idle state C1     delta usage:      16    delta time:      771
idle state C2     delta usage: 1000047    delta time: 51848427


----- Output for pre-patch, trigger time 50,000 ns: -----

1154.504049 ns latency, 587.281359 wake call.

Testrun with cpu 28, iterations 1000000, non-aborted futex-waits 
1000000, trigger time 50000 ns.

idle state POLL   delta usage:       1    delta time:       50
idle state C1     delta usage: 1027007    delta time: 49536027
idle state C2     delta usage:    2408    delta time:   123819

------------------------------
Best, Norbert
