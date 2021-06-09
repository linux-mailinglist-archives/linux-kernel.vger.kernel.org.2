Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6773A1529
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhFINMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbhFINMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:12:12 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA4FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 06:10:18 -0700 (PDT)
Received: from terra.local.svanheule.net (unknown [IPv6:2a02:a03f:eafb:ee01:a92e:8520:f692:3284])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id AD20E20B199;
        Wed,  9 Jun 2021 15:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1623244216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YNUoYR6ZcG92mYzB8gVtgnq0NNffhd2w8JGmSQf3dvg=;
        b=aokKH7rlsw9Mz73oO4azJZBtdjDuWjx7UO3dKk3O89KJjIx/s709uC6Qd6H6c9jqTOovYP
        jKSGfA5rqR6srFn44pSHblZl/k8Fae5MGEv8+1FuLIagrd+KoKQVaJc7kOrRiSwDG8Tv2y
        1ffjbU2rDbEcSapzYr/Ig1tXHwMlNY0nETB/6rtfssoUNDE8HaIQOsTwYL1o3sTp7dcTkV
        Ja41eUdU3jyEdrU7cWxLH68/86y042mcnErUiQSwNlx9Ai/okEuNCbcKCznOUeMT2fLlfY
        Qo3LEyvM+tjbKP7ZTtKZGqr/I2ZX9O7dL9ccksNXyeoo2JJxmJ6zgFil3o1i0Q==
From:   Sander Vanheule <sander@svanheule.net>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Adrew Lunn <andrew@lunn.ch>,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v2 2/2] regmap: mdio: Reject invalid addresses
Date:   Wed,  9 Jun 2021 15:10:04 +0200
Message-Id: <047007e0e9fb596480829f11f8c7e6281d235c70.1623244066.git.sander@svanheule.net>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623244066.git.sander@svanheule.net>
References: <cover.1623244066.git.sander@svanheule.net>
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
 drivers/base/regmap/regmap-mdio.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-mdio.c b/drivers/base/regmap/regmap-mdio.c
index b772b42809e2..6a20201299f5 100644
--- a/drivers/base/regmap/regmap-mdio.c
+++ b/drivers/base/regmap/regmap-mdio.c
@@ -31,14 +31,20 @@ static int regmap_mdio_c22_read(void *context, unsigned int reg, unsigned int *v
 {
 	struct mdio_device *mdio_dev = context;
 
-	return regmap_mdio_read(mdio_dev, reg & REGNUM_C22_MASK, val);
+	if (unlikely(reg & ~REGNUM_C22_MASK))
+		return -ENXIO;
+
+	return regmap_mdio_read(mdio_dev, reg, val);
 }
 
 static int regmap_mdio_c22_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct mdio_device *mdio_dev = context;
 
-	return regmap_mdio_write(mdio_dev, reg & REGNUM_C22_MASK, val);
+	if (unlikely(reg & ~REGNUM_C22_MASK))
+		return -ENXIO;
+
+	return mdiobus_write(mdio_dev->bus, mdio_dev->addr, reg, val);
 }
 
 static const struct regmap_bus regmap_mdio_c22_bus = {
@@ -50,14 +56,20 @@ static int regmap_mdio_c45_read(void *context, unsigned int reg, unsigned int *v
 {
 	struct mdio_device *mdio_dev = context;
 
-	return regmap_mdio_read(mdio_dev, MII_ADDR_C45 | (reg & REGNUM_C45_MASK), val);
+	if (unlikely(reg & ~REGNUM_C45_MASK))
+		return -ENXIO;
+
+	return regmap_mdio_read(mdio_dev, MII_ADDR_C45 | reg, val);
 }
 
 static int regmap_mdio_c45_write(void *context, unsigned int reg, unsigned int val)
 {
 	struct mdio_device *mdio_dev = context;
 
-	return regmap_mdio_write(mdio_dev, MII_ADDR_C45 | (reg & REGNUM_C45_MASK), val);
+	if (unlikely(reg & ~REGNUM_C45_MASK))
+		return -ENXIO;
+
+	return regmap_mdio_write(mdio_dev, MII_ADDR_C45 | reg, val);
 }
 
 static const struct regmap_bus regmap_mdio_c45_bus = {
-- 
2.31.1

