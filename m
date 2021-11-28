Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120C846067A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357913AbhK1N0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357637AbhK1NYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:24:36 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D981C06175E;
        Sun, 28 Nov 2021 05:19:33 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id m5so14042439ilh.11;
        Sun, 28 Nov 2021 05:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=521EvKI6EbdtF1DZoqUQypBcun81DeM7zYPyPbmkezw=;
        b=nxDTX1IjHaVGag01lCyyCR24q+bUyiEEly+4te+h9GXJ7/HJ7CtJ/4R+BoGmsR9UT0
         024fjHfPCX2wU0l4cCUVVTCWnpWeSnoUtFQ7RzqIcXSGJXXf6c5wKLKzRPnR/oanUvM7
         zLekmgDc6lfrkpXQ3eWMAnzmHKp2M0/ODJe76g5oeoZZWOyxN9I3OIZZed2dtlNwgKk3
         JMkC7FSm0a0eKakYaZY/Snmg8Lk3ausU8gfJp775DdnwOitLtiAYxnYpSOjfghCDdbIs
         Q0efCjap63ctsbVY/L0/rTjVH4Yu6K2GhneTt96nhLXx4G0gZ+RyJiArtNdBpzjUSoRv
         +blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=521EvKI6EbdtF1DZoqUQypBcun81DeM7zYPyPbmkezw=;
        b=OjDLz6ACBD0wgw0zpXJr2G49oCMDHNACajYi69l7I3MBsrDYBAgPzSbfqVGe+Z9qxe
         VVYdOGpzyIXyMz6969DmUBBJckCXTAXLBKzKFCkmj+OsWv5Zb9yoVxEsTWxtyFXLsXYL
         ctuJDqJzGx6h2Fj2CU34oPv3D2nJg1W99Tplc90Zd5Urdg4uj9zHv3P4yZzFVEXNZvwo
         VIZXKiZ5QULksh5sQszqdNu98T/kOPgFjuGEDjd3LOiPPR/vJl/qf1hH3r7HAjyRpJaS
         YNrjApmDHy7mUsyItvQGVv4TZnssL+0qNlmSq47HdlU2ge+TLuZJzRiYqHANl2fshESo
         hQeg==
X-Gm-Message-State: AOAM533wTvmSrPMTMr15WSbGuhFy/pzJXZdu4LmIL/ASEYnehPxDYEx1
        w+AeXVQ2klBPi9mNQ+zQk5U=
X-Google-Smtp-Source: ABdhPJxqou9qnWhwDUQC35la6Ea1oG44QBG1nFwiJfpH2nb93ileCf5azIlVh1Oxkm4W5I9zUG1pKA==
X-Received: by 2002:a05:6e02:ca9:: with SMTP id 9mr50659159ilg.60.1638105572777;
        Sun, 28 Nov 2021 05:19:32 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id q12sm6990413ile.77.2021.11.28.05.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:19:32 -0800 (PST)
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
Subject: [PATCH V4 9/9] arm64: dts: imx8mn: Enable GPU
Date:   Sun, 28 Nov 2021 07:18:52 -0600
Message-Id: <20211128131853.15125-10-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128131853.15125-1-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M-Nano features a GC7000. The Etnaviv driver detects it as:

    etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mn.dtsi | 25 +++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index d8726d0ce326..5b8f8488e362 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1117,6 +1117,31 @@ gpmi: nand-controller@33002000 {
 			status = "disabled";
 		};

+		gpu: gpu@38000000 {
+			compatible = "vivante,gc";
+			reg = <0x38000000 0x8000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MN_CLK_GPU_AHB>,
+				<&clk IMX8MN_CLK_GPU_BUS_ROOT>,
+				<&clk IMX8MN_CLK_GPU_CORE_ROOT>,
+				<&clk IMX8MN_CLK_GPU_SHADER>;
+			clock-names = "reg", "bus", "core", "shader";
+			assigned-clocks = <&clk IMX8MN_CLK_GPU_CORE>,
+					  <&clk IMX8MN_CLK_GPU_SHADER>,
+					  <&clk IMX8MN_CLK_GPU_AXI>,
+					  <&clk IMX8MN_CLK_GPU_AHB>,
+					  <&clk IMX8MN_GPU_PLL>,
+					  <&clk IMX8MN_CLK_GPU_CORE>,
+					  <&clk IMX8MN_CLK_GPU_SHADER>;
+			assigned-clock-parents = <&clk IMX8MN_GPU_PLL_OUT>,
+						  <&clk IMX8MN_GPU_PLL_OUT>,
+						  <&clk IMX8MN_SYS_PLL1_800M>,
+						  <&clk IMX8MN_SYS_PLL1_800M>;
+			assigned-clock-rates = <0>, <0>, <800000000>, <400000000>, <1200000000>,
+				<400000000>, <400000000>;
+			power-domains = <&pgc_gpumix>;
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible = "arm,gic-v3";
 			reg = <0x38800000 0x10000>,
--
2.32.0

