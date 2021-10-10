Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73124280D6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Oct 2021 13:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhJJLfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 07:35:20 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:57012 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231556AbhJJLfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 07:35:19 -0400
Received: from pop-os.home ([90.126.248.220])
        by mwinf5d73 with ME
        id 4BZH2600A4m3Hzu03BZHvZ; Sun, 10 Oct 2021 13:33:20 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Oct 2021 13:33:20 +0200
X-ME-IP: 90.126.248.220
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        yangyingliang@huawei.com
Cc:     linux-geode@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] USB: gadget: udc: Remove some dead code
Date:   Sun, 10 Oct 2021 13:33:16 +0200
Message-Id: <9a85b2353843b95e2d86acb3103967fd405a8536.1633865503.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'drd_wq' workqueue_struct has never been used.
It is only destroyed, but never created.

It was introduced in commit 1b9f35adb0ff ("usb: gadget: udc: Add Synopsys
UDC Platform driver")

Remove the corresponding dead code and save some space from the 'udc'
structure.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/gadget/udc/amd5536udc.h    | 1 -
 drivers/usb/gadget/udc/snps_udc_plat.c | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/amd5536udc.h b/drivers/usb/gadget/udc/amd5536udc.h
index 3296f3fcee48..055436016503 100644
--- a/drivers/usb/gadget/udc/amd5536udc.h
+++ b/drivers/usb/gadget/udc/amd5536udc.h
@@ -572,7 +572,6 @@ struct udc {
 	struct extcon_specific_cable_nb	extcon_nb;
 	struct notifier_block		nb;
 	struct delayed_work		drd_work;
-	struct workqueue_struct		*drd_wq;
 	u32				conn_type;
 };
 
diff --git a/drivers/usb/gadget/udc/snps_udc_plat.c b/drivers/usb/gadget/udc/snps_udc_plat.c
index 99805d60a7ab..8bbb89c80348 100644
--- a/drivers/usb/gadget/udc/snps_udc_plat.c
+++ b/drivers/usb/gadget/udc/snps_udc_plat.c
@@ -243,11 +243,6 @@ static int udc_plat_remove(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, NULL);
 
-	if (dev->drd_wq) {
-		flush_workqueue(dev->drd_wq);
-		destroy_workqueue(dev->drd_wq);
-	}
-
 	phy_power_off(dev->udc_phy);
 	phy_exit(dev->udc_phy);
 	extcon_unregister_notifier(dev->edev, EXTCON_USB, &dev->nb);
-- 
2.30.2

