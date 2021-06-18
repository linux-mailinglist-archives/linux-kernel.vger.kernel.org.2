Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057073AC9D2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbhFRL3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbhFRL3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:29:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88F3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:26:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so5557099wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FoipwiSu6RMmejDEuQLuWgfq8PcsSlF81vDlDxsZQGA=;
        b=KnMwd1ATmLVv4hVW/7GD2G0aljq9d1OapnYv0zZhKz3FTakuD2en7c+bY+F4a1OLH2
         go40bc70ksFQZ4FTh7x/ue5eOZhTRFg6BXan1wraI5HMNfvc5Rlkt5wFgLx7d8Uvfvcp
         oaThIn1c10DnsNJIud12nZqJLWhy/ZKkIH91SybS/quFYG8honVwFx3Ve6Kkb64lUn35
         l2G8Xc3Dh4LT1MtCGF9nFTI2Dd/g7BSX8C+4ZTzi8E/pHG9igAE27d4QP89ZShnOt0rn
         vRIbyL2wBW2JWlUcQ+2X1wG3yI+/wKUBMkJn3QO19rOlOR7HHr1Qb0Y7UqwpW1FPkbyW
         +mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FoipwiSu6RMmejDEuQLuWgfq8PcsSlF81vDlDxsZQGA=;
        b=MY54PzVHpD8NwXNzekh1VRVn2FV6cEdaosLeukBfeVWmcBzzodmHdFbWDM9Ymkm15E
         lL29WMi3wk0Qs3u67SMq2za3fybuS+6HiNXRHe5/y9GAegJA0gn7hXt+H4g1g2+eelOj
         tcsHa7nwH1G0NonySIcDYQKKzSdIzJJVAqWtVe2PpSJf3VAjqwuG8Bqx+en18uKAtjDa
         ZLLOaXHubzso6+ZetWRykhh/tDXhkMpDwBcOKsZ0WfOgCTwsXkBLsEtlnYRJjW54822g
         3nI6SPBnUzKolxkNvm/YjHx9yZhcdqVlLvIQ6ULI/VSbjT/ORVfwP33xnxIRQitDkJto
         h5Ng==
X-Gm-Message-State: AOAM530cNlo/9l7gwy0x/zmKviWKsh/EVq88OTv7eGEgLzWMjd9uWvQd
        EA4gjBBKV0iTzk48AmC3qYQCgg==
X-Google-Smtp-Source: ABdhPJxMdM+M2d9Y9bKTjNn2KTRW5Xbkhd3MKfZLfxPdW26Nny/FtH5YdWIofR85q6OI4KeMY7ejzA==
X-Received: by 2002:a1c:4d0d:: with SMTP id o13mr11083791wmh.59.1624015618201;
        Fri, 18 Jun 2021 04:26:58 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:f927:d21d:7ac:d122])
        by smtp.gmail.com with ESMTPSA id k16sm7381882wmr.42.2021.06.18.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 04:26:57 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:26:52 +0200
From:   Marco Elver <elver@google.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Functional Coverage via RV? (was: "Learning-based Controlled
 Concurrency Testing")
Message-ID: <YMyC/Dy7XoxTeIWb@elver.google.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c179dc74-662d-567f-0285-fcfce6adf0a5@redhat.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 09:58AM +0200, Daniel Bristot de Oliveira wrote:
> On 6/17/21 1:20 PM, Marco Elver wrote:
> > [+Daniel, just FYI. We had a discussion about "functional coverage"
> > and fuzzing, and I've just seen your wonderful work on RV. If you have
> > thought about fuzzing with RV and how coverage of the model impacts
> > test generation, I'd be curious to hear.]
> 
> One aspect of RV is that we verify the actual execution of the system instead of
> a complete model of the system, so we depend of the testing to cover all the
> aspects of the system <-> model.
> 
> There is a natural relation with testing/fuzzing & friends with RV.
> 
> > Looks like there is ongoing work on specifying models and running them
> > along with the kernel: https://lwn.net/Articles/857862/
> > 
> > Those models that are run alongside the kernel would have their own
> > coverage, and since there's a mapping between real code and model, a
> > fuzzer trying to reach new code in one or the other will ultimately
> > improve coverage for both.
> 
> Perfect!
> 
> > Just wanted to document this here, because it seems quite relevant.
> > I'm guessing that "functional coverage" would indeed be a side-effect
> > of a good RV model?
> 
> So, let me see if I understood the terms. Functional coverage is a way to check
> if all the desired aspects of a code/system/subsystem/functionality were covered
> by a set of tests?

Yes, unlike code/structural coverage (which is what we have today via
KCOV) functional coverage checks if some interesting states were reached
(e.g. was buffer full/empty, did we observe transition a->b etc.).

Functional coverage is common in hardware verification, but of course
software verification would benefit just as much -- just haven't seen it
used much in practice yet.
[ Example for HW verification: https://www.chipverify.com/systemverilog/systemverilog-functional-coverage ]

It still requires some creativity from the designer/developer to come up
with suitable functional coverage. State explosion is a problem, too,
and naturally it is impractical to capture all possible states ... after
all, functional coverage is meant to direct the test generator/fuzzer
into more interesting states -- we're not doing model checking after all.

> If that is correct, we could use RV to:
> 
>  - create an explicit model of the states we want to cover.
>  - check if all the desired states were visited during testing.
> 
> ?

Yes, pretty much. On one hand there could be an interface to query if
all states were covered, but I think this isn't useful out-of-the box.
Instead, I was thinking we can simply get KCOV to help us out: my
hypothesis is that most of this would happen automatically if dot2k's
generated code has distinct code paths per transition.

If KCOV covers the RV model (since it's executable kernel C code), then
having distinct code paths for "state transitions" will effectively give
us functional coverage indirectly through code coverage (via KCOV) of
the RV model.

From what I can tell this doesn't quite happen today, because
automaton::function is a lookup table as an array. Could this just
become a generated function with a switch statement? Because then I
think we'd pretty much have all the ingredients we need.

Then:

1. Create RV models for states of interests not covered by normal code
   coverage of code under test.

2. Enable KCOV for everything.

3. KCOV's coverage of the RV model will tell us if we reached the
   desired "functional coverage" (and can be used by e.g. syzbot to
   generate better tests without any additional changes because it
   already talks to KCOV).

Thoughts?

Thanks,
-- Marco
