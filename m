Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC2335E93C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 00:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347602AbhDMWri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 18:47:38 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:36707 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348665AbhDMWrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:47:37 -0400
Received: by mail-ed1-f53.google.com with SMTP id 18so21352781edx.3;
        Tue, 13 Apr 2021 15:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1mPbtibU3Fh5sSrZq8G0/u9i81sI/lY2kXV2ao+WnyA=;
        b=DZcquxH2dZbxOnTZe51XLb/P5tE1/RaMjSiONJ6DW+WwCBgK8Vt991SbFHqnkgXN3H
         Pp/GF53vk+rHB48ORJeHFGokE4ak/AZKY1jKGVEK0WVkLYiDNR4Oe7koYMFXvTMSsnZM
         +iI1vISX+JcPfHrXEU7/N7xI3PYkePwYZ1hApOmtVFsz+/6yU07ybw9gyxsltjrFTbPt
         fdTEmtps84fYAYYWp/SOfVrn4AQIJQmyUKctobfxh+S0YUn99FmfwHYzeumcwSZuKW7P
         qUI5BribfCas8nTESCC53PTqQq9G5VNHH6RVBiuf9xVj27qiMPlswM+oYa4gqENlF3UG
         Ry3Q==
X-Gm-Message-State: AOAM533QkUVd0i7SR/muPgUKGbabSU8c5efw9tlGon+VuIBqTzgVzZ34
        PU+s45cJVtGJqeEvo2dsPlZWBiz2+5vaJwSK9/E=
X-Google-Smtp-Source: ABdhPJxTnYqTsJ4p6QgVcXWsdElSvoyXRZAqJLksH6oI7m/MsND/BUBBd34ONoiZCSTe8Gz95pjslhomjEWQmn1z65o=
X-Received: by 2002:a05:6402:4245:: with SMTP id g5mr37892755edb.306.1618354036178;
 Tue, 13 Apr 2021 15:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrW2QHa2TLvnUuVxAAheqcbSZ-5_WRXtDSAGcbG8N+gtdQ@mail.gmail.com>
 <87lf9nk2ku.fsf@oldenburg.str.redhat.com> <CALCETrWxJzf-rm9rqMpdxEtdVe+0OH7XRtWV=UzrgBDiPT=vVQ@mail.gmail.com>
 <CAJvTdKkAzEeAKrEYMU-gBWXoNGyJ09ZGw1gsU0b3uCuo8vrX0A@mail.gmail.com> <CALCETrVvapzL79BQNEvOupMHHzriR+n97955tRA+TPE6rgRC4Q@mail.gmail.com>
In-Reply-To: <CALCETrVvapzL79BQNEvOupMHHzriR+n97955tRA+TPE6rgRC4Q@mail.gmail.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 13 Apr 2021 18:47:04 -0400
Message-ID: <CAJvTdKmDb3TOHbb4w1YNcdYH2Pzr+RsAS_o0q3AFP1Xz55R37g@mail.gmail.com>
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

On Tue, Apr 13, 2021 at 4:16 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Mon, Apr 12, 2021 at 4:46 PM Len Brown <lenb@kernel.org> wrote:
> >
> > On Mon, Apr 12, 2021 at 11:21 AM Andy Lutomirski <luto@kernel.org> wrote:
> >
> > > AMX: Multiplying a 4x4 matrix probably looks *great* in a
> > > microbenchmark.  Do it once and you permanently allocate 8kB (is that
> > > even a constant?  can it grow in newer parts?), potentially hurts all
> > > future context switches, and does who-knows-what to Turbo licenses and
> > > such.
> >
> > Intel expects that AMX will be extremely valuable to key workloads.
> > It is true that you may never run that kind of workload on the machine
> > in front of you,
> > and so you have every right to be doubtful about the value of AMX.
>
> I fully believe that AMX will be amazing when used for the right
> workload.  The problem is that a library may have no way to tell
> whether a workload is the type of computationally intensive workload
> for which it makes sense.  Imagine you have a little function:
>
> int matrix_times_vector(int dim, float *out, const float *matrix,
> const float *vector);
>
> A clever library might use AMX for this.  If dim == 4 and the caller
> is planning to call it in a long, tight loop, maybe this even makes
> sense.  If dim == 4 and it's being called once, AMX is probably a
> losing proposition.  With previous technologies, at least the impact
> was limited to the function itself and maybe once per call to the
> caller.  But now, with AMX, the program that invoked this takes a
> performance and memory hit *forever* if it uses AMX once.

Again...

As this is a "clever" library, built with a clever toolchain, and the
result is that
TILERELEASE was properly issued at the end of computation.
Thus the hardware knows that the  (volatile) AMX registers are no longer live.

The XSAVE hardware recognizes this INIT=1 condition and
transfers NO DATA "*forever*".  This is true both on context switch (compacted)
where it is automatic, and on (uncompacted) signal delivery, where we
check for this case.

Was that the "performance hit" of concern, or did I miss something?

Yes, it is true that the kernel allocated a context switch buffer for
the lifetime
of that task, and it will not be freed until that task exits.

If this proves to be an issue, there is nothing
preventing us from implementing a re-claim scheme for a rarely used buffer.
After recognizing this situation, we'd simply arm XFD, free the
buffer, and from then onwards, the task behaves exactly as if had
never touched AMX.

However, nobody has yet suggested that would be a common situation
worth an optimization to reclaim that task's 8KB.

> Beyond that, we have the signal handling issue.

I'm unaware of any unresolved feedback on the signal handling series
other than a wistful "wouldn't a new SIGFAIL be more clear (for future apps)
than the existing SIGSEGV?"  I agree with this sentiment, but I don't
think we should hold up a patch to prevent corrupting user data
because a new signal number to describe the scenario doesn't exit.
Particularly since the new code that knows about the new SIGFAIL
will also be new code that has been compiled with the new glibc
that for most cases will prevent this scenario in the first place...

> One solution, going
> off of what WIlly mentioned, is:
>
> bool amx_begin(void *signal_save_buffer);
> void amx_end();
>
> In the amx_begin() region, if you get a signal, the AMX state is saved
> in the buffer.  Outside the region, if you get a signal and AMX is in
> use, the kernel will either unceremoniously kill the task or will
> deliver SIGYOUBLEWIT. [0]

I think it is clear that if a new signal ABI is going to be invented,
that it should be opt-in on state, so that it can run fast on machines
far into the future by not choosing to opt-in on anything.

It isn't clear that changing the signal save state around critical regions
(in multiple threads) so that a single (per process definition) of a signal
handler gets a different result at different times is going to make that
(new) signal handler author especially happy.  More likely they
either always want the state, or they do not.

> I'm really hoping some userspace people can chime in.

Len Brown, Intel Open Source Technology Center
