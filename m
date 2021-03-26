Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71026349EAE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 02:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhCZB1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 21:27:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:51734 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230224AbhCZB1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 21:27:25 -0400
IronPort-SDR: +P1+iLNnAz4hBMypcv17adIROammYddGMBN40J8JSs3i7VS3MHsiMGMsQW/qEoir9oPc4iPq6u
 1sMZq4RTfM2A==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="170421831"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="170421831"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 18:27:25 -0700
IronPort-SDR: MDdF21SB/UFmDMutEAf7qoUFSHyfb/7nlIyD/R3NS4MK7PwUpxcmgaiy0QQ/0StIhbkWIKU/WJ
 xWabQdPydbJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="443089024"
Received: from clx-ap-likexu.sh.intel.com ([10.239.48.108])
  by fmsmga002.fm.intel.com with ESMTP; 25 Mar 2021 18:27:22 -0700
From:   Like Xu <like.xu@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     pbonzini@redhat.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>, wei.w.wang@intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu@linux.intel.com>
Subject: [PATCH v5 5/5] perf/x86: Move ARCH_LBR_CTL_MASK definition to include/asm/msr-index.h
Date:   Fri, 26 Mar 2021 09:19:18 +0800
Message-Id: <20210326011918.183685-6-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210326011918.183685-1-like.xu@linux.intel.com>
References: <20210326011918.183685-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARCH_LBR_CTL_MASK will be reused for LBR emulation in the KVM.

Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 arch/x86/events/intel/lbr.c      | 2 --
 arch/x86/include/asm/msr-index.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 6df9a802613f..70afda9d4878 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -168,8 +168,6 @@ enum {
 	 ARCH_LBR_RETURN		|\
 	 ARCH_LBR_OTHER_BRANCH)
 
-#define ARCH_LBR_CTL_MASK			0x7f000e
-
 static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
 
 static __always_inline bool is_lbr_call_stack_bit_set(u64 config)
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 546d6ecf0a35..8f3375961efc 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -169,6 +169,7 @@
 #define LBR_INFO_BR_TYPE		(0xfull << LBR_INFO_BR_TYPE_OFFSET)
 
 #define MSR_ARCH_LBR_CTL		0x000014ce
+#define ARCH_LBR_CTL_MASK		0x7f000e
 #define ARCH_LBR_CTL_LBREN		BIT(0)
 #define ARCH_LBR_CTL_CPL_OFFSET		1
 #define ARCH_LBR_CTL_CPL		(0x3ull << ARCH_LBR_CTL_CPL_OFFSET)
-- 
2.29.2

