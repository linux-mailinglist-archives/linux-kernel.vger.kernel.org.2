Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D66B447522
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Nov 2021 20:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhKGTJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Nov 2021 14:09:41 -0500
Received: from vps.xff.cz ([195.181.215.36]:41352 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234631AbhKGTJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Nov 2021 14:09:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1636311517; bh=h4BpOOjQtkAykHCWV6tHGyXVrJ4qCZ6b243KtgEe0Kg=;
        h=From:To:Subject:Date:From;
        b=AgrHm1CySmReXI9I5TU3g6AKiUBPH14YllIHhHauS1GksZCqlSuaKw6giQWwfaT+j
         g0oxZa1PFqMruFOBGJQajN4UCg6WJVzp2Iqpwf6BUkKUBxLTe9ZBWnkZY7buAq5QYs
         qVkalonlK5F/nwNJZjd7SciJnRxspYVly/CxOcjI=
From:   Ondrej Jirman <megous@megous.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Ondrej Jirman <megous@megous.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        kernel test robot <lkp@intel.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support),
        linux-kernel@vger.kernel.org (open list)
Subject: phy: rockchip-inno-usb2: Don't print useless error
Date:   Sun,  7 Nov 2021 19:58:35 +0100
Message-Id: <20211107185836.2540901-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt is optional, make the dmesg not complain about it
missing.

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 428c2313a9cb2..27820bee04eae 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1180,7 +1180,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	phy_cfgs = match->data;
 	rphy->chg_state = USB_CHG_STATE_UNDEFINED;
 	rphy->chg_type = POWER_SUPPLY_TYPE_UNKNOWN;
-	rphy->irq = platform_get_irq(pdev, 0);
+	rphy->irq = platform_get_irq_optional(pdev, 0);
 	platform_set_drvdata(pdev, rphy);
 
 	ret = rockchip_usb2phy_extcon_register(rphy);
-- 
2.33.1

