Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B74311DE7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 15:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhBFOpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 09:45:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:38620 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230247AbhBFOot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 09:44:49 -0500
IronPort-SDR: qx7oWrw87hjsGDlUqbAtsR389kewQtkwqObvyDeg4LhzlIGymv5ACPIioVAnH0HpqmD/2W/xUr
 tIDzOIKi4qRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="200566044"
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="200566044"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:43:47 -0800
IronPort-SDR: gA45uT67lxOzE4s5fSMLrQzbrFN0ln6BpLAvCjxo24mlsuHHWUzTvgOB9SPBceQ7lR6b6+W3yU
 ZZAlPK9QS4Vg==
X-IronPort-AV: E=Sophos;i="5.81,158,1610438400"; 
   d="scan'208";a="394360228"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 06:43:45 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 6/6] mei: bus: add client dma interface
Date:   Sat,  6 Feb 2021 16:43:25 +0200
Message-Id: <20210206144325.25682-6-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210206144325.25682-1-tomas.winkler@intel.com>
References: <20210206144325.25682-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Expose the client dma mapping via mei client
bus interface.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus.c     | 46 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/mei/hw.h      |  5 +++++
 include/linux/mei_cl_bus.h |  3 +++
 3 files changed, 54 insertions(+)

diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index 34fb5e541fe5..d430710a5fe5 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -636,6 +636,52 @@ static void mei_cl_bus_vtag_free(struct mei_cl_device *cldev)
 	kfree(cl_vtag);
 }
 
+void *mei_cldev_dma_map(struct mei_cl_device *cldev, u8 buffer_id, size_t size)
+{
+	struct mei_device *bus;
+	struct mei_cl *cl;
+	int ret;
+
+	if (!cldev || !buffer_id || !size)
+		return ERR_PTR(-EINVAL);
+
+	if (!IS_ALIGNED(size, MEI_FW_PAGE_SIZE)) {
+		dev_err(&cldev->dev, "Map size should be aligned to %lu\n",
+			MEI_FW_PAGE_SIZE);
+		return ERR_PTR(-EINVAL);
+	}
+
+	cl = cldev->cl;
+	bus = cldev->bus;
+
+	mutex_lock(&bus->device_lock);
+	ret = mei_cl_dma_alloc_and_map(cl, NULL, buffer_id, size);
+	mutex_unlock(&bus->device_lock);
+	if (ret)
+		return ERR_PTR(ret);
+	return cl->dma.vaddr;
+}
+EXPORT_SYMBOL_GPL(mei_cldev_dma_map);
+
+int mei_cldev_dma_unmap(struct mei_cl_device *cldev)
+{
+	struct mei_device *bus;
+	struct mei_cl *cl;
+	int ret;
+
+	if (!cldev)
+		return -EINVAL;
+
+	cl = cldev->cl;
+	bus = cldev->bus;
+
+	mutex_lock(&bus->device_lock);
+	ret = mei_cl_dma_unmap(cl, NULL);
+	mutex_unlock(&bus->device_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mei_cldev_dma_unmap);
+
 /**
  * mei_cldev_enable - enable me client device
  *     create connection with me client
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index b10606550613..bc240b88abf1 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -22,6 +22,11 @@
 #define MEI_D0I3_TIMEOUT            5  /* D0i3 set/unset max response time */
 #define MEI_HBM_TIMEOUT             1  /* 1 second */
 
+/*
+ * FW page size for DMA allocations
+ */
+#define MEI_FW_PAGE_SIZE 4096UL
+
 /*
  * MEI Version
  */
diff --git a/include/linux/mei_cl_bus.h b/include/linux/mei_cl_bus.h
index 959ad7d850b4..53801eacfaef 100644
--- a/include/linux/mei_cl_bus.h
+++ b/include/linux/mei_cl_bus.h
@@ -116,4 +116,7 @@ int mei_cldev_enable(struct mei_cl_device *cldev);
 int mei_cldev_disable(struct mei_cl_device *cldev);
 bool mei_cldev_enabled(struct mei_cl_device *cldev);
 
+void *mei_cldev_dma_map(struct mei_cl_device *cldev, u8 buffer_id, size_t size);
+int mei_cldev_dma_unmap(struct mei_cl_device *cldev);
+
 #endif /* _LINUX_MEI_CL_BUS_H */
-- 
2.26.2

