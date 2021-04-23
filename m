Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C24369AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 21:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhDWTgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 15:36:22 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:39844 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbhDWTgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 15:36:20 -0400
Received: by mail-ed1-f52.google.com with SMTP id g17so57970640edm.6;
        Fri, 23 Apr 2021 12:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIuJQ0zh3viNBczyKYB2fhbiaLgRnT4n+rCK9rNkZDg=;
        b=Lvij315qTLu+zaugScYy2mPiJHWmwor5ZoRxZYQA5kziMLFKMunKgUXr7ygOyLfgtd
         eLHC5cJvedMuCurdNIw/9PteWJr30r7I5/CLluCOuFvGhDZ7TEMxL+/Z5+xyK0dsI366
         wP8CdVzi7uJcvaR7tc+uVOu6HGIvALAGx84TB/Pne8fWIwrUAJqxg0D4HwnTiilijFNr
         /jB02rNLeKJfukhGELXMWoz4s8+D+krf/P4JqHEzHr6w+OyIg4y837r6OrBJwomuBvdD
         Jix/ZSks2ZJGxv47DwnNFaXeJlvkt3UHqOg7xNGm0KxOFPEV2V4ieu0YsY26CnViKpbd
         vrNQ==
X-Gm-Message-State: AOAM53090L9LquUoUYDnIDb9lA0FvIG0+dU5E0bn2o2nANyhFLUF1c2Y
        qg9a8sNkmOd5qSK0YFoHjdCMPkL6TbBNBq5PQxk=
X-Google-Smtp-Source: ABdhPJygyn0q4rDisgKpgzZFbtCvXd00pA1BEv3Q+3EXywkGito2udfG1uByIxVRDVqVz7/aaTjEUBHW7xWXzh4iJJs=
X-Received: by 2002:aa7:d1ce:: with SMTP id g14mr6325912edp.122.1619206543054;
 Fri, 23 Apr 2021 12:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210414095804.GB10709@zn.tnic> <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
 <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic>
In-Reply-To: <20210419215809.GJ9093@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Fri, 23 Apr 2021 15:35:30 -0400
Message-ID: <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Borislav Petkov <bp@alien8.de>
Cc:     Willy Tarreau <w@1wt.eu>, Andy Lutomirski <luto@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-abi@vger.kernel.org,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        Rich Felker <dalias@libc.org>, Kyle Huey <me@kylehuey.com>,
        Keno Fischer <keno@juliacomputing.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n Mon, Apr 19, 2021 at 5:58 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Apr 19, 2021 at 05:33:03PM -0400, Len Brown wrote:
> > For this to happen, every thread would not only have to include/link-with
> > code that uses AMX, but that code would have to *run*.
>
> ...the *library* does that decision automatically!
>
> Which means *every* possible thread on the system.
>
> Which means, *every* thread has a fat 8K buffer attached to it because
> the library uses AMX on its behalf by *default*.

Yes.  If a library decides to execute AMX instructions on behalf
of a task, the kernel will allocate an 8KB context switch buffer
on behalf of that task.

True.  Nothing prevents every user task in the system from executing AMX
instructions, whether explicitly or in a library, and the kernel will
transparently allocate an 8KB buffer for each one.

I do not know anybody who predicts or expects that every task in the system,
or a universally executed library routine, will find a reason to run
AMX instructions.
Again, if that were the expectation or the intent, the proposal would
be to statically
allocate an 8KB context switch buffer on AMX hardware, instead of
dynamic allocation.

Today, libraries routinely probe for what instructions are available
and decide to use them, or not.  I think that most customers
consider that a desirable feature -- since it allows them to run the
same application on multiple hardware generations and get the
most out of each generation.  I respect your right to dislike that feature.

Granted, if you find a reason to dislike AMX, the mechanisms to disable
it today are on a system-wide basis, not on a process or task basis.

Len Brown, Intel Open Source Technology Center
