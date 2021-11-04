Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD958445722
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhKDQV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbhKDQVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:21:24 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306CCC061203;
        Thu,  4 Nov 2021 09:18:44 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id c206so6028803iof.2;
        Thu, 04 Nov 2021 09:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZ5rOSu+Pvwwo25HoRKbQcBfCSk933X5/lGtJvS6+EU=;
        b=czMDr0CyxLZfz4hJsuOExFrZxsVB7HgI4duA7bc7lABdMWztL90CGO4kl9biJ/UYa6
         ExNGK/3kQCTcmkBP5YtFuQJkvgT31sMtXVlEwkslxCR+jZmgFOXRS7ZLWYoVgIktj+p7
         VMjaRSVZEwiVECUNaZm/gUPhAEW1QqZE89CLd+f9i3rA8YbV+4RkMQapyksELwJ9uDmu
         2pA3z2QbX3c0+EVHThd4SxtcnzjgDkWEcdrTOVVfFNS+OjcPAFQ1WpVNObMGiO/HnJbn
         mVhTGkOkEVV85jHCyvqU6NlLaN3gTCyp7w5Z4zlkJuyZmIXQpa1MybmEiIA/si6Ebf5b
         uYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZ5rOSu+Pvwwo25HoRKbQcBfCSk933X5/lGtJvS6+EU=;
        b=lc7Vd+wGYsMFKirrOj8kq8ovxJm3RnRbQVbu/nQ1A3MR07QQYmcIlmZFCd3IC0qjhO
         baxIHAEP4+SkfBUpS9UdowHQaY/8zeJR5/X5kw4k2Cr41IGH0NKz2S2ps70eZUwo5WTi
         chRexWTSKbLyHwYgZoa8xtxIVwNF/7DUnN8vbDv/b0Tz8gleN7aNRyvFO2pc1SEK+tn1
         QlNdSftkYW5ZKouzCeU0FeqZdXTO9TguIYWXIWStPUaWCgQL+x+BaL15cPmBdeT4NX4F
         MmsUBcZTtoyU/B27p/uZ2kkZ0nmR2xVNXI18eUhrydZv58osrfy6vJ7q7Ijh1TGi3ovr
         O76Q==
X-Gm-Message-State: AOAM5339uKAT/Bt9wOdNzZvB/it/+1gHGQuHF/7ZF6Z4tvFACT+Xf26l
        ePPvc2i/lHwIa5+ZBpgBfAQ=
X-Google-Smtp-Source: ABdhPJy6wDM2SmdGObT2rmqrNV2I64GnrWtdMbkK2KWAmjqSs7hB/HANO3nloP4Q1Hkc7UsPky6URg==
X-Received: by 2002:a05:6638:386:: with SMTP id y6mr4607797jap.49.1636042723329;
        Thu, 04 Nov 2021 09:18:43 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e81d:737a:bb84:83ba])
        by smtp.gmail.com with ESMTPSA id e17sm3266326iow.18.2021.11.04.09.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:18:42 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, ariel.dalessandro@collabora.com,
        krzk@kernel.org, tharvey@gateworks.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 8/9] arm64: dts: imx8mn: add DISP blk-ctrl
Date:   Thu,  4 Nov 2021 11:18:03 -0500
Message-Id: <20211104161804.587250-9-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211104161804.587250-1-aford173@gmail.com>
References: <20211104161804.587250-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT node for the DISP blk-ctrl. With this in place the
display/mipi power domains should be functional.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 4e9d7099bb4f..6ac14903bcef 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1011,6 +1011,34 @@ aips4: bus@32c00000 {
 			#size-cells = <1>;
 			ranges;
 
+			disp_blk_ctrl: blk-ctrl@32e28000 {
+				compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
+				reg = <0x32e28000 0x100>;
+				power-domains = <&pgc_dispmix>, <&pgc_dispmix>,
+						<&pgc_dispmix>, <&pgc_mipi>,
+						<&pgc_mipi>;
+				power-domain-names = "bus", "isi",
+						     "lcdif", "mipi-dsi",
+						     "mipi-csi";
+				clocks = <&clk IMX8MN_CLK_DISP_AXI>,
+					 <&clk IMX8MN_CLK_DISP_APB>,
+					 <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+					 <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
+					 <&clk IMX8MN_CLK_DSI_CORE>,
+					 <&clk IMX8MN_CLK_DSI_PHY_REF>,
+					 <&clk IMX8MN_CLK_CSI1_PHY_REF>,
+					 <&clk IMX8MN_CLK_CAMERA_PIXEL_ROOT>;
+				clock-names = "disp_axi", "disp_apb",
+					      "disp_axi_root", "disp_apb_root",
+					      "lcdif-axi", "lcdif-apb", "lcdif-pix",
+					      "dsi-pclk", "dsi-ref",
+					      "csi-aclk", "csi-pclk";
+				#power-domain-cells = <1>;
+			};
+
 			usbotg1: usb@32e40000 {
 				compatible = "fsl,imx8mn-usb", "fsl,imx7d-usb";
 				reg = <0x32e40000 0x200>;
-- 
2.32.0

