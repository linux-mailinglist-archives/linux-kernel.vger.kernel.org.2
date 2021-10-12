Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157F142A4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbhJLMtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhJLMta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:49:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFC2C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XpABCObaiIMLrlV6HMkqdEqou3Cn9Id8iPDiFDWo6F4=; b=XDr8QroVK+cjkDP2nwAncemwxK
        YV2YGHlKsyefMJy6lhQxD7I4zV4dXJzV3Moxal/YrI8ihU9Pp5QN+bN76lSvUyVm3dLF3fAR//LHr
        o2dBZh8EKfPiefRT6mhlt1Njgntc2rnNNlYpnL3c7CulGCgjQs109FuiQBTNovtknc2LzndTTsyiv
        rkKa8SQzuXwxYGm44OpH81f4/lyXzA4weJnoPXV2cnU631jkyK2KyKk5UGoUJlc1rcKYjCGjuzrdW
        ZgOjgMYBh0HKREnoawtQ5ahM56vsP80IrxAiKOLqukZT4opY57AI4QMXwCPYlDFpGHov40t2S1ZbA
        lDdhMJAQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maH9w-006VaV-PS; Tue, 12 Oct 2021 12:45:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B717D30032E;
        Tue, 12 Oct 2021 14:45:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 984D92C880EE3; Tue, 12 Oct 2021 14:45:32 +0200 (CEST)
Date:   Tue, 12 Oct 2021 14:45:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] x86/apic: reduce cache line misses in
 __x2apic_send_IPI_mask()
Message-ID: <YWWDbIU+Cpppc7PV@hirez.programming.kicks-ass.net>
References: <20211007031756.345269-1-eric.dumazet@gmail.com>
 <20211007072917.GN174703@worktop.programming.kicks-ass.net>
 <CANn89iKOa+tqerm80vHvHEurc2UxTq_heQuOUE0KnVuJht8AKA@mail.gmail.com>
 <YV7+/0+Q1n67wCF8@hirez.programming.kicks-ass.net>
 <CANn89iLEz5POFii_=wU=2J0A9CE3H5JPq3sQFUQ8E400YumUpw@mail.gmail.com>
 <CANn89iKg2Te8if2t_8oaAo6wL2BFNr2cP3D2w+jDePkFO5xREg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iKg2Te8if2t_8oaAo6wL2BFNr2cP3D2w+jDePkFO5xREg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 03:13:46PM -0700, Eric Dumazet wrote:
> It seems wasteful to use tiny per-cpu variables and block hard irqs.
> 
> Quick and very dirty patch :
> 
> diff --git a/arch/x86/kernel/apic/x2apic_cluster.c
> b/arch/x86/kernel/apic/x2apic_cluster.c
> index e696e22d0531976f7cba72ed17443592eac72c13..c5076d40d4ea7bc9ffb06728531d91777a32cef4
> 100644
> --- a/arch/x86/kernel/apic/x2apic_cluster.c
> +++ b/arch/x86/kernel/apic/x2apic_cluster.c
> @@ -44,15 +44,18 @@ static void
>  __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
>  {
>         unsigned int cpu, clustercpu;
> -       struct cpumask *tmpmsk;
> +       cpumask_var_t tmpmsk;
> +#ifdef CONFIG_CPUMASK_OFFSTACK
>         unsigned long flags;
> +#endif
>         u32 dest;
> 
>         /* x2apic MSRs are special and need a special fence: */
>         weak_wrmsr_fence();
> +#ifdef CONFIG_CPUMASK_OFFSTACK
>         local_irq_save(flags);
> -
>         tmpmsk = this_cpu_cpumask_var_ptr(ipi_mask);
> +#endif
>         cpumask_copy(tmpmsk, mask);
>         /* If IPI should not be sent to self, clear current CPU */
>         if (apic_dest != APIC_DEST_ALLINC)
> @@ -74,7 +77,9 @@ __x2apic_send_IPI_mask(const struct cpumask *mask,
> int vector, int apic_dest)
>                 cpumask_andnot(tmpmsk, tmpmsk, &cmsk->mask);
>         }
> 
> +#ifdef CONFIG_CPUMASK_OFFSTACK
>         local_irq_restore(flags);
> +#endif
>  }

I'm really conflicted about this. On the one hand, yes absolutely. On
the other hand, urgh, code ugly :-)


