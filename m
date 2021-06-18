Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3334B3ACB71
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbhFRM5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:57:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:41863 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231437AbhFRM5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:57:09 -0400
IronPort-SDR: +thxC2Tc8fAVIhxNZXZtHAd1dj9IjmB+arvNyLL0Bi9MmIsCervGQ54Gyudh5l3jX2kVZspv47
 Brp98GE9Drzg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="267692210"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="267692210"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 05:54:58 -0700
IronPort-SDR: rD3VS5ul0snUG/7nJCTvtzScoLAUhkAQsSR9EuMZidCZDIQzyDTq7UEsJ10SZQmFYPVv/bnKFs
 lxxuWYxlxr0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="404970795"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2021 05:54:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7964C50E; Fri, 18 Jun 2021 15:55:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v2 1/8] platform/x86: Remove "default n" entries
Date:   Fri, 18 Jun 2021 15:55:09 +0300
Message-Id: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
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
v2: no changes
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

