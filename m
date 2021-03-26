Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2368334AF01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbhCZTJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:09:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:27820 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhCZTJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:09:07 -0400
IronPort-SDR: ae3C3PyBepKbLklln2Jq+jXAr09k5cylv1MWXh/JcD+odDlThsZDUCavNTf1BAgK2K8walmTfW
 DJmLnDZw1Oyg==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="191234830"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="191234830"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 12:09:07 -0700
IronPort-SDR: Fh6iHgDoVal0QIyP5HW4xipkXL5AQQrOQaYHTvzZj4yQDvKPWCTNRW80fjqrxUMWtUYBxS9+fq
 YbkMVt2JVyGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="392321180"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2021 12:09:07 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 19/25] perf/x86: Support filter_match callback
Date:   Fri, 26 Mar 2021 12:02:06 -0700
Message-Id: <1616785332-165261-20-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616785332-165261-1-git-send-email-kan.liang@linux.intel.com>
References: <1616785332-165261-1-git-send-email-kan.liang@linux.intel.com>
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
index a5e4422..062a9d3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2645,6 +2645,14 @@ static int x86_pmu_aux_output_match(struct perf_event *event)
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
@@ -2672,6 +2680,8 @@ static struct pmu pmu = {
 	.check_period		= x86_pmu_check_period,
 
 	.aux_output_match	= x86_pmu_aux_output_match,
+
+	.filter_match		= x86_pmu_filter_match,
 };
 
 void arch_perf_update_userpage(struct perf_event *event,
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e1c10f5..3861b4a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -872,6 +872,7 @@ struct x86_pmu {
 
 	int (*aux_output_match) (struct perf_event *event);
 
+	int (*filter_match)(struct perf_event *event);
 	/*
 	 * Hybrid support
 	 *
-- 
2.7.4

