Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED8348DAA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 11:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhCYKHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 06:07:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14589 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbhCYKGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 06:06:50 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5ggz213lz19JH5;
        Thu, 25 Mar 2021 18:04:47 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 18:06:38 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mathias.nyman@intel.com>,
        <stern@rowland.harvard.edu>
CC:     <linux-usb@vger.kernel.org>, <yisen.zhuang@huawei.com>,
        <tanxiaofei@huawei.com>, <liudongdong3@huawei.com>,
        <liulongfang@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] USB:XHCI:Adjust the log level of hub
Date:   Thu, 25 Mar 2021 18:04:12 +0800
Message-ID: <1616666652-37920-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the number of ports of the hub is not between 1 and Maxports,
it will only exit the registration of the hub on the current controller,
but it will not affect the function of the controller itself. Its other
hubs can operate normally, so the log level here can be changed from
error to information.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 drivers/usb/core/hub.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b1e14be..70294ad 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1409,13 +1409,11 @@ static int hub_configure(struct usb_hub *hub,
 		maxchild = min_t(unsigned, maxchild, USB_SS_MAXPORTS);
 
 	if (hub->descriptor->bNbrPorts > maxchild) {
-		message = "hub has too many ports!";
-		ret = -ENODEV;
-		goto fail;
+		dev_info(hub_dev, "hub has too many ports!\n");
+		return -ENODEV;
 	} else if (hub->descriptor->bNbrPorts == 0) {
-		message = "hub doesn't have any ports!";
-		ret = -ENODEV;
-		goto fail;
+		dev_info(hub_dev, "hub doesn't have any ports!\n");
+		return -ENODEV;
 	}
 
 	/*
-- 
2.8.1

