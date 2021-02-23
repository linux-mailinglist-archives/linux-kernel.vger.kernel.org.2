Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDF93227F2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 10:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhBWJnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 04:43:11 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:43111 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229961AbhBWJnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 04:43:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0UPM5RZd_1614073345;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPM5RZd_1614073345)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 23 Feb 2021 17:42:26 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] mfd: lm3533: Switch to using the new API kobj_to_dev()
Date:   Tue, 23 Feb 2021 17:42:24 +0800
Message-Id: <1614073344-68361-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed the following coccicheck:
./drivers/mfd/lm3533-core.c:361:60-61: WARNING opportunity for
kobj_to_dev()

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mfd/lm3533-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 22fdffd..5690768 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -358,7 +358,7 @@ static ssize_t store_output(struct device *dev,
 static umode_t lm3533_attr_is_visible(struct kobject *kobj,
 					     struct attribute *attr, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct lm3533 *lm3533 = dev_get_drvdata(dev);
 	struct device_attribute *dattr = to_dev_attr(attr);
 	struct lm3533_device_attribute *lattr = to_lm3533_dev_attr(dattr);
-- 
1.8.3.1

