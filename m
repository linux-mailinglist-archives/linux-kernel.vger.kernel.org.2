Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA6533F2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 15:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbhCQOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 10:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231958AbhCQOiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 10:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615991894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6QjnS9M1RvzfgWf8ySCR1tl4IInYd9EOwZcLOFR1ryI=;
        b=i7VcyMD1T3HjfjyfZXsXgr3NJEIzuI7q7NFLl/kKPi/T0dNULGAcw34+vDznpRd8anFZeh
        E6zW1ct/62de+1YpW+j3MLXsmQbWGtpYtpOFHEySDbG+P43wreaW//mL8L8dwPvnL8iV/3
        IVvsGdJkJ+3h6GV1d5hMB56sy4LkDtM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-vktqff58MqOrTXVdw8Sn1Q-1; Wed, 17 Mar 2021 10:38:12 -0400
X-MC-Unique: vktqff58MqOrTXVdw8Sn1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E94581425A;
        Wed, 17 Mar 2021 14:38:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.224])
        by smtp.corp.redhat.com (Postfix) with SMTP id B6F5660C13;
        Wed, 17 Mar 2021 14:38:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 17 Mar 2021 15:38:09 +0100 (CET)
Date:   Wed, 17 Mar 2021 15:38:06 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Qianli Zhao <zhaoqianligood@gmail.com>
Cc:     christian@brauner.io, axboe@kernel.dk, ebiederm@xmission.com,
        tglx@linutronix.de, pcc@google.com, linux-kernel@vger.kernel.org,
        zhaoqianli@xiaomi.com
Subject: Re: [PATCH V3] exit: trigger panic when global init has exited
Message-ID: <20210317143805.GA5610@redhat.com>
References: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615985460-112867-1-git-send-email-zhaoqianligood@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/17, Qianli Zhao wrote:
>
> From: Qianli Zhao <zhaoqianli@xiaomi.com>
>
> When init sub-threads running on different CPUs exit at the same time,
> zap_pid_ns_processe()->BUG() may be happened.

and why do you think your patch can't prevent this?

Sorry, I must have missed something. But it seems to me that you are trying
to fix the wrong problem. Yes, zap_pid_ns_processes() must not be called in
the root namespace, and this has nothing to do with CONFIG_PID_NS.

> And every thread status is abnormal after exit(PF_EXITING set,task->mm=NULL etc),
> which makes it difficult to parse coredump from fulldump normally.
> In order to fix the above problem, when any one init has been set to SIGNAL_GROUP_EXIT,
> trigger panic immediately, and prevent other init threads from continuing to exit
>
> [   24.705376] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f00
> [   24.705382] CPU: 4 PID: 552 Comm: init Tainted: G S         O    4.14.180-perf-g4483caa8ae80-dirty #1
> [   24.705390] kernel BUG at include/linux/pid_namespace.h:98!
>
> PID: 552   CPU: 4   COMMAND: "init"
> PID: 1     CPU: 7   COMMAND: "init"
> core4                           core7
> ...                             sys_exit_group()
>                                 do_group_exit()
>                                    - sig->flags = SIGNAL_GROUP_EXIT
>                                    - zap_other_threads()
>                                 do_exit() //PF_EXITING is set
> ret_to_user()
> do_notify_resume()
> get_signal()
>     - signal_group_exit
>     - goto fatal;
> do_group_exit()
> do_exit() //PF_EXITING is set
>     - panic("Attempted to kill init! exitcode=0x%08x\n")
>                                 exit_notify()
>                                 find_alive_thread() //no alive sub-threads
>                                 zap_pid_ns_processes()//CONFIG_PID_NS is not set
>                                 BUG()
>
> Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
> ---
> V3:
> - Use group_dead instead of thread_group_empty() to test single init exit.
>
> V2:
> - Changelog update
> - Remove wrong useage of SIGNAL_UNKILLABLE.
> - Add thread_group_empty() test to handle single init thread exit
> ---
>  kernel/exit.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index 04029e3..32b74e4 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -766,6 +766,17 @@ void __noreturn do_exit(long code)
>
>  	validate_creds_for_do_exit(tsk);
>
> +	group_dead = atomic_dec_and_test(&tsk->signal->live);
> +	/*
> +	 * If global init has exited,
> +	 * panic immediately to get a useable coredump.
> +	 */
> +	if (unlikely(is_global_init(tsk) &&
> +	    (group_dead || (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
> +			panic("Attempted to kill init! exitcode=0x%08x\n",
> +				tsk->signal->group_exit_code ?: (int)code);
> +	}
> +
>  	/*
>  	 * We're taking recursive faults here in do_exit. Safest is to just
>  	 * leave this task alone and wait for reboot.
> @@ -784,16 +795,7 @@ void __noreturn do_exit(long code)
>  	if (tsk->mm)
>  		sync_mm_rss(tsk->mm);
>  	acct_update_integrals(tsk);
> -	group_dead = atomic_dec_and_test(&tsk->signal->live);
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

