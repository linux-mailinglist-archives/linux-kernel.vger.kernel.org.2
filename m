Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85AB358980
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhDHQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbhDHQS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:18:56 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6999C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 09:18:44 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id c4so2786665qkg.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z/10m34ld3LPppZE5ruPnrJzxvMepDPhpVu4JH9Ytvw=;
        b=O7k474EAutOW4VpwRnBjWeBNOEW9EL2y5pJh4v8H5Ur89NDOk1FDKy64MyYccijlvX
         M0Ag0uveYy88WoOA+5m4FalB3c/MrXd7ED+ndMuME4+4g76PMZAgtBZIL9Au2soquBUM
         fUaKAj25cNAb/uYCrFTw9VZMMqn+oh1CZntFM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z/10m34ld3LPppZE5ruPnrJzxvMepDPhpVu4JH9Ytvw=;
        b=It14X/T05tKHCgUoVrYtKSNOETqRw7uyIFgJ53fadlYCsRR+k6V4PU02QR+aJYplIC
         AHW8MbQ8qJsU5Ag8FUoI9JIBKQIHeHiqlIu0SqkJEEm2fGZbAWAqworNtRh1y4Y4VMqE
         uyqdvbug4mB+0sSK9DA1PfGy5N/p+CC/NczTVHB65ZPfAW0zaJvj1mucJhxIAxQpt91v
         1wpHX3/rvR3A71vP0DFaQsGJIjr4YTUfISrCveVyvf+AxGz8J3eDjYGetfqW7cD0jGW3
         cOxCXmqeBcIs4u7ZQnxRRn5Y67mPHNlJrBk2J/0SNJPM0QedqbRqpp0MZm6vXweQa4Yq
         bk0w==
X-Gm-Message-State: AOAM53170xfBdebGvmsP8wel8D+YFrmc1dlngwVyPazYKdTBaydEmWjL
        ojirIvP/vwgymV5L2Eg8vD3VdA==
X-Google-Smtp-Source: ABdhPJy0mM6/W2hoIAUimtCmiF2jyderD7q2Bam75Nq/u+lU6NX1c9t28jWrRO48EN4MiVK9EqjZRA==
X-Received: by 2002:a05:620a:31a:: with SMTP id s26mr9282337qkm.355.1617898723743;
        Thu, 08 Apr 2021 09:18:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:52f5])
        by smtp.gmail.com with ESMTPSA id y19sm20990498qky.111.2021.04.08.09.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 09:18:43 -0700 (PDT)
Date:   Thu, 8 Apr 2021 17:18:41 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: page_counter: mitigate consequences of a
 page_counter underflow
Message-ID: <YG8s4X9AB1GoxvYA@chrisdown.name>
References: <20210408143155.2679744-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210408143155.2679744-1-hannes@cmpxchg.org>
User-Agent: Mutt/2.0.6 (98f8cb83) (2021-03-06)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner writes:
>When the unsigned page_counter underflows, even just by a few pages, a
>cgroup will not be able to run anything afterwards and trigger the OOM
>killer in a loop.
>
>Underflows shouldn't happen, but when they do in practice, we may just
>be off by a small amount that doesn't interfere with the normal
>operation - consequences don't need to be that dire.
>
>Reset the page_counter to 0 upon underflow. We'll issue a warning that
>the accounting will be off and then try to keep limping along.
>
>[ We used to do this with the original res_counter, where it was a
>  more straight-forward correction inside the spinlock section. I
>  didn't carry it forward into the lockless page counters for
>  simplicity, but it turns out this is quite useful in practice. ]
>
>Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Chris Down <chris@chrisdown.name>

>---
> mm/page_counter.c | 8 ++++++--
> 1 file changed, 6 insertions(+), 2 deletions(-)
>
>diff --git a/mm/page_counter.c b/mm/page_counter.c
>index c6860f51b6c6..7d83641eb86b 100644
>--- a/mm/page_counter.c
>+++ b/mm/page_counter.c
>@@ -52,9 +52,13 @@ void page_counter_cancel(struct page_counter *counter, unsigned long nr_pages)
> 	long new;
>
> 	new = atomic_long_sub_return(nr_pages, &counter->usage);
>-	propagate_protected_usage(counter, new);
> 	/* More uncharges than charges? */
>-	WARN_ON_ONCE(new < 0);
>+	if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
>+		      new, nr_pages)) {
>+		new = 0;
>+		atomic_long_set(&counter->usage, new);
>+	}
>+	propagate_protected_usage(counter, new);
> }
>
> /**
>-- 
>2.31.1
>
>
