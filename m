Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622EC39C6D4
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 10:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbhFEIgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 04:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFEIgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 04:36:11 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E15AC061766
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 01:34:24 -0700 (PDT)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafb:ee01:578f:7526:5a0:96d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 62093208FCA;
        Sat,  5 Jun 2021 10:34:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1622882061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mPMsemwFKmKrqmVjdDciPu/TccJFyizH3e06n5iIdXc=;
        b=aDtT/KubvMMrLDXwIu+ivvnyqfOeIWDucJ5wVHcGV02fmB3VhzVm3gkbJ5fz4sW0UXlHPo
        z2O3noF3j18Cxmd+HcPPy3/SEzH/gJEaVRNuVEroKrxJ834HKg2utrkHFHiO3rgMsCX+ZW
        EGtMXTNT4ToxHczNRs98lrz2OmqvfDrCRqzIrWqpunzRRB3w4cd50PXZDsbhASjX4hPUW4
        u/ImP4MCR1EakNlP4d1/BetCX+qodAYpI9u5tUxhGfwxtVjB8FYu1dlnlXDIRLaR3BozWO
        1PN/3TlY7/tZBaPBpa7W2KIv0+D/63wU4ERhmgFaNTi0IVA/OhvxUYiFOvnI/A==
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sander Vanheule <sander@svanheule.net>,
        Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH] regmap: mdio: Reject invalid clause-22 addresses
Date:   Sat,  5 Jun 2021 10:31:18 +0200
Message-Id: <20210605083116.12786-1-sander@svanheule.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622743333.git.sander@svanheule.net>
References: <cover.1622743333.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently a regmap configuration for regmap-mdio must have a register
address width of 5 bits (cf. clause-22 register access). This is not
enforced on the provided register addresses, which would enable
clause-45 MDIO bus access, if the right bit packing is used.

Prevent clause-45 access, and other invalid addresses, by verifying the
provided register address.

Cc: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/base/regmap/regmap-mdio.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-mdio.c b/drivers/base/regmap/regmap-mdio.c
index 5ec208279913..3b842cf1eef9 100644
--- a/drivers/base/regmap/regmap-mdio.c
+++ b/drivers/base/regmap/regmap-mdio.c
@@ -5,16 +5,22 @@
 #include <linux/module.h>
 #include <linux/regmap.h>
 
+#define REGVAL_MASK		GENMASK(15, 0)
+#define REGNUM_C22_MASK		GENMASK(4, 0)
+
 static int regmap_mdio_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct mdio_device *mdio_dev = context;
 	int ret;
 
-	ret = mdiobus_read(mdio_dev->bus, mdio_dev->addr, reg);
+	if (unlikely(reg & ~REGNUM_C22_MASK))
+		return -ENXIO;
+
+	ret = mdiobus_read(mdio_dev->bus, mdio_dev->addr, reg & REGNUM_C22_MASK);
 	if (ret < 0)
 		return ret;
 
-	*val = ret & 0xffff;
+	*val = ret & REGVAL_MASK;
 	return 0;
 }
 
@@ -22,7 +28,10 @@ static int regmap_mdio_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct mdio_device *mdio_dev = context;
 
-	return mdiobus_write(mdio_dev->bus, mdio_dev->addr, reg, val);
+	if (unlikely(reg & ~REGNUM_C22_MASK))
+		return -ENXIO;
+
+	return mdiobus_write(mdio_dev->bus, mdio_dev->addr, reg & REGNUM_C22_MASK, val);
 }
 
 static const struct regmap_bus regmap_mdio_bus = {
-- 
2.31.1

