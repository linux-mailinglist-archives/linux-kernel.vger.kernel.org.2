Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71AE93C661C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 00:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbhGLWMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 18:12:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:10020 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhGLWMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 18:12:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="197335000"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="197335000"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:09:59 -0700
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; 
   d="scan'208";a="464392194"
Received: from jzloch-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.136.11])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2021 15:09:54 -0700
From:   Iwona Winiarska <iwona.winiarska@intel.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     x86@kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Iwona Winiarska <iwona.winiarska@intel.com>
Subject: [PATCH 08/14] peci: Add device detection
Date:   Tue, 13 Jul 2021 00:04:41 +0200
Message-Id: <20210712220447.957418-9-iwona.winiarska@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210712220447.957418-1-iwona.winiarska@intel.com>
References: <20210712220447.957418-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since PECI devices are discoverable, we can dynamically detect devices
that are actually available in the system.

This change complements the earlier implementation by rescanning PECI
bus to detect available devices. For this purpose, it also introduces the
minimal API for PECI requests.

Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/peci/Makefile   |   2 +-
 drivers/peci/core.c     |  13 ++++-
 drivers/peci/device.c   | 111 ++++++++++++++++++++++++++++++++++++++++
 drivers/peci/internal.h |  15 ++++++
 drivers/peci/request.c  |  74 +++++++++++++++++++++++++++
 drivers/peci/sysfs.c    |  34 ++++++++++++
 6 files changed, 246 insertions(+), 3 deletions(-)
 create mode 100644 drivers/peci/device.c
 create mode 100644 drivers/peci/request.c

diff --git a/drivers/peci/Makefile b/drivers/peci/Makefile
index 621a993e306a..917f689e147a 100644
--- a/drivers/peci/Makefile
+++ b/drivers/peci/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 # Core functionality
-peci-y := core.o sysfs.o
+peci-y := core.o request.o device.o sysfs.o
 obj-$(CONFIG_PECI) += peci.o
 
 # Hardware specific bus drivers
