Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5983FD5BA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 10:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243272AbhIAIgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 04:36:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:18259 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243240AbhIAIgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 04:36:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="240951408"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="240951408"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 01:35:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="532010730"
Received: from chenyi-pc.sh.intel.com ([10.239.159.88])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 01:35:39 -0700
From:   Chenyi Qiang <chenyi.qiang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Chenyi Qiang <chenyi.qiang@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH] x86/bus_lock: Don't assume the init value of DEBUGCTLMSR.BUS_LOCK_DETECT to be zero
Date:   Wed,  1 Sep 2021 16:40:04 +0800
Message-Id: <20210901084004.5393-1-chenyi.qiang@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible that BIOS/firmware has set DEBUGCTLMSR_BUS_LOCK_DETECT, or
this kernel has been kexec'd from a kernel that enabled bus lock
detection.

Disable bus lock detection explicitly if not wanted.

Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8321c43554a1..38dda04d9342 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1152,22 +1152,23 @@ static void bus_lock_init(void)
 {
 	u64 val;
 
-	/*
-	 * Warn and fatal are handled by #AC for split lock if #AC for
-	 * split lock is supported.
-	 */
-	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) ||
-	    (boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
-	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
-	    sld_state == sld_off)
+	if (!boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
 		return;
 
-	/*
-	 * Enable #DB for bus lock. All bus locks are handled in #DB except
-	 * split locks are handled in #AC in the fatal case.
-	 */
 	rdmsrl(MSR_IA32_DEBUGCTLMSR, val);
-	val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+
+	if ((boot_cpu_has(X86_FEATURE_SPLIT_LOCK_DETECT) &&
+	    (sld_state == sld_warn || sld_state == sld_fatal)) ||
+	    sld_state == sld_off) {
+		/*
+		 * Warn and fatal are handled by #AC for split lock if #AC for
+		 * split lock is supported.
+		 */
+		val &= ~DEBUGCTLMSR_BUS_LOCK_DETECT;
+	} else {
+		val |= DEBUGCTLMSR_BUS_LOCK_DETECT;
+	}
+
 	wrmsrl(MSR_IA32_DEBUGCTLMSR, val);
 }
 
-- 
2.17.1

