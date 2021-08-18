Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB473F04FC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbhHRNkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:40:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237269AbhHRNkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:40:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C3D9610A6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 13:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629293973;
        bh=jcsNfLgfyHoCJ2MrZDn1SZHM9fpLAQwJ2KE3As4gQGY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kgdV7iMoQ+8M8n5wX0GEy/+QA3JOKWrNa0h+9m5hjemGHx193EgCSTjuRD3NZNbik
         QmliZQcpaAa4SQDkWtafS6TWodX4ruV25hTlA58UJgP9eQqCm4TURdO2qDbPTYuDF1
         8kXY9KNNG2m3kBpJg+Ffah8aGfZrOnbDN1ZvtSMK5UM2dUBCJXfFtlYy3LGxvmFUPF
         asdAH40yRkb01V1eDGKVmOBE0sMr9nkAdp/YODe8tEN9/hMZEgI9Ywwr0r2igNA4B1
         3alFRNi+HYn09SW3e1IqRXirKWWI+7Fl4kxwWwTHikgmZF1IT7jcJPAX0EbNVeCcp0
         4SpbufMMWC5+Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 07/16] habanalabs/gaudi: increase boot fit timeout
Date:   Wed, 18 Aug 2021 16:39:13 +0300
Message-Id: <20210818133922.63637-7-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210818133922.63637-1-ogabbay@kernel.org>
References: <20210818133922.63637-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various f/w versions have different timeouts, so increase the default
timeout to accommodate all the options.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 4 ++++
 drivers/misc/habanalabs/gaudi/gaudi.c        | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index c232d197b57a..8d2568c63f19 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1062,6 +1062,10 @@ static void detect_cpu_boot_status(struct hl_device *hdev, u32 status)
 		dev_err(hdev->dev,
 			"Device boot progress - Thermal Sensor initialization failed\n");
 		break;
+	case CPU_BOOT_STATUS_SECURITY_READY:
+		dev_err(hdev->dev,
+			"Device boot progress - Stuck in preboot after security initialization\n");
+		break;
 	default:
 		dev_err(hdev->dev,
 			"Device boot progress - Invalid status code %d\n",
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 1b98233ffc4b..3fbcdb013a7e 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -76,7 +76,7 @@
 #define GAUDI_PLDM_MMU_TIMEOUT_USEC	(MMU_CONFIG_TIMEOUT_USEC * 100)
 #define GAUDI_PLDM_QMAN0_TIMEOUT_USEC	(HL_DEVICE_TIMEOUT_USEC * 30)
 #define GAUDI_PLDM_TPC_KERNEL_WAIT_USEC	(HL_DEVICE_TIMEOUT_USEC * 30)
-#define GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC	1000000		/* 1s */
+#define GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC	4000000		/* 4s */
 #define GAUDI_MSG_TO_CPU_TIMEOUT_USEC	4000000		/* 4s */
 #define GAUDI_WAIT_FOR_BL_TIMEOUT_USEC	15000000	/* 15s */
 
-- 
2.17.1

