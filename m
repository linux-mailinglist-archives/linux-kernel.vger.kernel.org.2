Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE5400BB0
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 16:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbhIDOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 10:46:11 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:40442 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236587AbhIDOqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 10:46:09 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mMWsj-0014LY-1W; Sat, 04 Sep 2021 14:42:57 +0000
Date:   Sat, 4 Sep 2021 14:42:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [possible bug] missed wakeup in do_sigtimedwait()?
Message-ID: <YTOF8VYTYNFYpB7O@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_sigtimedwait():
        spin_lock_irq(&tsk->sighand->siglock);
        sig = dequeue_signal(tsk, &mask, info);
nope, nothing posted yet
        if (!sig && timeout) {
                /*
                 * None ready, temporarily unblock those we're interested
                 * while we are sleeping in so that we'll be awakened when
                 * they arrive. Unblocking is always fine, we can avoid
                 * set_current_blocked().
                 */
                tsk->real_blocked = tsk->blocked;
                sigandsets(&tsk->blocked, &tsk->blocked, &mask);
                recalc_sigpending();
                spin_unlock_irq(&tsk->sighand->siglock);
... and now somebody sends us a signal.  signal_wake_up() does nothing,
since we are still in TASK_RUNNING at that point

                __set_current_state(TASK_INTERRUPTIBLE);
                ret = freezable_schedule_hrtimeout_range(to, tsk->timer_slack_ns,
                                                         HRTIMER_MODE_REL);
... and we go to sleep for the duration of timeout or until the next
signal to arrive.

                spin_lock_irq(&tsk->sighand->siglock);
                __set_task_blocked(tsk, &tsk->real_blocked);
                sigemptyset(&tsk->real_blocked);
                sig = dequeue_signal(tsk, &mask, info);
... now we finally dequeue the sucker that had been pending through the
entire timeout period.

        }
        spin_unlock_irq(&tsk->sighand->siglock);

Looks like that __set_current_state() should've been done before dropping
the siglock.  Am I missing something subtle here?  It's not a terribly
wide window, but it's not impossible to hit e.g. on KVM and it does look
like a missed wakeup problem...  For that matter, spin_unlock_irq() might
run irq handlers, so it's not impossible to hit on the real hardware either.
