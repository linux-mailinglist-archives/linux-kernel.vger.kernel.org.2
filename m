Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B398A420906
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 12:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbhJDKKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 06:10:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232755AbhJDKK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 06:10:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 91BE06124F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633342119;
        bh=3IsaB6Xc6Y0tXq8BgqF/zS/WfLqedHgGYTIiObAH4DM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=D4FWef9GMagfKPvtFQ6onwOKLYWIdvbIZZ+vXTny9yIs7q0FtkPos/NByWkZoV0sf
         RJPBSfNwnDk9wDQiwS3HRKeIl2kAR+GVJoMW5WjbmkGNFgywoBiayzZ3Ksfss/vBnV
         L0byIPrZ6QdZn9GvW/nYQ/we0B0iF3S3+Vim2ZKbs7xHeLJfAsU5F1fZLBVmD2oDNH
         XcFKbeQzQ/32Y2t/CDuOoiEBxS2IhyFz7q0H30SElBEsaoRaGAAuebkTcrpmDP3gAj
         rzwxRHbY2ZjSb6slesoDCNKRtDpwaURUPWCZuV2yezoHEH2fi9jAGYBwyTU2a2YZGo
         n4zSBADIPlufA==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] habanalabs: refactor reset log message
Date:   Mon,  4 Oct 2021 13:08:28 +0300
Message-Id: <20211004100830.27573-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211004100830.27573-1-ogabbay@kernel.org>
References: <20211004100830.27573-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset to the device is not necessarily due to an error, so print it
as info instead of error.

In addition, print the type of reset we are doing:
- reset of the entire device (aka hard reset)
- reset of the device after user have released it (less than hard reset)
- lighter reset of an inference device (aka soft reset)

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 8f96f2bb14ec..be18ad0c1bfc 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1018,7 +1018,14 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 
 		take_release_locks(hdev);
 
-		dev_err(hdev->dev, "Going to RESET device!\n");
+		if (hard_reset)
+			dev_info(hdev->dev, "Going to reset device\n");
+		else if (flags & HL_RESET_DEVICE_RELEASE)
+			dev_info(hdev->dev,
+				"Going to reset device after it was released by user\n");
+		else
+			dev_info(hdev->dev,
+				"Going to reset compute engines of inference device\n");
 	}
 
 again:
-- 
2.17.1

