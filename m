Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED0C34E31A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhC3IZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:25:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:18303 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231246AbhC3IZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:25:51 -0400
IronPort-SDR: f03DE3eOKYISpt5y6cDFwru+B9Dm6wlhmFprRRVKfhJeaZ9tJgIxVuM+Y+5bnTpIWxkPSauT6R
 vZtxLKy+mgOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="171123203"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="171123203"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 01:25:51 -0700
IronPort-SDR: QhYJxEJnKLngIZE1S5WYB+swi4cC776gFmD6EAo9vxh9sox71FuLyLwJdvrGM3+YrZj9kBOiE1
 DcVpv9WnaSYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="411500971"
Received: from shbuild999.sh.intel.com ([10.239.147.94])
  by fmsmga008.fm.intel.com with ESMTP; 30 Mar 2021 01:25:48 -0700
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rui.zhang@intel.com, andi.kleen@intel.com, dave.hansen@intel.com,
        len.brown@intel.com, Feng Tang <feng.tang@intel.com>
Subject: [RFC 1/2] x86/tsc: add a timer to make sure tsc_adjust is always checked
Date:   Tue, 30 Mar 2021 16:25:46 +0800
Message-Id: <1617092747-15769-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally the tsc_sync will be checked every time system enters idle state,
but there is still caveat that a system won't enter idle, either because
it's too busy or configured purposely to not enter idle. Setup a periodic
timer to make sure the check is always on.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 arch/x86/kernel/tsc_sync.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/x86/kernel/tsc_sync.c b/arch/x86/kernel/tsc_sync.c
index 3d3c761..1ba3941 100644
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -30,6 +30,7 @@ struct tsc_adjust {
 };
 
 static DEFINE_PER_CPU(struct tsc_adjust, tsc_adjust);
+static struct timer_list tsc_sync_check_timer;
 
 /*
  * TSC's on different sockets may be reset asynchronously.
@@ -77,6 +78,43 @@ void tsc_verify_tsc_adjust(bool resume)
 	}
 }
 
+/*
+ * Normally the tsc_sync will be checked every time system enters idle state,
+ * but there is still caveat that a system won't enter idle, either because
+ * it's too busy or configured purposely to not enter idle.
+ *
+ * So setup a periodic timer to make sure the check is always on.
+ */
+
+#define SYNC_CHECK_INTERVAL		(HZ * 600)
+static void tsc_sync_check_timer_fn(struct timer_list *unused)
+{
+	int next_cpu;
+
+	tsc_verify_tsc_adjust(false);
+
+	/* Loop to do the check for all onlined CPUs */
+	next_cpu = cpumask_next(raw_smp_processor_id(), cpu_online_mask);
+	if (next_cpu >= nr_cpu_ids)
+		next_cpu = cpumask_first(cpu_online_mask);
+
+	tsc_sync_check_timer.expires += SYNC_CHECK_INTERVAL;
+	add_timer_on(&tsc_sync_check_timer, next_cpu);
+}
+
+static int __init start_sync_check_timer(void)
+{
+	if (!boot_cpu_has(X86_FEATURE_TSC_ADJUST))
+		return 0;
+
+	timer_setup(&tsc_sync_check_timer, tsc_sync_check_timer_fn, 0);
+	tsc_sync_check_timer.expires = jiffies + SYNC_CHECK_INTERVAL;
+	add_timer(&tsc_sync_check_timer);
+
+	return 0;
+}
+late_initcall(start_sync_check_timer);
+
 static void tsc_sanitize_first_cpu(struct tsc_adjust *cur, s64 bootval,
 				   unsigned int cpu, bool bootcpu)
 {
-- 
2.7.4

