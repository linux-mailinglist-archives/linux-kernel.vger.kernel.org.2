Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CC73A7CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhFOLKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:10:12 -0400
Received: from foss.arm.com ([217.140.110.172]:60726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229977AbhFOLJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:09:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FBD3143B;
        Tue, 15 Jun 2021 04:07:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE4A43F719;
        Tue, 15 Jun 2021 04:07:28 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ondrej Jirman <megous@megous.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v7 13/19] phy: sun4i-usb: Allow reset line to be shared
Date:   Tue, 15 Jun 2021 12:06:30 +0100
Message-Id: <20210615110636.23403-14-andre.przywara@arm.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210615110636.23403-1-andre.przywara@arm.com>
References: <20210615110636.23403-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB HCIs (and PHYs?) in Allwinner's newer generation SoCs (H616)
rely on the reset line of USB PHY 2 to be de-asserted, even when only
one of the other PHYs is actually in use.

To make those ports work, we include this reset line in the HCIs' resets
property, which requires this line to be shareable.

Change the call to allocate the reset line to mark it as shared, to
enable the other ports on those SoCs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 142f4cafdc78..126ef74d013c 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -788,7 +788,7 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
 		}
 
 		snprintf(name, sizeof(name), "usb%d_reset", i);
-		phy->reset = devm_reset_control_get(dev, name);
+		phy->reset = devm_reset_control_get_shared(dev, name);
 		if (IS_ERR(phy->reset)) {
 			dev_err(dev, "failed to get reset %s\n", name);
 			return PTR_ERR(phy->reset);
-- 
2.17.5

