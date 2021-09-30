Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5C141E310
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 23:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348880AbhI3VOS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Sep 2021 17:14:18 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:34792 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348834AbhI3VOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 17:14:10 -0400
Received: by mail-lf1-f51.google.com with SMTP id g41so30446911lfv.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 14:12:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FmeX3t1aT8i9dZHDnbcE/UsTG25QicvHNyap/ASOAAc=;
        b=CatcS0lIR1oeye5PDy7/njFBKu96+MAAXXPBPW2YM5RQSKllGvA88t7rU+HKZQX64X
         STNzxJDmcD4LNAz8tUy4FYP8kwC9GNC42lpcCYA87qG7ELpU5t548xAvQCmVV0gI/dKU
         +9Yf2w7QDcwaN8hRB8Nqy41b9Czpfl0KaaLz1+8fLIrJbm5ESIqyDa/8l33UqMeO4uv0
         ynUSPF0kJM9FOJbZayzkTSDGRbttndd8HxpMO5aa3mg8RfGb40JXhGTARApOwtg+Zf7Z
         Nqv5wDkfL53to+jqgE6WmErh6EiMWv2UXqNg8sty7kv/zsNK7W7BU4bW/iZnzw9GKTmd
         g4QQ==
X-Gm-Message-State: AOAM532RKiKriVqcnhQltgKQJkzDQXZXQ+GQCr2aMlX+ndOwi5jnEgik
        Cwdh0d867l66nj+EeCcQoNBXht1zeumE5c/HxdQGkxK0xLQ=
X-Google-Smtp-Source: ABdhPJxZqpIX2kr+bm0zrAjD5zeN7m5yICu+is8adn8ZveGeiKWIMJJgy5Z2gqsIwz0eSIq0U+rI3RhadOQKr8yc7GM=
X-Received: by 2002:a05:651c:1548:: with SMTP id y8mr7832966ljp.17.1633036345770;
 Thu, 30 Sep 2021 14:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
In-Reply-To: <20210825155413.19673-1-chang.seok.bae@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 30 Sep 2021 17:12:14 -0400
Message-ID: <CAJvTdKkK=_pp1PrWdh1_GN73VifuAkivnErgK+bo2h34Vd_55w@mail.gmail.com>
Subject: Re: [PATCH v10 00/28] x86: Support Intel Advanced Matrix Extensions
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thiago Macieira <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sep 17 Minutes (tglx, daveh, chang, rafael, lenb)

As a result of a verbal discussion with Thomas, we propose the
following five updates to the v10 AMX patch series.  Below this list
of updates are notes from additional discussion that did not result in
changes.

Update #1 Expand XSAVE no-write optimization to cover XSTATE feature17 and later
------------------------------------------------------------------------------------------------------------------

Linux/AMX patchset v10 checks for XINUSE.AMX=0 just before XSAVE to
the signal stack.  If that INIT condition is detected, Linux sets
RFBM.AMX=0 before XSAVE.  The result is that instead of writing 8K of
zeros for AMX, XSAVE writes nothing.  Originally, this was intended as
a performance optimization,  However, if this optimization applies to
the last items on the stack, then it also reduces how much stack is
required.

Update this optimization to apply to feature17 and later, rather than
just XFD-enabled features (like feature 18, AMX.data).  We do this
starting with feature17 (AMX.TILECONFIG) not because it is large, but
because it is new.  Also it sets the precedent for an inevitable
"feature19" that comes after AMX, but may not necessarily be protected
by XFD.

[ note that a future performance enhancement might be to apply this
check to AVX-512.  Doing so would save data transfer (of zeros) when
AVX512 is INIT, but due to features after AVX512 and before feature17
it would not necessarily shrink the signal stack use, which must be
assumed to include up through feature16 ]

Update #2: Enhance run-time stack check upon signal delivery.
------------------------------------------------------------------------------------

Linux 5.14 added a new check just before writing to the signal stack.
If sigaltstack is being used, Linux checks if the XSTATE will fit.  If
not, SIGSEGV rather than corrupting the user stack.  [ It was an
oversight that this check was not present before AVX-512 was deployed,
and the result was that there were situations where too-small
sigaltstack were corrupted. ]

This new check currently uses the total XSTATE for its comparison.
However, it doesn’t account for the possibility that feature17 (AMX
TILECONFIG) and later may be in INIT state and never actually written.
And so the check is overly pessimistic, and could kill some legacy
apps that do not need to be killed.

Enhance this check to allow programs that have not requested AMX (and
later) to continue running when their actual stack use fits within
their allocated sigaltstack, even the addition of features17 and later
would not fit.

Update #3: New check upon request to use AMX:
-----------------------------------------------------------------

For an application that registers a too-small sigaltstack, and later
requests access to AMX, the request to access AMX should be denied.

