Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2D132A28E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381603AbhCBIFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:05:47 -0500
Received: from mga03.intel.com ([134.134.136.65]:13759 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381492AbhCBHxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:53:03 -0500
IronPort-SDR: FARAqDT4mnDT41RucX1yNmKYgWrn4nbyfulbPLqwmj+C+kkIc0KJ1ZIq1Xb9DyYcVL1NjFKV4F
 MqjGXvrI1C4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186782241"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="186782241"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 23:51:15 -0800
IronPort-SDR: byUiS9rIG5lwheUs1+zg2/hXGgKivn3c6WOCps3Zt4idWWDPolVmperYxRX50vogzV7Q4B7B8l
 CQ0s8Ev5U0GA==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="406597597"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 23:51:11 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 2/3] soundwire: Intel: introduce DMI quirks for HP Spectre x360 Convertible
Date:   Tue,  2 Mar 2021 15:51:04 +0800
Message-Id: <20210302075105.11515-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
References: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

HP Spectre x360 Convertible devices expose invalid _ADR fields in the
DSDT, which prevents codec drivers from probing. A possible solution
is to override the DSDT, but that's just too painful for users.

This patch suggests a simple DMI-based quirk to remap the existing
invalid ADR information into valid ones.

BugLink: https://github.com/thesofproject/linux/issues/2700
Co-developed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/soundwire/Makefile     |  2 +-
 drivers/soundwire/bus.h        |  2 ++
 drivers/soundwire/dmi-quirks.c | 66 ++++++++++++++++++++++++++++++++++
 drivers/soundwire/intel.c      |  1 +
 4 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 drivers/soundwire/dmi-quirks.c

diff --git a/drivers/soundwire/Makefile b/drivers/soundwire/Makefile
index bf1e250d50dd..986776787b9e 100644
--- a/drivers/soundwire/Makefile
+++ b/drivers/soundwire/Makefile
@@ -20,7 +20,7 @@ soundwire-cadence-y := cadence_master.o
 obj-$(CONFIG_SOUNDWIRE_CADENCE) += soundwire-cadence.o
 
 #Intel driver
-soundwire-intel-y :=	intel.o intel_init.o
+soundwire-intel-y :=	intel.o intel_init.o dmi-quirks.o
 obj-$(CONFIG_SOUNDWIRE_INTEL) += soundwire-intel.o
 
 #Qualcomm driver
diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
index 2e049d39c6e5..40354469860a 100644
--- a/drivers/soundwire/bus.h
+++ b/drivers/soundwire/bus.h
@@ -7,6 +7,8 @@
 #define DEFAULT_BANK_SWITCH_TIMEOUT 3000
 #define DEFAULT_PROBE_TIMEOUT       2000
 
+u64 sdw_dmi_override_adr(struct sdw_bus *bus, u64 addr);
+
 #if IS_ENABLED(CONFIG_ACPI)
 int sdw_acpi_find_slaves(struct sdw_bus *bus);
 #else
diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
new file mode 100644
index 000000000000..249e476e49ea
--- /dev/null
+++ b/drivers/soundwire/dmi-quirks.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+// Copyright(c) 2021 Intel Corporation.
+
+/*
+ * Soundwire DMI quirks
+ */
+
+#include <linux/device.h>
+#include <linux/dmi.h>
+#include <linux/soundwire/sdw.h>
+#include "bus.h"
+
+struct adr_remap {
+	u64 adr;
+	u64 remapped_adr;
+};
+
+/*
+ * HP Spectre 360 Convertible devices do not expose the correct _ADR
+ * in the DSDT.
+ * Remap the bad _ADR values to the ones reported by hardware
+ */
+static const struct adr_remap hp_spectre_360[] = {
+	{
+		0x000010025D070100,
+		0x000020025D071100
+	},
+	{
+		0x000110025d070100,
+		0x000120025D130800
+	},
+	{}
+};
+
+static const struct dmi_system_id adr_remap_quirk_table[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Spectre x360 Convertible"),
+		},
+		.driver_data = (void *)hp_spectre_360,
+	},
+	{}
+};
+
+u64 sdw_dmi_override_adr(struct sdw_bus *bus, u64 addr)
+{
+	const struct dmi_system_id *dmi_id;
+
+	/* check if any address remap quirk applies */
+	dmi_id = dmi_first_match(adr_remap_quirk_table);
+	if (dmi_id) {
+		struct adr_remap *map = dmi_id->driver_data;
+
+		for (map = dmi_id->driver_data; map->adr; map++) {
+			if (map->adr == addr) {
+				dev_dbg(bus->dev, "remapped _ADR 0x%llx as 0x%llx\n",
+					addr, map->remapped_adr);
+				addr = map->remapped_adr;
+				break;
+			}
+		}
+	}
+
+	return addr;
+}
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index a2d5cdaa9998..a401e270a47f 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1302,6 +1302,7 @@ static int intel_prop_read(struct sdw_bus *bus)
 
 static struct sdw_master_ops sdw_intel_ops = {
 	.read_prop = sdw_master_read_prop,
+	.override_adr = sdw_dmi_override_adr,
 	.xfer_msg = cdns_xfer_msg,
 	.xfer_msg_defer = cdns_xfer_msg_defer,
 	.reset_page_addr = cdns_reset_page_addr,
-- 
2.17.1

