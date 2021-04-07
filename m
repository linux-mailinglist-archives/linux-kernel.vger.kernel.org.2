Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D86435781A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 00:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbhDGW7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 18:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhDGW7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 18:59:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF35C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 15:59:03 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617836340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5lTT2yZijB3wSjISGEUxR7TCUauzInHTuAtEss7TpSE=;
        b=x0Fdmue0ZudF6x1eCrbs4UBTQmDTVzL4hZFh8o+c7BYqLTSx6dJ/sVcOwgGHSdwpIOpCFK
        wO73nD567GfN01qgawz3HmQEMYSTZVp4/4hR8mu762uHDeSEl987QZBxtphDlq7UueJP7G
        HmrHYFtd6rESQpbwdHYTTAbZUdeGuUPJmefw1Koir8Vh13L4Pvo3++NqellBONOv4xz5SV
        LxyI4/VKeFRYnLS7GtVzmQJ1PN3R85Levlu2CZXccQUBJVLXQHYlQfGwBkEqlSG00hgMt8
        Tvtb6B6jCTcDwYRZF5znFuocWJMCJDf092vCyDVq8Yb+DbIGv5OO03lnfZmD5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617836340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5lTT2yZijB3wSjISGEUxR7TCUauzInHTuAtEss7TpSE=;
        b=oNdFGggnTjvZptXIWPi7166YvLyjaZvpT5yto3J9KWWasoTiInFFQjBNf0ueJy6K8kNXjU
        Ih/DLwB2nAIZ9RAA==
To:     Marco Faltelli <marco.faltelli@uniroma2.it>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH] kernel/time: Feedback reply for hr_sleep syscall, a fine-grained sleep service
In-Reply-To: <20210407113211.2398-1-marco.faltelli@uniroma2.it>
References: <20210407112958.2350-1-marco.faltelli@uniroma2.it> <20210407113211.2398-1-marco.faltelli@uniroma2.it>
Date:   Thu, 08 Apr 2021 00:59:00 +0200
Message-ID: <87eefl4s7f.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marco!

On Wed, Apr 07 2021 at 11:32, Marco Faltelli wrote:

> Current sleep services (nanosleep) provide sleep periods very far from
> the expectations when scheuling microsecond-scale timers. On our
> testbed, using rdtscp() before and after a nanosleep() syscall to
> measure the effective elapsed time with a 1us timer, we got ~59us.
> Even with larger timeout periods, the difference is still evident
> (e.g., with a 100us timer, we measured ~158us of elapsed time).

So the delta is a constant of ~50us, right?

> We believe that one of the reasons is the use of the timespec
> structure, that needs to be copied for user to kernel and then
> converted into a single-value representation.

Interesting.

