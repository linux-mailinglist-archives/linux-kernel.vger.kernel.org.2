Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85D2334363
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbhCJQoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:44:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:37313 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232840AbhCJQoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:44:03 -0500
IronPort-SDR: efhtOBwD+znX1WfgiBWt7ihiZ1bZmBWyVqxUDHYsUtkgRQO3T6vt3sbZmqga+c/UkrR7Rd8BSP
 DW3d8p9TNw5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="188546482"
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="188546482"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 08:44:02 -0800
IronPort-SDR: fDw/ZBezD9DsVAWgiiiaeIZx0jQOvqerRhnf6uytPDfa6s5L7BqTSHpNVdz9rZgeXD4dycwvop
 u7C8yT9ovTkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,237,1610438400"; 
   d="scan'208";a="509729268"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2021 08:44:02 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 14/25] perf/x86: Remove temporary pmu assignment in event_init
Date:   Wed, 10 Mar 2021 08:37:50 -0800
Message-Id: <1615394281-68214-15-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
References: <1615394281-68214-1-git-send-email-kan.liang@linux.intel.com>
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
index 32e8fed..96b4a72 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2302,7 +2302,6 @@ static int validate_group(struct perf_event *event)
 
 static int x86_pmu_event_init(struct perf_event *event)
 {
-	struct pmu *tmp;
 	int err;
 
 	switch (event->attr.type) {
@@ -2317,20 +2316,10 @@ static int x86_pmu_event_init(struct perf_event *event)
 
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

