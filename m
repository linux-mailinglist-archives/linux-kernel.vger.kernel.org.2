Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FDC63ABD06
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbhFQTpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhFQTpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:45:19 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5D6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:43:10 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id q15so5769011pgg.12;
        Thu, 17 Jun 2021 12:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tzl7V45UMyttxYvjiG/RGthazfovWqPJvvGzwmVDhlo=;
        b=nX6c2e296ygCF1xZbasjThl+i6Ji+L2S4BwRH6Yqu5GAayLfXb/+7noHwKrOBgUhT9
         eg2K8QQKUCQtGI30BQjNCvkson1PiNZIydbEt4cn3X0jb3cSPVKu8RtW23Ga/do6cx8l
         s/i584YLWZFfY2swVuF0bgfLDDTAJDioZtSyV46rFruBtv95EFO/v26qprrx+naHMg6M
         lFwo2KSs4Ir8cAEpHhXJCuHOCzDuFlXqVr9mSZov9TiqBb9CS8s88/2qQbksE+oNykis
         D1BoDJgcAA4aFeSifOrKf3dxz8Zh9NnbDwFhbyRFV++z4+dmK99df1yl1LRUFxVEsCG/
         UX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tzl7V45UMyttxYvjiG/RGthazfovWqPJvvGzwmVDhlo=;
        b=tTxoCJhnfZLlTrSuC33s6mWiAHniBMq+srPGWhmLPBaKSH/H17PRD8C8fsRePQ+OSL
         z4TABYVzx4+K2sGybh3wbGbEuQ3QvbKoDxE/Pzs2Ed9+5PD+1ftDEbrM6PDlV/LUJxz3
         3wcDbcQYBBbKCpQ7WISzSrk1saYxDQI2DZan4qiHzjpaXiRxKG9mj/k59kcoeAVhnkUo
         RSj6eX+2cC4+IJqz7BIrbITjIbSu1sFewgOzAfHTQt2GOzw9vmvN+vWew7Lw/ZY11gtv
         FbqeeI1A7PLtEGqFykJwSE6oGTzVjyV+Dzt6bXLOKFktNTwxeSwY+fULnJZ1s9DcD/+V
         F4Lw==
X-Gm-Message-State: AOAM533cBpJ04HSd7vbhhi/9wKWPeNRjLQqiIlBjOUalNb0KTtnJjAmn
        Z9tn7W25NRV8oLRwoO2809s=
X-Google-Smtp-Source: ABdhPJzSDzSC/y7Al0PHl13B+aX97fg7FS5mmLZ0StkNpzHKaEaV2uuutbLzj6Fs44BbtxcdaNvEGQ==
X-Received: by 2002:aa7:8587:0:b029:2f8:8439:c265 with SMTP id w7-20020aa785870000b02902f88439c265mr1528450pfn.38.1623958989932;
        Thu, 17 Jun 2021 12:43:09 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.75.27])
        by smtp.gmail.com with ESMTPSA id z9sm5987187pfa.2.2021.06.17.12.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:43:09 -0700 (PDT)
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
Subject: [RFCv1 2/8] phy: amlogic: meson8b-usb2: Use phy init callback function
Date:   Thu, 17 Jun 2021 19:41:37 +0000
Message-Id: <20210617194154.2397-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617194154.2397-1-linux.amoon@gmail.com>
References: <20210617194154.2397-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the code for bulk clk_enable into .init callback function.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index 771b73f3b44e..d48171b0b32e 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -142,10 +142,9 @@ static const struct regmap_config phy_meson8b_usb2_regmap_conf = {
 	.max_register = REG_TUNE,
 };
 
-static int phy_meson8b_usb2_power_on(struct phy *phy)
+static int phy_meson8b_usb2_init(struct phy *phy)
 {
 	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
-	u32 reg;
 	int ret;
 
 	if (!IS_ERR_OR_NULL(priv->reset)) {
@@ -162,6 +161,14 @@ static int phy_meson8b_usb2_power_on(struct phy *phy)
 		return ret;
 	}
 
+	return 0;
+}
+
+static int phy_meson8b_usb2_power_on(struct phy *phy)
+{
+	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
+	u32 reg;
+
 	regmap_update_bits(priv->regmap, REG_CONFIG, REG_CONFIG_CLK_32k_ALTSEL,
 			   REG_CONFIG_CLK_32k_ALTSEL);
 
@@ -219,6 +226,7 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
 }
 
 static const struct phy_ops phy_meson8b_usb2_ops = {
+	.init           = phy_meson8b_usb2_init,
 	.power_on	= phy_meson8b_usb2_power_on,
 	.power_off	= phy_meson8b_usb2_power_off,
 	.owner		= THIS_MODULE,
-- 
2.31.1

