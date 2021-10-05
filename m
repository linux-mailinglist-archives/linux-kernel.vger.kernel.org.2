Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CFB42225A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhJEJfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbhJEJfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:35:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128E5C061745
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 02:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GQy6jrQzp7SQEfSgsx40GCt9tDyuUPnWczLZw1jnZNM=; b=HSxIC9GgQfg66qlEOswlFup3Q3
        DGqP9JGzvBA8Znx5BmbfKC24ItVpjHNw/TB/52bkvorLcGM+6B7OwFZMn3H55dPUw58PrqajVmFNr
        tLKnrB9GmGKX+ztz6EejW7DE/F7QulOymymh7Vh4vXVdabCkcpC1KF89CuhS0UVHMHCpmdV5y0Mgw
        Y7KLONVLtgbiWB2I6UYiC6gl8oUJNKbXppQCV8zZHE3jPKqszDqP59CvbIWZq5i/w37Zjdi7fq4Z7
        upf56TJED4wC7B0aDyFMtVkBj8EkfkAtB9VCcTespXwrQNWquws9+YdXmtqFqER/i6tEtOdyPRm2k
        X8LOiApw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXgns-000BNi-O4; Tue, 05 Oct 2021 09:32:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F4F4300233;
        Tue,  5 Oct 2021 11:32:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21FD7202A012E; Tue,  5 Oct 2021 11:32:04 +0200 (CEST)
Date:   Tue, 5 Oct 2021 11:32:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <YVwblBZ9JBn9vvVr@hirez.programming.kicks-ass.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net>
 <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net>
 <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922132002.GX3959@techsingularity.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 02:20:02PM +0100, Mel Gorman wrote:
> 
> Note that the TuneD throughput-performance profile allows up to 15ms
> for sysctl_sched_latency (ignoring scaling) but there is no explanation
> why such a long period was necessary or why sched_latency_ns is also
> not adjusted. The intent may have been to disable wakeup preemption
> or it might be an oversight.  An internet search for instances where
> sysctl_sched_wakeup_granularity parameter are tuned to high values offer
> either no explanation or a broken one.

FWIW, if one wants to disable wakeup preemption, we've got SCHED_BATCH
for that.
