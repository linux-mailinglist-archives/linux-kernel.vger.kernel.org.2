Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BAB3BF9F5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhGHMW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:22:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:6447 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhGHMW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:22:57 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GLFdl3xlSz75hM;
        Thu,  8 Jul 2021 20:16:43 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 8 Jul 2021 20:20:11 +0800
Received: from huawei.com (10.175.104.170) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 8 Jul 2021
 20:20:11 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, Wu Bo <wubo40@huawei.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH] driver core: Make probe_type of driver accessible via sysfs
Date:   Thu, 8 Jul 2021 20:20:10 +0800
Message-ID: <20210708122010.262510-1-haowenchao@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like drivers_autoprobe of bus, make probe_type of driver
accessible via sysfs, so we can get and set a driver's probe_type
happily.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/base/bus.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 1f6b4bd61056..e006562cb638 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -583,6 +583,25 @@ static ssize_t uevent_store(struct device_driver *drv, const char *buf,
 }
 static DRIVER_ATTR_WO(uevent);
 
+static ssize_t probe_type_show(struct device_driver *drv, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", drv->probe_type);
+}
+
+static ssize_t probe_type_store(struct device_driver *drv, const char *buf,
+		size_t count)
+{
+	if (buf[0] == '0')
+		drv->probe_type = 0;
+	else if (buf[0] == '1')
+		drv->probe_type = 1;
+	else if (buf[0] == '2')
+		drv->probe_type = 2;
+
+	return count;
+}
+static DRIVER_ATTR_RW(probe_type);
+
 /**
  * bus_add_driver - Add a driver to the bus.
  * @drv: driver.
@@ -626,6 +645,12 @@ int bus_add_driver(struct device_driver *drv)
 		printk(KERN_ERR "%s: uevent attr (%s) failed\n",
 			__func__, drv->name);
 	}
+	error = driver_create_file(drv, &driver_attr_probe_type);
+	if (error) {
+		printk(KERN_ERR "%s: probe_type attr (%s) failed\n",
+				__func__, drv->name);
+	}
+
 	error = driver_add_groups(drv, bus->drv_groups);
 	if (error) {
 		/* How the hell do we get out of this pickle? Give up */
-- 
2.27.0

