Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A44350D2E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 05:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhDADcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 23:32:24 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:38270 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhDADb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 23:31:58 -0400
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 66D1FE0282;
        Thu,  1 Apr 2021 11:31:55 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>, Joe Perches <joe@perches.com>,
        Wang Qing <wangqing@vivo.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Eric Biggers <ebiggers@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Petr Mladek <pmladek@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Santosh Sivaraj <santosh@fossix.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Andrey Ignatov <rdna@fb.com>
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH V2 1/4] kernel: watchdog: Modify the explanation related to watchdog thread
Date:   Thu,  1 Apr 2021 11:31:31 +0800
Message-Id: <1617247900-23813-2-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617247900-23813-1-git-send-email-wangqing@vivo.com>
References: <1617247900-23813-1-git-send-email-wangqing@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZH0NIGB8YSExIHktDVkpNSkxJT0xCSk1KQkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTI6LBw4Aj8KMDQNFBE6PTZI
        DAsKC09VSlVKTUpMSU9MQkpNTktIVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFPSUhPNwY+
X-HM-Tid: 0a788b7cd04e2c17kusn66d1fe0282
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The watchdog thread has been replaced by cpu_stop_work, modify the 
explanation related.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/watchdog.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

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

