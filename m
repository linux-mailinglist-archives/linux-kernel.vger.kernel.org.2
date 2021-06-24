Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CEC3B30CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 16:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhFXOEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 10:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:45878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230056AbhFXOEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 10:04:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D29E661410;
        Thu, 24 Jun 2021 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624543300;
        bh=lEMGdk+QOQQbwsmw6YQ5VqGUddHqHIPANLPyfPqVKt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jQyKT/p4r0QmX4pZh3rm+SlKuWds0XlElMYuNd62/lF8G/fOtIdRu/WAaLs5EdgDI
         CgknBPNuOMAcnISzOoDRLIR3XuwtD9nd8arzaOnjyrN592+UFj6aYCtpCT9F+M1ZcL
         aYHF1yknepYNf2wZ12GxIEt3uqCTYaj/zmZnShuKEmwt3XuhI79PxJQO69ENDAPXHY
         fDe+iLHdIzQnmm5FUjIwuXX32JELnTmmSQmqQdKqAdi74ee/eVbjil1r1y5IkVV1Zc
         ynwbgujALQehLYjuwHVodmlu1fkMDWqA9LcxzpS3eqibveUKY7YZZffZ3vceFZ8sSZ
         kybQ8gln9tmAA==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1lwPvG-003wSC-Kx; Thu, 24 Jun 2021 16:01:38 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Lee Jones" <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH v7 1/8] staging: phy-hi3670-usb3: do a some minor cleanups
Date:   Thu, 24 Jun 2021 16:01:30 +0200
Message-Id: <55db419e42fd3af72494acbe0ea0f0d1de8906ac.1624542940.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624542940.git.mchehab+huawei@kernel.org>
References: <cover.1624542940.git.mchehab+huawei@kernel.org>
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

