Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1FD42A30F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbhJLLWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:22:18 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23368 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236176AbhJLLWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:22:16 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HTCl62w0WzYdZv;
        Tue, 12 Oct 2021 19:15:46 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 19:20:13 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 12 Oct
 2021 19:20:13 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC:     <linux@roeck-us.net>, <jdelvare@suse.com>
Subject: [PATCH] hwmon: Fix possible memleak in __hwmon_device_register()
Date:   Tue, 12 Oct 2021 19:27:58 +0800
Message-ID: <20211012112758.2681084-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got memory leak as follows when doing fault injection test:

unreferenced object 0xffff888102740438 (size 8):
  comm "27", pid 859, jiffies 4295031351 (age 143.992s)
  hex dump (first 8 bytes):
    68 77 6d 6f 6e 30 00 00                          hwmon0..
  backtrace:
    [<00000000544b5996>] __kmalloc_track_caller+0x1a6/0x300
    [<00000000df0d62b9>] kvasprintf+0xad/0x140
    [<00000000d3d2a3da>] kvasprintf_const+0x62/0x190
    [<000000005f8f0f29>] kobject_set_name_vargs+0x56/0x140
    [<00000000b739e4b9>] dev_set_name+0xb0/0xe0
    [<0000000095b69c25>] __hwmon_device_register+0xf19/0x1e50 [hwmon]
    [<00000000a7e65b52>] hwmon_device_register_with_info+0xcb/0x110 [hwmon]
    [<000000006f181e86>] devm_hwmon_device_register_with_info+0x85/0x100 [hwmon]
    [<0000000081bdc567>] tmp421_probe+0x2d2/0x465 [tmp421]
    [<00000000502cc3f8>] i2c_device_probe+0x4e1/0xbb0
    [<00000000f90bda3b>] really_probe+0x285/0xc30
    [<000000007eac7b77>] __driver_probe_device+0x35f/0x4f0
    [<000000004953d43d>] driver_probe_device+0x4f/0x140
    [<000000002ada2d41>] __device_attach_driver+0x24c/0x330
    [<00000000b3977977>] bus_for_each_drv+0x15d/0x1e0
    [<000000005bf2a8e3>] __device_attach+0x267/0x410

When device_register() returns an error, the name allocated in
dev_set_name() will be leaked, the put_device() should be used
instead of calling hwmon_dev_release() to give up the device
reference, then the name will be freed in kobject_cleanup().

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: bab2243ce189 ("hwmon: Introduce hwmon_device_register_with_groups")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/hwmon/hwmon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 8d3b1dae31df..3501a3ead4ba 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -796,8 +796,10 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 	dev_set_drvdata(hdev, drvdata);
 	dev_set_name(hdev, HWMON_ID_FORMAT, id);
 	err = device_register(hdev);
-	if (err)
-		goto free_hwmon;
+	if (err) {
+		put_device(hdev);
+		goto ida_remove;
+	}
 
 	INIT_LIST_HEAD(&hwdev->tzdata);
 
-- 
2.25.1

