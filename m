Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C093346FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhCXC5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:57:32 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:29826 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhCXC5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:57:06 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id B17B5E0146;
        Wed, 24 Mar 2021 10:56:59 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>, Wang Qing <wangqing@vivo.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Santosh Sivaraj <santosh@fossix.org>,
        Petr Mladek <pmladek@suse.com>, Andrey Ignatov <rdna@fb.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Modify the explanation and documentation related to watchdog thread
Date:   Wed, 24 Mar 2021 10:56:39 +0800
Message-Id: <1616554602-1857-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTExLSR9OGRoaTB5DVkpNSk1OTk9NSUtOT09VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDI6MBw*Vj8OODhWETkpVikU
        TlZPCUxVSlVKTUpNTk5PTUlLQklOVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFPTEJMNwY+
X-HM-Tid: 0a786229f6362c17kusnb17b5e0146
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"watchdog/%u" threads has be replaced by cpu_stop_work, So we need to modify 
the explanation and documentation related to this.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 .../admin-guide/kernel-per-CPU-kthreads.rst          | 20 --------------------
 kernel/watchdog.c                                    | 12 ++++--------
 2 files changed, 4 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
index 531f689..5e51ee5
--- a/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
+++ b/Documentation/admin-guide/kernel-per-CPU-kthreads.rst
@@ -332,23 +332,3 @@ To reduce its OS jitter, do at least one of the following:
 	kthreads from being created in the first place.  However, please
 	note that this will not eliminate OS jitter, but will instead
 	shift it to RCU_SOFTIRQ.
-
-Name:
-  watchdog/%u
-
-Purpose:
-  Detect software lockups on each CPU.
-
-To reduce its OS jitter, do at least one of the following:
-
-1.	Build with CONFIG_LOCKUP_DETECTOR=n, which will prevent these
-	kthreads from being created in the first place.
-2.	Boot with "nosoftlockup=0", which will also prevent these kthreads
-	from being created.  Other related watchdog and softlockup boot
-	parameters may be found in Documentation/admin-guide/kernel-parameters.rst
-	and Documentation/watchdog/watchdog-parameters.rst.
-3.	Echo a zero to /proc/sys/kernel/watchdog to disable the
-	watchdog timer.
-4.	Echo a large number of /proc/sys/kernel/watchdog_thresh in
-	order to reduce the frequency of OS jitter due to the watchdog
-	timer down to a level that is acceptable for your workload.
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 7110906..d7fb4fb
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -92,7 +92,7 @@ __setup("nmi_watchdog=", hardlockup_panic_setup);
  * own hardlockup detector.
  *
  * watchdog_nmi_enable/disable can be implemented to start and stop when
- * softlockup watchdog threads start and stop. The arch must select the
+ * softlockup watchdog start and stop. The arch must select the
  * SOFTLOCKUP_DETECTOR Kconfig.
  */
 int __weak watchdog_nmi_enable(unsigned int cpu)
@@ -322,7 +322,7 @@ static DEFINE_PER_CPU(struct completion, softlockup_completion);
 static DEFINE_PER_CPU(struct cpu_stop_work, softlockup_stop_work);
 
 /*
- * The watchdog thread function - touches the timestamp.
+ * The watchdog feed function - touches the timestamp.
  *
  * It only runs once every sample_period seconds (4 seconds by
  * default) to reset the softlockup timestamp. If this gets delayed
@@ -551,11 +551,7 @@ static void lockup_detector_reconfigure(void)
 }
 
 /*
- * Create the watchdog thread infrastructure and configure the detector(s).
- *
- * The threads are not unparked as watchdog_allowed_mask is empty.  When
- * the threads are successfully initialized, take the proper locks and
- * unpark the threads in the watchdog_cpumask if the watchdog is enabled.
+ * Create the watchdog infrastructure and configure the detector(s).
  */
 static __init void lockup_detector_setup(void)
 {
@@ -621,7 +617,7 @@ void lockup_detector_soft_poweroff(void)
 
 #ifdef CONFIG_SYSCTL
 
-/* Propagate any changes to the watchdog threads */
+/* Propagate any changes to the watchdog infrastructure */
 static void proc_watchdog_update(void)
 {
 	/* Remove impossible cpus to keep sysctl output clean. */
-- 
2.7.4

