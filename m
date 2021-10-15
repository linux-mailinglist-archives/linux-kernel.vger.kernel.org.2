Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9AB442F2D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbhJONbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 09:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbhJONaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 09:30:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3CCC061771
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 06:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Y+dllbYuaiNXvJfYYEEAwgqi7pueU8vq8fs+ZarrgY=; b=SGQyE/A4j13kyQc5N0v+OCaRqW
        yjxg7YfsyPVPrMemGvzPbgkfotObNeHVUjACtqLbV14f8Minl0p6ZvRxsGGaDZ9ZLIk2XaHJKChIZ
        sTWLx4QvQcKj1hc3PTuWDGMKafF7L5MoOvTi/XvmaWTOKO5y3IC+Z+Fx7ifU8IueCRSXXRLRdIpVC
        Vn1gUx9NGSSxrThHrDPjtb4UF4ExbA1ftMAJKg5b2b09nCRTVqcjE3oiY9wjJTaWBgLqSRQV+Ige9
        xPACpucrtc6D5Pepdfn8bbSk8IxCB17YuA3UONcpK3f31p+UL66GDqQE/76BO3tGgvGvwHLNuxfO9
        btNbIMLw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbNDk-0092PI-PZ; Fri, 15 Oct 2021 13:26:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EC8923004E7;
        Fri, 15 Oct 2021 15:26:00 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CAF3521BE7655; Fri, 15 Oct 2021 15:26:00 +0200 (CEST)
Date:   Fri, 15 Oct 2021 15:26:00 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/apic: reduce cache line misses in
 __x2apic_send_IPI_mask()
Message-ID: <YWmBaNoMGMZOACoT@hirez.programming.kicks-ass.net>
References: <20211007031756.345269-1-eric.dumazet@gmail.com>
 <20211007072917.GN174703@worktop.programming.kicks-ass.net>
 <CANn89iKOa+tqerm80vHvHEurc2UxTq_heQuOUE0KnVuJht8AKA@mail.gmail.com>
 <YV7+/0+Q1n67wCF8@hirez.programming.kicks-ass.net>
 <CANn89iLEz5POFii_=wU=2J0A9CE3H5JPq3sQFUQ8E400YumUpw@mail.gmail.com>
 <CANn89iKg2Te8if2t_8oaAo6wL2BFNr2cP3D2w+jDePkFO5xREg@mail.gmail.com>
 <YWWDbIU+Cpppc7PV@hirez.programming.kicks-ass.net>
 <CANn89iL5mmbVojrUC4GHKC+0WSxzs_obqbt=rn2S_cmkddAriQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iL5mmbVojrUC4GHKC+0WSxzs_obqbt=rn2S_cmkddAriQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 11:02:46AM -0700, Eric Dumazet wrote:
> On Tue, Oct 12, 2021 at 5:46 AM Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > I'm really conflicted about this. On the one hand, yes absolutely. On
> > the other hand, urgh, code ugly :-)
> 
> That was indeed some ugly hack.
> 
> I cooked this more generic patch instead, I am currently testing it.
> (generic as : we no longer disable hard irqs, regardless of some CONFIG option )
> 
> diff --git a/arch/x86/kernel/apic/x2apic_cluster.c
> b/arch/x86/kernel/apic/x2apic_cluster.c
> index e696e22d0531976f7cba72ed17443592eac72c13..7ad81467ce33349dee1ceaf0cefc8375d60213f6
> 100644
> --- a/arch/x86/kernel/apic/x2apic_cluster.c
> +++ b/arch/x86/kernel/apic/x2apic_cluster.c
> @@ -22,7 +22,10 @@ struct cluster_mask {
>   */
>  static u32 *x86_cpu_to_logical_apicid __read_mostly;
> 
> -static DEFINE_PER_CPU(cpumask_var_t, ipi_mask);

This might maybe do with a comment explaining where the 3 comes from.
Also see below.

> +#define IPI_NEST_MAX 3
> +static DEFINE_PER_CPU(cpumask_var_t, ipi_mask[IPI_NEST_MAX]);
> +static DEFINE_PER_CPU(int, ipi_nest_level);
> +
>  static DEFINE_PER_CPU_READ_MOSTLY(struct cluster_mask *, cluster_masks);
>  static struct cluster_mask *cluster_hotplug_mask;
> 
> @@ -45,14 +48,18 @@ __x2apic_send_IPI_mask(const struct cpumask *mask,
> int vector, int apic_dest)
>  {
>         unsigned int cpu, clustercpu;
>         struct cpumask *tmpmsk;
> -       unsigned long flags;
> +       int nest_level;
>         u32 dest;
> 
>         /* x2apic MSRs are special and need a special fence: */
>         weak_wrmsr_fence();
> -       local_irq_save(flags);
> 
> -       tmpmsk = this_cpu_cpumask_var_ptr(ipi_mask);
> +       preempt_disable();
> +       nest_level = this_cpu_inc_return(ipi_nest_level) - 1;
> +       if (WARN_ON_ONCE(nest_level >= IPI_NEST_MAX))
> +               goto end;

So this matches the: task, softirq, irq nesting and realistically won't
trigger I suppose, but that WARN is not giving me warm and fuzzies, just
not sending the IPI is terrible behaviour if we ever do hit this.

I think I would prefer to trip x2apic_send_IPI_all() over sending too
few IPIs.

That *might* in some distant future kill some NOHZ_FULL userspace, but
at least it won't make the system grind to a halt as a missing IPI can.

Thomas, any opinions there?

> +
> +       tmpmsk = this_cpu_cpumask_var_ptr(ipi_mask[nest_level]);
>         cpumask_copy(tmpmsk, mask);
>         /* If IPI should not be sent to self, clear current CPU */
>         if (apic_dest != APIC_DEST_ALLINC)
> @@ -74,7 +81,9 @@ __x2apic_send_IPI_mask(const struct cpumask *mask,
> int vector, int apic_dest)
>                 cpumask_andnot(tmpmsk, tmpmsk, &cmsk->mask);
>         }
> 
> -       local_irq_restore(flags);
> +end:
> +       this_cpu_dec(ipi_nest_level);
> +       preempt_enable();
>  }
> 
>  static void x2apic_send_IPI_mask(const struct cpumask *mask, int vector)
