Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9AA53ABD09
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbhFQTqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFQTqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:46:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBC3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:44:00 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so2404531pjo.3;
        Thu, 17 Jun 2021 12:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hdzvs1xs4XG3cpyN4NkJEKqbHLmgGkruX+DR+rsCUB8=;
        b=KzJwSd6ASPVS70vFaIeoMnaFl69YBeca53kGHvijVtBhgsWbanwrpO8qZcVlpjhzGy
         oqCWhUzPocyp1GqUVxqQDpd+pdcZV1buOgaveUqgEA/lu9wT5s1/sOtP99BFFCoIUB9h
         GrFF+nn++sPbetBCyrdoZDL3Mj7Kr6RTEYETq17limuCSOIk0ZIfVM59aw31RIiXxuJ6
         AjKTH1Y0cpascG4sdEbQxbdRZZBIIWd85cV/dvG0FOUXPWqeNcMnfw1EOOLCS9Kdyb3P
         3CjoywJ+C4DOZz3YxtWeZZJJ1MGuYNJBJeWQ7jgqaT8avdVT4bWQbRypsrfPvmWe+vB3
         cbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hdzvs1xs4XG3cpyN4NkJEKqbHLmgGkruX+DR+rsCUB8=;
        b=HNRhghDFFk9iU64/F8XJrCPCgWBe3JgYOgoqVbhAd6qs1naINWOjiV4gm10Myl39FV
         u05c5JJz5O6Mcu4NcFcR4BxjSae1T+NQ7TnxRNWcZb5/5Pe5N0MoMgC2PPmnZcjoJ+0U
         wo/g28jiGmMHdFpMj/KxiFk12dEYIxCqC5cjZjIfBvf04vB5fCUKhuydGO98xt58jwjI
         2C6bsFIBBXUePlPZyxLrVvyiltQuFOtgobG/iHYFPKful+vBA7jBix7em/HNxPffyX49
         RJh0SqkgeyZ771Ue6phcP004VIXKbzK8G7Q22j00hNVapf5WNA2JsJmRSzYpI+/wSfR9
         Fzow==
X-Gm-Message-State: AOAM531mcOWFemgJtrj/opHsz0oaCwYe2VsP1rNnFZtzb3u/FfC+1qgl
        zzPkUwtJjIn9AdbkTKpurSk=
X-Google-Smtp-Source: ABdhPJyONX1RytaqS/1Abh60D0SZ6YpWdjvwgyXHIGp/cDL0NRrUFyKJEfDLIqaBQz0JNR6EF1p1Lw==
X-Received: by 2002:a17:90b:3147:: with SMTP id ip7mr7180115pjb.8.1623959039950;
        Thu, 17 Jun 2021 12:43:59 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.75.27])
        by smtp.gmail.com with ESMTPSA id z9sm5987187pfa.2.2021.06.17.12.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:43:59 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     --to=linux-phy@lists.infradead.org,
        --to=linux-arm-kernel@lists.infradead.org,
        --to=linux-amlogic@lists.infradead.org,
        --to=linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFCv1 5/8] phy: amlogic: meson8b-usb2: Reorder phy poweroff callback function
Date:   Thu, 17 Jun 2021 19:41:40 +0000
Message-Id: <20210617194154.2397-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617194154.2397-1-linux.amoon@gmail.com>
References: <20210617194154.2397-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the phy_meson8b_usb2_power_off fundtion to avoid compilation
error.

drivers/phy/amlogic/phy-meson8b-usb2.c:247:3: error:
	implicit declaration of function 'phy_meson8b_usb2_power_off';

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 18e0986f6ed2..ab23a584d7b7 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -205,6 +205,17 @@ static int phy_meson8b_usb2_setmode(struct phy *phy, enum phy_mode mode,
 	return 0;
 }
 
+static int phy_meson8b_usb2_power_off(struct phy *phy)
+{
+	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
+
+	if (priv->dr_mode == USB_DR_MODE_HOST)
+		regmap_update_bits(priv->regmap, REG_DBG_UART,
+				   REG_DBG_UART_SET_IDDQ,
+				   REG_DBG_UART_SET_IDDQ);
+	return 0;
+}
+
 static int phy_meson8b_usb2_power_on(struct phy *phy)
 {
 	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
@@ -240,19 +251,6 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 	return 0;
 }
 
-static int phy_meson8b_usb2_power_off(struct phy *phy)
-{
-	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
-
-	if (priv->dr_mode == USB_DR_MODE_HOST)
-		regmap_update_bits(priv->regmap, REG_DBG_UART,
-				   REG_DBG_UART_SET_IDDQ,
-				   REG_DBG_UART_SET_IDDQ);
-
-
-	return 0;
-}
-
 static const struct phy_ops phy_meson8b_usb2_ops = {
 	.init           = phy_meson8b_usb2_init,
 	.exit           = phy_meson8b_usb2_exit,
-- 
2.31.1

