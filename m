Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C531C3534ED
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 19:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbhDCRaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 13:30:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236724AbhDCRaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 13:30:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 42CB361168
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 17:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617471032;
        bh=lCxd7qfZL0mOkoiC1TgDrXd1VQsbxk4u3Ol8OnbJpDo=;
        h=From:To:Subject:Date:From;
        b=MXDqDqQm9Im3Ut9Z5Hgbl5VQX6f5lskQGvuvjiJRKLsmuTWme4bHUqzhdxvStAl3G
         GZlChm8gSYIMeIGZ8RiQgl5V9YrYvQAXfq7tPEICVUf0CU+TV+l0cIlAREnbsiAs8v
         g2q3s5Fb9xRD72Vc9Dimw1l8fI9oBV92HkQlCtGEz6CKlVdgaO7Ycx+z0K0JX7s+td
         odSihu2Z9prA/Y23RPbIdAM5GyofaYBP5nqRB1WgvjWLArcrRolpC75IGYUtebaEel
         cI3EpXC+MEhBtxhc9Eoq0m2HyOQ8PKft7TiVybsNFzP4VMJ5A9JtWDo4/fJo6kI2La
         IBrEGWRSb44LA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: use strscpy instead of sprintf and strlcpy
Date:   Sat,  3 Apr 2021 20:30:27 +0300
Message-Id: <20210403173027.8528-1-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer the use of strscpy when copying the ASIC name into a char array,
to prevent accidentally exceeding the array's length.
In addition, strlcpy is frowned upon so replace it.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index e64c60d48d42..2ed4f2bedc08 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -321,11 +321,11 @@ static int device_early_init(struct hl_device *hdev)
 	switch (hdev->asic_type) {
 	case ASIC_GOYA:
 		goya_set_asic_funcs(hdev);
-		strlcpy(hdev->asic_name, "GOYA", sizeof(hdev->asic_name));
+		strscpy(hdev->asic_name, "GOYA", sizeof(hdev->asic_name));
 		break;
 	case ASIC_GAUDI:
 		gaudi_set_asic_funcs(hdev);
-		sprintf(hdev->asic_name, "GAUDI");
+		strscpy(hdev->asic_name, "GAUDI", sizeof(hdev->asic_name));
 		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
-- 
2.25.1

