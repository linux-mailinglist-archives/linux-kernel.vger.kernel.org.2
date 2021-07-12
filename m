Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6703C5315
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 12:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352108AbhGLHw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 03:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244030AbhGLHSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 03:18:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92BED61480;
        Mon, 12 Jul 2021 07:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626074116;
        bh=ZSYyLpThU7atOFT/NZaiJUxPgyF+d7cTrL7oB5a3JnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TVJ4ClZqZIE7s/6NcQepqRNjFO421uhOX5YDONDm5I5jnpV+R3+z4vvazFhRYerm7
         /qrkOz8B9ToVaOOMf9lpReS+/REm+bsj0wPgGRYzekrq1LuekthVoUUraYSy+0rkno
         P9SaF/2kXJufoVmjppiSA5Nq6B4GNZO8Sj+3x4DU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Skripkin <paskripkin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.12 443/700] net: ethernet: ezchip: fix error handling
Date:   Mon, 12 Jul 2021 08:08:46 +0200
Message-Id: <20210712061023.636834003@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712060924.797321836@linuxfoundation.org>
References: <20210712060924.797321836@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

[ Upstream commit 0de449d599594f5472e00267d651615c7f2c6c1d ]

As documented at drivers/base/platform.c for platform_get_irq:

 * Gets an IRQ for a platform device and prints an error message if finding the
 * IRQ fails. Device drivers should check the return value for errors so as to
 * not pass a negative integer value to the request_irq() APIs.

So, the driver should check that platform_get_irq() return value
is _negative_, not that it's equal to zero, because -ENXIO (return
value from request_irq() if irq was not found) will
pass this check and it leads to passing negative irq to request_irq()

Fixes: 0dd077093636 ("NET: Add ezchip ethernet driver")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/ezchip/nps_enet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ezchip/nps_enet.c b/drivers/net/ethernet/ezchip/nps_enet.c
index 026a3ec19b6e..3d74401b4f10 100644
--- a/drivers/net/ethernet/ezchip/nps_enet.c
+++ b/drivers/net/ethernet/ezchip/nps_enet.c
@@ -610,7 +610,7 @@ static s32 nps_enet_probe(struct platform_device *pdev)
 
 	/* Get IRQ number */
 	priv->irq = platform_get_irq(pdev, 0);
-	if (!priv->irq) {
+	if (priv->irq < 0) {
 		dev_err(dev, "failed to retrieve <irq Rx-Tx> value from device tree\n");
 		err = -ENODEV;
 		goto out_netdev;
-- 
2.30.2



