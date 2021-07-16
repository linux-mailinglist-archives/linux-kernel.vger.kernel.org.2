Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7593CB141
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 05:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhGPD6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 23:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbhGPD6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 23:58:53 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC99C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 20:55:58 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t9so8714916pgn.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 20:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TmHoAr7TsgUjxWUVvVNVWLfhdEBCaePz7sPswNQdCDk=;
        b=ItvV6SEEqBRLfd7hPX9WTdcx+4rcJuda3PnZ6PVB1XQAY2T1BPxQNw3NVaV6aLRuk7
         gOFW+nSfplfwDe/w4pELEiBDrjafsXH6g/YwCbA4R5gt173lCN77SBqi96E8MS8Brw6P
         +3UkVyUXTaSlpUenPwo5GpbvwiPr38GyZaSDPt0hyJ+Zs599usrZQL5YQYMEL7XGEcKF
         lSWhd1IoSgwvT0rxo+hfotPI5kinZ5l15iVnJ7cFAVJVhdG0Vyc4XoZVdtwx9yT7A6Xc
         MIzn7pIDKioFC0sOo2F+A2WLULY/70uCKA9ucHOUWeLNd+koxunvtg8vUwnengI27ZCp
         MTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TmHoAr7TsgUjxWUVvVNVWLfhdEBCaePz7sPswNQdCDk=;
        b=rHADhM5EXgvv7kYWnLe5ME/r/po2ElMuobTwEZ6lbCFQPG6M9cEM/FxgtHggO3+gUJ
         4+3+Oq0dHb5WdRAWiGj/mXKoteWytBXTAE50lrDLSPZLrNKvjR6s6RPXQ2iMxuqq6Umh
         kHp1hLFr1fyBb4/l+LC9GeVy/5HcO4YAh96/mtU0tX9HW6ubc9z/9blg/6m0IB6RFg99
         uyo4AiGDwrI6G1NenahDPjDv5CD683Arv7pCeaumaddDKlkweYalPRAWzIbWUufv8pZS
         i6Fma3rUvOHoFT8WxiCUVNwF1pHtxHPq7hNikXDdZV9B1K0qNeE8NXSRTjejoua/eOpk
         u0Dg==
X-Gm-Message-State: AOAM532ryJAlGMCkmE4ClWCnPAQfHskynSnlz/AOegm05dGp0kgP/yh+
        RalqOHBLXPpjXeCBN3Zpyqk=
X-Google-Smtp-Source: ABdhPJyv/00aUO0IqYE7dWIEvqFWUwyXeWMHhhDmsF3qqjQB9sGJqU0EE7TafV7Plb3sHWzhMTDEtQ==
X-Received: by 2002:a65:6441:: with SMTP id s1mr7659977pgv.214.1626407757633;
        Thu, 15 Jul 2021 20:55:57 -0700 (PDT)
Received: from localhost.localdomain (1-171-2-23.dynamic-ip.hinet.net. [1.171.2.23])
        by smtp.gmail.com with ESMTPSA id y7sm8572048pfy.153.2021.07.15.20.55.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Jul 2021 20:55:56 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        axel.lin@ingics.com, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH] regulator: rtq6752: fix reg reset behavior
Date:   Fri, 16 Jul 2021 11:55:46 +0800
Message-Id: <1626407746-23156-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Reg will be reset in below two conditions.
1. 'Enable' pin from H to L.
2. Both PAVDD and NAVDD are all disabled.

And 'Enable' pin also control i2c communication capability.

This patch is to Seperate the if condition in enable/disable callback for
reg cache manipulation.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Hi,
Normally, during testing, I consider only 'enable' will cause reg to be reset.
But after consulting our RD, this reset behavior not just 'Enable' H to L,
both powers are disabled, also.

This patch is used to fix this.
---
 drivers/regulator/rtq6752-regulator.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/rtq6752-regulator.c b/drivers/regulator/rtq6752-regulator.c
index 72a72aa..609d3fc 100644
--- a/drivers/regulator/rtq6752-regulator.c
+++ b/drivers/regulator/rtq6752-regulator.c
@@ -54,12 +54,14 @@ static int rtq6752_set_vdd_enable(struct regulator_dev *rdev)
 	int rid = rdev_get_id(rdev), ret;
 
 	mutex_lock(&priv->lock);
-	if (!priv->enable_flag && priv->enable_gpio) {
+	if (priv->enable_gpio) {
 		gpiod_set_value(priv->enable_gpio, 1);
 
 		usleep_range(RTQ6752_I2CRDY_TIMEUS,
 			     RTQ6752_I2CRDY_TIMEUS + 100);
+	}
 
+	if (!priv->enable_flag) {
 		regcache_cache_only(priv->regmap, false);
 		ret = regcache_sync(priv->regmap);
 		if (ret) {
@@ -86,12 +88,14 @@ static int rtq6752_set_vdd_disable(struct regulator_dev *rdev)
 	mutex_lock(&priv->lock);
 	priv->enable_flag &= ~BIT(rid);
 
-	if (!priv->enable_flag && priv->enable_gpio) {
+	if (!priv->enable_flag) {
 		regcache_cache_only(priv->regmap, true);
 		regcache_mark_dirty(priv->regmap);
+	}
 
+	if (priv->enable_gpio)
 		gpiod_set_value(priv->enable_gpio, 0);
-	}
+
 	mutex_unlock(&priv->lock);
 
 	return 0;
-- 
2.7.4

