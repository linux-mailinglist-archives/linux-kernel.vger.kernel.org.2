Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2801B362EC2
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhDQJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235936AbhDQJHP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:07:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 10663610C8;
        Sat, 17 Apr 2021 09:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618650410;
        bh=ALaujIM4MHZI2NXZtZbJiCxlc9y5gaJPEj1yklzpSjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6W6I38Tz94KUhUlq5XIKWErj7yfIB375InODl3drFm9uabgj6Y14wiwDb2MT3Tqr
         5UplFlwvriSZHw7SL7VlkwBstDO9OKznkwCTAnB93q0eMToVJNwHBSV3bBkSVhMDnH
         HrlbbJbXDtt/x0zw3O+ZNkw9F2G2hGyDHhMTb7iOCNOR81PESesBbSgEWyQn2/QqhD
         LQU+03oACUGot6zxDBXx3E9nIGiratqQl4j7ystwJ79DYL64fAd9lkgP5p3Ah1cqNc
         HD5HfEOWFsYxM1kb1TCLWvIZpQ8X6RN4Ig1GHXUq2dP7bN4sBzkUdQiwwCkFBtIqrx
         96TuE/91LZIiA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 5/7] habanalabs: request f/w in separate function
Date:   Sat, 17 Apr 2021 12:06:36 +0300
Message-Id: <20210417090638.9802-5-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417090638.9802-1-ogabbay@kernel.org>
References: <20210417090638.9802-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

This refactor is needed due to the dynamic FW load in which requesting
the FW file (and getting its attributes) is not immediately followed by
copying FW file content.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 65 +++++++++++++-------
 1 file changed, 44 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 337c76fb5e3c..0a9e3cb86552 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -12,6 +12,47 @@
 #include <linux/slab.h>
 
 #define FW_FILE_MAX_SIZE	0x1400000 /* maximum size of 20MB */
+
+static int hl_request_fw(struct hl_device *hdev,
+				const struct firmware **firmware_p,
+				const char *fw_name)
+{
+	size_t fw_size;
+	int rc;
+
+	rc = request_firmware(firmware_p, fw_name, hdev->dev);
+	if (rc) {
+		dev_err(hdev->dev, "Firmware file %s is not found! (error %d)\n",
+				fw_name, rc);
+		goto out;
+	}
+
+	fw_size = (*firmware_p)->size;
+	if ((fw_size % 4) != 0) {
+		dev_err(hdev->dev, "Illegal %s firmware size %zu\n",
+				fw_name, fw_size);
+		rc = -EINVAL;
+		goto release_fw;
+	}
+
+	dev_dbg(hdev->dev, "%s firmware size == %zu\n", fw_name, fw_size);
+
+	if (fw_size > FW_FILE_MAX_SIZE) {
+		dev_err(hdev->dev,
+			"FW file size %zu exceeds maximum of %u bytes\n",
+			fw_size, FW_FILE_MAX_SIZE);
+		rc = -EINVAL;
+		goto release_fw;
+	}
+
+	return 0;
+
+release_fw:
+	release_firmware(*firmware_p);
+out:
+	return rc;
+}
+
 /**
  * hl_fw_load_fw_to_device() - Load F/W code to device's memory.
  *
@@ -33,29 +74,11 @@ int hl_fw_load_fw_to_device(struct hl_device *hdev, const char *fw_name,
 	size_t fw_size;
 	int rc;
 
-	rc = request_firmware(&fw, fw_name, hdev->dev);
-	if (rc) {
-		dev_err(hdev->dev, "Firmware file %s is not found!\n", fw_name);
-		goto out;
-	}
+	rc = hl_request_fw(hdev, &fw, fw_name);
+	if (rc)
+		return rc;
 
 	fw_size = fw->size;
-	if ((fw_size % 4) != 0) {
-		dev_err(hdev->dev, "Illegal %s firmware size %zu\n",
-			fw_name, fw_size);
-		rc = -EINVAL;
-		goto out;
-	}
-
-	dev_dbg(hdev->dev, "%s firmware size == %zu\n", fw_name, fw_size);
-
-	if (fw_size > FW_FILE_MAX_SIZE) {
-		dev_err(hdev->dev,
-			"FW file size %zu exceeds maximum of %u bytes\n",
-			fw_size, FW_FILE_MAX_SIZE);
-		rc = -EINVAL;
-		goto out;
-	}
 
 	if (size - src_offset > fw_size) {
 		dev_err(hdev->dev,
-- 
2.25.1

