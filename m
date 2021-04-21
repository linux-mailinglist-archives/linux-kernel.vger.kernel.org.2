Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD5B366C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242698AbhDUNPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242101AbhDUNJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C726661454;
        Wed, 21 Apr 2021 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010555;
        bh=1pswFlhkFI5NKpiQkO2Hrq9ecj6jYeZOMh2wghuGTuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FJRxde6u5rzjVMiZCCycw0myapSy3lY9T5UAVzYJ25XCE4tesLMrSbj/ZXXCt+g8Y
         DJ5k99kniUvV9dwvGgUegKbjoGVYpcYWbzJEdrrrM3Qk6l/1OwgVJiuxOJ3p+4WuFS
         muu+zDRaERILioVvFaIg/8Ua1uco+l/sjtlGrqXk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kangjie Lu <kjlu@umn.edu>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 177/190] Revert "hwmon: (lm80) fix a missing check of bus read in lm80 probe"
Date:   Wed, 21 Apr 2021 15:00:52 +0200
Message-Id: <20210421130105.1226686-178-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 9aa3aa15f4c2f74f47afd6c5db4b420fadf3f315.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: Kangjie Lu <kjlu@umn.edu>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/lm80.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index ac4adb44b224..97ab491d2922 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -596,7 +596,6 @@ static int lm80_probe(struct i2c_client *client)
 	struct device *dev = &client->dev;
 	struct device *hwmon_dev;
 	struct lm80_data *data;
-	int rv;
 
 	data = devm_kzalloc(dev, sizeof(struct lm80_data), GFP_KERNEL);
 	if (!data)
@@ -609,14 +608,8 @@ static int lm80_probe(struct i2c_client *client)
 	lm80_init_client(client);
 
 	/* A few vars need to be filled upon startup */
-	rv = lm80_read_value(client, LM80_REG_FAN_MIN(1));
-	if (rv < 0)
-		return rv;
-	data->fan[f_min][0] = rv;
-	rv = lm80_read_value(client, LM80_REG_FAN_MIN(2));
-	if (rv < 0)
-		return rv;
-	data->fan[f_min][1] = rv;
+	data->fan[f_min][0] = lm80_read_value(client, LM80_REG_FAN_MIN(1));
+	data->fan[f_min][1] = lm80_read_value(client, LM80_REG_FAN_MIN(2));
 
 	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
 							   data, lm80_groups);
-- 
2.31.1

