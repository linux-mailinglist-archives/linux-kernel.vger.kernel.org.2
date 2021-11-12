Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8513644EB6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 17:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhKLQfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 11:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbhKLQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 11:35:44 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5B2C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:32:53 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u1so16464777wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 08:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGKUSGKtLFj44yzs+ZJ05zEIvv3LfPz2d/+T3ZZAwrY=;
        b=zNZg9CCNXXFkQwszxD+xvUqQjfREfGlJ87bFXONypKNRSpdEs3HT1X//C7GyxRiK9r
         6Sb8z0ojOE2Vbj5GAogYfz4gBnd8ztC6FELdNwbMNYf0PZDaky8o4HJarbeK/0koRcFm
         5zN52PHwT9MlRMKDQEOP+PyRoK63Z2UlditWTuCrJDsTnp6ezHZJ/OjOds9fzkFAAXKz
         Ae3humcL3Am0PHYTQck78M5BBP6hEpxGuLW0D2M/ODU5QeFaz7mo3WcRqp+V5QHams5n
         nOD8iCa1UakV6m3K8bDpCptrZi6rTEGK5nZSmrI1hSmxIsittL+qtciHw9BLrUKtVcxg
         xV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGKUSGKtLFj44yzs+ZJ05zEIvv3LfPz2d/+T3ZZAwrY=;
        b=2vEsmMvsFIWhLB++7+1Sugue1Xx8z26fQHLjcTg5+N9C3rK60oOyzxbYabDEggbHcn
         HR+8EpkCp0YjBDcA9NFbCWyQspC1yOWfSz7AT9WAsRnwuZPgauDdcas7FtGn8y6fLS/6
         GQvnHkBDIyn3MUQp62v06R77h64ZByYy3gwGbFeE5prMCF6NHIPk24JIVBCLDwM3yJRs
         +pSn0l+5TXx8mjZ0YOUE1U85iVLAO4MF2gvJichZxh2Gz6JGEDvMDIW1Xvz+/1V749c0
         rn+JzPq0nXaOqJ9W8UBCJZXuT1Ptk+Z64kpUs5V29+XtgaluvBXACZts+SGGmsxUyVZ6
         uUlw==
X-Gm-Message-State: AOAM532NenHjAJnxdKzqA9OguhaGLGT790pH6PP+jZBX+X0K5F7udNL8
        0HelTHVK2G+hXYofPzSYpGYt3Q==
X-Google-Smtp-Source: ABdhPJxRxksvOD26GekokFvPEm27nCXht9IQYJiQdZxzfsNqhBLqbNGJGsuI+ejvei9GfRgTqw1ieA==
X-Received: by 2002:adf:e38d:: with SMTP id e13mr20027652wrm.402.1636734772006;
        Fri, 12 Nov 2021 08:32:52 -0800 (PST)
Received: from amjad.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h15sm6253796wml.9.2021.11.12.08.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 08:32:51 -0800 (PST)
From:   Amjad Ouled-Ameur <aouledameur@baylibre.com>
To:     khilman@baylibre.com
Cc:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        p.zabel@pengutronix.de, balbi@kernel.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v3 1/3] phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
Date:   Fri, 12 Nov 2021 17:28:25 +0100
Message-Id: <20211112162827.128319-2-aouledameur@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112162827.128319-1-aouledameur@baylibre.com>
References: <20211112162827.128319-1-aouledameur@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use reset_control_rearm() call if an error occurs in case
phy_meson_gxl_usb2_init() fails after reset() has been called ; or in case
phy_meson_gxl_usb2_exit() is called i.e the resource is no longer used
and the reset line may be triggered again by other devices.

reset_control_rearm() keeps use of triggered_count sane in the reset
framework. Therefore, use of reset_control_reset() on shared reset line
should be balanced with reset_control_rearm().

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/phy/amlogic/phy-meson-gxl-usb2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/amlogic/phy-meson-gxl-usb2.c b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
index 2b3c0d730f20..9a9c769ecabc 100644
--- a/drivers/phy/amlogic/phy-meson-gxl-usb2.c
+++ b/drivers/phy/amlogic/phy-meson-gxl-usb2.c
@@ -110,8 +110,10 @@ static int phy_meson_gxl_usb2_init(struct phy *phy)
 	int ret;
 
 	ret = reset_control_reset(priv->reset);
-	if (ret)
+	if (ret) {
+		reset_control_rearm(priv->reset);
 		return ret;
+	}
 
 	ret = clk_prepare_enable(priv->clk);
 	if (ret)
@@ -125,6 +127,7 @@ static int phy_meson_gxl_usb2_exit(struct phy *phy)
 	struct phy_meson_gxl_usb2_priv *priv = phy_get_drvdata(phy);
 
 	clk_disable_unprepare(priv->clk);
+	reset_control_rearm(priv->reset);
 
 	return 0;
 }
-- 
2.25.1

