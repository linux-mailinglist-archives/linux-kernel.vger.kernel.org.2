Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB2539C365
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 00:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhFDWWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 18:22:33 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38829 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhFDWWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 18:22:31 -0400
Received: by mail-lj1-f170.google.com with SMTP id a4so13465201ljd.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 15:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9zFBMvnldr+a2Bn098Bq6btluKTz9/gtI3L8L3G704=;
        b=ON4ziKiRp5LVq4JfVNVftECbm0Jxb1CFgpD63zSOqLcI1y/jw+2eSrTArKHg8kOxFi
         GJfAJLgbireiKAUxlonVH76df7ajATcwEE9AfwbclT3V9zSZ/V5X7fjdpTaZk9/8XbmN
         dZdg+6BU30M/38YSvOFl4iwDOiyXpBw10D2dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9zFBMvnldr+a2Bn098Bq6btluKTz9/gtI3L8L3G704=;
        b=CZU1VgL3goajdBg4FHBbVvnq3Ol2HHdlsNLFXLpe99Br0AwMeGbg1XT1bLMBXNW/xy
         4+8WiRFP809Id8AZF48DttZo7yp75Xs357bDrPl40e9CpYWm6Um/WLzzl6UGAfX0mRxv
         qYBg+YMkiQw4jWRN9g+Jo8QjsTlGG/GHRkKIGq3CF5wOn7SIY1mg7u4I8fsT6INQ5tKq
         h24yFfmeZZ8LN8Y3eCLeSuL2eoZvYgZM6SFgHySAXsidHTXRwhg0H7C5cAVzV9Yp5HLW
         TqKWR15S7u7P8v1tKL4K3Y5K6fU32fXV2dv7UbjpultMKQV3TVx62GgPTg6MogzMm1bj
         j9hw==
X-Gm-Message-State: AOAM530WfFJX4KgmAGP13vVUUsD13tA9sEfYUfdjcS1a+IMokMvAVEDj
        NEly14nEjsCrCo7lhh1m98yfbbjpWHAXLKTawXk=
X-Google-Smtp-Source: ABdhPJyOsUz+18w+njDVesf5qUwFCx5F5SMYO24lLObuE5y9b5wfJCr37O1eta2IwJWRlQZO+Mys1A==
X-Received: by 2002:a2e:2f09:: with SMTP id v9mr4918367ljv.152.1622845168599;
        Fri, 04 Jun 2021 15:19:28 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q19sm718172lff.281.2021.06.04.15.19.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 15:19:27 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id u22so13433558ljh.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 15:19:27 -0700 (PDT)
X-Received: by 2002:a2e:b60d:: with SMTP id r13mr5244550ljn.220.1622845167131;
 Fri, 04 Jun 2021 15:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210604151356.GC2793@willie-the-truck> <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
 <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net> <20210604155154.GG1676809@rowland.harvard.edu>
 <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net> <20210604182708.GB1688170@rowland.harvard.edu>
 <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jun 2021 15:19:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
Message-ID: <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 4, 2021 at 2:40 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Here is one use case:
>
>         volatile_if(READ_ONCE(A)) {
>                 WRITE_ONCE(B, 1);
>                 do_something();
>         } else {
>                 WRITE_ONCE(B, 1);
>                 do_something_else();
>         }
>
> With plain "if", the compiler is within its rights to do this:
>
>         tmp = READ_ONCE(A);
>         WRITE_ONCE(B, 1);
>         if (tmp)
>                 do_something();
>         else
>                 do_something_else();
>
> On x86, still no problem.  But weaker hardware could now reorder the
> store to B before the load from A.  With volatile_if(), this reordering
> would be prevented.

But *should* it be prevented? For code like the above?

I'm not really seeing that the above is a valid code sequence.

Sure, that "WRITE_ONCE(B, 1)" could be seen as a lock release, and
then it would be wrong to have the read of 'A' happen after the lock
has actually been released. But if that's the case, then it should
have used a smp_store_release() in the first place, not a
WRITE_ONCE().

So I don't see the above as much of a valid example of actual
READ/WRITE_ONCE() use.

If people use READ/WRITE_ONCE() like the above, and they actually
depend on that kind of ordering, I think that code is likely wrong to
begin with. Using "volatile_if()" doesn't make it more valid.

Now, part of this is that I do think that in *general* we should never
use this very suble load-cond-store pattern to begin with. We should
strive to use more smp_load_acquire() and smp_store_release() if we
care about ordering of accesses. They are typically cheap enough, and
if there's much of an ordering issue, they are the right things to do.

I think the whole "load-to-store ordering" subtle non-ordered case is
for very very special cases, when you literally don't have a general
memory ordering, you just have an ordering for *one* very particular
access. Like some of the very magical code in the rw-semaphore case,
or that smp_cond_load_acquire().

IOW, I would expect that we have a handful of uses of this thing. And
none of them have that "the conditional store is the same on both
sides" pattern, afaik.

And immediately when the conditional store is different, you end up
having a dependency on it that orders it.

But I guess I can accept the above made-up example as an "argument",
even though I feel it is entirely irrelevant to the actual issues and
uses we have.

               Linus
