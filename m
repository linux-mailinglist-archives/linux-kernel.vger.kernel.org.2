Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0880D3F7B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242218AbhHYRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:09:58 -0400
Received: from mail.ispras.ru ([83.149.199.84]:54946 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhHYRJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:09:57 -0400
Received: from hellwig.intra.ispras.ru (unknown [10.10.2.182])
        by mail.ispras.ru (Postfix) with ESMTPS id 93EB240A2BC8;
        Wed, 25 Aug 2021 17:09:03 +0000 (UTC)
From:   Evgeny Novikov <novikov@ispras.ru>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Evgeny Novikov <novikov@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Mike Turquette <mturquette@linaro.org>,
        Kirill Shilimanov <kirill.shilimanov@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] usb: ehci-orion: Handle errors of clk_prepare_enable() in probe
Date:   Wed, 25 Aug 2021 20:09:02 +0300
Message-Id: <20210825170902.11234-1-novikov@ispras.ru>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ehci_orion_drv_probe() did not account for possible errors of
clk_prepare_enable() that in particular could cause invocation of
clk_disable_unprepare() on clocks that were not prepared/enabled yet,
e.g. in remove or on handling errors of usb_add_hcd() in probe. Though,
there were several patches fixing different issues with clocks in this
driver, they did not solve this problem.

Add handling of errors of clk_prepare_enable() in ehci_orion_drv_probe()
to avoid calls of clk_disable_unprepare() without previous successful
invocation of clk_prepare_enable().

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 8c869edaee07 ("ARM: Orion: EHCI: Add support for enabling clocks")
Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Co-developed-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
Signed-off-by: Kirill Shilimanov <kirill.shilimanov@huawei.com>
---
 drivers/usb/host/ehci-orion.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index a319b1df3011..3626758b3e2a 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -264,8 +264,11 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	 * the clock does not exists.
 	 */
 	priv->clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(priv->clk))
-		clk_prepare_enable(priv->clk);
+	if (!IS_ERR(priv->clk)) {
+		err = clk_prepare_enable(priv->clk);
+		if (err)
+			goto err_put_hcd;
+	}
 
 	priv->phy = devm_phy_optional_get(&pdev->dev, "usb");
 	if (IS_ERR(priv->phy)) {
@@ -311,6 +314,7 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 err_dis_clk:
 	if (!IS_ERR(priv->clk))
 		clk_disable_unprepare(priv->clk);
+err_put_hcd:
 	usb_put_hcd(hcd);
 err:
 	dev_err(&pdev->dev, "init %s fail, %d\n",
-- 
2.26.2

