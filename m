Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9034F365B53
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhDTOj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbhDTOjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:39:54 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28336C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6IyPt9ZoAPwZV47/xoojROaiJABU9ZeJnmBOh0IUDUk=; b=q8QkP4pXj2co/2NRBll+I/V7xs
        IUqTPYyqYNRWHejYtIyDhbbTSJeSwfwf5GbNbW02IeoLxCa8LPu5D3NN+buiC+CKh70ApJ0ICs8f4
        suQm5XlXk7lAVKXXHqrZZV2NOe0WjSA/rh5Qtm4VegNF6TkwB5L+KgGQZnUBtvPwheoSANxqlaBDF
        fLNBzn9ZyigWPKLgC8Oktww37L65g6WVu8rucWF0psN7caD72sin0jYVlu6ZxuGLLrYabUST+QOft
        fEfQIleEqn3yNu8IRba/+U2uR3fYuEz2vbpylgZOo/AygzeYvrNhY7bgJ4LLZcEK5hp1vPXyX5tMB
        lgsTGTug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lYrWr-00CMuV-Tk; Tue, 20 Apr 2021 14:39:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0BCD530018E;
        Tue, 20 Apr 2021 16:39:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DF62D2BCEDE78; Tue, 20 Apr 2021 16:39:04 +0200 (CEST)
Date:   Tue, 20 Apr 2021 16:39:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        tglx@linutronix.de, mingo@kernel.org, bigeasy@linutronix.de,
        swood@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched: Use cpu_dying() to fix balance_push vs
 hotplug-rollback
Message-ID: <YH7niBZDWjsz+jBa@hirez.programming.kicks-ass.net>
References: <20210310150109.259726371@infradead.org>
 <871rclu3jz.mognet@e113632-lin.i-did-not-set--mail-host-address--so-tickle-me>
 <YHQ3Iy7QfL+0UoM0@hirez.programming.kicks-ass.net>
 <87r1jfmn8d.mognet@arm.com>
 <YHU/a9HvGLYpOLKZ@hirez.programming.kicks-ass.net>
 <YHgAYef83VQhKdC2@hirez.programming.kicks-ass.net>
 <87a6pzmxec.mognet@arm.com>
 <20210419105541.GA40111@e120877-lin.cambridge.arm.com>
 <20210420094632.GA165360@e120877-lin.cambridge.arm.com>
 <YH7jSPZx0BhyHoLe@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YH7jSPZx0BhyHoLe@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 04:20:56PM +0200, Peter Zijlstra wrote:
> On Tue, Apr 20, 2021 at 10:46:33AM +0100, Vincent Donnefort wrote:
> 
> > Found the issue:
> > 
> > $ cat hotplug/states:
> > 219: sched:active
> > 220: online
> > 
> > CPU0: 
> > 
> > $ echo 219 > hotplug/fail
> > $ echo 0 > online
> > 
> > => cpu_active = 1 cpu_dying = 1
> > 
> > which means that later on, for another CPU hotunplug, in
> > __balance_push_cpu_stop(), the fallback rq for a kthread can select that
> > CPU0, but __migrate_task() would fail and we end-up in an infinite loop,
> > trying to migrate that task to CPU0.
> > 
> > The problem is that for a failure in sched:active, as "online" has no callback,
> > there will be no call to cpuhp_invoke_callback(). Hence, the cpu_dying bit would
> > not be reset.
> 
> Urgh! Good find.
> 
> > Maybe cpuhp_reset_state() and cpuhp_set_state() would then be a better place to
> > switch the dying bit?
> 
> Yes, except now cpuhp_invoke_ap_callback() makes my head hurt, that runs
> the callbacks out of order. I _think_ we can ignore it, but ....
> 
> Something like the below, let me see if I can reproduce and test.

I seem to have triggered the BUG() in select_fallback_rq() with your recipie.
Have cpu0 fail on sched:active, then offline all other CPUs.

Now lemme add that patch.
