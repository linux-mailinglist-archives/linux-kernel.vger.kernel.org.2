Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3E9362ED4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 11:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhDQJV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 05:21:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235455AbhDQJVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 05:21:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 38611611AB
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618651257;
        bh=54evbdRf9AuoFP3XbJgS9LydMVHo7Km+slyhp4mXF0U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JkK3qR3tdB8IT+1I4WFT04LOG/udv0DIhcfza02zd8/nVPmOv8WJixYaZOs/xJ6A5
         P66vh/34k8tF7/jKfUEZPRIsQGH5zoYkEapQwnGdTp5Ad0ogYQz8pqYRbYmXix2YFe
         wni1yWo9gJx6FR246An8SUh5rOw693drqxoy+FM605/xgqUto646es7LleOhWjVULd
         690KsD0Up9Uy+r8eigOAohH0yaUsr4ozhUoLxt1EfAGKpD5c6stL8e0iJlNUOh1k/z
         44Ww0PqWhweEcRc2xwe8Xb9IC+D01rcpcQ6Wa1/47w4ooKhbY6BhsYTRwjxsPUxs/E
         weTkJPK4YGiPg==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] habanalabs: change error level of security not ready
Date:   Sat, 17 Apr 2021 12:20:51 +0300
Message-Id: <20210417092052.22842-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210417092052.22842-1-ogabbay@kernel.org>
References: <20210417092052.22842-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This error indicates a problem in the security initialization inside
the f/w so we need to stop the device loading because it won't be
usable.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/firmware_if.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/habanalabs/common/firmware_if.c b/drivers/misc/habanalabs/common/firmware_if.c
index fff29f057b6d..377a7ca886fe 100644
--- a/drivers/misc/habanalabs/common/firmware_if.c
+++ b/drivers/misc/habanalabs/common/firmware_if.c
@@ -362,12 +362,9 @@ static int fw_read_errors(struct hl_device *hdev, u32 boot_err0_reg,
 	}
 
 	if (err_val & CPU_BOOT_ERR0_SECURITY_NOT_RDY) {
-		dev_warn(hdev->dev,
+		dev_err(hdev->dev,
 			"Device boot warning - security not ready\n");
-		/* This is a warning so we don't want it to disable the
-		 * device
-		 */
-		err_val &= ~CPU_BOOT_ERR0_SECURITY_NOT_RDY;
+		err_exists = true;
 	}
 
 	if (err_val & CPU_BOOT_ERR0_SECURITY_FAIL) {
-- 
2.25.1

