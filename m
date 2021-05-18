Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A92F387949
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 14:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349439AbhERM42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 08:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349405AbhERM4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 08:56:21 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52475C061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:55:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso1510857pji.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1S0+65DlHcqIy/iliVc4sMHyoFziFu6YzLua2qsbzig=;
        b=mD7uYykRtq2XnkUd6TsE7uu9uR0ALELlPnrE1eW9JwlanSiooRR6B0riEaoUAve/NH
         2a4pUFHYX+MZ4pRXYrj3OQkhPe2L13Svfyq/3FQWQIw4DXWH9ShnqPCxQRtf5rDspYyi
         YZzTttCIMyE0d9Dg6I36b5nxdub3NyFjrGeOt3W2xU1xqYdHURkGrsnVUmHJ92Kne9ZR
         PSuVzkuYxt9zOjp8o/q0RFYplK4bg7BCVr7S5dkgSvqmE8zoPfA78Yv7nklxecrD5CwS
         8jMs+i7y7HeraHt7WshcG3veCbrwJltpgwG9hKuw8u6s9+PQlYb50hoZqXXuOy92eRCa
         Z2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1S0+65DlHcqIy/iliVc4sMHyoFziFu6YzLua2qsbzig=;
        b=nfGI5/TqOgGtWX/G8n6Q60PINL3q74Uoz5HbIEbvSW4t4dfmws0etVa2eH6oh8S95D
         U5MzV29hwcxY3ZiIf6ezOTq94060MPthhK6zPjbMwZ/iqK74dT8Dodu+gGgN+ur/NWqF
         CkttpTFe7zVwHdbCOkkVtZSLJOUDMtfYD4Ur5qH+AAtKehMn2B5x7/sCTCniLFoVo3Oe
         k6x7B4TaWIADRlumjgDofu4BHFzbuB35e4f2n0GA5nONzvDIy8LpR8zWGF2lruuHwafw
         TN1v6JUgysDGMhoBpY8Qk1Sxq82E6DhFvv2k70A3TDpgVvr5HXPkwyyCrTEHnfY3b904
         tGIw==
X-Gm-Message-State: AOAM5330IEW1b+0za6xcDROaW6aPV6xFBQ9F1wFWRoyHPxcvv2hQf+Lu
        Udro9/IV54iFxkcjmNhOkDA=
X-Google-Smtp-Source: ABdhPJzh9FJS7TJT2BUL0+meTilfE3yC11N44jUbW5SNnq1bDjWIlxEK3XNSlCqK25jspD+6E5FPMg==
X-Received: by 2002:a17:902:a60a:b029:f0:ad94:70bf with SMTP id u10-20020a170902a60ab02900f0ad9470bfmr4478018plq.31.1621342502890;
        Tue, 18 May 2021 05:55:02 -0700 (PDT)
Received: from sz-dl-056.autox.sz ([45.67.53.159])
        by smtp.gmail.com with ESMTPSA id mp21sm2047204pjb.50.2021.05.18.05.54.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 May 2021 05:55:02 -0700 (PDT)
From:   Yejune Deng <yejune.deng@gmail.com>
X-Google-Original-From: Yejune Deng <yejunedeng@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yejune Deng <yejunedeng@gmail.com>
Subject: [PATCH] sched: simplify is_cpu_allowed() code
Date:   Tue, 18 May 2021 20:54:46 +0800
Message-Id: <1621342486-9643-1-git-send-email-yejunedeng@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Combine multiple if statements that return the same value.

Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
---
 kernel/sched/core.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3ab28de..b9b4452 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2153,26 +2153,18 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
  */
 static inline bool is_cpu_allowed(struct task_struct *p, int cpu)
 {
-	/* When not in the task's cpumask, no point in looking further. */
-	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+	/*
+	 * When not in the task's cpumask, no point in looking further.
+	 * Regular kernel threads don't get to stay during offline.
+	 *
+	 */
+	if (!cpumask_test_cpu(cpu, p->cpus_ptr) || cpu_dying(cpu))
 		return false;
 
-	/* migrate_disabled() must be allowed to finish. */
-	if (is_migration_disabled(p))
-		return cpu_online(cpu);
-
 	/* Non kernel threads are not allowed during either online or offline. */
 	if (!(p->flags & PF_KTHREAD))
 		return cpu_active(cpu);
 
-	/* KTHREAD_IS_PER_CPU is always allowed. */
-	if (kthread_is_per_cpu(p))
-		return cpu_online(cpu);
-
-	/* Regular kernel threads don't get to stay during offline. */
-	if (cpu_dying(cpu))
-		return false;
-
 	/* But are allowed during online. */
 	return cpu_online(cpu);
 }
-- 
2.7.4

