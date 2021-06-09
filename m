Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17FAD3A187B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 17:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238783AbhFIPF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 11:05:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234760AbhFIPFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 11:05:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D9D2613B9;
        Wed,  9 Jun 2021 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623251029;
        bh=i8FKGCKIb4LgWVUHd3Oa7mTutXLNiG9013ZIIFgr7aA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l04RAt9E/1DinwP5bcdivmlyHwT9R8A6sbAEtnTBb00jhHMHYSK+2cbU1FL/GxpR/
         l9kMccySYYccR2h3u1viPIO5OiwGcyeUxM2adoguCPgWMbasMseuuDlkZzUwLGOjY4
         kvst2VAvsY/fnAVZfUJF8mfFFy3rFoEnrkwmOzIYCF9YjgfNbKHhYwvt9u1fGFdyFV
         ga/uigC15h0Do0zuuPVcTCuRHhH2oTJ3+HO/snlDHYwekV4mu4TnANA6ZNS9ekMTDx
         oFUle5D298837FNzUZuWq5jo50ScB3lnncQ7/CtJLVph9O8SnYxkEjK6rX77xb244V
         ulb4FiFnEjxuw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>
Subject: [PATCH 2/7] habanalabs: small code refactoring
Date:   Wed,  9 Jun 2021 18:03:38 +0300
Message-Id: <20210609150343.4712-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609150343.4712-1-ogabbay@kernel.org>
References: <20210609150343.4712-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

Use datatype defines instead of hard coded values,
and rename set_fixed_properties function.

Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c   | 6 +++---
 drivers/misc/habanalabs/goya/goya.c     | 4 ++--
 drivers/misc/habanalabs/goya/goyaP.h    | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 0056282cec94..46fcab1bf873 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1395,7 +1395,7 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 
 	dev_info(hdev->dev, "Found %s device with %lluGB DRAM\n",
 		hdev->asic_name,
-		hdev->asic_prop.dram_size / 1024 / 1024 / 1024);
+		hdev->asic_prop.dram_size / SZ_1G);
 
 	rc = hl_vm_init(hdev);
 	if (rc) {
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9b4bd38c2986..f8bf30e48bba 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -410,7 +410,7 @@ static inline void set_default_power_values(struct hl_device *hdev)
 	}
 }
 
-static int gaudi_get_fixed_properties(struct hl_device *hdev)
+static int gaudi_set_fixed_properties(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	u32 num_sync_stream_queues = 0;
@@ -655,9 +655,9 @@ static int gaudi_early_init(struct hl_device *hdev)
 	u32 fw_boot_status;
 	int rc;
 
-	rc = gaudi_get_fixed_properties(hdev);
+	rc = gaudi_set_fixed_properties(hdev);
 	if (rc) {
-		dev_err(hdev->dev, "Failed to get fixed properties\n");
+		dev_err(hdev->dev, "Failed setting fixed properties\n");
 		return rc;
 	}
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index bcefc372a689..6d63930b7a10 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -355,7 +355,7 @@ static int goya_mmu_set_dram_default_page(struct hl_device *hdev);
 static int goya_mmu_add_mappings_for_device_cpu(struct hl_device *hdev);
 static void goya_mmu_prepare(struct hl_device *hdev, u32 asid);
 
-int goya_get_fixed_properties(struct hl_device *hdev)
+int goya_set_fixed_properties(struct hl_device *hdev)
 {
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 	int i;
@@ -587,7 +587,7 @@ static int goya_early_init(struct hl_device *hdev)
 	u32 fw_boot_status, val;
 	int rc;
 
-	rc = goya_get_fixed_properties(hdev);
+	rc = goya_set_fixed_properties(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "Failed to get fixed properties\n");
 		return rc;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index ef8c6c8b5c8d..0b05da614729 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -168,7 +168,7 @@ struct goya_device {
 	u8		device_cpu_mmu_mappings_done;
 };
 
-int goya_get_fixed_properties(struct hl_device *hdev);
+int goya_set_fixed_properties(struct hl_device *hdev);
 int goya_mmu_init(struct hl_device *hdev);
 void goya_init_dma_qmans(struct hl_device *hdev);
 void goya_init_mme_qmans(struct hl_device *hdev);
-- 
2.25.1

