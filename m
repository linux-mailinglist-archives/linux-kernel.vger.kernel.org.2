Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9471427DF2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 00:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhJIWsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 18:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbhJIWsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 18:48:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06BFC061570
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CdahD9KGB2jW2SFMgdzmX7pbdEnWq7g4q8ajzwa5WNg=; b=XiAm0xm2/4/JT1k6xXlb85PYIh
        Pvf/8J2NVxnunn9kDesp5RREDkQ8LxNrzzcVe0N0p3h7B/KBp7bmvycoIaVNB0zA8uuRRjk6pKgjD
        Rs7S+se/tyMzsYy1L7rb2Ho1K+8hQb8LUuyqrOalRx97h1pC3snRIC3PXk2q6Rhq197V0rytBxxgo
        qmBPe9Gia53/88ZXvZty7B3V4OqlCpCtQappCKrddrRpjeA/P73JnA7/U/RX9D27ojeoI1dwD1VLQ
        UkGh5qpW/5GMz0VJZjOCOs1CLfYJUqhsk2tEsaVeYEvpGWrBvkKmxm38ibgaczOqmYvWpi6lj+t/7
        KG7WKQjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mZL6H-008uwi-LR; Sat, 09 Oct 2021 22:45:53 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 113F29811D4; Sun, 10 Oct 2021 00:45:53 +0200 (CEST)
Date:   Sun, 10 Oct 2021 00:45:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/pelt: Use or not add in update_irq_load_avg()
Message-ID: <20211009224552.GA174703@worktop.programming.kicks-ass.net>
References: <20211009180642.20319-1-tao.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211009180642.20319-1-tao.zhou@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 02:06:42AM +0800, Tao Zhou wrote:
> The ret value of update_irq_load_avg() can be 2. And this value
> is used in __update_blocked_others(). It should be 0 or 1. Use
> OR operation in update_irq_load_avg().

AFAICT it doesn't matter one way or the other, but you're probably right
in that |= makes more sense.

No Signed-off-by tag...

> ---
>  kernel/sched/pelt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index a554e3bbab2b..7edf21f7977c 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -458,7 +458,7 @@ int update_irq_load_avg(struct rq *rq, u64 running)
>  				0,
>  				0,
>  				0);
> -	ret += ___update_load_sum(rq->clock, &rq->avg_irq,
> +	ret |= ___update_load_sum(rq->clock, &rq->avg_irq,
>  				1,
>  				1,
>  				1);
> -- 
> 2.32.0
> 
