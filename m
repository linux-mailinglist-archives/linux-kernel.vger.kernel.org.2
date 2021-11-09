Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDFF44AC5C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245631AbhKILSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:18:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245616AbhKILSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:18:21 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAF0C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 03:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=w1EOH6FPBwa3M2ymytmOdE7Dwkz35NxpmkwCa2EKnko=; b=OJJOWDfTxVYdPuwTP2rFq28Tiv
        PJOyMuRCOA5fjZK2HdhyJMG1gO6idcNwJVC1mS9khNjjB7FP8elEcGKhWHJfLOLL282yLnKoUf4qb
        WgHAUKyjuqgW9agKfQWlByUsLZmtw/Je2RFVXA2bK6RK7OUK5sUWmgi7MLOEmAJop81/BkKSjrIL4
        6JG0UxZnKF/mpaxFOI7ML39Rx3yPaRu5DZWvl89Y8/rjHqB1lDFY2kqnV3JSHX7XbepEFTablHtJ/
        z0MRP3sAOFXLu/2/KM9jO1Q5q1S2DpILsetT3F9lktKWQfrZAS+RqmIT4V5ub3gXg89vKDANViumT
        jnwM+bLg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mkP5r-000yft-VJ; Tue, 09 Nov 2021 11:15:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A372F300388;
        Tue,  9 Nov 2021 12:15:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 67258203B736E; Tue,  9 Nov 2021 12:15:11 +0100 (CET)
Date:   Tue, 9 Nov 2021 12:15:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineethrp@gmail.com>,
        Hao Luo <haoluo@google.com>, Tao Zhou <tao.zhou@linux.dev>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched/core: forced idle accounting
Message-ID: <YYpYP919xlC0NX7/@hirez.programming.kicks-ass.net>
References: <20211018203428.2025792-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018203428.2025792-1-joshdon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 01:34:28PM -0700, Josh Don wrote:
> @@ -5804,6 +5830,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>  		}
>  	}
>  
> +	if (rq->core->core_forceidle_count) {

Does this want to be something like:

	if (schedstat_enabled() && .. ) ?

afaict without schedstat on this is dead code.

> +		if (cookie)
> +			rq->core->core_forceidle_start = rq_clock(rq->core);
> +		rq->core->core_forceidle_occupation = occ;
> +	}
> +
>  	rq->core->core_pick_seq = rq->core->core_task_seq;
>  	next = rq->core_pick;
>  	rq->core_sched_seq = rq->core->core_pick_seq;
