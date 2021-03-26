Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA33334AE2F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 19:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhCZSAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCZSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 14:00:21 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C56C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:00:20 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q3so6062106qkq.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JuCtzQ2o57I1mdRQQKMjDk7R3vh/HcRtMBM2EnWeKIk=;
        b=aLhEkQ+fcyfwKrpLIj7u1BKGvLZLCR2p3gUyur5X74Tb+Q/fJfssm0y4iG4DzazGqi
         NCq0MA2Zb27kRKBkItMr2jFIcYuNbza2fKDNBxvqhb8Yswvk/gq6hyO/7TPVFG7N4Ynj
         s/uMbHjPOs/rAC0vrsz9Y99QO1giQOQQwYy7CCWXDhG8psfn+4BgPJDGPZXFFIlsd6oq
         oDuNS5ZD0QUlzHpe+pCY30sgnvGrDpqfuBPsqEuGVpvyNhu00S63fAIG5l6Usra/eYrE
         PKmD4UrgTeahVohvZxIuv3dmZGNPOCYxkpONz9WCjlVVQ2yL2nE3xY4c5fcv48EzpntY
         15yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JuCtzQ2o57I1mdRQQKMjDk7R3vh/HcRtMBM2EnWeKIk=;
        b=XVbM4MKLfzUc78cIxAIcLb+gPEgEYubdkWEr9hmLsg3qvwX5Go+AmNjSBiNBMrQ6hy
         g7ma5aSHBgUTIcnZtl8YbklzNE9O074w+5zOTBjavgYW6AWrKsV726I15JCZ7ky7lLVc
         g6sAFqw60Uj/8UNx3vXNWS2gZdnUsDPPNZ2ICVyGIR/GrnSGnTlsAG52ceN6UQx87aUC
         dTIAqtLMiowDwNeM7I7YLs6CDFynYIomYtBlwzupn40vzgaj4IgVJ7QJouE7ubyTno0I
         42O4IgBOQSNxViJ3UM2iBrMlV9hVUUvKwMfo4oVBiJTEku8TwVswZXUzeTm3e786kMlC
         nm/g==
X-Gm-Message-State: AOAM531vog6sSYbIqYca/Y/UBJqfeC9cOaNN6Ni4J8fORVqoVf/C+L7d
        jeO+GKOYkzDuBFveoOav0LF1sw==
X-Google-Smtp-Source: ABdhPJxHbmtNqJrtjYI5E8IAtaJPDHUYoCz/4JPeqimu7al57dG+8WEar1jaszzpn+MvtXKz+WUQZg==
X-Received: by 2002:a05:620a:2158:: with SMTP id m24mr14137923qkm.306.1616781620060;
        Fri, 26 Mar 2021 11:00:20 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 131sm7744301qkl.74.2021.03.26.11.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 11:00:19 -0700 (PDT)
Date:   Fri, 26 Mar 2021 14:00:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] sched/psi.c: Rudimentary typo fixes
Message-ID: <YF4hMn4rCftcdsSm@cmpxchg.org>
References: <20210326124233.7586-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326124233.7586-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 06:12:33PM +0530, Bhaskar Chowdhury wrote:
> 
> s/possible/possible/
> s/ exceution/execution/
> s/manupulations/manipulations/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  kernel/sched/psi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 967732c0766c..316ebc57a115 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -59,7 +59,7 @@
>   * states, we would have to conclude a CPU SOME pressure number of
>   * 100%, since *somebody* is waiting on a runqueue at all
>   * times. However, that is clearly not the amount of contention the
> - * workload is experiencing: only one out of 256 possible exceution
> + * workload is experiencing: only one out of 256 possible execution

I thought this was the french spelling.

Joking aside, the corrections look right, but I also had no trouble
understanding what those sentences mean. Typos happen, plus we have a
lot of non-native speakers who won't use perfect spelling or grammar.

So for me, the bar is "this can be easily understood", not "needs to
be perfect English", and I'd say let's skip patches like these unless
they fix something truly unintelligble.

