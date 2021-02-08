Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98D90313C17
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbhBHSBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:01:41 -0500
Received: from mga09.intel.com ([134.134.136.24]:27508 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233205AbhBHPgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 10:36:02 -0500
IronPort-SDR: vFCgPghKPZh9PHOc/Jrxd0VighX6aDYHJfrQ5DBj+Sy3QzeZ8c7u+YLDd1rvBivpYFrcBlwUae
 c0UTHu+nm6oA==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="181874620"
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="181874620"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2021 07:30:37 -0800
IronPort-SDR: Q86FS+Ahj2ce3kmw02ZEu58KrgGJ8tJEkm0MLjlskEfWtbJgOEUH4QCoWfZtuiQSJu/HxjYVkA
 V+Nh4E5a0SNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,162,1610438400"; 
   d="scan'208";a="358820891"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 08 Feb 2021 07:30:36 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, bp@alien8.de, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com
Subject: [PATCH 34/49] tools headers uapi: Update tools's copy of linux/perf_event.h
Date:   Mon,  8 Feb 2021 07:25:31 -0800
Message-Id: <1612797946-18784-35-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
References: <1612797946-18784-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

To get the changes in:

("perf: Introduce PERF_TYPE_HARDWARE_PMU and PERF_TYPE_HW_CACHE_PMU")

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 7d292de5..83ab6a6 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -33,6 +33,8 @@ enum perf_type_id {
 	PERF_TYPE_HW_CACHE			= 3,
 	PERF_TYPE_RAW				= 4,
 	PERF_TYPE_BREAKPOINT			= 5,
+	PERF_TYPE_HARDWARE_PMU			= 6,
+	PERF_TYPE_HW_CACHE_PMU			= 7,
 
 	PERF_TYPE_MAX,				/* non-ABI */
 };
@@ -95,6 +97,30 @@ enum perf_hw_cache_op_result_id {
 };
 
 /*
+ * attr.config layout for type PERF_TYPE_HARDWARE* and PERF_TYPE_HW_CACHE*
+ * PERF_TYPE_HARDWARE:		0xAA
+ *				AA: hardware event ID
+ * PERF_TYPE_HW_CACHE:		0xCCBBAA
+ *				AA: hardware cache ID
+ *				BB: hardware cache op ID
+ *				CC: hardware cache op result ID
+ * PERF_TYPE_HARDWARE_PMU:	0xDD000000AA
+ *				AA: hardware event ID
+ *				DD: PMU type ID
+ * PERF_TYPE_HW_CACHE_PMU:	0xDD00CCBBAA
+ *				AA: hardware cache ID
+ *				BB: hardware cache op ID
+ *				CC: hardware cache op result ID
+ *				DD: PMU type ID
+ */
+#define PERF_HW_CACHE_ID_SHIFT			0
+#define PERF_HW_CACHE_OP_ID_SHIFT		8
+#define PERF_HW_CACHE_OP_RESULT_ID_SHIFT	16
+#define PERF_HW_CACHE_EVENT_MASK		0xffffff
+
+#define PERF_PMU_TYPE_SHIFT			32
+
+/*
  * Special "software" events provided by the kernel, even if the hardware
  * does not support performance events. These events measure various
  * physical and sw events of the kernel (and allow the profiling of them as
-- 
2.7.4

