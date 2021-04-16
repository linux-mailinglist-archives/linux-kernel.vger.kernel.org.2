Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00113621AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 16:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236049AbhDPOGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 10:06:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:11215 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235875AbhDPOGk (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 10:06:40 -0400
IronPort-SDR: Jxx7ob2x+2gzz/x/aZLnQvJk6El/F9m3eNrs910qII7VuaoOt4wWOaDfHJDnz1IZ1MRaGvbH76
 d0+wgu30JmSg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="256358325"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="256358325"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 07:06:15 -0700
IronPort-SDR: Sl7txlN0lipf3dh9z80PGeNqyKPSWV5kUQM8ByqLUhdwxuQU6jOOM9svd8IK8JPxSWr+j4trEU
 KKOnkEA+6v5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="612766606"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2021 07:06:13 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v4 01/25] tools headers uapi: Update tools's copy of linux/perf_event.h
Date:   Fri, 16 Apr 2021 22:04:53 +0800
Message-Id: <20210416140517.18206-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210416140517.18206-1-yao.jin@linux.intel.com>
References: <20210416140517.18206-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get the changes in:

Liang Kan's patch
[PATCH V6 21/25] perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE

Kan's patch is in review at the moment. The following perf tool
patches need this interface for hybrid support.

This patch can be removed after Kan's patch is upstreamed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
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

