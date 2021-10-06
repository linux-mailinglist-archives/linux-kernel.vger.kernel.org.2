Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB7404234CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 02:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237176AbhJFAHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 20:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237019AbhJFAHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 20:07:19 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5D4C061749;
        Tue,  5 Oct 2021 17:05:28 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p80so860731iod.10;
        Tue, 05 Oct 2021 17:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x11HqO+/PtZ+6U0J6esjEI4aLwAmQPl4b6jkYZuk7fs=;
        b=EInVCwBKI97wtAWN81C9K10uzeMPwCZdF4HHjHL0U2WAyuzerVNbTyxUpSWEXhFRpG
         bLYpXWbkcICSlovgdXjnhKvaW46Wi7LH651hrwflA8HCkXvvlf/aezemgguqS8hKcu2j
         0EF712X7u+gBp07RuKZJPiuKfX1TKVw9ZeWreS0SURRwW5cl5GyPAmtkyXgx9WrYdCCq
         ZMS3x24r2jg8OF/7a62OoiDCL2JpoA6oN6nzSQ6EWFCezQoNLlrNjBJJIqeI3UdRgxMn
         st+K54D7UAPPIXL1XDHV3IKDBwCOOZ0aBZasSGtD1tJIGyUqjKoiX+iU9l1CoNinXrii
         BllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x11HqO+/PtZ+6U0J6esjEI4aLwAmQPl4b6jkYZuk7fs=;
        b=Il84SJGUENtb0SEsx26qRA0zTrmCavp5nI7XrrKf+NoioSF1hT5ON/COdchKd5kL8Z
         dxDq6FPjwXVhM2c4+L4DIpvtkBZrdmeqSTBjN5MeJYkKHnOvB0RKFa0tYa+trGBvv5W9
         DE5SlGB1OjhKl+i/j8vnZsHyEn371MEMF0xmuvV7OsBIMRm3adwNcbjgCTuj7jt1NvCz
         Y1QwbDfyzruPVsRkyvWmYEijWPVz2zswZbSLRuGobdbdwIzAEdkS3buqBO4/ImF4fy2F
         SiNgHfqQEXJqCyQEeAohQb9sMM19LQNsDFnDPQjoRFvvnRaL+9iFVFaG39sKNdnO+aya
         kZxw==
X-Gm-Message-State: AOAM530JNVQR2+zyTuh4uCPRtsyuJl4jVVMncq9MQ1EGmPcPgT7i/Zx7
        fhcicZf1di3eDLsT2jEAigk=
X-Google-Smtp-Source: ABdhPJza6rBWrLL23igGyfG2ReHHTGXFm1fmhrwVo+qo8zbheAoKpS1X6I4CCGxvnTSf9rwIsBy+Sw==
X-Received: by 2002:a02:8804:: with SMTP id r4mr4810477jai.55.1633478727974;
        Tue, 05 Oct 2021 17:05:27 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:94fc:9a4b:2e18:e915])
        by smtp.gmail.com with ESMTPSA id y2sm11338646ioj.12.2021.10.05.17.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 17:05:27 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] arm64: dts: imx8mn: add DISP blk-ctrl
Date:   Tue,  5 Oct 2021 19:05:03 -0500
Message-Id: <20211006000505.627334-6-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211006000505.627334-1-aford173@gmail.com>
References: <20211006000505.627334-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT node for the DISP blk-ctrl. With this in place the
display/mipi power domains should be functional.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 28 +++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index ea994dd9fb03..57f67257d2fd 100644
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
2.25.1

