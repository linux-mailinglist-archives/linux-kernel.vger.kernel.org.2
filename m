Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30770322793
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhBWJNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:13:21 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:33828 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232290AbhBWJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:13:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UPLS2QL_1614071545;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPLS2QL_1614071545)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Feb 2021 17:12:26 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     ogabbay@kernel.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] banalabs: Switch to using the new API kobj_to_dev()
Date:   Tue, 23 Feb 2021 17:12:24 +0800
Message-Id: <1614071544-130951-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the following coccicheck:
./drivers/misc/habanalabs/common/sysfs.c:347:60-61: WARNING opportunity
for kobj_to_dev()

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/misc/habanalabs/common/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 4366d8f..79c1ddf 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -344,7 +344,7 @@ static ssize_t eeprom_read_handler(struct file *filp, struct kobject *kobj,
 			struct bin_attribute *attr, char *buf, loff_t offset,
 			size_t max_size)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct hl_device *hdev = dev_get_drvdata(dev);
 	char *data;
 	int rc;
-- 
1.8.3.1

