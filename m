Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 478E33873D9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 10:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346279AbhERIZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 04:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbhERIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 04:25:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5E8C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HhLhYx8X/N3oHEcmVADa59F9cz2oSPkONiRH7L58LjU=; b=NXOYIm7fkali+E3M/XMfELs0Zt
        6HTYghYovNl/UXPGPIAGbwe5PBHrRu3PPeukI/ZD7hadke8eTzII1SDuJ22FHOSyWA0jg4DdMiYG5
        rNasnYhSFoATqOXG51sWc3oK8KYcwbFyJ8pkwEg2w/bclbwmQYwa+mE4ratE3LUPBSQ40j8Upf+EE
        l42Fct3DOytK8hvMnvYPLZhbczmoH2lQibGknwk042O/Iq86yUEtezUWpmDJJLo9hBevjH+XXgJwl
        lp1crZxNn5rpebcs+gnD461oe6XKtGit81XEYJgYhJ1y5sJRFzxrPMktyY//AQslo9PaGiUNw3qlf
        N5YUmsqQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1liv0V-00DnYd-Vl; Tue, 18 May 2021 08:23:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B777130022A;
        Tue, 18 May 2021 10:23:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 988E93138186A; Tue, 18 May 2021 10:23:13 +0200 (CEST)
Date:   Tue, 18 May 2021 10:23:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
Cc:     "'fweisbec@gmail.com'" <fweisbec@gmail.com>,
        "'tglx@linutronix.de'" <tglx@linutronix.de>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'juri.lelli@redhat.com'" <juri.lelli@redhat.com>,
        "'vincent.guittot@linaro.org'" <vincent.guittot@linaro.org>,
        "'dietmar.eggemann@arm.com'" <dietmar.eggemann@arm.com>,
        "'rostedt@goodmis.org'" <rostedt@goodmis.org>,
        "'bsegall@google.com'" <bsegall@google.com>,
        "'mgorman@suse.de'" <mgorman@suse.de>,
        "'bristot@redhat.com'" <bristot@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Utime and stime are less when getrusage (RUSAGE_THREAD) is
 executed on a tickless CPU.
Message-ID: <YKN5cQpFSdsgBlBU@hirez.programming.kicks-ass.net>
References: <OSBPR01MB21837C8931D90AE55AF4A955EB529@OSBPR01MB2183.jpnprd01.prod.outlook.com>
 <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSBPR01MB2183384B29F6291EB7C0BB81EB2C9@OSBPR01MB2183.jpnprd01.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 18, 2021 at 07:59:06AM +0000, hasegawa-hitomi@fujitsu.com wrote:
> Hi Ingo, Peter, Juri, and Vincent
> 
> 
> > I found that when I run getrusage(RUSAGE_THREAD) on a tickless CPU, the utime and stime I get are less than the actual time, unlike when I run getrusage(RUSAGE_SELF) on a single thread.
> > This problem seems to be caused by the fact that se.sum_exec_runtime is not updated just before getting the information from 'current'.
> > In the current implementation, task_cputime_adjusted() calls task_cputime() to get the 'current' utime and stime, then calls cputime_adjust() >to adjust the sum of utime and stime to be equal to cputime.sum_exec_runtime. On a tickless CPU, sum_exec_runtime is not updated >periodically, so there seems to be a discrepancy with the actual time.
> > Therefore, I think I should include a process to update se.sum_exec_runtime just before getting the information from 'current' (as in other >processes except RUSAGE_THREAD). I'm thinking of the following improvement.
> > 
> > @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
> >         if (who == RUSAGE_THREAD) {
> > +               task_sched_runtime(current);
> >                 task_cputime_adjusted(current, &utime, &stime);
> > 
> > Is there any possible problem with this?
> 
> 
> Any comments?

Your email is malformed.
