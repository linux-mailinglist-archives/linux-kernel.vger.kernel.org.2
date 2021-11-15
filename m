Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BFD450318
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 12:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhKOLJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 06:09:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237602AbhKOLI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 06:08:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C042063218
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636974330;
        bh=cFShx6HDPabggm6BFW1B8MbEL5i9wKNZkmDYIwHuKxg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BAqnpzp3dQck9r5MJ8aTs4956qEh11pHcVSVjE3EAaDJ0Qr1bxufWKd7rIS0rm/H3
         whnYBTOEHG4Kvmt9mrYY9tLG4oc+yr7BhBk6ISvNs0Cv/O0w1z4/7fbhHKy4Lu/dE9
         Bl9n8IgtcF22Rw0K6si0vfa+m6JyfzGz/RfTNObEQmOdhGqcJhLlEWIz21Y0N4kUXS
         iOyyokKrRBdwLmZxXSLeSx4saCnvcL4EGE7H3XCgF1ga1UKC18WHr6dwT9wkDe9b5L
         41gnkXBdlRJoE4WPxgM7a1NMmH/rrlRPpox0SaR7p9Iv8mH+dVzKfOMHo9IlWuF0mv
         RuvQ4rSV0XRMQ==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] habanalabs: prevent false heartbeat message
Date:   Mon, 15 Nov 2021 13:05:18 +0200
Message-Id: <20211115110521.783103-4-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211115110521.783103-1-ogabbay@kernel.org>
References: <20211115110521.783103-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a device reset has started, there is a chance that the heartbeat
function will fail because the device is disabled at the beginning
of the reset function.

In that case, we don't want the error message to appear in the log.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 0da5a55490ff..ca74d7815a67 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -543,7 +543,9 @@ static void hl_device_heartbeat(struct work_struct *work)
 	if (!hdev->asic_funcs->send_heartbeat(hdev))
 		goto reschedule;
 
-	dev_err(hdev->dev, "Device heartbeat failed!\n");
+	if (hl_device_operational(hdev, NULL))
+		dev_err(hdev->dev, "Device heartbeat failed!\n");
+
 	hl_device_reset(hdev, HL_DRV_RESET_HARD | HL_DRV_RESET_HEARTBEAT);
 
 	return;
-- 
2.25.1

