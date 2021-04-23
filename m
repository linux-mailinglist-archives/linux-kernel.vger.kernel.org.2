Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3021F368CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 07:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbhDWFhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 01:37:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:9279 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhDWFhT (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 01:37:19 -0400
IronPort-SDR: w/RNXvokZpy6CaEJri7MTHzfpqJqdAYvzfQn+nK2FA6q9OJlBi3lzIwXGdhEpVT85yR/dIqNHt
 23nwqH08T+4w==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183501770"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183501770"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 22:36:39 -0700
IronPort-SDR: l1Kea8KK0GFpZDISDm4rIAUZIuFOKC4mxV7EvMZcFtMgbObtNcCg2EUL5LELQRqF9uo5II17Z6
 o1kkrbNi+Ygw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="386293509"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2021 22:36:37 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 01/26] tools headers uapi: Update tools's copy of linux/perf_event.h
Date:   Fri, 23 Apr 2021 13:35:16 +0800
Message-Id: <20210423053541.12521-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210423053541.12521-1-yao.jin@linux.intel.com>
References: <20210423053541.12521-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get the changes in:

Liang Kan's patch
[PATCH V6 21/25] perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE

Kan's patch is upstreamed yet but perf/core branch doesn't have it
at this moment. But next perf tool patches need this interface for
hybrid support.

This patch can be removed after Kan's patch is merged in perf/core
branch.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v5:
 - Update the commit message to mention that Kan's patch is
   upstreamed but not merged in perf/core branch.

v4:
 - Updated by Kan's latest patch,
   '[PATCH V6 21/25] perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE'

 include/uapi/linux/perf_event.h       | 15 +++++++++++++++
 tools/include/uapi/linux/perf_event.h | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index ad15e40d7f5d..14332f4cf816 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -37,6 +37,21 @@ enum perf_type_id {
 	PERF_TYPE_MAX,				/* non-ABI */
 };
 
+/*
+ * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
+ * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
+ *					AA: hardware event ID
+ *					EEEEEEEE: PMU type ID
+ * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
+ *					BB: hardware cache ID
+ *					CC: hardware cache op ID
+ *					DD: hardware cache op result ID
+ *					EEEEEEEE: PMU type ID
+ * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
+ */
+#define PERF_PMU_TYPE_SHIFT		32
+#define PERF_HW_EVENT_MASK		0xffffffff
+
 /*
  * Generalized performance event event_id types, used by the
  * attr.event_id parameter of the sys_perf_event_open()
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ad15e40d7f5d..14332f4cf816 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -37,6 +37,21 @@ enum perf_type_id {
 	PERF_TYPE_MAX,				/* non-ABI */
 };
 
+/*
+ * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
+ * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
+ *					AA: hardware event ID
+ *					EEEEEEEE: PMU type ID
+ * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
+ *					BB: hardware cache ID
+ *					CC: hardware cache op ID
+ *					DD: hardware cache op result ID
+ *					EEEEEEEE: PMU type ID
+ * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
+ */
+#define PERF_PMU_TYPE_SHIFT		32
+#define PERF_HW_EVENT_MASK		0xffffffff
+
 /*
  * Generalized performance event event_id types, used by the
  * attr.event_id parameter of the sys_perf_event_open()
-- 
2.17.1

