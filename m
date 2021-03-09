Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED2332E45
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 19:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhCIS1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 13:27:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35153 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230094AbhCIS1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 13:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615314426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IdwtO+nBORLyUijXVXbOxgr/gsljMvfSaB/v2q3YioQ=;
        b=Ufo2URWnGgeo4TB2GCOEkgLCcNXGGjqjcc/5UWMIimxWT+YyRpCh0eWJ/rfN4n96Y8FbjU
        UPM7qOvE1BFWc0r5qB/IS+VTiNkulqMDiUpR4c2eCKn2Cmnjsa3po7+FAi7NGvsVMXG9Mv
        aNS9S+oV55GTqL1AjyECzOv61aK4Irk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-C5V6JJxjOpev1uX7jV7g7w-1; Tue, 09 Mar 2021 13:27:04 -0500
X-MC-Unique: C5V6JJxjOpev1uX7jV7g7w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF18E804333;
        Tue,  9 Mar 2021 18:27:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.83])
        by smtp.corp.redhat.com (Postfix) with SMTP id CC15160CCD;
        Tue,  9 Mar 2021 18:26:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  9 Mar 2021 19:27:02 +0100 (CET)
Date:   Tue, 9 Mar 2021 19:26:58 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Qianli Zhao <zhaoqianligood@gmail.com>
Cc:     christian@brauner.io, axboe@kernel.dk, ebiederm@xmission.com,
        tglx@linutronix.de, pcc@google.com, linux-kernel@vger.kernel.org,
        zhaoqianli@xiaomi.com
Subject: Re: [PATCH] exit: trigger panic when init process is set to
 SIGNAL_GROUP_EXIT
Message-ID: <20210309182657.GA1408@redhat.com>
References: <1615296712-175334-1-git-send-email-zhaoqianligood@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615296712-175334-1-git-send-email-zhaoqianligood@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09, Qianli Zhao wrote:
>
> From: Qianli Zhao <zhaoqianli@xiaomi.com>
>
> Once any init thread finds SIGNAL_GROUP_EXIT, trigger panic immediately
> instead of last thread of global init has exited, and do not allow other
> init threads to exit, protect task/memory state of all sub-threads for
> get reliable init coredump

To be honest, I don't understand the changelog. It seems that you want
to uglify the kernel to simplify the debugging of buggy init? Or what?

Nor can I understand the patch. I fail to understand the games with
SIGNAL_UNKILLABLE and ->siglock.

And iiuc with this patch the kernel will crash if init's sub-thread execs,
signal_group_exit() returns T in this case.

Oleg.

