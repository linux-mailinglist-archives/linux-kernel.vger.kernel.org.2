Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EDF34AD42
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 18:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhCZRYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 13:24:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:50877 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhCZRXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 13:23:54 -0400
IronPort-SDR: PfmUfFaiQ7YraDDLyL+hZqMBrpv1cz0LSFvPLAhCLQ7HEb6Qn77qHmQSu5hI/x6kkbO8DGpktu
 5G/Lh9F+AiDA==
X-IronPort-AV: E=McAfee;i="6000,8403,9935"; a="190631528"
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="190631528"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 10:23:54 -0700
IronPort-SDR: jZQxOIOaDMznMWA5sWTSORlT7efU8wJatRFvj/OkXaf4TVxbTgId3KkcOTlRcqt8ZVDtvw/KAR
 mvXWTP5RM3rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,281,1610438400"; 
   d="scan'208";a="409989810"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2021 10:23:53 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5990F236; Fri, 26 Mar 2021 19:24:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Rosin <peda@axentia.se>
Subject: [PATCH v1 2/3] mux: gpio: Make it OF independent
Date:   Fri, 26 Mar 2021 19:24:00 +0200
Message-Id: <20210326172401.33685-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210326172401.33685-1-andriy.shevchenko@linux.intel.com>
References: <20210326172401.33685-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Module doesn't use OF APIs anyhow, make it OF independent by replacing
headers and dropping useless of_match_ptr() call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mux/gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mux/gpio.c b/drivers/mux/gpio.c
index 891ee0274733..e5ef9284e2b4 100644
--- a/drivers/mux/gpio.c
+++ b/drivers/mux/gpio.c
@@ -10,8 +10,8 @@
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mux/driver.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
@@ -97,7 +97,7 @@ static int mux_gpio_probe(struct platform_device *pdev)
 static struct platform_driver mux_gpio_driver = {
 	.driver = {
 		.name = "gpio-mux",
-		.of_match_table	= of_match_ptr(mux_gpio_dt_ids),
+		.of_match_table	= mux_gpio_dt_ids,
 	},
 	.probe = mux_gpio_probe,
 };
-- 
2.30.2

