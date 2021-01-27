Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DF2306026
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 16:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236694AbhA0PsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 10:48:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:12371 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236467AbhA0Pq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 10:46:59 -0500
IronPort-SDR: Bw9iuddzLUCiYLMFNbf35I1q1PU+OikSgNxbWDeXL1K2Q5j9tHhaW0HsG6baXN+MQuJQwf4JUV
 Ii8cioHfL/QQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159861134"
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="159861134"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 07:42:18 -0800
IronPort-SDR: 4wICnYjyt04yG2PPy83l2PSy02O3y9CO4JIHjJqbI/Q9j89ioJdrIzltTXNGXkBPUIrGRup0Fu
 T8xGTgAAZqoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="369514636"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 27 Jan 2021 07:42:18 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com, mpe@ellerman.id.au,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V2 3/5] perf/x86/intel: Filter unsupported Topdown metrics event
Date:   Wed, 27 Jan 2021 07:38:43 -0800
Message-Id: <1611761925-159055-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611761925-159055-1-git-send-email-kan.liang@linux.intel.com>
References: <1611761925-159055-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Current perf doesn't check the index of a Topdown metrics event before
updating the event. A perf tool user may get a value from an unsupported
Topdown metrics event.

For example, the L2 topdown event, cpu/event=0x00,umask=0x84/, is not
supported on Ice Lake. A perf tool user may mistakenly use the
unsupported events via RAW format. In this case, the scheduler follows
the unknown event handling and assigns a GP counter to the event. The
icl_get_topdown_value() returns the value of the slots to the event.
The perf tool user will get the value for the unsupported
Topdown metrics event.

Add a check in the __icl_update_topdown_event() and avoid updating
unsupported events.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 8eba41b..b02d482 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2319,6 +2319,17 @@ static void __icl_update_topdown_event(struct perf_event *event,
 {
 	u64 delta, last = 0;
 
+	/*
+	 * Although the unsupported topdown events are not exposed to users,
+	 * users may mistakenly use the unsupported events via RAW format.
+	 * For example, using L2 topdown event, cpu/event=0x00,umask=0x84/,
+	 * on Ice Lake. In this case, the scheduler follows the unknown
+	 * event handling and assigns a GP counter to the event.
+	 * Check the case, and avoid updating unsupported events.
+	 */
+	if (event->hw.idx < INTEL_PMC_IDX_FIXED)
+		return;
+
 	delta = icl_get_topdown_value(event, slots, metrics);
 	if (last_slots)
 		last = icl_get_topdown_value(event, last_slots, last_metrics);
-- 
2.7.4

