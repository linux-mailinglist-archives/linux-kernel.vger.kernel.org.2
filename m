Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAEC741D5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 10:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349043AbhI3IyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 04:54:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23342 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348239AbhI3IyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 04:54:12 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HKn2L3gQRzRfhp;
        Thu, 30 Sep 2021 16:48:10 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 30 Sep 2021 16:52:28 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 30 Sep
 2021 16:52:28 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <rafael@kernel.org>, <gregkh@linuxfoundation.org>,
        <saravanak@google.com>
Subject: [PATCH] driver core: Fix possible memory leak in device_link_add()
Date:   Thu, 30 Sep 2021 16:57:14 +0800
Message-ID: <20210930085714.2057460-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I got memory leak as follows:

unreferenced object 0xffff88801f0b2200 (size 64):
  comm "i2c-lis2hh12-21", pid 5455, jiffies 4294944606 (age 15.224s)
  hex dump (first 32 bytes):
    72 65 67 75 6c 61 74 6f 72 3a 72 65 67 75 6c 61  regulator:regula
    74 6f 72 2e 30 2d 2d 69 32 63 3a 31 2d 30 30 31  tor.0--i2c:1-001
  backtrace:
    [<00000000bf5b0c3b>] __kmalloc_track_caller+0x19f/0x3a0
    [<0000000050da42d9>] kvasprintf+0xb5/0x150
    [<000000004bbbed13>] kvasprintf_const+0x60/0x190
    [<00000000cdac7480>] kobject_set_name_vargs+0x56/0x150
    [<00000000bf83f8e8>] dev_set_name+0xc0/0x100
    [<00000000cc1cf7e3>] device_link_add+0x6b4/0x17c0
    [<000000009db9faed>] _regulator_get+0x297/0x680
    [<00000000845e7f2b>] _devm_regulator_get+0x5b/0xe0
    [<000000003958ee25>] st_sensors_power_enable+0x71/0x1b0 [st_sensors]
    [<000000005f450f52>] st_accel_i2c_probe+0xd9/0x150 [st_accel_i2c]
    [<00000000b5f2ab33>] i2c_device_probe+0x4d8/0xbe0
    [<0000000070fb977b>] really_probe+0x299/0xc30
    [<0000000088e226ce>] __driver_probe_device+0x357/0x500
    [<00000000c21dda32>] driver_probe_device+0x4e/0x140
    [<000000004e650441>] __device_attach_driver+0x257/0x340
    [<00000000cf1891b8>] bus_for_each_drv+0x166/0x1e0

When device_register() returns an error, the name allocated in dev_set_name()
will be leaked, the put_device() should be used instead of kfree() to give up
the device reference, then the name will be freed in kobject_cleanup() and the
references of consumer and supplier will be decreased in device_link_release_fn().

Fixes: 287905e68dd2 ("driver core: Expose device link details in sysfs")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/base/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index e65dd803a453..4a123e58711f 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -809,9 +809,7 @@ struct device_link *device_link_add(struct device *consumer,
 		     dev_bus_name(supplier), dev_name(supplier),
 		     dev_bus_name(consumer), dev_name(consumer));
 	if (device_register(&link->link_dev)) {
-		put_device(consumer);
-		put_device(supplier);
-		kfree(link);
+		put_device(&link->link_dev);
 		link = NULL;
 		goto out;
 	}
-- 
2.25.1

