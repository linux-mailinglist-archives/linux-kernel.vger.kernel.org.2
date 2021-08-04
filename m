Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDC433E0133
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbhHDMbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:31:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34166 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237690AbhHDMbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:31:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1C1141FDD3;
        Wed,  4 Aug 2021 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628080298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DC4/KiaX6Vt6MBJgEki+wBHi3z9bnh0HTsoiAX5JG+Y=;
        b=qv89K6eJX6qCyTdTbWC4KoIJyZrT3KxOobSvMJygB5ThmfxOox1BDe2omC2JBPPAoLMtGB
        bKFSc+u2up5Woqc9r/hhTWJ8Ov9DX5HAMaytSa9uS/AcZYXU1vxKGHzVBgdDIPMeXPJbGJ
        AqnoLG6rfavK0Kh86LcdVpnFJG8pEbA=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A1B3A3B84;
        Wed,  4 Aug 2021 12:31:37 +0000 (UTC)
Date:   Wed, 4 Aug 2021 14:31:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Chengyang Fan <cy.fan@huawei.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v1 03/10] kgdb: delay roundup if holding printk
 cpulock
Message-ID: <YQqIqKjRcNhZSaAZ@alley>
References: <20210803131301.5588-1-john.ogness@linutronix.de>
 <20210803131301.5588-4-john.ogness@linutronix.de>
 <20210803142558.cz7apumpgijs5y4y@maple.lan>
 <87tuk635rb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuk635rb.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2021-08-03 17:36:32, John Ogness wrote:
> On 2021-08-03, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > On Tue, Aug 03, 2021 at 03:18:54PM +0206, John Ogness wrote:
> >> kgdb makes use of its own cpulock (@dbg_master_lock, @kgdb_active)
> >> during cpu roundup. This will conflict with the printk cpulock.
> >
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index 3d0c933937b4..1b546e117f10 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -214,6 +215,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
> >>  #ifdef CONFIG_SMP
> >>  static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
> >>  static atomic_t printk_cpulock_nested = ATOMIC_INIT(0);
> >> +static unsigned int kgdb_cpu = -1;
> >
> > Is this the flag to provoke retriggering? It appears to be a write-only
> > variable (at least in this patch). How is it consumed?
> 
> Critical catch! Thank you. I am quite unhappy to see these hunks were
> accidentally dropped when generating this series.
> 
> @@ -3673,6 +3675,9 @@ EXPORT_SYMBOL(__printk_cpu_trylock);
>   */
>  void __printk_cpu_unlock(void)
>  {
> +	bool trigger_kgdb = false;
> +	unsigned int cpu;
> +
>  	if (atomic_read(&printk_cpulock_nested)) {
>  		atomic_dec(&printk_cpulock_nested);
>  		return;
> @@ -3683,6 +3688,12 @@ void __printk_cpu_unlock(void)
>  	 * LMM(__printk_cpu_unlock:A)
>  	 */
>  
> +	cpu = smp_processor_id();
> +	if (kgdb_cpu == cpu) {
> +		trigger_kgdb = true;
> +		kgdb_cpu = -1;
> +	}

Just in case that this approach is used in the end.

This code looks racy. kgdb_roundup_delay() seems to be called in NMI
context. NMI might happen at this point and set kgdb_cpu after
it was checked.

I am afraid that it won't be easy to make this safe using a single
global variable. A solution might be a per-CPU variable set
by kgdb_roundup_delay() when it owns printk_cpu_lock.
__printk_cpu_unlock() would call kgdb_roundup_cpu(cpu) when
the variable is set.

Nit: The name "kgdb_cpu" is too generic. It is not clear what is
     so special about this CPU. I would call the per-CPU variable
     "kgdb_delayed_roundup" or so.


Best Regards,
Petr

>  	/*
>  	 * Guarantee loads and stores from this CPU when it was the
>  	 * lock owner are visible to the next lock owner. This pairs
> @@ -3703,6 +3714,21 @@ void __printk_cpu_unlock(void)
>  	 */
>  	atomic_set_release(&printk_cpulock_owner,
>  			   -1); /* LMM(__printk_cpu_unlock:B) */
> +
> +	if (trigger_kgdb) {
> +		pr_warn("re-triggering kgdb roundup for CPU#%d\n", cpu);
> +		kgdb_roundup_cpu(cpu);
> +	}
>  }
