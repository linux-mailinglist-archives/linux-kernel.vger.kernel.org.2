Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630A13E2371
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 08:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243384AbhHFGqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 02:46:33 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:60626 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhHFGqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 02:46:32 -0400
Received: from localhost.localdomain ([217.128.214.245])
        by mwinf5d69 with ME
        id e6mC2500F5JEng9036mDmZ; Fri, 06 Aug 2021 08:46:16 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 06 Aug 2021 08:46:16 +0200
X-ME-IP: 217.128.214.245
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     nsaenz@kernel.org, f.fainelli@gmail.com,
        gregkh@linuxfoundation.org, bgolaszewski@baylibre.com,
        sboyd@kernel.org, wangqing@vivo.com, eric@anholt.net,
        swarren@wwwdotorg.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] firmware: raspberrypi: Fix a leak in 'rpi_firmware_get()'
Date:   Fri,  6 Aug 2021 08:46:11 +0200
Message-Id: <5e17e5409b934cd08bf6f9279c73be5c1cb11cce.1628232242.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.

Add the corresponding 'put_device()' in the normal and error handling
paths.

Fixes: 4e3d60656a72 ("ARM: bcm2835: Add the Raspberry Pi firmware driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Review carefully, management of reference counted resources is sometimes
tricky.

I also think that a 'put_device()' just after the 'platform_get_drvdata()'
call, and before the 'if (!fw)', could be enough, but I find the
proposed version more easy to follow.
---
 drivers/firmware/raspberrypi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 250e01680742..4b8978b254f9 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -329,12 +329,18 @@ struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
 
 	fw = platform_get_drvdata(pdev);
 	if (!fw)
-		return NULL;
+		goto err_put_device;
 
 	if (!kref_get_unless_zero(&fw->consumers))
-		return NULL;
+		goto err_put_device;
+
+	put_device(&pdev->dev);
 
 	return fw;
+
+err_put_device:
+	put_device(&pdev->dev);
+	return NULL;
 }
 EXPORT_SYMBOL_GPL(rpi_firmware_get);
 
-- 
2.30.2

