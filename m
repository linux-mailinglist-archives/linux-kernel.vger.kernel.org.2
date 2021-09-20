Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549C3411413
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbhITMQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:16:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237516AbhITMPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:15:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCA5361040;
        Mon, 20 Sep 2021 12:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632140065;
        bh=73TrFucuxNlW8vlWVi6GfOpJwgFjp9pH7dqbOl/p7wo=;
        h=From:To:Cc:Subject:Date:From;
        b=lxiDFh5VQoEKNTJARE7WiT6/ejxjLbbskFbG3sXsmNfWJVwEFIj3bnU33Alohu/l8
         x+hMbIxne+bbna/eyKBT+mcGcIOuUXp8rU4BznUpvKUt3Nl+Cm/cQbSxTeg/qoVxzu
         uEFOKAUxPm7rGrbBK2Pg/cK1PrpLVpclhKSKs3Rg+HCt0i2gvm+D0HHx07ERgaRI6x
         KOnM0LPkvJ4RJNnKU1G7dZxoxZJrrvQWeIg7ByhC+RqL4hGgEttL4OVUIopIHuHPwg
         4+HqngtfBa1IaN67IHBz9frokL31Y9dCsQU+V1ck2Kgu0cYZbS4PVuQTEDysB4aiBu
         JhQnSF2xpxf0Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, Armin Wolf <W_Armin@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Carlos Alberto Lopez Perez <clopez@igalia.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sebastian Oechsle <setboolean@icloud.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: dell-smm-hwmon: remove unused variable warning
Date:   Mon, 20 Sep 2021 14:14:16 +0200
Message-Id: <20210920121421.93297-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When procfs is disabled, the code produces a warning
for an unused variable:

drivers/hwmon/dell-smm-hwmon.c: In function 'i8k_init_procfs':
drivers/hwmon/dell-smm-hwmon.c:624:31: error: unused variable 'data' [-Werror=unused-variable]
  624 |         struct dell_smm_data *data = dev_get_drvdata(dev);
      |                               ^~~~

Remove that local variable and just pass dev_get_drvdata(dev)
directly.

Fixes: ba04d73c26ed ("hwmon: (dell-smm-hwmon) Move variables into a driver private data structure")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwmon/dell-smm-hwmon.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 774c1b0715d9..0a3ce22c78e6 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -621,10 +621,8 @@ static void i8k_exit_procfs(void *param)
 
 static void __init i8k_init_procfs(struct device *dev)
 {
-	struct dell_smm_data *data = dev_get_drvdata(dev);
-
 	/* Register the proc entry */
-	proc_create_data("i8k", 0, NULL, &i8k_proc_ops, data);
+	proc_create_data("i8k", 0, NULL, &i8k_proc_ops, dev_get_drvdata(dev));
 
 	devm_add_action_or_reset(dev, i8k_exit_procfs, NULL);
 }
-- 
2.29.2

