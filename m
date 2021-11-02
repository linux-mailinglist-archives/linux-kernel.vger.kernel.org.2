Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CA6442FDE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 15:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbhKBOLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 10:11:44 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44758 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbhKBOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 10:11:34 -0400
Received: from in02.mta.xmission.com ([166.70.13.52]:48526)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mhuTB-00E5qr-Cm; Tue, 02 Nov 2021 08:08:57 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:53842 helo=email.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mhuT8-00E0KU-Ba; Tue, 02 Nov 2021 08:08:56 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kyle Huey <me@kylehuey.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Marko =?utf-8?B?TcOka2Vsw6Q=?= <marko.makela@mariadb.com>,
        linux-kernel@vger.kernel.org
References: <20211101034147.6203-1-khuey@kylehuey.com>
Date:   Tue, 02 Nov 2021 09:08:23 -0500
In-Reply-To: <20211101034147.6203-1-khuey@kylehuey.com> (Kyle Huey's message
        of "Sun, 31 Oct 2021 20:41:45 -0700")
Message-ID: <877ddqabvs.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mhuT8-00E0KU-Ba;;;mid=<877ddqabvs.fsf@disp2133>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18yLF/TE9fFa+WJxpcr9EUgH3LUy8FYDHg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4986]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Kyle Huey <me@kylehuey.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 2263 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.1 (0.2%), b_tie_ro: 2.8 (0.1%), parse: 0.75
        (0.0%), extract_message_metadata: 11 (0.5%), get_uri_detail_list: 1.62
        (0.1%), tests_pri_-1000: 5 (0.2%), tests_pri_-950: 1.11 (0.0%),
        tests_pri_-900: 0.84 (0.0%), tests_pri_-90: 1900 (83.9%), check_bayes:
        1885 (83.3%), b_tokenize: 6 (0.3%), b_tok_get_all: 1601 (70.8%),
        b_comp_prob: 1.76 (0.1%), b_tok_touch_all: 273 (12.0%), b_finish: 0.81
        (0.0%), tests_pri_0: 327 (14.4%), check_dkim_signature: 0.63 (0.0%),
        check_dkim_adsp: 2.4 (0.1%), poll_dns_idle: 0.15 (0.0%), tests_pri_10:
        2.5 (0.1%), tests_pri_500: 8 (0.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] signal: SIGKILL can cause signal effects to appear at PTRACE_EVENT_EXIT without tracer notification
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Huey <me@kylehuey.com> writes:

> rr, a userspace record and replay debugger[0], uses the recorded register
> state at PTRACE_EVENT_EXIT to find the point in time at which to cease
> executing the program during replay.
>
> If a SIGKILL races with processing another signal in get_signal, it is
> possible for the kernel to decline to notify the tracer of the original
> signal. But if the original signal had a handler, the kernel proceeds
> with setting up a signal handler frame as if the tracer had chosen to
> deliver the signal unmodified to the tracee. When the kernel goes to
> execute the signal handler that it has now modified the stack and registers
> for, it will discover the pending SIGKILL, and terminate the tracee
> without executing the handler. When PTRACE_EVENT_EXIT is delivered to
> the tracer, however, the effects of handler setup will be visible to
> the tracer.
>
> Because rr (the tracer) was never notified of the signal, it is not aware
> that a signal handler frame was set up and expects the state of the program
> at PTRACE_EVENT_EXIT to be a state that will be reconstructed naturally
> by allowing the program to execute from the last event. When that fails
> to happen during replay, rr will assert and die.
>
> The following patches add an explicit check for a newly pending SIGKILL
> after the ptracer has been notified and the siglock has been reacquired.
> If this happens, we stop processing the current signal and proceed
> immediately to handling the SIGKILL. This makes the state reported at
> PTRACE_EVENT_EXIT the unmodified state of the program, and also avoids the
> work to set up a signal handler frame that will never be used.
>
> This issue was originally reported by the credited rr user.
>
> [0] https://rr-project.org/

If I read this correctly the problem is not precisely that the rr
debugger is never notified about the signal, but rather that the program
is killed with SIGKILL before rr can read the notification and see which
signal it is.

This definitely sounds like a quality of implementation issue.

The solution that is proposed in your patches simply drops the signal
when SIGKILL is pending.

I think we can have a slightly better of quality of implementation
than that (as well as a simpler implementation) by requeuing the
signal instead of simply dropping it.  Something like the below.

Can you test that and see if it works for you?

Eric

diff --git a/kernel/signal.c b/kernel/signal.c
index 056a107e3cbc..0dff366b9129 100644
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

