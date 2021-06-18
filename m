Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1CA3AC58D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbhFRIBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232455AbhFRIBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624003143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QB7KMugTullHRvmV8LmfWYhXRlkrxyob1yW5wSk8lIc=;
        b=HiwVAQbfIrqrCb9qynJifuAlJkzQMQdxmU1x+Zv2MPQoTGwIyb86mSB2Yt04628DGaYwFk
        4+An3w01x8gr9Ed7YuB+FQZApXwd5YVjlz982owY9O7THk4bYDXsFumKdewiBpP1xKkVE1
        Fkc5qSQYxI+5YuaBNcAPqT0QRGCgzsQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-YRRurwiMOEiuRGj6iNzicA-1; Fri, 18 Jun 2021 03:59:01 -0400
X-MC-Unique: YRRurwiMOEiuRGj6iNzicA-1
Received: by mail-ed1-f70.google.com with SMTP id y16-20020a0564024410b0290394293f6816so3076171eda.20
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 00:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QB7KMugTullHRvmV8LmfWYhXRlkrxyob1yW5wSk8lIc=;
        b=nUoLGkCubKV86RGwohDF/klEqydlX4A3PCJpwEPhm+oUoRu0ISWvzjZ+QE0Gy30V+0
         pXVVyUb/0vwUyvStA7HRnbNOkLlhPncQ9UUS78qZnby7JKO32WRA8GwT2nZ6VAqLDyQ7
         zLZhdgZdZfqlRI+Ifb3GXNrOMJ5xV0eUpQL7T2odVxzOHo3vVXB6hAZadO5BXigBNswi
         DJAWsopWLguDwACQ1If9L+TViIDeuHqkj/DB4kUtRyTb2KoELTolQZplozPZA+vtLJg9
         Q8tDP0mj8gxvTJTETBRHExTc6kGYjBrmrASKHuqr0kqLYoZlWLA65BDe0uTlJK36RF36
         TEiw==
X-Gm-Message-State: AOAM5338ksAqThxpFgwg39Zgxv3G4PqkmnrIvKeS2Dh6r1bP3sE0QrSI
        0LwY4QwBch8RZpNHc0vvdaLeph8ALHDGhpnwzfzfYafqKKN9dkQ5gxRVT4BQ2qBxkzhLfg7tDU1
        em7PIkm1aGJxPwQnrep3mK6+S0BBVR3lcnoazRqfdTzSYCTIL2joXVhMhSAA/+JdfF1EfP/V0JB
        U=
X-Received: by 2002:a05:6402:1907:: with SMTP id e7mr2816209edz.186.1624003140331;
        Fri, 18 Jun 2021 00:59:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCjAhFJ44rzAMXFrOKVFCyFfd/HZ3Qq7IMdWRz77kXqru5K3Yu46yzxF/xMZ9n36K3MOJvSA==
X-Received: by 2002:a05:6402:1907:: with SMTP id e7mr2816173edz.186.1624003139926;
        Fri, 18 Jun 2021 00:58:59 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id c19sm5756050edw.10.2021.06.18.00.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 00:58:59 -0700 (PDT)
