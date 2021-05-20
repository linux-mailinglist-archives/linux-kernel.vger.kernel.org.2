Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12D7338B082
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbhETNx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:53:29 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4774 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240761AbhETNxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:53:10 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FmB011ZLFzqTdb;
        Thu, 20 May 2021 21:48:17 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 21:51:48 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 21:51:47 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <yuehaibing@huawei.com>
CC:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] phy: phy-twl4030-usb: use DEVICE_ATTR_RO macro
Date:   Thu, 20 May 2021 21:51:32 +0800
Message-ID: <20210520135132.37628-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DEVICE_ATTR_RO helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/phy/ti/phy-twl4030-usb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
index 812e5409d359..5771e2486a3b 100644
--- a/drivers/phy/ti/phy-twl4030-usb.c
+++ b/drivers/phy/ti/phy-twl4030-usb.c
@@ -544,8 +544,8 @@ static int twl4030_usb_ldo_init(struct twl4030_usb *twl)
 	return 0;
 }
 
-static ssize_t twl4030_usb_vbus_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+static ssize_t vbus_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct twl4030_usb *twl = dev_get_drvdata(dev);
 	int ret = -EINVAL;
@@ -557,7 +557,7 @@ static ssize_t twl4030_usb_vbus_show(struct device *dev,
 
 	return ret;
 }
-static DEVICE_ATTR(vbus, 0444, twl4030_usb_vbus_show, NULL);
+static DEVICE_ATTR_RO(vbus);
 
 static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
-- 
2.17.1

