Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD6335435F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241655AbhDEPTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 11:19:06 -0400
Received: from mga18.intel.com ([134.134.136.126]:43445 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238675AbhDEPSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 11:18:36 -0400
IronPort-SDR: rCvr4q01P50pjJkd3Os2qPr2R8Stz8CB9ZzYpY7YsTdf/bzLp4jV7IvvKqvdCdlEL+z0Y3Ldxv
 S+5M17mhEHDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="180402991"
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="180402991"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 08:18:29 -0700
IronPort-SDR: I5yHuDb6D4vM4YqJK/5ixJuVVw56aq6CsLxZTHUT6c4YJ6I572gHEEWjlfqKp9yT9wybrR6tkp
 nPI8EhRkwibw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,306,1610438400"; 
   d="scan'208";a="379006407"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga003.jf.intel.com with ESMTP; 05 Apr 2021 08:18:29 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, tglx@linutronix.de, bp@alien8.de,
        namhyung@kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        yao.jin@linux.intel.com, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, ricardo.neri-calderon@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 24/25] perf/x86/cstate: Add Alder Lake CPU support
Date:   Mon,  5 Apr 2021 08:11:06 -0700
Message-Id: <1617635467-181510-25-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
References: <1617635467-181510-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Compared with the Rocket Lake, the CORE C1 Residency Counter is added
for Alder Lake, but the CORE C3 Residency Counter is removed. Other
counters are the same.

Create a new adl_cstates for Alder Lake. Update the comments
accordingly.

The External Design Specification (EDS) is not published yet. It comes
from an authoritative internal source.

The patch has been tested on real hardware.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/cstate.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 407eee5..4333990 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -40,7 +40,7 @@
  * Model specific counters:
  *	MSR_CORE_C1_RES: CORE C1 Residency Counter
  *			 perf code: 0x00
- *			 Available model: SLM,AMT,GLM,CNL,TNT
+ *			 Available model: SLM,AMT,GLM,CNL,TNT,ADL
  *			 Scope: Core (each processor core has a MSR)
  *	MSR_CORE_C3_RESIDENCY: CORE C3 Residency Counter
  *			       perf code: 0x01
@@ -51,46 +51,49 @@
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
- *						TNT,RKL
+ *						TNT,RKL,ADL
  *			       Scope: Core
  *	MSR_CORE_C7_RESIDENCY: CORE C7 Residency Counter
  *			       perf code: 0x03
  *			       Available model: SNB,IVB,HSW,BDW,SKL,CNL,KBL,CML,
- *						ICL,TGL,RKL
+ *						ICL,TGL,RKL,ADL
  *			       Scope: Core
  *	MSR_PKG_C2_RESIDENCY:  Package C2 Residency Counter.
  *			       perf code: 0x00
  *			       Available model: SNB,IVB,HSW,BDW,SKL,KNL,GLM,CNL,
- *						KBL,CML,ICL,TGL,TNT,RKL
+ *						KBL,CML,ICL,TGL,TNT,RKL,ADL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C3_RESIDENCY:  Package C3 Residency Counter.
  *			       perf code: 0x01
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,KNL,
- *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL
+ *						GLM,CNL,KBL,CML,ICL,TGL,TNT,RKL,
+ *						ADL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C6_RESIDENCY:  Package C6 Residency Counter.
  *			       perf code: 0x02
  *			       Available model: SLM,AMT,NHM,WSM,SNB,IVB,HSW,BDW,
  *						SKL,KNL,GLM,CNL,KBL,CML,ICL,TGL,
- *						TNT,RKL
+ *						TNT,RKL,ADL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C7_RESIDENCY:  Package C7 Residency Counter.
  *			       perf code: 0x03
  *			       Available model: NHM,WSM,SNB,IVB,HSW,BDW,SKL,CNL,
- *						KBL,CML,ICL,TGL,RKL
+ *						KBL,CML,ICL,TGL,RKL,ADL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C8_RESIDENCY:  Package C8 Residency Counter.
  *			       perf code: 0x04
- *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
+ *						ADL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C9_RESIDENCY:  Package C9 Residency Counter.
  *			       perf code: 0x05
- *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL
+ *			       Available model: HSW ULT,KBL,CNL,CML,ICL,TGL,RKL,
+ *						ADL
  *			       Scope: Package (physical package)
  *	MSR_PKG_C10_RESIDENCY: Package C10 Residency Counter.
  *			       perf code: 0x06
  *			       Available model: HSW ULT,KBL,GLM,CNL,CML,ICL,TGL,
- *						TNT,RKL
+ *						TNT,RKL,ADL
  *			       Scope: Package (physical package)
  *
  */
@@ -563,6 +566,20 @@ static const struct cstate_model icl_cstates __initconst = {
 				  BIT(PERF_CSTATE_PKG_C10_RES),
 };
 
+static const struct cstate_model adl_cstates __initconst = {
+	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
+				  BIT(PERF_CSTATE_CORE_C6_RES) |
+				  BIT(PERF_CSTATE_CORE_C7_RES),
+
+	.pkg_events		= BIT(PERF_CSTATE_PKG_C2_RES) |
+				  BIT(PERF_CSTATE_PKG_C3_RES) |
+				  BIT(PERF_CSTATE_PKG_C6_RES) |
+				  BIT(PERF_CSTATE_PKG_C7_RES) |
+				  BIT(PERF_CSTATE_PKG_C8_RES) |
+				  BIT(PERF_CSTATE_PKG_C9_RES) |
+				  BIT(PERF_CSTATE_PKG_C10_RES),
+};
+
 static const struct cstate_model slm_cstates __initconst = {
 	.core_events		= BIT(PERF_CSTATE_CORE_C1_RES) |
 				  BIT(PERF_CSTATE_CORE_C6_RES),
@@ -650,6 +667,8 @@ static const struct x86_cpu_id intel_cstates_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE_L,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(TIGERLAKE,		&icl_cstates),
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&icl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_cstates),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_cstates),
 	{ },
 };
 MODULE_DEVICE_TABLE(x86cpu, intel_cstates_match);
-- 
2.7.4

