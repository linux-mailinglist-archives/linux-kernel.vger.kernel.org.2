Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1943966D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 14:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbhJYMjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:39:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233147AbhJYMjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:39:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4F1E60EFE;
        Mon, 25 Oct 2021 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635165402;
        bh=61hVkOnQqvss/B9JSZ6O/zHXM5S7XyWYNqHwFDD4VgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=br4YWBL/QF+287Sx17DhXy9M+sbas488EyBbo/I1weHqk5TpVr4Klwtahy0bxoPOW
         ZUzOBOVMRdxHJfQ+g55d5aiyng2fWAmjODGaSJUYeqnbhNPKldMI989M6y7m71RgOt
         BJjZm+4Ym2mrmn2hM/ei7Fi//k5e4By9TnPoXMb54YlW38Sc/uPa+LzLdHFxON/Hmd
         GYZzGv4C9Qw6FuODbs9UGgYUILCtj6uqIsh/YBo9r0ufWJf2VyB0uDqJJYsZzUkb0K
         tVYA88iw/gMRe/iUd2Y1r+agUYbea0Ln8Mrv9yISOywpN2YQd7wSIljiAOWBC7Uc03
         /A3bQSkhLR7Jw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/4] habanalabs: revise and document use of boot status flags
Date:   Mon, 25 Oct 2021 15:36:34 +0300
Message-Id: <20211025123636.2842618-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211025123636.2842618-1-ogabbay@kernel.org>
References: <20211025123636.2842618-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ohad Sharabi <osharabi@habana.ai>

The boot status flag "SRAM available" can be set by f/w Linux (in the
general case) or by f/w uboot (in some specific debug scenario) but
never by f/w preboot.

Hence, when polling the boot status flags in the preboot stage we do not
want to poll on "SRAM Avialable".

The special case in which uboot set this flag is when we are running
special debug scenario without Linux. In this case, at some point during
the boot, the uboot relocates its code to the DRAM and then set the
specified flag.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 24 ++++++++++++++++----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 025707a21882..482bed152c39 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -1101,7 +1101,6 @@ static int hl_fw_read_preboot_caps(struct hl_device *hdev,
 		(status == CPU_BOOT_STATUS_DRAM_RDY) ||
 		(status == CPU_BOOT_STATUS_NIC_FW_RDY) ||
 		(status == CPU_BOOT_STATUS_READY_TO_BOOT) ||
-		(status == CPU_BOOT_STATUS_SRAM_AVAIL) ||
 		(status == CPU_BOOT_STATUS_WAITING_FOR_BOOT_FIT),
 		FW_CPU_STATUS_POLL_INTERVAL_USEC,
 		timeout);
@@ -2055,12 +2054,20 @@ static int hl_fw_dynamic_wait_for_boot_fit_active(struct hl_device *hdev,
 
 	dyn_loader = &fw_loader->dynamic_loader;
 
-	/* Make sure CPU boot-loader is running */
+	/*
+	 * Make sure CPU boot-loader is running
+	 * Note that the CPU_BOOT_STATUS_SRAM_AVAIL is generally set by Linux
+	 * yet there is a debug scenario in which we loading uboot (without Linux)
+	 * which at later stage is relocated to DRAM. In this case we expect
+	 * uboot to set the CPU_BOOT_STATUS_SRAM_AVAIL and so we add it to the
+	 * poll flags
+	 */
 	rc = hl_poll_timeout(
 		hdev,
 		le32_to_cpu(dyn_loader->comm_desc.cpu_dyn_regs.cpu_boot_status),
 		status,
-		(status == CPU_BOOT_STATUS_READY_TO_BOOT),
+		(status == CPU_BOOT_STATUS_READY_TO_BOOT) ||
+		(status == CPU_BOOT_STATUS_SRAM_AVAIL),
 		FW_CPU_STATUS_POLL_INTERVAL_USEC,
 		dyn_loader->wait_for_bl_timeout);
 	if (rc) {
@@ -2081,7 +2088,7 @@ static int hl_fw_dynamic_wait_for_linux_active(struct hl_device *hdev,
 
 	dyn_loader = &fw_loader->dynamic_loader;
 
-	/* Make sure CPU boot-loader is running */
+	/* Make sure CPU linux is running */
 
 	rc = hl_poll_timeout(
 		hdev,
@@ -2415,7 +2422,14 @@ static int hl_fw_static_init_cpu(struct hl_device *hdev,
 		WREG32(msg_to_cpu_reg, KMD_MSG_NA);
 	}
 
-	/* Make sure CPU boot-loader is running */
+	/*
+	 * Make sure CPU boot-loader is running
+	 * Note that the CPU_BOOT_STATUS_SRAM_AVAIL is generally set by Linux
+	 * yet there is a debug scenario in which we loading uboot (without Linux)
+	 * which at later stage is relocated to DRAM. In this case we expect
+	 * uboot to set the CPU_BOOT_STATUS_SRAM_AVAIL and so we add it to the
+	 * poll flags
+	 */
 	rc = hl_poll_timeout(
 		hdev,
 		cpu_boot_status_reg,
-- 
2.25.1

