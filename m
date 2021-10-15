Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC8AE42E843
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 07:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235354AbhJOFK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 01:10:57 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:24320 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbhJOFK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 01:10:56 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HVvM74SYgzYff7;
        Fri, 15 Oct 2021 13:04:19 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 13:08:49 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 15 Oct
 2021 13:08:48 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <balbi@kernel.org>
Subject: [PATCH] usb: phy: isp1301: add release func to dev to avoid memory leak
Date:   Fri, 15 Oct 2021 13:16:24 +0800
Message-ID: <20211015051624.1655193-1-yangyingliang@huawei.com>
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

After calling usb_add_phy_dev(), client->dev.type will be changed
to 'usb_pyh_dev_type', the release() func is null, it cause the
following WARNING:

Device '1-001c' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
WARNING: CPU: 1 PID: 405 at device_release+0x1b7/0x240
Call Trace:
 kobject_put+0x1e5/0x540
 device_unregister+0x35/0xc0
 i2c_unregister_device+0x114/0x1f0

It cause 'client' leaked which is allocated in i2c_new_client_device():

unreferenced object 0xffff88800670b000 (size 2048):
  comm "xrun", pid 429, jiffies 4294946742 (age 235.248s)
  hex dump (first 32 bytes):
    00 00 1c 00 69 73 70 31 33 30 31 00 00 00 00 00  ....isp1301.....
    00 00 00 00 00 00 00 00 c0 e4 17 c1 ff ff ff ff  ................
  backtrace:
    [<00000000a4641100>] kmem_cache_alloc_trace+0x186/0x2b0
    [<00000000d9d933e7>] i2c_new_client_device+0x56/0xb40
    [<000000007255bed2>] new_device_store+0x1f4/0x410

So add release func to dev to avoid this memory leak.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 790d3a5ab6e36 ("usb: phy: isp1301: give it a context structure")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/usb/phy/phy-isp1301.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/phy/phy-isp1301.c b/drivers/usb/phy/phy-isp1301.c
index ad3d57f1c273..04f005572484 100644
--- a/drivers/usb/phy/phy-isp1301.c
+++ b/drivers/usb/phy/phy-isp1301.c
@@ -111,6 +111,7 @@ static int isp1301_probe(struct i2c_client *client,
 	phy->init = isp1301_phy_init;
 	phy->set_vbus = isp1301_phy_set_vbus;
 	phy->type = USB_PHY_TYPE_USB2;
+	client->dev.release = client->dev.type->release;
 
 	i2c_set_clientdata(client, isp);
 	usb_add_phy_dev(phy);
-- 
2.25.1

