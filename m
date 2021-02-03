Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B2130D182
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 03:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhBCC0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 21:26:36 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48737 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231641AbhBCC0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 21:26:33 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UNiztUM_1612319149;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UNiztUM_1612319149)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 03 Feb 2021 10:25:50 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     davem@davemloft.net
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] ide: remove unneeded semicolon
Date:   Wed,  3 Feb 2021 10:25:48 +0800
Message-Id: <1612319148-110936-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the following coccicheck warning:
./drivers/ide/ide-taskfile.c:167:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ide/ide-taskfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index d016cbe..60d8fa1 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -164,7 +164,7 @@ static ide_startstop_t task_no_data_intr(ide_drive_t *drive)
 		if ((stat & ATA_BUSY) == 0 || retries-- == 0)
 			break;
 		udelay(10);
-	};
+	}
 
 	if (!OK_STAT(stat, ATA_DRDY, BAD_STAT)) {
 		if (custom && tf->command == ATA_CMD_SET_MULTI) {
-- 
1.8.3.1

