Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E86935E960
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347853AbhDMW7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231787AbhDMW7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:59:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 115FD61246
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 22:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618354752;
        bh=2W54etGrZFjK3LvTvpFBh3mSYBYxMTnNbzR4OPQA1FU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ScIRVEJKFsCPTP5/oxbdUJWk4rJKO0dforaKk5k1b0NZGZL5TCsJ2ElcNiwGxAKHa
         gxGZ1R3E/zYzyAXUQpVRwJnEbx5169juPGVFJCcvEzuunYFL3LrQNIM9EYp6rdTdyj
         +vjKLv8ZNT1J1J2I4MT7OmEoGHgQjmFj9sPhrvyuJFMQCb31tBCAf3lMFB1FRRbqKd
         T/8mER3ddgN4Ozc64QaGimsdVsiN/UxaEYhTUeFDgUG+239saI3rbZkShm/Wwez+YS
         7Exl7qNZYICzaLWx9iRYMeZHI8qVIm9krfy274wYXUhONmenYlExRseWwyN4RkwjYc
         JqjxVJSpDGP3g==
Received: by mail-ed1-f48.google.com with SMTP id g17so20623020edm.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 15:59:11 -0700 (PDT)
X-Gm-Message-State: AOAM530ppebeQxc9NHFx8GB+karQ26PkboqkAGdh+LDM+OoIaw0H/6NG
        N5E9mLhMQkHBqP/bwZmC1H6bzh+bf7ro8CXl3cpRJw==
X-Google-Smtp-Source: ABdhPJzJkPw21zTgf71eMpCcBJ3V1F0sHGsjyBMesqTdaShDitlG+tfS7Km1wCffDoYAPcz8pg7cyeKVQJPirZVPmj8=
X-Received: by 2002:aa7:d353:: with SMTP id m19mr34103472edr.172.1618354749851;
 Tue, 13 Apr 2021 15:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com>
 <CALCETrVvapzL79BQNEvOupMHHzriR+n97955tRA+TPE6rgRC4Q@mail.gmail.com> <CAJvTdKmDb3TOHbb4w1YNcdYH2Pzr+RsAS_o0q3AFP1Xz55R37g@mail.gmail.com>
In-Reply-To: <CAJvTdKmDb3TOHbb4w1YNcdYH2Pzr+RsAS_o0q3AFP1Xz55R37g@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 13 Apr 2021 15:58:58 -0700
X-Gmail-Original-Message-ID: <CALCETrUe4_DvSdq7CRJsUxZm8DSwfHevagxJEbHv88UjcC1Hkg@mail.gmail.com>
Message-ID: <CALCETrUe4_DvSdq7CRJsUxZm8DSwfHevagxJEbHv88UjcC1Hkg@mail.gmail.com>
Subject: Re: Candidate Linux ABI for Intel AMX and hypothetical new related features
To:     Len Brown <lenb@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Willy Tarreau <w@1wt.eu>,
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

On Tue, Apr 13, 2021 at 3:47 PM Len Brown <lenb@kernel.org> wrote:
>
> On Tue, Apr 13, 2021 at 4:16 PM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > On Mon, Apr 12, 2021 at 4:46 PM Len Brown <lenb@kernel.org> wrote:
> > >
> > > On Mon, Apr 12, 2021 at 11:21 AM Andy Lutomirski <luto@kernel.org> wrote:
> > >
> > > > AMX: Multiplying a 4x4 matrix probably looks *great* in a
> > > > microbenchmark.  Do it once and you permanently allocate 8kB (is that
> > > > even a constant?  can it grow in newer parts?), potentially hurts all
> > > > future context switches, and does who-knows-what to Turbo licenses and
> > > > such.
> > >
> > > Intel expects that AMX will be extremely valuable to key workloads.
> > > It is true that you may never run that kind of workload on the machine
> > > in front of you,
> > > and so you have every right to be doubtful about the value of AMX.
> >
> > I fully believe that AMX will be amazing when used for the right
> > workload.  The problem is that a library may have no way to tell
> > whether a workload is the type of computationally intensive workload
> > for which it makes sense.  Imagine you have a little function:
> >
> > int matrix_times_vector(int dim, float *out, const float *matrix,
> > const float *vector);
> >
> > A clever library might use AMX for this.  If dim == 4 and the caller
> > is planning to call it in a long, tight loop, maybe this even makes
> > sense.  If dim == 4 and it's being called once, AMX is probably a
> > losing proposition.  With previous technologies, at least the impact
> > was limited to the function itself and maybe once per call to the
> > caller.  But now, with AMX, the program that invoked this takes a
> > performance and memory hit *forever* if it uses AMX once.
>
> Again...
>
> As this is a "clever" library, built with a clever toolchain, and the
> result is that
> TILERELEASE was properly issued at the end of computation.
> Thus the hardware knows that the  (volatile) AMX registers are no longer live.

My argument has *nothing* to do with TILERELEASE.  Let me try again.

Suppose I write some user code an call into a library that uses AMX
because the library authors benchmarked it and determined that using
AMX is faster when called in a loop.  But I don't call it in a loop.
Then I take the transition penalty into and out of AMX code (I'll
believe there is no penalty when I see it -- we've had a penalty with
VEX and with AVX-512) and my program runs *slower*.  And, to top it
off, I've just permanently allocated 8kB of extra FPU state buffer,
*and* I'm taking either an XCR0 or an XFD write penalty on every
future context switch.

Someone or something needs to make a decision as to whether AMX should
actually be used for a given algorithm.  The user library community
has swept this under the rug by declaring that libraries should use
the best-in-a-tight-loop code for the entire existence of extensions
beyond XMM, and the cost keeps getting higher.

> > Beyond that, we have the signal handling issue.
>
> I'm unaware of any unresolved feedback on the signal handling series
> other than a wistful "wouldn't a new SIGFAIL be more clear (for future apps)
> than the existing SIGSEGV?"  I agree with this sentiment, but I don't
> think we should hold up a patch to prevent corrupting user data
> because a new signal number to describe the scenario doesn't exit.
> Particularly since the new code that knows about the new SIGFAIL
> will also be new code that has been compiled with the new glibc
> that for most cases will prevent this scenario in the first place...
>
> > One solution, going
> > off of what WIlly mentioned, is:
> >
> > bool amx_begin(void *signal_save_buffer);
> > void amx_end();
> >
> > In the amx_begin() region, if you get a signal, the AMX state is saved
> > in the buffer.  Outside the region, if you get a signal and AMX is in
> > use, the kernel will either unceremoniously kill the task or will
> > deliver SIGYOUBLEWIT. [0]
>
> I think it is clear that if a new signal ABI is going to be invented,
> that it should be opt-in on state, so that it can run fast on machines
> far into the future by not choosing to opt-in on anything.
>
> It isn't clear that changing the signal save state around critical regions
> (in multiple threads) so that a single (per process definition) of a signal
> handler gets a different result at different times is going to make that
> (new) signal handler author especially happy.  More likely they
> either always want the state, or they do not.

Perhaps some form of decision should be reached before AMX lands?
Landing AMX in its current form is a decision, and we should make a
credible effort to decide if it's the right one.

--Andy
