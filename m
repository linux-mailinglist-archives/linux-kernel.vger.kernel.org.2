Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602753F0BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 21:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbhHRTdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 15:33:19 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:38599 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229965AbhHRTdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 15:33:18 -0400
Received: from pop-os.home ([90.126.253.178])
        by mwinf5d76 with ME
        id j7Yf250073riaq2037YfrR; Wed, 18 Aug 2021 21:32:41 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 18 Aug 2021 21:32:41 +0200
X-ME-IP: 90.126.253.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     alcooperx@gmail.com, balbi@kernel.org, gregkh@linuxfoundation.org,
        f.fainelli@gmail.com
Cc:     linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] usb: bdc: Fix an error handling path in 'bdc_probe()' when no suitable DMA config is available
Date:   Wed, 18 Aug 2021 21:32:38 +0200
Message-Id: <0c5910979f39225d5d8fe68c9ab1c147c68ddee1.1629314734.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If no suitable DMA configuration is available, a previous 'bdc_phy_init()'
call must be undone by a corresponding 'bdc_phy_exit()' call.

Branch to the existing error handling path instead of returning
directly.

Fixes: cc29d4f67757 ("usb: bdc: Add support for USB phy")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
checkpatch.pl warns that:
   WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
   #29: FILE: drivers/usb/gadget/udc/bdc/bdc_core.c:563:
   +			ret = -ENOTSUPP;
I've never seen this warning before and don't want to make a blind fix for that.
Let me know if I should fix it or not.
---
drivers/usb/gadget/udc/bdc/bdc_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
index 0bef6b3f049b..251db57e51fa 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_core.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
@@ -560,7 +560,8 @@ static int bdc_probe(struct platform_device *pdev)
 		if (ret) {
 			dev_err(dev,
 				"No suitable DMA config available, abort\n");
-			return -ENOTSUPP;
+			ret = -ENOTSUPP;
+			goto phycleanup;
 		}
 		dev_dbg(dev, "Using 32-bit address\n");
 	}
-- 
2.30.2

