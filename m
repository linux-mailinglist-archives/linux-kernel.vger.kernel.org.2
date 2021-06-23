Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A42A83B1681
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFWJMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:12:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28806 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229833AbhFWJMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624439421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TldL/w6S5dtdX+yYkIXo1zpWU2dmtlChFepScE6V4JQ=;
        b=Um1NE1FALzfPV3S6aPJ18bwP7+2Jhla107TX+bZBbzekhKhA/SaxOLzk/pKJfXxMRj4JEJ
        6akUdeoCDsYfn+ap9TV4u3LycXQ/2WqTSaQtjR32S5dKxJ6XtJQ29ZYvReRiwCBnh3xS6N
        k8AiirHm40RvSMbmx2tS1xLIJONh44c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-beRGgmDzMTmJGJsuAZgGyA-1; Wed, 23 Jun 2021 05:10:19 -0400
X-MC-Unique: beRGgmDzMTmJGJsuAZgGyA-1
Received: by mail-wm1-f70.google.com with SMTP id y129-20020a1c32870000b029016920cc7087so125659wmy.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 02:10:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TldL/w6S5dtdX+yYkIXo1zpWU2dmtlChFepScE6V4JQ=;
        b=Xfe0fy5d6YqXMpwTIsGubVoBA2za4ijjRw1V2HatrB/ikgPr0/I/vKRZkKRzqob3+K
         75UgbfPjbB4n9Z/1gATU9ZERdzaQdm0nU/jzd8p+JgKCHqJkpPBlYTZ01HZNPQLu7L1U
         q2NJop9QWWv49/z6h0TYN3KKptH0TY/ga4FB2HDQ1ruK/vNMuhb0kzbX5KkfT8qU8g/s
         +VEqFBpjAEVWGAPuzsH/AROceyd8lSqNFnptYXguNVrwu0KGHQqUI1397yMTVCiFTtqc
         WMHjo3fjs8mwaE8BZQZy/VbaxPj+wupWtAZif3WV6i8M73cLvnK257rtVZEEXBmNPnOd
         sGuw==
X-Gm-Message-State: AOAM531eADiKYwovIN3gQTgmFru5a+BLwqsFee6jolrSCgiFU+4aPGSU
        O45v/lJv2hl1oMt4YwEP/Z8827Ib0nZaa3F5GZMGcQhY39QpgbPCsprWH1+7SSNI8tuA3R+6ZOi
        vs9sF9ZZiHkwqUIwCe01U9E+e4FXWX61Wg7HQKTgnnV4+abiFvoqVpgrlyl6NiGN5J/L5prYv4y
        A=
X-Received: by 2002:adf:eace:: with SMTP id o14mr10541405wrn.159.1624439418486;
        Wed, 23 Jun 2021 02:10:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTZzNPxGUMqNheGeM3M2TBt3rXHEhKc0P0xPL91HyyMaTOme/Ws+UTyi3FBDzfRQXRQyvDnw==
X-Received: by 2002:adf:eace:: with SMTP id o14mr10541375wrn.159.1624439418205;
        Wed, 23 Jun 2021 02:10:18 -0700 (PDT)
Received: from x1.bristot.me (nat-cataldo.sssup.it. [193.205.81.5])
        by smtp.gmail.com with ESMTPSA id f19sm2222698wre.48.2021.06.23.02.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 02:10:17 -0700 (PDT)
Subject: Re: Functional Coverage via RV? (was: "Learning-based Controlled
 Concurrency Testing")
To:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210518204226.GR4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNN+nS1CAz=0vVdJLAr_N+zZxqp3nm5cxCCiP-SAx3uSyA@mail.gmail.com>
 <20210519185305.GC4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNMskihABCyNo=cK5c0vbNBP=fcUO5-ZqBJCiO4XGM47DA@mail.gmail.com>
 <CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss=EZ4xAbrHnMwdt5g@mail.gmail.com>
 <c179dc74-662d-567f-0285-fcfce6adf0a5@redhat.com>
 <YMyC/Dy7XoxTeIWb@elver.google.com>
 <35852e24-9b19-a442-694c-42eb4b5a4387@redhat.com>
 <YNBqTVFpvpXUbG4z@elver.google.com>
 <01a0161a-44d2-5a32-7b7a-fdb13debfe57@redhat.com>
 <YNG/8EcdPBfH/Taf@elver.google.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <93e7048a-209f-82f2-8d28-ff8347595695@redhat.com>
Date:   Wed, 23 Jun 2021 11:10:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNG/8EcdPBfH/Taf@elver.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/21 12:48 PM, Marco Elver wrote:
> On Mon, Jun 21, 2021 at 09:25PM +0200, Daniel Bristot de Oliveira wrote:
>> On 6/21/21 12:30 PM, Marco Elver wrote:
>>> On Mon, Jun 21, 2021 at 10:23AM +0200, Daniel Bristot de Oliveira wrote:
>>> [...]
>>>>> Yes, unlike code/structural coverage (which is what we have today via
>>>>> KCOV) functional coverage checks if some interesting states were reached
>>>>> (e.g. was buffer full/empty, did we observe transition a->b etc.).
>>>>
>>>> So you want to observe a given a->b transition, not that B was visited?
>>>
>>> An a->b transition would imply that a and b were visited.
>>
>> HA! let's try again with a less abstract example...
> 
> Terminology misunderstanding.
> 
> I mean "state transition". Writing "a->b transition" led me to infer 'a'
> and 'b' are states, but from below I infer that you meant an "event
> trace" (viz. event sequence).  So it seems I was wrong.
> 
> Let me be clearer: transition A -[a]-> B implies states A and B were
> visited.

right

Hence, knowing that event 'a' occurred is sufficient, and
> actually provides a little more information than just "A and B were
> visited".

iff [a] happens only from A to B...

> 
>>
>>   |   +------------ on --+----------------+
>>   v   ^                  +--------v       v
>> +========+               |        +===========+>--- suspend ---->+===========+
>> |  OFF   |               +- on --<|     ON    |                  | SUSPENDED |
>> +========+ <------ shutdown -----<+===========+<----- on -------<+===========+
>>     ^                                    v                             v
>>     +--------------- off ----------------+-----------------------------+
>>
>> Do you care about:
>>
>> 1) states [OFF|ON|SUSPENDED] being visited a # of times; or
>> 2) the occurrence of the [on|suspend|off] events a # of times; or
>> 3) the language generated by the "state machine"; like:
>>
>>    the occurrence of *"on -> suspend -> on -> off"*
>>
>>          which is != of
>>
>>    the occurrence of *"on -> on -> suspend -> off"*
>>
>>          although the same events and states occurred the same # of times
>> ?
> 
> They are all interesting, but unrealistic for a fuzzer to keep track of.
> We can't realistically keep track of all possible event traces. Nor that
> some state or event was visited # of times.

