Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369ED3E90F6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 14:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237961AbhHKM1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 08:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbhHKMZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 08:25:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5F6C061382
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 05:23:43 -0700 (PDT)
Message-ID: <20210811121417.590136432@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628684622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9snN8xer+lJKJI12sG/6cncJ9Ea2JsEyaBt7/r26lmo=;
        b=cNSlBXdTvTuYYj9fmDfEmlzf1uYmt0/YX7YE1VJQFbwoRQ5U5U9fjTdwyg953oAflX5MRn
        2REunNRzPfqIYlG5lqOy750oSMsOY3Um6xaTSmFjpXHwzdqaIuR+/+00Seh5Qqo7ygKYPt
        uf2drcYbbHjpHU5zL/tEO/qSR3x5e1urKsWLFIn8QDLkLXEE5N+nlZHGVQiSgZmYLfDjF3
        f/saULNq/t/ivGuMuXx+A8gsaWJ1ljUUZQ5ZO9pmRHaZkzKBTlAUdYJx8wtNr8VrHhRiBO
        Q/CAR7PghwBrK7V3Kgyk4NJsprSvYCKENhedH24JTSjZ9K5/342PWTxzJYBfXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628684622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=9snN8xer+lJKJI12sG/6cncJ9Ea2JsEyaBt7/r26lmo=;
        b=5AQ0ENmaUwW0Zw8vWDLs3+loNZC1K8DJ2mIa71akzE7xsu3yN27OvopnDaqEtooGgNHwfY
        wlsOCNdlLBCONpCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Mike Galbraith <efault@gmx.de>
Subject: [patch V4 58/68] futex: Remove bogus condition for requeue PI
References: <20210811120348.855823694@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Date:   Wed, 11 Aug 2021 14:23:42 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For requeue PI it's required to establish PI state for the PI futex to
which waiters are requeued. This either acquires the user space futex on
behalf of the top most waiter on the inner 'waitqueue' futex or attaches to
the PI state of an existing waiter or creates on attached to the owner of
the futex.

This code can retry in case of failure, but retry can never happen when the
pi state was successfully created. The condition to run this code is:

  (task_count - nr_wake) < nr_requeue

which is always true because:

   task_count = 0
   nr_wake = 1
   nr_requeue >= 0

Remove it all together.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 kernel/futex.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2000,7 +2000,7 @@ static int futex_requeue(u32 __user *uad
 		}
 	}
 
-	if (requeue_pi && (task_count - nr_wake < nr_requeue)) {
+	if (requeue_pi) {
 		struct task_struct *exiting = NULL;
 
 		/*

