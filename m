Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F96427BFC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 18:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhJIQ3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 12:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhJIQ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 12:29:30 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284B3C061570;
        Sat,  9 Oct 2021 09:27:33 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id s17so9256834ioa.13;
        Sat, 09 Oct 2021 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XuJaZNgF74UYMRE6pkGwMNLIVjxtetPUKBOwSGBs5mY=;
        b=TYUnmffEvq2yzC0xfMovOzvLnCbkitxSYNEBDAgTzkAjGjZjhIwE4N23aO3wKjkCQr
         9JG82E3cZwJ+eqWpmh+Fha1s2yGBJ5itvsNVouYtMvpDfVn3hd8oFUClswEUqEpo2SO6
         H2UPTkxCFW9ntZBUizxPCiweL8orSHp35MG5pZ8F/IsfzDBQuYX7uEpPWaa2/g8dICKw
         rEfXoGeiOALaszEZ/TjvAZrges54rzKLuJyrZ90uNEedpGUNEzZh6Lf5QOGhIpGq5DUI
         SwsQYdhhuLWUtUxm3mTZUb0Rtaefekgzl7WICVgRgS0wRNmYjeOfsjtOhnEtGLEEEe/Z
         gyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XuJaZNgF74UYMRE6pkGwMNLIVjxtetPUKBOwSGBs5mY=;
        b=FQE01kPlXq00q1HRdXpeimHdS52zFPy3reCKeC+356DoThAVukDDKr2DaIu/XCajQd
         454Sy8smUeOkmKL2QnbL18/F3NFcdNN3vqVDZ1vA+zsqQ7lukzpNPXmUTAoBK5AP6sF4
         /ZL1qQq0PtsE0iIKBcFg9yGQJcmbWyECSEm+9gWfN3sd32v3TNLqcyRLEdF1+peWf1pT
         m5WtuT4iTp/lH0SMuIH8q1rRcCmXTplIA3y7hgnLYDv4AEf9S8XGhCHyKekL0f1SxcQs
         4uuMC5e/QVyXlpHpdOYbiMaPxvzAoCDr1tilTPXjGvaLCUZdA6wElSy+u/cFGH4oUkbt
         K47w==
X-Gm-Message-State: AOAM533NasrcjoKltdmnIcTHbL7beQ0CGGIjfN4lGy3B+rVDIwEBmQtc
        5LY4BMv0Ww/MXfjFbCwn5wA=
X-Google-Smtp-Source: ABdhPJym2rfAWwSc3C8qgOdqjtjBVIXW1crZZyJFsgUxC24BTMjWA7izbr2RVcx6rEj/HR2cZ5vwuA==
X-Received: by 2002:a02:6913:: with SMTP id e19mr5646360jac.53.1633796852475;
        Sat, 09 Oct 2021 09:27:32 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:cb0f:c46c:9a27:ace])
        by smtp.gmail.com with ESMTPSA id y5sm1253722ilg.58.2021.10.09.09.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 09:27:32 -0700 (PDT)
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
Subject: [PATCH V2 8/9] arm64: dts: imx8mn: add DISP blk-ctrl
Date:   Sat,  9 Oct 2021 11:26:58 -0500
Message-Id: <20211009162700.1452857-9-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009162700.1452857-1-aford173@gmail.com>
References: <20211009162700.1452857-1-aford173@gmail.com>
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
2.25.1

