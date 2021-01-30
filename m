Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBB33092C4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 09:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbhA3I7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 03:59:35 -0500
Received: from mga02.intel.com ([134.134.136.20]:46729 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230036AbhA3FMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 00:12:40 -0500
IronPort-SDR: 5ug/LsJZfeVh6U64LrKcXr3k4wJE1D3jBbFz6CZZ10ijo0Zkz6XHLpsJx3ulIEiVNOaayyILf5
 ePULZXOecMOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="167606755"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="167606755"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:30 -0800
IronPort-SDR: 6x0pjL90H5WGgg3smaPAwPynUI+dO6xTFB8WrmVKZpRG/li+b53cx6Lfjmf0nIX//cN3WwzmIp
 xCi6oJ7yVdnQ==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="389569474"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:30 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 220216365;
        Fri, 29 Jan 2021 18:21:30 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 1125B363653; Fri, 29 Jan 2021 18:21:30 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>
Subject: [PATCH v4 16/34] misc: xlink-pcie: Add asynchronous event notification support for XLink
Date:   Fri, 29 Jan 2021 18:21:06 -0800
Message-Id: <20210130022124.65083-52-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210130022124.65083-1-mgross@linux.intel.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Add support to notify XLink layer upon PCIe link UP/DOWN events

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 drivers/misc/xlink-pcie/common/core.h      |  3 ++
 drivers/misc/xlink-pcie/common/interface.c | 17 ++++++++++
 drivers/misc/xlink-pcie/local_host/core.c  | 11 +++++++
 drivers/misc/xlink-pcie/remote_host/main.c |  3 ++
 drivers/misc/xlink-pcie/remote_host/pci.c  | 36 ++++++++++++++++++++++
 drivers/misc/xlink-pcie/remote_host/pci.h  |  3 ++
 include/linux/xlink_drv_inf.h              | 12 ++++++++
 7 files changed, 85 insertions(+)

diff --git a/drivers/misc/xlink-pcie/common/core.h b/drivers/misc/xlink-pcie/common/core.h
index f43c175b7a48..87b302f87cfd 100644
--- a/drivers/misc/xlink-pcie/common/core.h
+++ b/drivers/misc/xlink-pcie/common/core.h
@@ -239,4 +239,7 @@ int intel_xpcie_pci_connect_device(u32 id);
 int intel_xpcie_pci_read(u32 id, void *data, size_t *size, u32 timeout);
 int intel_xpcie_pci_write(u32 id, void *data, size_t *size, u32 timeout);
 int intel_xpcie_pci_reset_device(u32 id);
+int intel_xpcie_pci_register_device_event(u32 sw_device_id,
+					  xlink_device_event event_notif_fn);
+int intel_xpcie_pci_unregister_device_event(u32 sw_device_id);
 #endif /* XPCIE_CORE_HEADER_ */
diff --git a/drivers/misc/xlink-pcie/common/interface.c b/drivers/misc/xlink-pcie/common/interface.c
index fcc69a940a4c..5d30c27dd18d 100644
--- a/drivers/misc/xlink-pcie/common/interface.c
+++ b/drivers/misc/xlink-pcie/common/interface.c
@@ -105,3 +105,20 @@ int xlink_pcie_reset_device(u32 sw_device_id)
 	return intel_xpcie_pci_reset_device(sw_device_id);
 }
 EXPORT_SYMBOL_GPL(xlink_pcie_reset_device);
+
+int xlink_pcie_register_device_event(u32 sw_device_id,
+				     xlink_device_event event_notif_fn)
+{
+	if (!event_notif_fn)
+		return -EINVAL;
+
+	return intel_xpcie_pci_register_device_event(sw_device_id,
+						     event_notif_fn);
+}
+EXPORT_SYMBOL_GPL(xlink_pcie_register_device_event);
+
+int xlink_pcie_unregister_device_event(u32 sw_device_id)
+{
+	return intel_xpcie_pci_unregister_device_event(sw_device_id);
+}
+EXPORT_SYMBOL_GPL(xlink_pcie_unregister_device_event);
diff --git a/drivers/misc/xlink-pcie/local_host/core.c b/drivers/misc/xlink-pcie/local_host/core.c
index 2c4e29bce7f7..bfb14c18c24c 100644
--- a/drivers/misc/xlink-pcie/local_host/core.c
+++ b/drivers/misc/xlink-pcie/local_host/core.c
@@ -804,3 +804,14 @@ int intel_xpcie_pci_reset_device(u32 id)
 {
 	return 0;
 }
+
+int intel_xpcie_pci_register_device_event(u32 sw_device_id,
+					  xlink_device_event event_notif_fn)
+{
+	return 0;
+}
+
+int intel_xpcie_pci_unregister_device_event(u32 sw_device_id)
+{
+	return 0;
+}
diff --git a/drivers/misc/xlink-pcie/remote_host/main.c b/drivers/misc/xlink-pcie/remote_host/main.c
index ed1a431ed5d4..efc9143a2fac 100644
--- a/drivers/misc/xlink-pcie/remote_host/main.c
+++ b/drivers/misc/xlink-pcie/remote_host/main.c
@@ -53,6 +53,8 @@ static int intel_xpcie_probe(struct pci_dev *pdev,
 	if (new_device)
 		intel_xpcie_list_add_device(xdev);
 
+	intel_xpcie_pci_notify_event(xdev, NOTIFY_DEVICE_CONNECTED);
+
 	return ret;
 }
 
