Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5B539A9F9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhFCS1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:27:05 -0400
Received: from polaris.svanheule.net ([84.16.241.116]:42900 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFCS1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:27:04 -0400
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafb:ee01:eb34:edf2:c0ff:9e88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 0D7372082E2;
        Thu,  3 Jun 2021 20:25:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1622744718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ygm3qNq49nKCGx74/wgWlaFl/v5sIznFwvYp0WMz3yo=;
        b=qCBPeBT4qA27FbMPZpsOH/A611ESLvcXb0AEIxVpwm7w5hC9VYhCP/IOTbuM0odvOFTfen
        j3k242fGisEI8nhp7GZzXoM4DUpLhAR+tjIK1di8bKmiTxWjBw57PzoDih4umWe7ghDlJi
        wNaBspmHL9RLLw9EWyDs9/SYkDFXYzmpNZnzEH11mbYpvSbBxnLYGBc9JhPHFYw9LWAwVn
        22RxEw0e5kV45Jrc8RkM99nrQYDZMYAwlOJNHBft4+R5U1YUHJiX94B2Po5jfiGzQ2UPZY
        785RTXCqqkKoCV5iCmPnp9M6PjrNPA4jmDry2oGxs9NkiHs8NrRpbpTbdPJIVA==
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH 1/2] regmap: mdio: Clean up invalid clause-22 addresses
Date:   Thu,  3 Jun 2021 20:25:09 +0200
Message-Id: <f7013f67e6d6ff56ec98660f18320f6ffcc1a777.1622743333.git.sander@svanheule.net>
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

Prevent clause-45 access, and other invalid addresses, by masking the
provided register address.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/base/regmap/regmap-mdio.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-mdio.c b/drivers/base/regmap/regmap-mdio.c
index 5ec208279913..aee34bf2400e 100644
--- a/drivers/base/regmap/regmap-mdio.c
+++ b/drivers/base/regmap/regmap-mdio.c
@@ -5,16 +5,19 @@
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
+	ret = mdiobus_read(mdio_dev->bus, mdio_dev->addr, reg & REGNUM_C22_MASK);
 	if (ret < 0)
 		return ret;
 
-	*val = ret & 0xffff;
+	*val = ret & REGVAL_MASK;
 	return 0;
 }
 
@@ -22,7 +25,7 @@ static int regmap_mdio_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct mdio_device *mdio_dev = context;
 
-	return mdiobus_write(mdio_dev->bus, mdio_dev->addr, reg, val);
+	return mdiobus_write(mdio_dev->bus, mdio_dev->addr, reg & REGNUM_C22_MASK, val);
 }
 
 static const struct regmap_bus regmap_mdio_bus = {
-- 
2.31.1

