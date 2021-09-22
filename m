Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F552414A02
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhIVNCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:02:07 -0400
Received: from mx24.baidu.com ([111.206.215.185]:55714 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231585AbhIVNCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:02:02 -0400
Received: from BJHW-Mail-Ex05.internal.baidu.com (unknown [10.127.64.15])
        by Forcepoint Email with ESMTPS id 720D3FAF1D7B11E54F0B;
        Wed, 22 Sep 2021 21:00:31 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex05.internal.baidu.com (10.127.64.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 22 Sep 2021 21:00:31 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Wed, 22 Sep 2021 21:00:30 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: rockchip-inno-usb2: Make use of the helper function devm_add_action_or_reset()
Date:   Wed, 22 Sep 2021 21:00:23 +0800
Message-ID: <20210922130024.745-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex09.internal.baidu.com (10.127.64.32) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex05_2021-09-22 21:00:31:487
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper function devm_add_action_or_reset() will internally
call devm_add_action(), and gif devm_add_action() fails then it will
execute the action mentioned and return the error code. So
use devm_add_action_or_reset() instead of devm_add_action()
to simplify the error handling, reduce the code.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 4f569d9307b9..1938365abbb3 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -321,7 +321,7 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
 	struct device_node *node = rphy->dev->of_node;
 	struct clk_init_data init;
 	const char *clk_name;
-	int ret;
+	int ret = 0;
 
 	init.flags = 0;
 	init.name = "clk_usbphy_480m";
@@ -352,15 +352,8 @@ rockchip_usb2phy_clk480m_register(struct rockchip_usb2phy *rphy)
 	if (ret < 0)
 		goto err_clk_provider;
 
-	ret = devm_add_action(rphy->dev, rockchip_usb2phy_clk480m_unregister,
-			      rphy);
-	if (ret < 0)
-		goto err_unreg_action;
-
-	return 0;
+	return devm_add_action_or_reset(rphy->dev, rockchip_usb2phy_clk480m_unregister, rphy);
 
-err_unreg_action:
-	of_clk_del_provider(node);
 err_clk_provider:
 	clk_unregister(rphy->clk480m);
 err_ret:
-- 
2.25.1

