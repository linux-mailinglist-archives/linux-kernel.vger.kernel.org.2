Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE5E334375
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhCJQpR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 Mar 2021 11:45:17 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:34946 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbhCJQor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:44:47 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK1wy-00DDXh-3E; Wed, 10 Mar 2021 09:44:44 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lK1ww-000HEG-C4; Wed, 10 Mar 2021 09:44:43 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     qianli zhao <zhaoqianligood@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, christian@brauner.io,
        axboe@kernel.dk, Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
References: <1615296712-175334-1-git-send-email-zhaoqianligood@gmail.com>
        <20210309182657.GA1408@redhat.com>
        <CAPx_LQEQto2fget=kCnfjSCdAp9XCwc2AWgzwxpbxdyCgNs5Mg@mail.gmail.com>
Date:   Wed, 10 Mar 2021 10:44:46 -0600
In-Reply-To: <CAPx_LQEQto2fget=kCnfjSCdAp9XCwc2AWgzwxpbxdyCgNs5Mg@mail.gmail.com>
        (qianli zhao's message of "Wed, 10 Mar 2021 11:59:41 +0800")
Message-ID: <m1lfavufep.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1lK1ww-000HEG-C4;;;mid=<m1lfavufep.fsf@fess.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+9KH7c+QID5w5XESlFCn9AxAaajfrWimE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,LotsOfNums_01,T_TM2_M_HEADER_IN_MSG,XMSubLong,
        XM_B_SpammyWords,XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  1.2 LotsOfNums_01 BODY: Lots of long strings of numbers
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.2 XM_B_SpammyWords One or more commonly used spammy words
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;qianli zhao <zhaoqianligood@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1141 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 11 (0.9%), b_tie_ro: 9 (0.8%), parse: 2.2 (0.2%),
        extract_message_metadata: 26 (2.3%), get_uri_detail_list: 8 (0.7%),
        tests_pri_-1000: 7 (0.6%), tests_pri_-950: 1.82 (0.2%),
        tests_pri_-900: 1.56 (0.1%), tests_pri_-90: 177 (15.5%), check_bayes:
        141 (12.3%), b_tokenize: 32 (2.8%), b_tok_get_all: 16 (1.4%),
        b_comp_prob: 7 (0.6%), b_tok_touch_all: 81 (7.1%), b_finish: 1.24
        (0.1%), tests_pri_0: 886 (77.7%), check_dkim_signature: 0.64 (0.1%),
        check_dkim_adsp: 2.5 (0.2%), poll_dns_idle: 0.45 (0.0%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 20 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] exit: trigger panic when init process is set to SIGNAL_GROUP_EXIT
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qianli zhao <zhaoqianligood@gmail.com> writes:

> Hi,Oleg
>
> Thanks for your replay.
>
>> To be honest, I don't understand the changelog. It seems that you want
>> to uglify the kernel to simplify the debugging of buggy init? Or what?
>
> My patch is for the following purpose:
> 1. I hope to fix the occurrence of unexpected panic
> - [   24.705390] kernel BUG at include/linux/pid_namespace.h:98!
> This problem occurs when both two init threads enter the do_exit,
> One of the init thread is syscall sys_exit_group,and set SIGNAL_GROUP_EXIT
> The other init thread perform ret_to_user()->get_signal() and found
> SIGNAL_GROUP_EXIT is set,then do_group_exit()->do_exit()
> Since there are no alive init threads it finally goes to
> zap_pid_ns_processes() and BUG().
> Timing details are in the changelog.

At the start of your changelog and your patch subject you describe what
you are doing but not why.  For the next revision of the patch please
lead with the why it makes what you are trying to do much easier to
understand.

> 2. I hope to fix the problem that coredump cannot be parsed after init
> crash Before my patch,ever init sub-thread will finish do_exit(),the last
> thread will trigger panic().
> Except for the thread that triggered the panic,the state(such as
> PF_EXITING etc) of the other threads is already exiting,so we can't
> parse coredump from fulldump
> In fact, when any one init has been set to SIGNAL_GROUP_EXIT, then we
> can trigger panic,and prevent other init threads from continuing to
> exit
>
>> Nor can I understand the patch. I fail to understand the games with
>> SIGNAL_UNKILLABLE and ->siglock.
>
> When first init thread panic,i don't want other init threads to still
> exit,this will destroy the state of other init threads.
> so i use SIGNAL_UNKILLABLE to mark this stat,prevent other init
> threads from continuing to exit
> In addition i use siglock to protect tsk->signal->flags.

It does not work to use SIGNAL_UNKILLABLE for this.  Normally init
has SIGNAL_UNKILLABLE set.  The only case that clears SIGNAL_UNKILLABLE
is force_sig_info_to_task.  If the init process exits with exit(2)
SIGNAL_UNKILLABLE will already be set.  Which means testing
SIGNAL_UNKILLABLE as your patch does will prevent the panic.

Further simply calling panic is sufficient to guarantee that the other
threads don't exit, and that whichever thread calls panic first
will be the reporting thread.  The rest of the threads will be caught
in panic_smp_self_stop(), if they happen to be running on other cpus.

So I would make the whole thing just be:

	/* If global init has exited,
         * panic immediately to get a useable coredump.
         */
	if (unlikely(is_global_init(tsk) &&
	    (thread_group_empty(tsk) ||
            (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
		panic("Attempted to kill init!	exitcode=0x%08x\n",
                	tsk->signal->group_exit_code ?: (int)code);
	}

The thread_group_empty test is needed to handle single threaded
inits.

Do you think you can respin your patch as something like that?

Eric

>
>> And iiuc with this patch the kernel will crash if init's sub-thread execs,
>> signal_group_exit() returns T in this case.
>
> Oleg Nesterov <oleg@redhat.com> 于2021年3月10日周三 上午2:27写道：
>>
>> On 03/09, Qianli Zhao wrote:
>> >
>> > From: Qianli Zhao <zhaoqianli@xiaomi.com>
>> >
>> > Once any init thread finds SIGNAL_GROUP_EXIT, trigger panic immediately
>> > instead of last thread of global init has exited, and do not allow other
>> > init threads to exit, protect task/memory state of all sub-threads for
>> > get reliable init coredump
>>
>> To be honest, I don't understand the changelog. It seems that you want
>> to uglify the kernel to simplify the debugging of buggy init? Or what?
>>
>> Nor can I understand the patch. I fail to understand the games with
>> SIGNAL_UNKILLABLE and ->siglock.
>>
>> And iiuc with this patch the kernel will crash if init's sub-thread execs,
>> signal_group_exit() returns T in this case.
>>
>> Oleg.
>>
>> > [   24.705376] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
>> > [   24.705382] CPU: 4 PID: 552 Comm: init Tainted: G S         O    4.14.180-perf-g4483caa8ae80-dirty #1
>> > [   24.705390] kernel BUG at include/linux/pid_namespace.h:98!
>> >
>> > PID: 552   CPU: 4   COMMAND: "init"
>> > PID: 1     CPU: 7   COMMAND: "init"
>> > core4                         core7
>> > ...                           sys_exit_group()
>> >                               do_group_exit()
>> >                                   - sig->flags = SIGNAL_GROUP_EXIT
>> >                                   - zap_other_threads()
>> >                               do_exit()
>> >                                   - PF_EXITING is set
>> > ret_to_user()
>> > do_notify_resume()
>> > get_signal()
>> >     - signal_group_exit
>> >     - goto fatal;
>> > do_group_exit()
>> > do_exit()
>> >     - PF_EXITING is set
>> >     - panic("Attempted to kill init! exitcode=0x%08x\n")
>> >                               exit_notify()
>> >                               find_alive_thread() //no alive sub-threads
>> >                               zap_pid_ns_processes()//CONFIG_PID_NS is not set
>> >                               BUG()
>> >
>> > Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
>> > ---
>> > We got an init crash issue, but we can't get init coredump from fulldump, we also
>> > see BUG() triggered which calling in zap_pid_ns_processes().
>> >
>> > From crash dump we can get the following information:
>> > 1. "Attempted to kill init",init process is killed.
>> > - Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
>> > 2. At the same time as init crash, a BUG() triggered in other core.
>> > - [   24.705390] kernel BUG at include/linux/pid_namespace.h:98!
>> > 3. When init thread calls exit_mm, the corresponding thread task->mm will be empty, which is not conducive to extracting coredump
>> >
>> > To fix the issue and save complete coredump, once find init thread is set to SIGNAL_GROUP_EXIT
>> > trigger panic immediately,and other child threads are not allowed to exit just wait for reboot
>> >
>> > PID: 1      TASK: ffffffc973126900  CPU: 7   COMMAND: "init"
>> >  #0 [ffffff800805ba60] perf_trace_kernel_panic_late at ffffff99ac0bcbcc
>> >  #1 [ffffff800805bac0] die at ffffff99ac08dc64
>> >  #2 [ffffff800805bb10] bug_handler at ffffff99ac08e398
>> >  #3 [ffffff800805bbc0] brk_handler at ffffff99ac08529c
>> >  #4 [ffffff800805bc80] do_debug_exception at ffffff99ac0814e4
>> >  #5 [ffffff800805bdf0] el1_dbg at ffffff99ac083298
>> > ->Exception
>> >     /home/work/courbet-r-stable-build/kernel/msm-4.14/include/linux/pid_namespace.h: 98
>> >  #6 [ffffff800805be20] do_exit at ffffff99ac0c22e8
>> >  #7 [ffffff800805be80] do_group_exit at ffffff99ac0c2658
>> >  #8 [ffffff800805beb0] sys_exit_group at ffffff99ac0c266c
>> >  #9 [ffffff800805bff0] el0_svc_naked at ffffff99ac083cf
>> > ->SYSCALLNO: 5e (__NR_exit_group)
>> >
>> > PID: 552    TASK: ffffffc9613c8f00  CPU: 4   COMMAND: "init"
>> >  #0 [ffffff801455b870] __delay at ffffff99ad32cc14
>> >  #1 [ffffff801455b8b0] __const_udelay at ffffff99ad32cd10
>> >  #2 [ffffff801455b8c0] msm_trigger_wdog_bite at ffffff99ac5d5be0
>> >  #3 [ffffff801455b980] do_msm_restart at ffffff99acccc3f8
>> >  #4 [ffffff801455b9b0] machine_restart at ffffff99ac085dd0
>> >  #5 [ffffff801455b9d0] emergency_restart at ffffff99ac0eb6dc
>> >  #6 [ffffff801455baf0] panic at ffffff99ac0bd008
>> >  #7 [ffffff801455bb70] do_exit at ffffff99ac0c257c
>> >     /home/work/courbet-r-stable-build/kernel/msm-4.14/kernel/exit.c: 842
>> >  #8 [ffffff801455bbd0] do_group_exit at ffffff99ac0c2644
>> >  #9 [ffffff801455bcc0] get_signal at ffffff99ac0d1384
>> > #10 [ffffff801455be60] do_notify_resume at ffffff99ac08b2a8
>> > #11 [ffffff801455bff0] work_pending at ffffff99ac083b8c
>> >
>> > ---
>> >  kernel/exit.c | 29 +++++++++++++++++++++--------
>> >  1 file changed, 21 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/kernel/exit.c b/kernel/exit.c
>> > index ef2fb929..6b2da22 100644
>> > --- a/kernel/exit.c
>> > +++ b/kernel/exit.c
>> > @@ -758,6 +758,27 @@ void __noreturn do_exit(long code)
>> >       validate_creds_for_do_exit(tsk);
>> >
>> >       /*
>> > +      * Once init group is marked for death,
>> > +      * panic immediately to get a useable coredump
>> > +      */
>> > +     if (unlikely(is_global_init(tsk) &&
>> > +         signal_group_exit(tsk->signal))) {
>> > +             spin_lock_irq(&tsk->sighand->siglock);
>> > +             if (!(tsk->signal->flags & SIGNAL_UNKILLABLE)) {
>> > +                     tsk->signal->flags |= SIGNAL_UNKILLABLE;
>> > +                     spin_unlock_irq(&tsk->sighand->siglock);
>> > +                     panic("Attempted to kill init! exitcode=0x%08x\n",
>> > +                             tsk->signal->group_exit_code ?: (int)code);
>> > +             } else {
>> > +                     /* init sub-thread is dying, just wait for reboot */
>> > +                     spin_unlock_irq(&tsk->sighand->siglock);
>> > +                     futex_exit_recursive(tsk);
>> > +                     set_current_state(TASK_UNINTERRUPTIBLE);
>> > +                     schedule();
>> > +             }
>> > +     }
>> > +
>> > +     /*
>> >        * We're taking recursive faults here in do_exit. Safest is to just
>> >        * leave this task alone and wait for reboot.
>> >        */
>> > @@ -776,14 +797,6 @@ void __noreturn do_exit(long code)
>> >       acct_update_integrals(tsk);
>> >       group_dead = atomic_dec_and_test(&tsk->signal->live);
>> >       if (group_dead) {
>> > -             /*
>> > -              * If the last thread of global init has exited, panic
>> > -              * immediately to get a useable coredump.
>> > -              */
>> > -             if (unlikely(is_global_init(tsk)))
>> > -                     panic("Attempted to kill init! exitcode=0x%08x\n",
>> > -                             tsk->signal->group_exit_code ?: (int)code);
>> > -
>> >  #ifdef CONFIG_POSIX_TIMERS
>> >               hrtimer_cancel(&tsk->signal->real_timer);
>> >               exit_itimers(tsk->signal);
>> > --
>> > 1.9.1
>> >
>>
