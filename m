Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC67B3ACB78
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbhFRM5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:57:32 -0400
Received: from mga18.intel.com ([134.134.136.126]:52722 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233120AbhFRM5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:57:16 -0400
IronPort-SDR: Y4XVKmsExL2TnumFJURwmtVpnJLLZU4xw/RGMY7uY4MVG7DEXsdEfQsCRyEw4hema9+xGhG+wu
 aDaYELhcf5Zw==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="193860537"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="193860537"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 05:54:58 -0700
IronPort-SDR: T/dZ7HM2euqSvCyc6Jls/y/0S7qM9TUsB1qUAN8BekGuX4UlhdGO7gd5owd5kelCvkAgdxAWnL
 7lcUf3f2vPew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="555568678"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2021 05:54:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 93BFA5B5; Fri, 18 Jun 2021 15:55:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>
Subject: [PATCH v2 4/8] platform/x86: intel_skl_int3472: Use ACPI GPIO resource directly
Date:   Fri, 18 Jun 2021 15:55:12 +0300
Message-Id: <20210618125516.53510-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
References: <20210618125516.53510-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we call acpi_gpio_get_io_resource(), the output will be
the pointer to the ACPI GPIO resource. Use it directly instead of
dereferencing the generic resource.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new patch
 .../intel_skl_int3472_clk_and_regulator.c     |  7 ++---
 .../intel-int3472/intel_skl_int3472_common.h  |  2 +-
 .../intel_skl_int3472_discrete.c              | 28 +++++++++----------
 3 files changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c b/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
index ceee860e2c07..49ea1e86c193 100644
--- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
+++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_clk_and_regulator.c
@@ -131,10 +131,10 @@ int skl_int3472_register_clock(struct int3472_discrete_device *int3472)
 }
 
 int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
-				   struct acpi_resource *ares)
+				   struct acpi_resource_gpio *agpio)
 {
-	char *path = ares->data.gpio.resource_source.string_ptr;
 	const struct int3472_sensor_config *sensor_config;
+	char *path = agpio->resource_source.string_ptr;
 	struct regulator_consumer_supply supply_map;
 	struct regulator_init_data init_data = { };
 	struct regulator_config cfg = { };
@@ -168,8 +168,7 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 						int3472->regulator.supply_name,
 						&int3472_gpio_regulator_ops);
 
-	int3472->regulator.gpio = acpi_get_and_request_gpiod(path,
-							     ares->data.gpio.pin_table[0],
+	int3472->regulator.gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
 							     "int3472,regulator");
 	if (IS_ERR(int3472->regulator.gpio)) {
 		dev_err(int3472->dev, "Failed to get regulator GPIO line\n");
diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h b/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
index 6fdf78584219..765e01ec1604 100644
--- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
+++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_common.h
@@ -113,6 +113,6 @@ union acpi_object *skl_int3472_get_acpi_buffer(struct acpi_device *adev,
 int skl_int3472_fill_cldb(struct acpi_device *adev, struct int3472_cldb *cldb);
 int skl_int3472_register_clock(struct int3472_discrete_device *int3472);
 int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
-				   struct acpi_resource *ares);
+				   struct acpi_resource_gpio *agpio);
 
 #endif
diff --git a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c b/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
index 48a00a1f4fb6..fd681d2a73fe 100644
--- a/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
+++ b/drivers/platform/x86/intel-int3472/intel_skl_int3472_discrete.c
@@ -103,11 +103,11 @@ skl_int3472_get_sensor_module_config(struct int3472_discrete_device *int3472)
 }
 
 static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int3472,
