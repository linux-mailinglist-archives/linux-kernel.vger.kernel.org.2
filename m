Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10014422398
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 12:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhJEKc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 06:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhJEKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 06:32:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4992AC06161C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 03:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8/E+Skj2P4cErpuwuqBhsyiELvo+Dy6BTQQ10rnG+ys=; b=TFxGeYihBUCt7zt4FMcX3F/Z5A
        MnUwfKY8wnkIgAXFMP2X+rUKAwqgYVIlU1pDfjf+PErjwBGcCkcy6OEx0lQjoL+MPiaI8Un18l36/
        Y2SlaIZXpQSIi7BWgGc7KP/tLiPqLY8d19vpSHpIbgficAV2Ew2kNB7xgzEHhRRUeU2vSPaOQ0+fQ
        P3Tb6HrYPBHZMVW1jKmL6jfGUQ0eKuC/WCle1BtZwg2HQhrqZhCqIilwKSHjOmY+17oiQdGIrdSoV
        zcHjc41t9Ylw8uUNZf0ys8cGfJI7usp8FG1X/gHcZaVqsbHltv66eLF1mM5tsAVdNQxRWeNS9KCgf
        sxRox/gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mXhgT-000DzM-Im; Tue, 05 Oct 2021 10:28:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7C8F300233;
        Tue,  5 Oct 2021 12:28:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C0BCA2038E207; Tue,  5 Oct 2021 12:28:27 +0200 (CEST)
Date:   Tue, 5 Oct 2021 12:28:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>, Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <YVwoy30GY61Z4nid@hirez.programming.kicks-ass.net>
References: <20210920142614.4891-3-mgorman@techsingularity.net>
 <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net>
 <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <20210922132002.GX3959@techsingularity.net>
 <CAKfTPtCxhzz1XgNXM8jaQC2=tGHm0ap88HneUgWTpCSeWVZwsw@mail.gmail.com>
 <20210922150457.GA3959@techsingularity.net>
 <CAKfTPtB3tXwBZ_tVaDdiwMt-=sGH1iV6eUV6Rsnpw7q=tEpBwA@mail.gmail.com>
 <20210922173853.GB3959@techsingularity.net>
 <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtDc39fCLbQqA2BhC6dsb+MyYYMdk9HUvrU0fRqULuQB-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 08:22:43PM +0200, Vincent Guittot wrote:

> @@ -7161,6 +7162,13 @@ static void check_preempt_wakeup(struct rq *rq,
> struct task_struct *p, int wake_
>                 return;
> 
>         update_curr(cfs_rq_of(se));
> +       delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
> +       /*
> +        * Ensure that current got a chance to move forward
> +        */
> +       if (delta_exec < sysctl_sched_min_granularity)
> +               return;
> +

I think we tried that at some point; IIRC the problem with this is that
if the interactive task fails to preempt, that preemption is lost. IOW
interactivity suffers.

Basically if you don't want wake-up preemptions, use SCHED_BATCH, then
those tasks will not preempt one another, but the SCHED_NORMAL tasks
will preempt them.
