Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13A4362ED5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbhDQJVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:38680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235928AbhDQJVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:21:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50F246101E
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618651258;
        bh=zCgxhikp+2d8xInkNz4yJtbex+YRg33ELU6seVv8Rg8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BYr1DwbyYwx10xBzaqeCQNKkU/R6yv3ajcRM7lpJ0+VUMSPqeDwG14Rkg+mLudONu
         WE29fBfpq81DHuGfUEYDjWBryvE+q6N/sg+Nwj32kSsBWA3OiGkQMtkQQzRGyaxwT4
         L6IxzdpBSjyApfMHPUfE0BT/095SEe9Yj1WNoT9zwHyeLZXnQsSk+T/gVEKYXFLvuH
         9KuGdBJnmIFHj8WYJbMQ5OPKvH5oac+PDknEKkTxdImcu6cpsmWkZ4pkWSENwMY3bJ
         z7ONGgVJ3ebLRdDLtmCOxL5RQrQbWI6bmBNJkEP6gnbgX4EeTmNRjg9Pt/gPDYxilb
         VfK7zNdVUNBjA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] habanalabs: ignore f/w status error
Date:   Sat, 17 Apr 2021 12:20:52 +0300
Message-Id: <20210417092052.22842-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417092052.22842-1-ogabbay@kernel.org>
References: <20210417092052.22842-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case firmware has a bug and erroneously reports a status error
(e.g. device unusable) during boot, allow the user to tell the driver
to continue the boot regardless of the error status.

This will be done via kernel parameter which exposes a mask. The
user that loads the driver can decide exactly which status error to
ignore and which to take into account. The bitmask is according to
defines in hl_boot_if.h

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c    | 3 ++-
 drivers/misc/habanalabs/common/habanalabs.h     | 7 +++++++
 drivers/misc/habanalabs/common/habanalabs_drv.c | 7 +++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 377a7ca886fe..0713b2c12d54 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -400,7 +400,8 @@ static int fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
 		err_exists = true;
 	}
 
-	if (err_exists)
+	if (err_exists && ((err_val & ~CPU_BOOT_ERR0_ENABLED) &
+				lower_32_bits(hdev->boot_error_status_mask)))
 		return -EIO;
 
 	return 0;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 91291a8e201e..6579f8767abd 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -1962,6 +1962,12 @@ struct hl_mmu_funcs {
  * @clock_gating_mask: is clock gating enabled. bitmask that represents the
  *                     different engines. See debugfs-driver-habanalabs for
  *                     details.
+ * @boot_error_status_mask: contains a mask of the device boot error status.
+ *                          Each bit represents a different error, according to
+ *                          the defines in hl_boot_if.h. If the bit is cleared,
+ *                          the error will be ignored by the driver during
+ *                          device initialization. Mainly used to debug and
+ *                          workaround firmware bugs
  * @in_reset: is device in reset flow.
  * @curr_pll_profile: current PLL profile.
  * @card_type: Various ASICs have several card types. This indicates the card
@@ -2077,6 +2083,7 @@ struct hl_device {
 	u64				timeout_jiffies;
 	u64				max_power;
 	u64				clock_gating_mask;
+	u64				boot_error_status_mask;
 	atomic_t			in_reset;
 	enum hl_pll_frequency		curr_pll_profile;
 	enum cpucp_card_types		card_type;
diff --git a/drivers/misc/habanalabs/common/habanalabs_drv.c b/drivers/misc/habanalabs/common/habanalabs_drv.c
index 7135f1e03864..64d1530db985 100644
--- a/drivers/misc/habanalabs/common/habanalabs_drv.c
+++ b/drivers/misc/habanalabs/common/habanalabs_drv.c
@@ -30,6 +30,7 @@ static DEFINE_MUTEX(hl_devs_idr_lock);
 static int timeout_locked = 30;
 static int reset_on_lockup = 1;
 static int memory_scrub = 1;
+static ulong boot_error_status_mask = ULONG_MAX;
 
 module_param(timeout_locked, int, 0444);
 MODULE_PARM_DESC(timeout_locked,
@@ -43,6 +44,10 @@ module_param(memory_scrub, int, 0444);
 MODULE_PARM_DESC(memory_scrub,
 	"Scrub device memory in various states (0 = no, 1 = yes, default yes)");
 
+module_param(boot_error_status_mask, ulong, 0444);
+MODULE_PARM_DESC(boot_error_status_mask,
+	"Mask of the error status during device CPU boot (If bitX is cleared then error X is masked. Default all 1's)");
+
 #define PCI_VENDOR_ID_HABANALABS	0x1da3
 
 #define PCI_IDS_GOYA			0x0001
@@ -319,6 +324,8 @@ int create_hdev(struct hl_device **dev, struct pci_dev *pdev,
 	hdev->major = hl_major;
 	hdev->reset_on_lockup = reset_on_lockup;
 	hdev->memory_scrub = memory_scrub;
+	hdev->boot_error_status_mask = boot_error_status_mask;
+
 	hdev->pldm = 0;
 
 	set_driver_behavior_per_device(hdev);
-- 
2.25.1

