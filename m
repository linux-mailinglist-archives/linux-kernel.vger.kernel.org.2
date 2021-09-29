Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8734941C17F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 11:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245036AbhI2JUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhI2JUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 05:20:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D9CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MxJHOOZw60MsFdeldAnHQy5aiHiHdVrAze6Zxk22Um8=; b=URHV/Z6dwxREK0Nk/cvbzT4nTD
        DBKVDDiMJlHfKECPz9ElH+pMuaWoKhgzWgNt5uQVRVCBaKJNDFMGaMnt0jBZognhn87G6UxgCFHcP
        ajtVRjyktLnDfTm49uVYcCm2blKPRJEsrwTwROOdCiKgoj+EceBQqCNqmgBpsG20Yk6Ru9zV0apHd
        n1EwdEl+bpL1YaWEA+c43HTYmmMWm9MX7omMJ2aeW4RJiyS4JOofRQBjaXjZSAqnVOC8dWexiuHwX
        mQxzRcV9/BUw7Qfdqh70JBHfSSyaHGZGPqLt1tjXvqM2dBJf1zz84nC+WCK6jaOpWk8iRsavWQMSY
        AqYsrHPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVVjO-006gFV-Pp; Wed, 29 Sep 2021 09:18:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 23FB3300056;
        Wed, 29 Sep 2021 11:18:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 061FD29AD1D57; Wed, 29 Sep 2021 11:18:25 +0200 (CEST)
Date:   Wed, 29 Sep 2021 11:18:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org, mingo@redhat.com,
        kernel-team@fb.com, eranian@google.com,
        Lucian Grijincu <lucian@fb.com>
Subject: Re: [PATCH v2] perf/core: fix userpage->time_enabled of inactive
 events
Message-ID: <YVQvYUuokUnev0tG@hirez.programming.kicks-ass.net>
References: <20210924012800.2461781-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210924012800.2461781-1-songliubraving@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 06:28:00PM -0700, Song Liu wrote:

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 1cb1f9b8392e2..d73f986eef7b3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3707,6 +3707,46 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
>  	return 0;
>  }
>  
> +static inline bool event_update_userpage(struct perf_event *event)
> +{
> +	/*
> +	 * Checking mmap_count to avoid unnecessary work. This does leave a
> +	 * corner case: if the event is enabled before mmap(), the first
> +	 * time the event gets scheduled is via:
> +	 *
> +	 *  __perf_event_enable (or __perf_install_in_context)
> +	 *      -> ctx_resched
> +	 *         -> perf_event_sched_in
> +	 *            -> ctx_sched_in
> +	 *
> +	 * with mmap_count of 0, so we will skip here. As a result,
> +	 * userpage->offset is not accurate after mmap and before the
> +	 * first rotation.
> +	 *
> +	 * To avoid the discrepancy of this window, the user space should
> +	 * mmap the event before enabling it.
> +	 */

It seems to me that writing that comment was more work than actually
fixing perf_mmap() to DTRT, no? AFAICT all we need is something like:

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fd2ae70fa6c4..1e33c2e6b0dc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6324,6 +6324,8 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 		ring_buffer_attach(event, rb);
 
+		perf_event_update_time(event);
+		perf_set_shadow_time(event, event->ctx);
 		perf_event_init_userpage(event);
 		perf_event_update_userpage(event);
 	} else {

