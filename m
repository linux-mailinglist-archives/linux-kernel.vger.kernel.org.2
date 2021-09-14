Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7DEF40A45A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbhINDYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238941AbhINDYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:24:24 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DBFC061762
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:23:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id t4so1643004plo.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 20:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVxaxVLkHd1OjVLGEtEzeZhPd4oQXGRtOBcdwaIOQoo=;
        b=VD8L5DZDba6LinV9fL99EZSQlxIuW5tifd3k9wR85ktbr1sCZ0aMhwC4jSUB1bPSOz
         Wx7uvL2allXH+ThbkiaG0ShqRshMUD9hrUNZyVA5v+RoVzobZibV41J+wTYr2S1y7s7M
         aLKf8kXiw7CMIc0HFwYfyyBmuw59Aof5QCXU1xaWs7C1FH87gVEvkTHauDpoj5XRQ9qI
         HKhCwgoUwxEFYB7D9MkrkyR+s46EmwTA9CPsZ/s9xYCy6z07cLl7bSmKAzYrPVG0qLkO
         cmrZ/jT/4wss4pcXRvE/+9BANLjmXAAZz0xtyATmcsjx9CgJczWZsJmD0+fqGPJaKlXA
         Yrqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVxaxVLkHd1OjVLGEtEzeZhPd4oQXGRtOBcdwaIOQoo=;
        b=Zt02qIikTTk9BSmRQ/fU9o7o28IrYECl/gh4uX7lDOjcRTjSiszALJFfWznRRvlccx
         7ltBZIkisQVbDsjn9fn+ip0pdI8laqCfojpURM+QbCx0x3UgmH2pG3jKl8AKt7eCaZk9
         0qatz/GTkmw5hZBor49X8t5bPvKGd7X0+bWJVp6WjcI+jW8CyzRbxG7LXv0WCslIc9vP
         Q4u+ZdRqcVjy+T/kMyAtqrNuqPz6frDom/ssQSNZJxI8Gb8UGFY1Zaenj9oOAh++TFa2
         VPfsSOuV05M658kgfnpL6nUGHpd/suP4+iUF/MATntwh2ZKg3U0qrvRaImjglQuPW70J
         l1ig==
X-Gm-Message-State: AOAM530oWTMOqFWIxBCS+DMgEzocIwCXKhSCJ1RpyPhgy28mzKyx7bmo
        X/tvytfb5zh2b+RT/3Dw7Bwpzj+nl2AlqQ==
X-Google-Smtp-Source: ABdhPJxtiqHHahhi7Tya9jEM3Pa5oDWkR9Xnn6LR4TxQ4Rkk8Jif00btB8e+mn8rYOtmh0IaA7yCyw==
X-Received: by 2002:a17:902:c101:b0:138:f219:b0a0 with SMTP id 1-20020a170902c10100b00138f219b0a0mr13188285pli.1.1631589787299;
        Mon, 13 Sep 2021 20:23:07 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.213])
        by smtp.gmail.com with ESMTPSA id x15sm9354101pgt.34.2021.09.13.20.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 20:23:07 -0700 (PDT)
From:   yangcong <yangcong5@huaqin.corp-partner.google.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, dianders@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        yangcong <yangcong5@huaqin.corp-partner.google.com>,
        Douglas Anderson <dianders@chromium.org>
Subject: [v6 1/4] drm/panel: boe-tv101wum-nl6: Support enabling a 3.3V rail
Date:   Tue, 14 Sep 2021 11:22:49 +0800
Message-Id: <20210914032252.3770756-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210914032252.3770756-1-yangcong5@huaqin.corp-partner.google.com>
References: <20210914032252.3770756-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The auo,b101uan08.3 panel (already supported by this driver) has
a 3.3V rail that needs to be turned on. For previous users of
this panel this voltage was directly output by pmic. On a new
user (the not-yet-upstream sc7180-trogdor-mrbland board) we need
to turn the 3.3V rail on. Add support in the driver for this.

Signed-off-by: yangcong <yangcong5@huaqin.corp-partner.google.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index db9d0b86d542..9a644433629e 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -45,6 +45,7 @@ struct boe_panel {
 	const struct panel_desc *desc;
 
 	enum drm_panel_orientation orientation;
+	struct regulator *pp3300;
 	struct regulator *pp1800;
 	struct regulator *avee;
 	struct regulator *avdd;
@@ -511,6 +512,7 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 		gpiod_set_value(boe->enable_gpio, 0);
 		usleep_range(5000, 7000);
 		regulator_disable(boe->pp1800);
+		regulator_disable(boe->pp3300);
 	} else {
 		gpiod_set_value(boe->enable_gpio, 0);
 		usleep_range(500, 1000);
@@ -518,6 +520,7 @@ static int boe_panel_unprepare(struct drm_panel *panel)
 		regulator_disable(boe->avdd);
 		usleep_range(5000, 7000);
 		regulator_disable(boe->pp1800);
+		regulator_disable(boe->pp3300);
 	}
 
 	boe->prepared = false;
@@ -536,6 +539,10 @@ static int boe_panel_prepare(struct drm_panel *panel)
 	gpiod_set_value(boe->enable_gpio, 0);
 	usleep_range(1000, 1500);
 
+	ret = regulator_enable(boe->pp3300);
+	if (ret < 0)
+		return ret;
+
 	ret = regulator_enable(boe->pp1800);
 	if (ret < 0)
 		return ret;
@@ -767,6 +774,10 @@ static int boe_panel_add(struct boe_panel *boe)
 	if (IS_ERR(boe->avee))
 		return PTR_ERR(boe->avee);
 
+	boe->pp3300 = devm_regulator_get(dev, "pp3300");
+	if (IS_ERR(boe->pp3300))
+		return PTR_ERR(boe->pp3300);
+
 	boe->pp1800 = devm_regulator_get(dev, "pp1800");
 	if (IS_ERR(boe->pp1800))
 		return PTR_ERR(boe->pp1800);
-- 
2.25.1

