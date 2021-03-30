Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6843134E426
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhC3JQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:16:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:49406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231599AbhC3JQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:16:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1617095794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FUEnjmgOHti2zjGDOO5t+fxlCLHNJiQF7pXIcPIMnrY=;
        b=pRputFnlUpjBbp1GlTJosJVcHbG92g8iI/RvDkS7PukOC9p8NTRcSqmPmIqoFPK4oeHWJD
        J4vA01wepuYlvzCIXqiUrOa17DCjhpcfJdTuDWyvp4PWEH7S2dFHxKRD6dixJqNj9DyaAu
        rfZj6PnWQ2W+wUbna9E+fYFIP4UkFOM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A971DAE5C;
        Tue, 30 Mar 2021 09:16:34 +0000 (UTC)
Date:   Tue, 30 Mar 2021 11:16:34 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2] x86/apic/vector: Move pr_warn() out of vector_lock
Message-ID: <YGLschswmBlMMly9@alley>
References: <20210329005236.1218-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329005236.1218-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2021-03-28 20:52:36, Waiman Long wrote:
> It was found that the following circular locking dependency warning
> could happen in some systems:
> 
> [  218.097878] ======================================================
> [  218.097879] WARNING: possible circular locking dependency detected
> [  218.097880] 4.18.0-228.el8.x86_64+debug #1 Not tainted
> [  218.097881] ------------------------------------------------------
> [  218.097882] systemd/1 is trying to acquire lock:
> [  218.097883] ffffffff84c27920 (console_owner){-.-.}, at: console_unlock+0x3fb/0x9f0
> [  218.097886]
> [  218.097887] but task is already holding lock:
> [  218.097888] ffffffff84afca78 (vector_lock){-.-.}, at: x86_vector_activate+0xca/0xab0
> [  218.097891]
> [  218.097892] which lock already depends on the new lock.
> [  218.097893]
> [  218.097893]
> [  218.097894] the existing dependency chain (in reverse order) is:
> [  218.097895]
> [  218.097896] -> #3 (vector_lock){-.-.}:
> [  218.097899]        _raw_spin_lock_irqsave+0x48/0x81
> [  218.097900]        x86_vector_activate+0xca/0xab0
> [  218.097901]        __irq_domain_activate_irq+0xdb/0x160
> [  218.097901]        __irq_domain_activate_irq+0x7d/0x160
> [  218.097902]        __irq_domain_activate_irq+0x7d/0x160
> [  218.097903]        irq_domain_activate_irq+0x95/0x130
> [  218.097904]        __setup_irq+0x861/0x1e60
> [  218.097905]        request_threaded_irq+0x1e7/0x2c0
> [  218.097906]        acpi_os_install_interrupt_handler+0x14c/0x180
> [  218.097907]        acpi_ev_install_sci_handler+0xc4/0xef
> [  218.097908]        acpi_ev_install_xrupt_handlers+0x85/0x15f
> [  218.097909]        acpi_enable_subsystem+0x345/0x394
> [  218.097910]        acpi_init+0x157/0x612
> [  218.097910]        do_one_initcall+0xe9/0x57d
> [  218.097911]        kernel_init_freeable+0x606/0x6d4
> [  218.097912]        kernel_init+0xc/0x121
> [  218.097913]        ret_from_fork+0x27/0x50
> [  218.097914]
> [  218.097914] -> #2 (&irq_desc_lock_class){-.-.}:
> [  218.097917]        _raw_spin_lock_irqsave+0x48/0x81
> [  218.097918]        __irq_get_desc_lock+0xcf/0x140
> [  218.097919]        __dble_irq_nosync+0x6e/0x110
> [  218.097920]        serial8250_do_startup+0x17a6/0x1ed0
> [  218.097921]        uart_startup.part.7+0x16f/0x4b0
> [  218.097922]        tty_port_open+0x112/0x190
> [  218.097922]        uart_open+0xe0/0x150
> [  218.097923]        tty_open+0x229/0x9a0
> [  218.097924]        chrdev_open+0x1e0/0x4e0
> [  218.097925]        do_dentry_open+0x3d9/0xea0
> [  218.097926]        path_openat+0xb73/0x2690
> [  218.097927]        do_filp_open+0x17c/0x250
> [  218.097927]        do_sys_open+0x1d9/0x360
> [  218.097928]        kernel_init_freeable+0x62e/0x6d4
> [  218.097929]        kernel_init+0xc/0x121
> [  218.097930]        ret_from_fork+0x27/0x50
> [  218.097930]
> [  218.097931] -> #1 (&port_lock_key){-.-.}:
> [  218.097934]        _raw_spin_lock_irqsave+0x48/0x81
> [  218.097935]        serial8250_console_write+0x629/0x770
> [  218.097936]        console_unlock+0x611/0x9f0
> [  218.097937]        register_console+0x54c/0xa70
> [  218.097938]        univ8250_console_init+0x24/0x27
> [  218.097938]        console_init+0x2ef/0x45a
> [  218.097939]        start_kernel+0x4c4/0x7c5
> [  218.097940]        secondary_startup_64+0xb7/0xc0
> [
> [  218.097941] -> #0 (console_owner){-.-.}:
> [  218.097944]        __lock_acquire+0x2894/0x7300
> [  218.097945]        lock_acquire+0x14f/0x3b0
> [  218.097946]        console_unlock+0x45d/0x9f0
> [  218.097947]        vprintk_emit+0x147/0x450
> [  218.097947]        printk+0x9f/0xc5
> [  218.097948]        x86_vector_activate+0x3f8/0xab0
> [  218.097949]        __irq_domain_activate_irq+0xdb/0x160
> [  218.097950]        __irq_domain_activate_irq+0x7d/0x160
> [  218.097951]        __irq_domain_activate_irq+0x7d/0x160
> [  218.097952]        irq_domain_activate_irq+0x95/0x130
> [  218.097953]        __setup_irq+0x861/0x1e60
> [  218.097954]        request_threaded_irq+0x1e7/0x2c0
> [  218.097955]        univ8250_setup_irq+0x6ef/0x8b0
> [  218.097955]        serial8250_do_startup+0x7d4/0x1ed0
> [  218.097956]        uart_startup.part.7+0x16f/0x4b0
> [  218.097957]        tty_port_open+0x112/0x190
> [  218.097958]        uart_open+0xe0/0x150
> [  218.097959]        tty_open+0x229/0x9a0
> [  218.097960]        chrdev_open+0x1e0/0x4e0
> [  218.097960]        do_dentry_open+0x3d9/0xea0
> [  218.097961]        path_openat+0xb73/0x2690
> [  218.097962]        do_filp_open+0x17c/0x250
> [  218.097963]        do_sys_open+0x1d9/0x360
> [  218.097964]        do_syscall_64+0xa5/0x4d0
> [  218.097965]        entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> [  218.097965]
> [  218.097966] other info that might help us debug this:
> [  218.097967]
> [  218.097967] Chain exists of:
> [  218.097968]   console_oc_lock_class --> vector_lock
> [  218.097972]
> [  218.097973]  Possible unsafe locking scenario:
> [  218.097973]
> [  218.097974]        CPU0                    CPU1
> [  218.097975]        ----                    ----
> [  218.097975]   lock(vector_lock);
> [  218.097977]                                lock(&irq_desc_lock_class);
> [  218.097980]                                lock(vector_lock);
> [  218.097981]   lock(console_owner);
> [  218.097983]
> [  218.097984]  *** DEADLOCK ***
> [  218.097984]
> [  218.097985] 6 locks held by systemd/1:
> [  218.097986]  #0: ffff88822b5cc1e8 (&tty->legacy_mutex){+.+.}, at: tty_init_dev+0x79/0x440
> [  218.097989]  #1: ffff88832ee00770 (&port->mutex){+.+.}, at: tty_port_open+0x85/0x190
> [  218.097993]  #2: ffff88813be85a88 (&desc->request_mutex){+.+.}, at: __setup_irq+0x249/0x1e60
> [  218.097996]  #3: ffff88813be858c0 (&irq_desc_lock_class){-.-.}, at: __setup_irq+0x2d9/0x1e60
> [  218.098000]  #4: ffffffff84afca78 (vector_lock){-.-.}, at: x86_vector_activate+0xca/0xab0
> [  218.098003]  #5: ffffffff84c27e20 (console_lock){+.+.}, at: vprintk_emit+0x13a/0x450
> [  218.098007]
> [  218.098007] stack backtrace:
> [  218.098009] CPU: 1 PID: 1 Comm: systemdt tainted 4.18.0-228.el8.x86_64+debug #1
> [  218.098010] Hardware name: HP ProLiant DL385p Gen8, BIOS A28 03/07/2016
> [  218.098010] Call Trace:
> [  218.098011]  dump_stack+0x9a/0xf0
> [  218.098012]  check_noncircular+0x317/0x3c0
> [  218.098013]  ? print_circular_bug+0x1e0/0x1e0
> [  218.098014]  ? do_profile_hits.isra.4.cold.9+0x2d/0x2d
> [  218.098015]  ? sched_clock+0x5/0x10
> [  218.098015]  __lock_acquire+0x2894/0x7300
> [  218.098016]  ? trace_hardirqs_on+0x10/0x10
> [  218.098017]  ? lock_downgrade+0x6f0/0x6f0
> [  218.098018]  lock_acquire+0x14f/0x3b0
> [  218.098019]  ? console_unlock+0x3fb/0x9f0
> [  218.098019]  console_unlock+0x45d/0x9f0
> [  218.098020]  ? console_unlock+0x3fb/0x9f0
> [  218.098021]  vprintk_emit+0x147/0x450
> [  218.098022]  ? apic_update_irq_cfg+0x3f6/0x520
> [  218.098023]  printk+0x9f/0xc5
> [  218.098023]  ? kmsg_dump_rewind_nolock+0xd9/0xd9
> [  218.098024]  x86_vector_activate+0x3f8/0xab0
> [  218.098025]  ? find_held_lock+0x3a/0x1c0
> [  218.098026]  __irq_domain_activate_irq+0xdb/0x160
> [  218.098027]  __irq_domain_activate_irq+0x7d/0x160
> [  218.098028]  __irq_domain_activate_irq+0x7d/0x160
> [  218.098029]  irq_domain_activate_irq+0x95/0x130
> [  218.098029]  ? __init_waitqueue_head+0x3a/0x90
> [  218.098030]  __setup_irq+0x861/0x1e60
> [  218.098031]  ? kmem_cache_alloc_trace+0x169/0x360
> [  218.098032]  ? request_threaded_irq+0xf9/0x2c0
> [  218.098033]  request_threaded_irq+0x1e7/0x2c0
> [  218.098033]  univ8250_setup_irq+0x6ef/0x8b0
> [  218.50_do_startup+0x7d4/0x1ed0
> [  218.098035]  uart_startup.part.7+0x16f/0x4b0
> [  218.098036]  tty_port_open+0x112/0x190
> [  218.098037]  ? _raw_spin_unlock+0x1f/0x30
> [  218.098037]  uart_open+0xe0/0x150
> [  218.098038]  tty_open+0x229/0x9a0
> [  218.098039]  ? lock_acquire+0x14f/0x3b0
> [  218.098040]  ? tty_init_dev+0x440/0x440
> [  218.098041]  ? selinux_file_open+0x2cf/0x400
> [  218.098041]  chrdev_open+0x1e0/0x4e0
> [  218.098042]  ? cdev_put.part.0+0x50/0x50
> [  218.098043]  do_dentry_open+0x3d9/0xea0
> [  218.098044]  ? cdev_put.part.0+0x50/0x50
> [  218.098045]  ? devcgroup_check_permission+0x17c/0x2f0
> [  218.098046]  ? __x64_sys_fchdir+0x180/0x180
> [  218.098046]  ? security_inode_permission+0x79/0xc0
> [  218.098047]  path_openat+0xb73/0x2690
> [  218.098048]  ? save_stack+0x81/0xb0
> [  218.098049]  ? path_lookupat+0x820/0x820
> [  218.098049]  ? sched_clock+0x5/0x10
> [  218.098050]  ? sched_clock_cpu+0x18/0x1e0
> [  218.098051]  ? do_syscall_64+0xa5/0x4d0
> [  218.098052]  ? entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> [  218.098053]  ? __lock_acquire+0x646/0x7300
> [  218.098054]  ? sched_clock_cpu+0x18/0x1e0
> [  218.098054]  ? find_held_lock+0x3a/0x1c0 filp_open+0x17c/0x250
> [  218.098056]  ? may_open_dev+0xc0/0xc0
> [  218.098057]  ? do_raw_spin_unlock+0x54/0x230
> [  218.098058]  ? _raw_spin_unlock+0x1f/0x30
> [  218.098058]  ? _raw_spin_unlock_irq+0x24/0x40
> [  218.098059]  do_sys_open+0x1d9/0x360
> [  218.098060]  ? filp_open+0x50/0x50
> [  218.098061]  ? entry_SYSCALL_64_after_hwframe+0x7a/0xdf
> [  218.098062]  ? do_syscall_64+0x22/0x4d0
> [  218.098062]  do_syscall_64+0xa5/0x4d0
> [  218.098063]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf
> [  218.098064] RIP: 0033:0x7ff4ee7620d6
> 
> This lockdep warning was causing by printing of the warning message:
> 
> [  218.095152] irq 3: Affinity broken due to vector space exhaustion.
> 
> To avoid this potential deadlock scenario, this patch moves all the
> pr_warn() calls in the vector.c file out of the vector_lock critical
> sections.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  arch/x86/kernel/apic/vector.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
> index 3c9c7492252f..79f1ce3a9539 100644
> --- a/arch/x86/kernel/apic/vector.c
> +++ b/arch/x86/kernel/apic/vector.c
> @@ -385,7 +385,7 @@ static void x86_vector_deactivate(struct irq_domain *dom, struct irq_data *irqd)
>  	raw_spin_unlock_irqrestore(&vector_lock, flags);
>  }
>  
> -static int activate_reserved(struct irq_data *irqd)
> +static int activate_reserved(struct irq_data *irqd, char *wbuf, size_t wsize)
>  {
>  	struct apic_chip_data *apicd = apic_chip_data(irqd);
>  	int ret;
> @@ -410,8 +410,9 @@ static int activate_reserved(struct irq_data *irqd)
>  	 */
>  	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
>  			    irq_data_get_affinity_mask(irqd))) {
> -		pr_warn("irq %u: Affinity broken due to vector space exhaustion.\n",
> -			irqd->irq);
> +		snprintf(wbuf, wsize, KERN_WARNING
> +			 "irq %u: Affinity broken due to vector space exhaustion.\n",
> +			 irqd->irq);

If you prove that this might happen upstream and we decide to
duct-tape it then printk_deferred() would be a better solution
than these games with temporary buffers.

As already mentioned in the other replies, the printk rework is
the real solution. The current state is that all locks around
the logbuffer manipulation should be removed in 5.13. Then
we are finally going to rework the console handling.

It is hard to predict how long it would take. IMHO, we would need
at least two more release cycles. The idea is simple. The problem
is how to detect and handle situations where we could not rely on
the kthreads doing the work. Also it would involve rewriting
some historic code around console locking.

Best Regards,
Petr
