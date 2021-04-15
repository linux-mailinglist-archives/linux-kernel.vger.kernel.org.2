Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B03C360C10
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbhDOOnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhDOOnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:43:20 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C18C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:42:56 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d6so37148qtx.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pUmCri+aAr/3BRvGEMcFWa6v/j3oXvsCBPh6QOca+BM=;
        b=CAqwJVXXXHV9UsITI7oeN41aiJSvPHuVwySb4jFTdw73QJq978n1pLsQsA0ttizUKf
         8MwHq91f0miC/140uGBOer19/RyAyu1yqakuO83IajJg6dclM2QcxM7JUFJef+EvCAZK
         +zIMKHAH2nKocHm6cPOg5Wn3hhw6RYsXBiwDC4k4ZWvaiIOQDu+vxoUKcYx4DYCwxIE8
         f9TIYZ/ajYkqmBS1ji0HyPcyCWtnQe670a8/O/tUF1k1tz9MyAF4RzKQynzihNOp6G+k
         g9StzhiLSLmlsogu4rR5FX1ODUI4Lo1V7DCTVO5xgGdyR//VDf5k79sgD5D2saEd9cts
         kEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pUmCri+aAr/3BRvGEMcFWa6v/j3oXvsCBPh6QOca+BM=;
        b=o4D2Cp3Kf7AZlxfCUuZiS8VBEd5Im8NGVGI7sJ20hLDjn2HMlNnfu0cZzQSdtC+uqY
         CPVP+b3IcdOkisdD4XUmek5k6XOzMNPjXfzFAOB6ZFic9zqX1vW4+xigM5y2s4D2IghH
         5gJvvfLi3UAceqyYbsXr37qbGKX8Q3XGjQ8PdHPFohwjV9Fy5vq4BYJsPI52j2kRVkgC
         47NEw1X52cJtu8qmJ6TCjbaPw7CxIxk/HM6nE4g+3jiuJIARmuBRyZ69mmUaaHbwoHJd
         Qyu1sXNJKXdl2iEXxZn3sKIHe+Pm9lC5zM2GsGxqfPCjlr33UbpvaJxFwolq/nj5xOKS
         g0ow==
X-Gm-Message-State: AOAM530b+fEuin88UeeyI3enSjo5fWLqViEvApgxS9A5Po9ZVvcajRbe
        qKXIvBDf8Bh9VHaMTbWPQuJnTw==
X-Google-Smtp-Source: ABdhPJyiLkQqq1uRdsSlku3udhWSzmpPud8gnHFWMGq/6/8gU2JXJwfypylnNjMp27tCn+p0yV6aKA==
X-Received: by 2002:ac8:4899:: with SMTP id i25mr3321147qtq.59.1618497776168;
        Thu, 15 Apr 2021 07:42:56 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id b1sm1921448qto.36.2021.04.15.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 07:42:55 -0700 (PDT)
Date:   Thu, 15 Apr 2021 10:42:54 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched,psi: fix the 'int' underflow for psi
Message-ID: <YHhQ7tDZWF6tHXSQ@cmpxchg.org>
References: <1618496981-6148-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618496981-6148-1-git-send-email-charante@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 07:59:41PM +0530, Charan Teja Reddy wrote:
> psi_group_cpu->tasks, represented by the unsigned int, stores the number
> of tasks that could be stalled on a psi resource(io/mem/cpu).
> Decrementing these counters at zero leads to wrapping which further
> leads to the psi_group_cpu->state_mask is being set with the respective
> pressure state. This could result into the unnecessary time sampling for
> the pressure state thus cause the spurious psi events. This can further
> lead to wrong actions being taken at the user land based on these psi
> events.
> Though psi_bug is set under these conditions but that just for debug
> purpose. Fix it by decrementing the ->tasks count only when it is
> non-zero.

Makes sense, it's more graceful in the event of a bug.

But what motivates this change? Is it something you hit recently with
an upstream kernel and we should investigate?

> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> ---
>  kernel/sched/psi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 967732c..f925468 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -718,7 +718,8 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  					groupc->tasks[3], clear, set);
>  			psi_bug = 1;
>  		}
> -		groupc->tasks[t]--;
> +		if (groupc->tasks[t])
> +			groupc->tasks[t]--;

There is already a branch on the tasks to signal the bug. How about:

		if (groupc->tasksk[t]) {
			groupc->tasks[t]--;
		} else if (!psi_bug) {
			printk_deferred(...
			psi_bug = 1;
		}