> In our work Metronome
> (https://dl.acm.org/doi/pdf/10.1145/3386367.3432730) we had the need
> for a precise microsecond-granularity sleep service, as nanosleep()
> was far from our needs, so we developed hr_sleep(), a new sleep
> service.

The above 'interesting' assumption made me curious about the deeper
insight, so I went to read. Let me give you a few comments on that
paper.

> In current conventional implementations of the Linux kernel, the support
> for (fine-grain) sleep periods of threads is based on the nanosleep()
> system call, which has index 35 in the current specification of the
> x86-64/Linux system call table.

There is also clock_nanosleep(2) for completness sake...

> The actual execution path of this system call, particularly at kernel
> side, is shown in Figure 1a. When entering kernel mode the thread exploit=
s two main kernel
> level subsystems. One is the scheduling subsystem, which allows managing
> the run-queue of threads that can be rescheduled in CPU. The other one
> is the high-resolution timers subsystem, which allows posting
> timer-expiration requests to the Linux kernel timer wheel.

The timer wheel is not involved in this at all. If your timer would end
up on the timer wheel your observed latencies would be in the
milliseconds range not in the 50usec range.

> The latter is a data structure that keeps the ordered set of timer
> expiration requests, so that each time one of these timers expires the
> subsequent timer expiration request is activated.

Not exactly how the timer wheel in the kernel works, but that's
irrelevant because it is not involved in this.

> The expiration of a timer is associated with the interrupt coming from
> the High Precision Event Timer (HPET) on board of x86 processors.

You must have a really old and crappy machine to test on. HPET is
avoided on any CPU less than 10 years old and pretty much irrelevant or
a performace horror on any machine which has more than 4 cores.

> In any case, independently of whether preemption will occur, the CPU
> cycles spent for that preamble lead to a delay for the post of the
> timer- expiration request to the timer wheel, leading the thread to
> actually start its timed-sleep phase with a delay.

I would have expected a proper measurement of the delay which is caused
by that processing in the paper, but in absence of that I instrumented
it for you:

First of all I implemented the thing myself, because the crud you posted
fails to compile (see below) and for other reasons which I spare myself
to explain because of that.

The regular clock_nanosleep() over the hacked up nanosleep_u64(), which
just takes a u64 nanosecond value as argument instead of the timespec
pointer has an overhead of ~64 CPU clock cycles on average according to
'perf stat' which amounts to a whopping 32 nanoseconds per syscall on my
test machine running at 2 GHz.

That's _three_ orders of magnitude off from 50us. There goes the theory.

So now where are these 50 microseconds coming from?

There is no massive software/hardware induced overhead caused by the
timespec pointer handling at all, the 50 microseconds are simply the
default timer slack value which is added to the expiry value to allow
better batching of timer expiries.=20

That slack is automatically zero for tasks in real time scheduling
classes and can also be modified by a system wide setting and per
process via prctl(PR_SET_TIMERSLACK, .....) except a system policy
prevents that.

That prtcl has unfortunately a severe limitation: it does not allow to
set the slack value to 0, the mininum values is 1 nanosecond, and I'm
happy to discuss that when you come up with a proper scientific proof
that that _one_ nanosecond matters.

As a limited excuse I concede, that the timer slack is barely
documented, but i'm thorougly surprised that this has not been figured
out and instead of that weird theories about the syscall entry code
implications make up several pages of handwaving content of a published
and 'reviewed' academic paper.

So here is the comparison between the regular clock_nanosleep() with the
prctl() used and the u64 based variant which sets the slack to 0 with
1e6 samples each for a delay of 50us.

sys_clock_nanosleep(CLOCK_MONOTONIC, 0, &td, NULL)
 |
 |                            sys_nanosleep_u64(delayns)
 |                             |
 v                             v
Mean: 54                      Mean: 54

53 us:     206   0.02%        53 us:    977   0.10%
54 us:  975444  97.56%        54 us: 983885  98.49%
55 us:   16737  99.24%        55 us:   6842  99.17%
56 us:    5777  99.82%        56 us:   6958  99.87%
57 us:    1412  99.96%        57 us:    881  99.95%
58 us:     108  99.97%        58 us:     68  99.96%

Massive difference, right? Not really conclusive due to the lack of a
proper sample set and variance analysis, but I couldn't be bothered to
provide that as the paper does not even provide any hint about the
conditions under which the results in Table 1 in Section 3.1 were
collected. So I just followed the same approach of 'lies, damned lies
and statistics' as used in the paper.

Which brings me back to the earlier paragraph:

> We believe that one of the reasons is the use of the timespec
> structure, that needs to be copied for user to kernel and then
> converted into a single-value representation.

Believe belongs into the realm of religion. A proper technical analysis
would have told you that this is not the case. See above.

> In the paper previously linked, Section 3.1 provides more details
> about hr_sleep and Section 3.3 extensively evaluates hr_sleep() and
> compares it to nanosleep(). For a 1us timeout, hr_sleep() elapses
> ~3.8us in mean vs. the ~59us of nanosleep().

Unfortunately Section 3.1 is a fairy tale in a lot of aspects not only
vs. the root cause analysis, which makes Section 3.3 a completely
useless comparison of apples and oranges.

May I suggest to patch Section 6 (Conclusion) in the following way:

- Metronome was technically enabled by our development of a
- new high resolution timed-sleep Linux service, named hr_sleep(),
- way more precise and efficient than the classical nanosleep(), with
- common thread priorities.
+ Metronome developed a new high resolution timed-sleep Linux service,
+ named hr_sleep(), due to the lack of proper root cause analysis of
+ the observed constant latencies of 50us with the existing Linux
+ [clock_]nanosleep() syscall. The same effect could have been achieved
+ with adding a trivial "prctl(PR_SET_TIMERSLACK, 1, 0, 0);" to the
+ Metronome user space implementation, but that would have significantly
+ decreased the amount of non-scientific content of this paper in
+ chapters [3.1, 3.3, 5.x, ...]

If you would have come up with a patch to fix the shortcomings of the
documentation, i.e. man pages, to document timer slack in the context of
nanosleep/clock_nanosleep() and it's implications properly, then I
surely would be impressed.

That said, why the heck are you posting a patch which does not even
compile in the first place?

> +struct control_record {
> +	struct task_struct *task;
> +	int awake;
> +	struct hrtimer hr_timer;
> +};
> +
> +static enum hrtimer_restart hr_sleep_callback(struct hrtimer *timer)
> +{
> +	struct control_record *control;
> +	struct task_struct *the_task;
> +
> +	control =3D (control_record *)container_of(timer, control_record, hr_ti=
mer);

kernel/time/hrtimer.c: In function =E2=80=98hr_sleep_callback=E2=80=99:
kernel/time/hrtimer.c:2014:13: error: =E2=80=98control_record=E2=80=99 unde=
clared (first use in this function)
    control =3D (control_record *)container_of(timer, control_record, hr_ti=
mer);

kernel/time/hrtimer.c:2014:13: note: each undeclared identifier is reported=
 only once for each function it appears in
kernel/time/hrtimer.c:2014:29: error: expected expression before =E2=80=98)=
=E2=80=99 token
iner_of(timer, control_record, hr_timer);

kernel/time/hrtimer.c: In function =E2=80=98__do_sys_hr_sleep=E2=80=99:
kernel/time/hrtimer.c:2036:24: warning: unused variable =E2=80=98restart=E2=
=80=99 [-Wunused-variable]
  struct restart_block *restart;
                        ^~~~~~~

To be clear. I did not even need a compiler to spot this ...

So just to make your excellent analysis even more interesting, I fixed
up the compile fails and here are the superiour results to prove your
point:

sys_clock_nanosleep(CLOCK_MONOTONIC, 0, &td, NULL)
 |
 |                       sys_nanosleep_u64(delayns)
 |                        |
 |                        |                     sys_hr_sleep(delayns)=20
 |                        |                      |
 v                        v                      v
Mean: 54                 Mean: 54               Mean: 54

53 us:     206   0.02%   53 us:    977   0.10%  53 us:    970  0.10%
54 us:  975444  97.56%   54 us: 983885  98.49%  54 us: 978430 97.94%
55 us:   16737  99.24%   55 us:   6842  99.17%  55 us:  12524 99.19%
56 us:    5777  99.82%   56 us:   6958  99.87%  56 us:   7119 99.90%
57 us:    1412  99.96%   57 us:    881  99.95%  57 us:    524 99.96%
58 us:     108  99.97%   58 us:     68  99.96%  58 us:     99 99.97%

Again: No conclusive sample set size (see above), but obvious enough to
       not really require it.

Ergo: -500 ECTS points for this excellent example of missing the point.

For the record:

    The blame is not on Marco (except for posting a patch which does not
    even compile), the real problem is the failure of the academic
    system per se which is nowadays driven by marketing instead of the
    fundamental aspects of science and scientific approaches to analyze
    a problem.

    The same blame goes to the 'anonymous reviewers' of this paper.

Yet another solution in search of a problem ...

Thanks,

        tglx
