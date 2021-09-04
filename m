Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65944400D84
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 01:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhIDXXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 19:23:46 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:45184 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbhIDXXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 19:23:45 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMevT-0019im-JH; Sat, 04 Sep 2021 23:18:19 +0000
Date:   Sat, 4 Sep 2021 23:18:19 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Kyle Huey <me@kylehuey.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC] another signal oddity
Message-ID: <YTP+u6Kb3xguT0sN@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Suppose we are sending e.g. SIGINT to a process
(by kill(2)).  The target has two threads -
	* thread1 (leader) that has SIGINT blocked
	* thread2 that does *not* have SIGINT blocked
	* thread2 is ptraced and running (not in ptrace stop).
	* handler for SIGINT is SIG_DFL.

complete_signal() is called.  want_signal(SIGINT, thread1)
is false.  type is not PIDTYPE_PID and thread_group_empty()
is false.  want_signal(SIGINT, thread2) is true, so we end
up with signal->curr_target and t set to thread2.
p is thread1.

And then we hit this:
        if (sig_fatal(p, sig) &&
True - the handler is SIG_DFL and unhandled SIGINT is fatal
            !(signal->flags & SIGNAL_GROUP_EXIT) &&
True - we are not in group exit.
            !sigismember(&t->real_blocked, sig) &&
True - nobody is in sigtimedwait(), so ->real_blocked is empty.
            (sig == SIGKILL || !p->ptrace)) {
Also true - thread1 is not ptraced.

So we go ahead and initiate a group exit.  Both thread1 and
thread2 get SIGKILL added to ->blocked and are woken up.

But AFAICS we have no business doing that - thread1 has SIGINT
blocked, so get_signal() in it would not pick that SIGINT.
And thread2 is traced, so picking SIGINT would've hit
ptrace_signal(), stop and let the tracer deal with it.  If
the tracer decides to cancel that SIGINT, we would continue
just fine.

Which order of execution could possibly lead to fatal signal
delivery?

IDGI...  Looks like that !p->ptrace used to be !t->ptrace until
426915796cca "kernel/signal.c: remove the no longer needed
SIGNAL_UNKILLABLE check in complete_signal()" back in 2017,
but I don't see anything in commit message that would explain
that part of changes.  The testcase in there wouldn't care
either way...

What am I missing here?
