Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F4D3EAC04
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 22:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbhHLUmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 16:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbhHLUm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 16:42:28 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D87AC0613D9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:42:03 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id a19so8273226qkg.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 13:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jV3+d13+BlvVKdHvamJ73f10IOo4fLZB7GTSxjSftek=;
        b=Zuzv/I+FVw2M1t/wdbOUlEGYA5wI6WSjciqkWH6PkNENhgzU7aEEOSpytnvm6JeFx2
         4yfRx0/OqCAaXHSirS/WBw8P3LYKXW73J3xBwgI4bZkRcPMLQJwZ9jpmlMAm0lQW++II
         9t7Q/GGv2IqZpo3msgGdg8gQ0vQSxckuX2fY4Alo+u4JiWe+OWkD161oAC9q9L0m4Wdn
         r4cXp1qL9SFiEg80fluK6LUxXsfpHX635NZSep6qMh9mBf1YdnsZx00VuOk0w0ojM6RE
         7WZQXXLie1tVGh5AAk6FYKjo62SGBTwgVqDANoDVRgLgnqHaF/Ys04FYF1hqj4wj7Kp/
         tp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jV3+d13+BlvVKdHvamJ73f10IOo4fLZB7GTSxjSftek=;
        b=lqq2PW/hr4cwmu4+oVu+Rj212id0FqeE8ToTr4lZv0HkxZUA470DhQHT03cGNGnaGF
         AG8EOnk0SXgMKy8zWM8xtL+e1w+oET0wOnm6vlpGafNRv+xVEtu710NaBuVin8zBXZYM
         szKCU/ltSVFQjs34fXFwsdFEq8C9naOJxSplK7P/JCx0acXcZsB8iVAgCYnDxevsYLYq
         Dq0qx84XfXtzmT+F5jlcEWRQZbVgkWlKuSaSYxlOjye374C8bcPWoZO9UeXy2m0SHjli
         2grNTSNWaHWBq8bVRoiimwm8WSY9se79SHDyZQ9+FoTgy8TvEFJl2Etjlnb3K8D/CU7H
         hdug==
X-Gm-Message-State: AOAM5326OJgC6G1+FTLWYHyWntPzfw5CXduHcCzYhA0IYnk9ayT43fAD
        FEQUFp2vEKq1qgSWNLkW35k=
X-Google-Smtp-Source: ABdhPJyrnT6PORGjrTDgySqbzkzSUbFYzqIA1bWHZIgwb7kGDQIv/+5gNYYb0UkJSgl3ItgM3Weaiw==
X-Received: by 2002:a05:620a:22b0:: with SMTP id p16mr6668847qkh.346.1628800922084;
        Thu, 12 Aug 2021 13:42:02 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:e89f:d077:9161:1bd7])
        by smtp.gmail.com with ESMTPSA id m16sm1940361qki.19.2021.08.12.13.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 13:42:01 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/8] phy: phy-rockchip-inno-usb2: support muxed interrupts
Date:   Thu, 12 Aug 2021 16:41:13 -0400
Message-Id: <20210812204116.2303617-6-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210812204116.2303617-1-pgwipeout@gmail.com>
References: <20210812204116.2303617-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3568 usb2phy has a single muxed interrupt that handles all
interrupts.
Allow the driver to plug in only a single interrupt as necessary.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 168 +++++++++++++-----
 1 file changed, 119 insertions(+), 49 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 84a0c1d697da..fdeb2e7c937a 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -204,6 +204,7 @@ struct rockchip_usb2phy_port {
  * @dcd_retries: The retry count used to track Data contact
  *		 detection process.
  * @edev: extcon device for notification registration
+ * @irq: muxed interrupt for single irq configuration
  * @phy_cfg: phy register configuration, assigned by driver data.
  * @ports: phy port instance.
  */
@@ -218,6 +219,7 @@ struct rockchip_usb2phy {
 	enum power_supply_type	chg_type;
 	u8			dcd_retries;
 	struct extcon_dev	*edev;
+	int			irq;
 	const struct rockchip_usb2phy_cfg	*phy_cfg;
 	struct rockchip_usb2phy_port	ports[USB2PHY_NUM_PORTS];
 };
@@ -934,6 +936,102 @@ static irqreturn_t rockchip_usb2phy_otg_mux_irq(int irq, void *data)
 		return IRQ_NONE;
 }
 
