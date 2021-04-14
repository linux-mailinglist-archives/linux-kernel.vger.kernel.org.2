Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D048F35FD6E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhDNVst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:48:49 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:37444 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbhDNVst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:48:49 -0400
Received: by mail-ej1-f42.google.com with SMTP id w3so33707993ejc.4;
        Wed, 14 Apr 2021 14:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XS0kpoYgqiPQOsxQst3pEpo6vwygG6iguU7xtylpFAQ=;
        b=R4HLScVpGpRnQEKw7NHatDkO8Kdp1Ys50dKBE35emHYTMzAm4iOENf+904BpPX5P4P
         GUVSRIhoWlw8QLuYldCz9u3fvZwDb6X0ZFOSvQgsPbrvxzMYw+4fYE5wUBMWso7WIu9x
         WvqtjJWT9s5MhpWLNP4iTkIArqDFGqRq1yQ0Dy/Ct6LKT5PjRNBAdRVlRkRUsNJnBPIE
         CfWJzT9SyeR0FJigw6zKFQyoX0/NEJjs8xmFkyRdTEQ4yTY9E+7/JRO1rQcP7z5zPPyF
         mhkKQ31OhI913Cx0wQEpvPxNV2McQIyPdyquy9o1qKWGFyspqdiedriu39meuFftcLXL
         4SOQ==
X-Gm-Message-State: AOAM532D3YhB9ZPNcmSyT/x3PBywIkueoQfDnTc1eaYMll93VyLYZKtb
        CcGiumcEWT58mpAn3b+zm1wUo6RLrLsZUGohCGU=
X-Google-Smtp-Source: ABdhPJzoJJapTvR/IS5yL52e1mGnUtf5FDcvfkZGtHTXSncNEXq3EG0YxrBNPW/UGxUPvvSNTRET89dza6xnE1nCj/A=
X-Received: by 2002:a17:906:dfcc:: with SMTP id jt12mr164611ejc.31.1618436903216;
 Wed, 14 Apr 2021 14:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <CALCETrVvapzL79BQNEvOupMHHzriR+n97955tRA+TPE6rgRC4Q@mail.gmail.com>
 <CAJvTdKmDb3TOHbb4w1YNcdYH2Pzr+RsAS_o0q3AFP1Xz55R37g@mail.gmail.com> <CALCETrUe4_DvSdq7CRJsUxZm8DSwfHevagxJEbHv88UjcC1Hkg@mail.gmail.com>
In-Reply-To: <CALCETrUe4_DvSdq7CRJsUxZm8DSwfHevagxJEbHv88UjcC1Hkg@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Wed, 14 Apr 2021 17:48:11 -0400
Message-ID: <CAJvTdKmppOcyy=akSo3+dn0KN5GmOKLK5cp3eZ_ymujE-=ExwQ@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>, Florian Weimer <fweimer@redhat.com>,
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

On Tue, Apr 13, 2021 at 6:59 PM Andy Lutomirski <luto@kernel.org> wrote:

> Suppose I write some user code and call into a library that uses AMX
> because the library authors benchmarked it and determined that using
> AMX is faster when called in a loop.  But I don't call it in a loop.

Again...

AMX registers are volatile.

That means if a routine uses them and expects them to persist
across a call, the caller must save them.
It also means that they can't be used as globals, they can't
be used for passing parameters, and they can't be used for
static information in a called routine.

And so a routine that uses AMX starts from scratch, and finishes
with no state in registers.  Everything gets loaded from memory
into AMX, joyous number crunching proceeds, and the answer
is stored in memory when the routine is complete.

Could somebody write a routine that uses AMX to perform a single multiply,
and then call that routine from a loop?  Yes, that is possible,
but I would challenge them to demonstrate it is a good idea under
*any* conditions.

More realistic, perhaps would be a routine that does a matrix multiply
and is passed matrices of variable size.  It would be easy to demonstrate
that is a performance win on a  big matrix, but then what happens
when somebody calls that routine with a matrix size of 1?
Surely that would be a net loss.

This is pretty much exactly what Willy described.  It is faster to
copy a 5-byte structure by hand, than to call bcopy().

Indeed, dedicated co-processors have been built to do what AMX does,
but the work has to be big enough to out-weigh the overhead of invoking them.

This trade-off is as old as the hills, and yes, it is possible to screw up.

> Then I take the transition penalty into and out of AMX code (I'll
> believe there is no penalty when I see it -- we've had a penalty with
> VEX and with AVX-512) and my program runs *slower*.

