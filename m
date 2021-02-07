Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D41731210A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 04:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbhBGDLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 22:11:52 -0500
Received: from mga11.intel.com ([192.55.52.93]:57510 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhBGDLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 22:11:50 -0500
IronPort-SDR: p0rHIoPGNJjQVEgjRcNcIuhHlxLxWsExo1g+thgdUfNyFw7POpfRG/eVksY0NmY6TwcJSR4MjY
 ukaEpTUKgl7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9887"; a="178071324"
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="178071324"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 19:11:09 -0800
IronPort-SDR: rCLAidvoDS4hgN4lukNGzYPt9TsJTau9z1VYX4InUYebc+1mHvjJQkon7h261h2FhyTf7SLfy9
 kwMpkwbipUFA==
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="584618075"
Received: from shsi6026.sh.intel.com (HELO localhost) ([10.239.147.88])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 19:11:05 -0800
From:   shuo.a.liu@intel.com
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>, Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [PATCH v9 03/18] x86/acrn: Introduce acrn_cpuid_base() and hypervisor feature bits
Date:   Sun,  7 Feb 2021 11:10:25 +0800
Message-Id: <20210207031040.49576-4-shuo.a.liu@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210207031040.49576-1-shuo.a.liu@intel.com>
References: <20210207031040.49576-1-shuo.a.liu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yin Fengwei <fengwei.yin@intel.com>

ACRN Hypervisor reports hypervisor features via CPUID leaf 0x40000001
which is similar to KVM. A VM can check if it's the privileged VM using
the feature bits. The Service VM is the only privileged VM by design.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
Signed-off-by: Shuo Liu <shuo.a.liu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Borislav Petkov <bp@suse.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Fengwei Yin <fengwei.yin@intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Yu Wang <yu1.wang@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/include/asm/acrn.h | 16 ++++++++++++++++
 arch/x86/kernel/cpu/acrn.c  |  2 +-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/acrn.h b/arch/x86/include/asm/acrn.h
index ff259b69cde7..127f20672c5d 100644
--- a/arch/x86/include/asm/acrn.h
+++ b/arch/x86/include/asm/acrn.h
@@ -2,7 +2,23 @@
 #ifndef _ASM_X86_ACRN_H
 #define _ASM_X86_ACRN_H
 
+/*
+ * This CPUID returns feature bitmaps in EAX.
+ * Guest VM uses this to detect the appropriate feature bit.
+ */
+#define	ACRN_CPUID_FEATURES		0x40000001
+/* Bit 0 indicates whether guest VM is privileged */
+#define	ACRN_FEATURE_PRIVILEGED_VM	BIT(0)
+
 void acrn_setup_intr_handler(void (*handler)(void));
 void acrn_remove_intr_handler(void);
 
+static inline u32 acrn_cpuid_base(void)
+{
+	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))
+		return hypervisor_cpuid_base("ACRNACRNACRN", 0);
+
+	return 0;
+}
+
 #endif /* _ASM_X86_ACRN_H */
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index e0c181781905..23f5f27b5a02 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -21,7 +21,7 @@
 
 static u32 __init acrn_detect(void)
 {
-	return hypervisor_cpuid_base("ACRNACRNACRN", 0);
+	return acrn_cpuid_base();
 }
 
 static void __init acrn_init_platform(void)
-- 
2.28.0

