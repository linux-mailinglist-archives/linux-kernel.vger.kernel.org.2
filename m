Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCEE3E26E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 11:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244372AbhHFJMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 05:12:24 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42331 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244306AbhHFJMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 05:12:14 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D55E5C00D5;
        Fri,  6 Aug 2021 05:11:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 06 Aug 2021 05:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=D5XAa6mnxzOob
        ICi+NDfgLGr0+PRNm4JdFb6bI4vo6Q=; b=d9n1IOC/m9VDVJhmiPkjP13Q3VMbI
        jSGuEYQidyXQLu1m4d+7FRhzWLyp9CyN4AQ0YVickHEBwf/KTibU/ADzIqOGT210
        ty5ehY6IeZCzIFfwKBCk5W7zVNrgHar1JkY6+ds9jvYfyS/GYNdUJrc0XECndZFk
        FN9mBwANm/S3tELqQ6v/dpi3Sm1DSU+DGOuhttbz6YfDdM2yWmftJs0E5rv044IE
        0vb95FkuC5SbAdcVKQIyPaIBUGYpdsPS9s0KOg5/x7mr+vxleXHIYmWVcoT4Wte0
        VSZ1/Rs5mzYZLxqZXlClvgZM+UlwZVmdoUJ1TzvLZp0Z+TZo35Kvnh9zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=D5XAa6mnxzOobICi+NDfgLGr0+PRNm4JdFb6bI4vo6Q=; b=iSGOYtzm
        SysSZMeoaauoykeBo32lrAvFURRpg5OvB0sjskblSsjNclkC3ejYakytpvMg0l5G
        BxNfwUGFDHS8bfTQnUUH3vhxcYDQhznRFoT4dt0Sa1YomdyXcOpIFRBSwVG+RO04
        OW5SzAflh7QHLfzAJZejXnpEwb0Ygo+xAIex45perV3amr/OnHPng1nY4vCmycYw
        r/sts0f4aIKeAalZ36OeqioVV18aX/AQWv2Dj06lXzn2j39I/ZxkpGakQRdZ7S8+
        AEcVlmJgBhHM833w+UQj4GRSmnKrHNc9JGQBpawRVXdKFJcvf9quInTLgYA4HueT
        2olgHdTBkYQoQQ==
X-ME-Sender: <xms:3vwMYX15nfYbBm6k9c5AZ-wTfLKhYpIqofYsfPQlNgY2jn6IGPRvjA>
    <xme:3vwMYWEkZSnZIWc2_duonVt0FHWGporaeaxKZGLOyTZzp4Sp4FxzinSPzkqC1MaRF
    O-a0yLAIFA6sai2yqY>
X-ME-Received: <xmr:3vwMYX77ix0KMc3H-2gOYxD-8hiHobnszhMjdK2ogjFmZUDUXQj0aJhDUCIuYEBQTh9TA-MG8AF-8zkyuOEItxHAMx2iyyabXOtsYdPwEu4xdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepgeegtdetjeekge
    eguefgheeuvedugedvteejveeiudegvddtkeffkeehtdetudfhnecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhish
    htrghirhdvfedrmhgv
X-ME-Proxy: <xmx:3vwMYc20mLmRW4rInAEO4Sb-sOsmPjlzYnk0eMzeVW8RXezRM028Pw>
    <xmx:3vwMYaHttOfeKdBvawMJHgKu4_yCWUTfUla28eBl7F363c57C_qd3g>
    <xmx:3vwMYd9v2mTJoIJVE04nRozWPbG2ZMQeNfm-jzd9XZ-8-cMCTtvwDQ>
    <xmx:3_wMYd2IVBtSbNd4ZNfhnXOvhS8qpHMohr3EdsbDppJdIxI5v0Skww>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Aug 2021 05:11:55 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     lee.jones@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com, Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v9 11/12] ARM: imx_v6_v7_defconfig: Enable backlight class devices
Date:   Fri,  6 Aug 2021 19:10:57 +1000
Message-Id: <20210806091058.141-12-alistair@alistair23.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210806091058.141-1-alistair@alistair23.me>
References: <20210806091058.141-1-alistair@alistair23.me>
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