If you have a clear definition of what "transition penalty" is, please share it.

Lacking one, I'll assume you are referring to the
impact on turbo frequency of using AMX hardware?

Again...

On the hardware that supports AMX, there is zero impact on frequency
due to the presence of AMX state, whether modified or unmodified.

We resolved on another thread that Linux will never allow entry
into idle with modified AMX state, and so AMX will have zero impact
on the ability of the process to enter deep power-saving C-states.

It is true that AMX activity is considered when determining max turbo.
(as it must be)
However, the *release* of the turbo credits consumed by AMX is
"several orders of magnitude" faster on this generation
than it was for AVX-512 on pre-AMX hardware.

I respect your right to not believe me about performance until you
have this hardware.
But proposing a new ABI based on concern of a problem that hasn't been
shown to exist would be folly.

> And, to top it
> off, I've just permanently allocated 8kB of extra FPU state buffer,
> *and* I'm taking either an XCR0 or an XFD write penalty on every
> future context switch.

Again...

We allocate an 8kB FPU state buffer for tasks that use AMX.
We do not allocate that buffer for tasks that do not use AMX.

If it turns out to be common that a long running task touches AMX once
and never again, it would not be difficult to optimize for that case
and free the buffer.

Again...

Yes, the proposal, and the working patch set on the list, context
switches XFD -- which is exactly what that hardware was designed to do.
If the old and new tasks have the same value of XFD, the MSR write is skipped.

I'm not aware of any serious proposal to context-switch XCR0,
as it would break the current programming model, where XCR0
advertises what the OS supports.  It would also impact performance,
as every write to XCR0 necessarily provokes a VMEXIT.

> Someone or something needs to make a decision as to whether AMX should
> actually be used for a given algorithm.  The user library community
> has swept this under the rug by declaring that libraries should use
> the best-in-a-tight-loop code for the entire existence of extensions
> beyond XMM, and the cost keeps getting higher.

Is this a plea for library writers to run the simplest microbenchmarks
to determine if their code makes any sense at all before releasing it?
If so, I agree.

> Perhaps some form of decision should be reached before AMX lands?
> Landing AMX in its current form is a decision, and we should make a
> credible effort to decide if it's the right one.

Three questions come to mind:

1. Do we have a power or performance issue?
2. Do we have ABI breakage?
3. Can we do better in the long term?

1. Power or Performance issue?

Per above, and multiple other threads, I'm not aware of any unresolved
power or performance issues on AMX-capable hardware.

2. ABI Breakage?

We all recognize that the signal.h hard-coded alt-sig-stack size ABI
was ill conceived, and overlooked -- for decades.

We all recognize that there are a non-zero number of applications that
fail on AVX-512 hardware because of this issue.

We all recognize that if not addressed, AVX would increase the likelihood
of an application failing due to the too-small-alternative-signal-stack issue.

I thank the ARM community for taking action on this issue and setting the
example of the ALT-VEC solution to compute and expose required stack
size at run-time.
I further thank HJ Lu and the libc team for picking up that ball and shipping
the solution to this problem with an updated ABI in glibc 2.34.

I acknowledge that it is not impossible to fail after that fix -- you can
ignore the ABI, or you could hardcode sizes, or you could be statically
linked to the old libc.  But it gets increasingly harder to fail, the kernel
signal series has a new run-time check to prevent data corruption
that could have happened in the past, and the remedy is clear --
re-build with the new glibc.

Yes, it would have been good if this were done before AVX-512 deployed.

3. Can we do better in the long term?

Assuming the ABI update in #2 addresses the issue with applications that
declare their own alt-sig-stack, we have a backward compatible solution today.

Somewhere in the past, the decision was made that all architectural state
should be exposed to signal handlers.  And a decision was made on x86
that it should be in uncompacted XSTATE format.

There are programs today that count on both of these things being true,
and if we change either of those, we break applications.

But the irony is that there are a vanishingly small number of signal handlers
that actually care at all about that state, and it seems to be wasteful
to give it to them.

So the question is whether to continue giving them all that information,
or to give them a way to decline -- to give the option for signals to be
more lightweight.

We can certainly do this.  The question is if it is important enough to bother.

What applications would notice if signal handlers were faster?
Would those applications be willing to update to opt-in to a
new incompatible signal handling ABI, where the kernel
took the time to supply only the state that they request?

thanks,
Len Brown, Intel Open Source Technology Center
