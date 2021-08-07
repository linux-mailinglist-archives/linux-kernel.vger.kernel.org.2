Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9DA3E34F4
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhHGKlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:41:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42787 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232210AbhHGKkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:40:51 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 5397C5C00E9;
        Sat,  7 Aug 2021 06:40:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 07 Aug 2021 06:40:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=D5XAa6mnxzOob
        ICi+NDfgLGr0+PRNm4JdFb6bI4vo6Q=; b=nby/EihaKX9ksoZtY6JH6tEIJhyuk
        d9E6Tqa+HCbbZF915agEWQ7X9NXmfXtenV0sqWwWdb9+Zj98foqkcyLfuEHJ9o6g
        XZXH17Omm1qkCLQQE9wJRVXxLO8DbsWNaFBrnqduRH7LFt2GOLy2RXQyI4ryExsZ
        1BNWtmyfwwGZ9Na3/r9XF5I3oqgnnuaKeJ77BP3lJvQTy88Vnf04F6C3U9ukS6X1
        o8dRzDwq4m2FA07A+PwI6plGS2e6/mA1T7V/sbcp2uxzD/8MdWRmRtOrkZOLtyno
        8mXo9CsFSx08Klx+PMQnTWZ7loyyp6y4pnnDE5SLnUuZS9gBA0B2AbCWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=D5XAa6mnxzOobICi+NDfgLGr0+PRNm4JdFb6bI4vo6Q=; b=amaUbw6W
        YfO+szEq/BCfRuOQMS6dORXsuA/oL1xaMe2V6m0JCcR3Snr3f7+24QbXs0cbI4ad
        9ltmrce1Q4yXFGrZCpXpmX1edl3n6DVUeKfboy/2GEJe0XalEkP4H831mZvUpsAj
        d7jOTtrwQrf2xihcZc32STQdPPlZUZZMevZzcw1N8fH4cEpZUilggdCM+pLcwRTN
        viv8gmxNlIy8RiYnm0mQgRz/jO37RDUMDfWC4CiHV93K7GcNPGshEP75gN5o+hnj
        RBCFyhPqGR9N/EjJMwobMxlXRQYqfp8yRc1+LZ3mgiJ2ADgLrWaeFInqPkudPDQ4
        7TwDxApKVODoew==
X-ME-Sender: <xms:ImMOYRoC09ouwF076mSrlz8DMlQx5FQJSBX0JjQQKgE3ztt3zogWHA>
    <xme:ImMOYTpdqYOZnmU5aL30CaZkhdfceJNeNvwMQGbJ9B6VNzdQtZirJg8nw7XB5UIY8
    Ul1X5spyJoz2hGH2SM>
X-ME-Received: <xmr:ImMOYeMlt22pFVWHNiK0EkadWeQYHQ-tk1Q-rX74Ccvkd3gMurhvkLF3zpKzkHkIhi6NYjEdofVSNkpKlZJkuI0yuNa4nRGxR4eJKtC1O98OANKM4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjeefgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:ImMOYc5_LE-8DkoZJ2gxqG895IfKOzyt9Qp5bVa5C8M34pXrhjtlWA>
    <xmx:ImMOYQ5D8WLGg4cKiqrwWHH9TuXCdDbLjwqXPR-WRSyEG7zCTfQJVg>
    <xmx:ImMOYUi9xljwC7LcBA36QceGU72T1Fz3uYjIzDx9i5u1qHRNHSnSlQ>
    <xmx:ImMOYfapbLHRpZMXFM8HJsocFRoMd5cOP7O1UWRQTkV078DAZ17JcA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Aug 2021 06:40:30 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v10 10/11] ARM: imx_v6_v7_defconfig: Enable backlight class devices
Date:   Sat,  7 Aug 2021 20:39:39 +1000
Message-Id: <20210807103940.152-11-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210807103940.152-1-alistair@alistair23.me>
References: <20210807103940.152-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BACKLIGHT_CLASS_DEVICE config is required for the already enabled
DRM_SIMPLE_PANEL to work so let's enable BACKLIGHT_CLASS_DEVICE.

This allows the mxsfb probe to complete successfully on the reMarkable
2.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 0ac7c61c6f3d..486c59cdb174 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -300,6 +300,7 @@ CONFIG_FB_MODE_HELPERS=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_L4F00242T03=y
 CONFIG_LCD_PLATFORM=y
+CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=y
 CONFIG_BACKLIGHT_GPIO=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
2.31.1

