Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9167535E3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344500AbhDMQ22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 12:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343767AbhDMQ20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 12:28:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD61A61220;
        Tue, 13 Apr 2021 16:28:05 +0000 (UTC)
Date:   Tue, 13 Apr 2021 12:28:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Hui Su <suhui@zeku.com>, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: remove the redundant comments
Message-ID: <20210413122804.2d69fca6@gandalf.local.home>
In-Reply-To: <d9c447fd-d3f5-cb66-b3a9-7f7002594ccc@arm.com>
References: <20210412073928.1120823-1-suhui@zeku.com>
        <d9c447fd-d3f5-cb66-b3a9-7f7002594ccc@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 10:36:07 +0200
Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

> > @@ -897,11 +897,6 @@ DECLARE_STATIC_KEY_FALSE(sched_uclamp_used);
> >  struct rq {
> >  	/* runqueue lock: */
> >  	raw_spinlock_t		lock;
> > -
> > -	/*
> > -	 * nr_running and cpu_load should be in the same cacheline because
> > -	 * remote CPUs use both these fields when doing load calculation.
> > -	 */
> >  	unsigned int		nr_running;
> >  #ifdef CONFIG_NUMA_BALANCING
> >  	unsigned int		nr_numa_running;  
> 
> I forgot to remove this snippet back then. LGTM.
> 
> Add a
> 
>   Fixes: 55627e3cd22c ("sched/core: Remove rq->cpu_load[]")
> 
> line.

It's just removing a comment. Should it really need a "Fixes" tag, which
will cause many people to look at it to determine if it should be
backported to stable?

-- Steve
