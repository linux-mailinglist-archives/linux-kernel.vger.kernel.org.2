Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C10460677
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357605AbhK1N0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346278AbhK1NYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:24:32 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FEFC061746;
        Sun, 28 Nov 2021 05:19:31 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id k21so17572798ioh.4;
        Sun, 28 Nov 2021 05:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HAFh9FPQuPmoV1vF4y4Sk6Yto42klwa4ZHAtnVZjT34=;
        b=MCR+JBVhIa7EiVnRCKKOQcC1FuWHvVSZX0AfSnzcTfaBEuD8XgsHQ1o0CP8S4AT059
         PgP4Xl30kVPAwu3obhHTSzLSNyy5eWUSLDKjCKK1UaVb7repIoL0h/zw0Y0n4c8CQ4fS
         5i/J29PLgnRYBW9sCOVmLCUXgDNOwDuBaTiTZ08ZNsDrcIm8bQEhsj51UE5v3RX6NZ7a
         UHQNDQepx8OKaPTSR6OEnew1xfFXC7cyIdnHJxSJGSwKsQSZpdaUc6rs0MIU2uaA+1fb
         w6gGgjZS5DQsLXLBc0fECVZ4VJeUQxMP5vCpufPVplLdfoY2CJ2PI3lH2xGzOlNIX7jB
         a2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HAFh9FPQuPmoV1vF4y4Sk6Yto42klwa4ZHAtnVZjT34=;
        b=l2Q1FaX1G5wlIWsGE2up5VWduyvOX4hdWzqeYPgQgaq/dToeslSyeMzug3i2uOrguE
         BUKLmaMt9aR96W005D3Xo8JdqLY9S5n4s7b3Nzjb2Dz7zVj1v8zkpAZaKY4lsWck5g1w
         hfidRDBHK76jcH9bHXwxwGpBsUKZhrcQL24g/0n5MZKuAiYGuMELZy1hpmyzFE2IUKGn
         3mbcB0GWzkddI3uWn/E8LI7MecwvvvJtyPSs/LFznAezwDvWWQuC9hFTQm2jMlG8D7pD
         rOQCiTkqrEyJ5IY9yWmJfd+cFWCFCOemcJ5J0KmWlm5ftEuvGU2CSBs5UYMVrk82I9YK
         l4ZA==
X-Gm-Message-State: AOAM532z1iNMQMLPeCmcHvcK5Ab4UuhegtLje9B5aSzt4j4TvsHzQM4h
        MLN7clASs0Jff9heUhJC2S0=
X-Google-Smtp-Source: ABdhPJyklrABPjnFUQbmrcN/qK1ypXXfulVA8aiccQUrD4vEoRPdvVjc8NlpJJZW7iWW0eBESQJDfw==
X-Received: by 2002:a05:6602:2e8d:: with SMTP id m13mr52839949iow.68.1638105570647;
        Sun, 28 Nov 2021 05:19:30 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id q12sm6990413ile.77.2021.11.28.05.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:19:30 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 8/9] arm64: dts: imx8mn: add DISP blk-ctrl
Date:   Sun, 28 Nov 2021 07:18:51 -0600
Message-Id: <20211128131853.15125-9-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128131853.15125-1-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
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
index 902d5725dc55..d8726d0ce326 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1039,6 +1039,34 @@ aips4: bus@32c00000 {
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

