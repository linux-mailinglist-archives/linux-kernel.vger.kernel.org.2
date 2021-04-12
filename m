Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50BEB35C9A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbhDLPVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 11:21:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:41438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241439AbhDLPVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 11:21:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8468B6128E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 15:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618240880;
        bh=FmZKUnRsdaFJ8VOHHTMiK0YVlTe93wzi8c1jk3A/72o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OA3x4EwdGOObY1BV9RBxkj1ObPhYzX1I6YmpHeNrZPmqbTyottIrBP64OI5OFWl62
         gGvJGN4dPmHXkXYQgEnZpyLNggRQbKfasaI96BUhpXRBXRUs/LP+EkF12JrbwLyl26
         4hv4htdG1KTR3+jGotFr9fCrW7yLTnqSvRzVlGE29zfxJOypDFNnP8cyP6Qg3vF43f
         EhvWQv5KakTsjO3qMVNbOC30TMGlMFvf99SWkHJayVE1OX4ie6dnH//KggthrmdaMk
         Ymb6rvCQnZ8SK80WtZA6gmatr5c0WG1994hLvM3AM42G8zrMv6haJ7B1xaDLFN2qui
         4gsQTZNJWNq+A==
Received: by mail-ej1-f41.google.com with SMTP id r9so20917760ejj.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 08:21:20 -0700 (PDT)
X-Gm-Message-State: AOAM533y2zJ20v4Jt/toOdrqf5zq1hNQnla8oSxGlMyc1c/pFJ2sMgHp
        2zOk08/4uRkyAkULIEWLJR0fdJ4YHh1SAi6peKmqZw==
X-Google-Smtp-Source: ABdhPJyoceAnmJGi1Fl7qzXAK2V8CtOV6R70hMWrZ/iM4Yticls+y1Z/mLooygmK5t39YdmV2lNIZyvHZeoXCYs8cN4=
X-Received: by 2002:a17:906:35ca:: with SMTP id p10mr3622543ejb.199.1618240879035;
 Mon, 12 Apr 2021 08:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87lf9nk2ku.fsf@oldenburg.str.redhat.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 12 Apr 2021 08:21:07 -0700
X-Gmail-Original-Message-ID: <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
Message-ID: <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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

On Mon, Apr 12, 2021 at 7:19 AM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Andy Lutomirski:
>
> Maybe we could have done this in 2016 when I reported this for the first
> time.  Now it is too late, as more and more software is using
> CPUID-based detection for AVX-512.  Our users have been using AVX-512
> hardware for quite some time now, and I haven't seen *that* many issues
> resulting from the context size.  That isn't to say that problems do not
> exist, but they are more of the kind that the increased stack usage
> means that areas of the stack that used to be zero no longer are, so
> users encounter different side effects from uninitialized-variable bugs.
>
> How much software depends on the signal handler data layout?  The %zmm
> state does not appear to be exposed today, so perhaps some savings could
> be had there.

The fact that including <asm/signal.h> is barely functional in glibc
probably helps keep software from touching the state. :)

>
> The suggestion to make CPUID trap doesn't sound workable to me.  At
> least in the past, it's been suggested as a serializing instruction to
> be used alongside RDTSC, which makes it rather time-critical for some
> applications.
>
> Even today, signal handlers do not really compose well in the sense that
> multiple libraries can use them and collaborate without being aware of
> each other (like they can divide up TLS memory with the help of the
> dynamic linker, or carve out address space using mmap).  Proposals to
> set special process-wide flags only make that situation worse.  Code
> that installs a signal handler often does not have control on which
> thread an asynchronous signal is delivered, or which code it interrupts.
> A single process-wide flag cannot capture that accurately, even if it is
> per signal number.

I think this would want to be a per-signal-handler flag, not per
process.  It's entirely possible to write a signal handler callback
that doesn't touch AVX512 or AMX state, even if the toolchain may make
it annoying.  That specific handler could set the "make me fast" flag.

>
> The rseq extension might work conceptually, but it requires to make
> operations idempotent, with periodic checkpoint, and of course
> inline/flatten all calls.  And it requires compiler work, the present
> model based on inline asm hacks doesn't look workable.  Maybe that works
> for AMX.  I have not checked if there is yet any public documentation of
> the programming model.

I tend to think that the rseq model will be unworkable.  People trying
to use the new instructions will hate it.

>
> I think someone expressed the sentiment (maybe on another thread) that
> the current CPU feature enablement process does not work.  I do not
> agree.  Currently it is only necessary to upgrade the kernel and maybe
> glibc (but not in all cases), and then you are good to go.  You can keep
> using your old libraries, old compilers, and even old assemblers if you
> are okay with .byte hacks.  You do not need special userspace libraries,
> new compilers for different languages, special firmware or binary blobs.
> Overall, it just works.
>
> On x86, we are really bad about actually using CPU features pervasively,
> but that is a different story.
>

"Just works" is different from "is a good idea", though.  With SSE2
and other non-VEX xmm extensions, just using them in userspace seems
quite reasonable.  If a function could run faster using xmm, then it
might as well use xmm.  But this model starts to break down with newer
features:

VEX: ymm (AFAIK) performs just fine, at least on most CPUs, except
that mixing VEX and non-VEX code has big penalties.  Copying that
64-bit data structure using ymm is not necessarily wise even if it
microbenchmarks well.  Heck, mixing translation units using normal C
floating point code that were compiled with different flags can be
quite slow.

AVX-512: Intel has still not responded to my requests for detailed
documentation of the performance issues.  The internet is full of
various reports and various voodoo ideas.  VZEROALL does not do what
one would naively expect, and the implications are unclear.  AVX-512
code, even used just once, is likely to permanently bloat the signal
state.  Even ignoring the unknowns here, on most current non-Xeon-phi
parts AFAICT, using small bits of AVX-512 code has *huge* performance
impacts.  Libraries automatically using AVX-512 just because it's
there is not necessarily a good idea, even if it microbenchmarks well.

AMX: Multiplying a 4x4 matrix probably looks *great* in a
microbenchmark.  Do it once and you permanently allocate 8kB (is that
even a constant?  can it grow in newer parts?), potentially hurts all
future context switches, and does who-knows-what to Turbo licenses and
such.

Even putting aside all kernel and ABI issues, is it actually a good
idea for user libraries to transparently use these new features?  I'm
not really convinced.  I think that serious discussion among userspace
people is needed.

--Andy
