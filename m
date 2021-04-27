Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB7036BF9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 09:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbhD0HD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 03:03:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:3176 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234670AbhD0HDx (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 03:03:53 -0400
IronPort-SDR: hJyF3x32jmwJwPQiYchND9BamY18z8V2qybAqJAiocKS8HwFYjsPoci13RDQ4P0/NegtLVDmEX
 m6xbdC9jutRQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175944145"
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="175944145"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 00:03:11 -0700
IronPort-SDR: D1vEvxpeXx/zGfbR+GTo9NW7Svb5MvS/C6EWzAoqwlju/D7WTnAnIna25ZwbUDVB2lqFLviV7A
 oP+JaN0HfAsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,254,1613462400"; 
   d="scan'208";a="447506580"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by fmsmga004.fm.intel.com with ESMTP; 27 Apr 2021 00:03:08 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v6 01/26] tools headers uapi: Update tools's copy of linux/perf_event.h
Date:   Tue, 27 Apr 2021 15:01:14 +0800
Message-Id: <20210427070139.25256-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427070139.25256-1-yao.jin@linux.intel.com>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
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
v6:
 - No update.

v5:
 - Update the commit message to mention that Kan's patch is
   upstreamed but not merged to perf/core branch.

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

