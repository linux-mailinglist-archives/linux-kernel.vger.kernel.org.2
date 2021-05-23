Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C5E38DCBF
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 21:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232229AbhEWTlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 15:41:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:12053 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232008AbhEWTj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 15:39:58 -0400
IronPort-SDR: nkonRLIllWwntV5nkB6gZQuaQJPOncqD/ZGh+YD2jPugw1vDIdi9JyP2ojsu0aRanFxfiq7uuS
 pfqu1bQO9s8A==
X-IronPort-AV: E=McAfee;i="6200,9189,9993"; a="265703542"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="265703542"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2021 12:38:29 -0700
IronPort-SDR: tUM0pKVM27xRAXG8u26u4vbDMpLxX5nHr3zH2rBpsUUBTqZ1T1r9tSmXGdaWD+eHhprO4jumQM
 cs8FZV2+4b8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="407467126"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2021 12:38:29 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     bp@suse.de, luto@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH v5 21/28] x86/fpu/amx: Initialize child's AMX state
Date:   Sun, 23 May 2021 12:32:52 -0700
Message-Id: <20210523193259.26200-22-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210523193259.26200-1-chang.seok.bae@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assure that a forked child starts AMX registers in the INIT-state.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v4:
* Added as a new patch. This was missing on previous versions.
---
 arch/x86/kernel/fpu/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 016c3adebec3..cccfeafe81e5 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -285,6 +285,10 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
 
 	fpregs_unlock();
 
+	/* AMX state is volatile, children do not inherit it. */
+	if (xfeatures_mask_all & XFEATURE_MASK_XTILE)
+		dst_fpu->state->xsave.header.xfeatures &= ~(XFEATURE_MASK_XTILE);
+
 	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
 
 	trace_x86_fpu_copy_src(src_fpu);
-- 
2.17.1