This sequence could occur if a legacy application contains a signal
handler and a hard-coded sigaltstack size, but it links with a new
library that requests use of AMX.  The result should be the same as if
the application and library were to run on a system that does not
support AMX.

[And since this application is prohibited from touching AMX, that
guarantees its signal stack will not grow]

Update #4: New check upon sigaltstack(2)
--------------------------------------------------------

For an application that is granted access to AMX, and then later
registers a too-small sigaltstack, sigaltstack(2) should return an
error and have no effect.

This sequence is the reverse of the above, and is more problematic.
If the app looks at the return code of sigaltstack, it will likely
exit.  If the app ignores the return code from sigaltstack, then it
will proceed to invoke sigaction(SA_ONSTACK), which will return
failure, because there was no preceding successful sigaltstack(2).

Update #5: Enhance prtcl to support synchronous ctx switch buffer allocation.
------------------------------------------------------------------------------------------------------

Linux/AMX v10 supports per-task transparent allocation for 8KB AMX
context switch buffers using XFD hardware support.  The benefit of
this approach is that buffers are allocated only for threads that
actually need them.  However, in OOM conditions, an allocation failure
results in a signal, which is an unfriendly way to fail.

Enhance the existing prctl so that a user can not only ask for
permission for all tasks in the process to access AMX, but for the
kernel to immediately allocate context switch buffers for all current
and future tasks in that process.

If the kernel has an allocation failure in this call, no buffers are
allocated, no permission is granted, and the system call returns an
error.

Note that use of this optional flag may provoke unnecessary allocation
of buffers, perhaps exacerbating the risk of OOM in the first place.

Note that use of this flag does not add any protection from OOM issues
on subsequent thread creation.  With this flag, the actual thread
clone call would fail.  Without this flag, if the clone worked, a
signal would be delivered if and when the clone actually touched AMX
and the kernel was unable to allocate a context switch buffer.

ie. This flag will not necessarily enhance survivability in the face
of run-time OOM issues.  All it does is deliver an initial OOM failure
synchronously.  Also, use of this flag could provoke future OOM errors
due to unnecessary hogging of per task kernel memory.

Currently the system call will allocate buffers for all current and
future threads in a process.  This notion is cleared on EXEC (just as
AMX access permission is cleared on EXEC)

There was some discussion about not allocating for threads that exit
before the call, or only those cloned from a task with a buffer, but
we decided brute force allocating for all tasks was simplest.  We
fully expect most apps to use dynamic-allocation on 1st use, rather
than this flag.

Requirement: AMX-induced XSTATE growth must not cause run-time app failures
-------------------------------------------------------------------------------------------------------------

The Linux signal ABI uses uncompacted XSTATE format.  The same ABI is
in effect, whether the application is using the (large) default stack,
or if it specifies a (user-allocated) sigaltstack(2).  AMX.TMM is
defined as 8KB of data in the XSTATE format, and thus there is a real
risk that users who allocate a sigaltstack() will not make it large
enough to hold XSTATE.  Note that since uncompacted XSTATE includes
all previous features, this is an issue even on hardware that doesn't
support AMX, but supports a feature after AMX "feature19".  Further,
since uncompacted XSTATE format is dedicated by CPUID, its unprotected
use is a risk to programs even though they may not use AMX or
subsequent features. Eg. XSTATE feature19 will appear 8KB after
feature17, even on a CPU that doesn’t support feature18 (AMX.TMM).

Legacy glibc signal.h hard-coded 2K and 8K stack sizes for
applications to use for sigaltstack().  AVX-512 exceeded the 2K limit,
and AMX shall exceed the 8K limit.

Glibc 2.34 shipped on 8/1/2021.  It includes a change to the
hard-coded stack limit to one calculated at run time to reflect the
current hardware.  Apps that use the ABI and re-compile with the
updated glibc should have no problems, whether they use AMX or not.

However this does not benefit legacy binaries that were compiled with
an old glibc, or those which ignore signal.h and allocate a signal
stack using a non-ABI size.  Those apps run on past hardware with a
small sigaltstack(), and they must be able to run on AMX-capable
hardware.

This patch series includes a new prctl(), which must be invoked for a
task in a process to access AMX and later features.

Legacy apps with legacy libraries never call the prctl, Linux used XFD
to enforce that AMX.data stays in INIT, Linux doesn't write zeros for
AMX to the signal stack, and so those apps will not experience any
signal stack growth.

Legacy apps linked with a new library may indirectly invoke the
prctl(AMX).  If the binary had registered a too small sigaltstack, the
prctl() will deny access to AMX.  If the binary registers a too small
sigalstack after success prctl(), the sigalstack() (or subsequent
sigaction()) will return failure.

New sigaltstack apps built with the new glibc properly using the ABI
will allocate a stack large enough for using AMX and later features.

Requirement: kernel ability to control which apps access AMX
----------------------------------------------------------------------------------

