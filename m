Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946E3450313
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237680AbhKOLIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237554AbhKOLI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:08:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8F0763210;
        Mon, 15 Nov 2021 11:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636974327;
        bh=Imr2+vaJxA/bgLRaAzfqzMUslsf6Y+JTyyJDLu1dtCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtaY50ZLe7s3HEIVGz8W6PpBe4yheQGweOQ1UiDuKeilTVKbmL15wvIgeDpXlpNZi
         eF3ydjWwBAvmb1nHEpwTMk0yEkiOaodk2zT6ekvrRbCQX32RqckwV6QQPIVjzHJ3d/
         IuiYOdeubhaYcxWsWO1UvMvFAw37OFOffnDhSw3H+Mbfk/Scr8WCQGFkVL0rimpTEN
         Q5ZoYCEP6SEjYh6AYxNuuovtEf4weDLz2BF0du0Werybhrs1hnniF6qJyfzwd4W4Zk
         FZCNcXuSVJqWwtUFdfzh0fw91F/X3lmNoU4T6BcneRa1yQDiV2c8MuDPJ/DItP7Q3n
         cTXBYWXMcEpdQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/7] habanalabs: handle device TPM boot error as warning
Date:   Mon, 15 Nov 2021 13:05:16 +0200
Message-Id: <20211115110521.783103-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115110521.783103-1-ogabbay@kernel.org>
References: <20211115110521.783103-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

AS TPM error indication is not fatal, driver should dump a warning
and continue booting.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c        | 9 +++++++++
 drivers/misc/habanalabs/include/common/hl_boot_if.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 70e992bdbde7..aea5904332fd 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -529,6 +529,15 @@ static bool fw_report_boot_dev0(struct hl_device *hdev, u32 err_val,
 		err_exists = true;
 	}
 
+	if (err_val & CPU_BOOT_ERR0_TPM_FAIL) {
+		dev_warn(hdev->dev,
+			"Device boot warning - TPM failure\n");
+		/* This is a warning so we don't want it to disable the
+		 * device
+		 */
+		err_val &= ~CPU_BOOT_ERR0_TPM_FAIL;
+	}
+
 	/* return error only if it's in the predefined mask */
 	if (err_exists && ((err_val & ~CPU_BOOT_ERR0_ENABLED) &
 				lower_32_bits(hdev->boot_error_status_mask)))
diff --git a/drivers/misc/habanalabs/include/common/hl_boot_if.h b/drivers/misc/habanalabs/include/common/hl_boot_if.h
index 2626df6ef3ef..135e21d6edc9 100644
--- a/drivers/misc/habanalabs/include/common/hl_boot_if.h
+++ b/drivers/misc/habanalabs/include/common/hl_boot_if.h
@@ -32,6 +32,7 @@ enum cpu_boot_err {
 	CPU_BOOT_ERR_DEVICE_UNUSABLE_FAIL = 13,
 	CPU_BOOT_ERR_BOOT_FW_CRIT_ERR = 18,
 	CPU_BOOT_ERR_BINNING_FAIL = 19,
+	CPU_BOOT_ERR_TPM_FAIL = 20,
 	CPU_BOOT_ERR_ENABLED = 31,
 	CPU_BOOT_ERR_SCND_EN = 63,
 	CPU_BOOT_ERR_LAST = 64 /* we have 2 registers of 32 bits */
@@ -108,6 +109,8 @@ enum cpu_boot_err {
  *					malfunctioning components might still be
  *					in use.
  *
+ * CPU_BOOT_ERR0_TPM_FAIL		TPM verification flow failed.
+ *
  * CPU_BOOT_ERR0_ENABLED		Error registers enabled.
  *					This is a main indication that the
  *					running FW populates the error
@@ -130,6 +133,7 @@ enum cpu_boot_err {
 #define CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL	(1 << CPU_BOOT_ERR_DEVICE_UNUSABLE_FAIL)
 #define CPU_BOOT_ERR0_BOOT_FW_CRIT_ERR		(1 << CPU_BOOT_ERR_BOOT_FW_CRIT_ERR)
 #define CPU_BOOT_ERR0_BINNING_FAIL		(1 << CPU_BOOT_ERR_BINNING_FAIL)
+#define CPU_BOOT_ERR0_TPM_FAIL			(1 << CPU_BOOT_ERR_TPM_FAIL)
 #define CPU_BOOT_ERR0_ENABLED			(1 << CPU_BOOT_ERR_ENABLED)
 #define CPU_BOOT_ERR1_ENABLED			(1 << CPU_BOOT_ERR_ENABLED)
 
-- 
2.25.1

