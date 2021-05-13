Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C43A37F9CE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 16:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbhEMOjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 10:39:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:61116 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234536AbhEMOiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 10:38:51 -0400
IronPort-SDR: s4N0CFVq8dSoGB1gHQdbwLLqTAblcs79XeoBh4UM6uzfNJJxZ+SaH4x59u4DSddwVoGS8CWyPK
 QFvivQzwrLgA==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="187375749"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="187375749"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 07:36:30 -0700
IronPort-SDR: QsclJbgROVSahcDgBKEOj1BBfXuVe2EFdd/xJMWBVtEGx5VIQaJubVVRdlfD/oUlEA6S/Toyiq
 3WTgMc2954aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="542503735"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2021 07:36:30 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     robh@kernel.org, ak@linux.intel.com, acme@kernel.org,
        mark.rutland@arm.com, luto@amacapital.net, eranian@google.com,
        namhyung@kernel.org, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V7 1/2] perf: Track per-PMU sched_task() callback users
Date:   Thu, 13 May 2021 07:23:01 -0700
Message-Id: <1620915782-50154-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current perf only tracks the per-CPU sched_task() callback users, which
doesn't work if a callback user is a task. For example, the dirty
counters have to be cleared to prevent data leakage when a new RDPMC
task is scheduled in. The task may be created on one CPU but running on
another CPU. It cannot be tracked by the per-CPU variable. A global
variable is not going to work either because of the hybrid PMUs.
Add a per-PMU variable to track the callback users.

In theory, the per-PMU variable should be checked everywhere the
sched_task() can be called. But the X86 RDPMC is the only user for the
per-PMU sched_cb_usage. A callback for the X86 RDPMC is required only
when a different context is scheduled in. To avoid unnecessary
sched_task() invoke, the per-PMU sched_cb_usage is only checked there.
Should there be any other ARCHs which require it in the other places,
it can be added later separately.

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

- New patch. Split the V6 to core and x86 parts.

 include/linux/perf_event.h | 3 +++
 kernel/events/core.c       | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c8a3388..c6ee202 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -301,6 +301,9 @@ struct pmu {
 	/* number of address filters this PMU can do */
 	unsigned int			nr_addr_filters;
 
+	/* Track the per PMU sched_task() callback users */
+	atomic_t			sched_cb_usage;
+
 	/*
 	 * Fully disable/enable this PMU, can be used to protect from the PMI
 	 * as well as for lazy/batch writing of the MSRs.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1574b70..286b718 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3851,7 +3851,14 @@ static void perf_event_context_sched_in(struct perf_event_context *ctx,
 		cpu_ctx_sched_out(cpuctx, EVENT_FLEXIBLE);
 	perf_event_sched_in(cpuctx, ctx, task);
 
-	if (cpuctx->sched_cb_usage && pmu->sched_task)
+	/*
+	 * X86 RDPMC is the only user for the per-PMU sched_cb_usage.
+	 * A callback for the X86 RDPMC is required only when a
+	 * different context is scheduled in.
+	 * To avoid unnecessary sched_task() invoke, the per-PMU
+	 * sched_cb_usage is only checked here.
+	 */
+	if (pmu->sched_task && (cpuctx->sched_cb_usage || atomic_read(&pmu->sched_cb_usage)))
 		pmu->sched_task(cpuctx->task_ctx, true);
 
 	perf_pmu_enable(pmu);
-- 
2.7.4

