Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA4E3B17E1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFWKNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:13:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230152AbhFWKNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:13:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82A21611C9;
        Wed, 23 Jun 2021 10:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624443093;
        bh=lEMGdk+QOQQbwsmw6YQ5VqGUddHqHIPANLPyfPqVKt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y04lejJqplVnm8xl33R+qVL59qxO/Im5Ny1FfusZA2XIdX0KN7qIFta4L7nsvFcWy
         7gURBzVlWAphcq9em4pDEoOHOm9PGc8CtjYo5c5FXzc8GWTmrESk2XeYfdx9DpNQtF
         eud5yh6/yNI4Kj82YNcWR0+TsuLllA3qdwRL9bSMo53CINGka5q9KOYlX2BCTqU1NH
         N4vXjb/YUPw5OYVxGJNe+pAVGUxennG5kSrw7x1qxvhwuw9/Q9mS7e86J1BtVrYoON
         qkQbPPrk3Ke125FAEn2hibnuojcICNuyYw6k+Dg+Co0TYZRAHEt9FNBg19TpKQLN/C
         xig6Vx0g0Cr+w==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lvzr1-002pFT-3T; Wed, 23 Jun 2021 12:11:31 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v6 1/8] staging: phy-hi3670-usb3: do a some minor cleanups
Date:   Wed, 23 Jun 2021 12:11:23 +0200
Message-Id: <55db419e42fd3af72494acbe0ea0f0d1de8906ac.1624442566.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624442566.git.mchehab+huawei@kernel.org>
References: <cover.1624442566.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before moving this driver out of staging:

1. group some integers altogether;

2. Use:

	return some_function()

instead of:

	ret = some_function();
	return ret;

This is just a cleanup. No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/phy-hi3670-usb3.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
index e7e579ce0302..b9ffe08abaab 100644
--- a/drivers/staging/hikey9xx/phy-hi3670-usb3.c
+++ b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
@@ -148,10 +148,8 @@ static int hi3670_phy_cr_clk(struct regmap *usb31misc)
 		return ret;
 
 	/* Clock down */
-	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
-				 CFG54_USB31PHY_CR_CLK, 0);
-
-	return ret;
+	return regmap_update_bits(usb31misc, USB_MISC_CFG54,
+				  CFG54_USB31PHY_CR_CLK, 0);
 }
 
 static int hi3670_phy_cr_set_sel(struct regmap *usb31misc)
@@ -215,17 +213,14 @@ static int hi3670_phy_cr_set_addr(struct regmap *usb31misc, u32 addr)
 		return ret;
 
 	reg = FIELD_PREP(CFG54_USB31PHY_CR_ADDR_MASK, addr);
-	ret = regmap_update_bits(usb31misc, USB_MISC_CFG54,
-				 CFG54_USB31PHY_CR_ADDR_MASK, reg);
 
-	return ret;
+	return regmap_update_bits(usb31misc, USB_MISC_CFG54,
+				  CFG54_USB31PHY_CR_ADDR_MASK, reg);
 }
 
 static int hi3670_phy_cr_read(struct regmap *usb31misc, u32 addr, u32 *val)
 {
-	int reg;
-	int i;
-	int ret;
+	int reg, i, ret;
 
 	for (i = 0; i < 100; i++) {
 		ret = hi3670_phy_cr_clk(usb31misc);
@@ -286,9 +281,7 @@ static int hi3670_phy_cr_write(struct regmap *usb31misc, u32 addr, u32 val)
 	if (ret)
 		return ret;
 
-	ret = hi3670_phy_cr_wait_ack(usb31misc);
-
-	return ret;
+	return hi3670_phy_cr_wait_ack(usb31misc);
 }
 
 static int hi3670_phy_set_params(struct hi3670_priv *priv)
-- 
2.31.1

