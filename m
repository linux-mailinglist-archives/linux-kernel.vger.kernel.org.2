Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DA635B931
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 06:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhDLEDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 00:03:19 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:48339 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229448AbhDLEDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 00:03:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UVD1aq6_1618200171;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UVD1aq6_1618200171)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 12 Apr 2021 12:02:56 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     bp@alien8.de
Cc:     davem@davemloft.net, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ide-cd: remove useless variable
Date:   Mon, 12 Apr 2021 12:02:51 +0800
Message-Id: <1618200171-54914-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following gcc warning:

drivers/ide/ide-cd_ioctl.c:212:6: warning: variable ‘stat’ set but not
used [-Wunused-but-set-variable].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/ide/ide-cd_ioctl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ide/ide-cd_ioctl.c b/drivers/ide/ide-cd_ioctl.c
index 011eab9..22ec8b7 100644
--- a/drivers/ide/ide-cd_ioctl.c
+++ b/drivers/ide/ide-cd_ioctl.c
@@ -209,7 +209,6 @@ int ide_cdrom_select_speed(struct cdrom_device_info *cdi, int speed)
 	ide_drive_t *drive = cdi->handle;
 	struct cdrom_info *cd = drive->driver_data;
 	u8 buf[ATAPI_CAPABILITIES_PAGE_SIZE];
-	int stat;
 	unsigned char cmd[BLK_MAX_CDB];
 
 	if (speed == 0)
@@ -230,7 +229,7 @@ int ide_cdrom_select_speed(struct cdrom_device_info *cdi, int speed)
 		cmd[5] = speed & 0xff;
 	}
 
-	stat = ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, NULL, 0, 0);
+	ide_cd_queue_pc(drive, cmd, 0, NULL, NULL, NULL, 0, 0);
 
 	if (!ide_cdrom_get_capabilities(drive, buf)) {
 		ide_cdrom_update_speed(drive, buf);
-- 
1.8.3.1

