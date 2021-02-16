Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E5731CA60
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 13:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhBPMHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 07:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbhBPMFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 07:05:16 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B530FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 04:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6SOYiIoOIrJswiH+kvkOeoh2i6yuirVJqSRi5GsGhK0=; b=e6iu4OknmrFp2oKWbuaRUYmCIN
        p/ZrAWYsqdKtH7nm3/xoQlwNTL6TsdK5U5aMda2JDUp0WSE6CYxHcO1aZCVqZcLnNoSXdcM27z8ow
        xJpnFe5Hqe5pyJs9nW2rixRyAhK8BCnzZptCX/u5mrCtXWCYIVizJRcRmPj0HGC5PC0jws2c25YhZ
        MaVgRMso4MvKueqFLR8qbgxSg+el0xbb3N8vWW3ZNKSCBAZEnTLuCzKTDIpA+or55BEr5VNOZb0vC
        eOiys62qNmda6jDk8OkWpW0zFzCtTttbErldPxT1PwdOIzwZ5aLXgEDFwk6PzbLBegQf1MViqI0pd
        4P3DHhGw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBz5Z-0000fc-Pv; Tue, 16 Feb 2021 12:04:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D69923011E6;
        Tue, 16 Feb 2021 13:04:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADE8220577E14; Tue, 16 Feb 2021 13:04:18 +0100 (CET)
Date:   Tue, 16 Feb 2021 13:04:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v5 1/8] smp: Run functions concurrently in
 smp_call_function_many_cond()
Message-ID: <YCu0wleNK9a/rUWr@hirez.programming.kicks-ass.net>
References: <20210209221653.614098-1-namit@vmware.com>
 <20210209221653.614098-2-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209221653.614098-2-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 02:16:46PM -0800, Nadav Amit wrote:
> @@ -894,17 +911,12 @@ EXPORT_SYMBOL(on_each_cpu_mask);
>  void on_each_cpu_cond_mask(smp_cond_func_t cond_func, smp_call_func_t func,
>  			   void *info, bool wait, const struct cpumask *mask)
>  {
> -	int cpu = get_cpu();
> +	unsigned int scf_flags = SCF_RUN_LOCAL;
>  
> -	smp_call_function_many_cond(mask, func, info, wait, cond_func);
> -	if (cpumask_test_cpu(cpu, mask) && cond_func(cpu, info)) {
> -		unsigned long flags;
> +	if (wait)
> +		scf_flags |= SCF_WAIT;
>  
> -		local_irq_save(flags);
> -		func(info);
> -		local_irq_restore(flags);
> -	}
> -	put_cpu();
> +	smp_call_function_many_cond(mask, func, info, scf_flags, cond_func);
>  }
>  EXPORT_SYMBOL(on_each_cpu_cond_mask);

You lost the preempt_disable() there, I've added it back:

---
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -920,7 +920,9 @@ void on_each_cpu_cond_mask(smp_cond_func
 	if (wait)
 		scf_flags |= SCF_WAIT;
 
+	preempt_disable();
 	smp_call_function_many_cond(mask, func, info, scf_flags, cond_func);
+	preempt_enable();
 }
 EXPORT_SYMBOL(on_each_cpu_cond_mask);
 
