Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D939534F406
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 00:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbhC3WJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 18:09:08 -0400
Received: from mga14.intel.com ([192.55.52.115]:48937 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232793AbhC3WIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:08:44 -0400
IronPort-SDR: D2MeDUnxbG+iYImGRfvtM3A9AD02RdLV/TZ9uG8K9wmIL0xmpCRCuhoPdhtB5qRnnyyuudfHWL
 zus9ZxjM4rxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="191341943"
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="191341943"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 15:08:43 -0700
IronPort-SDR: we5lIoaqklH/BWhoMXBYuNlNo2qyQsr+QzNZbSXCX0/UdRn76vILzkUIDbujA1bkuGvWAYnOeB
 m4qrEAjcvsSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="393779757"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orsmga002.jf.intel.com with ESMTP; 30 Mar 2021 15:08:42 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     mgross@linux.intel.com, hdegoede@redhat.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] platform/x86: ISST: Account for increased timeout in some cases
Date:   Tue, 30 Mar 2021 15:08:40 -0700
Message-Id: <20210330220840.3113959-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases when firmware is busy or updating, some mailbox commands
still timeout on some newer CPUs. To fix this issue, change how we
process timeout.

With this change, replaced timeout from using simple count with real
timeout in micro-seconds using ktime. When the command response takes
more than average processing time, yield to other tasks. The worst case
timeout is extended upto 1 milli-second.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../intel_speed_select_if/isst_if_mbox_pci.c  | 33 +++++++++++++------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
index a2a2d923e60c..df1fc6c719f3 100644
--- a/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
+++ b/drivers/platform/x86/intel_speed_select_if/isst_if_mbox_pci.c
@@ -21,12 +21,16 @@
 #define PUNIT_MAILBOX_BUSY_BIT		31
 
 /*
- * The average time to complete some commands is about 40us. The current
- * count is enough to satisfy 40us. But when the firmware is very busy, this
- * causes timeout occasionally.  So increase to deal with some worst case
- * scenarios. Most of the command still complete in few us.
+ * The average time to complete mailbox commands is less than 40us. Most of
+ * the commands complete in few micro seconds. But the same firmware handles
+ * requests from all power management features.
+ * We can create a scenario where we flood the firmware with requests then
+ * the mailbox response can be delayed for 100s of micro seconds. So define
+ * two timeouts. One for average case and one for long.
+ * If the firmware is taking more than average, just call cond_resched().
  */
-#define OS_MAILBOX_RETRY_COUNT		100
+#define OS_MAILBOX_TIMEOUT_AVG_US	40
+#define OS_MAILBOX_TIMEOUT_MAX_US	1000
 
 struct isst_if_device {
 	struct mutex mutex;
@@ -35,11 +39,13 @@ struct isst_if_device {
 static int isst_if_mbox_cmd(struct pci_dev *pdev,
 			    struct isst_if_mbox_cmd *mbox_cmd)
 {
-	u32 retries, data;
+	s64 tm_delta = 0;
+	ktime_t tm;
+	u32 data;
 	int ret;
 
 	/* Poll for rb bit == 0 */
-	retries = OS_MAILBOX_RETRY_COUNT;
+	tm = ktime_get();
 	do {
 		ret = pci_read_config_dword(pdev, PUNIT_MAILBOX_INTERFACE,
 					    &data);
@@ -48,11 +54,14 @@ static int isst_if_mbox_cmd(struct pci_dev *pdev,
 
 		if (data & BIT_ULL(PUNIT_MAILBOX_BUSY_BIT)) {
 			ret = -EBUSY;
+			tm_delta = ktime_us_delta(ktime_get(), tm);
+			if (tm_delta > OS_MAILBOX_TIMEOUT_AVG_US)
+				cond_resched();
 			continue;
 		}
 		ret = 0;
 		break;
-	} while (--retries);
+	} while (tm_delta < OS_MAILBOX_TIMEOUT_MAX_US);
 
 	if (ret)
 		return ret;
@@ -74,7 +83,8 @@ static int isst_if_mbox_cmd(struct pci_dev *pdev,
 		return ret;
 
 	/* Poll for rb bit == 0 */
-	retries = OS_MAILBOX_RETRY_COUNT;
+	tm_delta = 0;
+	tm = ktime_get();
 	do {
 		ret = pci_read_config_dword(pdev, PUNIT_MAILBOX_INTERFACE,
 					    &data);
@@ -83,6 +93,9 @@ static int isst_if_mbox_cmd(struct pci_dev *pdev,
 
 		if (data & BIT_ULL(PUNIT_MAILBOX_BUSY_BIT)) {
 			ret = -EBUSY;
+			tm_delta = ktime_us_delta(ktime_get(), tm);
+			if (tm_delta > OS_MAILBOX_TIMEOUT_AVG_US)
+				cond_resched();
 			continue;
 		}
 
@@ -96,7 +109,7 @@ static int isst_if_mbox_cmd(struct pci_dev *pdev,
 		mbox_cmd->resp_data = data;
 		ret = 0;
 		break;
-	} while (--retries);
+	} while (tm_delta < OS_MAILBOX_TIMEOUT_MAX_US);
 
 	return ret;
 }
-- 
2.25.4

