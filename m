Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB633ABD07
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 21:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhFQTpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 15:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbhFQTpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 15:45:35 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CFCC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 12:43:27 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x19so3496789pln.2;
        Thu, 17 Jun 2021 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IphS2NfYy5YZOfBpgQZDF/SMsovEiyi9nwsRO6kEmeA=;
        b=W/pVQVs4NBXtAYB44k2FtP7IHprt6d6EQ3dpcGJzbORkjzsTXC497kYd5Ph5SvW7On
         AQOK39Cn16MWTOGPzVp1O2FYev8QYj+EfmqZlnkpPvMw068YdCfdq58EssXhzPIrWn3l
         YTmqO05Yn3QKdXQAj5ntx2kInNGvcqNCv1vLDE3VhahwWsHblJqjx90cDlqI6EqjTtrG
         3/KMyZvPalXzJF0rmMjIdJX326IspxknvB45A0NbzN0VdXGDk3UK1+gSo54j5jTmKKjK
         VgMBkuh0vBvr4g48oU8cQfNbbPovAzJ5E9Qe4New5O8l17FRfuCHWAfDXp1TXNvfo5ma
         aUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IphS2NfYy5YZOfBpgQZDF/SMsovEiyi9nwsRO6kEmeA=;
        b=laaz8DY2n9iwLP8ZeJdv624rigG6ztaZg1Xj4H8fkbzVx4aLB9Ob6IIRThUkmtAcnv
         VebxJ+nYtVycu98kuODqy4Ycn8fXdeTrSYdkOSBZAI5tTDcQ4wxEJ2ifG1SGW1rl2DDn
         7zVzJZvCcuh10ij5Fg+fcIqWx7CsjHUnELkkh9IVA3SNQl1hL4tqYcBKjtCA23vMc1xA
         Ty5g5s35t7hgUcea+Pe9u1bbIK9CpcIVZIzMbKlCVZFy8D4ZbT3+UF2QKy6VvZSPGUr5
         IqQq+J386W88fLwKL+3iD2u3FrL+VR1VkkMZnLXn6PLb3TfH62iHq4aMQneuP2Bb3a0F
         /iGQ==
X-Gm-Message-State: AOAM5310XIyg9bjp0zrod7aJoirVVaS+Mz5U6Ir8QAaeU535LhpiOdYn
        D6R1dYmCyEWHe4PC472GTTk=
X-Google-Smtp-Source: ABdhPJwx8ZB3IeQr09msM778ELNHTToq+Qc73hhIl+bWtjosPtRLzG8166FGLfKwgITZ18ya2OFIXQ==
X-Received: by 2002:a17:90a:5795:: with SMTP id g21mr6988218pji.235.1623959006613;
        Thu, 17 Jun 2021 12:43:26 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.75.27])
        by smtp.gmail.com with ESMTPSA id z9sm5987187pfa.2.2021.06.17.12.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 12:43:26 -0700 (PDT)
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
Subject: [RFCv1 3/8] phy: amlogic: meson8b-usb2: Use phy exit callback function
Date:   Thu, 17 Jun 2021 19:41:38 +0000
Message-Id: <20210617194154.2397-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210617194154.2397-1-linux.amoon@gmail.com>
References: <20210617194154.2397-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder the code for phy bulkclk disable in .exit callback function.

Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/phy/amlogic/phy-meson8b-usb2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson8b-usb2.c b/drivers/phy/amlogic/phy-meson8b-usb2.c
index d48171b0b32e..2b32a3eabccf 100644
--- a/drivers/phy/amlogic/phy-meson8b-usb2.c
+++ b/drivers/phy/amlogic/phy-meson8b-usb2.c
@@ -164,6 +164,15 @@ static int phy_meson8b_usb2_init(struct phy *phy)
 	return 0;
 }
 
+static int phy_meson8b_usb2_exit(struct phy *phy)
+{
+	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
+
+	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
+
+	return 0;
+}
+
 static int phy_meson8b_usb2_power_on(struct phy *phy)
 {
 	struct phy_meson8b_usb2_priv *priv = phy_get_drvdata(phy);
@@ -220,13 +229,13 @@ static int phy_meson8b_usb2_power_off(struct phy *phy)
 				   REG_DBG_UART_SET_IDDQ,
 				   REG_DBG_UART_SET_IDDQ);
 
-	clk_bulk_disable_unprepare(priv->num_clks, priv->clks);
 
 	return 0;
 }
 
 static const struct phy_ops phy_meson8b_usb2_ops = {
 	.init           = phy_meson8b_usb2_init,
+	.exit           = phy_meson8b_usb2_exit,
 	.power_on	= phy_meson8b_usb2_power_on,
 	.power_off	= phy_meson8b_usb2_power_off,
 	.owner		= THIS_MODULE,
-- 
2.31.1

