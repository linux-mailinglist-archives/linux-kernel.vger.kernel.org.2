Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20BE3F6EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 07:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhHYFNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 01:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbhHYFNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 01:13:13 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22306C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 22:12:28 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIlCx-00Fq6M-Eb; Wed, 25 Aug 2021 05:12:15 +0000
Date:   Wed, 25 Aug 2021 05:12:15 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] fix PTRACE_KILL
Message-ID: <YSXRL4Gt4SVLa+Hl@zeniv-ca.linux.org.uk>
References: <YRrdvKEu2JQxLI5n@zeniv-ca.linux.org.uk>
 <877dgkvsog.fsf@disp2133>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dgkvsog.fsf@disp2133>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 01:21:03PM -0500, Eric W. Biederman wrote:

> > So let it check (under tasklist_lock) that the victim is traced by us
> > and call sig_send_info() to feed it SIGKILL.  It's easier that trying
> > to force ptrace_resume() into handling that mess and it's less brittle
> > that way.
> 
> I took a quick look and despite being deprecated PTRACE_KILL appears
> to still have some active users (like gcc-10).  So that seems to rule

????
What the hell would gcc do with ptrace() to start with, let alone with
PTRACE_KILL?
<greps>

Egads...  
void ThreadSuspender::KillAllThreads() {
  for (uptr i = 0; i < suspended_threads_list_.ThreadCount(); i++)
    internal_ptrace(PTRACE_KILL, suspended_threads_list_.GetThreadID(i),
                    nullptr, nullptr);
}
in libsanitizer/sanitizer_common/sanitizer_stoptheworld_linux_libcdep.cc

OK, obvious comments regarding the authors' sanity aside, here "send
SIGKILL" would clearly be fine.

> I looked at the bug that PTRACE_KILL only kills a process when it is
> stopped and it is present in Linux 1.0.  Given that I expect userspace
> applications are ok with the current semantics rather than the intended
> semantics.

The history is trickier than that.

