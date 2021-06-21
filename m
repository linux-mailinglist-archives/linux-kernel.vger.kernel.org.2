Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17853AE72E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 12:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFUKdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 06:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFUKdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 06:33:00 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230EEC061767
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:30:46 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b3so8769355wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 03:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lFoiBKZtD98dZmzCBxXD6R0VVGwRjhBQinGa5Vre968=;
        b=g7s0XJvLGf3ZvO9sTbpXuIX2T/CgpsQP22BJxSvAmqulLT8s+AEW5lUOKDDJsmGb5S
         OmMcDsS8ADFQjCKtGTI1JDK+qCOQtH1nsNeZ/fEpkz+LtQlJRvJQgUN1k+7jd6YyYcDg
         AEOjt3irkSB6m24cPV++KcIq5PSkYTNWGrp3G0OaXQyqTIJXV6tOCPzb06DZ502lTbbW
         TL7Kxx1Xc7z+19szc2lmjrP9W5bpTSFWRK6nmWp/Dqtp1qtqoUkWZrE5N2HUop7EosQL
         ZZU82yQQ+eZzMjhUOIAFocIyv8y0/q5p1QeItKhGEcMmAYwthZnx/YKhuapNbxzd5VD9
         icrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lFoiBKZtD98dZmzCBxXD6R0VVGwRjhBQinGa5Vre968=;
        b=mvlLQflNMpTUejSB3AbmGlJQnwPLezh3dNYpUgfekmQ3NnD1hlSaooNvwdl36WAcML
         GGrmtJI47LVcVu9+pTSDtZzxYoLO9f6GWgP9AzjwMB9/tSHn19kG2TJUkpo6db+fDrHE
         910AZanUzKZmqVZlKlzcpTsunI9A275+8RDBauW+QqcnIkmI1rZ8eX32bCKpzuh++3XT
         bQsJL25mubJxwzAonm3/hZ/BRWtYP0PRQF2XClWDOFy7gqHt19G6ymsZJR+1vH3FtDd4
         yWLf/swkMzkkgmgDdvUZCpERD6dIO9RRGbp5meUSVOHYlm7C5GvNihrmVLptM/qlf2a1
         htYA==
X-Gm-Message-State: AOAM5301DVue3wLy8mehlzQogFQURfS7+qLtQiXv0cnsvBR5lTJ3QxlZ
        56e4jh5sElnUKMuT4m8gyzg9lg==
X-Google-Smtp-Source: ABdhPJwP93zzOQ83PI1pi+x513cvCMKkWMY6HDhQ0VgS1yi2o0JEYzO0Yy67/DI/MK2k+xQhtaN/Gg==
X-Received: by 2002:a5d:65c1:: with SMTP id e1mr516081wrw.196.1624271444633;
        Mon, 21 Jun 2021 03:30:44 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:6679:9a60:529b:288d])
        by smtp.gmail.com with ESMTPSA id s16sm4764489wrm.36.2021.06.21.03.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 03:30:44 -0700 (PDT)
Date:   Mon, 21 Jun 2021 12:30:37 +0200
From:   Marco Elver <elver@google.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzkaller <syzkaller@googlegroups.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Functional Coverage via RV? (was: "Learning-based Controlled
 Concurrency Testing")
Message-ID: <YNBqTVFpvpXUbG4z@elver.google.com>
References: <20210517164411.GH4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNPbXmm9jQcquyrNGv4M4+KW_DgcrXHsgDtH=tYQ6=RU4Q@mail.gmail.com>
 <20210518204226.GR4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNN+nS1CAz=0vVdJLAr_N+zZxqp3nm5cxCCiP-SAx3uSyA@mail.gmail.com>
 <20210519185305.GC4441@paulmck-ThinkPad-P17-Gen-1>
 <CANpmjNMskihABCyNo=cK5c0vbNBP=fcUO5-ZqBJCiO4XGM47DA@mail.gmail.com>
 <CANpmjNMPvAucMQoZeLQAP_WiwiLT6XBoss=EZ4xAbrHnMwdt5g@mail.gmail.com>
 <c179dc74-662d-567f-0285-fcfce6adf0a5@redhat.com>
 <YMyC/Dy7XoxTeIWb@elver.google.com>
 <35852e24-9b19-a442-694c-42eb4b5a4387@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35852e24-9b19-a442-694c-42eb4b5a4387@redhat.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 10:23AM +0200, Daniel Bristot de Oliveira wrote:
[...]
> > Yes, unlike code/structural coverage (which is what we have today via
> > KCOV) functional coverage checks if some interesting states were reached
> > (e.g. was buffer full/empty, did we observe transition a->b etc.).
> 
> So you want to observe a given a->b transition, not that B was visited?

An a->b transition would imply that a and b were visited.

> I still need to understand what you are aiming to verify, and what is the
> approach that you would like to use to express the specifications of the systems...
> 
> Can you give me a simple example?

The older discussion started around a discussion how to get the fuzzer
into more interesting states in complex concurrent algorithms. But
otherwise I have no idea ... we were just brainstorming and got to the
point where it looked like "functional coverage" would improve automated
test generation in general. And then I found RV which pretty much can
specify "functional coverage" and almost gets that information to KCOV
"for free".
 
> so, you want to have a different function for every transition so KCOV can
> observe that?

Not a different function, just distinct "basic blocks". KCOV uses
compiler instrumentation, and a sequence of non-branching instructions
denote one point of coverage; at the next branch (conditional or otherwise)
it then records which branch was taken and therefore we know which code
paths were covered.

> > 
> > From what I can tell this doesn't quite happen today, because
> > automaton::function is a lookup table as an array.
> 
> It is a the transition function of the formal automaton definition. Check this:
> 
> https://bristot.me/wp-content/uploads/2020/01/JSA_preprint.pdf
> 
> page 9.
> 
> Could this just
> > become a generated function with a switch statement? Because then I
> > think we'd pretty much have all the ingredients we need.
> 
> a switch statement that would.... call a different function for each transition?

No, just a switch statement that returns the same thing as it does
today. But KCOV wouldn't see different different coverage with the
current version because it's all in one basic block because it looks up
the next state given the current state out of the array. If it was a
switch statement doing the same thing, the compiler will turn the thing
into conditional branches and KCOV then knows which code path
(effectively the transition) was covered.
 
> > Then:
> > 
> > 1. Create RV models for states of interests not covered by normal code
> >    coverage of code under test.
> > 
> > 2. Enable KCOV for everything.
> > 
> > 3. KCOV's coverage of the RV model will tell us if we reached the
> >    desired "functional coverage" (and can be used by e.g. syzbot to
> >    generate better tests without any additional changes because it
> >    already talks to KCOV).
> > 
> > Thoughts?
> > 
> > Thanks,
> > -- Marco
