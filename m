Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5153E3A133B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 13:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbhFILsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 07:48:21 -0400
Received: from polaris.svanheule.net ([84.16.241.116]:47178 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbhFILsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 07:48:11 -0400
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafb:ee01:a92e:8520:f692:3284])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 5CBEF20B132;
        Wed,  9 Jun 2021 13:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1623239176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jr7WaxNfsViKRSi3e68KdJ1XtziTgHkqSKryqN7U7yc=;
        b=uUgxD4BeFgf3XGrfiti7S6wJ5od8tRxH4l2IHzMWV6OEwqM9tbJm0iXYRO6Bk/AJQf5184
        c+VeEr2Ok3O+JWkCHSoTQzDfulqjd549vwZZiRatInbVSY7rkwhl9go7x1/iNGBDt85iZd
        KS+lB0mcOeNwNFSCxdfZ0gSAQCSiDp7DnvWWL5LhjNYX4lgI0RfHEzPSOqf9DE7nnpluPc
        t8u5DAXWrg9AwELItNtKu/8qVQCD2FIyHaAIYMET53wEMnW5+nMrkuStrP2UMiv8BHHGQr
        dwEu2EAjwys3LscYrdWluJcjqIn6Nu7oWIR0DoFKSMsSUx6dnYj8ziFnPlVCrg==
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrew Lunn <andrew@lunn.ch>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH 2/2] regmap: mdio: Reject invalid clause-22 addresses
Date:   Wed,  9 Jun 2021 13:46:06 +0200
Message-Id: <7e1fc137134699fd2daca0937c2223225afd9c3d.1623238313.git.sander@svanheule.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623238313.git.sander@svanheule.net>
References: <cover.1623238313.git.sander@svanheule.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an invalid register offset is provided, the upper bits are silently
discarded. Change this to return -ENXIO instead, to help catch potential
bugs.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/base/regmap/regmap-mdio.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap-mdio.c b/drivers/base/regmap/regmap-mdio.c
index aee34bf2400e..9adfb82be8f1 100644
--- a/drivers/base/regmap/regmap-mdio.c
+++ b/drivers/base/regmap/regmap-mdio.c
@@ -13,7 +13,10 @@ static int regmap_mdio_read(void *context, unsigned int reg, unsigned int *val)
 	struct mdio_device *mdio_dev = context;
 	int ret;
 
-	ret = mdiobus_read(mdio_dev->bus, mdio_dev->addr, reg & REGNUM_C22_MASK);
+	if (unlikely(reg & ~REGNUM_C22_MASK))
+		return -ENXIO;
+
+	ret = mdiobus_read(mdio_dev->bus, mdio_dev->addr, reg);
 	if (ret < 0)
 		return ret;
 
@@ -25,7 +28,10 @@ static int regmap_mdio_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct mdio_device *mdio_dev = context;
 
-	return mdiobus_write(mdio_dev->bus, mdio_dev->addr, reg & REGNUM_C22_MASK, val);
+	if (unlikely(reg & ~REGNUM_C22_MASK))
+		return -ENXIO;
+
+	return mdiobus_write(mdio_dev->bus, mdio_dev->addr, reg, val);
 }
 
 static const struct regmap_bus regmap_mdio_bus = {
-- 
2.31.1

