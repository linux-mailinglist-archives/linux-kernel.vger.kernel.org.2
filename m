Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E843ACB74
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhFRM5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:57:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:14292 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231819AbhFRM5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:57:09 -0400
IronPort-SDR: YNzi0lmAECWvkLb1h45C+b8KmUy6pqqXmDbzaCd6srHqKYW4u6ZyA4UERonQaf1dxZOUOBInYn
 6B1xouFEZmtg==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="270395763"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="270395763"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 05:54:58 -0700
IronPort-SDR: /pdkcCQANDexfl5KJUNrMybrKmTZLY3ZYfq6kWmleclQf6EXKadKHyq6dVJPID3wC8XhVM8K7D
 7gvWxYb995Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="638149204"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jun 2021 05:54:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8B49F580; Fri, 18 Jun 2021 15:55:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v2 3/8] platform/x86: intel_skl_int3472: Fix dependencies (drop CLKDEV_LOOKUP)
Date:   Fri, 18 Jun 2021 15:55:11 +0300
Message-Id: <20210618125516.53510-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
References: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Besides the fact that COMMON_CLK selects CLKDEV_LOOKUP, the latter
is going to be removed from clock framework.

Reviewed-by: Daniel Scally <djrscally@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added Rb (Daniel)
 drivers/platform/x86/intel-int3472/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel-int3472/Kconfig b/drivers/platform/x86/intel-int3472/Kconfig
index c112878e833b..62e5d4cf9ee5 100644
--- a/drivers/platform/x86/intel-int3472/Kconfig
+++ b/drivers/platform/x86/intel-int3472/Kconfig
@@ -1,7 +1,7 @@
 config INTEL_SKL_INT3472
 	tristate "Intel SkyLake ACPI INT3472 Driver"
 	depends on ACPI
-	depends on COMMON_CLK && CLKDEV_LOOKUP
+	depends on COMMON_CLK
 	depends on I2C
 	depends on GPIOLIB
 	depends on REGULATOR
-- 
2.30.2

