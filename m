Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7654F35C8F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242581AbhDLOjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 10:39:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:29206 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242417AbhDLOit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:38:49 -0400
IronPort-SDR: 9sf1EXY70UTElSPmFP2TssdLWIwPMpjPXAOdtk2mcQBOTbFQLOaSbgw7dUoeBlJxumfdf96ks2
 8TubhJFdR5qA==
X-IronPort-AV: E=McAfee;i="6200,9189,9952"; a="194317987"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="194317987"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 07:38:28 -0700
IronPort-SDR: CbzdFkkpCMyy0OoExJsliwJ5hiA3ORQdpKtCKTJTc+w1HFq6sPeANUal5weky6HVEL/oc+X9sf
 JxZj4SX0hUTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="scan'208";a="398392819"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 12 Apr 2021 07:38:28 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, ricardo.neri-calderon@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 14/25] perf/x86: Remove temporary pmu assignment in event_init
Date:   Mon, 12 Apr 2021 07:30:54 -0700
Message-Id: <1618237865-33448-15-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618237865-33448-1-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The temporary pmu assignment in event_init is unnecessary.

The assignment was introduced by commit 8113070d6639 ("perf_events:
Add fast-path to the rescheduling code"). At that time, event->pmu is
not assigned yet when initializing an event. The assignment is required.
However, from commit 7e5b2a01d2ca ("perf: provide PMU when initing
events"), the event->pmu is provided before event_init is invoked.
The temporary pmu assignment in event_init should be removed.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/core.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 4dcf0de..fe811b5 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2292,7 +2292,6 @@ static int validate_group(struct perf_event *event)
 
 static int x86_pmu_event_init(struct perf_event *event)
 {
-	struct pmu *tmp;
 	int err;
 
 	switch (event->attr.type) {
@@ -2307,20 +2306,10 @@ static int x86_pmu_event_init(struct perf_event *event)
 
 	err = __x86_pmu_event_init(event);
 	if (!err) {
-		/*
-		 * we temporarily connect event to its pmu
-		 * such that validate_group() can classify
-		 * it as an x86 event using is_x86_event()
-		 */
-		tmp = event->pmu;
-		event->pmu = &pmu;
-
 		if (event->group_leader != event)
 			err = validate_group(event);
 		else
 			err = validate_event(event);
-
-		event->pmu = tmp;
 	}
 	if (err) {
 		if (event->destroy)
-- 
2.7.4

