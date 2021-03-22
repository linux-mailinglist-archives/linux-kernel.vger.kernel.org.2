Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F4E344EC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhCVSoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbhCVSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:43:35 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CC5C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:43:34 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id b21so32419887qtr.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 11:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zNDWMRbtqgU+iwXs/7K3ehA/M7zAKlzAJTVv5nnU03o=;
        b=Q8C7exskqqdhqLS56Dtj9+CObLS82y20GOHSZs6XEmEErMwwFH07899rU9f2wBrkQj
         uk171nhed4wl+uKppPNFpAPhRfLIwdj0QqWVI3vkZkmfpkwb0eBCye66/KWxJzghbSj1
         TWa3EvQSKs+ukvkNA0HBITlYQwEDxspD/T6gqQfy8SWhwfM/73G39LD4HzW5Mw9h9l/y
         LCVy3qKauK8nOjM+j4dtKtVK9GdhsDz2wRJaWEzTajvASJKiYnZF3lxaNaRwygzXJKQY
         TJGiG9Sh0JrNKFvvg7SedQlL1ZNFrm0sqMM8dENH8OCGKXM4FGIu4OMIFZm8yOLGOhS6
         RUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zNDWMRbtqgU+iwXs/7K3ehA/M7zAKlzAJTVv5nnU03o=;
        b=XK6i8JS0H1oHmeKJFAOCioiWnWE04sisneRJUErB1ZQtfasQAfE3TtIohEQ/W6CyBH
         qy+rKQsBvoOS2ovprWFFpCGth594GjrgetY6YJM3AxCNPoXdX1Gy+l4LgO3qFZrHttqy
         eWvYyj9Ol3YfZoQyLjer17LG6ILR3NhxIM7IZNbdsoq0QBgnPywKfWIX/vPZfpNeu+FB
         Nu9+aMokgv8n2vpYb5w6LTLUCI0EungLQe7gLjfSW9VXRFG3SmjBrCi8WbzG+20072Qd
         b5zKRqvFvb9zjbG+hWMUZDsK0DV0hsXX/fUJcnYY3qy1n7QzLNyndyilEplMFRi/+PJR
         G68A==
X-Gm-Message-State: AOAM53184nkWJ7FsrMM3tTi87wIKGOLfABZm10VE5Ku8hW9vf2M71CLC
        aLZ+E9Y5fY/RybdjY945inD9MTli
X-Google-Smtp-Source: ABdhPJzLqHXD7iG5PlIToHwO75qUPbROHrLSc6h6IIjcXF5UppPAWSVGFkJL4v9eAOYWJN5u3BxPH6YH
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:412:ec52:3eae:f873:1de1])
 (user=brho job=sendgmr) by 2002:a0c:a99a:: with SMTP id a26mr1093670qvb.2.1616438613767;
 Mon, 22 Mar 2021 11:43:33 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:43:24 -0400
In-Reply-To: <YFh0QjnoGPmbykyE@hirez.programming.kicks-ass.net>
Message-Id: <20210322184324.437430-1-brho@google.com>
Mime-Version: 1.0
References: <YFh0QjnoGPmbykyE@hirez.programming.kicks-ass.net>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2] sched: allow resubmits to queue_balance_callback()
From:   Barret Rhoden <brho@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to this commit, if you submitted the same callback_head twice, it
would be enqueued twice, but only if it was the last callback on the
list.  The first time it was submitted, rq->balance_callback was NULL,
so head->next is NULL.  That defeated the check in
queue_balance_callback().

This commit changes the callback list such that whenever an item is on
the list, its head->next is not NULL.  The last element (first inserted)
will point to itself.  This allows us to detect and ignore any attempt
to reenqueue a callback_head.

Signed-off-by: Barret Rhoden <brho@google.com>
---

sorry about the old version.  i updated to linus's branch, plus a minor
fix from v1.

this should work with the balance_push_callback stuff you added a few
months ago.  in this commit, head->next can equal null *or* head and it
will be treated as null.  (balance_push_callback's next == NULL).

thanks,
barret


 kernel/sched/core.c  | 3 ++-
 kernel/sched/sched.h | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 98191218d891..c5a1a225d0b4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3986,7 +3986,8 @@ static void do_balance_callbacks(struct rq *rq, struct callback_head *head)
 
 	while (head) {
 		func = (void (*)(struct rq *))head->func;
-		next = head->next;
+		/* The last element pointed to itself */
+		next = head->next == head ? NULL : head->next;
 		head->next = NULL;
 		head = next;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 10a1522b1e30..66e1a9e5a1af 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1418,11 +1418,15 @@ queue_balance_callback(struct rq *rq,
 {
 	lockdep_assert_held(&rq->lock);
 
+	/*
+	 * The last element on the list points to itself, so we can always
+	 * detect if head is already enqueued.
+	 */
 	if (unlikely(head->next || rq->balance_callback == &balance_push_callback))
 		return;
 
 	head->func = (void (*)(struct callback_head *))func;
-	head->next = rq->balance_callback;
+	head->next = rq->balance_callback ?: head;
 	rq->balance_callback = head;
 }
 
-- 
2.31.0.rc2.261.g7f71774620-goog