> [   24.705376] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
> [   24.705382] CPU: 4 PID: 552 Comm: init Tainted: G S         O    4.14.180-perf-g4483caa8ae80-dirty #1
> [   24.705390] kernel BUG at include/linux/pid_namespace.h:98!
> 
> PID: 552   CPU: 4   COMMAND: "init"
> PID: 1     CPU: 7   COMMAND: "init"
> core4				core7
> ...				sys_exit_group()
> 				do_group_exit()
> 				    - sig->flags = SIGNAL_GROUP_EXIT
> 				    - zap_other_threads()
> 				do_exit()
> 				    - PF_EXITING is set
> ret_to_user()
> do_notify_resume()
> get_signal()
>     - signal_group_exit
>     - goto fatal;
> do_group_exit()
> do_exit()
>     - PF_EXITING is set
>     - panic("Attempted to kill init! exitcode=0x%08x\n")
> 				exit_notify()
> 				find_alive_thread() //no alive sub-threads
> 				zap_pid_ns_processes()//CONFIG_PID_NS is not set
> 				BUG()
> 
> Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
> ---
> We got an init crash issue, but we can't get init coredump from fulldump, we also
> see BUG() triggered which calling in zap_pid_ns_processes().
> 
> From crash dump we can get the following information:
> 1. "Attempted to kill init",init process is killed.
> - Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
> 2. At the same time as init crash, a BUG() triggered in other core.
> - [   24.705390] kernel BUG at include/linux/pid_namespace.h:98!
> 3. When init thread calls exit_mm, the corresponding thread task->mm will be empty, which is not conducive to extracting coredump
> 
> To fix the issue and save complete coredump, once find init thread is set to SIGNAL_GROUP_EXIT
> trigger panic immediately,and other child threads are not allowed to exit just wait for reboot
> 
> PID: 1      TASK: ffffffc973126900  CPU: 7   COMMAND: "init"
>  #0 [ffffff800805ba60] perf_trace_kernel_panic_late at ffffff99ac0bcbcc
>  #1 [ffffff800805bac0] die at ffffff99ac08dc64
>  #2 [ffffff800805bb10] bug_handler at ffffff99ac08e398
>  #3 [ffffff800805bbc0] brk_handler at ffffff99ac08529c
>  #4 [ffffff800805bc80] do_debug_exception at ffffff99ac0814e4
>  #5 [ffffff800805bdf0] el1_dbg at ffffff99ac083298
> ->Exception
>     /home/work/courbet-r-stable-build/kernel/msm-4.14/include/linux/pid_namespace.h: 98
>  #6 [ffffff800805be20] do_exit at ffffff99ac0c22e8
>  #7 [ffffff800805be80] do_group_exit at ffffff99ac0c2658
>  #8 [ffffff800805beb0] sys_exit_group at ffffff99ac0c266c
>  #9 [ffffff800805bff0] el0_svc_naked at ffffff99ac083cf
> ->SYSCALLNO: 5e (__NR_exit_group) 
> 
> PID: 552    TASK: ffffffc9613c8f00  CPU: 4   COMMAND: "init"
>  #0 [ffffff801455b870] __delay at ffffff99ad32cc14
>  #1 [ffffff801455b8b0] __const_udelay at ffffff99ad32cd10
>  #2 [ffffff801455b8c0] msm_trigger_wdog_bite at ffffff99ac5d5be0
>  #3 [ffffff801455b980] do_msm_restart at ffffff99acccc3f8
>  #4 [ffffff801455b9b0] machine_restart at ffffff99ac085dd0
>  #5 [ffffff801455b9d0] emergency_restart at ffffff99ac0eb6dc
>  #6 [ffffff801455baf0] panic at ffffff99ac0bd008
>  #7 [ffffff801455bb70] do_exit at ffffff99ac0c257c
>     /home/work/courbet-r-stable-build/kernel/msm-4.14/kernel/exit.c: 842
>  #8 [ffffff801455bbd0] do_group_exit at ffffff99ac0c2644
>  #9 [ffffff801455bcc0] get_signal at ffffff99ac0d1384
> #10 [ffffff801455be60] do_notify_resume at ffffff99ac08b2a8
> #11 [ffffff801455bff0] work_pending at ffffff99ac083b8c
> 
> ---
>  kernel/exit.c | 29 +++++++++++++++++++++--------
>  1 file changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/exit.c b/kernel/exit.c
> index ef2fb929..6b2da22 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -758,6 +758,27 @@ void __noreturn do_exit(long code)
>  	validate_creds_for_do_exit(tsk);
>  
>  	/*
> +	 * Once init group is marked for death,
> +	 * panic immediately to get a useable coredump
> +	 */
> +	if (unlikely(is_global_init(tsk) &&
> +	    signal_group_exit(tsk->signal))) {
> +		spin_lock_irq(&tsk->sighand->siglock);
> +		if (!(tsk->signal->flags & SIGNAL_UNKILLABLE)) {
> +			tsk->signal->flags |= SIGNAL_UNKILLABLE;
> +			spin_unlock_irq(&tsk->sighand->siglock);
> +			panic("Attempted to kill init! exitcode=0x%08x\n",
> +				tsk->signal->group_exit_code ?: (int)code);
> +		} else {
> +			/* init sub-thread is dying, just wait for reboot */
> +			spin_unlock_irq(&tsk->sighand->siglock);
> +			futex_exit_recursive(tsk);
> +			set_current_state(TASK_UNINTERRUPTIBLE);
> +			schedule();
> +		}
> +	}
> +
> +	/*
>  	 * We're taking recursive faults here in do_exit. Safest is to just
>  	 * leave this task alone and wait for reboot.
>  	 */
> @@ -776,14 +797,6 @@ void __noreturn do_exit(long code)
>  	acct_update_integrals(tsk);
>  	group_dead = atomic_dec_and_test(&tsk->signal->live);
>  	if (group_dead) {
> -		/*
> -		 * If the last thread of global init has exited, panic
> -		 * immediately to get a useable coredump.
> -		 */
> -		if (unlikely(is_global_init(tsk)))
> -			panic("Attempted to kill init! exitcode=0x%08x\n",
> -				tsk->signal->group_exit_code ?: (int)code);
> -
>  #ifdef CONFIG_POSIX_TIMERS
>  		hrtimer_cancel(&tsk->signal->real_timer);
>  		exit_itimers(tsk->signal);
> -- 
> 1.9.1
> 

