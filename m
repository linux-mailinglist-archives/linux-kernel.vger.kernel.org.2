Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CEF443516
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 19:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhKBSJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 14:09:44 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:48572 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhKBSJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 14:09:42 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:57246)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mhyBZ-00EXk2-CU; Tue, 02 Nov 2021 12:07:01 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:36458 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mhyBX-00EgBL-Rh; Tue, 02 Nov 2021 12:07:00 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kyle Huey <me@kylehuey.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        Marko =?utf-8?B?TcOka2Vsw6Q=?= <marko.makela@mariadb.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211101034147.6203-1-khuey@kylehuey.com>
        <877ddqabvs.fsf@disp2133>
        <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
Date:   Tue, 02 Nov 2021 13:06:32 -0500
In-Reply-To: <CAP045AqJVXA60R9RF8Gb2PWGBsK6bZ7tVBkdCcPYYrp6rOkG-Q@mail.gmail.com>
        (Kyle Huey's message of "Tue, 2 Nov 2021 09:01:19 -0700")
Message-ID: <87fsse8maf.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mhyBX-00EgBL-Rh;;;mid=<87fsse8maf.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19glLJYUumwVtWxnHVY7tuRZNIQu60pijA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kyle Huey <me@kylehuey.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 860 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.6 (0.4%), b_tie_ro: 2.6 (0.3%), parse: 0.74
        (0.1%), extract_message_metadata: 13 (1.6%), get_uri_detail_list: 2.3
        (0.3%), tests_pri_-1000: 11 (1.3%), tests_pri_-950: 0.92 (0.1%),
        tests_pri_-900: 0.73 (0.1%), tests_pri_-90: 359 (41.8%), check_bayes:
        343 (39.9%), b_tokenize: 8 (0.9%), b_tok_get_all: 9 (1.1%),
        b_comp_prob: 2.1 (0.2%), b_tok_touch_all: 321 (37.3%), b_finish: 0.62
        (0.1%), tests_pri_0: 457 (53.2%), check_dkim_signature: 0.44 (0.1%),
        check_dkim_adsp: 2.3 (0.3%), poll_dns_idle: 0.16 (0.0%), tests_pri_10:
        2.6 (0.3%), tests_pri_500: 8 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: SIGKILL can cause signal effects to appear at PTRACE_EVENT_EXIT without tracer notification
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Huey <me@kylehuey.com> writes:

> On Tue, Nov 2, 2021 at 7:09 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Kyle Huey <me@kylehuey.com> writes:
>>
>> > rr, a userspace record and replay debugger[0], uses the recorded register
>> > state at PTRACE_EVENT_EXIT to find the point in time at which to cease
>> > executing the program during replay.
>> >
>> > If a SIGKILL races with processing another signal in get_signal, it is
>> > possible for the kernel to decline to notify the tracer of the original
>> > signal. But if the original signal had a handler, the kernel proceeds
>> > with setting up a signal handler frame as if the tracer had chosen to
>> > deliver the signal unmodified to the tracee. When the kernel goes to
>> > execute the signal handler that it has now modified the stack and registers
>> > for, it will discover the pending SIGKILL, and terminate the tracee
>> > without executing the handler. When PTRACE_EVENT_EXIT is delivered to
>> > the tracer, however, the effects of handler setup will be visible to
>> > the tracer.
>> >
>> > Because rr (the tracer) was never notified of the signal, it is not aware
>> > that a signal handler frame was set up and expects the state of the program
>> > at PTRACE_EVENT_EXIT to be a state that will be reconstructed naturally
>> > by allowing the program to execute from the last event. When that fails
>> > to happen during replay, rr will assert and die.
>> >
>> > The following patches add an explicit check for a newly pending SIGKILL
>> > after the ptracer has been notified and the siglock has been reacquired.
>> > If this happens, we stop processing the current signal and proceed
>> > immediately to handling the SIGKILL. This makes the state reported at
>> > PTRACE_EVENT_EXIT the unmodified state of the program, and also avoids the
>> > work to set up a signal handler frame that will never be used.
>> >
>> > This issue was originally reported by the credited rr user.
>> >
>> > [0] https://rr-project.org/
>>
>> If I read this correctly the problem is not precisely that the rr
>> debugger is never notified about the signal, but rather that the program
>> is killed with SIGKILL before rr can read the notification and see which
>> signal it is.
>
> The precise problem is that the kernel made a modification to the
> tracee state (setting up the signal handler frame) without telling the
> tracer about it (delivering the ptrace notification for the pending
> non-SIGKILL signal).

Except the kernel did make it to ptrace_stop.  The stop just did not
fully happen because of SIGKILL.  I expect SIGCHLD was sent to the
tracer as part of that stop that never fully happened.

> That can be fixed either by not modifying the
> tracee state here or by telling the tracer about the signal (that will
> never actually run). I suspect we'll all agree that the former seems
> preferable.
>
>> This definitely sounds like a quality of implementation issue.
>>
>> The solution that is proposed in your patches simply drops the signal
>> when SIGKILL is pending.
>
> That's right.
>
>> I think we can have a slightly better of quality of implementation
>> than that (as well as a simpler implementation) by requeuing the
>> signal instead of simply dropping it.  Something like the below.
>
> What is the benefit of requeueing the signal? All pending signals will
> be dropped when the SIGKILL is processed, no?

Not before PTRACE_EVENT_EXIT.  In fact the pending signals are not
actually flushed until the thread or the entire process is reaped.

Further the coredump code makes some attempt to write out the
pending signals.  The code appears to predate siginfo support
in the kernel so it misses a lot but it is there.

The real advantage is that it keeps the logic of dealing with weird
ptrace_stop logic in ptrace_signal where it belongs.  It also allows the
common (and missing in this case) idiom of goto relock to be used.

So I think changing ptrace_signal will be much more maintainable.

>> Can you test that and see if it works for you?
>
> It does not work. This triggers an infinite loop in get_signal, as we
> dequeue the signal, attempt to notify the ptracer, see the pending
> sigkill, requeue the signal, go around the loop, dequeue the original
> signal ...

Apologies I made a bit of a thinko.  That change also needs to change
the handling of if (signr == 0) after ptrace_signal.

Which means it would need to be something like the below.

diff --git a/kernel/signal.c b/kernel/signal.c
index 056a107e3cbc..eddb745b34a7 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2610,7 +2610,8 @@ static int ptrace_signal(int signr, kernel_siginfo_t *info)
 	}
 
 	/* If the (new) signal is now blocked, requeue it.  */
-	if (sigismember(&current->blocked, signr)) {
+	if (sigismember(&current->blocked, signr) ||
+	    signal_group_exit(current->signal)) {
 		send_signal(signr, info, current, PIDTYPE_PID);
 		signr = 0;
 	}
@@ -2764,8 +2765,10 @@ bool get_signal(struct ksignal *ksig)
 		if (unlikely(current->ptrace) && (signr != SIGKILL) &&
 		    !(sighand->action[signr -1].sa.sa_flags & SA_IMMUTABLE)) {
 			signr = ptrace_signal(signr, &ksig->info);
-			if (!signr)
-				continue;
+			if (!signr) {
+				spin_unlock_irq(&sighand->siglock);
+				goto relock;
+			}
 		}
 
 		ka = &sighand->action[signr-1];

Eric
