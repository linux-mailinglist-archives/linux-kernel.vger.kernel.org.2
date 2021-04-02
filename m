Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D3335245F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbhDBASS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:18:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:48424 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236601AbhDBAR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:59 -0400
IronPort-SDR: RWNT+qmQuIzo08cfEHj1vTPp0Tz4A3Yd6gykQcQuRG6Y0RDmGHXn80II6wT6HrDcwfzReLM0eo
 kkGH3g5EFINg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171775052"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="171775052"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:52 -0700
IronPort-SDR: wX7QKUFcV9QqVqovsMMtGNXuEMoN4pMcU5ttSEX0gMHxHNkHIAhgJQBu4jw646g4rYZ3drk7NX
 5A8qk1+U6mKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399381"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:52 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 19/25] perf/x86: Support filter_match callback
Date:   Thu,  1 Apr 2021 17:10:46 -0700
Message-Id: <1617322252-154215-20-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Implement filter_match callback for X86, which check whether an event is
schedulable on the current CPU.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c       | 10 ++++++++++
 arch/x86/events/perf_event.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 19e026a..18b75d6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2650,6 +2650,14 @@ static int x86_pmu_aux_output_match(struct perf_event *event)
 	return 0;
 }
 
+static int x86_pmu_filter_match(struct perf_event *event)
+{
+	if (x86_pmu.filter_match)
+		return x86_pmu.filter_match(event);
+
+	return 1;
+}
+
 static struct pmu pmu = {
 	.pmu_enable		= x86_pmu_enable,
 	.pmu_disable		= x86_pmu_disable,
@@ -2677,6 +2685,8 @@ static struct pmu pmu = {
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
+
+	.filter_match		= x86_pmu_filter_match,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index c1c90c3..f996686 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -870,6 +870,7 @@ struct x86_pmu {
 
 	int (*aux_output_match) (struct perf_event *event);
 
+	int (*filter_match)(struct perf_event *event);
 	/*
 	 * Hybrid support
 	 *
-- 
2.7.4

