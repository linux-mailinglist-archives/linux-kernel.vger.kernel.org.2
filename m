Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FAC38FF87
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 12:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhEYKwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 06:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhEYKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 06:52:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A7EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 03:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3yMiZmZluSw2WQWEbx30T7K0/rHONFze8eFE1k40vy4=; b=E5LM8zdkpvRG+vzhWbwzKvL2xr
        Q4YEZv51a8jsqziNUf0r4aqdeeuJVCmD6jjI9O6/wMkfjIcTTghCobk/xCjoe0nJRlvql8d486WZh
        5RtjsloQyUlEnnJIKQuKMKmK37ICV7Q05Hhe2v8qZpt7WpiKzbGCGBljNzQGza/6qfmfGNx4Z6tOr
        MLpALDCrhGtbMkaievgExnkr9UaWKmG3LWHh7ovUkM26sVY7aB/FIRrMb3Z1yTJXXhfSc4KD2qAW2
        4SRWugxaf5hRdam3LHTZrE5B4z4pR8Za0+kRdC2lsRoXN4n+sMyyJ2AagXPD3EPEB+4hGCIJH8apn
        flrf4mwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llUch-003PQr-4v; Tue, 25 May 2021 10:49:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34AAC3001E4;
        Tue, 25 May 2021 12:49:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1AA5720299B51; Tue, 25 May 2021 12:49:15 +0200 (CEST)
Date:   Tue, 25 May 2021 12:49:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     changhuaixin <changhuaixin@linux.alibaba.com>
Cc:     Benjamin Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        dtcccc@linux.alibaba.com, Juri Lelli <juri.lelli@redhat.com>,
        khlebnikov@yandex-team.ru,
        open list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Odin Ugedal <odin@uged.al>, Odin Ugedal <odin@ugedal.com>,
        pauld@redhead.com, Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        xiyou.wangcong@gmail.com
Subject: Re: [PATCH v5 1/3] sched/fair: Introduce the burstable CFS controller
Message-ID: <YKzWKxD+G4wTd2hf@hirez.programming.kicks-ass.net>
References: <20210520123419.8039-1-changhuaixin@linux.alibaba.com>
 <20210520123419.8039-2-changhuaixin@linux.alibaba.com>
 <YKe89Uda+uJdx4X0@hirez.programming.kicks-ass.net>
 <C759D4F2-FA5F-4EB2-8441-C9ECD79AFD55@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C759D4F2-FA5F-4EB2-8441-C9ECD79AFD55@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 08:42:03PM +0800, changhuaixin wrote:

> >> --- a/kernel/sysctl.c
> >> +++ b/kernel/sysctl.c
> >> @@ -1816,6 +1816,15 @@ static struct ctl_table kern_table[] = {
> >> 		.proc_handler	= proc_dointvec_minmax,
> >> 		.extra1		= SYSCTL_ONE,
> >> 	},
> >> +	{
> >> +		.procname	= "sched_cfs_bw_burst_enabled",
> >> +		.data		= &sysctl_sched_cfs_bw_burst_enabled,
> >> +		.maxlen		= sizeof(unsigned int),
> >> +		.mode		= 0644,
> >> +		.proc_handler	= proc_dointvec_minmax,
> >> +		.extra1		= SYSCTL_ZERO,
> >> +		.extra2		= SYSCTL_ONE,
> >> +	},
> >> #endif
> >> #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> >> 	{
> > 
> > What's the purpose of this new sysctl? By default it is disabled because
> > burst==0, only if you set burst to some !0 value does this actually do
> > anything.
> 
> Originally, this is designed to turn burst feature off when the system becomes unstable.
> Guess we can remove this as you have questioned it.

Is stability a concern? This is CFS after all, if we overload, we simply
share time as per usual.

If there is a real use-case for a global knob to limit/disable this I
don't object too much, but then please explicitly mention it.
