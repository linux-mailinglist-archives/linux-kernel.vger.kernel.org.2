Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD42340B00D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 15:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhINOAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 10:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhINOAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 10:00:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C69BC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 06:58:44 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id n18so8236942plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=kuGfoiHW6NcPNvARG0VGXXuklmC4CvtIeNqf7tHyLDY=;
        b=CYmjmGpeYGKepBsojHml54XupAoZlD3GyuZyIUd29k1M7Z3zYoYE3KKq4UJVsEK+JM
         4w9uE0qxsLzI7exmwyRMPxmHZNg3A8EEmKNnqHbm/76Us6khGgCGW92gl8PViBcL9lju
         bZTDfqzKgamLTOCVaubKn8XNR7aprZ5qMoWAX5YXkr/CY3q3SwG2bm1nAJpvdgOGEU40
         os7Mv9Z+qkqg8iKhj3JLuni2jwYTjjbgeV4T3hT9xiVold1UzkQzcAAWH4socboX6gDK
         pr3xZg3EQZcutndRaZ5Vdxw5eQQrJuNEZXbtEV8lVtLl7cJqA683pxUxO8dVcEbH7GKI
         vTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kuGfoiHW6NcPNvARG0VGXXuklmC4CvtIeNqf7tHyLDY=;
        b=JE2rHE6ab3qM0WDWfHKTsqeWRalvZm3o37oIywg3M0Z37VjU+/NHnl2Zl6otlB9TVl
         ryPHwuSwg7kL7O8J73HjFhuQB1IzQrhrOuJ+2iXXUeGzPiY7aaBuPvR1HvA8WZ4s4qaP
         JupppV9a4ai0++kzJ51RYXfYW85QMj8WznHsrgQ2P0L4rSVp/IMN7K2mZqoH5xg/ogby
         eW7l47nkYHRsfF2nMnEdyz658zmzRRXm4XuRCGdIkwenvSSO8VaKHG6GFhQzjpB6V5n+
         vCES2DgKhNOfYmZ7t4UTcSv1FP+hoSpOvTRjHDCtM38zudJ7vp2pDsn9gZE/klnGaW3T
         F/8Q==
X-Gm-Message-State: AOAM533hoD3IXtDuhjCbPX1wi/wV8j1Gns1ZwN8geu5qv26mjiod6Uo7
        fpvOkO0tOoMXyYZ3xlpsVze4wmvYyRY=
X-Google-Smtp-Source: ABdhPJyvpRb9oGIkD6JcuwCNsRBMRVR2YXCVY3sZRerC6ijN3GdsTFxPS0dVQXWRg/U7qCzjQwoxug==
X-Received: by 2002:a17:90b:4c4f:: with SMTP id np15mr2295910pjb.30.1631627923319;
        Tue, 14 Sep 2021 06:58:43 -0700 (PDT)
Received: from localhost.localdomain (1-171-6-195.dynamic-ip.hinet.net. [1.171.6.195])
        by smtp.gmail.com with ESMTPSA id a15sm11869075pgn.25.2021.09.14.06.58.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 06:58:42 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
Subject: [PATCH] regulator: rtq6752: Enclose 'enable' gpio control by enable flag
Date:   Tue, 14 Sep 2021 21:58:32 +0800
Message-Id: <1631627912-7974-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Fix 'enable' gpio control logic if it's specified.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
This patch is to prevent the logic error from the below cases.

1. All off and both are sequentially controlled to be on.
The 'enable' gpio control block to be called twice including the delay time.

2. Both are on and one is preparing to be off.
The 'enable' gpio control low before register cache is configured to be true.

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