Originally (and that's all the way back to v6), ptrace(2) failed for
everything that hadn't been in stopped state and traced by the caller.
The only exception had been ptrace(pid, 0) (== PTRACE_TRACEME).
The only stop back then had been in signal delivery.

Predecessor of PTRACE_KILL had been ptrace(pid, 8) (before any enums and
yes, the constant is still the same).  It worked by arranging for exit()
in the context of tracee; see /usr/sys/ken/sig.c in v6 tree (procxmt()
for payload to be run in child, ptrace() for syscall itself).

At some point between 4.3BSD and 4.4BSD PT_ATTACH had been added
(== our PTRACE_ATTACH), and it obviously had checks of its own
that did _not_ require the target to be stopped (let alone to be
already traced by the caller).

In Linux ptrace(2) had been added in 0.95 (well, at some point between
0.12 and 0.95).  The first departure from the usual model had happened
in 0.99pl4.  For some reason PTRACE_DETACH had "target must be stopped"
check removed.  In 0.99pl14 PTRACE_KILL had joined PTRACE_DETACH in
that weirdness, in 0.99pl14b PTRACE_DETACH went back to normal, but
PTRACE_KILL had stuck that way.  No idea why; ask Linus, maybe he remembers.
It's been 28 years, though, so...

At that point we had two ptrace stops - in signal delivery and in
syscall entry (strace stuff).

PTRACE_KILL had become unpleasantly racy - it would make the child
runnable and set child->exit_code to SIGKILL, expecting the child to
pick it from there once it regains the timeslice.  If the child had
been *not* in ptrace stop, all of that would have no effect whatsoever.

ptrace(pid, PTRACE_CONT, ..., SIGKILL) still worked reliably at
that point.  That had changed 9 years later, when we had added new
ptrace stops.  execve() of a traced process used to raise SIGTRAP,
with the usual signal delivery happening on the way to userland.
In a0691b116f6a "Add new ptrace event tracing mechanism" we had
suddenly grown a bunch of (optional) stops, by way of ptrace_event() -
on exec/fork/vfork/clone/exit.  Unfortunately, in each of those stops
ptrace(pid, PTRACE_CONT, ..., signr) ended up with signr quietly ignored.
And in any of them PTRACE_KILL (by then a close relative of PTRACE_CONT)
would quietly do nothing.  Note that ptrace stop on syscall entry/exit
did explicitly raise the signal requested by PTRACE_CONT; the new ones
had not bothered.

Those stops had been uncommon.  However, in 2004 (two years down the
road) Roland's 0cc0515ba006 "[PATCH] make single-step into signal
delivery stop in handler" had added a ptrace stop on single-stepping
into a handler.  And PTRACE_CONT/SIGKILL there will have that SIGKILL
(or any other signal number we pass) completely ignored.  Worse, changing
that behaviour is impossible - if we make PTRACE_CONT in that state
deliver a new signal, we risk breaking any debugger that relies upon
the fact that in such situation ptrace(..., PTRACE_CONT, ...., signr)
ignores signr and had done so for the last 17 years.

By that point signr passing by PTRACE_CONT had become unreliable.
There'd been no good way to tell that stop from the normal stop
on SIGTRAP delivery, short of having examined the state during
the previous stop *and* remembering that you've done PTRACE_SINGLESTEP
from there.  Both parts are required, unfortunately.  Worse, it's not
universal on all architectures - arm64, hexagon, ia64, microblaze,
openrisc, parisc, powerpc, s390, sh, x86 and uml do it, the rest do
not.

Take a look at gdb source and grep for PTRACE_KILL in there; complaints
are impressive (and well-founded).  They end up doing sending SIGKILL
by kill(2); in gdbserver they follow that with PTRACE_KILL, perhaps on
the theory that there's no such thing as overkill...

In 2011 we had another ptrace stop join that bunch - group stop handling
for traced processes.  At some point seccomp shite had been added to
the "events" pile.  All of those have signr (and PTRACE_KILL) ignored,
but by then the thing had already been FUBAR.

> The current semantics also include the weirdness that PTRACE_KILL only
> kills a process when it is stopped in ptrace_signal, and not at other
> ptrace stops.
> 
> So rather than fix the code to do what was intended 27 years ago,
> why don't we accept the fact that PTRACE_KILL is equivalent
> to PTRACE_CONT with data = SIGKILL.

Because it changes behaviour, making it fail visibly for threads not in
ptrace stop?  I agree that it should have been acting that way all along,
but... the same 27 (28, really) years of the current "no error if it's
not stopped" behaviour are there.

> If there are regressions or we really care we can tweak the return value
> to return 0 instead of -ESRCH when the process is not stopped.

How?  You obviously can't blindly change -ESRCH to 0 - it *is* the expected
error when the recepient is not traced by us, after all.  So we'd have to
do... what exactly?  Special-case PTRACE_KILL in ptrace_check_attach()
*and* in its callers?  Open-code ptrace_check_attach() for PTRACE_KILL,
turning it into "yes, call ptrace_freeze_traced(), bailing out if
it fails, but bailing out with 0 instead of -ESRCH", with ptrace_resume()
done in the same function (ptrace_kill()?) we open-code it into?

Frankly, all variants I see are both ugly and hard on the reader.  In
the code that is already way too subtle...

BTW, glibc has an implementation for Hurd in sysdeps/mach/hurd/ptrace.c:
    case PTRACE_KILL:
      va_start (ap, request);
      pid = va_arg (ap, pid_t);
      va_end (ap);
      /* SIGKILL always just terminates the task,
         so normal kill is just the same when traced.  */
      return __kill (pid, SIGKILL);
Which is to say, there it is turned into a signal right on libc level...


It's a mess.  We have two problems with userland API:
	1) PTRACE_KILL doesn't return an error when the target is not stopped.
	2) PTRACE_KILL *and* PTRACE_CONT are unreliable even for stopped
targets - some ptrace stops ignore the signal passed with PTRACE_CONT (and
ignore SIGKILL from PTRACE_KILL).  PTRACE_CONT side of that is impossible
to fix by now.

And that's on top of the internal problems with ptrace_resume() done on
non-stopped child.

The change I'd proposed makes PTRACE_KILL deliver SIGKILL regardless of
the target state; yours is arguably what we should've done from the very
beginning (what we used to have prior to 0.99pl14 and what all other
Unices had been doing all along), but it's a visible change wrt error
returns and I don't see any sane way to paper over that part.

Linus, what would you prefer?  I've no strong preferences here...
