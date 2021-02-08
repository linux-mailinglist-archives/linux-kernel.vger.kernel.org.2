Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E2E313C91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhBHSIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:08:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:62838 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234111AbhBHPiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:38:25 -0500
IronPort-SDR: tDX+TUNIuKPbELxeQRIhr0Er3IdZZRomdHaToP9MzdRmdGQ2Y8Fx3iQttn5+/wGpnriv4rZ228
 r7JpoRdY90kQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="180951953"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="180951953"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:15 -0800
IronPort-SDR: 1ENtMY45kw+ATOjzeD/lbVbPHy+e56Jpnxufx9RpC4epiFQ5U0eM7v7aj04ELZWUvC9YFKSbOU
 RMiaHZN3V6IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820657"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:14 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 14/49] perf/x86: Remove temporary pmu assignment in event_init
Date:   Mon,  8 Feb 2021 07:25:11 -0800
Message-Id: <1612797946-18784-15-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
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
index 29dee3f..bdcd3ad 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2294,7 +2294,6 @@ static int validate_group(struct perf_event *event)
 
 static int x86_pmu_event_init(struct perf_event *event)
 {
-	struct pmu *tmp;
 	int err;
 
 	switch (event->attr.type) {
@@ -2309,20 +2308,10 @@ static int x86_pmu_event_init(struct perf_event *event)
 
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

