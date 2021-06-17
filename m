Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126E23ABBDF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 20:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbhFQSdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 14:33:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:17452 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231674AbhFQSc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 14:32:59 -0400
IronPort-SDR: IczcYC352r3TbDe9ZLQbb1S4Yu48ih4Exu4BkZDcVCuiO8lEP62fUyGnzL1WWsOFpMGq7VRM5J
 OEmImWZvtglw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="186807543"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="186807543"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 11:30:50 -0700
IronPort-SDR: TXyR17xtMuYpevbI812ZGnup2NQnwPfVlmTWsubnPrV+hPTMzyBGx1YaOzJeoGvdoQJv3WMpmU
 daMJF/KsuNSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="452870205"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jun 2021 11:30:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id DC075262; Thu, 17 Jun 2021 21:31:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v1 1/4] platform/x86: Remove "default n" entries
Date:   Thu, 17 Jun 2021 21:30:28 +0300
Message-Id: <20210617183031.70685-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus already once did that for PDx86, don't repeat our mistakes.
TL;DR: 'n' *is* the default 'default'.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/Kconfig      | 1 -
 drivers/platform/x86/dell/Kconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 4fd792f2a10a..ccb827b57f1f 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1092,7 +1092,6 @@ config TOUCHSCREEN_DMI
 
 config FW_ATTR_CLASS
 	tristate
-	default n
 
 config INTEL_IMR
 	bool "Intel Isolated Memory Region support"
diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
index 9b0a4d080f43..9e7314d90bea 100644
--- a/drivers/platform/x86/dell/Kconfig
+++ b/drivers/platform/x86/dell/Kconfig
@@ -5,7 +5,6 @@
 
 menuconfig X86_PLATFORM_DRIVERS_DELL
 	bool "Dell X86 Platform Specific Device Drivers"
-	default n
 	depends on X86_PLATFORM_DEVICES
 	help
 	  Say Y here to get to see options for device drivers for various
-- 
2.30.2

