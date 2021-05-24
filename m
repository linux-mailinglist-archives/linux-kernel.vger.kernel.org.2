Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE638E58A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 13:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbhEXLhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 07:37:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3645 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbhEXLhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 07:37:11 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpZn32z1VzNybK;
        Mon, 24 May 2021 19:32:07 +0800 (CST)
Received: from dggpemm500009.china.huawei.com (7.185.36.225) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:35:42 +0800
Received: from huawei.com (10.175.113.32) by dggpemm500009.china.huawei.com
 (7.185.36.225) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 24 May
 2021 19:35:42 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Colin Leroy <colin@colino.net>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        "Liu Shixin" <liushixin2@huawei.com>
Subject: [PATCH -next] macintosh/therm_adt746x: Replaced simple_strtol() with kstrtoint()
Date:   Mon, 24 May 2021 20:08:35 +0800
Message-ID: <20210524120835.1580420-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500009.china.huawei.com (7.185.36.225)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The simple_strtol() function is deprecated in some situation since
it does not check for the range overflow. Use kstrtoint() instead.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/macintosh/therm_adt746x.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index 7e218437730c..0d7ef55126ce 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -352,7 +352,8 @@ static ssize_t store_##name(struct device *dev, struct device_attribute *attr, c
 	struct thermostat *th = dev_get_drvdata(dev);		\
 	int val;						\
 	int i;							\
-	val = simple_strtol(buf, NULL, 10);			\
+	if (unlikely(kstrtoint(buf, 10, &val))			\
+		return -EINVAL;					\
 	printk(KERN_INFO "Adjusting limits by %d degrees\n", val);	\
 	limit_adjust = val;					\
 	for (i=0; i < 3; i++)					\
@@ -364,7 +365,8 @@ static ssize_t store_##name(struct device *dev, struct device_attribute *attr, c
 static ssize_t store_##name(struct device *dev, struct device_attribute *attr, const char *buf, size_t n) \
 {								\
 	int val;						\
-	val = simple_strtol(buf, NULL, 10);			\
+	if (unlikely(kstrtoint(buf, 10, &val))			\
+		return -EINVAL;					\
 	if (val < 0 || val > 255)				\
 		return -EINVAL;					\
 	printk(KERN_INFO "Setting specified fan speed to %d\n", val);	\
-- 
2.18.0.huawei.25