As servers get larger, customers are consolidating more functions onto
fewer systems.  The risk of “noisy neighbor” applications interfering
with each other is growing.  This has been seen to be an acute problem
where AVX-512 applications have a greater frequency impact than non
AVX-512 applications.  This impact has been optimized in SPR and newer
hardware, as compared to previous generations, so it should be a lot
less noticeable.  However, like AVX-512 instructions, AMX instructions
can also switch many transistors, and will thus impact maximum
frequency more than simpler instructions.  This impact will be
core-wide, and thus will be seen by threads running on an HT sibling.

In response, Linux requires the ability to exercise “fine grained
control” over which apps can use AMX.  The v10 AMX patch set includes
a “permission” system call for this purpose.  It would be mandated to
be called by all apps that want to access AMX.

Per-Task XCR0 Proposal
----------------------------------
The benefit of a per-task XCR0 would be that application probing for
AMX could do the traditional CPUID+XGETBV(XCR0) for AMX, just like
they did for previous features.

At the same time, Linux could use a per-task XCR0 to implement its
desired “fine grained policy”.  The task asks if XCR0 has AMX, and
Linux can say YES or NO based on policy.

But context switching XCR0 per-task is not viable in a virtualized
environment, as each write would provoke a VMEXIT.  As Linux is the
same on bare metal and on top of a VMM, and a huge portion of our
customers now have some sort of VMM, this VMEXIT penalty prohibits
per-task XCR0 via XCR0 context switches.

However, user-space accesses XCR0 via the XGETBV() instruction.  If
the HW could be made to trap on that instruction such that the kernel
could spoof XCR0, then the kernel would have a mechanism to tell an
app that it can’t access AMX without mandating a new system call.  The
”real” HW XCR0 would still be in effect.  (Since XCR0.AMX=1, Linux
would not have a #UD to aid it in blocking access to AMX, but it can
enforce access via XFD/#NM.)

If trapping XGETBV() is not viable, another approach would be
replacing its use with a system call, say, sys_xgetbv(), to return the
spoofed version instead of the hardware version.  Apps would have to
cut over to this new system call from the native XGETBV().  A simple
system call returning the SW XCR0 is sufficient to let the app know if
it is approved to use AMX or not.  However, if this call is to replace
the v10 prtcl(GET/SET) system call, the kernel has to know that the
app is actually requesting to use AMX, rather than just seeing what is
available.  Only when it knows this is a “request” can it immediately
sanity check if a too-small sigaltstack() was registered.  And so the
proposal would be: allowed-bits = sys_xgetbv(requested-bits).  This is
similar to the v10 prctl(GET), prtl(SET).  However, it has the
advantage of combining the request and the response into a single
call, and it could also replace use of the native XGETBV() in the
current application probe for AMX and other stateful features.

At the end of the day, it seems that we will not be able to trap on
user xgetbv(), and we don't see a significant benefit of combining
GET/SET, so we are sticking with the current prctl().

What we did not have time to talk about:
------------------------------------------------------
There was a request from Boris and Thiago on the list to add an
additional system call, to allow an app to distinguish between what
the HW supports, and what the app has permission to access.  Unclear
if this is part of a larger "Linux needs a better way to probe for
features" ABI, or if this is necessary for initial AMX support.  We'll
see where the discussion on the list leads...

Brainstorm for future: Future-proof lightweight signal ABI
---------------------------------------------------------------------------
The current signal ABI with its uncompacted XSTATE format did not
anticipate large XSTATE features.

After AMX, we should investigate a new signal ABI which would be
immune to problems due to new large state features.

At the same time, the new signal ABI could also be designed to be
efficient and fast.

The legacy ABI supports the signal handler running with a “clean
slate” of register state, while being able to access all signaled
thread state in the XSTATE on the stack.

A lightweight signal handler might start execution with the minimum of
state cleared and saved for its benefit, and all else the signal
handler would have to save itself.

Such a handler would need to be built specially (ala. User-space
interrupt handlers) to not expand, say memcpy() into AVX512, for
example.  The handler is also prohibited from calling routines that
break such rules.

Large state would sit in registers throughout the lifetime of the
signal handler, making it immune to performance scaling issues due to
future large state.  Indeed, this is the fastest possible solution for
a minimal signal handler.

Another proposal is to simply opt-into using XSAVEC format on the
signal stack.  This is the compacted format that the kernel enjoys
during context switch, and has the advantage that it will never grow
due to unused (or unsupported) features.  However, for applications
that actually want to examine or modify the state, accessor routines
to find state based on the XSAVEC would need to be used, rather than
today's fixed offsets.

Finally a hybrid is possible, where legacy XSAVE is used up through
feature16, and a second invocation using XSAVEC is used for feature17
and later.  This would have the advantage of keeping legacy
compatibility for existing features, and adding no growth for unused
future features.  However, decoders to understand the stack format
would need to be updated.

This efforts will take a while to develop, and even longer to deploy,
and so it is necessarily a post-AMX effort.
