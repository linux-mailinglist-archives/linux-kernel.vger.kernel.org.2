Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF572313CFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbhBHSQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:16:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:62838 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232292AbhBHPlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:41:11 -0500
IronPort-SDR: Mf0cKIsbHnDOvEdzh89j5VCuhPG1AuMng5Iw1OFAAL4+J3Rx+EaJWuvDPDgKisoSs0ZSISbE+w
 maZk651lBXZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951979"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951979"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:22 -0800
IronPort-SDR: BlckNCgQhV4DeGBJcg3Bvz/m15JRa+JIeFYlJG0OnXuU4q27Y2wmBHqZv5CZMVIYOgSuHEUlYd
 9EtRSXe7MPAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820724"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:22 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 19/49] perf/x86: Support filter_match callback
Date:   Mon,  8 Feb 2021 07:25:16 -0800
Message-Id: <1612797946-18784-20-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
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
index 4d9dd83c..b68d38a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2613,6 +2613,14 @@ static int x86_pmu_aux_output_match(struct perf_event *event)
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
@@ -2640,6 +2648,8 @@ static struct pmu pmu = {
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
+
+	.filter_match		= x86_pmu_filter_match,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 84d629d..5759f96 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -900,6 +900,7 @@ struct x86_pmu {
 	 */
 	unsigned long			hybrid_pmu_bitmap;
 	struct x86_hybrid_pmu		hybrid_pmu[X86_HYBRID_PMU_MAX_INDEX];
+	int				(*filter_match)(struct perf_event *event);
 };
 
 struct x86_perf_task_context_opt {
-- 
2.7.4

