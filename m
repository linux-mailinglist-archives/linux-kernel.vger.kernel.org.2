Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21633AF644
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 21:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbhFUTlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 15:41:10 -0400
Received: from mga17.intel.com ([192.55.52.151]:62776 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230076AbhFUTlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 15:41:08 -0400
IronPort-SDR: J0yP4axgUtG/6f9sn7hn6VVRNmjU1Dcv6G7aSHGiToMN51KvJEbqWRn/3IYQtwG4EZs2lepkgY
 C+V5NKgoBw7g==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="187299323"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="187299323"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 12:38:54 -0700
IronPort-SDR: cfTZCc6nTDGaZ5HbCrgsspZR5BZokevEXKTNkvq+nlCC2wcJaQUYO7PIs/QqHTHd9YVO/yHoAr
 UelEUgvDZFgQ==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="486617908"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 12:38:51 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tamar Mashiah <tamar.mashiah@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next v2 1/2] mei: fix kdoc in the driver
Date:   Mon, 21 Jun 2021 22:37:55 +0300
Message-Id: <20210621193756.134027-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tamar Mashiah <tamar.mashiah@intel.com>

Over time the functions were renamed,
but this was not always reflected in kdoc, fix that.

Signed-off-by: Tamar Mashiah <tamar.mashiah@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---

V2:
1. Fix kdoc for mei_ext_next()
2. Fix kdoc also in mei_wdt.c

 drivers/misc/mei/bus-fixup.c | 2 +-
 drivers/misc/mei/client.c    | 6 +++---
 drivers/misc/mei/hbm.c       | 2 +-
 drivers/misc/mei/hw-me.c     | 4 ++--
 drivers/misc/mei/hw.h        | 2 +-
 drivers/misc/mei/main.c      | 2 +-
 drivers/misc/mei/pci-txe.c   | 2 +-
 drivers/watchdog/mei_wdt.c   | 4 ++--
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index d8e760b11ae3..67844089db21 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -498,7 +498,7 @@ static struct mei_fixup {
 };
 
 /**
- * mei_cldev_fixup - run fixup handlers
+ * mei_cl_bus_dev_fixup - run fixup handlers
  *
  * @cldev: me client device
  */
diff --git a/drivers/misc/mei/client.c b/drivers/misc/mei/client.c
index 2cc370adb238..18e49479d8b0 100644
--- a/drivers/misc/mei/client.c
+++ b/drivers/misc/mei/client.c
@@ -326,7 +326,7 @@ void mei_io_cb_free(struct mei_cl_cb *cb)
 }
 
 /**
- * mei_tx_cb_queue - queue tx callback
+ * mei_tx_cb_enqueue - queue tx callback
  *
  * Locking: called under "dev->device_lock" lock
  *
@@ -2250,7 +2250,7 @@ static void mei_cl_dma_free(struct mei_cl *cl)
 }
 
 /**
- * mei_cl_alloc_and_map - send client dma map request
+ * mei_cl_dma_alloc_and_map - send client dma map request
  *
  * @cl: host client
  * @fp: pointer to file structure
@@ -2349,7 +2349,7 @@ int mei_cl_dma_alloc_and_map(struct mei_cl *cl, const struct file *fp,
 }
 
 /**
- * mei_cl_unmap_and_free - send client dma unmap request
+ * mei_cl_dma_unmap - send client dma unmap request
  *
  * @cl: host client
  * @fp: pointer to file structure
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index d0277c7fed10..99b5c1ecc444 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -853,7 +853,7 @@ static int mei_hbm_add_single_tx_flow_ctrl_creds(struct mei_device *dev,
 }
 
 /**
- * mei_hbm_cl_flow_control_res - flow control response from me
+ * mei_hbm_cl_tx_flow_ctrl_creds_res - flow control response from me
  *
  * @dev: the device structure
  * @fctrl: flow control response bus message
diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
index cda0829ac589..d3a6c0728645 100644
--- a/drivers/misc/mei/hw-me.c
+++ b/drivers/misc/mei/hw-me.c
@@ -1380,7 +1380,7 @@ static bool mei_me_fw_type_nm(const struct pci_dev *pdev)
 	.quirk_probe = mei_me_fw_type_nm
 
 /**
- * mei_me_fw_sku_sps_4() - check for sps 4.0 sku
+ * mei_me_fw_type_sps_4() - check for sps 4.0 sku
  *
  * Read ME FW Status register to check for SPS Firmware.
  * The SPS FW is only signaled in the PCI function 0.
@@ -1405,7 +1405,7 @@ static bool mei_me_fw_type_sps_4(const struct pci_dev *pdev)
 	.quirk_probe = mei_me_fw_type_sps_4
 
 /**
- * mei_me_fw_sku_sps() - check for sps sku
+ * mei_me_fw_type_sps() - check for sps sku
  *
  * Read ME FW Status register to check for SPS Firmware.
  * The SPS FW is only signaled in pci function 0
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index b10606550613..47ef2429a4bc 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -284,7 +284,7 @@ static inline bool mei_ext_last(struct mei_ext_meta_hdr *meta,
 }
 
 /**
- *mei_ext_next - following extended header on the TLV list
+ * mei_ext_next - following extended header on the TLV list
  *
  * @ext: current extend header
  *
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 9001c45f6fc4..786f7c8f7f61 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1102,7 +1102,7 @@ static ssize_t dev_state_show(struct device *device,
 static DEVICE_ATTR_RO(dev_state);
 
 /**
- * dev_set_devstate: set to new device state and notify sysfs file.
+ * mei_set_devstate: set to new device state and notify sysfs file.
  *
  * @dev: mei_device
  * @state: new device state
diff --git a/drivers/misc/mei/pci-txe.c b/drivers/misc/mei/pci-txe.c
index 4bf26ce61044..aec0483b8e72 100644
--- a/drivers/misc/mei/pci-txe.c
+++ b/drivers/misc/mei/pci-txe.c
@@ -156,7 +156,7 @@ static int mei_txe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 }
 
 /**
- * mei_txe_remove - Device Shutdown Routine
+ * mei_txe_shutdown- Device Shutdown Routine
  *
  * @pdev: PCI device structure
  *
diff --git a/drivers/watchdog/mei_wdt.c b/drivers/watchdog/mei_wdt.c
index e023d7d90d66..c8ac36135e28 100644
--- a/drivers/watchdog/mei_wdt.c
+++ b/drivers/watchdog/mei_wdt.c
@@ -121,7 +121,7 @@ struct mei_mc_hdr {
 };
 
 /**
- * struct mei_wdt_start_request watchdog start/ping
+ * struct mei_wdt_start_request - watchdog start/ping
  *
  * @hdr: Management Control Command Header
  * @timeout: timeout value
@@ -134,7 +134,7 @@ struct mei_wdt_start_request {
 } __packed;
 
 /**
- * struct mei_wdt_start_response watchdog start/ping response
+ * struct mei_wdt_start_response - watchdog start/ping response
  *
  * @hdr: Management Control Command Header
  * @status: operation status
-- 
2.31.1

