Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD67370A8A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 08:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhEBGjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 02:39:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:36030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhEBGjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 02:39:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C54B61466;
        Sun,  2 May 2021 06:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619937530;
        bh=piKgrKmyiBaUXWlFDCoVe92nrUxy8uKDEoHPROdAKYs=;
        h=From:To:Cc:Subject:Date:From;
        b=Lv7XEAX/B9u8077r48/+QI5LUQWM9R8MmyJPB3ByqKMkb1JGmgJQAUddS+xvT8qte
         K+D9UPJRKJgIxLxxW0hOaQ+6x6Y1XNISxC/gefhf9E4PkAiNpereDbLI8jwoAhxRpn
         loPk1v14lYKKHOy/E4IXCIPAeohDiLboYwLGK6mJI+GOUpAMJyi4W2kNWoYm0EyWQD
         Rxwygys0OUP2ApCHV566qkf9VyAaQYviy8UFyuB269SSbyS6y08yC6/Hs6xshFFLIe
         Bc4+FGK/pyRSccTmPivsDEOAIlAaJJ7xVQcCwvlTk0oCiXFnZIT/BSprcEOzrqRI22
         Y4DZCtUYq3TGA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Guy Nisan <gnisan@habana.ai>
Subject: [PATCH 1/4] habanalabs: modify progress status messages
Date:   Sun,  2 May 2021 09:38:42 +0300
Message-Id: <20210502063845.4615-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guy Nisan <gnisan@habana.ai>

Indicate "progress" instead of "error" when reporting progress status.

Change "u-boot stopped by user" to "Cannot boot" message as
CPU_BOOT_STATUS_UBOOT_NOT_READY may indicate a fatal error that prevent
u-boot from loading firmware.

Signed-off-by: Guy Nisan <gnisan@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 2a22ff9d4425..284563388710 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -792,43 +792,43 @@ static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 	switch (status) {
 	case CPU_BOOT_STATUS_NA:
 		dev_err(hdev->dev,
-			"Device boot error - BTL did NOT run\n");
+			"Device boot progress - BTL did NOT run\n");
 		break;
 	case CPU_BOOT_STATUS_IN_WFE:
 		dev_err(hdev->dev,
-			"Device boot error - Stuck inside WFE loop\n");
+			"Device boot progress - Stuck inside WFE loop\n");
 		break;
 	case CPU_BOOT_STATUS_IN_BTL:
 		dev_err(hdev->dev,
-			"Device boot error - Stuck in BTL\n");
+			"Device boot progress - Stuck in BTL\n");
 		break;
 	case CPU_BOOT_STATUS_IN_PREBOOT:
 		dev_err(hdev->dev,
-			"Device boot error - Stuck in Preboot\n");
+			"Device boot progress - Stuck in Preboot\n");
 		break;
 	case CPU_BOOT_STATUS_IN_SPL:
 		dev_err(hdev->dev,
-			"Device boot error - Stuck in SPL\n");
+			"Device boot progress - Stuck in SPL\n");
 		break;
 	case CPU_BOOT_STATUS_IN_UBOOT:
 		dev_err(hdev->dev,
-			"Device boot error - Stuck in u-boot\n");
+			"Device boot progress - Stuck in u-boot\n");
 		break;
 	case CPU_BOOT_STATUS_DRAM_INIT_FAIL:
 		dev_err(hdev->dev,
-			"Device boot error - DRAM initialization failed\n");
+			"Device boot progress - DRAM initialization failed\n");
 		break;
 	case CPU_BOOT_STATUS_UBOOT_NOT_READY:
 		dev_err(hdev->dev,
-			"Device boot error - u-boot stopped by user\n");
+			"Device boot progress - Cannot boot\n");
 		break;
 	case CPU_BOOT_STATUS_TS_INIT_FAIL:
 		dev_err(hdev->dev,
-			"Device boot error - Thermal Sensor initialization failed\n");
+			"Device boot progress - Thermal Sensor initialization failed\n");
 		break;
 	default:
 		dev_err(hdev->dev,
-			"Device boot error - Invalid status code %d\n",
+			"Device boot progress - Invalid status code %d\n",
 			status);
 		break;
 	}
-- 
2.25.1

