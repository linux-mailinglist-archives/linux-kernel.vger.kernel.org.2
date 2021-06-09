Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71D93A133A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhFILsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:48:20 -0400
Received: from polaris.svanheule.net ([84.16.241.116]:47162 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239391AbhFILsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:10 -0400
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafb:ee01:a92e:8520:f692:3284])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id CED2D20B130;
        Wed,  9 Jun 2021 13:46:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1623239175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nf2BXQtJeETi1BZFFJMFnUxdAnmaMx2soeadxhnEBxM=;
        b=voC3qrNRaGiQFlVVnRXgsrWBjQJ1VcDC+ekdHUG1qcyJglud5un2zlMGQYXHp2vOQoS0ml
        Jff+bJnLh44d5bQGCTHjtE7tm/N8hL7U3UB4bmnsQEy/qyhFwgqYi1cIGQeDmHjfhEBkZl
        9bDz3nt5o7x5WlXHSGbAWQL35yb9RONVu2w7JswCBAbgOcciEcEcKP/1UFMDLQM3uDEEPq
        8fPApUMf2QGvUAIwdMmBlKFo2TR47nb4hY4PoQQUdFtIoX9Ts5gt1GcMNAWTgprkYX6Twf
        U0vxziRNTggHhJVBXGaJZBhi94ZZGsMonnyzWCxMTn7r0S2Qok1Cfbmd+VOIyw==
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrew Lunn <andrew@lunn.ch>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH 1/2] Revert "regmap: mdio: Add clause-45 support"
Date:   Wed,  9 Jun 2021 13:46:05 +0200
Message-Id: <deed937f8fd63285e95acdfa8ca327638057811f.1623238313.git.sander@svanheule.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623238313.git.sander@svanheule.net>
References: <cover.1623238313.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f083be9db060fbac09123d80bdffb2c001ac0e2b.

There are currently no (planned) regmap users for C45 register access.
Remove support for now, to reduce dead code.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/base/regmap/regmap-mdio.c | 70 +++++++------------------------
 1 file changed, 14 insertions(+), 56 deletions(-)

diff --git a/drivers/base/regmap/regmap-mdio.c b/drivers/base/regmap/regmap-mdio.c
index cfb23afb19eb..aee34bf2400e 100644
--- a/drivers/base/regmap/regmap-mdio.c
+++ b/drivers/base/regmap/regmap-mdio.c
@@ -7,14 +7,13 @@
 
 #define REGVAL_MASK		GENMASK(15, 0)
 #define REGNUM_C22_MASK		GENMASK(4, 0)
-/* Clause-45 mask includes the device type (5 bit) and actual register number (16 bit) */
-#define REGNUM_C45_MASK		GENMASK(20, 0)
 
-static int regmap_mdio_read(struct mdio_device *mdio_dev, u32 reg, unsigned int *val)
+static int regmap_mdio_read(void *context, unsigned int reg, unsigned int *val)
 {
+	struct mdio_device *mdio_dev = context;
 	int ret;
 
-	ret = mdiobus_read(mdio_dev->bus, mdio_dev->addr, reg);
+	ret = mdiobus_read(mdio_dev->bus, mdio_dev->addr, reg & REGNUM_C22_MASK);
 	if (ret < 0)
 		return ret;
 
@@ -22,63 +21,27 @@ static int regmap_mdio_read(struct mdio_device *mdio_dev, u32 reg, unsigned int
 	return 0;
 }
 
-static int regmap_mdio_write(struct mdio_device *mdio_dev, u32 reg, unsigned int val)
-{
-	return mdiobus_write(mdio_dev->bus, mdio_dev->addr, reg, val);
-}
-
-static int regmap_mdio_c22_read(void *context, unsigned int reg, unsigned int *val)
-{
-	struct mdio_device *mdio_dev = context;
-
-	return regmap_mdio_read(mdio_dev, reg & REGNUM_C22_MASK, val);
-}
-
-static int regmap_mdio_c22_write(void *context, unsigned int reg, unsigned int val)
+static int regmap_mdio_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct mdio_device *mdio_dev = context;
 
-	return regmap_mdio_write(mdio_dev, reg & REGNUM_C22_MASK, val);
+	return mdiobus_write(mdio_dev->bus, mdio_dev->addr, reg & REGNUM_C22_MASK, val);
 }
 
-static const struct regmap_bus regmap_mdio_c22_bus = {
-	.reg_write = regmap_mdio_c22_write,
-	.reg_read = regmap_mdio_c22_read,
-};
-
-static int regmap_mdio_c45_read(void *context, unsigned int reg, unsigned int *val)
-{
-	struct mdio_device *mdio_dev = context;
-
-	return regmap_mdio_read(mdio_dev, MII_ADDR_C45 | (reg & REGNUM_C45_MASK), val);
-}
-
-static int regmap_mdio_c45_write(void *context, unsigned int reg, unsigned int val)
-{
-	struct mdio_device *mdio_dev = context;
-
-	return regmap_mdio_write(mdio_dev, MII_ADDR_C45 | (reg & REGNUM_C45_MASK), val);
-}
-
-static const struct regmap_bus regmap_mdio_c45_bus = {
-	.reg_write = regmap_mdio_c45_write,
-	.reg_read = regmap_mdio_c45_read,
+static const struct regmap_bus regmap_mdio_bus = {
+	.reg_write = regmap_mdio_write,
+	.reg_read = regmap_mdio_read,
 };
 
 struct regmap *__regmap_init_mdio(struct mdio_device *mdio_dev,
 	const struct regmap_config *config, struct lock_class_key *lock_key,
 	const char *lock_name)
 {
-	struct regmap_bus *bus;
-
-	if (config->reg_bits == 5 && config->val_bits == 16)
-		bus = &regmap_mdio_c22_bus;
-	else if (config->reg_bits == 21 && config->val_bits == 16)
-		bus = &regmap_mdio_c45_bus;
-	else
+	if (config->reg_bits != 5 || config->val_bits != 16)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return __regmap_init(&mdio_dev->dev, bus, mdio_dev, config, lock_key, lock_name);
+	return __regmap_init(&mdio_dev->dev, &regmap_mdio_bus, mdio_dev, config,
+		lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__regmap_init_mdio);
 
@@ -86,16 +49,11 @@ struct regmap *__devm_regmap_init_mdio(struct mdio_device *mdio_dev,
 	const struct regmap_config *config, struct lock_class_key *lock_key,
 	const char *lock_name)
 {
-	const struct regmap_bus *bus;
-
-	if (config->reg_bits == 5 && config->val_bits == 16)
-		bus = &regmap_mdio_c22_bus;
-	else if (config->reg_bits == 21 && config->val_bits == 16)
-		bus = &regmap_mdio_c45_bus;
-	else
+	if (config->reg_bits != 5 || config->val_bits != 16)
 		return ERR_PTR(-EOPNOTSUPP);
 
-	return __devm_regmap_init(&mdio_dev->dev, bus, mdio_dev, config, lock_key, lock_name);
+	return __devm_regmap_init(&mdio_dev->dev, &regmap_mdio_bus, mdio_dev,
+		config, lock_key, lock_name);
 }
 EXPORT_SYMBOL_GPL(__devm_regmap_init_mdio);
 
-- 
2.31.1

