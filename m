Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D5E35372E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 09:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhDDHXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 03:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:44028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhDDHXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 03:23:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 448A761006;
        Sun,  4 Apr 2021 07:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617521010;
        bh=rw0riYxY2I2KPFz2zXz3iDPgLWMsyb+NrA8Vg5CEmOg=;
        h=From:To:Cc:Subject:Date:From;
        b=C4UfopuSinbskrq4/hOi94SyqFGKT+6bgSM82Orh7lchYrNwfExvPYdeRQxO2+eIg
         z36HQrRE8omleBbIYR7j8c7pFu7NJKu8IjB1LwpdldXksvmzODmILOHSOQebJvRqH2
         yRDjhSvBHIs20LbDy6n7GDf0ndI48HRk4d7EIwmnsFcbKVOYsB4n4+0auUdquPz2TC
         5jnSPZ9Z2JOpRvu6aw2U+Rlea+CNSZrZ6L/nUeWPYRznE8Y+UAkKlMWKmxm52Zvcwp
         oM5jabOvA4p9LowoCDn8CEB10CoKbX6fRe6olBvhmlJ8iUEHbLt7ZUXcK/mpZEZw64
         EyH7bQaZleDxw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH] habanalabs: support DEVICE_UNUSABLE error indication from FW
Date:   Sun,  4 Apr 2021 10:23:25 +0300
Message-Id: <20210404072325.9227-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

In case of multiple ECC errors, FW will set the DEVICE_UNUSABLE bit.
On boot-up, the driver will therefore fail inserting the device.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c        | 3 +++
 drivers/misc/habanalabs/include/common/hl_boot_if.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 092691a8917d..d81a8d537373 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -342,6 +342,9 @@ static int fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
 		dev_err(hdev->dev, "Device boot error - eFuse failure\n");
 	if (err_val & CPU_BOOT_ERR0_PLL_FAIL)
 		dev_err(hdev->dev, "Device boot error - PLL failure\n");
+	if (err_val & CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL)
+		dev_err(hdev->dev,
+			"Device boot error - device unusable failure\n");
 
 	security_val = RREG32(cpu_security_boot_status_reg);
 	if (security_val & CPU_BOOT_DEV_STS0_ENABLED)
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 1717874ff306..980b432fd76e 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -73,6 +73,9 @@
  * CPU_BOOT_ERR0_PLL_FAIL		PLL settings failed, meaning that one
  *					of the PLLs remains in REF_CLK
  *
+ * CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL	Device is unusable and customer support
+ *					should be contacted.
+ *
  * CPU_BOOT_ERR0_ENABLED		Error registers enabled.
  *					This is a main indication that the
  *					running FW populates the error
@@ -92,6 +95,7 @@
 #define CPU_BOOT_ERR0_PRI_IMG_VER_FAIL		(1 << 10)
 #define CPU_BOOT_ERR0_SEC_IMG_VER_FAIL		(1 << 11)
 #define CPU_BOOT_ERR0_PLL_FAIL			(1 << 12)
+#define CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL	(1 << 13)
 #define CPU_BOOT_ERR0_ENABLED			(1 << 31)
 
 /*
-- 
2.25.1

