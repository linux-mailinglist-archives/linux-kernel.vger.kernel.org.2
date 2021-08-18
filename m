Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AC23F17DF
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 13:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238837AbhHSLRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 07:17:14 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:54497 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238733AbhHSLRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 07:17:02 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 770025C00C9;
        Thu, 19 Aug 2021 07:16:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 19 Aug 2021 07:16:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=D5XAa6mnxzOob
        ICi+NDfgLGr0+PRNm4JdFb6bI4vo6Q=; b=W5ahaGDqx2Seh2kQfGPuUxnXrxwRy
        FGFpA1vRKDMBaOBkemOPSOqB/mKsUDtyzolnGu/pQ1qWSPyJJaW1ObNi0R5mVQP1
        vvuHAsfZS2yO1JNyVLayq7dl8SWfPtt5Xn8orYMbGo3AMJsltd8MJyRUKToumNWr
        qBTSq7fsgzHyaq2acZpcGn8f3VHiFdCfZS8cZa9gIDc/LgBDd2zA6GuqaeAaGnji
        cQmGvL0WHdvmC77OMr7qv9QSW8M5xFGylvtItQkEOtjTmT6C7hSIzzbjPNm26GM6
        P4Rtd0OkYVKh0G0PZV8PmGnLnLjKtMiDLzyHIItOlwWBhc9ZYEI8K38EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=D5XAa6mnxzOobICi+NDfgLGr0+PRNm4JdFb6bI4vo6Q=; b=XUVot1kV
        fwEmsOmt86r2imJUlVubGX7pucrIVQ04HKjLqrNYjWgYnGy5RNcJy0OuWHCE7i79
        Qw9zWCvdhpGQDBPC4UYcfO8Er6iQkNqWv2JjREkOIZH5mFN28dFL2zjfFY3Hs7LM
        nTmrq5l6z9KtNhIPslkJ0bxT1S7nfcfUB+SCZ5H2Y93i9QcQOmwCWM/VB8ZCS3/Y
        WHMoOotsHRW+ECdGQDFfd0ODSJGiQ+Nqk48xR+X9+6O4hb3X6G1qj1PPkp/N7i0V
        Jwr3yV/nWwNaqbqh5xxN+p4Y3m9m3gukZUD3lukTvMhEXcT6QuCI9tXVmMXBmRDa
        TxFACe0worFUJQ==
X-ME-Sender: <xms:iT0eYetqmuocn3-IXbD48El_DN8fzouu_v3pLC44VcC2whd6LwF4aw>
    <xme:iT0eYTfEaEJX6XUZo3U-_TAHq9b2tPmQ6hPVfIBk3Bedj1zn4AEZHLzZFIK-1iDi2
    JrUN7QXSuI0AFJLtak>
X-ME-Received: <xmr:iT0eYZxN-fJjgB3P0RbnH9D1cyspYArR4vF8hkapMO6bOIEwVLzN45p0whwl8TojBCT3CWvDkZhxm9luKLbn-XVeTADjbhtuhsM4xnsR_GHpJMsHXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:iT0eYZOfk4gHMHKagxrFAsx3RXTG_y6QKrEJQeLWteV23GY3HGJRaw>
    <xmx:iT0eYe_HAJoOMev_KDN-zhy6_pmXdrX8XwCzh6IqQmpsFjuR0Uu_-Q>
    <xmx:iT0eYRV3MFl84bne3LvBDfI556qP3FcE2Ue38krbeeW_xjh0VlkweA>
    <xmx:iT0eYTPKdymRsmw_ZWgZdX_fkwzwvYaKCR-R-rD1bpQX11k_cNpl9g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 07:16:21 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v11 09/10] ARM: imx_v6_v7_defconfig: Enable backlight class devices
Date:   Thu, 19 Aug 2021 01:44:48 +1000
Message-Id: <20210818154449.1037-10-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210818154449.1037-1-alistair@alistair23.me>
References: <20210818154449.1037-1-alistair@alistair23.me>
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

