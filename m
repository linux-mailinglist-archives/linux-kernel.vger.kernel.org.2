Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91A13AE4BA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 10:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhFUI0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 04:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30923 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229641AbhFUI0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 04:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624263838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2eRyDqU+eiRM4S6L16jfahmN9VAWzXoQKsX2LAlqcH8=;
        b=cxu9Ny+zSw5s55mw825uvU5ZLrYCKUnaB8U7HVB6/TCrneQUjpsecXamMmKP5tvv3j6tT6
        2VRDONmmhajkyrisWmHeONnfKsYU+Gum+LlVWbhLXu4UgqlL/EtRfzCaomSqGXzhlHZNGl
        32NNh38hU63eeZysDVBWnZV8HszocbU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-zd-O4IpeM9KvV92qJYcD8g-1; Mon, 21 Jun 2021 04:23:57 -0400
X-MC-Unique: zd-O4IpeM9KvV92qJYcD8g-1
Received: by mail-ej1-f70.google.com with SMTP id f8-20020a1709064dc8b02904996ccd94c0so839251ejw.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 01:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2eRyDqU+eiRM4S6L16jfahmN9VAWzXoQKsX2LAlqcH8=;
        b=uDkXlEahMw0u5LmH+r0Mjyqq7Tw0ROsR9XGoL7nbK1j9v2lUzZU6abJ3YKFkBJec0X
         ZhVn/IvE9FoQ4nGqjniuRDZUSbh6Vhod+lSwvR9V6eale8BZX5NhdqAVGjjnuZyRQWo8
         aGZL8sDYIm0nQ7rsXvfeVqiW0vVT4LOI5NE3U9sEYoABUITW5QUvep4pP9LTtmnRBhq2
         9QUjY4iANwzhRue6ZL/Uldo5ZOCHTRAl2T6rCvLDKLZ+cuEZaDnfVd4IW8m3rVuC+Ptx
         TWYMijMoHsq5bVjORMKpl40FaeRcZXI+x9PKHMCYAgJBSioPaGAtWCnrEUU2Enrzo2jW
         M3Xw==
X-Gm-Message-State: AOAM532ISUZYOiPqx9T/dqdml1kVouwyTRGiO6GqHsTcN/igm54yCJXi
        uzZvccd2se1mPIFIC0awB8kadhi0PxFkWEhdTgIb1OsrUbjQ3rELjFVSjQbpHceUMTPpLfw+c1+
        cYFRV2i2KppzJgmIqCYNM9+rvOkxQqbs4FCDzFf5G9xjqx5haV7KvoicpFCn053PUTpguHm/jnX
        c=
X-Received: by 2002:a17:907:3e88:: with SMTP id hs8mr1561486ejc.96.1624263835818;
        Mon, 21 Jun 2021 01:23:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyW8j09+OIYlsqes/N+x98AFc0mm0eToC6c0GATiL3DTRrzRjEmJfvjNuCb6cFoP5/sbixe7Q==
X-Received: by 2002:a17:907:3e88:: with SMTP id hs8mr1561472ejc.96.1624263835573;
        Mon, 21 Jun 2021 01:23:55 -0700 (PDT)
Received: from x1.bristot.me (host-79-23-205-114.retail.telecomitalia.it. [79.23.205.114])
        by smtp.gmail.com with ESMTPSA id b14sm4434036ejk.120.2021.06.21.01.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jun 2021 01:23:55 -0700 (PDT)
