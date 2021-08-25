Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0627F3F736F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbhHYKjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:39:22 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:22226 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239838AbhHYKjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:39:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UlnIh7o_1629887828;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UlnIh7o_1629887828)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 25 Aug 2021 18:38:27 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     corentin.chary@gmail.com
Cc:     hdegoede@redhat.com, mgross@linux.intel.com, jdelvare@suse.com,
        linux@roeck-us.net, acpi4asus-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] asus-wmi: Fix "unsigned 'retval' is never less than zero" smatch warning
Date:   Wed, 25 Aug 2021 18:37:02 +0800
Message-Id: <1629887822-23918-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warnings:

drivers/platform/x86/asus-wmi.c:478 panel_od_write() warn: unsigned
'retval' is never less than zero.

drivers/platform/x86/asus-wmi.c:566 panel_od_write() warn: unsigned
'retval' is never less than zero.

drivers/platform/x86/asus-wmi.c:1451 panel_od_write() warn: unsigned
'retval' is never less than zero.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 98829e84dc67 ("asus-wmi: Add dgpu disable method")
Fixes: 382b91db8044 ("asus-wmi: Add egpu enable method")
Fixes: ca91ea34778f ("asus-wmi: Add panel overdrive functionality")
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/platform/x86/asus-wmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index cc58118..22af431 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -475,7 +475,7 @@ static int dgpu_disable_write(struct asus_wmi *asus)
 		return err;
 	}
 
-	if (retval > 1 || retval < 0) {
+	if (retval > 1) {
 		pr_warn("Failed to set dgpu disable (retval): 0x%x\n", retval);
 		return -EIO;
 	}
@@ -563,7 +563,7 @@ static int egpu_enable_write(struct asus_wmi *asus)
 		return err;
 	}
 
-	if (retval > 1 || retval < 0) {
+	if (retval > 1) {
 		pr_warn("Failed to set egpu disable (retval): 0x%x\n", retval);
 		return -EIO;
 	}
@@ -1448,7 +1448,7 @@ static int panel_od_write(struct asus_wmi *asus)
 		return err;
 	}
 
-	if (retval > 1 || retval < 0) {
+	if (retval > 1) {
 		pr_warn("Failed to set panel overdrive (retval): 0x%x\n", retval);
 		return -EIO;
 	}
-- 
1.8.3.1

