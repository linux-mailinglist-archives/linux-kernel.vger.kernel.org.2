Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DBE3D8DB9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 14:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhG1M0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 08:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbhG1M0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 08:26:25 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15335C061799;
        Wed, 28 Jul 2021 05:26:23 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id t68so1941145qkf.8;
        Wed, 28 Jul 2021 05:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sLsXOi/Vd6SWXJJX1GfqgWGuuId516J+Mh4hAEOUuFE=;
        b=a1N/dN4xR1XWNZDY/J2oCSI8VOFv6WyuuZc6bd9tByJFeMuPk0nLuph02ZsMRNmMJC
         As6MIuOfMHuoG0kLAqb6PTZlB2YOvprxnCe+oDd+q+XQjpsG3hIDiWuD9FfheeSzFq3L
         Y8+G/fpEK8FoWd2xyuRF9MqPMEP4Nc3L6MqOnHfLDvpi32dktXWmMZYG/QoP4GWtIiae
         F8x+hDSyPNgVx+xyg6VofwIXouKi9v8bqj6koUXSQTfTl/PyA0TtoHa/huwPqJsGw+CK
         5afMnDrgcQxrFbqa6hew93JQHPmUVx1C+YVBeBeTpqtMH453Gq0tZm5BAYk12HEb1sXl
         3YVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLsXOi/Vd6SWXJJX1GfqgWGuuId516J+Mh4hAEOUuFE=;
        b=RHKWz9SvfqjrSi00T4OeNkAQ7Y55lmGUYKn019yklP5tezm8UVVF06wf2jf39f59hJ
         QQhlDu3zXkctxrCwzFtBAwmApGRyFN9X0TXeYq7LOoIGulWdDlNkzMHaS6UuFC7O34z5
         9f/Q+HYU/2/nekFBEG9mcS70fb2G0cFqC5nVdAifJerEJG4gdQIwCtw1CsTkL63EqB6D
         Ge8bKlk2qFkqy3OFbQxZ9mg3XUPx4CeTfciKG2jlY0s2YCKj0wc28eoZTlVLMyeWzZ7F
         h3XNkAInluqyVqp4pnEnNPKw0Y8pVVK/jyoewoo/b5BJzrb5yWEjQESWLEfUa/0mPlM+
         TeMA==
X-Gm-Message-State: AOAM530miVtbNmJLjDIzwnylzCKlJNggyRnVgq/9/qhmxdYgiILJIPVA
        idtPJj7f5yzGdQnJ6hb8cII=
X-Google-Smtp-Source: ABdhPJzguoTTyVVCd2JnPZcYbW8796g1C5ngdVomfVwumL+wn6oZIGKb9Nkd0LNxQXyhLUJvIjQQEw==
X-Received: by 2002:a37:40c2:: with SMTP id n185mr9799919qka.50.1627475182223;
        Wed, 28 Jul 2021 05:26:22 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id z9sm2842972qtn.54.2021.07.28.05.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 05:26:21 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Peter Geis <pgwipeout@gmail.com>
Subject: [RFC PATCH 6/9] phy: phy-rockchip-inno-usb2: support muxed interrupts
Date:   Wed, 28 Jul 2021 08:26:03 -0400
Message-Id: <20210728122606.697619-7-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728122606.697619-1-pgwipeout@gmail.com>
References: <20210728122606.697619-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3568 usb2phy has a single muxed interrupt that handles all
interrupts.
Allow the driver to plug in only a single interrupt as necessary.

This currently only supports the host configuration for the new phy.

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

