Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D608460972
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 20:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357636AbhK1TkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 14:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238479AbhK1TiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 14:38:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD5FC061746
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 11:34:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCF36B80D61
        for <linux-kernel@vger.kernel.org>; Sun, 28 Nov 2021 19:34:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995A7C004E1;
        Sun, 28 Nov 2021 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638128084;
        bh=7ST2ofIlYLSNX0vDroI8cYNghHTs9+e2IKjOQvMRuKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lTW8LTJbAn517sltoYWZysaoWKSJHxnbrvJ8w11p3D+sPFSvllZixGyTkC8BOTM6X
         mmaUzpOS1uLd5ZH/jlwJxgRsnQy6i2jX28TGeL1rbks+oumEt7wQp37Scjk0NfQwe6
         nC8Mj6XVJpDQUgVzChLxQ9ZDKFC98HWYNSESt8E3ZVgMeX9CCjAT5pFNDGvIAGRURA
         DrBTFZw8r2iYalaU/CZesAPEe8qjlbnLHg+jW0Ubu4PCzRIcLMiecxQpxWP8pCjvep
         b/iKoeyntP6PNH6HlFJ3n2qsIR3oB2vWDyPBvYDkg1juI0d4Oa6YEPMsZqR411NpVd
         hJ9gky0cGOg/Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 04/12] habanalabs: move device boot warnings to the correct location
Date:   Sun, 28 Nov 2021 21:34:27 +0200
Message-Id: <20211128193435.266534-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211128193435.266534-1-ogabbay@kernel.org>
References: <20211128193435.266534-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

As device boot warnings clears the indication from the error mask,
they must be located together before the unknown error validation.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 45 ++++++++++----------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index aea5904332fd..cf67800f2b47 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -443,15 +443,6 @@ static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val,
 		err_exists = true;
 	}
 
-	if (err_val & CPU_BOOT_ERR0_DRAM_SKIPPED) {
-		dev_warn(hdev->dev,
-			"Device boot warning - Skipped DRAM initialization\n");
-		/* This is a warning so we don't want it to disable the
-		 * device
-		 */
-		err_val &= ~CPU_BOOT_ERR0_DRAM_SKIPPED;
-	}
-
 	if (err_val & CPU_BOOT_ERR0_BMC_WAIT_SKIPPED) {
 		if (hdev->bmc_enable) {
 			dev_err(hdev->dev,
@@ -495,15 +486,6 @@ static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val,
 		err_exists = true;
 	}
 
-	if (err_val & CPU_BOOT_ERR0_PRI_IMG_VER_FAIL) {
-		dev_warn(hdev->dev,
-			"Device boot warning - Failed to load preboot primary image\n");
-		/* This is a warning so we don't want it to disable the
-		 * device as we have a secondary preboot image
-		 */
-		err_val &= ~CPU_BOOT_ERR0_PRI_IMG_VER_FAIL;
-	}
-
 	if (err_val & CPU_BOOT_ERR0_SEC_IMG_VER_FAIL) {
 		dev_err(hdev->dev, "Device boot error - Failed to load preboot secondary image\n");
 		err_exists = true;
@@ -523,10 +505,23 @@ static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val,
 	if (sts_val & CPU_BOOT_DEV_STS0_ENABLED)
 		dev_dbg(hdev->dev, "Device status0 %#x\n", sts_val);
 
-	if (!err_exists && (err_val & ~CPU_BOOT_ERR0_ENABLED)) {
-		dev_err(hdev->dev,
-			"Device boot error - unknown ERR0 error 0x%08x\n", err_val);
-		err_exists = true;
+	/* All warnings should go here in order not to reach the unknown error validation */
+	if (err_val & CPU_BOOT_ERR0_DRAM_SKIPPED) {
+		dev_warn(hdev->dev,
+			"Device boot warning - Skipped DRAM initialization\n");
+		/* This is a warning so we don't want it to disable the
+		 * device
+		 */
+		err_val &= ~CPU_BOOT_ERR0_DRAM_SKIPPED;
+	}
+
+	if (err_val & CPU_BOOT_ERR0_PRI_IMG_VER_FAIL) {
+		dev_warn(hdev->dev,
+			"Device boot warning - Failed to load preboot primary image\n");
+		/* This is a warning so we don't want it to disable the
+		 * device as we have a secondary preboot image
+		 */
+		err_val &= ~CPU_BOOT_ERR0_PRI_IMG_VER_FAIL;
 	}
 
 	if (err_val & CPU_BOOT_ERR0_TPM_FAIL) {
@@ -538,6 +533,12 @@ static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val,
 		err_val &= ~CPU_BOOT_ERR0_TPM_FAIL;
 	}
 
+	if (!err_exists && (err_val & ~CPU_BOOT_ERR0_ENABLED)) {
+		dev_err(hdev->dev,
+			"Device boot error - unknown ERR0 error 0x%08x\n", err_val);
+		err_exists = true;
+	}
+
 	/* return error only if it's in the predefined mask */
 	if (err_exists && ((err_val & ~CPU_BOOT_ERR0_ENABLED) &
 				lower_32_bits(hdev->boot_error_status_mask)))
-- 
2.25.1

