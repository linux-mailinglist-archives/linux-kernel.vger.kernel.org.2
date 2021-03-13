Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250AD339C47
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 06:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbhCMFtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 00:49:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:62600 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233233AbhCMFt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 00:49:26 -0500
IronPort-SDR: efA8ceWZCaX80KsC1W/6SFNtp1aHvS4UYjCA/M4/uXX6lMcG5nX/O80wTOfz9oOLJDNRUGCHxE
 QE41I646dbtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="176050567"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="176050567"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 21:49:25 -0800
IronPort-SDR: OAeM29iTNOWl4jSI1OM4x/psHWWvu8CtnXoECovsZUpPll4F8dISoF2BPswms9eNrzKBFbahYE
 nEvgIOEH3PhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="372880400"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga006.jf.intel.com with ESMTP; 12 Mar 2021 21:49:25 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Xiaoyao Li " <xiaoyao.li@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 1/3] x86/cpufeatures: Enumerate #DB for bus lock detection
Date:   Sat, 13 Mar 2021 05:49:08 +0000
Message-Id: <20210313054910.2503968-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210313054910.2503968-1-fenghua.yu@intel.com>
References: <20210313054910.2503968-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A bus lock is acquired though either split locked access to
writeback (WB) memory or any locked access to non-WB memory. This is
typically >1000 cycles slower than an atomic operation within a cache
line. It also disrupts performance on other cores.

Some CPUs have ability to notify the kernel by an #DB trap after a user
instruction acquires a bus lock and is executed. This allows the kernel
to enforce user application throttling or mitigations. Both breakpoint
and bus lock can trigger the #DB trap in the same instruction and the
ordering of handling them is the kernel #DB handler's choice.

The CPU feature flag to be shown in /proc/cpuinfo will be "bus_lock_detect".

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
Change Log:
v5:
- Add "Both breakpoint and bus lock can trigger an #DB trap..." in the
  commit message (Thomas).

 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26d69f7..faec3d92d09b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -354,6 +354,7 @@
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
+#define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* Bus Lock detect */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
-- 
2.30.2