-					  struct acpi_resource *ares,
+					  struct acpi_resource_gpio *agpio,
 					  const char *func, u32 polarity)
 {
-	char *path = ares->data.gpio.resource_source.string_ptr;
 	const struct int3472_sensor_config *sensor_config;
+	char *path = agpio->resource_source.string_ptr;
 	struct gpiod_lookup *table_entry;
 	struct acpi_device *adev;
 	acpi_handle handle;
@@ -145,7 +145,7 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
 
 	table_entry = &int3472->gpios.table[int3472->n_sensor_gpios];
 	table_entry->key = acpi_dev_name(adev);
-	table_entry->chip_hwnum = ares->data.gpio.pin_table[0];
+	table_entry->chip_hwnum = agpio->pin_table[0];
 	table_entry->con_id = func;
 	table_entry->idx = 0;
 	table_entry->flags = polarity;
@@ -156,23 +156,22 @@ static int skl_int3472_map_gpio_to_sensor(struct int3472_discrete_device *int347
 }
 
 static int skl_int3472_map_gpio_to_clk(struct int3472_discrete_device *int3472,
-				       struct acpi_resource *ares, u8 type)
+				       struct acpi_resource_gpio *agpio, u8 type)
 {
-	char *path = ares->data.gpio.resource_source.string_ptr;
+	char *path = agpio->resource_source.string_ptr;
+	u16 pin = agpio->pin_table[0];
 	struct gpio_desc *gpio;
 
 	switch (type) {
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
-		gpio = acpi_get_and_request_gpiod(path, ares->data.gpio.pin_table[0],
-						  "int3472,clk-enable");
+		gpio = acpi_get_and_request_gpiod(path, pin, "int3472,clk-enable");
 		if (IS_ERR(gpio))
 			return (PTR_ERR(gpio));
 
 		int3472->clock.ena_gpio = gpio;
 		break;
 	case INT3472_GPIO_TYPE_PRIVACY_LED:
-		gpio = acpi_get_and_request_gpiod(path, ares->data.gpio.pin_table[0],
-						  "int3472,privacy-led");
+		gpio = acpi_get_and_request_gpiod(path, pin, "int3472,privacy-led");
 		if (IS_ERR(gpio))
 			return (PTR_ERR(gpio));
 
@@ -242,7 +241,7 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 
 	if (!obj) {
 		dev_warn(int3472->dev, "No _DSM entry for GPIO pin %u\n",
-			 ares->data.gpio.pin_table[0]);
+			 agpio->pin_table[0]);
 		return 1;
 	}
 
@@ -250,15 +249,14 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 
 	switch (type) {
 	case INT3472_GPIO_TYPE_RESET:
-		ret = skl_int3472_map_gpio_to_sensor(int3472, ares, "reset",
+		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, "reset",
 						     GPIO_ACTIVE_LOW);
 		if (ret)
 			err_msg = "Failed to map reset pin to sensor\n";
 
 		break;
 	case INT3472_GPIO_TYPE_POWERDOWN:
-		ret = skl_int3472_map_gpio_to_sensor(int3472, ares,
-						     "powerdown",
+		ret = skl_int3472_map_gpio_to_sensor(int3472, agpio, "powerdown",
 						     GPIO_ACTIVE_LOW);
 		if (ret)
 			err_msg = "Failed to map powerdown pin to sensor\n";
@@ -266,13 +264,13 @@ static int skl_int3472_handle_gpio_resources(struct acpi_resource *ares,
 		break;
 	case INT3472_GPIO_TYPE_CLK_ENABLE:
 	case INT3472_GPIO_TYPE_PRIVACY_LED:
-		ret = skl_int3472_map_gpio_to_clk(int3472, ares, type);
+		ret = skl_int3472_map_gpio_to_clk(int3472, agpio, type);
 		if (ret)
 			err_msg = "Failed to map GPIO to clock\n";
 
 		break;
 	case INT3472_GPIO_TYPE_POWER_ENABLE:
-		ret = skl_int3472_register_regulator(int3472, ares);
+		ret = skl_int3472_register_regulator(int3472, agpio);
 		if (ret)
 			err_msg = "Failed to map regulator to sensor\n";
 
-- 
2.30.2

