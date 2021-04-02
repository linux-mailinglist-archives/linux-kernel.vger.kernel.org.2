Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAAD35244D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 02:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbhDBARh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 20:17:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:22890 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236295AbhDBARg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 20:17:36 -0400
IronPort-SDR: RD6vvhWunAmwiiuUaLAaRHQfe7gYW88zgggtqnzfGS3ViALHDB6OCxr+0+jyht+hytnoqobEa/
 /6aLMTnTPokA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="191837663"
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="191837663"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 17:17:35 -0700
IronPort-SDR: IsuBQgkkfgaxwcb2BgysYd9iwZKHslUFtm9kU+exO/f+JkI98QOcgttKfgGvRKQMDa30ERojas
 mpUlfGPRZPMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,298,1610438400"; 
   d="scan'208";a="528399240"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga004.jf.intel.com with ESMTP; 01 Apr 2021 17:17:35 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH V4 01/25] x86/cpufeatures: Enumerate Intel Hybrid Technology feature bit
Date:   Thu,  1 Apr 2021 17:10:28 -0700
Message-Id: <1617322252-154215-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
References: <1617322252-154215-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

Add feature enumeration to identify a processor with Intel Hybrid
Technology: one in which CPUs of more than one type are the same package.
On a hybrid processor, all CPUs support the same homogeneous (i.e.,
symmetric) instruction set. All CPUs enumerate the same features in CPUID.
Thus, software (user space and kernel) can run and migrate to any CPU in
the system as well as utilize any of the enumerated features without any
change or special provisions. The main difference among CPUs in a hybrid
processor are power and performance properties.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Len Brown <len.brown@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3 (as part of patchset for perf change for Alderlake)
 * None

Changes since V2 (as part of patchset for perf change for Alderlake)
 * Don't show "hybrid_cpu" in /proc/cpuinfo (Boris)

Changes since v1 (as part of patchset for perf change for Alderlake)
 * None

Changes since v1 (in a separate posting):
 * Reworded commit message to clearly state what is Intel Hybrid
   Technology. Stress that all CPUs can run the same instruction
   set and support the same features.
---
 arch/x86/include/asm/cpufeatures.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26d69f7..1ba4a6e1690c 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -374,6 +374,7 @@
 #define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
 #define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
 #define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
+#define X86_FEATURE_HYBRID_CPU		(18*32+15) /* "" This part has CPUs of more than one type */
 #define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
 #define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
 #define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
-- 
2.17.1

