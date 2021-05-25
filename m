Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DD238F75B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 03:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhEYBJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 21:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbhEYBJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 21:09:19 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA54C06138E;
        Mon, 24 May 2021 18:07:50 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l15so21500731iln.8;
        Mon, 24 May 2021 18:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVif8BOmdy7xXqArUgQhM4hL5Kyfy23SPGVr8JCHGd4=;
        b=ZXlpfF1SmYcGXtVsHK4PQL1yVyTJotz4FBHSHXc9WT8Msi3aoeP5WG6X6WQE8lmTt4
         fPUQJbBApnXxcrPJnZG3GSVXsKukSdFe0WwhDWegOI/IOqkfBDaR8qFRrLfmw9JkDoh6
         +ZRRebPW9hmNQvAxQvBo9Nz+Fh874OwU7wwOpiNRJ7EnDT4qvKuwIb0Zwe1rkX5fFAFn
         JqspsnlWDvksgWqUhxhbZIXuN/ho1dmidAEiRn3aBOSU4Mg6pKbPOGSZPssHau+huSzu
         wP3vUDgEqUQJ95h/Dp6LBkGQj0PrstEDj2DJUXZRZfI1YsiL94ZsKcyxU1dbRDZaJc73
         7ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVif8BOmdy7xXqArUgQhM4hL5Kyfy23SPGVr8JCHGd4=;
        b=Bq2Djp6G4gH3ouuCEq/kM4W1evPtFpiB9WOoKBPSx+4P/sg+zBZErNTEePUsPMBJNY
         7YnoFBWezSVXup9O0FBA0qmavPWPM78H5yX8IHMiCms2I8/cy+6MGVHeqawp9v5jZrND
         L2IMa+gzli5abJVbYB+A51F3YAfScfzxnKqRsfzMNjcNJkgo/qvcW1+EGgpFT6CMssqf
         uN/iw5Y+guitJwNzir/8f1RelTEOsVaSd3UD8NiG7G1/3iXrcZlvFTN3k/vqnONswxkm
         3HZCnqwoYMoGGzlxA17g2FeHWjCDRJbuGjDEq6/hxOfn3dCKOxwthEYqgbS6zYDXc5J+
         t4WQ==
X-Gm-Message-State: AOAM532U+cvFc0Fxn0cYuFD4KOT17N/heZeRsh8lMFh3L6f16jTBgQTo
        dgMjcVfV/u9WS/5OGzpsb6s=
X-Google-Smtp-Source: ABdhPJyLtpDPaYyrDPzdTTrR5wI1NKr9M9FWvlRAlfBWIQ6OG5JC5JwMd/AjMGkIx1HbLmbvBClWXA==
X-Received: by 2002:a92:c74b:: with SMTP id y11mr20601316ilp.302.1621904869422;
        Mon, 24 May 2021 18:07:49 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:599b:b8c7:b3a9:9f1d])
        by smtp.gmail.com with ESMTPSA id w20sm12318413ilj.16.2021.05.24.18.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 18:07:49 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] arm64: dts: imx8mn: Add GPU node
Date:   Mon, 24 May 2021 20:07:32 -0500
Message-Id: <20210525010732.115562-6-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525010732.115562-1-aford173@gmail.com>
References: <20210525010732.115562-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the documentation from NXP, the i.MX8M Nano has a
Vivante GC7000 Ultra Lite as its GPU core.

With this patch, the Etnaviv driver presents the GPU as:
   etnaviv-gpu 38000000.gpu: model: GC7000, revision: 6203

The stock operating voltage for the i.MX8M Nano is .85V which means
the GPU needs to run at 400MHz.  For boards where the operating
voltage is higher, this can be increased.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 8b1fb83cb893..8fc5d46d076b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1049,6 +1049,31 @@ gpmi: nand-controller@33002000 {
 			status = "disabled";
 		};
 
+		gpu: gpu@38000000 {
+			compatible = "vivante,gc";
+			reg = <0x38000000 0x8000>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&clk IMX8MN_CLK_GPU_AHB>,
+				<&clk IMX8MN_CLK_GPU_BUS_ROOT>,
+				<&clk IMX8MN_CLK_GPU_CORE_ROOT>,
+				<&clk IMX8MN_CLK_GPU_SHADER_DIV>;
+			clock-names = "reg", "bus", "core", "shader";
+			assigned-clocks = <&clk IMX8MN_CLK_GPU_CORE_SRC>,
+					  <&clk IMX8MN_CLK_GPU_SHADER_SRC>,
+					  <&clk IMX8MN_CLK_GPU_AXI>,
+					  <&clk IMX8MN_CLK_GPU_AHB>,
+					  <&clk IMX8MN_GPU_PLL>,
+					  <&clk IMX8MN_CLK_GPU_CORE_DIV>,
+					  <&clk IMX8MN_CLK_GPU_SHADER_DIV>;
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
2.25.1

