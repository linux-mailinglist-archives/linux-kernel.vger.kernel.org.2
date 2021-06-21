Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F33C43AE51C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFUImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:42:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22621 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230316AbhFUImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624264794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T0iq4AklK07uhVNnOrMTmioBKAv5sLyv0oWUsUhB/DE=;
        b=UAe7+TfiOiqD7M/RkTaysSCQcImNjgypybvYFLK5UwvJI9sD9aE+EKTW8Tz8ok5ITMeodi
        8Gz3sxih2F/1C9MTOCtmV2RVQoX9Ve1liVQwqqq42BFLP/5dv+rgsbuzwgL/w0Eo1zFUcy
        VdrB93r+06hAa4h/u4BrZMuvx1nR2bw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-MtJzQdXMPQOGx1IuhLTWFQ-1; Mon, 21 Jun 2021 04:39:53 -0400
X-MC-Unique: MtJzQdXMPQOGx1IuhLTWFQ-1
Received: by mail-ej1-f71.google.com with SMTP id ci22-20020a170906c356b0290492ca430d87so1126551ejb.14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T0iq4AklK07uhVNnOrMTmioBKAv5sLyv0oWUsUhB/DE=;
        b=Lw8CpknZ0tERQlG0yhE6+XWFNNh6fTBaFYMV5k8q5xzfUghqIMJhGLvrr/0t4/mlAi
         eLEJlK8mJBf/VQX492s7cqI4l0ljfq/qQ7xPVH8QhLxum3PYZr2xWYv46Ysyxw6nsNhL
         9lQ6fMbHu5bY9enqbtzdYDE0hoOmmwFFp9wRcSJ0u6N9ctzp9Rn0m4+J7qeSEtqfuvsl
         mjZqzi5zSm1SXAJANBb3n9SqfDT1krVWPqbi1ftVndfm82opM/mDh74cVYCDPT/tSA4n
         UjwcHKoa9YzVHxeefqb/tRNToygchjIvvgpRNpxa7okyg96+k/QZL+u1qlnVfAmqs01d
         oR8A==
X-Gm-Message-State: AOAM531iX2VkrO0zFKtH7Dbe/bjLho7ZxE/Qse4kMQWV4mWsP+mQmLF8
        r3BdONXBiY3/Hm6zyaYIAelTvFvp4bToy7JG41uSOrbpovLcwiDIdm/eAw4g5vO5IOCoc430Ix8
        9KgvZjpEmF6axV1HyIiJAkdPOvvq8hhmjQEm4ujmJeDUio4tdFWG2KnYQOsKJXFNNjAEmBGYZzv
        k=
X-Received: by 2002:a05:6402:1d08:: with SMTP id dg8mr1137910edb.299.1624264792135;
        Mon, 21 Jun 2021 01:39:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzL4BRPmi/k3ppzm6zt9UyBZnXu9jbGJwSztg+T3o1X3OKQ1sgodX3V0NvlI2Y9gXUVydyWXg==
X-Received: by 2002:a05:6402:1d08:: with SMTP id dg8mr1137889edb.299.1624264791917;
        Mon, 21 Jun 2021 01:39:51 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id qq26sm4466948ejb.6.2021.06.21.01.39.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 01:39:51 -0700 (PDT)
