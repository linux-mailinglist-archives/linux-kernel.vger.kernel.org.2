Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB2FE334368
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233159AbhCJQoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:44:44 -0500
Received: from mga03.intel.com ([134.134.136.65]:37313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhCJQoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:44:09 -0500
IronPort-SDR: QLwFRGlHVH5x93AMSI3YKPGxlxPxDeW2lzjbRgBfNZJTGdNvDpN22GvpcEtN7Et73IlyR1CsfT
 UX7k70oDjkSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188546515"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188546515"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:44:09 -0800
IronPort-SDR: kjwo9VgSkmYgDMCRCcJeDLqIcNJCNcnkBLZbNl2PgfAkuT4JhL2XVaCwY4Hqx1mmDXPMBQ2x2F
 kfoR4WOoWj0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="509729323"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 08:44:08 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 19/25] perf/x86: Support filter_match callback
Date:   Wed, 10 Mar 2021 08:37:55 -0800
Message-Id: <1615394281-68214-20-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
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
index 43f5529..b675283 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2625,6 +2625,14 @@ static int x86_pmu_aux_output_match(struct perf_event *event)
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
@@ -2652,6 +2660,8 @@ static struct pmu pmu = {
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
+
+	.filter_match		= x86_pmu_filter_match,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 36a08709..74bdcfe 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -865,6 +865,7 @@ struct x86_pmu {
 
 	int (*aux_output_match) (struct perf_event *event);
 
+	int (*filter_match)(struct perf_event *event);
 	/*
 	 * Hybrid support
 	 *
-- 
2.7.4