diff --git a/drivers/peci/core.c b/drivers/peci/core.c
index 0ad00110459d..ae7a9572cdf3 100644
--- a/drivers/peci/core.c
+++ b/drivers/peci/core.c
@@ -31,7 +31,15 @@ struct device_type peci_controller_type = {
 
 int peci_controller_scan_devices(struct peci_controller *controller)
 {
-	/* Just a stub, no support for actual devices yet */
+	int ret;
+	u8 addr;
+
+	for (addr = PECI_BASE_ADDR; addr < PECI_BASE_ADDR + PECI_DEVICE_NUM_MAX; addr++) {
+		ret = peci_device_create(controller, addr);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -106,7 +114,8 @@ EXPORT_SYMBOL_NS_GPL(peci_controller_add, PECI);
 
 static int _unregister(struct device *dev, void *dummy)
 {
-	/* Just a stub, no support for actual devices yet */
+	peci_device_destroy(to_peci_device(dev));
+
 	return 0;
 }
 
diff --git a/drivers/peci/device.c b/drivers/peci/device.c
new file mode 100644
index 000000000000..1124862211e2
--- /dev/null
+++ b/drivers/peci/device.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2018-2021 Intel Corporation
+
+#include <linux/peci.h>
+#include <linux/slab.h>
+
+#include "internal.h"
+
+static int peci_detect(struct peci_controller *controller, u8 addr)
+{
+	struct peci_request *req;
+	int ret;
+
+	req = peci_request_alloc(NULL, 0, 0);
+	if (!req)
+		return -ENOMEM;
+
+	mutex_lock(&controller->bus_lock);
+	ret = controller->xfer(controller, addr, req);
+	mutex_unlock(&controller->bus_lock);
+
+	peci_request_free(req);
+
+	return ret;
+}
+
+static bool peci_addr_valid(u8 addr)
+{
+	return addr >= PECI_BASE_ADDR && addr < PECI_BASE_ADDR + PECI_DEVICE_NUM_MAX;
+}
+
+static int peci_dev_exists(struct device *dev, void *data)
+{
+	struct peci_device *device = to_peci_device(dev);
+	u8 *addr = data;
+
+	if (device->addr == *addr)
+		return -EBUSY;
+
+	return 0;
+}
+
+int peci_device_create(struct peci_controller *controller, u8 addr)
+{
+	struct peci_device *device;
+	int ret;
+
+	if (WARN_ON(!peci_addr_valid(addr)))
+		return -EINVAL;
+
+	/* Check if we have already detected this device before. */
+	ret = device_for_each_child(&controller->dev, &addr, peci_dev_exists);
+	if (ret)
+		return 0;
+
+	ret = peci_detect(controller, addr);
+	if (ret) {
+		/*
+		 * Device not present or host state doesn't allow successful
+		 * detection at this time.
+		 */
+		if (ret == -EIO || ret == -ETIMEDOUT)
+			return 0;
+
+		return ret;
+	}
+
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	if (!device)
+		return -ENOMEM;
+
+	device->controller = controller;
+	device->addr = addr;
+	device->dev.parent = &device->controller->dev;
+	device->dev.bus = &peci_bus_type;
+	device->dev.type = &peci_device_type;
+
+	ret = dev_set_name(&device->dev, "%d-%02x", controller->id, device->addr);
+	if (ret)
+		goto err_free;
+
+	ret = device_register(&device->dev);
+	if (ret)
+		goto err_put;
+
+	return 0;
+
+err_put:
+	put_device(&device->dev);
+err_free:
+	kfree(device);
+
+	return ret;
+}
+
+void peci_device_destroy(struct peci_device *device)
+{
+	device_unregister(&device->dev);
+}
+
+static void peci_device_release(struct device *dev)
+{
+	struct peci_device *device = to_peci_device(dev);
+
+	kfree(device);
+}
+
+struct device_type peci_device_type = {
+	.groups		= peci_device_groups,
+	.release	= peci_device_release,
+};
diff --git a/drivers/peci/internal.h b/drivers/peci/internal.h
index 80c61bcdfc6b..6b139adaf6b8 100644
--- a/drivers/peci/internal.h
+++ b/drivers/peci/internal.h
@@ -9,6 +9,21 @@
 
 struct peci_controller;
 struct attribute_group;
+struct peci_device;
+struct peci_request;
+
+/* PECI CPU address range 0x30-0x37 */
+#define PECI_BASE_ADDR		0x30
+#define PECI_DEVICE_NUM_MAX		8
+
+struct peci_request *peci_request_alloc(struct peci_device *device, u8 tx_len, u8 rx_len);
+void peci_request_free(struct peci_request *req);
+
+extern struct device_type peci_device_type;
+extern const struct attribute_group *peci_device_groups[];
+
+int peci_device_create(struct peci_controller *controller, u8 addr);
+void peci_device_destroy(struct peci_device *device);
 
 extern struct bus_type peci_bus_type;
 extern const struct attribute_group *peci_bus_groups[];
diff --git a/drivers/peci/request.c b/drivers/peci/request.c
new file mode 100644
index 000000000000..78cee51dfae1
--- /dev/null
+++ b/drivers/peci/request.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (c) 2021 Intel Corporation
+
+#include <linux/export.h>
+#include <linux/peci.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "internal.h"
+
+/**
+ * peci_request_alloc() - allocate &struct peci_request with buffers with given lengths
+ * @device: PECI device to which request is going to be sent
+ * @tx_len: requested TX buffer length
+ * @rx_len: requested RX buffer length
+ *
+ * Return: A pointer to a newly allocated &struct peci_request on success or NULL otherwise.
+ */
+struct peci_request *peci_request_alloc(struct peci_device *device, u8 tx_len, u8 rx_len)
+{
+	struct peci_request *req;
+	u8 *tx_buf, *rx_buf;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return NULL;
+
+	req->device = device;
+
+	/*
+	 * PECI controllers that we are using now don't support DMA, this
+	 * should be converted to DMA API once support for controllers that do
+	 * allow it is added to avoid an extra copy.
+	 */
+	if (tx_len) {
+		tx_buf = kzalloc(tx_len, GFP_KERNEL);
+		if (!tx_buf)
+			goto err_free_req;
+
+		req->tx.buf = tx_buf;
+		req->tx.len = tx_len;
+	}
+
+	if (rx_len) {
+		rx_buf = kzalloc(rx_len, GFP_KERNEL);
+		if (!rx_buf)
+			goto err_free_tx;
+
+		req->rx.buf = rx_buf;
+		req->rx.len = rx_len;
+	}
+
+	return req;
+
+err_free_tx:
+	kfree(req->tx.buf);
+err_free_req:
+	kfree(req);
+
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(peci_request_alloc, PECI);
+
+/**
+ * peci_request_free() - free peci_request
+ * @req: the PECI request to be freed
+ */
+void peci_request_free(struct peci_request *req)
+{
+	kfree(req->rx.buf);
+	kfree(req->tx.buf);
+	kfree(req);
+}
+EXPORT_SYMBOL_NS_GPL(peci_request_free, PECI);
diff --git a/drivers/peci/sysfs.c b/drivers/peci/sysfs.c
index 36c5e2a18a92..db9ef05776e3 100644
--- a/drivers/peci/sysfs.c
+++ b/drivers/peci/sysfs.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 // Copyright (c) 2021 Intel Corporation
 
+#include <linux/device.h>
+#include <linux/kernel.h>
 #include <linux/peci.h>
 
 #include "internal.h"
@@ -46,3 +48,35 @@ const struct attribute_group *peci_bus_groups[] = {
 	&peci_bus_group,
 	NULL
 };
+
+static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct peci_device *device = to_peci_device(dev);
+	bool res;
+	int ret;
+
+	ret = kstrtobool(buf, &res);
+	if (ret)
+		return ret;
+
+	if (res && device_remove_file_self(dev, attr))
+		peci_device_destroy(device);
+
+	return count;
+}
+static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0200, NULL, remove_store);
+
+static struct attribute *peci_device_attrs[] = {
+	&dev_attr_remove.attr,
+	NULL
+};
+
+static const struct attribute_group peci_device_group = {
+	.attrs = peci_device_attrs,
+};
+
+const struct attribute_group *peci_device_groups[] = {
+	&peci_device_group,
+	NULL
+};
-- 
2.31.1