Subject: Re: Functional Coverage via RV? (was: "Learning-based Controlled
 Concurrency Testing")
To:     Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
 <c179dc74-662d-567f-0285-fcfce6adf0a5@redhat.com>
 <YMyC/Dy7XoxTeIWb@elver.google.com>
 <CACT4Y+YTh=ND_cshGyVi98KiY=pkg3WKrpE__Cn+K0Wgmuyv+w@mail.gmail.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <8069d809-b133-edbf-4323-45c45a1c3c9d@redhat.com>
Date:   Mon, 21 Jun 2021 10:39:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YTh=ND_cshGyVi98KiY=pkg3WKrpE__Cn+K0Wgmuyv+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/21 1:08 PM, Dmitry Vyukov wrote:
> On Fri, Jun 18, 2021 at 1:26 PM Marco Elver <elver@google.com> wrote:
>>
>> On Fri, Jun 18, 2021 at 09:58AM +0200, Daniel Bristot de Oliveira wrote:
>>> On 6/17/21 1:20 PM, Marco Elver wrote:
>>>> [+Daniel, just FYI. We had a discussion about "functional coverage"
>>>> and fuzzing, and I've just seen your wonderful work on RV. If you have
>>>> thought about fuzzing with RV and how coverage of the model impacts
>>>> test generation, I'd be curious to hear.]
>>>
>>> One aspect of RV is that we verify the actual execution of the system instead of
>>> a complete model of the system, so we depend of the testing to cover all the
>>> aspects of the system <-> model.
>>>
>>> There is a natural relation with testing/fuzzing & friends with RV.
>>>
>>>> Looks like there is ongoing work on specifying models and running them
>>>> along with the kernel: https://lwn.net/Articles/857862/
>>>>
>>>> Those models that are run alongside the kernel would have their own
>>>> coverage, and since there's a mapping between real code and model, a
>>>> fuzzer trying to reach new code in one or the other will ultimately
>>>> improve coverage for both.
>>>
>>> Perfect!
>>>
>>>> Just wanted to document this here, because it seems quite relevant.
>>>> I'm guessing that "functional coverage" would indeed be a side-effect
>>>> of a good RV model?
>>>
>>> So, let me see if I understood the terms. Functional coverage is a way to check
>>> if all the desired aspects of a code/system/subsystem/functionality were covered
>>> by a set of tests?
>>
>> Yes, unlike code/structural coverage (which is what we have today via
>> KCOV) functional coverage checks if some interesting states were reached
>> (e.g. was buffer full/empty, did we observe transition a->b etc.).
>>
>> Functional coverage is common in hardware verification, but of course
>> software verification would benefit just as much -- just haven't seen it
>> used much in practice yet.
>> [ Example for HW verification: https://www.chipverify.com/systemverilog/systemverilog-functional-coverage ]
>>
>> It still requires some creativity from the designer/developer to come up
>> with suitable functional coverage. State explosion is a problem, too,
>> and naturally it is impractical to capture all possible states ... after
>> all, functional coverage is meant to direct the test generator/fuzzer
>> into more interesting states -- we're not doing model checking after all.
>>
>>> If that is correct, we could use RV to:
>>>
>>>  - create an explicit model of the states we want to cover.
>>>  - check if all the desired states were visited during testing.
>>>
>>> ?
>>
>> Yes, pretty much. On one hand there could be an interface to query if
>> all states were covered, but I think this isn't useful out-of-the box.
>> Instead, I was thinking we can simply get KCOV to help us out: my
>> hypothesis is that most of this would happen automatically if dot2k's
>> generated code has distinct code paths per transition.
>>
>> If KCOV covers the RV model (since it's executable kernel C code), then
>> having distinct code paths for "state transitions" will effectively give
>> us functional coverage indirectly through code coverage (via KCOV) of
>> the RV model.
>>
>> From what I can tell this doesn't quite happen today, because
>> automaton::function is a lookup table as an array. Could this just
>> become a generated function with a switch statement? Because then I
>> think we'd pretty much have all the ingredients we need.
>>
>> Then:
>>
>> 1. Create RV models for states of interests not covered by normal code
>>    coverage of code under test.
>>
>> 2. Enable KCOV for everything.
>>
>> 3. KCOV's coverage of the RV model will tell us if we reached the
>>    desired "functional coverage" (and can be used by e.g. syzbot to
>>    generate better tests without any additional changes because it
>>    already talks to KCOV).
>>
>> Thoughts?
> 
> I think there is usually already some code for any important state
> transitions. E.g. I can't imagine how a socket can transition to
> active/listen/shutdown/closed states w/o any code.

makes sense...

> I see RV to be potentially more useful for the "coverage dimensions"
> idea. I.e. for sockets that would be treating coverage for a socket
> function X as different coverage based on the current socket state,
> effectively consider (PC,state) as feedback signal.

How can RV subsystem talk with KCOV?

> But my concern is that we don't want to simply consider combinations
> of all kernel code multiplied by all combinations of states of all RV
> models.

I agree! Also because RV monitors will generally monitor an specific part of the
code (with exceptions for models like the preemption one).

Most likely this will lead to severe feedback signal
> explosion.So the question is: how do we understand that the socket
> model relates only to this restricted set of code?
> 

Should we annotate a model, saying which subsystem it monitors/verify?

-- Daniel

