Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2733502EA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhCaPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:05:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:50205 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236030AbhCaPFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:05:17 -0400
IronPort-SDR: s+VCwYd9LFBEFudtfSPq76rNYMDQ7SHHEcOnMKYAms/wU4vWYZJQfbPltf9HaNsGlB6JT73ED/
 4xTrqWfj/mUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="277206972"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="277206972"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 08:05:15 -0700
IronPort-SDR: jtOjRKjp4Dzw48N7Ih0ehk5t2Gx3Mfh7/MPivrs/RhfG9djF7WEdTeTjZyTh56W3kTPcXimdnl
 3roJyvlpO24w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="516934160"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2021 08:05:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 83F55199; Wed, 31 Mar 2021 18:05:28 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v1 1/1] driver core: platform: Declare early_platform_cleanup() prototype
Date:   Wed, 31 Mar 2021 18:05:25 +0300
Message-Id: <20210331150525.59223-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiler is not happy:

  CC      drivers/base/platform.o
drivers/base/platform.c:1557:20: warning: no previous prototype for ‘early_platform_cleanup’ [-Wmissing-prototypes]
 1557 | void __weak __init early_platform_cleanup(void) { }
      |                    ^~~~~~~~~~~~~~~~~~~~~~

Declare early_platform_cleanup() prototype in the header to make everyone happy.

Fixes: eecd37e105f0 ("drivers: Fix boot problem on SuperH")
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/platform_device.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 3f23f6e430bf..cd81e060863c 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -359,4 +359,7 @@ static inline int is_sh_early_platform_device(struct platform_device *pdev)
 }
 #endif /* CONFIG_SUPERH */
 
+/* For now only SuperH uses it */
+void early_platform_cleanup(void);
+
 #endif /* _PLATFORM_DEVICE_H_ */
-- 
2.30.2

