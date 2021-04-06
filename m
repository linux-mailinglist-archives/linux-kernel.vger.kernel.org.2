Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4ED35526B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 13:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245655AbhDFLgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 07:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243092AbhDFLgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 07:36:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9B9C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 04:36:37 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b9so5966118wrs.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fmDRbqtP+YDoUjuxUgyJwyFExQZfEPdy0d8S+LRWvjQ=;
        b=da/BlOh0qL3KhkDnkh1dcj+ftmfXRqcal7QU7xHXm4nFxd3BbvPE3elws20HHm4FZE
         LXOl1XXo79DzafbrvjESNds5njbnKMvuMKOJ0gN36pepbEU9vHt9QfEIwy0tTY0wU+a3
         Bepdw0FZYbZgguzsSDoBSzcZTYzsGnu/fkZmkyPqpoZTqctF3qB53jEq83Dk0/uhxaUP
         AKaakpRMQssB7EsKoH6zsjHaUJCdkiWk3TabwfNgN24EH8b7mTRL5Ttl6JmkBsP68Seq
         82xcLsEIGWny0CmJz2/iPsKIcOg3ct8bJnsEjGpla2PqmV2OCi5OBfUfB6V3MfVo4YYa
         ITYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fmDRbqtP+YDoUjuxUgyJwyFExQZfEPdy0d8S+LRWvjQ=;
        b=lCcv8H/2Y3uPj9cRjsMKdrjwSaIKy6ZaP1y4iaBYGckmnLlTDAc8sBnBfdVHYoDn6d
         2Kxb7WE95VPWrXkNJq1py0x1DXN9s0dFVGl63ISn7j04O9AUE8QPdayaCJ6B03qnuds2
         KS/PuRxyGtm6LSdX15BYpZOUed4wmLxiAXPJ6pS+h0agl6ZI7rFkOQ65P9uDqbNU4U4F
         gsRAMpjRPLS8Dg0OZAyBpJp1FsDrDe0v5+UjUi2ZOW/6NPox1ZK/f+N5AVBuWI5OUs6U
         h7B1F6/b8brbGlQrvVQbGfWHMRJTJfOWeN6IVjLOYHI0E9ULLciMUVNcm4WLVermH79f
         0sSw==
X-Gm-Message-State: AOAM530Q96oA3E8NDIgzJQPdhM6hRNgHqq/mT8V2fhOQ+FeLNpaSuHLl
        ju3e0pBanTqfhkjFrvcLz3L+yA==
X-Google-Smtp-Source: ABdhPJzwWNoZ/y/OCsc+wQ/p1TbyyhKewDu+8j6fMlc7jZTDjbF0PM2NYKLa0BynpolrrbughOcVtQ==
X-Received: by 2002:a5d:5741:: with SMTP id q1mr2615875wrw.69.1617708996296;
        Tue, 06 Apr 2021 04:36:36 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id k3sm11880735wrc.67.2021.04.06.04.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 04:36:35 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     mkorpershoek@baylibre.com, Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: mediatek: mt8167: add some DRM nodes
Date:   Tue,  6 Apr 2021 13:36:30 +0200
Message-Id: <20210406113631.2675029-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210406113631.2675029-1-fparent@baylibre.com>
References: <20210406113631.2675029-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add all the DRM nodes required to get DSI to work on MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
Note: This series is based on https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/log/?h=v5.12-next/dts64-2

V3:
	* Removed unicode character in commit summary
V2:
	* No changes

 arch/arm64/boot/dts/mediatek/mt8167.dtsi | 149 +++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8167.dtsi b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