@@ -62,6 +64,7 @@ static void intel_xpcie_remove(struct pci_dev *pdev)
 
 	if (xdev) {
 		intel_xpcie_pci_cleanup(xdev);
+		intel_xpcie_pci_notify_event(xdev, NOTIFY_DEVICE_DISCONNECTED);
 		intel_xpcie_remove_device(xdev);
 	}
 }
diff --git a/drivers/misc/xlink-pcie/remote_host/pci.c b/drivers/misc/xlink-pcie/remote_host/pci.c
index 71cbe779d1bc..6a79782b983e 100644
--- a/drivers/misc/xlink-pcie/remote_host/pci.c
+++ b/drivers/misc/xlink-pcie/remote_host/pci.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/mutex.h>
+#include <linux/pci.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/workqueue.h>
@@ -485,3 +486,38 @@ int intel_xpcie_pci_reset_device(u32 id)
 
 	return intel_xpcie_pci_prepare_dev_reset(xdev, true);
 }
+
+int intel_xpcie_pci_register_device_event(u32 sw_device_id,
+					  xlink_device_event event_notif_fn)
+{
+	struct xpcie_dev *xdev = intel_xpcie_get_device_by_id(sw_device_id);
+
+	if (!xdev)
+		return -ENOMEM;
+
+	xdev->event_fn = event_notif_fn;
+
+	return 0;
+}
+
+int intel_xpcie_pci_unregister_device_event(u32 sw_device_id)
+{
+	struct xpcie_dev *xdev = intel_xpcie_get_device_by_id(sw_device_id);
+
+	if (!xdev)
+		return -ENOMEM;
+
+	xdev->event_fn = NULL;
+
+	return 0;
+}
+
+void intel_xpcie_pci_notify_event(struct xpcie_dev *xdev,
+				  enum xlink_device_event_type event_type)
+{
+	if (event_type >= NUM_EVENT_TYPE)
+		return;
+
+	if (xdev->event_fn)
+		xdev->event_fn(xdev->devid, event_type);
+}
diff --git a/drivers/misc/xlink-pcie/remote_host/pci.h b/drivers/misc/xlink-pcie/remote_host/pci.h
index bd6b01cc58b8..b082bfb73e4f 100644
--- a/drivers/misc/xlink-pcie/remote_host/pci.h
+++ b/drivers/misc/xlink-pcie/remote_host/pci.h
@@ -36,6 +36,7 @@ struct xpcie_dev {
 	irq_handler_t core_irq_callback;
 
 	struct xpcie xpcie;
+	xlink_device_event event_fn;
 };
 
 static inline struct device *xpcie_to_dev(struct xpcie *xpcie)
@@ -58,5 +59,7 @@ struct xpcie_dev *intel_xpcie_create_device(u32 sw_device_id,
 void intel_xpcie_remove_device(struct xpcie_dev *xdev);
 void intel_xpcie_list_add_device(struct xpcie_dev *xdev);
 void intel_xpcie_list_del_device(struct xpcie_dev *xdev);
+void intel_xpcie_pci_notify_event(struct xpcie_dev *xdev,
+				  enum xlink_device_event_type event_type);
 
 #endif /* XPCIE_PCI_HEADER_ */
diff --git a/include/linux/xlink_drv_inf.h b/include/linux/xlink_drv_inf.h
index 8ffbaafecc88..f20f69bd879a 100644
--- a/include/linux/xlink_drv_inf.h
+++ b/include/linux/xlink_drv_inf.h
@@ -42,6 +42,15 @@ enum _xlink_device_status {
 	_XLINK_DEV_READY
 };
 
+enum xlink_device_event_type {
+	NOTIFY_DEVICE_DISCONNECTED,
+	NOTIFY_DEVICE_CONNECTED,
+	NUM_EVENT_TYPE
+};
+
+typedef int (*xlink_device_event)(u32 sw_device_id,
+				  enum xlink_device_event_type event_type);
+
 int xlink_pcie_get_device_list(u32 *sw_device_id_list,
 			       u32 *num_devices);
 int xlink_pcie_get_device_name(u32 sw_device_id, char *device_name,
@@ -55,4 +64,7 @@ int xlink_pcie_read(u32 sw_device_id, void *data, size_t *const size,
 int xlink_pcie_write(u32 sw_device_id, void *data, size_t *const size,
 		     u32 timeout);
 int xlink_pcie_reset_device(u32 sw_device_id);
+int xlink_pcie_register_device_event(u32 sw_device_id,
+				     xlink_device_event event_notif_fn);
+int xlink_pcie_unregister_device_event(u32 sw_device_id);
 #endif
-- 
2.17.1

