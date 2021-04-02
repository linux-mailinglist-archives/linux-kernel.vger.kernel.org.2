Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B7E352458
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhDBASF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:18:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:48430 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236535AbhDBARt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:49 -0400
IronPort-SDR: SAd0OFzU37guvETLAX1KpCObXa5TvH8qnTQhAy07Os6b+Ogzx/pj3wBIQVDchUX1SFmxgPdeJ/
 VT6VzFmy3C9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="171775044"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="171775044"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:48 -0700
IronPort-SDR: YXjXjC6eZdbnEdGlzHfmw07/buxJb2f1ZEK+UbiG4hFy9+sZJ44gL6eLbaaAGEtOt7RsN6hQQx
 PPmz0JdQAqgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399358"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:48 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 14/25] perf/x86: Remove temporary pmu assignment in event_init
Date:   Thu,  1 Apr 2021 17:10:41 -0700
Message-Id: <1617322252-154215-15-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
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
index b79a506..9c931ec 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2299,7 +2299,6 @@ static int validate_group(struct perf_event *event)
 
 static int x86_pmu_event_init(struct perf_event *event)
 {
-	struct pmu *tmp;
 	int err;
 
 	switch (event->attr.type) {
@@ -2314,20 +2313,10 @@ static int x86_pmu_event_init(struct perf_event *event)
 
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