Subject: Re: Functional Coverage via RV? (was: "Learning-based Controlled
 Concurrency Testing")
To:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210512181836.GA3445257@paulmck-ThinkPad-P17-Gen-1>
 <CACT4Y+Z+7qPaanHNQc4nZ-mCfbqm8B0uiG7OtsgdB34ER-vDYA@mail.gmail.com>
 <20210517164411.GH4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNPbXmm9jQcquyrNGv4M4+KW_DgcrXHsgDtH=tYQ6=RU4Q@mail.gmail.com>
 <20210518204226.GR4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNN+nS1CAz=0vVdJLAr_N+zZxqp3nm5cxCCiP-SAx3uSyA@mail.gmail.com>
 <20210519185305.GC4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNMskihABCyNo=cK5c0vbNBP=fcUO5-ZqBJCiO4XGM47DA@mail.gmail.com>
 <CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss=EZ4xAbrHnMwdt5g@mail.gmail.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <c179dc74-662d-567f-0285-fcfce6adf0a5@redhat.com>
Date:   Fri, 18 Jun 2021 09:58:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss=EZ4xAbrHnMwdt5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/21 1:20 PM, Marco Elver wrote:
> [+Daniel, just FYI. We had a discussion about "functional coverage"
> and fuzzing, and I've just seen your wonderful work on RV. If you have
> thought about fuzzing with RV and how coverage of the model impacts
> test generation, I'd be curious to hear.]

One aspect of RV is that we verify the actual execution of the system instead of
a complete model of the system, so we depend of the testing to cover all the
aspects of the system <-> model.

There is a natural relation with testing/fuzzing & friends with RV.

> Looks like there is ongoing work on specifying models and running them
> along with the kernel: https://lwn.net/Articles/857862/
> 
> Those models that are run alongside the kernel would have their own
> coverage, and since there's a mapping between real code and model, a
> fuzzer trying to reach new code in one or the other will ultimately
> improve coverage for both.

Perfect!

> Just wanted to document this here, because it seems quite relevant.
> I'm guessing that "functional coverage" would indeed be a side-effect
> of a good RV model?

So, let me see if I understood the terms. Functional coverage is a way to check
if all the desired aspects of a code/system/subsystem/functionality were covered
by a set of tests?

If that is correct, we could use RV to:

 - create an explicit model of the states we want to cover.
 - check if all the desired states were visited during testing.

?

-- Daniel

> Previous discussion below.
> 
> Thanks,
> -- Marco
> 
> On Wed, 19 May 2021 at 22:24, Marco Elver <elver@google.com> wrote:
>> On Wed, 19 May 2021 at 20:53, Paul E. McKenney <paulmck@kernel.org> wrote:
>>> On Wed, May 19, 2021 at 11:02:43AM +0200, Marco Elver wrote:
>>>> On Tue, 18 May 2021 at 22:42, Paul E. McKenney <paulmck@kernel.org> wrote:
>>>> [...]
>>>>>> All the above sound like "functional coverage" to me, and could be
>>>>>> implemented on top of a well-thought-out functional coverage API.
>>>>>> Functional coverage is common in the hardware verification space to
>>>>>> drive simulation and model checking; for example, functional coverage
>>>>>> could be "buffer is full" vs just structural (code) coverage which
>>>>>> cannot capture complex state properties like that easily.
>>>>>>
>>>>>> Similarly, you could then say things like "number of held locks" or
>>>>>> even alluding to your example (5) above, "observed race on address
>>>>>> range". In the end, with decent functional coverage abstractions,
>>>>>> anything should hopefully be possible.
>>>>>
>>>>> Those were in fact the lines along which I was thinking.
>>>>>
>>>>>> I've been wondering if this could be something useful for the Linux
>>>>>> kernel, but my guess has always been that it'd not be too-well
>>>>>> received because people don't like to see strange annotations in their
>>>>>> code. But maybe I'm wrong.
>>>>>
>>>>> I agree that it is much easier to get people to use a tool that does not
>>>>> require annotations.  In fact, it is best if it requires nothing at all
>>>>> from them...
>>>>
>>>> While I'd like to see something like that, because it'd be beneficial
>>>> to see properties of the code written down to document its behaviour
>>>> better and at the same time machine checkable, like you say, if it
>>>> requires additional effort, it's a difficult sell. (Although the same
>>>> is true for all other efforts to improve reliability that require a
>>>> departure from the "way it used to be done", be it data_race(), or
>>>> even efforts introducing whole new programming languages to the
>>>> kernel.)
>>>
>>> Fair point!  But what exactly did you have in mind?
>>
>> Good question, I'll try to be more concrete -- most of it are
>> half-baked ideas and questions ;-), but if any of it makes sense, I
>> should maybe write a doc to summarize.
>>
>> What I had in mind is a system to write properties for both functional
>> coverage, but also checking more general properties of the kernel. The
>> latter I'm not sure about how useful. But all this isn't really used
>> for anything other than in debug builds.
>>
>> Assume we start with macros such as "ASSERT_COVER(...)" (for
>> functional coverage) and "ASSERT(...)" (just plain-old assertions).
>> The former is a way to document potentially interesting states (useful
>> for fuzzers to reach them), and the latter just a way to just specify
>> properties of the system (useful for finding the actual bugs).
>> Implementation-wise the latter is trivial, the former requires some
>> thought on how to expose that information to fuzzers and how to use
>> (as Dmitry suggested it's not trivial). I'd also imagine we can have
>> module-level variants ("GLOBAL_ASSERT*(...)") that monitor some global
>> state, and also add support for some subset of temporal properties
>> like "GLOBAL_ASSERT_EVENTUALLY(precond, eventually_holds)" as
>> suggested below.
>>
>> I guess maybe I'd have to take a step back and just ask why we have no
>> way to write plain and simple assertions that are removed in non-debug
>> builds? Some subsystems seem to roll their own, which a 'git grep
>> "#define ASSERT"' tells me.
>>
>> Is there a fundamental reason why we shouldn't have them, perhaps
>> there was some past discussion? Today we have things like
>> lockdep_assert_held(), but nothing to even write a simple assert
>> otherwise. If I had to guess why something like ASSERT is bad, it is
>> because it gives people a way to check for unexpected conditions, but
>> if those checks disappear in non-debug builds, the kernel might be
>> unstable. Therefore every possible state must be handled and we must
>> always be able to recover. The argument in favor is, if the ASSERT()s
>> are proven invariants or conditions where we'd recover either way, and
>> are only there to catch accidental regressions during testing; and in
>> non-debug builds we don't suffer the performance overheads.
> ..
>>>>>> My ideal abstractions I've been thinking of isn't just for coverage,
>>>>>> but to also capture temporal properties (which should be inspired by
>>>>>> something like LTL or such), on top of which you can also build
>>>>>> coverage. Then we can specify things like "if I observe some state X,
>>>>>> then eventually we observe state Y", and such logic can also just be
>>>>>> used to define functional coverage of interest (again all this
>>>>>> inspired by what's already done in hardware verification).
>>>>>
>>>>> Promela/spin provides an LTL interface, but of course cannot handle
>>>>> much of RCU, let alone of the entire kernel.  And LTL can be quite
>>>>> useful.  But in a runtime system, how do you decide when "eventually"
>>>>> has arrived?  The lockdep system does so by tracking entry to idle
>>>>> and to userspace execution, along with exit from interrupt handlers.
>>>>> Or did you have something else in mind?
>>>>
>>>> For coverage, one could simply await the transition to the "eventually
>>>> state" indefinitely; once reached we have coverage.
>>>>
>>>> But for verification, because unlike explicit state model checkers
>>>> like Spin, we don't have the complete state and can't build an
>>>> exhaustive state-graph, we'd have to approximate. And without knowing
>>>> exactly what it is we're waiting for, the simplest option would be to
>>>> just rely on a timeout, either part of the property or implicit. What
>>>> the units of that timeout are I'm not sure, because a system might
>>>> e.g. be put to sleep.
> 

