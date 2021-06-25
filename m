Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1159A3B3C42
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhFYFcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:32:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60300 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbhFYFcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:32:21 -0400
Received: from 1-171-95-206.dynamic-ip.hinet.net ([1.171.95.206] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lwePW-0003qp-A4; Fri, 25 Jun 2021 05:29:50 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Koba Ko <koba.ko@canonical.com>,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "nvme-pci: use simple suspend when a HMB is enabled"
Date:   Fri, 25 Jun 2021 13:29:44 +0800
Message-Id: <20210625052944.4140054-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b97120b15ebd3de51325084136d3b9c3cce656d6.

There are at least two issues introduced by that commit.
Config space becomes inaccessible after s2idle:
[  827.776792] nvme 0000:58:00.0: can't change power state from D3cold to D0 (config space inaccessible)
The NVMe in question is recovered correctly but PCIe ASPM setting is lost as result.

The second one is more severe, the NVMe becomes unreliable and cause the
rootfs unreadable after s2idle.

Since reset DMA is not possible on suspend/resume, revert the commit to
solve the regression.

Cc: Koba Ko <koba.ko@canonical.com>
BugLink: https://bugs.launchpad.net/bugs/1912057
BugLink: https://bugs.launchpad.net/bugs/1927866
Fixes: b97120b15ebd ("nvme-pci: use simple suspend when a HMB is enabled")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/nvme/host/pci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a29b170701fc6..72d2121f82068 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3079,15 +3079,9 @@ static int nvme_suspend(struct device *dev)
 	 * the PCI bus layer to put it into D3 in order to take the PCIe link
 	 * down, so as to allow the platform to achieve its minimum low-power
 	 * state (which may not be possible if the link is up).
-	 *
-	 * If a host memory buffer is enabled, shut down the device as the NVMe
-	 * specification allows the device to access the host memory buffer in
-	 * host DRAM from all power states, but hosts will fail access to DRAM
-	 * during S3.
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
-	    ndev->nr_host_mem_descs ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
 		return nvme_disable_prepare_reset(ndev, true);
 
-- 
2.31.1

