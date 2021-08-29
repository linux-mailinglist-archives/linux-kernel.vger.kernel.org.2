Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69F503FAB74
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 14:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbhH2Moz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 08:44:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:33566 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235256AbhH2Mox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 08:44:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10090"; a="198394440"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="198394440"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 05:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="599850941"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2021 05:44:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D921311C; Sun, 29 Aug 2021 15:44:01 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mihai Carabas <mihai.carabas@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] pvpanic: Indentation fixes here and there
Date:   Sun, 29 Aug 2021 15:43:54 +0300
Message-Id: <20210829124354.81653-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210829124354.81653-1-andriy.shevchenko@linux.intel.com>
References: <20210829124354.81653-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) replace double spaces with single;
2) relax line width limitation a bit.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/pvpanic/pvpanic-mmio.c |  7 +++----
 drivers/misc/pvpanic/pvpanic-pci.c  | 12 +++++-------
 drivers/misc/pvpanic/pvpanic.c      | 11 ++++-------
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c b/drivers/misc/pvpanic/pvpanic-mmio.c
index 61dbff5f0065..eb97167c03fb 100644
--- a/drivers/misc/pvpanic/pvpanic-mmio.c
+++ b/drivers/misc/pvpanic/pvpanic-mmio.c
@@ -24,8 +24,7 @@ MODULE_AUTHOR("Hu Tao <hutao@cn.fujitsu.com>");
 MODULE_DESCRIPTION("pvpanic-mmio device driver");
 MODULE_LICENSE("GPL");
 
-static ssize_t capability_show(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pvpanic_instance *pi = dev_get_drvdata(dev);
 
@@ -33,14 +32,14 @@ static ssize_t capability_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(capability);
 
-static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
+static ssize_t events_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pvpanic_instance *pi = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%x\n", pi->events);
 }
 
-static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
+static ssize_t events_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	struct pvpanic_instance *pi = dev_get_drvdata(dev);
diff --git a/drivers/misc/pvpanic/pvpanic-pci.c b/drivers/misc/pvpanic/pvpanic-pci.c
index 7d1220f4c95b..07eddb5ea30f 100644
--- a/drivers/misc/pvpanic/pvpanic-pci.c
+++ b/drivers/misc/pvpanic/pvpanic-pci.c
@@ -19,11 +19,10 @@
 #define PCI_DEVICE_ID_REDHAT_PVPANIC     0x0011
 
 MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
-MODULE_DESCRIPTION("pvpanic device driver ");
+MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
 
-static ssize_t capability_show(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pvpanic_instance *pi = dev_get_drvdata(dev);
 
@@ -31,14 +30,14 @@ static ssize_t capability_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(capability);
 
-static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
+static ssize_t events_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct pvpanic_instance *pi = dev_get_drvdata(dev);
 
 	return sysfs_emit(buf, "%x\n", pi->events);
 }
 
-static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
+static ssize_t events_store(struct device *dev, struct device_attribute *attr,
 			    const char *buf, size_t count)
 {
 	struct pvpanic_instance *pi = dev_get_drvdata(dev);
@@ -65,8 +64,7 @@ static struct attribute *pvpanic_pci_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(pvpanic_pci_dev);
 
-static int pvpanic_pci_probe(struct pci_dev *pdev,
-			     const struct pci_device_id *ent)
+static int pvpanic_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct pvpanic_instance *pi;
 	void __iomem *base;
diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index 254d35efb0b7..c9b5a66697ea 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -23,7 +23,7 @@
 #include "pvpanic.h"
 
 MODULE_AUTHOR("Mihai Carabas <mihai.carabas@oracle.com>");
-MODULE_DESCRIPTION("pvpanic device driver ");
+MODULE_DESCRIPTION("pvpanic device driver");
 MODULE_LICENSE("GPL");
 
 static struct list_head pvpanic_list;
@@ -43,8 +43,7 @@ pvpanic_send_event(unsigned int event)
 }
 
 static int
-pvpanic_panic_notify(struct notifier_block *nb, unsigned long code,
-		     void *unused)
+pvpanic_panic_notify(struct notifier_block *nb, unsigned long code, void *unused)
 {
 	unsigned int event = PVPANIC_PANICKED;
 
@@ -94,8 +93,7 @@ static int pvpanic_init(void)
 	INIT_LIST_HEAD(&pvpanic_list);
 	spin_lock_init(&pvpanic_lock);
 
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &pvpanic_panic_nb);
+	atomic_notifier_chain_register(&panic_notifier_list, &pvpanic_panic_nb);
 
 	return 0;
 }
@@ -103,8 +101,7 @@ module_init(pvpanic_init);
 
 static void pvpanic_exit(void)
 {
-	atomic_notifier_chain_unregister(&panic_notifier_list,
-					 &pvpanic_panic_nb);
+	atomic_notifier_chain_unregister(&panic_notifier_list, &pvpanic_panic_nb);
 
 }
 module_exit(pvpanic_exit);
-- 
2.33.0

