Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CBE40B078
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 16:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbhINOWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhINOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:22:13 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E3AC061766
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:20:55 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id 5so8294708plo.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 07:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=N9JVgVG506A4pOrvl84cUIVr9SLgDoTeuv3CCffC6eI=;
        b=PE2DDe1EJUUNhlct25QQgwfuqq2afYwYT+duNuPOzmIOptPn/AqBPaUn1RyBkWfYHH
         3jyMpw7pz16SwrqbAlEK3iF/6rBsr+c9A+Kn4AoBKUxBwQ5Ss62G+Jf5AufzNO6tWsQU
         oj0gtD7YqK7Dlr3aIQ5tlAAbjsXWKHrv0fhyzMBhKMCFJghQe7WSt7O/ZxJkZWaCM/4n
         Jyhk4JvfmO1/YgyaOeav3cd3nJopEWBHEMN9oXf0BaQp363vM2dohuZbk1fhBvMvXn47
         pKZLmedERNgRVconZdzh9vPB8/y6p4G7xmDYyiM+6arBD8qC2u0Eh0ARl9JouX3+3txU
         FecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=N9JVgVG506A4pOrvl84cUIVr9SLgDoTeuv3CCffC6eI=;
        b=cgpX3OQiSQTnOSxyq/Vqr4ItqQvF3+ERRTjszsxv9SdJn1sviTZvivdWiEE8EQ3t6B
         XpiWNUTSz7J4mkf2T4ERHgxWIuBLOOIb5UrduKE11vFtD8o5Y4ePckua4vBdo9NcZhrI
         BIcw9Du7TWvintF6ADc4Gy4gP0Qx5/0otYjBc5/c4/Gfb+HKkO6azB15y+6WzJ/N5UJ5
         cxmf1dOVKYjCXUR9ZzGv+tW4AA21DwW+k7k0mDOVlwfrobyY+zI9oihMv0QCHkKZxeW7
         a51az4Sc/QxjoYglCPEbCmwEkXNKg20NGS7sinZX65tfwkpaQM5YfSOLykPA+ijfeiRq
         EqFw==
X-Gm-Message-State: AOAM53098PfN1FhOLdB4Qvg3D3hZhJeUfwvlDqLxCmnc/2kTnpnu2StW
        4S5D+gAPZHTbLtk5Iq00P0/yheLng3U=
X-Google-Smtp-Source: ABdhPJzMSshUkpFX5pwk0xvSfpPUK9YghGjpcjSPwVQauqErMeEkM55I6Lfb6pzKWcuMCQxx2zgohQ==
X-Received: by 2002:a17:903:1c2:b0:138:b303:7b95 with SMTP id e2-20020a17090301c200b00138b3037b95mr15240512plh.78.1631629255246;
        Tue, 14 Sep 2021 07:20:55 -0700 (PDT)
Received: from localhost.localdomain (1-171-6-195.dynamic-ip.hinet.net. [1.171.6.195])
        by smtp.gmail.com with ESMTPSA id z8sm10300577pfa.113.2021.09.14.07.20.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 07:20:54 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
Subject: [PATCH v2] regulator: rtq6752: Enclose 'enable' gpio control by enable flag
Date:   Tue, 14 Sep 2021 22:20:49 +0800
Message-Id: <1631629249-9998-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Fix 'enable' gpio control logic from the below cases if it's specified.

1. All off and both are sequentially controlled to be on.
The 'enable' gpio control block to be called twice including the delay time.

2. Both are on and one is preparing to be off.
The 'enable' gpio control low before register cache is configured to be true.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
v2
- Merge all comments into commit message.
---
 drivers/regulator/rtq6752-regulator.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/regulator/rtq6752-regulator.c b/drivers/regulator/rtq6752-regulator.c
index 609d3fc..dfe45fb 100644
--- a/drivers/regulator/rtq6752-regulator.c
+++ b/drivers/regulator/rtq6752-regulator.c
@@ -54,14 +54,14 @@ static int rtq6752_set_vdd_enable(struct regulator_dev *rdev)
 	int rid = rdev_get_id(rdev), ret;
 
 	mutex_lock(&priv->lock);
-	if (priv->enable_gpio) {
-		gpiod_set_value(priv->enable_gpio, 1);
+	if (!priv->enable_flag) {
+		if (priv->enable_gpio) {
+			gpiod_set_value(priv->enable_gpio, 1);
 
-		usleep_range(RTQ6752_I2CRDY_TIMEUS,
-			     RTQ6752_I2CRDY_TIMEUS + 100);
-	}
+			usleep_range(RTQ6752_I2CRDY_TIMEUS,
+				     RTQ6752_I2CRDY_TIMEUS + 100);
+		}
 
-	if (!priv->enable_flag) {
 		regcache_cache_only(priv->regmap, false);
 		ret = regcache_sync(priv->regmap);
 		if (ret) {
@@ -91,11 +91,11 @@ static int rtq6752_set_vdd_disable(struct regulator_dev *rdev)
 	if (!priv->enable_flag) {
 		regcache_cache_only(priv->regmap, true);
 		regcache_mark_dirty(priv->regmap);
-	}
 
-	if (priv->enable_gpio)
-		gpiod_set_value(priv->enable_gpio, 0);
+		if (priv->enable_gpio)
+			gpiod_set_value(priv->enable_gpio, 0);
 
+	}
 	mutex_unlock(&priv->lock);
 
 	return 0;
-- 
2.7.4

