Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3755035C8FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242656AbhDLOjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:39:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:29202 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242452AbhDLOi6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:38:58 -0400
IronPort-SDR: qJcvdQYQTQs4aPhngq/8txC1OM8L7dGEBRzaPYAFRiV/19c4iwT9fxUkBUfGXfr1UolkdHBI1E
 UDZg/wyC1lEw==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194318016"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="194318016"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 07:38:33 -0700
IronPort-SDR: BrIc6Ev4g+VNpA7ZewBAKmQRTYlxw/j5GnBN8rtWQ+F7ylM8X4tTI67PhIAIMOz31zaxgZrpUj
 nmkZ8MLhrzow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="398392854"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2021 07:38:33 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, ricardo.neri-calderon@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 19/25] perf/x86: Support filter_match callback
Date:   Mon, 12 Apr 2021 07:30:59 -0700
Message-Id: <1618237865-33448-20-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618237865-33448-1-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-1-git-send-email-kan.liang@linux.intel.com>
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
index ba3736c..8fc45b8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2642,6 +2642,14 @@ static int x86_pmu_aux_output_match(struct perf_event *event)
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
@@ -2669,6 +2677,8 @@ static struct pmu pmu = {
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
+
+	.filter_match		= x86_pmu_filter_match,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4d94ec9..0051c87 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -880,6 +880,7 @@ struct x86_pmu {
 
 	int (*aux_output_match) (struct perf_event *event);
 
+	int (*filter_match)(struct perf_event *event);
 	/*
 	 * Hybrid support
 	 *
-- 
2.7.4

