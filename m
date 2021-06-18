Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B063ACB75
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbhFRM5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:57:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:24557 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232837AbhFRM5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:57:10 -0400
IronPort-SDR: I4ZcWTpUu+d7bpPLWM0jIvIfJEeaO4dM41WIq02LNrMJdtHhEatNtEyRYxzVON7JF+E3aQvwKm
 O+Re5ItW6E0w==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="186926061"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="186926061"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 05:54:59 -0700
IronPort-SDR: 1kbTWI+eR+KE5WgtuOOUpYKOuuU/aXLhV+DMkydjWPCfI4vWa6ynSbn9hwXXvY1ERPB/EAG4p9
 QhmoUEBZ14Yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="640700723"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2021 05:54:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 826B9431; Fri, 18 Jun 2021 15:55:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v2 2/8] platform/x86: intel_skl_int3472: Free ACPI device resources after use
Date:   Fri, 18 Jun 2021 15:55:10 +0300
Message-Id: <20210618125516.53510-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
References: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may free ACPI device resources immediately after use.
Refactor skl_int3472_parse_crs() accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 .../x86/intel-int3472/intel_skl_int3472_discrete.c  | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c b/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
index 8c18dbff1c43..48a00a1f4fb6 100644
--- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
+++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
@@ -308,8 +308,10 @@ static int skl_int3472_parse_crs(struct int3472_discrete_device *int3472)
 	ret = acpi_dev_get_resources(int3472->adev, &resource_list,
 				     skl_int3472_handle_gpio_resources,
 				     int3472);
-	if (ret)
-		goto out_free_res_list;
+	if (ret < 0)
+		return ret;
+
+	acpi_dev_free_resource_list(&resource_list);
 
 	/*
 	 * If we find no clock enable GPIO pin then the privacy LED won't work.
@@ -319,7 +321,7 @@ static int skl_int3472_parse_crs(struct int3472_discrete_device *int3472)
 	if (int3472->clock.ena_gpio) {
 		ret = skl_int3472_register_clock(int3472);
 		if (ret)
-			goto out_free_res_list;
+			return ret;
 	} else {
 		if (int3472->clock.led_gpio)
 			dev_warn(int3472->dev,
@@ -329,10 +331,7 @@ static int skl_int3472_parse_crs(struct int3472_discrete_device *int3472)
 	int3472->gpios.dev_id = int3472->sensor_name;
 	gpiod_add_lookup_table(&int3472->gpios);
 
-out_free_res_list:
-	acpi_dev_free_resource_list(&resource_list);
-
-	return ret;
+	return 0;
 }
 
 int skl_int3472_discrete_probe(struct platform_device *pdev)
-- 
2.30.2

