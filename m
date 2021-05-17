Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDFD383DDC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbhEQTzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:55:37 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:36366 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235960AbhEQTz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:55:28 -0400
Received: by mail-oi1-f171.google.com with SMTP id f184so7594377oig.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UJvFAYsfphhNGnY3JCFzbqw4ycY8JjD7sKxWZWUclr0=;
        b=UzreqkDOWnnwglZ5z3LqZl35ZnXvHJr9l16aTLJdndTzKqEQ9LEzJ8TcVb1fvdQI42
         hzC4Q20VTg7i9F6dt8fPEErdO1trFCSvxPWzpO3P9JmerEJLNM4YHzqZgA3JU4q7416H
         Ofy1OF4O/bcnxuy1jqcuUHt2kg2mZ48xRwiTukHveIr6YB1oyCf/O6BcFpWccoCjv170
         HdZH/Kel8hewvYPX5mvLjBOTZIT4fFRQPRkkwhJgTVtBRTkfiwxDzDgq4lUrh15IBNSD
         w5TXFosIhIRNdJehyda9d8yZgi2z+X8/IFej/hMacqI5QsQwbe3N2d5p6iO8hBUHMBjk
         F2sw==
X-Gm-Message-State: AOAM533jW4omaNXAsTbD6o1e+uZSg4jgDWVwBSPo6KQIAaR30bZiNteg
        AwmsK6jK0+5kIvNtXANFcQ==
X-Google-Smtp-Source: ABdhPJz2iLQy5JnlibjkljwKIgDqzaIcmfI5Zf6XTZobqsaP4PvnrXrcib+BZmN16wilY0bRGDtzjw==
X-Received: by 2002:a05:6808:128a:: with SMTP id a10mr579189oiw.161.1621281251996;
        Mon, 17 May 2021 12:54:11 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id m81sm2920758oig.43.2021.05.17.12.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:54:10 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/5] perf: Track per-PMU sched_task() callback users
Date:   Mon, 17 May 2021 14:54:02 -0500
Message-Id: <20210517195405.3079458-3-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210517195405.3079458-1-robh@kernel.org>
References: <20210517195405.3079458-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current perf only tracks the per-CPU sched_task() callback users, which
doesn't work if a callback user is a task. For example, the dirty
counters have to be cleared to prevent data leakage when a new userspace
access task is scheduled in. The task may be created on one CPU but
running on another CPU. It cannot be tracked by the per-CPU variable. A
global variable is not going to work either because of the hybrid PMUs.
Add a per-PMU variable to track the callback users.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
[robh: Also call sched_task() got sched out cases]
Signed-off-by: Rob Herring <robh@kernel.org>
---
 include/linux/perf_event.h | 3 +++
 kernel/events/core.c       | 8 +++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 4cf081e22b76..a88d52e80864 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -300,6 +300,9 @@ struct pmu {
 	/* number of address filters this PMU can do */
 	unsigned int			nr_addr_filters;
 
+	/* Track the per PMU sched_task() callback users */
+	atomic_t			sched_cb_usage;
+
 	/*
 	 * Fully disable/enable this PMU, can be used to protect from the PMI
 	 * as well as for lazy/batch writing of the MSRs.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2e947a485898..6d0507c23240 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3448,7 +3448,8 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 
 			perf_pmu_disable(pmu);
 
-			if (cpuctx->sched_cb_usage && pmu->sched_task)
+			if (pmu->sched_task &&
+			    (cpuctx->sched_cb_usage || atomic_read(&pmu->sched_cb_usage)))
 				pmu->sched_task(ctx, false);
 
 			/*
@@ -3488,7 +3489,8 @@ static void perf_event_context_sched_out(struct task_struct *task, int ctxn,
 		raw_spin_lock(&ctx->lock);
 		perf_pmu_disable(pmu);
 
-		if (cpuctx->sched_cb_usage && pmu->sched_task)
+		if (pmu->sched_task &&
+		    (cpuctx->sched_cb_usage || atomic_read(&pmu->sched_cb_usage)))
 			pmu->sched_task(ctx, false);
 		task_ctx_sched_out(cpuctx, ctx, EVENT_ALL);
 
@@ -3851,7 +3853,7 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
 	perf_event_sched_in(cpuctx, ctx, task);
 
-	if (cpuctx->sched_cb_usage && pmu->sched_task)
+	if (pmu->sched_task && (cpuctx->sched_cb_usage || atomic_read(&pmu->sched_cb_usage)))
 		pmu->sched_task(cpuctx->task_ctx, true);
 
 	perf_pmu_enable(pmu);
-- 
2.27.0

