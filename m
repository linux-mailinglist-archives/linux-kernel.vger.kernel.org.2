Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631C33FAB75
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 14:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbhH2Mo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 08:44:57 -0400
Received: from mga12.intel.com ([192.55.52.136]:52069 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235259AbhH2Moy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:44:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10090"; a="197720595"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="197720595"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 05:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="539808156"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2021 05:43:58 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id F09DBC5; Sun, 29 Aug 2021 15:43:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] pvpanic: Keep single style across modules
Date:   Sun, 29 Aug 2021 15:43:52 +0300
Message-Id: <20210829124354.81653-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have different style on where we place module_*() and MODULE_*() macros.
Inherit the style from the original module (now pvpanic-mmio.c).

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/pvpanic/pvpanic-pci.c | 14 ++++++--------
 drivers/misc/pvpanic/pvpanic.c     |  3 +--
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 741116b3d995..7d1220f4c95b 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -22,11 +22,6 @@ MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
 MODULE_DESCRIPTION("pvpanic device driver ");
 MODULE_LICENSE("GPL");
 
-static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC)},
-	{}
-};
-
 static ssize_t capability_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
@@ -99,6 +94,12 @@ static int pvpanic_pci_probe(struct pci_dev *pdev,
 	return devm_pvpanic_probe(&pdev->dev, pi);
 }
 
+static const struct pci_device_id pvpanic_pci_id_tbl[]  = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT, PCI_DEVICE_ID_REDHAT_PVPANIC)},
+	{}
+};
+MODULE_DEVICE_TABLE(pci, pvpanic_pci_id_tbl);
+
 static struct pci_driver pvpanic_pci_driver = {
 	.name =         "pvpanic-pci",
 	.id_table =     pvpanic_pci_id_tbl,
@@ -107,7 +108,4 @@ static struct pci_driver pvpanic_pci_driver = {
 		.dev_groups = pvpanic_pci_dev_groups,
 	},
 };
-
-MODULE_DEVICE_TABLE(pci, pvpanic_pci_id_tbl);
-
 module_pci_driver(pvpanic_pci_driver);
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 02b807c788c9..fb5411dfd614 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -99,6 +99,7 @@ static int pvpanic_init(void)
 
 	return 0;
 }
+module_init(pvpanic_init);
 
 static void pvpanic_exit(void)
 {
@@ -106,6 +107,4 @@ static void pvpanic_exit(void)
 					 &pvpanic_panic_nb);
 
 }
-
-module_init(pvpanic_init);
 module_exit(pvpanic_exit);
-- 
2.33.0

