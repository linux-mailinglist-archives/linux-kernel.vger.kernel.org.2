Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BC3412722
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 22:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbhITUFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 16:05:43 -0400
Received: from mga05.intel.com ([192.55.52.43]:60374 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230024AbhITUDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 16:03:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10113"; a="308775413"
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="308775413"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 13:02:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,309,1624345200"; 
   d="scan'208";a="473779479"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga007.fm.intel.com with ESMTP; 20 Sep 2021 13:02:14 -0700
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
Subject: [PATCH 3/8] sched: Define and initialize a flag to identify valid PASID in the task
Date:   Mon, 20 Sep 2021 19:23:44 +0000
Message-Id: <20210920192349.2602141-4-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210920192349.2602141-1-fenghua.yu@intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Add a new field to the task structure to track whether this task
has initialized the IA32_PASID MSR (and thus holds a reference
count on the PASID for this process).

Initialize the field to zero when creating a new task with fork/clone.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 include/linux/sched.h | 4 ++++
 kernel/fork.c         | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 39039ce8ac4c..21a8cff9155c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -936,6 +936,10 @@ struct task_struct {
 	unsigned			in_eventfd_signal:1;
 #endif
 
+#ifdef CONFIG_IOMMU_SUPPORT
+	unsigned			has_valid_pasid:1;
+#endif
+
 	unsigned long			atomic_flags; /* Flags requiring atomic access. */
 
 	struct restart_block		restart_block;
diff --git a/kernel/fork.c b/kernel/fork.c
index 38681ad44c76..e379f88260eb 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -967,6 +967,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->use_memdelay = 0;
 #endif
 
+#ifdef CONFIG_IOMMU_SUPPORT
+	tsk->has_valid_pasid = 0;
+#endif
+
 #ifdef CONFIG_MEMCG
 	tsk->active_memcg = NULL;
 #endif
-- 
2.33.0

