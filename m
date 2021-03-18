Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6AC340EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 20:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhCRT6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 15:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhCRT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 15:57:48 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28CEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:57:47 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t18so30560061qva.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=rtKaq18TsAxjH4hNsZHEOk9XNEGOj6GRidAJBUycwvk=;
        b=QDybR7Ly9v0iT8XsOcDMUneD+yf6WOEmGi25IYk3rX4Y1XWKW1iEv5dFwyaEnciGSL
         T3Hbm7PfuoCCj2vdtxaT9bIVKu+8k+AgWwLNwaXIVZIrySsoeaxyAIEXkYlq6hbIRACH
         9o/kM9jnpwK51vz6XSnihOm6FF8/C82jLGpI3K0JQGjuuRGBnyshRoNm3UOltedz51WU
         dKzoHHJfJCbB6gFzLFGy4ahvbbP7LBZUiTmYftNq3Ac95iL7AZHXhQvz9i5AFiGtHbFt
         hfnaSdN+4JetFscFKrH25lto0DdSQsc6v4ji2/TxWNnAXPtFsgZdKOcsg0xFDZ1gvmVg
         ytuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=rtKaq18TsAxjH4hNsZHEOk9XNEGOj6GRidAJBUycwvk=;
        b=ckhqwDxKTuuHPQV3DiKBYXa7Jtg7Ng2fviB//5FCgV0r/WOT/+vt2p2F5tm4C1XrCT
         ujdUavujK/qb/IRW8Wc2ar2MsgHqgQnlZJavk8+HAA0WpPvmXCGPTPegBmXMiDIMj3pQ
         sJx/NidW4XTR108P36Fgv+VvnWFUUnp0UCBgbidonOlDO1oHUaOimur8rZxkivcFmC43
         R526NvW41UYVc4P2CgmM9Gl4Ys0t1TqbnNok88N+KRhQV81qMkHC+7wfcG7If0QFbkQx
         7Mm6ulxLGIsEI3vzaRz5uQQHIsGevVxpUvQmFzrw7EvIuk6QqFBejdl7pnWvYOEhsq0V
         EacQ==
X-Gm-Message-State: AOAM532EdDJVFj7i2tWQMeiWzA3Fa9+whiA+Nz/MMSa3w1fr0lxmQSqN
        SO2DJd3BvPEx+Eh2xOZuHmWqqDGS
X-Google-Smtp-Source: ABdhPJzJ/orxyg6iX2eYUSx00YPy1V8BOqOS+wU8y0qbijL1QXgou63OblKDdorK6BPw38KxQKpxAXdL
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:412:5dfa:c029:17ab:8f38])
 (user=brho job=sendgmr) by 2002:ad4:51c1:: with SMTP id p1mr6158244qvq.39.1616097467014;
 Thu, 18 Mar 2021 12:57:47 -0700 (PDT)
Date:   Thu, 18 Mar 2021 15:57:34 -0400
Message-Id: <20210318195734.3579799-1-brho@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: sched: allow resubmits to queue_balance_callback()
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

i might be missing something here, but this was my interpretation of
what the "if (unlikely(head->next))" check was for in
queue_balance_callback.

 kernel/sched/core.c  | 3 ++-
 kernel/sched/sched.h | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d95dc3f4644..6322975032ea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3669,7 +3669,8 @@ static void __balance_callback(struct rq *rq)
 	rq->balance_callback = NULL;
 	while (head) {
 		func = (void (*)(struct rq *))head->func;
-		next = head->next;
+		/* The last element pointed to itself */
+		next = head->next == head ? NULL : head->next;
 		head->next = NULL;
 		head = next;
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..42629e153f83 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1389,11 +1389,15 @@ queue_balance_callback(struct rq *rq,
 {
 	lockdep_assert_held(&rq->lock);
 
+	/*
+	 * The last element on the list points to itself, so we can always
+	 * detect if head is already enqueued.
+	 */
 	if (unlikely(head->next))
 		return;
 
 	head->func = (void (*)(struct callback_head *))func;
-	head->next = rq->balance_callback;
+	head->next = rq->balance_callback ?: NULL;
 	rq->balance_callback = head;
 }
 
-- 
2.31.0.rc2.261.g7f71774620-goog

