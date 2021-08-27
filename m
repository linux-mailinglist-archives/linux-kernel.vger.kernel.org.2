Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069ED3F9B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245353AbhH0OyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:54:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:28975 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231327AbhH0OyE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:54:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10089"; a="198209383"
X-IronPort-AV: E=Sophos;i="5.84,356,1620716400"; 
   d="scan'208";a="198209383"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2021 07:53:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,356,1620716400"; 
   d="scan'208";a="427138314"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 27 Aug 2021 07:53:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 14AF51ED; Fri, 27 Aug 2021 17:53:13 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zha Qipeng <qipeng.zha@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] platform/x86/intel: punit_ipc: Drop wrong use of ACPI_PTR()
Date:   Fri, 27 Aug 2021 17:53:10 +0300
Message-Id: <20210827145310.76239-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI_PTR() is more harmful than helpful. For example, in this case
if CONFIG_ACPI=n, the ID table left unused which is not what we want.

Instead of adding ifdeffery here and there, drop ACPI_PTR()
and unused acpi.h.

Fixes: fdca4f16f57d ("platform:x86: add Intel P-Unit mailbox IPC driver")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/intel/punit_ipc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/platform/x86/intel/punit_ipc.c b/drivers/platform/x86/intel/punit_ipc.c
index f58b8543f6ac..66bb39fd0ef9 100644
--- a/drivers/platform/x86/intel/punit_ipc.c
+++ b/drivers/platform/x86/intel/punit_ipc.c
@@ -8,7 +8,6 @@
  * which provide mailbox interface for power management usage.
  */
 
-#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -319,7 +318,7 @@ static struct platform_driver intel_punit_ipc_driver = {
 	.remove = intel_punit_ipc_remove,
 	.driver = {
 		.name = "intel_punit_ipc",
-		.acpi_match_table = ACPI_PTR(punit_ipc_acpi_ids),
+		.acpi_match_table = punit_ipc_acpi_ids,
 	},
 };
 
-- 
2.33.0

