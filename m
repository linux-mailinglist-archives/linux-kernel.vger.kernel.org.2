Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72A43AF206
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 19:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhFURdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 13:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbhFURdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 13:33:32 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7D0C061766
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:31:16 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id d13so26279173ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 10:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=js0VSMNft3m2F3NvErhrcAzo8IyEJqd6W2qFnUrJj00=;
        b=pCloMxiIg0NWb0C1zrjiBE1LiiCv09ojJn/HOOJOiZkawQKf/WmtOgFHWSYmmIA0Aj
         RM2qIVF1wsG13AZXyoEn4LwKj6eo+FOkh45kN6VjdW58wKzvQ42PYtIKoKp0Uj3cT1yg
         8BxrQlOAk1DIPJ15+vFD8e0SHLRSd8hthoXED8hPwriXybsc6c2pvw/HD9MQhRiahM2X
         eSlKPL4vacVwzvElqY0aFUlwrkD/5XNp7YQT9CIhB1lGUfckhJnM3dstI6Yd3XQWcD7X
         4qK2rxWCG3sIz92oQ5c1BfRUqAtAUjPVBy4TCQk1lJnEGgR0djlBPx80sUHWTzMLb8D9
         tttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=js0VSMNft3m2F3NvErhrcAzo8IyEJqd6W2qFnUrJj00=;
        b=ZUbHRxK6PtFK3SEJEj1+vyPa6q06duKRNOL8Z2CgtJf5+wdCJ+AGs72R9yOOyhQgNm
         ri7GiOfXAeCE20N7RMToTfz5gtqLPDip+HCbGEoHB/0jqe3c3pHOAx/4o1G3ZGrlbJe5
         PxVinmOEVYZm5+myVOz0DB1++As7Husy1VNnZsGfaNuPJCtuidSDwdKPlNWMUhwmnGL9
         HybCNbX/4qiaY/ELV5LSlJaZlaXTsRCEmtULUPZBxr1rja6irnKtzk6sjJ5B22VPIAP3
         t9BE/h2kRJ+xRUXQ+uft2g1XssORWpJb33xZsVN5ddAwMRJDqdEmZgql8MpW7MdChYXV
         5hqQ==
X-Gm-Message-State: AOAM530p4tE/vAQxvTjYs+dcsBFuHipLAFrBdMzsZpnlJ6Uusdb8rtAX
        ln3n+V6gMtoayzM8VJVTsfc/+0EHtwq0Hg==
X-Google-Smtp-Source: ABdhPJxVzKe5f/YQcsgpwlTBWd5573FWC2bobSJn98GiNw1b9l8G313qRpE6tGyFo8raAT7obY2qOw==
X-Received: by 2002:a2e:8097:: with SMTP id i23mr22400714ljg.182.1624296675259;
        Mon, 21 Jun 2021 10:31:15 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id u11sm1926380lfs.257.2021.06.21.10.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:31:14 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, linux@armlinux.org.uk,
        jaz@semihalf.com, gjb@semihalf.com, upstream@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, jon@solid-run.com, tn@semihalf.com,
        rjw@rjwysocki.net, lenb@kernel.org, Marcin Wojtas <mw@semihalf.com>
Subject: [net-next: PATCH v3 4/6] net: mvmdio: add ACPI support
Date:   Mon, 21 Jun 2021 19:30:26 +0200
Message-Id: <20210621173028.3541424-5-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210621173028.3541424-1-mw@semihalf.com>
References: <20210621173028.3541424-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introducing ACPI support for the mvmdio driver by adding
acpi_match_table with two entries:

* "MRVL0100" for the SMI operation
* "MRVL0101" for the XSMI mode

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvmdio.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index d14762d93640..7537ee3f6622 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -17,8 +17,10 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/fwnode_mdio.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -281,7 +283,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 	struct orion_mdio_dev *dev;
 	int i, ret;
 
-	type = (enum orion_mdio_bus_type)of_device_get_match_data(&pdev->dev);
+	type = (enum orion_mdio_bus_type)device_get_match_data(&pdev->dev);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
@@ -369,7 +371,7 @@ static int orion_mdio_probe(struct platform_device *pdev)
 		goto out_mdio;
 	}
 
-	ret = of_mdiobus_register(bus, pdev->dev.of_node);
+	ret = fwnode_mdiobus_register(bus, pdev->dev.fwnode);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Cannot register MDIO bus (%d)\n", ret);
 		goto out_mdio;
@@ -421,12 +423,20 @@ static const struct of_device_id orion_mdio_match[] = {
 };
 MODULE_DEVICE_TABLE(of, orion_mdio_match);
 
+static const struct acpi_device_id orion_mdio_acpi_match[] = {
+	{ "MRVL0100", BUS_TYPE_SMI },
+	{ "MRVL0101", BUS_TYPE_XSMI },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, orion_mdio_acpi_match);
+
 static struct platform_driver orion_mdio_driver = {
 	.probe = orion_mdio_probe,
 	.remove = orion_mdio_remove,
 	.driver = {
 		.name = "orion-mdio",
 		.of_match_table = orion_mdio_match,
+		.acpi_match_table = ACPI_PTR(orion_mdio_acpi_match),
 	},
 };
 
-- 
2.29.0

