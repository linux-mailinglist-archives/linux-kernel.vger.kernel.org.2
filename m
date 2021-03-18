Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEBB340601
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 13:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhCRMrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 08:47:36 -0400
Received: from m12-15.163.com ([220.181.12.15]:38934 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231153AbhCRMrX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 08:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qjsnO
        LOUb1hpNgZf/LA7Jfd4vRS9GeTS5SmoKUVuCdk=; b=fC2ImrwOzSHFuBwsE6hDk
        aBVO77UchzAK0Ttu0u7RldEwVUWcauSRAE2Gh9DEpqwTTd0mI9gOaM04lYWWakrU
        LHrX6qtn3+OSXroGKsohCD3Bw9JEeGwQoOrRPXdQwxROxhHdy2Lx38Oc9pxMhbyC
        J2ZmIG3W8B5QZNNzE2Sxt0=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp11 (Coremail) with SMTP id D8CowADn9wujS1NgBII0Fg--.41S2;
        Thu, 18 Mar 2021 20:46:36 +0800 (CST)
From:   zuoqilin1@163.com
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] hwmon: Fix spelling typo
Date:   Thu, 18 Mar 2021 20:46:37 +0800
Message-Id: <20210318124637.1331-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowADn9wujS1NgBII0Fg--.41S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyrGryrZFy5Jw45ur1xXwb_yoWxKwcEk3
        yxZr1xuF15AF1Syr1UZr93AryF93Z8WFn7JFW8Kay3A3yDurn8ArWkuF17AF17W347JF9x
        Zw4DKr4fC3W2kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0UEf5UUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbipRdZiVUMc3oMVwABso
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Change 'revsion' to 'revision'.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 drivers/hwmon/ftsteutates.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
index ef88a15..e87aa00 100644
--- a/drivers/hwmon/ftsteutates.c
+++ b/drivers/hwmon/ftsteutates.c
@@ -713,7 +713,7 @@ static int fts_detect(struct i2c_client *client,
 {
 	int val;
 
-	/* detection works with revsion greater or equal to 0x2b */
+	/* detection works with revision greater or equal to 0x2b */
 	val = i2c_smbus_read_byte_data(client, FTS_DEVICE_REVISION_REG);
 	if (val < 0x2b)
 		return -ENODEV;
-- 
1.9.1


