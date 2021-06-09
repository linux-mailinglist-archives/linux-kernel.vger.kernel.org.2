Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F873A1880
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbhFIPGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:06:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238730AbhFIPFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:05:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A67B611CC;
        Wed,  9 Jun 2021 15:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623251034;
        bh=3htA0DTwmys44bSiJGO7ECQ7iV5D+hf+DxriHOMFGSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHQMmGYEUFKpZ9n5qrDtkFupgNSkA1jYoSFtXlC36kgSp6dq/SvHLihbQheKYuhRr
         ZdjqmNdLh5PmrQ+tRFQL3wGacAEVv/AM9XXaDzDFGm9Mn+qvIebzmDyeLc7RaSer8o
         yP/L1nHtfXlFpNjnaOx9gggNQ41oX46CND+N1Op8GfF4kmsTi/npz9OhvBquVB/A0F
         e1pl3lAM5kHz5H19LNYkAHHRkSoVCwP5+XXK8s5jwOrJfHwh3LRPUuRsfoYUhH0sXz
         7MATp4NYbhNKvQeii6K4cgJwCjeLYWQAQIzYqnSwFCgeY4pL2aWjBp47ZfCUFZNfHi
         TpTYsCtTijnYA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 6/7] habanalabs: add hard reset timeout for PLDM
Date:   Wed,  9 Jun 2021 18:03:42 +0300
Message-Id: <20210609150343.4712-6-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609150343.4712-1-ogabbay@kernel.org>
References: <20210609150343.4712-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Hard reset flow on PLDM might take more than 2 minutes.
Hence add a dedicated hard reset timeout of 6 minutes for PLDM.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c     | 9 +++++++--
 drivers/misc/habanalabs/common/habanalabs.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 46fcab1bf873..cbdf75b24cb4 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1501,6 +1501,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 void hl_device_fini(struct hl_device *hdev)
 {
 	ktime_t timeout;
+	u64 reset_sec;
 	int i, rc;
 
 	dev_info(hdev->dev, "Removing device\n");
@@ -1508,6 +1509,11 @@ void hl_device_fini(struct hl_device *hdev)
 	hdev->device_fini_pending = 1;
 	flush_delayed_work(&hdev->device_reset_work.reset_work);
 
+	if (hdev->pldm)
+		reset_sec = HL_PLDM_HARD_RESET_MAX_TIMEOUT;
+	else
+		reset_sec = HL_HARD_RESET_MAX_TIMEOUT;
+
 	/*
 	 * This function is competing with the reset function, so try to
 	 * take the reset atomic and if we are already in middle of reset,
@@ -1516,8 +1522,7 @@ void hl_device_fini(struct hl_device *hdev)
 	 * ports, the hard reset could take between 10-30 seconds
 	 */
 
-	timeout = ktime_add_us(ktime_get(),
-				HL_HARD_RESET_MAX_TIMEOUT * 1000 * 1000);
+	timeout = ktime_add_us(ktime_get(), reset_sec * 1000 * 1000);
 	rc = atomic_cmpxchg(&hdev->in_reset, 0, 1);
 	while (rc) {
 		usleep_range(50, 200);
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index bc5a1b45270f..244fbf209d34 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -48,6 +48,7 @@
 #define HL_PENDING_RESET_LONG_SEC	60
 
 #define HL_HARD_RESET_MAX_TIMEOUT	120
+#define HL_PLDM_HARD_RESET_MAX_TIMEOUT	(HL_HARD_RESET_MAX_TIMEOUT * 3)
 
 #define HL_DEVICE_TIMEOUT_USEC		1000000 /* 1 s */
 
-- 
2.25.1

