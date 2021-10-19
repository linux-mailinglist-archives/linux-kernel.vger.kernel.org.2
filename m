Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F68432B9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 03:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhJSB6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 21:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhJSB6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 21:58:31 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E128C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 18:56:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s136so14683057pgs.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 18:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=Og/kHMmccKQDkROuf1sUa7HybfobTWbMRHSr7Vgy+5w=;
        b=QdpYfNqkJEQ+zutlEYtpTexTwuewyrxLitD2PGKmjqjkVpLT27tpTcdX1gUHw1S2p6
         8xBUR6B0pYcl80rTW1APMnLC+jXwWjun1n+1x7DXVY8HPr5CmgDzHN6teUv/eGvAPzwr
         wilxpCEIhNuLnTqU0HBbDIBUiSgi3OUmlupls1c5R1kiy3iBBsTClFXIZWDwwgI4Fx/4
         WB66/jYnzv2j6habVDICg+wsC50CYVvzBsV6nQjtIkqsnUH7jK595isyCKX8MGDIRs9I
         NXpFpKIZMDyWk6otMJrFBDV8kizhbHO576lDx5XqdJI+KWPxwcnpNLwYe1j0lOIMPl1P
         W7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=Og/kHMmccKQDkROuf1sUa7HybfobTWbMRHSr7Vgy+5w=;
        b=ylLfMCncq1BZMrGdy6zCLdxgHIuTtc243640dcdN8E6Kqa3m+RMBoDq83YsAl2c/Vb
         l7wes6CCrqT0/MFEueFutRzeY6FM0CanOJEN5gR/wZgB6DCF/zria3pntIsKyhpUYZNX
         Agfdu/ivG5sfnPpg/dK6UYp/w+1yEscqbSfbDv7cDvnh9ph6ikSdIGocNO9pW0d732s6
         zNlWzBRXHi2obozGeVqb/7xCl/f9A/5Cla7gBaEhE69w6nltrHN5JpWsOcxpaK8UNcVU
         A/JQa6DF6nGSGBbeVsPg1h3khxhJbnEsRPJM38EO7kE+/CbUapFiPwirinfj0yk9SPzh
         JI+Q==
X-Gm-Message-State: AOAM530TKj/kSprC1onX7f4dJqabMsSe/LVYmuPyaURACWPSmMo2WIO2
        62AuVUVdiIvalrUGr7jfg6A=
X-Google-Smtp-Source: ABdhPJwySTGJI/LgjuLNL9p1MHqmrXKYrR2sqTrNghT0zy6ps4wfd+Ah67Nh4wov9hTkf46cJ0nxfg==
X-Received: by 2002:a63:b91c:: with SMTP id z28mr15107747pge.393.1634608579593;
        Mon, 18 Oct 2021 18:56:19 -0700 (PDT)
Received: from ?IPV6:2601:645:8400:1:ffb7:9e6f:baa:dfce? ([2601:645:8400:1:ffb7:9e6f:baa:dfce])
        by smtp.gmail.com with ESMTPSA id w11sm737415pge.48.2021.10.18.18.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 18:56:19 -0700 (PDT)
Message-ID: <fff246da-2a10-3463-614c-e54cd8cf78e7@gmail.com>
Date:   Mon, 18 Oct 2021 18:56:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
From:   Norbert <nbrtt01@gmail.com>
Subject: Re: Performance regression: thread wakeup time (latency) increased up
 to 3x
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
Content-Language: en-US
In-Reply-To: <YW1ZjroFfmKM9HJe@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/21 04:25, Peter Zijlstra wrote:
> On Fri, Oct 15, 2021 at 09:08:58PM -0700, Norbert wrote:
> 
>>>>> On Fri, Oct 15, 2021 at 12:43:45AM -0700, Norbert wrote:
>>>>>> Performance regression: thread wakeup time (latency) increased up to 3x.
>>>>>>
>>>>>> Happened between 5.13.8 and 5.14.0. Still happening at least on 5.14.11.
> 
>> So git-bisect finally identified the following commit.
>> The performance difference came in a single step. Times were consistent with
>> my first post either the slow time or the fast time,
>> as far as I could tell during the bisection.
>>
>> It is a bit unfortunate that this comes from an attempt to reduce OS noise.
>>
>> -----------------------------------------------------
>> commit a5183862e76fdc25f36b39c2489b816a5c66e2e5
>> Author: Yunfeng Ye <yeyunfeng@huawei.com>
>> Date:   Thu May 13 01:29:16 2021 +0200
>>
>>      tick/nohz: Conditionally restart tick on idle exit
>>
>>      In nohz_full mode, switching from idle to a task will unconditionally
>>      issue a tick restart. If the task is alone in the runqueue or is the
>>      highest priority, the tick will fire once then eventually stop. But that
>>      alone is still undesired noise.
>>
>>      Therefore, only restart the tick on idle exit when it's strictly
>>      necessary.
>>
>>      Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
>>      Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
>>      Signed-off-by: Ingo Molnar <mingo@kernel.org>
>>      Acked-by: Peter Zijlstra <peterz@infradead.org>
>>      Link:
>> https://lore.kernel.org/r/20210512232924.150322-3-frederic@kernel.org
>> -----------------------------------------------------
>>
>> Is there anything else to do to complete this report?
> 
> So it _could_ be you're seeing increased use of deeper idle states due
> to less noise. I'm forever forgetting what the most friendly tool is for
> checking that (powertop can I think), Rafael?
> 
> One thing to try is boot with idle=halt and see if that makes a
> different.
> 
> Also, let me Cc all the people involved.. the thread starts:
> 
>    https://lkml.kernel.org/r/035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com
> 


Booting with idle=halt results in a thread wakeup time of around 2000 
ns, so in the middle between the kernel 5.13 value of 1080 ns and the 
kernel 5.14/5.15 value of around 3550 ns. The wake call time remains at 
740 ns (meaning as bad as without this setting). I'm not sure how much 
that says or doesn't say. By the way, using cpufreq.off=1 seems to have 
no effect at all.

In the meantime I verified the finding from the git bisection by 
manually reverting the changes from this commit in the source code of 
the 5.15-rc5 code base. By doing so the timings for the 
isolated/nohz_full CPUs come back almost to the (good) 5.13 values (both 
wakeup and wake-call).

However the timings for the non-isolated CPUs are unaffected and remain
with the worse performance of 1.3x for the wakeup and 1.4x for the wake 
call. So this apparently requires a separate independent git-bisect and 
is probably a second separate issue (if it is also due to a single change).

I've tried a bit to narrow down the cause of the 3.3x slowdown but am 
still trying to find my way through the maze of little functions... :-).
