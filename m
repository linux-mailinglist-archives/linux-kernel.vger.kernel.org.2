Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCAC32812A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 15:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbhCAOov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 09:44:51 -0500
Received: from mga03.intel.com ([134.134.136.65]:19892 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236497AbhCAOor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 09:44:47 -0500
IronPort-SDR: RehoTuLJTa+iLe+cr1sEyPnPnkavfnh5bdRYbtWZVRIUf9C1ykPNicJ12Kup62HNwe1asotN36
 kQx7wOJoSEKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="186536899"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="186536899"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 06:42:47 -0800
IronPort-SDR: D22qjAOIrcHT8tQ/XMi1++HgNQwNEW0+pxyEU+FwnRS6Lp/do9tqsHbDg/t3sqwwoRbK1ecPRI
 n+xe4VphGpTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="406251157"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 01 Mar 2021 06:42:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 77965F4; Mon,  1 Mar 2021 16:42:45 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] mfd: core: Remove support for dangling device properties
Date:   Mon,  1 Mar 2021 16:42:22 +0200
Message-Id: <20210301144222.31290-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301144222.31290-1-andriy.shevchenko@linux.intel.com>
References: <20210301144222.31290-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

From now on only accepting complete software nodes.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/mfd/mfd-core.c   | 6 ------
 include/linux/mfd/core.h | 4 ----
 2 files changed, 10 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index e24008b94aac..6dcff4b8e15e 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -238,12 +238,6 @@ static int mfd_add_device(struct device *parent, int id,
 			goto fail_of_entry;
 	}
 
-	if (cell->properties) {
-		ret = platform_device_add_properties(pdev, cell->properties);
-		if (ret)
-			goto fail_of_entry;
-	}
-
 	if (cell->swnode) {
 		ret = device_add_software_node(&pdev->dev, cell->swnode);
 		if (ret)
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 9ec599167fe6..0bc7cba798a3 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -51,7 +51,6 @@
 
 struct irq_domain;
 struct software_node;
-struct property_entry;
 
 /* Matches ACPI PNP id, either _HID or _CID, or ACPI _ADR */
 struct mfd_cell_acpi_match {
@@ -82,9 +81,6 @@ struct mfd_cell {
 	/* Software node for the device. */
 	const struct software_node *swnode;
 
-	/* device properties passed to the sub devices drivers */
-	const struct property_entry *properties;
-
 	/*
 	 * Device Tree compatible string
 	 * See: Documentation/devicetree/usage-model.rst Chapter 2.2 for details
-- 
2.30.1