+static irqreturn_t rockchip_usb2phy_irq(int irq, void *data)
+{
+	struct rockchip_usb2phy *rphy = data;
+	struct rockchip_usb2phy_port *rport;
+	irqreturn_t ret = IRQ_NONE;
+	unsigned int index;
+
+	for (index = 0; index < rphy->phy_cfg->num_ports; index++) {
+		rport = &rphy->ports[index];
+		if (!rport->phy)
+			continue;
+
+		/* Handle linestate irq for both otg port and host port */
+		ret = rockchip_usb2phy_linestate_irq(irq, rport);
+	}
+
+	return ret;
+}
+
+static int rockchip_usb2phy_port_irq_init(struct rockchip_usb2phy *rphy,
+					  struct rockchip_usb2phy_port *rport,
+					  struct device_node *child_np)
+{
+	int ret;
+
+	/*
+	 * If the usb2 phy used combined irq for otg and host port,
+	 * don't need to init otg and host port irq separately.
+	 */
+	if (rphy->irq > 0)
+		return 0;
+
+	switch (rport->port_id) {
+	case USB2PHY_PORT_HOST:
+		rport->ls_irq = of_irq_get_byname(child_np, "linestate");
+		if (rport->ls_irq < 0) {
+			dev_err(rphy->dev, "no linestate irq provided\n");
+			return rport->ls_irq;
+		}
+
+		ret = devm_request_threaded_irq(rphy->dev, rport->ls_irq, NULL,
+						rockchip_usb2phy_linestate_irq,
+						IRQF_ONESHOT,
+						"rockchip_usb2phy", rport);
+		if (ret) {
+			dev_err(rphy->dev, "failed to request linestate irq handle\n");
+			return ret;
+		}
+		break;
+	case USB2PHY_PORT_OTG:
+		/*
+		 * Some SoCs use one interrupt with otg-id/otg-bvalid/linestate
+		 * interrupts muxed together, so probe the otg-mux interrupt first,
+		 * if not found, then look for the regular interrupts one by one.
+		 */
+		rport->otg_mux_irq = of_irq_get_byname(child_np, "otg-mux");
+		if (rport->otg_mux_irq > 0) {
+			ret = devm_request_threaded_irq(rphy->dev, rport->otg_mux_irq,
+							NULL,
+							rockchip_usb2phy_otg_mux_irq,
+							IRQF_ONESHOT,
+							"rockchip_usb2phy_otg",
+							rport);
+			if (ret) {
+				dev_err(rphy->dev,
+					"failed to request otg-mux irq handle\n");
+				return ret;
+			}
+		} else {
+			rport->bvalid_irq = of_irq_get_byname(child_np, "otg-bvalid");
+			if (rport->bvalid_irq < 0) {
+				dev_err(rphy->dev, "no vbus valid irq provided\n");
+				ret = rport->bvalid_irq;
+				return ret;
+			}
+
+			ret = devm_request_threaded_irq(rphy->dev, rport->bvalid_irq,
+							NULL,
+							rockchip_usb2phy_bvalid_irq,
+							IRQF_ONESHOT,
+							"rockchip_usb2phy_bvalid",
+							rport);
+			if (ret) {
+				dev_err(rphy->dev,
+					"failed to request otg-bvalid irq handle\n");
+				return ret;
+			}
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int rockchip_usb2phy_host_port_init(struct rockchip_usb2phy *rphy,
 					   struct rockchip_usb2phy_port *rport,
 					   struct device_node *child_np)
@@ -947,18 +1045,9 @@ static int rockchip_usb2phy_host_port_init(struct rockchip_usb2phy *rphy,
 	mutex_init(&rport->mutex);
 	INIT_DELAYED_WORK(&rport->sm_work, rockchip_usb2phy_sm_work);
 
-	rport->ls_irq = of_irq_get_byname(child_np, "linestate");
-	if (rport->ls_irq < 0) {
-		dev_err(rphy->dev, "no linestate irq provided\n");
-		return rport->ls_irq;
-	}
-
-	ret = devm_request_threaded_irq(rphy->dev, rport->ls_irq, NULL,
-					rockchip_usb2phy_linestate_irq,
-					IRQF_ONESHOT,
-					"rockchip_usb2phy", rport);
+	ret = rockchip_usb2phy_port_irq_init(rphy, rport, child_np);
 	if (ret) {
-		dev_err(rphy->dev, "failed to request linestate irq handle\n");
+		dev_err(rphy->dev, "failed to setup host irq\n");
 		return ret;
 	}
 
@@ -1007,44 +1096,10 @@ static int rockchip_usb2phy_otg_port_init(struct rockchip_usb2phy *rphy,
 	INIT_DELAYED_WORK(&rport->chg_work, rockchip_chg_detect_work);
 	INIT_DELAYED_WORK(&rport->otg_sm_work, rockchip_usb2phy_otg_sm_work);
 
-	/*
-	 * Some SoCs use one interrupt with otg-id/otg-bvalid/linestate
-	 * interrupts muxed together, so probe the otg-mux interrupt first,
-	 * if not found, then look for the regular interrupts one by one.
-	 */
-	rport->otg_mux_irq = of_irq_get_byname(child_np, "otg-mux");
-	if (rport->otg_mux_irq > 0) {
-		ret = devm_request_threaded_irq(rphy->dev, rport->otg_mux_irq,
-						NULL,
-						rockchip_usb2phy_otg_mux_irq,
-						IRQF_ONESHOT,
-						"rockchip_usb2phy_otg",
-						rport);
-		if (ret) {
-			dev_err(rphy->dev,
-				"failed to request otg-mux irq handle\n");
-			goto out;
-		}
-	} else {
-		rport->bvalid_irq = of_irq_get_byname(child_np, "otg-bvalid");
-		if (rport->bvalid_irq < 0) {
-			dev_err(rphy->dev, "no vbus valid irq provided\n");
-			ret = rport->bvalid_irq;
-			goto out;
-		}
-
-		ret = devm_request_threaded_irq(rphy->dev, rport->bvalid_irq,
-						NULL,
-						rockchip_usb2phy_bvalid_irq,
-						IRQF_ONESHOT,
-						"rockchip_usb2phy_bvalid",
-						rport);
-		if (ret) {
-			dev_err(rphy->dev,
-				"failed to request otg-bvalid irq handle\n");
-			goto out;
-		}
-	}
+	ret = rockchip_usb2phy_port_irq_init(rphy, rport, child_np);
+	if (ret) {
+		dev_err(rphy->dev, "failed to init irq for host port\n");
+		goto out;
 
 	if (!IS_ERR(rphy->edev)) {
 		rport->event_nb.notifier_call = rockchip_otg_event;
@@ -1124,6 +1179,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	phy_cfgs = match->data;
 	rphy->chg_state = USB_CHG_STATE_UNDEFINED;
 	rphy->chg_type = POWER_SUPPLY_TYPE_UNKNOWN;
+	rphy->irq = platform_get_irq(pdev, 0);
 	platform_set_drvdata(pdev, rphy);
 
 	ret = rockchip_usb2phy_extcon_register(rphy);
@@ -1201,6 +1257,20 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	}
 
 	provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	if (rphy->irq > 0) {
+		ret = devm_request_threaded_irq(rphy->dev, rphy->irq, NULL,
+						rockchip_usb2phy_irq,
+						IRQF_ONESHOT,
+						"rockchip_usb2phy",
+						rphy);
+		if (ret) {
+			dev_err(rphy->dev,
+				"failed to request usb2phy irq handle\n");
+			goto put_child;
+		}
+	}
+
 	return PTR_ERR_OR_ZERO(provider);
 
 put_child:
-- 
2.25.1

