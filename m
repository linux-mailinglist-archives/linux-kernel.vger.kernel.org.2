Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC0441272C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 22:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbhITUHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 16:07:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:63446 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231501AbhITUFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 16:05:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="202723611"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="202723611"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 13:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="473779473"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2021 13:02:13 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 2/8] x86/process: Clear PASID state for a newly forked/cloned thread
Date:   Mon, 20 Sep 2021 19:23:43 +0000
Message-Id: <20210920192349.2602141-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210920192349.2602141-1-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PASID state has to be cleared on forks, since the child has a
different address space. The PASID is also cleared for thread clone. While
it would be correct to inherit the PASID in this case, it is unknown
whether the new task will use ENQCMD. Giving it the PASID "just in case"
would have the downside of increased context switch overhead to setting
the PASID MSR and losing init optimization.

Since #GP faults have to be handled on any threads that were created before
the PASID was assigned to the mm of the process, newly created threads
might as well be treated in a consistent way.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/process.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1d9463e3096b..c713986ef7d7 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -154,6 +154,14 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	frame->flags = X86_EFLAGS_FIXED;
 #endif
 
+	if (static_cpu_has(X86_FEATURE_ENQCMD)) {
+		/*
+		 * Clear the PASID bit in xfeatures so that the PASID MSR
+		 * will be initialized as init state (0).
+		 */
+		p->thread.fpu.state.xsave.header.xfeatures &= ~XFEATURE_MASK_PASID;
+	}
+
 	/* Kernel thread ? */
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		p->thread.pkru = pkru_get_init_value();
-- 
2.33.0

