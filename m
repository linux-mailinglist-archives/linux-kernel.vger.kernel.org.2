Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C9336E722
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 10:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbhD2Ihj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 04:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:47822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhD2Ihg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 04:37:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02CBE61289;
        Thu, 29 Apr 2021 08:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619685410;
        bh=MeLEsLw6D27yIvjQ/kVD7YJHUqg3HKZl6KtwqpCreNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IW7NtWq1kOKSpdZ0t3EbHV1G9raGE+iIzxS46CQTSI3s4y9uQ/263WJfMZ3aMSAcD
         3wQE3PYuMC3RSGsU6ad9jTzoX+vAfnWiRULC+CcPDb5MDRCDGVQNWzz4gld6H3DODW
         m4KEUBiD4QNqIISPOb+lbOomUGyOG/P4UCUyzdoM+QKHkaY2MHAHrb6Qbv1JU+zgsh
         qm7Y7EPApU9qh4OtJRVwtRcMxm+dhHJkDFd3vAP91wKtbuPhdFw5BA5gxfgR22wOyo
         IdUI0XrOljA3ugdMH1nzmIlD5LwdzvJPoV9Zy6NDIRBE28NKqlbHZH7pLrvVWZLoTp
         TSe0oV5GwQtOg==
Received: by pali.im (Postfix)
        id 295097DF; Thu, 29 Apr 2021 10:36:48 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 mvebu + mvebu/dt64 2/6] firmware: turris-mox-rwtm: report failures better
Date:   Thu, 29 Apr 2021 10:36:32 +0200
Message-Id: <20210429083636.22560-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210429083636.22560-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210429083636.22560-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Behún <kabel@kernel.org>

Report a notice level message if a command is not supported by the rWTM
firmware.

This should not be an error, merely a notice, because the firmware can
be used on non-CZ.NIC boards that do not have manufacturing information
burned.

Signed-off-by: Marek Behún <kabel@kernel.org>
Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
---
 drivers/firmware/turris-mox-rwtm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
index f85acdb3130c..d7e3489e4bf2 100644
--- a/drivers/firmware/turris-mox-rwtm.c
+++ b/drivers/firmware/turris-mox-rwtm.c
@@ -204,11 +204,14 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 		return ret;
 
 	ret = mox_get_status(MBOX_CMD_BOARD_INFO, reply->retval);
-	if (ret < 0 && ret != -ENODATA) {
-		return ret;
-	} else if (ret == -ENODATA) {
+	if (ret == -ENODATA) {
 		dev_warn(rwtm->dev,
 			 "Board does not have manufacturing information burned!\n");
+	} else if (ret == -ENOSYS) {
+		dev_notice(rwtm->dev,
+			   "Firmware does not support the BOARD_INFO command\n");
+	} else if (ret < 0) {
+		return ret;
 	} else {
 		rwtm->serial_number = reply->status[1];
 		rwtm->serial_number <<= 32;
@@ -237,10 +240,13 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
 		return ret;
 
 	ret = mox_get_status(MBOX_CMD_ECDSA_PUB_KEY, reply->retval);
-	if (ret < 0 && ret != -ENODATA) {
-		return ret;
-	} else if (ret == -ENODATA) {
+	if (ret == -ENODATA) {
 		dev_warn(rwtm->dev, "Board has no public key burned!\n");
+	} else if (ret == -ENOSYS) {
+		dev_notice(rwtm->dev,
+			   "Firmware does not support the ECDSA_PUB_KEY command\n");
+	} else if (ret < 0) {
+		return ret;
 	} else {
 		u32 *s = reply->status;
 
-- 
2.20.1

