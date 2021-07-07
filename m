Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAAE3BE6FC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 13:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhGGLVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 07:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbhGGLVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 07:21:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E17FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 04:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o60E3y7ol8TaCCvWC0GHg5ui9lDE74SSRdsrHPhk1w0=; b=A7rEFuWmYtsEJwCpxd/swPsekG
        V+/DDDDEfi+KfK7AjXsq+jQNnTkI4hUob08H+nYYfJSfewjSqPVoCA0coUdHByEzUrLTG6OG6zt3Y
        mEwNJlvH+2XIgoNMQJjxpdeEB8Cp4JdrCmRklK8sG+RyBrm7qEL3XUttQLh1/6xSJ7kDQHO51h2r2
        /+ZAdGa99Rwqra9/kiWWVR15+TdZxvrKI3WsLvLff53nFhqsIeZNQIUzBFwKQI/z6HHbc54l4oNU8
        /CSIROINqWwvnmVTFfcKO3IxycpwwQYzwxwQ2aTA2Wzi7OOTpfqFjYAQy7lqgrk0E6qjg/h+27m1K
        NU3Urq0A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m15Yq-00CLBY-7Y; Wed, 07 Jul 2021 11:17:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 607C5300233;
        Wed,  7 Jul 2021 13:17:46 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5009A2018A6F5; Wed,  7 Jul 2021 13:17:46 +0200 (CEST)
Date:   Wed, 7 Jul 2021 13:17:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ani Sinha <ani@anisinha.ca>
Cc:     linux-kernel@vger.kernel.org, anirban.sinha@nokia.com,
        tglx@linutronix.de, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v2] sched/clock: print a log when the sched clock is
 marked unstable
Message-ID: <YOWNWq0IHHP3Fdhz@hirez.programming.kicks-ass.net>
References: <20210707105659.194171-1-ani@anisinha.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707105659.194171-1-ani@anisinha.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 04:26:59PM +0530, Ani Sinha wrote:
> When the sched clock transitions from stable to unstable and
> vice versa, a kernel log is printed. When the sched clock
> is marked explicitly as unstable, make __clear_sched_clock_stable()
> emit a warning log. It is useful for example in understanding
> why a certain feature like NOHZ that depends on availability of a
> stable sched clock, is not available.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  kernel/sched/clock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> Changelog:
> V1: original patch
> v2: print pr_warn from __clear_sched_clock_stable instead. Commit log
>     updated with proper prefix and wording.
> 
> diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
> index c2b2859ddd82..99484fec0335 100644
> --- a/kernel/sched/clock.c
> +++ b/kernel/sched/clock.c
> @@ -183,6 +183,7 @@ static void __clear_sched_clock_stable(void)
>  		return;
>  
>  	tick_dep_set(TICK_DEP_BIT_CLOCK_UNSTABLE);
> +	pr_warn("sched_clock: Marking unstable.\n");
>  	schedule_work(&sched_clock_work);
>  }

I'm confused... that work has a ton of printk()s in, what is this
pr_warn() adding?
