Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278163093D1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhA3J6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:58:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:24255 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232307AbhA3DAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 22:00:31 -0500
IronPort-SDR: IJS3KlcaWGJ4dvthlnWhtamInDR2ae6WeGVu1B/nd+Il3Ik+KxMRduE6LWmZKZVvjlaBED8Bkr
 kq97/WgowLBg==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="159675281"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="159675281"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:30 -0800
IronPort-SDR: QnkvlGuAWW2w/zSRJyjGhG/ZwnVl8gjpsJhFf6ABWfQ4kZ+L0vFkcKvgDXCiL+04pVib5ydGuM
 CXwSEA2WmCfQ==
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="389569472"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 18:21:30 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 173716368;
        Fri, 29 Jan 2021 18:21:30 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 08E90363688; Fri, 29 Jan 2021 18:21:30 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Srikanth Thokala <srikanth.thokala@intel.com>
Subject: [PATCH v4 15/34] misc: xlink-pcie: Add XLink API interface
Date:   Fri, 29 Jan 2021 18:21:05 -0800
Message-Id: <20210130022124.65083-51-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210130022124.65083-1-mgross@linux.intel.com>
References: <20210130022124.65083-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Provide interface for XLink layer to interact with XLink PCIe transport
layer on both local host and remote host.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 drivers/misc/xlink-pcie/common/interface.c   | 107 +++++++++++++++++++
 drivers/misc/xlink-pcie/local_host/Makefile  |   1 +
 drivers/misc/xlink-pcie/remote_host/Makefile |   1 +
 3 files changed, 109 insertions(+)
 create mode 100644 drivers/misc/xlink-pcie/common/interface.c

diff --git a/drivers/misc/xlink-pcie/common/interface.c b/drivers/misc/xlink-pcie/common/interface.c
new file mode 100644
index 000000000000..fcc69a940a4c
--- /dev/null
+++ b/drivers/misc/xlink-pcie/common/interface.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel Keem Bay XLink PCIe Driver
+ *
+ * Copyright (C) 2021 Intel Corporation
+ */
+
+#include <linux/xlink_drv_inf.h>
+
+#include "core.h"
+#include "xpcie.h"
+
+/* Define xpcie driver interface API */
+int xlink_pcie_get_device_list(u32 *sw_device_id_list, u32 *num_devices)
+{
+	if (!sw_device_id_list || !num_devices)
+		return -EINVAL;
+
+	*num_devices = intel_xpcie_get_device_num(sw_device_id_list);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xlink_pcie_get_device_list);
+
+int xlink_pcie_get_device_name(u32 sw_device_id, char *device_name,
+			       size_t name_size)
+{
+	if (!device_name)
+		return -EINVAL;
+
+	return intel_xpcie_get_device_name_by_id(sw_device_id,
+						 device_name, name_size);
+}
+EXPORT_SYMBOL_GPL(xlink_pcie_get_device_name);
+
+int xlink_pcie_get_device_status(u32 sw_device_id, u32 *device_status)
+{
+	u32 status;
+	int rc;
+
+	if (!device_status)
+		return -EINVAL;
+
+	rc = intel_xpcie_get_device_status_by_id(sw_device_id, &status);
+	if (rc)
+		return rc;
+
+	switch (status) {
+	case XPCIE_STATUS_READY:
+	case XPCIE_STATUS_RUN:
+		*device_status = _XLINK_DEV_READY;
+		break;
+	case XPCIE_STATUS_ERROR:
+		*device_status = _XLINK_DEV_ERROR;
+		break;
+	case XPCIE_STATUS_RECOVERY:
+		*device_status = _XLINK_DEV_RECOVERY;
+		break;
+	case XPCIE_STATUS_OFF:
+		*device_status = _XLINK_DEV_OFF;
+		break;
+	default:
+		*device_status = _XLINK_DEV_BUSY;
+		break;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xlink_pcie_get_device_status);
+
+int xlink_pcie_boot_device(u32 sw_device_id, const char *binary_name)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xlink_pcie_boot_device);
+
+int xlink_pcie_connect(u32 sw_device_id)
+{
+	return intel_xpcie_pci_connect_device(sw_device_id);
+}
+EXPORT_SYMBOL_GPL(xlink_pcie_connect);
+
+int xlink_pcie_read(u32 sw_device_id, void *data, size_t *const size,
+		    u32 timeout)
+{
+	if (!data || !size)
+		return -EINVAL;
+
+	return intel_xpcie_pci_read(sw_device_id, data, size, timeout);
+}
+EXPORT_SYMBOL_GPL(xlink_pcie_read);
+
+int xlink_pcie_write(u32 sw_device_id, void *data, size_t *const size,
+		     u32 timeout)
+{
+	if (!data || !size)
+		return -EINVAL;
+
+	return intel_xpcie_pci_write(sw_device_id, data, size, timeout);
+}
+EXPORT_SYMBOL_GPL(xlink_pcie_write);
+
+int xlink_pcie_reset_device(u32 sw_device_id)
+{
+	return intel_xpcie_pci_reset_device(sw_device_id);
+}
+EXPORT_SYMBOL_GPL(xlink_pcie_reset_device);
diff --git a/drivers/misc/xlink-pcie/local_host/Makefile b/drivers/misc/xlink-pcie/local_host/Makefile
index 65df94c7e860..16bb1e7345ac 100644
--- a/drivers/misc/xlink-pcie/local_host/Makefile
+++ b/drivers/misc/xlink-pcie/local_host/Makefile
@@ -3,3 +3,4 @@ mxlk_ep-objs := epf.o
 mxlk_ep-objs += dma.o
 mxlk_ep-objs += core.o
 mxlk_ep-objs += ../common/util.o
+mxlk_ep-objs += ../common/interface.o
diff --git a/drivers/misc/xlink-pcie/remote_host/Makefile b/drivers/misc/xlink-pcie/remote_host/Makefile
index e8074dbb1161..088e121ad46e 100644
--- a/drivers/misc/xlink-pcie/remote_host/Makefile
+++ b/drivers/misc/xlink-pcie/remote_host/Makefile
@@ -3,3 +3,4 @@ mxlk-objs := main.o
 mxlk-objs += pci.o
 mxlk-objs += core.o
 mxlk-objs += ../common/util.o
+mxlk-objs += ../common/interface.o
-- 
2.17.1

