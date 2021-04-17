Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE52C362ED3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbhDQJVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:21:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:38676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235455AbhDQJVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:21:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 20D61611AB
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618651256;
        bh=devWtrWTisJeYLK1XRWv+UkdMnIM5pr2S1P0UFOavo0=;
        h=From:To:Subject:Date:From;
        b=Z00covArS4aCLPpsx8GZbuv2ZInG8B+K7i6/GzXe+RSSq7EW9illVPSiivdHmgonu
         nhAYd9IUq4zor+9s2+1mXCec76Omdhd71nACyQxq3oaTKZRVAOzkzuDzHPEZ/ppM1t
         2jtjoKSVJaQaMfJ+xnZXL2sG+Zw6f3Q9Y/JRLqdaEhE8Xt6cUScd5itKQMzzjHmtqD
         2+e0TeGonYKJEk1dB/pi1PlZm/r5om7N2b9iOBXP5AWiABVu9aCWk43AvXC/lIys+F
         FQfK+M9VUVVxWuzfmn5eL2x276PL2tjkDpZbx5KfA3+jUyYkB6/GyY0LaK4/BZeZdz
         rsCIAnry1XSIg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] habanalabs: skip reading f/w errors on bad status
Date:   Sat, 17 Apr 2021 12:20:50 +0300
Message-Id: <20210417092052.22842-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we read all FF from the boot status register, then something is
totally wrong and there is no point of reading specific errors.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index 7cf82da67dab..fff29f057b6d 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -850,8 +850,13 @@ int hl_fw_read_preboot_status(struct hl_device *hdev, u32 cpu_boot_status_reg,
 	if (rc) {
 		dev_err(hdev->dev, "Failed to read preboot version\n");
 		detect_cpu_boot_status(hdev, status);
-		fw_read_errors(hdev, boot_err0_reg,
-				cpu_security_boot_status_reg);
+
+		/* If we read all FF, then something is totally wrong, no point
+		 * of reading specific errors
+		 */
+		if (status != -1)
+			fw_read_errors(hdev, boot_err0_reg,
+					cpu_security_boot_status_reg);
 		return -EIO;
 	}
 
-- 
2.25.1

