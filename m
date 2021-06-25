Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A7F3B3E63
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 10:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhFYIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhFYIYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 04:24:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCE8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jIhYZf/q/ceFYrntsKFSdR8KTn/qUTHv3/eT0mVybbQ=; b=Fie/cVmq4pzfFKzyg4ceGWYqWo
        uP+JzVa2no0BsAdW0CcdTkCX72yTOogwpCkQwKF+unMBfwlj51xRj8I0PiBhNtw2XzwAXEy1Q4pB+
        Z6RYSWKlQmFim4XbJAxfv/ZeKYkpJtwiqPe0JM5GDnD8BOt3sy/dQarKIMYB5ao2V9MJIswHEZvEk
        /6GRnmhs32EJJKBwsvvNkjI3EVQ6qqg6HwB09jx0M3lujdZ0EZxuivu7Z3THjYTCI8DTg7ozs4mbK
        BqEIkclC5M7pIs8NZYGBRJQSVecBTH7B3cTZudijClVp/saptujS4Fa8M4VEk/iMY7tzQrRpf1AYT
        qzcHVz6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwh55-00HSLe-Hg; Fri, 25 Jun 2021 08:20:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0A26F300252;
        Fri, 25 Jun 2021 10:20:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D93F520171CE8; Fri, 25 Jun 2021 10:20:54 +0200 (CEST)
Date:   Fri, 25 Jun 2021 10:20:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Paul Turner <pjt@google.com>,
        David Rientjes <rientjes@google.com>,
        Oleg Rombakh <olegrom@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Steve Sistare <steven.sistare@oracle.com>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: cgroup SCHED_IDLE support
Message-ID: <YNWR5qgkAxzLtUKK@hirez.programming.kicks-ass.net>
References: <20210608231132.32012-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210608231132.32012-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 08, 2021 at 04:11:32PM -0700, Josh Don wrote:
> +static int se_is_idle(struct sched_entity *se)
> +{
> +	if (entity_is_task(se))
> +		return task_has_idle_policy(task_of(se));
> +	return cfs_rq_is_idle(group_cfs_rq(se));
> +}

I'm conflicted on this, on the one hand, since we want 'idle' to be a
sched_entity propery, I'd say, make it a sched_entity field, OTOH,
that's probably going to be a mess too :/

Let me read more..
