Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7024138F7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 04:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhEYCD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 22:03:26 -0400
Received: from mga12.intel.com ([192.55.52.136]:24699 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhEYCD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 22:03:26 -0400
IronPort-SDR: vZEdsxUTSYMkwUcoKnlGznVJDqMUljzDkHQLWaBfAJ+2Y1hz34CPyBGgGDcogBL8MboyNCjIMR
 i5Wfl0Ktv6Vg==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="181715516"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="181715516"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:01:57 -0700
IronPort-SDR: MUq8VZzO4v5/FNq/eicICWU0kvGFUjs5mGGZBannhFgiDHcp1/rHGsjDzZKZ5KXwN89Nz9liSc
 pdSQFigLWnjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="408349600"
Received: from otc-chromeosbuild-1.jf.intel.com ([10.54.30.83])
  by fmsmga007.fm.intel.com with ESMTP; 24 May 2021 19:01:56 -0700
From:   Azhar Shaikh <azhar.shaikh@intel.com>
To:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        azhar.shaikh@intel.com
Subject: [PATCH] usb: typec: intel_pmc_mux: Update IOM port status offset for AlderLake
Date:   Mon, 24 May 2021 19:04:01 -0700
Message-Id: <20210525020401.6738-1-azhar.shaikh@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel AlderLake(ADL) IOM has a different IOM port status offset than
Intel TigerLake.
Add a new ACPI ID for ADL and use the IOM port status offset as per
the platform.

Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 28 ++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 46a25b8db72e..5ef41cfa8213 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -83,8 +83,6 @@ enum {
 /*
  * Input Output Manager (IOM) PORT STATUS
  */
-#define IOM_PORT_STATUS_OFFSET				0x560
-
 #define IOM_PORT_STATUS_ACTIVITY_TYPE_MASK		GENMASK(9, 6)
 #define IOM_PORT_STATUS_ACTIVITY_TYPE_SHIFT		6
 #define IOM_PORT_STATUS_ACTIVITY_TYPE_USB		0x03
@@ -144,6 +142,7 @@ struct pmc_usb {
 	struct pmc_usb_port *port;
 	struct acpi_device *iom_adev;
 	void __iomem *iom_base;
+	u32 iom_port_status_offset;
 };
 
 static void update_port_status(struct pmc_usb_port *port)
@@ -153,7 +152,8 @@ static void update_port_status(struct pmc_usb_port *port)
 	/* SoC expects the USB Type-C port numbers to start with 0 */
 	port_num = port->usb3_port - 1;
 
-	port->iom_status = readl(port->pmc->iom_base + IOM_PORT_STATUS_OFFSET +
+	port->iom_status = readl(port->pmc->iom_base +
+				 port->pmc->iom_port_status_offset +
 				 port_num * sizeof(u32));
 }
 
@@ -559,14 +559,32 @@ static int is_memory(struct acpi_resource *res, void *data)
 	return !acpi_dev_resource_memory(res, &r);
 }
 
+/* IOM ACPI IDs and IOM_PORT_STATUS_OFFSET */
+static const struct acpi_device_id iom_acpi_ids[] = {
+	/* TigerLake */
+	{ "INTC1072", 0x560, },
+
+	/* AlderLake */
+	{ "INTC1079", 0x160, },
+	{}
+};
+
 static int pmc_usb_probe_iom(struct pmc_usb *pmc)
 {
 	struct list_head resource_list;
 	struct resource_entry *rentry;
-	struct acpi_device *adev;
+	static const struct acpi_device_id *id;
+	struct acpi_device *adev = NULL;
 	int ret;
 
-	adev = acpi_dev_get_first_match_dev("INTC1072", NULL, -1);
+	for (id = &iom_acpi_ids[0]; id->id[0]; id++) {
+		if (acpi_dev_present((const char *)id, NULL, -1)) {
+			pmc->iom_port_status_offset = (u32)id->driver_data;
+			adev = acpi_dev_get_first_match_dev((const char *)id, NULL, -1);
+			break;
+		}
+	}
+
 	if (!adev)
 		return -ENODEV;
 
-- 
2.17.1