We can track this easily via RV, and doing that is already on my todo list. But
now I got that we do not need all these information for the functional coverage.

> What I did mean is as described above: the simple occurrence of an
> event, as it implies some previous and next state were visited.
> 
> The fuzzer then builds up knowledge of which inputs cause some events to
> occur. Because it knows it has inputs for such events, it will then try
> to further combine these inputs hoping to reach new coverage. This leads
> to various distinct event traces using the events it has already
> observed. All of this is somewhat random of course, because fuzzers are
> not meant to be model checkers.
> 
> If someone wants something more complex as you describe, it'd have to
> explicitly become part of the model (if possible?). The problem of
> coverage explosion applies, and we may not recommend such usage anyway.

I did not mean to make GCOV/the fuzzer to keep track of these information. I was
trying to understand what are the best way to provide the information that you
all need.

>> RV can give you all... but the way to inform this might be different.
>>
>>>> I still need to understand what you are aiming to verify, and what is the
>>>> approach that you would like to use to express the specifications of the systems...
>>>>
>>>> Can you give me a simple example?
>>>
>>> The older discussion started around a discussion how to get the fuzzer
>>> into more interesting states in complex concurrent algorithms. But
>>> otherwise I have no idea ... we were just brainstorming and got to the
>>> point where it looked like "functional coverage" would improve automated
>>> test generation in general. And then I found RV which pretty much can
>>> specify "functional coverage" and almost gets that information to KCOV
>>> "for free".
>>
>> I think we will end up having an almost for free solution, but worth the price.
>>
>>>> so, you want to have a different function for every transition so KCOV can
>>>> observe that?
>>>
>>> Not a different function, just distinct "basic blocks". KCOV uses
>>> compiler instrumentation, and a sequence of non-branching instructions
>>> denote one point of coverage; at the next branch (conditional or otherwise)
>>> it then records which branch was taken and therefore we know which code
>>> paths were covered.
>>
>> ah, got it. But can't KCOV be extended with another source of information?
>  
> Not without changing KCOV. And I think we're weary of something like
> that due to the potential for coverage explosion. -fsanitize-coverage
> has various options to capture different types of coverage actually, not
> purely basic block based coverage. (KCOV already supports
> KCOV_ENABLE_COMPARISONS, perhaps that could help somehow. It captures
> arguments of comparisons.)
> 
>>>>>
>>>>> From what I can tell this doesn't quite happen today, because
>>>>> automaton::function is a lookup table as an array.
>>>>
>>>> It is a the transition function of the formal automaton definition. Check this:
>>>>
>>>> https://bristot.me/wp-content/uploads/2020/01/JSA_preprint.pdf
>>>>
>>>> page 9.
>>>>
>>>> Could this just
>>>>> become a generated function with a switch statement? Because then I
>>>>> think we'd pretty much have all the ingredients we need.
>>>>
>>>> a switch statement that would.... call a different function for each transition?
>>>
>>> No, just a switch statement that returns the same thing as it does
>>> today. But KCOV wouldn't see different different coverage with the
>>> current version because it's all in one basic block because it looks up
>>> the next state given the current state out of the array. If it was a
>>> switch statement doing the same thing, the compiler will turn the thing
>>> into conditional branches and KCOV then knows which code path
>>> (effectively the transition) was covered.
>  
> Per Dmitry's comment, yes we need to be careful that the compiler
> doesn't collapse the switch statement somehow. But this should be
> achievable with a bunch or 'barrier()' after every 'case ...:'.

Changing the "function" will add some overhead for the runtime monitor use-case.
For example, for the safety-critical systems that will run with a monitor
enabled to detect a failure and react to it.

But! I can extend the idea of the reactor to receive the successful state
transitions or create the "observer" abstraction, to which we can attach a
generic that will make the switch statements. This function can be
auto-generated by dot2k as well...

This reactor/observer can be enabed/disabled so... we can add as much annotation
and barriers as we want.

Thoughts?

-- Daniel

