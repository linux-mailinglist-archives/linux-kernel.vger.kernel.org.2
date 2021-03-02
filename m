Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246FD32A292
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346778AbhCBIK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:10:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:13743 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1837395AbhCBHyZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:54:25 -0500
IronPort-SDR: 79wHa5Pjg43kCZ6LIEZXIBv0IWqIBMPYhFa+zoYkz3s5w+uvgPqXDoLMdXq96jzmh/sJ8Ghim0
 fCfCL3ufhF1Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186782248"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="186782248"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 23:51:18 -0800
IronPort-SDR: rRLCUJqweNM8xiqk/1TUkIdq0Zb+mCgiA0ko5v3fufJG+lBob8szTNJz08aOmL/JoQgBzs7l6W
 eMALVJM2ekkQ==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="406597610"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 23:51:15 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: [PATCH v2 3/3] soundwire: Intel: add DMI quirk for Dell SKU 0A3E
Date:   Tue,  2 Mar 2021 15:51:05 +0800
Message-Id: <20210302075105.11515-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
References: <20210302075105.11515-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

We've been handling ACPI issues on early versions of the product with
a local ACPI initrd override but now that we have the possibility of a
kernel quirk let's get rid of the initrd override. This helps make
sure that the kernel will support all versions of the BIOS, with or
without updates.

Co-developed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
---
 drivers/soundwire/dmi-quirks.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 249e476e49ea..82061c1d9835 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -32,6 +32,29 @@ static const struct adr_remap hp_spectre_360[] = {
 	{}
 };
 
+/*
+ * The initial version of the Dell SKU 0A3E did not expose the devices
+ * on the correct links.
+ */
+static const struct adr_remap dell_sku_0A3E[] = {
+	/* rt715 on link0 */
+	{
+		0x00020025d071100,
+		0x00021025d071500
+	},
+	/* rt711 on link1 */
+	{
+		0x000120025d130800,
+		0x000120025d071100,
+	},
+	/* rt1308 on link2 */
+	{
+		0x000220025d071500,
+		0x000220025d130800
+	},
+	{}
+};
+
 static const struct dmi_system_id adr_remap_quirk_table[] = {
 	{
 		.matches = {
@@ -40,6 +63,13 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)hp_spectre_360,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "0A3E")
+		},
+		.driver_data = (void *)dell_sku_0A3E,
+	},
 	{}
 };
 
-- 
2.17.1

