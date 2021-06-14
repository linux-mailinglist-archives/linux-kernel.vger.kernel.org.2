Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E333A6716
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 14:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhFNMxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 08:53:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:44052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233746AbhFNMxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:53:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E88FF613DE;
        Mon, 14 Jun 2021 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623675068;
        bh=bbGBHQWynMHPkFkaOP4o3kanwtfOqFqUxl7IcwqzxGs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FTBHgrczwE07NG1XkXkJVzly+GAqJRARjEZfnS9jY2/2G8NC678DNukzbtpMZS2DS
         RnAlKBfzuME057dhft5bkU7Er1f0+aWqUrouDKlLH43zWKCgrSrJ5wqawQfIpjaDQB
         QuwyveCGXMrBYzfMPP3pJrWBv5kml35WwYNE+8S3BP67GVkZ+9jELYX7g5+cneQKrX
         23lE1cVjv+48k+VGL2udn3/z+GczNAdJlXAT52H/xO0LbKkCyVvMAyohmNsSn73HqR
         WYbrq5Clb60TSymBgGiAQO5Tj1EzwHTzmPGnswTafF04d0ELMFd7miJiHBFTf7LTyA
         oG1HyDx5GjZMg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 3/9] habanalabs: set rc as 'valid' in case of intentional func exit
Date:   Mon, 14 Jun 2021 15:50:54 +0300
Message-Id: <20210614125100.17627-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614125100.17627-1-ogabbay@kernel.org>
References: <20210614125100.17627-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

fix the following smatch warnings:
hl_fw_static_init_cpu() warn: missing error code 'rc'

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c      | 5 +++--
 drivers/misc/habanalabs/common/firmware_if.c | 5 ++++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index cbdf75b24cb4..e56f5170e338 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1360,8 +1360,9 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	}
 
 	/*
-	 * From this point, in case of an error, add char devices and create
-	 * sysfs nodes as part of the error flow, to allow debugging.
+	 * From this point, override rc (=0) in case of an error to allow
+	 * debugging (by adding char devices and create sysfs nodes as part of
+	 * the error flow).
 	 */
 	add_cdev_sysfs_on_err = true;
 
diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index d5d0db7fd6ef..ce87053d4fde 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -2393,11 +2393,14 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 
 	if (!(hdev->fw_components & FW_TYPE_LINUX)) {
 		dev_info(hdev->dev, "Skip loading Linux F/W\n");
+		rc = 0;
 		goto out;
 	}
 
-	if (status == CPU_BOOT_STATUS_SRAM_AVAIL)
+	if (status == CPU_BOOT_STATUS_SRAM_AVAIL) {
+		rc = 0;
 		goto out;
+	}
 
 	dev_info(hdev->dev,
 		"Loading firmware to device, may take some time...\n");
-- 
2.25.1

