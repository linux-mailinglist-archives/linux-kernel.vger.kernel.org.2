Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D1B370DA3
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 17:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhEBP2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 11:28:31 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:33367 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEBP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 11:28:30 -0400
Received: by mail-ed1-f47.google.com with SMTP id b17so487794ede.0;
        Sun, 02 May 2021 08:27:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Yo5lJFkseirK7+Os1dsvmENxr6gMP+2YIPJxFmkXVk=;
        b=L27R5QPUSfus9OCUuTfdlxzesCCOAJ9/gKhCTFxF7sS1wAggv5IHd5r+DBqOjXB3Jb
         7T7rPHJz6XWoId1dl64LZEidIugrfT4uTDijvaN6hkYQjIIHp6fUUbRixtyQ8JD8pz1O
         mmKUz0hPGg2oEJUjn5xi+s95Hx+ZK9QSqo3ejsSEhw2nK8dgkvfldiWuzL+Dok36k1EN
         OkeJA9uy6eeOcH+T55EOhJzRNgK+70ysd8nb2+QVgJFSy+Zr9r4OOy731ag4E52cpTeA
         jTxrhEbV6i+D6GteomWpmaC9kABntV/rx7NMaPxoERSeVEcQYaB4MaCQGHN9BHH0BD2E
         HeNA==
X-Gm-Message-State: AOAM5329xl4Qd+UFBwbz8NLe68oVySQIhPmq7FGmhXdpK2r4BuYoCGDc
        7yoBckiCbZhWVJ6zRmSHh56cfTl8+Kts9H9KwQVdho8A
X-Google-Smtp-Source: ABdhPJwhw4g3fWATRq9485rhmPqE20zAbxqrCkrtzYFFdBLT740uWpW4bDZ99Kccx/O2alF9MiVOiJ9uI1QA/dCpUgg=
X-Received: by 2002:a05:6402:3079:: with SMTP id bs25mr16173762edb.146.1619969258275;
 Sun, 02 May 2021 08:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic> <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
 <20210419191539.GH9093@zn.tnic> <CAJvTdK=VnG94ECcRVoUi8HrCbVEKc8X4_JmRTkqe+vTttf0Wsg@mail.gmail.com>
 <20210419215809.GJ9093@zn.tnic> <CAJvTdKn6JHo02karEs0e5g+6SimS5VUcXKjCkX35WY+xkgAgxw@mail.gmail.com>
 <YIMmwhEr46VPAZa4@zn.tnic>
In-Reply-To: <YIMmwhEr46VPAZa4@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Sun, 2 May 2021 11:27:26 -0400
Message-ID: <CAJvTdKnhXnynybS4eNEF_EtF26auyb-mhKLNd1D9_zvCrchZsw@mail.gmail.com>
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

On Fri, Apr 23, 2021 at 3:58 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Apr 23, 2021 at 03:35:30PM -0400, Len Brown wrote:
> > Yes.  If a library decides to execute AMX instructions on behalf
> > of a task, the kernel will allocate an 8KB context switch buffer
> > on behalf of that task.
>
> Again, the library should ask the kernel first whether it supports AMX.
> And the process should decide whether to use AMX - not the library on
> its own, on behalf of the process.
>
> > Granted, if you find a reason to dislike AMX, the mechanisms to disable
> > it today are on a system-wide basis, not on a process or task basis.
>
> Again, I don't dislike the feature. I don't want libraries jumping on
> new features without asking the process or the kernel first especially
> when those features have performance implications and need kernel
> support.

Here is how it works:

1. The kernel boots and sees the feature in CPUID.

2. If the kernel supports that feature, it sets XCR0[feature].

    For some features, there may be a bunch of kernel support,
    while simple features may require only state save/restore.

2a.  If the kernel doesn't support the feature, XCR0[feature] remains cleared.

3. user-space sees the feature in CPUID

4. user-space sees for the feature via xgetbv[XCR0]

5. If the feature is enabled in XCR0, the user happily uses it.

    For AMX, Linux implements "transparent first use"
    so that it doesn't have to allocate 8KB context switch
    buffers for tasks that don't actually use AMX.
    It does this by arming XFD for all tasks, and taking a #NM
    to allocate a context switch buffer only for those tasks
    that actually execute AMX instructions.

5a. If the feature is not enabled in XCR0, and the tasks uses
    those instructions anway, the hardware delivers a #UD
    and the kernel kills the process with a signal.

So you already have what you want, WRT user-space being
required to ask the kernel if the feature is supported.
When the kernel sets XCR0[feature], it tells user-space
that the kernel supports the feature; and there is no
way that user space can use the feature if the kernel
did not set that bit.

System calls before (and after) using a feature are not necessary,
and would only degrade performance over the existing ABI.

Regarding performance implications...
The system administrator is empowered to enable or disable
a feature in BIOS (clears CPUID bit) or in the kernel
(clears XCR0 bit) if they don't like it.
Yes, this is a per-system decision, rather than a per-process
or a per-thread decision.

So the only thing you don't have that you asked for is a
way for the main process to control what instructions are
used by the libraries that it links with.  That one is above
my pay grade.  Does the application have a *choice*
of which libraries they link with?

cheers,
Len Brown, Intel Open Source Technology Center
