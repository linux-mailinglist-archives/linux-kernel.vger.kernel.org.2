Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EF2396F76
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 10:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbhFAIue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 04:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhFAIuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 04:50:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD332C061344
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 01:48:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c3so13354356wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 01:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HsyI5GdZuVzBJ4Q40lGtjbheVohc16mnJhwL7iMTmSw=;
        b=xaimFvKzZB07yjuzlZWyPID+i3O41/kcqJPcS6iQTWYstiOp6aDbYne2LEu5c5Bux7
         3X91TH+ey2cmfMXZ8kv0um25JeEv8d8DqKkZfsjA0q4JdTqyq9I6DPvCkw9m4c1tt1tf
         lPn1qCjbi02nMpYFRTg/itPrKYtWrubWxcg56rL0v7agha79MwcofUh5IEPUhisFoHHi
         5UqOQYX3i8u2pq8/W+d/9E1fc17DzamiGADiKsbfUwM7uvp1mIfiiQ5SLqhtevM5f3pl
         BnMKeRC6P3WWASjB21jSQrIW4tuqsodmzAcONWwCXZj3Zh7rFDkH9hvR5rdJCpUtLySu
         zguA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HsyI5GdZuVzBJ4Q40lGtjbheVohc16mnJhwL7iMTmSw=;
        b=X4vFKTd04Mu3xfIlch+IeWefSmJejsAeFeq6vnLiQjmsYcdb023lvEbz/+IZ3ctwfL
         WvhsLb7byH4S+Q9K9QDeRrE+61E4CjdnWQf2o55+D3J+HMQNOGzVHMhY2DHY3d9R8Wd3
         3QZkqrJgmP86UYLyvg/JJUtLKBs2iotjIdsl+kt60DWlDTwV/avCPynoTbOYsAKpN+qC
         2PJ2p/gARoJpnYCH71Mp0rQOkFN6R6s1DX9YgkGDf0fR7rzX78C4I32yY6qlkycVsKYB
         MjQ2wtE/gWhF5c3TggTEYzmtUdPlbCrLBtEdBIQMe8UDZnl80N/tYAhiMPh73LgtwL4i
         o0Rw==
X-Gm-Message-State: AOAM5331gQY3/3KKcEENRWWNhzlxuXZdIB7T57nY6VxQ4HCH9UfSpqJn
        2EjyUoSkc0cimwU6rOqOCEWUgA==
X-Google-Smtp-Source: ABdhPJwicPfpiz9Ps9bnHfK5U9UhZq6pV1e3HJK+KjRppnJs8C7vVjbqoq40pD23inszRKpnR1omzw==
X-Received: by 2002:a5d:4c49:: with SMTP id n9mr26124117wrt.417.1622537313482;
        Tue, 01 Jun 2021 01:48:33 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:a3a:d001:6a80:207a])
        by smtp.gmail.com with ESMTPSA id t14sm1710470wmq.16.2021.06.01.01.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 01:48:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     balbi@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] usb: dwc3-meson-g12a: fix usb2 PHY glue init when phy0 is disabled
Date:   Tue,  1 Jun 2021 10:48:30 +0200
Message-Id: <20210601084830.260196-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1816; h=from:subject; bh=Qf752RJbSHGdE83hMRrW4mM1Uj4TitFrYwm+jlRhNvY=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBgtfRG0QSALHdUEWJSyZF78sJxWZurbP2ZCdFuehVl tryIs/6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYLX0RgAKCRB33NvayMhJ0ediEA DAEklNiHPCq29uk/iUjjt18PU0FxsriKAlJsf0WAkT4X8QAiBmOmFWHhG52Ugh1DIAar9YxggiaLVp nxIoiNOEcUG0n8PYca4XoMrrT/K9Qg6gyuEvdtdf5im26Z/pZzMpSQdaG+yzXlOdzA4vRxVv531vZb HE2G7Y5C3/G4eVYIXeN25A61PxbEp0XQLJgrIbZQrsa2x34Da0So46A1PBZ+/KG9xyi+lYk/uo8Ol9 +1CoMKDwOJr36+PL2pDgXEG8bPMqbJdOEcuMXihqH9ZOdSSaRqiX/Xcll0063Hgzp0sSid7J1Eux8W gZ3Y2egjh3e1b2q3dPU9JHrDyAMTCKtqzlwTzs2g3TZE+XT5deZ5THiOyZ8T/Ix2y4L1P71LeSuJNS T4MsZIp+MZueAd8D6CzH/rQZ5ogCFHdde8gA1ukOF2ow/Ji4P6fzzTSi6BbnreT1fv/ZGxJdIuPqe5 3ChDtsFjVHfhBHOC8R4mOiLV+r7lriC2CdtjSesNqpyy4AhHLqFgJF0tUweDK4axJuKblZdeSKYLW9 cN/48ySEMgJKSp7eHV6wLlIwsWhj79IUbfaBAcb5TQHwh/w9XfRLHGeXrqljzkz1KcOYFK8hEMMTqP GeqUnb0elGu5F1Qkh3MHos8Bfr7d5LhnJNGf48gOJpL5I8+HP1qXf2LUG4lg==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When only PHY1 is used (for example on Odroid-HC4), the regmap init code
uses the usb2 ports when doesn't initialize the PHY1 regmap entry.

This fixes:
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
...
pc : regmap_update_bits_base+0x40/0xa0
lr : dwc3_meson_g12a_usb2_init_phy+0x4c/0xf8
...
Call trace:
regmap_update_bits_base+0x40/0xa0
dwc3_meson_g12a_usb2_init_phy+0x4c/0xf8
dwc3_meson_g12a_usb2_init+0x7c/0xc8
dwc3_meson_g12a_usb_init+0x28/0x48
dwc3_meson_g12a_probe+0x298/0x540
platform_probe+0x70/0xe0
really_probe+0xf0/0x4d8
driver_probe_device+0xfc/0x168
...

Fixes: 013af227f58a97 ("usb: dwc3: meson-g12a: handle the phy and glue registers separately")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc3/dwc3-meson-g12a.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
index bdf1f98dfad8..9c944bc6d555 100644
--- a/drivers/usb/dwc3/dwc3-meson-g12a.c
+++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
@@ -651,7 +651,7 @@ static int dwc3_meson_g12a_setup_regmaps(struct dwc3_meson_g12a *priv,
 		return PTR_ERR(priv->usb_glue_regmap);
 
 	/* Create a regmap for each USB2 PHY control register set */
-	for (i = 0; i < priv->usb2_ports; i++) {
+	for (i = 0; i < priv->drvdata->num_phys; i++) {
 		struct regmap_config u2p_regmap_config = {
 			.reg_bits = 8,
 			.val_bits = 32,
@@ -659,6 +659,9 @@ static int dwc3_meson_g12a_setup_regmaps(struct dwc3_meson_g12a *priv,
 			.max_register = U2P_R1,
 		};
 
+		if (!strstr(priv->drvdata->phy_names[i], "usb2"))
+			continue;
+
 		u2p_regmap_config.name = devm_kasprintf(priv->dev, GFP_KERNEL,
 							"u2p-%d", i);
 		if (!u2p_regmap_config.name)
-- 
2.25.1

