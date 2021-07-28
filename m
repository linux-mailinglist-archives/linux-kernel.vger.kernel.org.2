Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A063D8DB8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhG1M0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhG1M0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:26:24 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E36FC061798;
        Wed, 28 Jul 2021 05:26:22 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id h27so1150794qtu.9;
        Wed, 28 Jul 2021 05:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yXImnqZERav+3w/cyHb8wggYxQXzQW+9n8PpB8P0B2M=;
        b=nTf1Rh+IBTk37Ypl1bqpBx/ym8f/2c2cD3boqnDXbg49T69of7n1FZDMO2lodZfo+a
         FKJNsHP0XHimKRL+HQlTOcMoynXQ9O+9daG3gi72aE2zeB6DLbbU9JfsyBgQyxC9VB6f
         daLU/ljVyIzhnLLbfiJuAcZBXCUx5tVouRLb24L2gqz46/YJ6e7yizBxeBmp5N1+WXn6
         5e0AMP9nmpTRllygLdkCHbRhcvDHefqLLp2+jUUQCum5pdeCxrzjOavdKnkqf2kQq6xM
         /TzWidxzOB7B6Q8oMYlBvLZ6uH0P9VaJGMKCmjefY85M1JWvC/SmORGEvlx4TGkOQnkG
         WhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXImnqZERav+3w/cyHb8wggYxQXzQW+9n8PpB8P0B2M=;
        b=NsUDoB4BMstO1VNum3byAz1H4L3x9hrUTN4xRYcGB/sLgd+c9zH8UBCM0DcNnLZyY8
         vFzhCQv6KgvK9gdeQ5Z+nmX00yVE4EEXuWqkl2jXj36shsNtSgu6qPc2YVrTn9Q4YZMD
         LBT4VMIRsV8JuGI+VzxC+NT7lGYLt9Q6yNjCwL+8z5AjuU0NXKKaMiq9IsfT8I1Z3Jk0
         bSp+VHxceIFvO3bAqdOLr4b8nxUMXXXbNqyG3/nuV7Adl6q1KO3nehITpcdeU8KZTXR4
         LAMhIHXPtATSqDR+/f4ER22KVHuc1RvXSrDrqlUBgwEjqo7gAc9fwsplFYGdKJntNWCe
         hSMA==
X-Gm-Message-State: AOAM530iGujl9whS0zZ3Q2vCX6cgNmtLPucab/dAoW5b96EjTM5Urous
        IWyuhYgxbQORtnKsGrnHKJw=
X-Google-Smtp-Source: ABdhPJyWW6C88y7pL6cKMtwywRISt6YmNQd6o2KFh32MLgLwlTNoYrvvX7m/LDxvsGY6ke0R8rGdzg==
X-Received: by 2002:ac8:5210:: with SMTP id r16mr16895190qtn.344.1627475181525;
        Wed, 28 Jul 2021 05:26:21 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id z9sm2842972qtn.54.2021.07.28.05.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:26:21 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 5/9] phy: phy-rockchip-inno-usb2: support standalone phy nodes
Date:   Wed, 28 Jul 2021 08:26:02 -0400
Message-Id: <20210728122606.697619-6-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728122606.697619-1-pgwipeout@gmail.com>
References: <20210728122606.697619-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Rockchip devices have the usb2 phy devices as standalone nodes
instead of children of the grf node.
Allow the driver to find the grf node from a phandle.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 5d2916143df7..84a0c1d697da 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1081,12 +1081,19 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (!dev->parent || !dev->parent->of_node)
-		return -EINVAL;
+	if (!dev->parent || !dev->parent->of_node) {
+		rphy->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,usbgrf");
+		if (IS_ERR(rphy->grf)) {
+			dev_err(dev, "failed to locate usbgrf\n");
+			return PTR_ERR(rphy->grf);
+		}
+	}
 
-	rphy->grf = syscon_node_to_regmap(dev->parent->of_node);
-	if (IS_ERR(rphy->grf))
-		return PTR_ERR(rphy->grf);
+	else {
+		rphy->grf = syscon_node_to_regmap(dev->parent->of_node);
+			if (IS_ERR(rphy->grf))
+				return PTR_ERR(rphy->grf);
+	}
 
 	if (of_device_is_compatible(np, "rockchip,rv1108-usb2phy")) {
 		rphy->usbgrf =
-- 
2.25.1

