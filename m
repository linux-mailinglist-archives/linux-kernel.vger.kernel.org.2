Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96A530CCE4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 21:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhBBUQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 15:16:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:59909 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232562AbhBBUPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 15:15:53 -0500
IronPort-SDR: D6xxFAZRUayMQG6L4bAvriq0/5XqSRwxuZAWxV/mi1PALiSFI1uAeytrmptlFt/g23CAqfxHnJ
 bbr3J0KADTtA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="180148770"
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="180148770"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 12:14:07 -0800
IronPort-SDR: 5e0ExBLLVCbNtAG96bNLnrCnaUyattxtnQZjY6Xc/osLpMLGPi9BxSagqa7V4fdtahjyt+GRp5
 b4Y/Z3Go2LdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,396,1602572400"; 
   d="scan'208";a="356442498"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2021 12:14:06 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, eranian@google.com, namhyung@kernel.org,
        jolsa@redhat.com, ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 1/9] tools headers uapi: Update tools's copy of linux/perf_event.h
Date:   Tue,  2 Feb 2021 12:09:05 -0800
Message-Id: <1612296553-21962-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
References: <1612296553-21962-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To get the changes in:

    commit 2a6c6b7d7ad3 ("perf/core: Add PERF_SAMPLE_WEIGHT_STRUCT")

This cures the following warning during perf's build:

        Warning: Kernel ABI header at
'tools/include/uapi/linux/perf_event.h' differs from latest version at
'include/uapi/linux/perf_event.h'
        diff -u tools/include/uapi/linux/perf_event.h
include/uapi/linux/perf_event.h

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/include/uapi/linux/perf_event.h | 54 ++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 4 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index b15e344..7d292de5 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -145,12 +145,14 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_CGROUP			= 1U << 21,
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
+	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
 
-	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
 
+#define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
 /*
  * values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set
  *
@@ -890,7 +892,24 @@ enum perf_event_type {
 	 * 	  char			data[size];
 	 * 	  u64			dyn_size; } && PERF_SAMPLE_STACK_USER
 	 *
-	 *	{ u64			weight;   } && PERF_SAMPLE_WEIGHT
+	 *	{ union perf_sample_weight
+	 *	 {
+	 *		u64		full; && PERF_SAMPLE_WEIGHT
+	 *	#if defined(__LITTLE_ENDIAN_BITFIELD)
+	 *		struct {
+	 *			u32	var1_dw;
+	 *			u16	var2_w;
+	 *			u16	var3_w;
+	 *		} && PERF_SAMPLE_WEIGHT_STRUCT
+	 *	#elif defined(__BIG_ENDIAN_BITFIELD)
+	 *		struct {
+	 *			u16	var3_w;
+	 *			u16	var2_w;
+	 *			u32	var1_dw;
+	 *		} && PERF_SAMPLE_WEIGHT_STRUCT
+	 *	#endif
+	 *	 }
+	 *	}
 	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
 	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
 	 *	{ u64			abi; # enum perf_sample_regs_abi
@@ -1127,14 +1146,16 @@ union perf_mem_data_src {
 			mem_lvl_num:4,	/* memory hierarchy level number */
 			mem_remote:1,   /* remote */
 			mem_snoopx:2,	/* snoop mode, ext */
-			mem_rsvd:24;
+			mem_blk:3,	/* access blocked */
+			mem_rsvd:21;
 	};
 };
 #elif defined(__BIG_ENDIAN_BITFIELD)
 union perf_mem_data_src {
 	__u64 val;
 	struct {
-		__u64	mem_rsvd:24,
+		__u64	mem_rsvd:21,
+			mem_blk:3,	/* access blocked */
 			mem_snoopx:2,	/* snoop mode, ext */
 			mem_remote:1,   /* remote */
 			mem_lvl_num:4,	/* memory hierarchy level number */
@@ -1217,6 +1238,12 @@ union perf_mem_data_src {
 #define PERF_MEM_TLB_OS		0x40 /* OS fault handler */
 #define PERF_MEM_TLB_SHIFT	26
 
+/* Access blocked */
+#define PERF_MEM_BLK_NA		0x01 /* not available */
+#define PERF_MEM_BLK_DATA	0x02 /* data could not be forwarded */
+#define PERF_MEM_BLK_ADDR	0x04 /* address conflict */
+#define PERF_MEM_BLK_SHIFT	40
+
 #define PERF_MEM_S(a, s) \
 	(((__u64)PERF_MEM_##a##_##s) << PERF_MEM_##a##_SHIFT)
 
@@ -1248,4 +1275,23 @@ struct perf_branch_entry {
 		reserved:40;
 };
 
+union perf_sample_weight {
+	__u64		full;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	struct {
+		__u32	var1_dw;
+		__u16	var2_w;
+		__u16	var3_w;
+	};
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	struct {
+		__u16	var3_w;
+		__u16	var2_w;
+		__u32	var1_dw;
+	};
+#else
+#error "Unknown endianness"
+#endif
+};
+
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
-- 
2.7.4

