Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE9D34D9B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 23:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbhC2Vt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 17:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhC2Vt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 17:49:29 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C642C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 14:49:29 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r17so6320023ilt.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OTRMqDMmVjOSM+8r4ljF7+vW0yLz7ssBKcqyHVjTTDo=;
        b=Z3rhMlqM/giLnUFw4LSy8zWfm1lJfeNgvg9MpwSq03tA6QpxM3ADZZs0EQ7g9Q4P7d
         o6hL3y00TaxxzYf8pS8T1HVixAw1d/XXklDlY1mgjK+2RB3t7mcULAsMg4LGOhzb3VFQ
         fS1Hl+CPnHBRZTT29mtOCaYREbs3XF+8Dcj14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OTRMqDMmVjOSM+8r4ljF7+vW0yLz7ssBKcqyHVjTTDo=;
        b=P+N25HFLbqe9ovAzRP/opjc+XFU6cexPScYwUa/hvGvhRTx8bbfdpuvqtRw8kpsAQU
         9C2thW2JPcP23JRvb3sm+pZtm4CU0OkS+/7Au2Tf7MuwMrSEho/Pib3vjBkYDD9lLWN2
         xyhNFB82C/pDkz9ClXq1c2UXBkLlxAJQ/Ei3WMIZhQdz64s2qz6n9wh8MZ3cAwTu4Nw6
         AH0xTxaHfRDELRzBY52a2XQNgnbhs4Tohqw+OeOOe3TuWTmKIcF0A9G6T6/o9qCKhJkL
         PNnYfZW8LJK+0vrHRz6FiVliwYa/S4DU/U5Nd0P63fZGimLi2ZfUerR06ZVpiwlsyfqW
         PwrA==
X-Gm-Message-State: AOAM5303LKvGGcgcYKAVti9r3SHDPpUVq8KnE4XAedhY8oI9ourwQRMq
        x1IGyFRjaZvl5SvP2UgtopM0Pw==
X-Google-Smtp-Source: ABdhPJy3Z/yXG62jQZyDsMJX/hNaY9lbdg//V857tdDfliwXCHKbNymhX8Yyl7Tpjntsn6Gf2AkIow==
X-Received: by 2002:a05:6e02:1e01:: with SMTP id g1mr22359572ila.192.1617054568828;
        Mon, 29 Mar 2021 14:49:28 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id e6sm10039732ioq.13.2021.03.29.14.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 14:49:28 -0700 (PDT)
Subject: Re: [PATCH] sched/psi.c: Rudimentary typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
References: <20210326124233.7586-1-unixbhaskar@gmail.com>
 <YF4hMn4rCftcdsSm@cmpxchg.org>
 <20210326184122.GO4746@worktop.programming.kicks-ass.net>
 <YF45Qi+/eB+/m7y/@Gentoo>
From:   Shuah Khan <skhan@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, dietmar.eggemann@arm.com,
        bsegall@google.com, Johannes Weiner <hannes@cmpxchg.org>,
        mingo@redhat.com, vincent.guittot@linaro.org, bristot@redhat.com,
        rostedt@goodmis.org, juri.lelli@redhat.com, mgorman@suse.de,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <1f5fb434-ca4b-bc10-92c4-411087ddf717@linuxfoundation.org>
Date:   Mon, 29 Mar 2021 15:49:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <YF45Qi+/eB+/m7y/@Gentoo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/21 1:42 PM, Bhaskar Chowdhury wrote:
> On 19:41 Fri 26 Mar 2021, Peter Zijlstra wrote:
>> On Fri, Mar 26, 2021 at 02:00:18PM -0400, Johannes Weiner wrote:
>>> On Fri, Mar 26, 2021 at 06:12:33PM +0530, Bhaskar Chowdhury wrote:
>>> >
>>> > s/possible/possible/
>>> > s/ exceution/execution/
>>> > s/manupulations/manipulations/
>>> >
>>> > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>>> > ---
>>> >  kernel/sched/psi.c | 6 +++---
>>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>>> >
>>> > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
>>> > index 967732c0766c..316ebc57a115 100644
>>> > --- a/kernel/sched/psi.c
>>> > +++ b/kernel/sched/psi.c
>>> > @@ -59,7 +59,7 @@
>>> >   * states, we would have to conclude a CPU SOME pressure number of
>>> >   * 100%, since *somebody* is waiting on a runqueue at all
>>> >   * times. However, that is clearly not the amount of contention the
>>> > - * workload is experiencing: only one out of 256 possible exceution
>>> > + * workload is experiencing: only one out of 256 possible execution
>>>
>>> I thought this was the french spelling.
>>>
>>> Joking aside, the corrections look right, but I also had no trouble
>>> understanding what those sentences mean. Typos happen, plus we have a
>>> lot of non-native speakers who won't use perfect spelling or grammar.
>>>
>>> So for me, the bar is "this can be easily understood", not "needs to
>>> be perfect English", and I'd say let's skip patches like these unless
>>> they fix something truly unintelligble.
>>
>> Ignore this robot, lots of people already have a special mail rule for
>> him. On top of that, this spelling mistake was already fixed by Ingo in:
>>
> 
> Dude, this is a human being and you are suggesting a fucking stupid 
> solution
> to others. I know what Ingo did and very appreciable. Please try to be
> cooperative and help. Stop spreading FUD ...for fuck's sake ...man..
> 
> I am not doing it fun...you need to understand that . ...
> 
> 
> ..and I have some special rule for some people to ...who the fuck care
> ...ahhhhhhhhhh

Bhaskar Chowdhury,

Please be advised that we have received a CoC complaint about your
responses to the following patch discussions:

- https://lore.kernel.org/lkml/YGFrvwX8QngvwPbA@Gentoo/
- https://lore.kernel.org/lkml/YF45Qi+%2FeB+%2Fm7y%2F@Gentoo/
- https://lore.kernel.org/lkml/YF44jiYiAVkuwE0P@Gentoo/
- https://lore.kernel.org/r/YGHOxwiqwhGAs819@Gentoo

There is no requirement that anyone accept your patches. Accepting
feedback and working with the community will ensure that your work
will be taken seriously now and in the future.

Your responses go against the CoC. If this continues, we will take
action to add you to the kernel wide blacklist.

Please refer to:
https://www.kernel.org/doc/html/latest/process/code-of-conduct.html

thanks,
-- Shuah (on behalf of the Code of Conduct Committee)

