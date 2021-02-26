Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7F3261FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhBZL0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:26:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:60100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230223AbhBZL0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:26:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1614338729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9Aoj+mD0sR1IiIwitK9WRvyR8NQutn4XWYPCWVLCqsI=;
        b=se13TZjCsJkvolVSSUHJ1dT0RmMc6nn/5/qGqYPLloh7TX8Wsyv8zRL72Q61AdxNVSUxZX
        gwaxQM5+L2d1uGeyY3YyX6X5hiWJETal8n6tjoF1naex4qJK4jy8yl8N5qDYvPI3c5Fgi8
        Pd0SAU0kc1Gwt8Jx9CLYX8zD4rYH3vs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA73DAFF9;
        Fri, 26 Feb 2021 11:25:29 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     paulmck@kernel.org, mhocko@suse.com,
        Juergen Gross <jgross@suse.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/3] kernel/smp: add boot parameter for controlling CSD lock debugging
Date:   Fri, 26 Feb 2021 12:25:19 +0100
Message-Id: <20210226112521.8641-2-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210226112521.8641-1-jgross@suse.com>
References: <20210226112521.8641-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently CSD lock debugging can be switched on and off via a kernel
config option only. Unfortunately there is at least one problem with
CSD lock handling pending for about 2 years now, which has been seen
in different environments (mostly when running virtualized under KVM
or Xen, at least once on bare metal). Multiple attempts to catch this
issue have finally led to introduction of CSD lock debug code, but
this code is not in use in most distros as it has some impact on
performance.

In order to be able to ship kernels with CONFIG_CSD_LOCK_WAIT_DEBUG
enabled even for production use, add a boot parameter for switching
the debug functionality on. This will reduce any performance impact
of the debug coding to a bare minimum when not being used.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 +++
 kernel/smp.c                                  | 38 +++++++++++++++++--
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bab6a8b01202..af9749b866c2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -784,6 +784,12 @@
 	cs89x0_media=	[HW,NET]
 			Format: { rj45 | aui | bnc }
 
+	csdlock_debug=	[KNL] Enable debug add-ons of cross-cpu function call
+			handling. When switched on additional debug data is
+			printed to the console in case a hanging cpu is
+			detected and that cpu is pinged again in order to try
+			to resolve the hang situation.
+
 	dasd=		[HW,NET]
 			See header of drivers/s390/block/dasd_devmap.c.
 
diff --git a/kernel/smp.c b/kernel/smp.c
index aeb0adfa0606..d5f0b21ab55e 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -24,6 +24,7 @@
 #include <linux/sched/clock.h>
 #include <linux/nmi.h>
 #include <linux/sched/debug.h>
+#include <linux/jump_label.h>
 
 #include "smpboot.h"
 #include "sched/smp.h"
@@ -102,6 +103,20 @@ void __init call_function_init(void)
 
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
+static DEFINE_STATIC_KEY_FALSE(csdlock_debug_enabled);
+
+static int __init csdlock_debug(char *str)
+{
+	unsigned int val = 0;
+
+	get_option(&str, &val);
+	if (val)
+		static_branch_enable(&csdlock_debug_enabled);
+
+	return 0;
+}
+early_param("csdlock_debug", csdlock_debug);
+
 static DEFINE_PER_CPU(call_single_data_t *, cur_csd);
 static DEFINE_PER_CPU(smp_call_func_t, cur_csd_func);
 static DEFINE_PER_CPU(void *, cur_csd_info);
@@ -110,7 +125,7 @@ static DEFINE_PER_CPU(void *, cur_csd_info);
 static atomic_t csd_bug_count = ATOMIC_INIT(0);
 
 /* Record current CSD work for current CPU, NULL to erase. */
-static void csd_lock_record(call_single_data_t *csd)
+static void __csd_lock_record(call_single_data_t *csd)
 {
 	if (!csd) {
 		smp_mb(); /* NULL cur_csd after unlock. */
@@ -125,7 +140,13 @@ static void csd_lock_record(call_single_data_t *csd)
 		  /* Or before unlock, as the case may be. */
 }
 
-static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
+static __always_inline void csd_lock_record(call_single_data_t *csd)
+{
+	if (static_branch_unlikely(&csdlock_debug_enabled))
+		__csd_lock_record(csd);
+}
+
+static int csd_lock_wait_getcpu(call_single_data_t *csd)
 {
 	unsigned int csd_type;
 
@@ -140,7 +161,7 @@ static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
  * the CSD_TYPE_SYNC/ASYNC types provide the destination CPU,
  * so waiting on other types gets much less information.
  */
-static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
+static bool csd_lock_wait_toolong(call_single_data_t *csd, u64 ts0, u64 *ts1, int *bug_id)
 {
 	int cpu = -1;
 	int cpux;
@@ -204,7 +225,7 @@ static __always_inline bool csd_lock_wait_toolong(call_single_data_t *csd, u64 t
  * previous function call. For multi-cpu calls its even more interesting
  * as we'll have to ensure no other cpu is observing our csd.
  */
-static __always_inline void csd_lock_wait(call_single_data_t *csd)
+static void __csd_lock_wait(call_single_data_t *csd)
 {
 	int bug_id = 0;
 	u64 ts0, ts1;
@@ -218,6 +239,15 @@ static __always_inline void csd_lock_wait(call_single_data_t *csd)
 	smp_acquire__after_ctrl_dep();
 }
 
+static __always_inline void csd_lock_wait(call_single_data_t *csd)
+{
+	if (static_branch_unlikely(&csdlock_debug_enabled)) {
+		__csd_lock_wait(csd);
+		return;
+	}
+
+	smp_cond_load_acquire(&csd->node.u_flags, !(VAL & CSD_FLAG_LOCK));
+}
 #else
 static void csd_lock_record(call_single_data_t *csd)
 {
-- 
2.26.2

