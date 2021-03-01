Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 736FC329F69
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 13:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573927AbhCBD2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:28:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:51394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238936AbhCAUdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 15:33:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C51664FE7;
        Mon,  1 Mar 2021 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614617887;
        bh=QsTUp8bQsQpd8ulOBfV2MbPHQmo7AQ+qGIkRfCUfRSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddzsywtyvLKzSV47oDZoh/rues7NnzQe/FJ+0CgboS1IvbyQcSJlJAO8u5tDqwR7w
         dNk3YZIKaW6oRvogQVq8i9FeaDeaLE036pNuWNsA/STqLlXaiofCMJHNKVurRRLgXk
         MyzGhdFeLQnhPZhVnNRhDdzQ0L2fVCuzhFE53Z5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Douglas Anderson <dianders@chromium.org>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 202/340] phy: rockchip-emmc: emmc_phy_init() always return 0
Date:   Mon,  1 Mar 2021 17:12:26 +0100
Message-Id: <20210301161058.248227924@linuxfoundation.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301161048.294656001@linuxfoundation.org>
References: <20210301161048.294656001@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Ruehl <chris.ruehl@gtsys.com.hk>

[ Upstream commit 39961bd6b70e5a5d7c4b5483ad8e1db6b5765c60 ]

rockchip_emmc_phy_init() return variable is not set with the error value
if clk_get() failed. 'emmcclk' is optional, thus use clk_get_optional()
and if the return value != NULL make error processing and set the
return code accordingly.

Fixes: 52c0624a10cce phy: rockchip-emmc: Set phyctrl_frqsel based on card clock
Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20201210080454.17379-1-chris.ruehl@gtsys.com.hk
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/rockchip/phy-rockchip-emmc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-emmc.c b/drivers/phy/rockchip/phy-rockchip-emmc.c
index 2dc19ddd120f5..a005fc58bbf02 100644
--- a/drivers/phy/rockchip/phy-rockchip-emmc.c
+++ b/drivers/phy/rockchip/phy-rockchip-emmc.c
@@ -240,15 +240,17 @@ static int rockchip_emmc_phy_init(struct phy *phy)
 	 * - SDHCI driver to get the PHY
 	 * - SDHCI driver to init the PHY
 	 *
-	 * The clock is optional, so upon any error we just set to NULL.
+	 * The clock is optional, using clk_get_optional() to get the clock
+	 * and do error processing if the return value != NULL
 	 *
 	 * NOTE: we don't do anything special for EPROBE_DEFER here.  Given the
 	 * above expected use case, EPROBE_DEFER isn't sensible to expect, so
 	 * it's just like any other error.
 	 */
-	rk_phy->emmcclk = clk_get(&phy->dev, "emmcclk");
+	rk_phy->emmcclk = clk_get_optional(&phy->dev, "emmcclk");
 	if (IS_ERR(rk_phy->emmcclk)) {
-		dev_dbg(&phy->dev, "Error getting emmcclk: %d\n", ret);
+		ret = PTR_ERR(rk_phy->emmcclk);
+		dev_err(&phy->dev, "Error getting emmcclk: %d\n", ret);
 		rk_phy->emmcclk = NULL;
 	}
 
-- 
2.27.0



