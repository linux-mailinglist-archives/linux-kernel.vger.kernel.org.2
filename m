Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D72A3DF184
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbhHCPbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236741AbhHCPay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:30:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09550C0617B1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 08:30:36 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628004633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYAidDTtZlwD0eAmDJGiwHLKb2zrViR5iopfW/47ycc=;
        b=OqjOI/FbmrK18S3ZvolMVu6MnmqMbOBo9jrdeXX3wxV7sqCVpdjTRar0H7i0ExNzY5bR/X
        PdP6sVQRAPdOYEMbxPgbQpXhiP/YVGhgrClPXAfjkOLUjk6nKsl2opF1S0+2EWZi8fdTVQ
        OyF18c9yESpVQ1ED39gaPl7oFtEgs51vYZX7ouRviNrfeq89w+mkATGMlPRG116iVVa1sP
        aAVNstXlI6g5+Od+hSIym7JtGUKKUBCybkbw6Tq9/SDXhAX0rTcnPPRvsN0GraIj3Cb00c
        qPHfZgWp/+9IGkAMNPiGT1MYOTT8EI5B06YAqc4VThaM1sSv5Bxo5RItB4a/cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628004633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYAidDTtZlwD0eAmDJGiwHLKb2zrViR5iopfW/47ycc=;
        b=+B9KGpXLz+WiAwY5HjTHSwrgLkU2AO4ktjbvjOzrUjWKgCCoYGx8mHsRRMGq0543zI3G5c
        yoN+x2AyyiqMdSCw==
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Petr Mladek <pmladek@suse.com>,
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
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH printk v1 03/10] kgdb: delay roundup if holding printk cpulock
In-Reply-To: <20210803142558.cz7apumpgijs5y4y@maple.lan>
References: <20210803131301.5588-1-john.ogness@linutronix.de> <20210803131301.5588-4-john.ogness@linutronix.de> <20210803142558.cz7apumpgijs5y4y@maple.lan>
Date:   Tue, 03 Aug 2021 17:36:32 +0206
Message-ID: <87tuk635rb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-03, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> On Tue, Aug 03, 2021 at 03:18:54PM +0206, John Ogness wrote:
>> kgdb makes use of its own cpulock (@dbg_master_lock, @kgdb_active)
>> during cpu roundup. This will conflict with the printk cpulock.
>
> When the full vision is realized what will be the purpose of the printk
> cpulock?
>
> I'm asking largely because it's current role is actively unhelpful
> w.r.t. kdb. It is possible that cautious use of in_dbg_master() might
> be a better (and safer) solution. However it sounds like there is a
> larger role planned for the printk cpulock...

The printk cpulock is used as a synchronization mechanism for
implementing atomic consoles, which need to be able to safely interrupt
the console write() activity at any time and immediately continue with
their own printing. The ultimate goal is to move all console printing
into per-console dedicated kthreads, so the primary function of the
printk cpulock is really to immediately _stop_ the CPU/kthread
performing write() in order to allow write_atomic() (from any context on
any CPU) to safely and reliably take over.

Atomic consoles are actually quite similar to the kgdb_io ops. For
example, comparing:

serial8250_console_write_atomic() + serial8250_console_putchar_locked()

with

serial8250_put_poll_char()

The difference is that serial8250_console_write_atomic() is line-based
and synchronizing with serial8250_console_write() so that if the kernel
crashes while outputing to the console, write() can be interrupted by
write_atomic() and cleanly formatted crash data can be output.

Also serial8250_put_poll_char() is calling into __pm_runtime_resume(),
which includes a spinlock and possibly sleeping. This would not be
acceptable for atomic consoles. Although, as Andy pointed out [0], I
will need to figure out how to deal with suspended consoles. Or just
implement a policy that registered atomic consoles may never be
suspended.

I had not considered merging kgdb_io ops with atomic console ops. But
now that I look at it more closely, there may be some useful overlap. I
will consider this. Thank you for this idea.

>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 3d0c933937b4..1b546e117f10 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -214,6 +215,7 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
>>  #ifdef CONFIG_SMP
>>  static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
>>  static atomic_t printk_cpulock_nested = ATOMIC_INIT(0);
>> +static unsigned int kgdb_cpu = -1;
>
> Is this the flag to provoke retriggering? It appears to be a write-only
> variable (at least in this patch). How is it consumed?

Critical catch! Thank you. I am quite unhappy to see these hunks were
accidentally dropped when generating this series.

@@ -3673,6 +3675,9 @@ EXPORT_SYMBOL(__printk_cpu_trylock);
  */
 void __printk_cpu_unlock(void)
 {
+	bool trigger_kgdb = false;
+	unsigned int cpu;
+
 	if (atomic_read(&printk_cpulock_nested)) {
 		atomic_dec(&printk_cpulock_nested);
 		return;
@@ -3683,6 +3688,12 @@ void __printk_cpu_unlock(void)
 	 * LMM(__printk_cpu_unlock:A)
 	 */
 
+	cpu = smp_processor_id();
+	if (kgdb_cpu == cpu) {
+		trigger_kgdb = true;
+		kgdb_cpu = -1;
+	}
+
 	/*
 	 * Guarantee loads and stores from this CPU when it was the
 	 * lock owner are visible to the next lock owner. This pairs
@@ -3703,6 +3714,21 @@ void __printk_cpu_unlock(void)
 	 */
 	atomic_set_release(&printk_cpulock_owner,
 			   -1); /* LMM(__printk_cpu_unlock:B) */
+
+	if (trigger_kgdb) {
+		pr_warn("re-triggering kgdb roundup for CPU#%d\n", cpu);
+		kgdb_roundup_cpu(cpu);
+	}
 }
 EXPORT_SYMBOL(__printk_cpu_unlock);

John Ogness

[0] https://lore.kernel.org/lkml/YQlKAeXS9MPmE284@smile.fi.intel.com
