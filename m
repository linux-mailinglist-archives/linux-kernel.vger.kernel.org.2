Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B3D373162
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 22:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhEDU1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 16:27:35 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:47982 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhEDU1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 16:27:32 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d69 with ME
        id 0kSX2500121Fzsu03kSXNL; Tue, 04 May 2021 22:26:35 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 04 May 2021 22:26:35 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     b-liu@ti.com, gregkh@linuxfoundation.org, matthias.bgg@gmail.com,
        min.guo@mediatek.com, yonglong.wu@mediatek.com
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] usb: musb: Fix an error message
Date:   Tue,  4 May 2021 22:26:29 +0200
Message-Id: <69f514dc7134e3c917cad208e73cc650cb9e2bd6.1620159879.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ret' is known to be 0 here.
Initialize 'ret' with the expected error code before using it.

Fixes: 0990366bab3c ("usb: musb: Add support for MediaTek musb controller")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/usb/musb/mediatek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/musb/mediatek.c b/drivers/usb/musb/mediatek.c
index eebeadd26946..6b92d037d8fc 100644
--- a/drivers/usb/musb/mediatek.c
+++ b/drivers/usb/musb/mediatek.c
@@ -518,8 +518,8 @@ static int mtk_musb_probe(struct platform_device *pdev)
 
 	glue->xceiv = devm_usb_get_phy(dev, USB_PHY_TYPE_USB2);
 	if (IS_ERR(glue->xceiv)) {
-		dev_err(dev, "fail to getting usb-phy %d\n", ret);
 		ret = PTR_ERR(glue->xceiv);
+		dev_err(dev, "fail to getting usb-phy %d\n", ret);
 		goto err_unregister_usb_phy;
 	}
 
-- 
2.30.2

