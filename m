Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C59314B73
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 10:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhBIJX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 04:23:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:51328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhBIJUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:20:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1612862383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dai9OHgWYwN2IeScEPrXFPx2OP+WacEqDQGMmgzQewI=;
        b=s0wHUYqQ6InM38Mz9PuMn+Qxl2JX6xVd4G6bM7evsRHc/8ynEaxFt0uMFshf63lTz6pTiU
        uZoS5/n3hLp3xibZIHhR0k5UKyh4XqGENZqcB4Q/fbejqgdEyWWo6n3DAIRqlaZUID79Fi
        xZHw5FGRBcMRaSaDcHdJpe4AQcoelo4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A56F9AD3E;
        Tue,  9 Feb 2021 09:19:43 +0000 (UTC)
Date:   Tue, 9 Feb 2021 10:19:42 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        john.ogness@linutronix.de, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] printk: fix deadlock when kernel panic
Message-ID: <YCJTrrirMlH7M5i7@alley>
References: <20210206054124.6743-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210206054124.6743-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2021-02-06 13:41:24, Muchun Song wrote:
> We found a deadlock bug on our server when the kernel panic. It can be
> described in the following diagram.
> 
> CPU0:                                         CPU1:
> panic                                         rcu_dump_cpu_stacks
>   kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
>     register_nmi_handler(crash_nmi_callback)      printk_safe_flush
>                                                     __printk_safe_flush
>                                                       raw_spin_lock_irqsave(&read_lock)
>     // send NMI to other processors
>     apic_send_IPI_allbutself(NMI_VECTOR)
>                                                         // NMI interrupt, dead loop
>                                                         crash_nmi_callback
>   printk_safe_flush_on_panic
>     printk_safe_flush
>       __printk_safe_flush
>         // deadlock
>         raw_spin_lock_irqsave(&read_lock)
> 
> The register_nmi_handler() can be called in the __crash_kexec() or the
> crash_smp_send_stop() on the x86-64. Because CPU1 is interrupted by the
> NMI with holding the read_lock and crash_nmi_callback() never returns,
> CPU0 can deadlock when printk_safe_flush_on_panic() is called.
> 
> When we hold the read_lock and then interrupted by the NMI, if the NMI
> handler call nmi_panic(), it is also can lead to deadlock.
> 
> In order to fix it, we make read_lock global and rename it to
> safe_read_lock. And we handle safe_read_lock the same way in
> printk_safe_flush_on_panic() as we handle logbuf_lock there.

What about the following commit message? It uses imperative language
and explains that the patch just prevents the deadlock. It removes
some details. The diagram is better than many words.

<commit message>
printk_safe_flush_on_panic() caused the following deadlock on our server:

CPU0:                                         CPU1:
panic                                         rcu_dump_cpu_stacks
  kdump_nmi_shootdown_cpus                      nmi_trigger_cpumask_backtrace
    register_nmi_handler(crash_nmi_callback)      printk_safe_flush
                                                    __printk_safe_flush
                                                      raw_spin_lock_irqsave(&read_lock)
    // send NMI to other processors
    apic_send_IPI_allbutself(NMI_VECTOR)
                                                        // NMI interrupt, dead loop
                                                        crash_nmi_callback
  printk_safe_flush_on_panic
    printk_safe_flush
      __printk_safe_flush
        // deadlock
        raw_spin_lock_irqsave(&read_lock)

DEADLOCK: read_lock is taken on CPU1 and will never get released.

It happens when panic() stops a CPU by NMI while it has been in
the middle of printk_safe_flush().

Handle the lock the same way as logbuf_lock. The printk_safe buffers
are flushed only when both locks can be safely taken.

Note: It would actually be safe to re-init the locks when all CPUs were
      stopped by NMI. But it would require passing this information
      from arch-specific code. It is not worth the complexity.
      Especially because logbuf_lock and printk_safe buffers have been
      obsoleted by the lockless ring buffer.
</commit message>

> Fixes: cf9b1106c81c ("printk/nmi: flush NMI messages on the system panic")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

With an updated commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
