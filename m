Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FEE330EBB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 13:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhCHMzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCHMzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:55:22 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E989C06175F;
        Mon,  8 Mar 2021 04:55:22 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c76-20020a1c9a4f0000b029010c94499aedso3737160wme.0;
        Mon, 08 Mar 2021 04:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KVQCxPBtXK0auJ43xEYQjSL/Z4nheSdWg2LvF6F1wJI=;
        b=pARiNyw1YcUOMJvaXJ1g6eSY/Mv/Ky1KJDheYsAaWws0u492/eWdpk5mnZcsYSht4s
         /rpIi7/cRunjHvGrydCblnZyuKVSWTOl6wTbz33FSdd2jsB8lAbFE0GZUIt1Hu3AN8BT
         oZzDpLuteWAc8Nmu3GMfJfXm0296MOZsesbAUyVjjhYAKOnxj4VFqopcSt2ZiDrXWn20
         39njPGXVP+/1MW41tLrypBgrCJQxs7s6uCLKL+lx07f5RWPLJHrHbq0+y8oJFMIXE4cq
         BuvsSB5c4gSwTRR/pyeLpc4FM1n9JyJlzy+odqcsn4QlKA8Lf6jF8iSTRNSF0t9xoO9g
         WUGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KVQCxPBtXK0auJ43xEYQjSL/Z4nheSdWg2LvF6F1wJI=;
        b=nLzayUrA6R2D86qJJH5lzYLhHGhTejvBVn1uZvF/jKvWnlGjlJ4lLfGD7sLdObalkV
         7sVv8CcbiBrW1pcXZQoWZzE7S9vEQjT5zap2Q9jTrcGI3dA807a9gHhFUD8N/ul+zo3L
         BjwLlHJ7Trmd0/G6yB84AbROYZqPZTOC8DpTM5AdL4D2/VwDK4LqfPSWvLNldn8FSlIg
         ERmssiCKKDZCmhowgHALbaFGsAV8b2VhvpkOkJjoCSCmEpnF7cJTiICcz6wwwlCGyriR
         GX6BrobVXcZAq1+M/PVoFRY7hTB75oCt4xhMUsoK/iQlUTSL+42IDY0EupDW4dNd6ut5
         adHg==
X-Gm-Message-State: AOAM5302DhriRxYFx5wIHtrQKNB52ZYMzKQZxOY0c8m/2y6XXtS3XXfB
        BWrSU/xIodkWK+IKSDb8sJE=
X-Google-Smtp-Source: ABdhPJyo3EkJKVSzQUBHJvbbU+XmRoQoLzMt5AyOTw9iRYuUk17IetN9mP7JCkTVorwzkbPVxhFutA==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr21898744wmj.44.1615208121206;
        Mon, 08 Mar 2021 04:55:21 -0800 (PST)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270095bc7625808eade0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:95bc:7625:808e:ade0])
        by smtp.gmail.com with ESMTPSA id o20sm18922033wmq.5.2021.03.08.04.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 04:55:21 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     m.felsch@pengutronix.de, devicetree@vger.kernel.org,
        will@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, krzk@kernel.org, robh+dt@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, catalin.marinas@arm.com,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v2 1/1] arm64: dts: imx8mm-nitrogen-r2: add ecspi2 support
Date:   Mon,  8 Mar 2021 13:55:18 +0100
Message-Id: <20210308125518.255216-2-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210308125518.255216-1-adrien.grassein@gmail.com>
References: <20210308125518.255216-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description for ecspi2 support.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 4f4cf7df5a5a..50c2ed0470da 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -52,6 +52,17 @@ &A53_3 {
 	cpu-supply = <&reg_buck3>;
 };
 
+/* J15 */
+&ecspi2 {
+	assigned-clocks = <&clk IMX8MM_CLK_ECSPI2>;
+	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_40M>;
+	assigned-clock-rates = <40000000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_ecspi2>;
+	cs-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
 &fec1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec1>;
@@ -286,6 +297,15 @@ &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
 
+	pinctrl_ecspi2: ecspi2grp {
+		fsl,pins = <
+			MX8MM_IOMUXC_ECSPI2_SS0_GPIO5_IO13	0x140
+			MX8MM_IOMUXC_ECSPI2_MISO_ECSPI2_MISO	0x19
+			MX8MM_IOMUXC_ECSPI2_SCLK_ECSPI2_SCLK	0x19
+			MX8MM_IOMUXC_ECSPI2_MOSI_ECSPI2_MOSI	0x19
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			MX8MM_IOMUXC_ENET_MDC_ENET1_MDC			0x3
-- 
2.25.1

