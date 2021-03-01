Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F3C328127
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhCAOo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:44:27 -0500
Received: from mga07.intel.com ([134.134.136.100]:9788 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233264AbhCAOoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:44:23 -0500
IronPort-SDR: ksXmxMV0R78WFswclYM/zWPQFX/eo9Wi3/1Ugr0TQpmeE/BmsawHtamDVF18h3L4IOdYsgs7I6
 UwNISBw8TfjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="250533184"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="250533184"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 06:42:37 -0800
IronPort-SDR: EiUVTyoNsFMeJ91OqMt5c8A9IHJnS8zn1UBpeBM0x0pUIEU9cjG/NXBa2+0beuIl7ejNrjmrv4
 +NMI3dHWomEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="585513939"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 01 Mar 2021 06:42:36 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CBD72F4; Mon,  1 Mar 2021 16:42:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] mfd: core: Add support for software nodes
Date:   Mon,  1 Mar 2021 16:42:19 +0200
Message-Id: <20210301144222.31290-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

The old device property API is going to be removed and
replaced with the newer software node API. This prepares MFD
subsystem for the transition.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/mfd-core.c   | 9 +++++++++
 include/linux/mfd/core.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index fc00aaccb5f7..e24008b94aac 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -244,6 +244,12 @@ static int mfd_add_device(struct device *parent, int id,
 			goto fail_of_entry;
 	}
 
+	if (cell->swnode) {
+		ret = device_add_software_node(&pdev->dev, cell->swnode);
+		if (ret)
+			goto fail_of_entry;
+	}
+
 	for (r = 0; r < cell->num_resources; r++) {
 		res[r].name = cell->resources[r].name;
 		res[r].flags = cell->resources[r].flags;
@@ -304,6 +310,7 @@ static int mfd_add_device(struct device *parent, int id,
 			list_del(&of_entry->list);
 			kfree(of_entry);
 		}
+	device_remove_software_node(&pdev->dev);
 fail_alias:
 	regulator_bulk_unregister_supply_alias(&pdev->dev,
 					       cell->parent_supplies,
@@ -372,6 +379,8 @@ static int mfd_remove_devices_fn(struct device *dev, void *data)
 	regulator_bulk_unregister_supply_alias(dev, cell->parent_supplies,
 					       cell->num_parent_supplies);
 
+	device_remove_software_node(&pdev->dev);
+
 	platform_device_unregister(pdev);
 	return 0;
 }
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 2009c4b936d9..9ec599167fe6 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -50,6 +50,7 @@
 #define MFD_DEP_LEVEL_HIGH 1
 
 struct irq_domain;
+struct software_node;
 struct property_entry;
 
 /* Matches ACPI PNP id, either _HID or _CID, or ACPI _ADR */
@@ -78,6 +79,9 @@ struct mfd_cell {
 	void			*platform_data;
 	size_t			pdata_size;
 
+	/* Software node for the device. */
+	const struct software_node *swnode;
+
 	/* device properties passed to the sub devices drivers */
 	const struct property_entry *properties;
 
-- 
2.30.1

