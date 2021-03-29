Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6E434C46B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 09:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhC2HCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 03:02:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:51195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229630AbhC2HBo (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 03:01:44 -0400
IronPort-SDR: a9d+qhN0ZWNn7gJWiynHSfIhdczxNVX7oagYjInWonv1aLsU60DCAXDbe4n0hkhFGe3PpTlwLu
 F637n5sUKGPQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="191590333"
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="191590333"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 00:01:44 -0700
IronPort-SDR: trnExEHVfdyPYw6FV3nlZPWmLJmvc1QPBViQbW4setTucV87ZoODFwW2mNbUX2owW+s5HZOxkU
 nW6QQjCB8EHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,287,1610438400"; 
   d="scan'208";a="444677242"
Received: from kbl-ppc.sh.intel.com ([10.239.159.163])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Mar 2021 00:01:42 -0700
From:   Jin Yao <yao.jin@linux.intel.com>
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com,
        Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v3 01/27] tools headers uapi: Update tools's copy of linux/perf_event.h
Date:   Mon, 29 Mar 2021 15:00:20 +0800
Message-Id: <20210329070046.8815-2-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210329070046.8815-1-yao.jin@linux.intel.com>
References: <20210329070046.8815-1-yao.jin@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To get the changes in:

Liang Kan's patch
("perf: Introduce PERF_TYPE_HARDWARE_PMU and PERF_TYPE_HW_CACHE_PMU")

Kan's patch is in review at the moment, but the following perf tool
patches need this interface for hybrid support.

This patch can be removed after Kan's patch is upstreamed.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
v3:
 - No change.

 tools/include/uapi/linux/perf_event.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index ad15e40d7f5d..c0a511eea498 100644
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
@@ -94,6 +96,30 @@ enum perf_hw_cache_op_result_id {
 	PERF_COUNT_HW_CACHE_RESULT_MAX,		/* non-ABI */
 };
 
+/*
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
 /*
  * Special "software" events provided by the kernel, even if the hardware
  * does not support performance events. These events measure various
-- 
2.17.1

