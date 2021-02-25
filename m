Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD23D324C39
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 09:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbhBYIrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 03:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbhBYIrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 03:47:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2214C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 00:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0chbbTizAM4s+RnstfoLBGU6yV6ryXMRj6cwHmxWsO4=; b=k6HHV2W7YjVTYREl888DFS+XNX
        35rEWttPio2L2lB3zTCqNYH3fmBHvBgodCdCtGafbTYaw5YS5yTmGYBu5ZtTnyWgQ/bl/ry+9EIse
        wBSSNQF+aawn4wXBu75JuL/5XQH6cHKGWmY49y/d28RLs73Nl7RwnfY7DorHIjsfEDkNLhydVmFvJ
        U6KU6CeZzCD5+g6lx6D3YS65Y3fzjDwG+dqVPOxvFKo8yU0qU9na7LeLDjBs6ziEJ9CErnZNjaRmN
        YRFrP7vu5E0gWOVHsxXpuYMXthRDDvNJAtEmPepkIuZJTvgZ6mRJx+KqTqU4Fw9PDiAv7E1QJWVxz
        aMDyNsrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lFCHR-00ATzC-LB; Thu, 25 Feb 2021 08:46:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2C1E53010D2;
        Thu, 25 Feb 2021 09:45:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E91CF20BC9281; Thu, 25 Feb 2021 09:45:52 +0100 (CET)
Date:   Thu, 25 Feb 2021 09:45:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 2/6] sched: Simplify migration_cpu_stop()
Message-ID: <YDdjwIhoCWtlliD7@hirez.programming.kicks-ass.net>
References: <20210224122439.176543586@infradead.org>
 <20210224131355.430014682@infradead.org>
 <jhjmtvt5vjn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjmtvt5vjn.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 24, 2021 at 03:34:36PM +0000, Valentin Schneider wrote:
> On 24/02/21 13:24, Peter Zijlstra wrote:
> > @@ -1950,31 +1931,20 @@ static int migration_cpu_stop(void *data
> >                       goto out;
> >
> >               if (pending) {
> > -			p->migration_pending = NULL;
> > +			if (p->migration_pending == pending)
> > +				p->migration_pending = NULL;
> >                       complete = true;
> >               }
> >
> > -		/* migrate_enable() --  we must not race against SCA */
> > -		if (dest_cpu < 0) {
> > -			/*
> > -			 * When this was migrate_enable() but we no longer
> > -			 * have a @pending, a concurrent SCA 'fixed' things
> > -			 * and we should be valid again. Nothing to do.
> > -			 */
> > -			if (!pending) {
> > -				WARN_ON_ONCE(!cpumask_test_cpu(task_cpu(p), &p->cpus_mask));
> > -				goto out;
> > -			}
> > -
> 
> This is fixed by 5+6, but at this patch I think you can have double
> completions - I thought this was an issue, but briefly looking at
> completion stuff it might not. In any case, consider:
> 
>   task_cpu(p) == Y
> 
>   SCA(p, X);
>                  SCA(p, Y);
> 
> 
> SCA(p, Y) will uninstall SCA(p, X)'s pending and complete.
> 
> migration/Y kicked by SCA(p, X) will grab arg->pending, which is still
> SCA(p, X)'s pending and also complete.

Right, so I didn't really think too hard about the intermediate states,
given it's all pretty buggered until at least 5. But yeah, double
complete is harmless.

Specifically, the refcount the stopper has should avoid the stack from
getting released.
