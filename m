Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C439339A9FA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 20:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFCS1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 14:27:08 -0400
Received: from polaris.svanheule.net ([84.16.241.116]:42912 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFCS1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 14:27:06 -0400
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafb:ee01:eb34:edf2:c0ff:9e88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 8D1AC2082E3;
        Thu,  3 Jun 2021 20:25:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1622744720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mkiOZ138uflRvbn1upqMjb/H1A5Yo7JBTsjLV+GJWcU=;
        b=U3/YVz1dYc8KcqXk/eSemMGv1VHV4kLgBJyz0+sF3tZ/ilmvgsjp5YJw9GxN+PsZf/GW3j
        pSsilnX8SREQe2b2qG15HmUjeYE9Gp2qe4hBFOGFpJlXoqH2Bd16+9pQZ+FEik/DQ1RfQy
        bSOmL6L9HRqE4tH1GrjqhOOLkV98z2ZF9AiZADJv+ixaJ9pZQIGE5fxUettCj/OhShs4XH
        /wcFev0ktmHuvyn/POtlPhqRsbaDV6AgEX5XfrB89cdpnSGpQAfkMt57QNRUq8RtKJFK7e
        66XCTUMjlDf7eJhftF4EE0gm+gBk9sFyO3zBS8RP3JYQBUnV4L+vKYnGzmt8bQ==
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [RFC PATCH 2/2] regmap: mdio: Add clause-45 support
Date:   Thu,  3 Jun 2021 20:25:10 +0200
Message-Id: <9cc263e3e7d5865edd90453b4183f1cf363cb636.1622743333.git.sander@svanheule.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622743333.git.sander@svanheule.net>
References: <cover.1622743333.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modern ethernet phys support the so-called clause-45 register access
mode, which allows for register address widths of 16 bit.

Also allow for 16-bit register address widths, and return a regmap for
clause-45 access in that case.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/base/regmap/regmap-mdio.c | 70 ++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 14 deletions(-)

diff --git a/drivers/base/regmap/regmap-mdio.c b/drivers/base/regmap/regmap-mdio.c
index aee34bf2400e..cfb23afb19eb 100644
--- a/drivers/base/regmap/regmap-mdio.c
+++ b/drivers/base/regmap/regmap-mdio.c
@@ -7,13 +7,14 @@
 
 #define REGVAL_MASK		GENMASK(15, 0)
 #define REGNUM_C22_MASK		GENMASK(4, 0)
+/* Clause-45 mask includes the device type (5 bit) and actual register number (16 bit) */
+#define REGNUM_C45_MASK		GENMASK(20, 0)
 
-static int regmap_mdio_read(void *context, unsigned int reg, unsigned int *val)
+static int regmap_mdio_read(struct mdio_device *mdio_dev, u32 reg, unsigned int *val)
 {
-	struct mdio_device *mdio_dev = context;
 	int ret;
 
-	ret = mdiobus_read(mdio_dev->bus, mdio_dev->addr, reg & REGNUM_C22_MASK);
+	ret = mdiobus_read(mdio_dev->bus, mdio_dev->addr, reg);
 	if (ret < 0)
 		return ret;
 
@@ -21,27 +22,63 @@ static int regmap_mdio_read(void *context, unsigned int reg, unsigned int *val)
 	return 0;
 }
 
-static int regmap_mdio_write(void *context, unsigned int reg, unsigned int val)
+static int regmap_mdio_write(struct mdio_device *mdio_dev, u32 reg, unsigned int val)
+{
+	return mdiobus_write(mdio_dev->bus, mdio_dev->addr, reg, val);
+}
+
+static int regmap_mdio_c22_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct mdio_device *mdio_dev = context;
+
+	return regmap_mdio_read(mdio_dev, reg & REGNUM_C22_MASK, val);
+}
+
+static int regmap_mdio_c22_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct mdio_device *mdio_dev = context;
 
-	return mdiobus_write(mdio_dev->bus, mdio_dev->addr, reg & REGNUM_C22_MASK, val);
+	return regmap_mdio_write(mdio_dev, reg & REGNUM_C22_MASK, val);
 }
 
-static const struct regmap_bus regmap_mdio_bus = {
-	.reg_write = regmap_mdio_write,
-	.reg_read = regmap_mdio_read,
+static const struct regmap_bus regmap_mdio_c22_bus = {
+	.reg_write = regmap_mdio_c22_write,
+	.reg_read = regmap_mdio_c22_read,
+};
+
+static int regmap_mdio_c45_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct mdio_device *mdio_dev = context;
+
+	return regmap_mdio_read(mdio_dev, MII_ADDR_C45 | (reg & REGNUM_C45_MASK), val);
+}
+
+static int regmap_mdio_c45_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct mdio_device *mdio_dev = context;
+
+	return regmap_mdio_write(mdio_dev, MII_ADDR_C45 | (reg & REGNUM_C45_MASK), val);
+}
+
+static const struct regmap_bus regmap_mdio_c45_bus = {
+	.reg_write = regmap_mdio_c45_write,
+	.reg_read = regmap_mdio_c45_read,
 };
 
 struct regmap *__regmap_init_mdio(struct mdio_device *mdio_dev,
 	const struct regmap_config *config, struct lock_class_key *lock_key,
 	const char *lock_name)
 {
-	if (config->reg_bits != 5 || config->val_bits != 16)
+	struct regmap_bus *bus;
+
+	if (config->reg_bits == 5 && config->val_bits == 16)
+		bus = &regmap_mdio_c22_bus;
+	else if (config->reg_bits == 21 && config->val_bits == 16)
+		bus = &regmap_mdio_c45_bus;
+	else
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return __regmap_init(&mdio_dev->dev, &regmap_mdio_bus, mdio_dev, config,
-		lock_key, lock_name);
+	return __regmap_init(&mdio_dev->dev, bus, mdio_dev, config, lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__regmap_init_mdio);
 
@@ -49,11 +86,16 @@ struct regmap *__devm_regmap_init_mdio(struct mdio_device *mdio_dev,
 	const struct regmap_config *config, struct lock_class_key *lock_key,
 	const char *lock_name)
 {
-	if (config->reg_bits != 5 || config->val_bits != 16)
+	const struct regmap_bus *bus;
+
+	if (config->reg_bits == 5 && config->val_bits == 16)
+		bus = &regmap_mdio_c22_bus;
+	else if (config->reg_bits == 21 && config->val_bits == 16)
+		bus = &regmap_mdio_c45_bus;
+	else
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return __devm_regmap_init(&mdio_dev->dev, &regmap_mdio_bus, mdio_dev,
-		config, lock_key, lock_name);
+	return __devm_regmap_init(&mdio_dev->dev, bus, mdio_dev, config, lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_mdio);
 
-- 
2.31.1

