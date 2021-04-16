Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC0C361D03
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 12:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbhDPJOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 05:14:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59537 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239914AbhDPJOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 05:14:19 -0400
Received: from 36-229-228-200.dynamic-ip.hinet.net ([36.229.228.200] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1lXKXs-0007Ka-Ec; Fri, 16 Apr 2021 09:13:49 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Prike Liang <Prike.Liang@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] nvme: Favor D3cold for suspend if NVMe device supports it
Date:   Fri, 16 Apr 2021 17:13:44 +0800
Message-Id: <20210416091344.1210803-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On AMD platforms that use s2idle, NVMe timeouts on s2idle resume,
because their SMU FW may cut off NVMe power during sleep.

Unlike Intel platforms where the power resources are generally
controlled by root port, the power resources is controlled by NVMe
device itself on recent AMD platforms:
...
    Scope (\_SB.PCI0.GP24.NVME)
    {
        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
        {
            P0NV
        })
        Name (_PR2, Package (0x01)  // _PR2: Power Resources for D2
        {
            P0NV
        })
        Name (_PR3, Package (0x01)  // _PR3: Power Resources for D3hot
        {
            P0NV
        })
        Method (_PS0, 0, NotSerialized)  // _PS0: Power State 0
        {
        }

        Method (_PS3, 0, NotSerialized)  // _PS3: Power State 3
        {
        }
    }
...
And it's a great indication that the NVMe should use D3cold for sleep
instead of staying at D0.

So use NVME_QUIRK_SIMPLE_SUSPEND if the ACPI counterpart of NVMe device
supports D3cold.

Tested on HP EliteBook 845 G7/G8.

BugLink: https://gitlab.freedesktop.org/drm/amd/-/issues/1230
References: https://lore.kernel.org/linux-nvme/1618458725-17164-1-git-send-email-Prike.Liang@amd.com/
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Prike Liang <Prike.Liang@amd.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
- Typo. It's EliteBook 845, not EliteBook 840.

 drivers/nvme/host/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7249ae74f71f..cc190324a919 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2840,6 +2840,13 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 	acpi_status status;
 	u8 val;
 
+	/*
+	 * If the device itself supports D3cold, use that instead of D0 ASPM +
+	 * NVMe APST.
+	 */
+	if (pci_pr3_present(dev))
+		return true;
+
 	/*
 	 * Look for _DSD property specifying that the storage device on the port
 	 * must use D3 to support deep platform power savings during
-- 
2.30.2

