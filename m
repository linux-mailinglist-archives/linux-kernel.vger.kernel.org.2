Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1723370DB5
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 17:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbhEBPwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 11:52:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhEBPwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 11:52:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5CE460FE8
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619970704;
        bh=aTelVVItRgtWgNwihX8ZbiBD9QVydsBncSakNWProqg=;
        h=From:To:Subject:Date:From;
        b=DdkZo5ESdyl39e3RrXRXObbotXMsUJ8XbH3VjpgviczKmfwcn/LUyORFqxRA7ywHW
         83v6CazqUpU/JIkj+akpiX8ErlcOJzbAErtvJ8dh/uTUiOyxF6Fw6nTkFAIYVRkmUi
         bxOW1bjGKmHrsG5a5tunZapkKwKsZK92Ua0IB3SzcvB+X8Yg9ixFE4NZ4Q08I5j0Pk
         R623VI2NH6o6WchnpYBmRua+iNFdER1vii0bHxDuVR6SP5eXrq8VFXMZw9oPT5K2a9
         ftOG8qwQ7r5oEkq4m4kFAoWro1k513X7jvKIaYI+5hs2+rc/ahgczKRoNCmtm6Nx03
         iNt+B8hTKn/1Q==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] habanalabs: ignore device unusable status
Date:   Sun,  2 May 2021 18:51:37 +0300
Message-Id: <20210502155140.4359-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some users might want to implement their own policy of when the device
is unusable so we need to ignore this status in the driver and continue
loading as normal.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index fc10cc06f401..a265753f2a53 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -441,9 +441,9 @@ static int fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
 	}
 
 	if (err_val & CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL) {
-		dev_err(hdev->dev,
-			"Device boot error - device unusable\n");
-		err_exists = true;
+		/* Ignore this bit, don't prevent driver loading */
+		dev_dbg(hdev->dev, "device unusable status is set\n");
+		err_val &= ~CPU_BOOT_ERR0_DEVICE_UNUSABLE_FAIL;
 	}
 
 	security_val = RREG32(cpu_security_boot_status_reg);
-- 
2.25.1

