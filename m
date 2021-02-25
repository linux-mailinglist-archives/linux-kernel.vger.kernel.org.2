Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 004CA32455B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 21:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbhBXUix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 15:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbhBXUir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 15:38:47 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33EDC061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 12:38:07 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b14so3613451qkk.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 12:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k+Ml1eYPwjOONJLtwcZvZvyigCe2sKPobwXhkk2LCr8=;
        b=o683AocjgiZ8dTsfbgOPsZ0aNJ93D7mHTzh53sWfdoei5j0GUCUom8CTWS2haEcrTz
         Etc0lxlpqsu/wejXMugE69CVKPANUh9/hPseekOUrWhEMhp+HxppQ7M5KMfPNpi+8uv6
         Pz2E9Ft44GezYCi1smMUl2sf/q2/uIT6JFHyb6POyQmgE90TJJO+qvx9OvOLjRQKQrPP
         98KVonZFM0YhzjL/p4lSzkDV2hP53C4rZNzuKz6HucLSusO72qjeKVfWwXEzBL94NV7/
         wCsvay/o2YDZeBYyR/5tRu7x7EKdsyXlFM45IJLzvzrmNl71lG8xorzEwLULc3Ys92bd
         6NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k+Ml1eYPwjOONJLtwcZvZvyigCe2sKPobwXhkk2LCr8=;
        b=peieYB+tupDfxH73bps6zUSurL4TGrh7wEct2yUjj1Kmrj2p9AgztR/j5vaX7inN7c
         R2uXPfr7TqhhUDSAJLcs5ikavaGHCAFVkPYFrGEkTkn83JWxuTcas6CNvnh4CFJTFY1/
         bmRT9m3plHTeWniuJkaZrBLbRTdkiOLi2bd1nQRQLnWIyEbhwzUmNjxMxKH7E59PA9n+
         t10wunEB7kkUapMt9g/tXGLguUsPqlOHRY/QZnxsEwLuIbimwGFXpsjlArr7lr9WbsYx
         6ZkS7W1R7M84tJTxql5GRJW43GmqDZVrp6jgjC254wxQKQSF6WMifYRZIFQVMOiQXTRp
         ad0Q==
X-Gm-Message-State: AOAM5315GT1SgWuBfJ6HNIyYXg4PFerTOLjuJrKQrHsSjZKZGCzaXl5u
        D1a6XgLMXhjbM94P1DEBAThzAg==
X-Google-Smtp-Source: ABdhPJxE7Kk7WVegfW0dA3yem37nnEyNTOTba6gF7TKuZQhgqeiPc6vBrRVVN2Z1PlsTot+hhmq9cA==
X-Received: by 2002:ae9:e50c:: with SMTP id w12mr32981266qkf.42.1614199086632;
        Wed, 24 Feb 2021 12:38:06 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id j20sm2399834qtl.36.2021.02.24.12.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 12:38:06 -0800 (PST)
Date:   Wed, 24 Feb 2021 15:38:05 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     David Rientjes <rientjes@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: enable memcg oom-kill for __GFP_NOFAIL
Message-ID: <YDa5LcoaaUXszPXz@cmpxchg.org>
References: <20210223204337.2785120-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223204337.2785120-1-shakeelb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 12:43:37PM -0800, Shakeel Butt wrote:
> In the era of async memcg oom-killer, the commit a0d8b00a3381 ("mm:
> memcg: do not declare OOM from __GFP_NOFAIL allocations") added the code
> to skip memcg oom-killer for __GFP_NOFAIL allocations. The reason was
> that the __GFP_NOFAIL callers will not enter aync oom synchronization
> path and will keep the task marked as in memcg oom. At that time the
> tasks marked in memcg oom can bypass the memcg limits and the oom
> synchronization would have happened later in the later userspace
> triggered page fault. Thus letting the task marked as under memcg oom
> bypass the memcg limit for arbitrary time.
> 
> With the synchronous memcg oom-killer (commit 29ef680ae7c21 ("memcg,
> oom: move out_of_memory back to the charge path")) and not letting the
> task marked under memcg oom to bypass the memcg limits (commit
> 1f14c1ac19aa4 ("mm: memcg: do not allow task about to OOM kill to bypass
> the limit")), we can again allow __GFP_NOFAIL allocations to trigger
> memcg oom-kill. This will make memcg oom behavior closer to page
> allocator oom behavior.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