Subject: Re: Functional Coverage via RV? (was: "Learning-based Controlled
 Concurrency Testing")
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
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
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
Message-ID: <35852e24-9b19-a442-694c-42eb4b5a4387@redhat.com>
Date:   Mon, 21 Jun 2021 10:23:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMyC/Dy7XoxTeIWb@elver.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/21 1:26 PM, Marco Elver wrote:
> On Fri, Jun 18, 2021 at 09:58AM +0200, Daniel Bristot de Oliveira wrote:
>> On 6/17/21 1:20 PM, Marco Elver wrote:
>>> [+Daniel, just FYI. We had a discussion about "functional coverage"
>>> and fuzzing, and I've just seen your wonderful work on RV. If you have
>>> thought about fuzzing with RV and how coverage of the model impacts
>>> test generation, I'd be curious to hear.]
>>
>> One aspect of RV is that we verify the actual execution of the system instead of
>> a complete model of the system, so we depend of the testing to cover all the
>> aspects of the system <-> model.
>>
>> There is a natural relation with testing/fuzzing & friends with RV.
>>
>>> Looks like there is ongoing work on specifying models and running them
>>> along with the kernel: https://lwn.net/Articles/857862/
>>>
>>> Those models that are run alongside the kernel would have their own
>>> coverage, and since there's a mapping between real code and model, a
>>> fuzzer trying to reach new code in one or the other will ultimately
>>> improve coverage for both.
>>
>> Perfect!
>>
>>> Just wanted to document this here, because it seems quite relevant.
>>> I'm guessing that "functional coverage" would indeed be a side-effect
>>> of a good RV model?
>>
>> So, let me see if I understood the terms. Functional coverage is a way to check
>> if all the desired aspects of a code/system/subsystem/functionality were covered
>> by a set of tests?
> 
> Yes, unlike code/structural coverage (which is what we have today via
> KCOV) functional coverage checks if some interesting states were reached
> (e.g. was buffer full/empty, did we observe transition a->b etc.).

So you want to observe a given a->b transition, not that B was visited?

> Functional coverage is common in hardware verification, but of course
> software verification would benefit just as much -- just haven't seen it
> used much in practice yet.
> [ Example for HW verification: https://www.chipverify.com/systemverilog/systemverilog-functional-coverage ]
> 
> It still requires some creativity from the designer/developer to come up
> with suitable functional coverage.

That is where the fun lives.

State explosion is a problem, too,
> and naturally it is impractical to capture all possible states ... after
> all, functional coverage is meant to direct the test generator/fuzzer
> into more interesting states -- we're not doing model checking after all.


I still need to understand what you are aiming to verify, and what is the
approach that you would like to use to express the specifications of the systems...

Can you give me a simple example?

>> If that is correct, we could use RV to:
>>
>>  - create an explicit model of the states we want to cover.
>>  - check if all the desired states were visited during testing.
>>
>> ?
> 
> Yes, pretty much. On one hand there could be an interface to query if
> all states were covered, but I think this isn't useful out-of-the box.
> Instead, I was thinking we can simply get KCOV to help us out: my
> hypothesis is that most of this would happen automatically if dot2k's
> generated code has distinct code paths per transition.

...

> 
> If KCOV covers the RV model (since it's executable kernel C code), then
> having distinct code paths for "state transitions" will effectively give
> us functional coverage indirectly through code coverage (via KCOV) of
> the RV model.

so, you want to have a different function for every transition so KCOV can
observe that?

> 
> From what I can tell this doesn't quite happen today, because
> automaton::function is a lookup table as an array.

It is a the transition function of the formal automaton definition. Check this:

https://bristot.me/wp-content/uploads/2020/01/JSA_preprint.pdf

page 9.

Could this just
> become a generated function with a switch statement? Because then I
> think we'd pretty much have all the ingredients we need.

a switch statement that would.... call a different function for each transition?

> Then:
> 
> 1. Create RV models for states of interests not covered by normal code
>    coverage of code under test.
> 
> 2. Enable KCOV for everything.
> 
> 3. KCOV's coverage of the RV model will tell us if we reached the
>    desired "functional coverage" (and can be used by e.g. syzbot to
>    generate better tests without any additional changes because it
>    already talks to KCOV).
> 
> Thoughts?
> 
> Thanks,
> -- Marco
> 

