Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619293A8AEA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhFOVTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:19:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:32191 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231156AbhFOVTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:19:03 -0400
IronPort-SDR: Tv4ZQaryuCdpYDJyWJxP0KUTR2J59khH7uI5m0f4FW+aqJq+nBNkJfymx8iRd6TJz4bmdsP9AC
 sESknKY8CWvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="193188986"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="193188986"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 14:16:40 -0700
IronPort-SDR: cqVNFYMjmd9FXxsmjh90AKaSDg31230ZTVhOuRApFpruwPfcKwPSnpBNbx8LTXjfURgmtrUN2p
 eSDo++ufTwHQ==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="637240743"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 14:16:38 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tamar Mashiah <tamar.mashiah@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/2] mei: fix kdoc in the driver
Date:   Wed, 16 Jun 2021 00:15:56 +0300
Message-Id: <20210615211557.248292-1-tomas.winkler@intel.com>
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
 drivers/misc/mei/bus-fixup.c | 2 +-
 drivers/misc/mei/client.c    | 6 +++---
 drivers/misc/mei/hbm.c       | 2 +-
 drivers/misc/mei/hw-me.c     | 4 ++--
 drivers/misc/mei/main.c      | 2 +-
 drivers/misc/mei/pci-txe.c   | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

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
-- 
2.31.1

