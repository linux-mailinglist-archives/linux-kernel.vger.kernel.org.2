Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E05D3567E3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 11:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhDGJY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 05:24:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15155 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350055AbhDGJYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 05:24:01 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FFf5W5fH3zpVyC;
        Wed,  7 Apr 2021 17:21:03 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Wed, 7 Apr 2021
 17:23:47 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>
CC:     <vkoul@kernel.org>, <kishon@ti.com>
Subject: [PATCH -next] phy: phy-twl4030-usb: Fix possible use-after-free in twl4030_usb_remove()
Date:   Wed, 7 Apr 2021 17:27:16 +0800
Message-ID: <20210407092716.3270248-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver's remove path calls cancel_delayed_work(). However, that
function does not wait until the work function finishes. This means
that the callback function may still be running after the driver's
remove function has finished, which would result in a use-after-free.

Fix by calling cancel_delayed_work_sync(), which ensures that
the work is properly cancelled, no longer running, and unable
to re-schedule itself.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/phy/ti/phy-twl4030-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
index 9887f908f540..812e5409d359 100644
--- a/drivers/phy/ti/phy-twl4030-usb.c
+++ b/drivers/phy/ti/phy-twl4030-usb.c
@@ -779,7 +779,7 @@ static int twl4030_usb_remove(struct platform_device *pdev)
 
 	usb_remove_phy(&twl->phy);
 	pm_runtime_get_sync(twl->dev);
-	cancel_delayed_work(&twl->id_workaround_work);
+	cancel_delayed_work_sync(&twl->id_workaround_work);
 	device_remove_file(twl->dev, &dev_attr_vbus);
 
 	/* set transceiver mode to power on defaults */
-- 
2.25.1

