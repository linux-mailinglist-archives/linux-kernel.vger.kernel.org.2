Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503E531D14F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 20:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhBPT5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 14:57:55 -0500
Received: from mga14.intel.com ([192.55.52.115]:21236 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230194AbhBPT5k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 14:57:40 -0500
IronPort-SDR: TSPOaWnP0lL/r8oGlCl4CyeHvNJZMme1K32BEWarGkTXopsjHDhCTCogqwJID6LYWiLO0Ap6Ab
 eRgHecTo/HuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="182222446"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="182222446"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 11:56:59 -0800
IronPort-SDR: 7w1Xe08TozeRRlR2SYslWv0RZhPmpYWNakOvaZIi8JvJN5ePshHCBUyY/uOFpQokcoTzo/bPbo
 lR4UQurtlUTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="scan'208";a="439064751"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.53])
  by orsmga001.jf.intel.com with ESMTP; 16 Feb 2021 11:56:59 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     Alison Schofield <alison.schofield@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>, brice.goglin@gmail.com
Subject: [PATCH v2] x86,sched: Update the Intel SNC CPU list that allows shared LLCs
Date:   Tue, 16 Feb 2021 11:58:04 -0800
Message-Id: <20210216195804.24204-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1340ccfa9a9a ("x86,sched: Allow topologies where NUMA nodes
share an LLC") added a vendor and model specific check to never
call topology_sane() for systems where NUMA nodes share an LLC.

Intel's Ice Lake and Sapphire Rapids CPUs exhibit this same topology.
They enumerate an LLC that is shared by multiple NUMA nodes. The
LLC on these CPUs is shared for off-package data access but private
to the NUMA node for on-package access. Since its CPUID can only
enumerate the cache as shared or unshared, add these CPUs to the
list of allowable topologies (snc_cpu[]).

In SNC mode, Ice Lake and Sapphire Rapids servers will no longer emit
this warning:

sched: CPU #3's llc-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: brice.goglin@gmail.com

---
Changes v1->v2:

- Implemented the minimal required change of adding the new models to
  the existing vendor and model specific check.

- Side effect of going minimalist: no longer labelled an X86_BUG (TonyL)

- Considered PeterZ suggestion of checking for COD CPUs, rather than
  SNC CPUs. That meant this snc_cpu list would go away, and so it never
  needs updating. That ups the stakes for this patch wrt LOC changed
  and testing needed. It actually drove me back to this simplest soln.

- Considered DaveH suggestion to remove the check altogether and recognize
  these topologies as sane. Not running with that further here. This patch
  is what is needed now. The broader discussion of sane topologies can
  carry on independent of this update.

- Updated commit message and log.

 arch/x86/kernel/smpboot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 02813a7f3a7c..de8c598dc3b9 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -475,6 +475,8 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 
 static const struct x86_cpu_id snc_cpu[] = {
 	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_X, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X, NULL),
+	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X, NULL),
 	{}
 };
 
-- 
2.20.1

