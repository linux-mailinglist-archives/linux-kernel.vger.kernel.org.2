Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1283649B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 20:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbhDSSTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 14:19:38 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44984 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbhDSSTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 14:19:35 -0400
Received: by mail-ed1-f44.google.com with SMTP id z5so5392359edr.11;
        Mon, 19 Apr 2021 11:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjNnhmj2U2q35zn2cIKMXxY6k0hLNhQZfkjD9pyuyE8=;
        b=ZqZDR2VYJSTp/YSdqsj8+KaS9N6Vw2cSqinU5DglLtMThob8qmWOAd7g+abD3i/gZp
         ewigXwmIXwQhUd1QFjnFVX8381J53w7CFYMZB5hPopknOfpamB7rfZfciS2ZyfewCO/E
         JRqP1FSDeP67Q7+OTRw7+WF0qHfwdy4zWKOPpixPbbLBcQGTtD/VIeaoqlA7sBJllD1p
         vgygPynwYejlwcecIbHc+HKXnutHzO8jtiGIsKUTr4BwpjPnq6DNbKC18CC8BSYy9rAl
         h7EUi5Xcb1HAMYOKO0Fiqmzit0aY7EX4ahC71K3XAQ5x7CYKe/5cslSSBEzXbU/emRvu
         2bPA==
X-Gm-Message-State: AOAM5312AAI1gXa28f118HDcX2yW6Tqn3Ath55SLrKlSw896jA1WSeJ3
        /6fX/CMGWWvK7BO9mpIaV0PbUhKaqVRhouG4RxFbUGyq2PM=
X-Google-Smtp-Source: ABdhPJxIc+lM/cqAg0fIGhDxE7WpiCIxur9A/2zYYq0wZPnNK8ah/AW0sTR5E+AM4Flr9QYrCHwfZGKaQ44xP814Geg=
X-Received: by 2002:a50:fb0a:: with SMTP id d10mr14294323edq.146.1618856343175;
 Mon, 19 Apr 2021 11:19:03 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <20210413034346.GA22861@1wt.eu> <CAJvTdKmLth==ZPv7ygLs0jFX7JRPVhVT82ZDoT4xcQRABEVTvQ@mail.gmail.com>
 <20210414095804.GB10709@zn.tnic> <CAJvTdKn_y8qAjDy189zEf8cnaWrvW3baca=z9FgGxV9AvQEADg@mail.gmail.com>
 <20210415044258.GA6318@zn.tnic> <20210415052938.GA2325@1wt.eu>
 <20210415054713.GB6318@zn.tnic> <CAJvTdKnjzAMh3N_c7KP3kA=e0LgYHgCANg44oJp3LcSm7dtbSQ@mail.gmail.com>
 <20210419141454.GE9093@zn.tnic>
In-Reply-To: <20210419141454.GE9093@zn.tnic>
From:   Len Brown <lenb@kernel.org>
Date:   Mon, 19 Apr 2021 14:18:51 -0400
Message-ID: <CAJvTdK=p8mgO3xw9sRxu0c7NTNTG109M442b3UZh8TqLLfkC1Q@mail.gmail.com>
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

On Mon, Apr 19, 2021 at 10:15 AM Borislav Petkov <bp@alien8.de> wrote:

> > Tasks are created without an 8KB AMX buffer.
> > Tasks have to actually touch the AMX TILE registers for us to allocate
> > one for them.
>
> When tasks do that it doesn't matter too much - for the library it does!
>
> If the library does that by default and the processes which comprise
> of that pipe I mentioned earlier, get all 8K buffers because the
> underlying library decided so and swinging those buffers around when
> saving/restoring contexts turns out to be a performance penalty, then we
> have lost.
>
> Lost because if that thing goes upstream in this way of use of AMX is
> allowed implicitly, there ain't fixing it anymore once it becomes an
> ABI.
>
> So, that library should ask the kernel whether it supports AMX and only
> use it if has gotten a positive answer.

Right, the library *does* ask the kernel whether it supports AMX (below).

> And by default that answer
> should be "no" because the majority of processes - that same pipe I keep
> mentioning - don't need it.

Indeed, the default is "no" because most libraries will *not* ask the system
for AMX support (below).  However, if they *did* probe for it,
and they *did* use it, the kernel would not stand in the way of
any of those requests.

> I have no good idea yet how granulary that should be - per process, per
> thread, whatever, but there should be a way for the kernel to control
> whether the library uses AMX, AVX512 or whatever fat state is out there
> available.
>
> Then, if a process wants the library to use AMX on its behalf, then it
> can say so and the library can do that but only after having asked for
> explicitly.

The ABI works like this:

0. App or library author decides AMX is useful at build-time.

1. App checks CPUID for AMX CPU feature
2. App checks XCR0 for AMX OS support

(if app touches AMX without these two being TRUE,
 it will suffer the consequence of a #UD when it touches an AMX instruction)

This ABI is how AVX works today.

What is new with AMX is the ability of the hardware and the OS
to delay the allocation of the context switch buffer until if/when
it is actually needed.

This is transparent, and thus not part of the ABI, unless you count
the absence of a mandated system call to be an ABI.

3. the application then touches an AMX register, triggering...
4.  #NM handled by the kernel, which allocates a context switch buffer
for that task, and dis-arms XFD.

Yes, we could invent a new system call and mandate that it be called
between #2 and #3.  However, we'd still do #4 in response, so I don't see any
value to that system call.  Indeed, I would advocate that glibc
replace it with a return statement.

So back to the example:
<process> | grep | awk | sed ...

Sure, if grep grows support for some AI feature that we haven't imaged
yet, then something in
its code flow is fully empowered to probe for AMX and use AMX on AMX hardware.
Sort of hard to imagine with the programs above that we know today,
but future programs
certainly could do this if they chose to.

thanks,
Len Brown, Intel Open Source Technology Center