index 9029051624a6..17942095944e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8167.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8167.dtsi
@@ -16,6 +16,19 @@
 / {
 	compatible = "mediatek,mt8167";
 
+	aliases {
+		aal0 = &aal;
+		ccorr0 = &ccorr;
+		color0 = &color;
+		dither0 = &dither;
+		dsi0 = &dsi;
+		ovl0 = &ovl0;
+		pwm0 = &disp_pwm;
+		rdma0 = &rdma0;
+		rdma1 = &rdma1;
+		wdma0 = &wdma;
+	};
+
 	soc {
 		topckgen: topckgen@10000000 {
 			compatible = "mediatek,mt8167-topckgen", "syscon";
@@ -114,6 +127,13 @@ vdecsys: syscon@16000000 {
 			#clock-cells = <1>;
 		};
 
+		mutex: mutex@14015000 {
+			compatible = "mediatek,mt8167-disp-mutex";
+			reg = <0 0x14015000 0 0x1000>;
+			interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+		};
+
 		pio: pinctrl@1000b000 {
 			compatible = "mediatek,mt8167-pinctrl";
 			reg = <0 0x1000b000 0 0x1000>;
@@ -126,6 +146,135 @@ pio: pinctrl@1000b000 {
 			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		rdma1: rdma1@1400a000 {
+			compatible = "mediatek,mt8167-disp-rdma",
+				     "mediatek,mt2701-disp-rdma";
+			reg = <0 0x1400a000 0 0x1000>;
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_DISP_RDMA1>;
+			iommus = <&iommu M4U_PORT_DISP_RDMA1>;
+			mediatek,larb = <&larb0>;
+		};
+
+		disp_pwm: disp_pwm@1100f000 {
+			compatible = "mediatek,mt8167-disp-pwm",
+				     "mediatek,mt8173-disp-pwn";
+			reg = <0 0x1100f000 0 0x1000>;
+			#pwm-cells = <2>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			clocks = <&topckgen CLK_TOP_PWM_SEL>,
+				 <&topckgen CLK_TOP_PWM_MM>,
+				  <&mmsys CLK_MM_DISP_PWM_26M>,
+				  <&mmsys CLK_MM_DISP_PWM_MM>;
+			clock-names = "pwm_sel",
+				      "pwm_mm",
+				      "main",
+				      "mm";
+			status = "disabled";
+		};
+
+		dsi: dsi@14012000 {
+			compatible = "mediatek,mt8167-dsi",
+				     "mediatek,mt2701-dsi";
+			reg = <0 0x14012000 0 0x1000>;
+			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_DSI_ENGINE>,
+				 <&mmsys CLK_MM_DSI_DIGITAL>,
+				 <&mipi_tx>;
+			clock-names = "engine", "digital", "hs";
+			phys = <&mipi_tx>;
+			phy-names = "dphy";
+			status = "disabled";
+		};
+
+		mipi_tx: mipi_dphy@14018000 {
+			compatible = "mediatek,mt8167-mipi-tx",
+				     "mediatek,mt2701-mipi-tx";
+			reg = <0 0x14018000 0 0x90>;
+			clocks = <&topckgen CLK_TOP_MIPI_26M_DBG>;
+			clock-output-names = "mipi_tx0_pll";
+			#clock-cells = <0>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		ovl0: ovl0@14007000 {
+			compatible = "mediatek,mt8167-disp-ovl",
+				     "mediatek,mt8173-disp-ovl";
+			reg = <0 0x14007000 0 0x1000>;
+			interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_DISP_OVL0>;
+			iommus = <&iommu M4U_PORT_DISP_OVL0>;
+			mediatek,larb = <&larb0>;
+		};
+
+		rdma0: rdma0@14009000 {
+			compatible = "mediatek,mt8167-disp-rdma",
+				     "mediatek,mt2701-disp-rdma";
+			reg = <0 0x14009000 0 0x1000>;
+			interrupts = <GIC_SPI 162 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_DISP_RDMA0>;
+			iommus = <&iommu M4U_PORT_DISP_RDMA0>;
+			mediatek,larb = <&larb0>;
+		};
+
+		color: color@1400c000 {
+			compatible = "mediatek,mt8167-disp-color",
+				     "mediatek,mt8173-disp-color";
+			reg = <0 0x1400c000 0 0x1000>;
+			interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_DISP_COLOR>;
+		};
+
+		ccorr: ccorr@1400d000 {
+			compatible = "mediatek,mt8167-disp-ccorr",
+				     "mediatek,mt8183-disp-ccorr";
+			reg = <0 0x1400d000 0 0x1000>;
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_DISP_CCORR>;
+		};
+
+		aal: aal@1400e000 {
+			compatible = "mediatek,mt8167-disp-aal";
+			reg = <0 0x1400e000 0 0x1000>;
+			interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_DISP_AAL>;
+		};
+
+		gamma: gamma@1400f000 {
+			compatible = "mediatek,mt8167-disp-gamma",
+				     "mediatek,mt8173-disp-gamma";
+			reg = <0 0x1400f000 0 0x1000>;
+			interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_DISP_GAMMA>;
+		};
+
+		dither: dither@14010000 {
+			compatible = "mediatek,mt8167-disp-dither";
+			reg = <0 0x14010000 0 0x1000>;
+			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_DISP_DITHER>;
+		};
+
+		wdma: wdma0@1400b000 {
+			compatible = "mediatek,mt8167-disp-wdma";
+			reg = <0 0x1400b000 0 0x1000>;
+			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_LOW>;
+			power-domains = <&spm MT8167_POWER_DOMAIN_MM>;
+			clocks = <&mmsys CLK_MM_DISP_WDMA>;
+			iommus = <&iommu M4U_PORT_DISP_WDMA0>;
+			mediatek,larb = <&larb0>;
+		};
+
 		mmsys: mmsys@14000000 {
 			compatible = "mediatek,mt8167-mmsys", "syscon";
 			reg = <0 0x14000000 0 0x1000>;
-- 
2.31.0

