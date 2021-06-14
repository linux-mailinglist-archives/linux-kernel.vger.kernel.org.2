Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699CA3A6AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbhFNPqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234160AbhFNPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:46:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20BAC061767;
        Mon, 14 Jun 2021 08:44:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2a01:e0a:4cb:a870:1f5e:e45f:238:7e73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B783A1F42B1C;
        Mon, 14 Jun 2021 16:44:10 +0100 (BST)
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org,
        heiko@sntech.de, pgwipeout@gmail.com
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH 3/4] PHY: rockchip: USB2: Allow 64 bits reg property
Date:   Mon, 14 Jun 2021 17:43:58 +0200
Message-Id: <20210614154359.805555-4-benjamin.gaignard@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
References: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rk356x device-tree "reg" property could be coded on 64 bits.
Change reg type and of_property_read_ to make it works.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 46ebdb1460a3d..45518f96d7217 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1068,7 +1068,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	struct rockchip_usb2phy *rphy;
 	const struct rockchip_usb2phy_cfg *phy_cfgs;
 	const struct of_device_id *match;
-	unsigned int reg;
+	u64 reg;
 	int index, ret;
 
 	rphy = devm_kzalloc(dev, sizeof(*rphy), GFP_KERNEL);
@@ -1098,7 +1098,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		rphy->usbgrf = NULL;
 	}
 
-	if (of_property_read_u32(np, "reg", &reg)) {
+	if (of_property_read_u64(np, "reg", &reg)) {
 		dev_err(dev, "the reg property is not assigned in %pOFn node\n",
 			np);
 		return -EINVAL;
-- 
2.25.1

