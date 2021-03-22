Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A25345278
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCVWhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:37:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:18634 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhCVWhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:37:19 -0400
IronPort-SDR: T/9HIdfDrsVD+s4Jp9jAH5m0rq0KRIMpey52Focs4I33puibqvXSOZWg9F6oDuwMKQMZxC4R1T
 4id4q0RThJeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9931"; a="177931446"
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="177931446"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 15:37:18 -0700
IronPort-SDR: Si1cn9/mw61E5b43SV8P9iAVsPKB4uH1cGQHiNmmPVYZwUUrne71NvU0wRoob2GCsROWoFBwEz
 EL7caK5LYoiQ==
X-IronPort-AV: E=Sophos;i="5.81,269,1610438400"; 
   d="scan'208";a="414681347"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2021 15:37:17 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/mce: Add Skylake quirk for patrol scrub reported errors
Date:   Mon, 22 Mar 2021 15:37:10 -0700
Message-Id: <20210322223710.307123-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

Skylake has a mode where the system administrator can use a BIOS setup
option to request that the memory controller report uncorrected errors
found by the patrol scrubber as corrected.  This results in them being
signalled using CMCI, which is less disruptive than a machine check.

Add a quirk to detect that a "corrected" error is actually a downgraded
uncorrected error with model specific checks for the "MSCOD" signature in
MCi_STATUS and that the error was reported from a memory controller bank.

Adjust the severity to MCE_AO_SEVERITY so that Linux will try to take
the affected page offline.

[Tony: Wordsmith commit comment]

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>

---
Repost ... looks like this got lost somewhere.

V2:
Boris:	Don't optimize with pointer to quirk function. Just do
 	the vendor/family/model check in the adjust_mce_log()
	function
Tony:	Add check for stepping >= 4
---
 arch/x86/kernel/cpu/mce/core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index e9265e2f28c9..2d5fe23adf29 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -673,6 +673,35 @@ static void mce_read_aux(struct mce *m, int i)
 	}
 }
 
+/*
+ * Skylake family CPUs have a mode where the user can request that
+ * the memory controller report uncorrected errors found by the patrol
+ * scrubber as corrected (MCI_STATUS_UC == 0). This results in them being
+ * signalled using CMCI, which is less disruptive that a machine check.
+ * The following quirk detects such errors and adjusts the severity.
+ */
+
+#define MSCOD_UCE_SCRUB	(0x0010 << 16) /* UnCorrected Patrol Scrub Error */
+#define MSCOD_MASK	GENMASK_ULL(31, 16)
+
+static void adjust_mce_log(struct mce *m)
+{
+	struct cpuinfo_x86 *c = &boot_cpu_data;
+
+	if (c->x86_vendor == X86_VENDOR_INTEL && c->x86 == 6 &&
+	    c->x86_model == INTEL_FAM6_SKYLAKE_X && c->x86_stepping >= 4) {
+		/*
+		 * Check the error code to see if this is an uncorrected patrol
+		 * scrub error from one of the memory controller banks. If so,
+		 * then adjust the severity level to MCE_AO_SEVERITY
+		 */
+		if (((m->status & MCACOD_SCRUBMSK) == MCACOD_SCRUB) &&
+		    ((m->status & MSCOD_MASK) == MSCOD_UCE_SCRUB) &&
+		    m->bank >= 13 && m->bank <= 18)
+			m->severity = MCE_AO_SEVERITY;
+	}
+}
+
 DEFINE_PER_CPU(unsigned, mce_poll_count);
 
 /*
@@ -772,6 +801,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 		if (mca_cfg.dont_log_ce && !mce_usable_address(&m))
 			goto clear_it;
 
+		adjust_mce_log(&m);
 		mce_log(&m);
 
 clear_it:
-- 
2.21.1

