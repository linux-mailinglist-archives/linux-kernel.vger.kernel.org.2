Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF86331FB1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 08:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhCIHMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 02:12:17 -0500
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:41770 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229520AbhCIHLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 02:11:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UR3kFqb_1615273900;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UR3kFqb_1615273900)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 15:11:46 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     stefanr@s5r6.in-berlin.de
Cc:     linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] firewire: Use bitwise instead of arithmetic operator for flags
Date:   Tue,  9 Mar 2021 15:11:39 +0800
Message-Id: <1615273899-88446-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/firewire/core-device.c:973:22-23: WARNING: sum of probable
bitmasks, consider |.

./drivers/firewire/core-device.c:954:22-23: WARNING: sum of probable
bitmasks, consider |.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/firewire/core-device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 6821698..e04832d 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -951,7 +951,7 @@ static void set_broadcast_channel(struct fw_device *device, int generation)
 	if (device->bc_implemented == BC_UNKNOWN) {
 		rcode = fw_run_transaction(card, TCODE_READ_QUADLET_REQUEST,
 				device->node_id, generation, device->max_speed,
-				CSR_REGISTER_BASE + CSR_BROADCAST_CHANNEL,
+				CSR_REGISTER_BASE | CSR_BROADCAST_CHANNEL,
 				&data, 4);
 		switch (rcode) {
 		case RCODE_COMPLETE:
@@ -970,7 +970,7 @@ static void set_broadcast_channel(struct fw_device *device, int generation)
 				   BROADCAST_CHANNEL_VALID);
 		fw_run_transaction(card, TCODE_WRITE_QUADLET_REQUEST,
 				device->node_id, generation, device->max_speed,
-				CSR_REGISTER_BASE + CSR_BROADCAST_CHANNEL,
+				CSR_REGISTER_BASE | CSR_BROADCAST_CHANNEL,
 				&data, 4);
 	}
 }
-- 
1.8.3.1

