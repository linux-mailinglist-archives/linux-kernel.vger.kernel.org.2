Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0262415BC3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 12:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbhIWKKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 06:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbhIWKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 06:10:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16DDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 03:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1PpKlPDoBSuaeYeHR/2+8Aixyu6VFnAIgOUGkUJPnsc=; b=lekoeEu5cRUMdgg1iAAtLeAiPd
        JjupVJ/wGLr36iYK2c3b4d3kHisYTtfWg3MTAewxiHyrLX15pl12jDwNparXBE7X4RMfkUcV4K2KH
        FmoxOySjbz3ENcLvE+gk6G1HLiTK0guoeDYhNjK4IK5+puoHUkA50F5tUltIjCeEzk5XcnVtCKfrY
        JqN6Ok+dccU0OW8AM9nbPjsQD1K/6khrpRfVQL1AgnzJnCzlItjlA48mv4y8aI6P5jXGBQepv+0ZA
        hV5PSUO86Gtr7k11c1+wNZYZHEsve7RM1mQIWN1aUyX/gk+k5HH0P7N+/3LCqDXuRONIZm8ALz54V
        /uuYhqaA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTLeu-005Cj0-4r; Thu, 23 Sep 2021 10:08:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D3F7C300250;
        Thu, 23 Sep 2021 12:08:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BC0662C9B8AB5; Thu, 23 Sep 2021 12:08:50 +0200 (CEST)
Date:   Thu, 23 Sep 2021 12:08:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org, mingo@redhat.com,
        kernel-team@fb.com, eranian@google.com,
        Lucian Grijincu <lucian@fb.com>
Subject: Re: [PATCH] perf/core: fix userpage->time_enabled of inactive events
Message-ID: <YUxSMqrJK/rKPZS3@hirez.programming.kicks-ass.net>
References: <20210922011715.4154119-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922011715.4154119-1-songliubraving@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 06:17:15PM -0700, Song Liu wrote:
> Users of rdpmc rely on the mmapped user page to calculate accurate
> time_enabled. Currently, userpage->time_enabled is only updated when the
> event is added to the pmu. As a result, inactive event (due to counter
> multiplexing) does not have accurate userpage->time_enabled. This can
> be reproduced with something like:
> 
>    /* open 20 task perf_event "cycles", to create multiplexing */
> 
>    fd = perf_event_open();  /* open task perf_event "cycles" */
>    userpage = mmap(fd);     /* use mmap and rdmpc */
> 
>    while (true) {
>      time_enabled_mmap = xxx; /* use logic in perf_event_mmap_page */
>      time_enabled_read = read(fd).time_enabled;
>      if (time_enabled_mmap > time_enabled_read)
>          BUG();
>    }

*groan*, yes I fear you're right.

> @@ -3807,6 +3816,23 @@ ctx_sched_in(struct perf_event_context *ctx,
>  	/* Then walk through the lower prio flexible groups */
>  	if (is_active & EVENT_FLEXIBLE)
>  		ctx_flexible_sched_in(ctx, cpuctx);
> +
> +	/*
> +	 * Update userpage for inactive events. This is needed for accurate
> +	 * time_enabled.
> +	 */
> +	if (unlikely(ctx->rotate_necessary)) {
> +		struct perf_event *event;
> +
> +		perf_event_groups_for_each(event, &ctx->pinned_groups) {
> +			if (event->state == PERF_EVENT_STATE_INACTIVE)
> +				perf_event_update_inactive_userpage(event, ctx);
> +		}

That's a straight up error, if a pinned event doesn't get scheduled,
it's game over.

> +		perf_event_groups_for_each(event, &ctx->flexible_groups) {
> +			if (event->state == PERF_EVENT_STATE_INACTIVE)
> +				perf_event_update_inactive_userpage(event, ctx);
> +		}
> +	}
>  }

That's terrible though, and also wrong I think.

It's wrong because:

 - you should only do this for (is_active & EVENT_TIME)
 - you should only consider the events visit_groups_merge() would have
 - you miss updating group-siling events

(I also think it's possible to try harder to avoid the work)

Now, looking at visit_groups_merge() we only terminate the iteration
when func returns !0, which is merge_sched_in(), and that *never*
returns !0.

So we already iterate all the right events. So I'm thinking we can do
something like the below, hmm?


diff --git a/kernel/events/core.c b/kernel/events/core.c
index 0c000cb01eeb..4d1e962c2ebe 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3707,6 +3712,28 @@ static noinline int visit_groups_merge(struct perf_cpu_context *cpuctx,
 	return 0;
 }
 
+static inline bool event_update_userpage(struct perf_event *event)
+{
+	if (!atomic_read(&event->mmap_count))
+		return false;
+
+	perf_event_update_time(event);
+	perf_set_shadow_time(event, event->ctx);
+	perf_event_update_userpage(event);
+	return true;
+}
+
+static inline void group_update_userpage(struct perf_event *group_event)
+{
+	struct perf_event *event;
+
+	if (!event_update_userpage(group_event))
+		return;
+
+	for_each_sibling_event(event, group_event)
+		event_update_userpage(event);
+}
+
 static int merge_sched_in(struct perf_event *event, void *data)
 {
 	struct perf_event_context *ctx = event->ctx;
@@ -3725,14 +3752,18 @@ static int merge_sched_in(struct perf_event *event, void *data)
 	}
 
 	if (event->state == PERF_EVENT_STATE_INACTIVE) {
+		*can_add_hw = 0;
+
 		if (event->attr.pinned) {
 			perf_cgroup_event_disable(event, ctx);
 			perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
-		}
 
-		*can_add_hw = 0;
-		ctx->rotate_necessary = 1;
-		perf_mux_hrtimer_restart(cpuctx);
+		} else {
+			ctx->rotate_necessary = 1;
+			perf_mux_hrtimer_restart(cpuctx);
+
+			group_update_userpage(event);
+		}
 	}
 
 	return 0;
