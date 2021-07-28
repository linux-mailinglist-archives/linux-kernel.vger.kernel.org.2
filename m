Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9223D94E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhG1SBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhG1SBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:01:03 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2042C0613C1;
        Wed, 28 Jul 2021 11:01:00 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id db14so1985848qvb.10;
        Wed, 28 Jul 2021 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EK6nzEkguohvBwXyakdiH/QJLGvW91jjn3gEUQ1x4MM=;
        b=Mu8W82VYfuKO/sPs6CaFtxNPJxGUIXY4jRnrfbwEZdJ9HL6WuGewBegPXmAplt+7tZ
         he4KGNfrl+69Z0BlosYNmNkRZAk63sbgZi6ZWr8uFaU+ibqPW+5FfDNXf6fBdt1eWSNx
         yNhd2kQVGJK4Bv4NkAYon2c8kFK7o8fcVMBcx5v2MLG1RgghDp0a2gUKajhCcp8uiSuw
         fxzn99ZIQpnKOXrK9eKLNLN85Cz3JMY1zzr+Jw2OsP/TsI7E6IrMN0uOQIEKl37QjMRR
         M8HX94Xb5HV0bBSeVP1FBJNI0xyN+f3+Rcej901RnmTVrG8G479cnhPI9wEhWT59nvg/
         XX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EK6nzEkguohvBwXyakdiH/QJLGvW91jjn3gEUQ1x4MM=;
        b=iN+SmMSSK7QSjnNC0i7xfpl3hG9KIU/DO6Ju1C9r3qyyFp65wAfcWKaE+LJ0I54HBH
         W45FulLfaZch5aV1vmR7KL6OaLDu03tS4peuCwPdKDMkgMBCB13jaRAg1nGBktxgHGRJ
         v9oPX5MIguHjR6b/GfwgHAKLydvmHb1t+2NNR17n6yRFISscjeeTMNsnmSApNZ4c32rD
         iLhTQl2LxW3zgIh5iOBuJ30ewgDLvYGbecpJ6t0zQX+AE66twrbLuYtKo3PJqJdCShIP
         hk8QELRDJhAwaRinMW3eCPXDHHlmGODhagrP7aq41qL5WRO4zShyn5Be5ef9WRWSBJgr
         4SlA==
X-Gm-Message-State: AOAM5322fmXUxBOhqLCNtzfQPGiE9qd1hkrrve8pW4gWvyQYa96hl8ut
        qs2grD6MqA+OnRcPZ4Gs1H8=
X-Google-Smtp-Source: ABdhPJwCXPPiJQZuLfP1ol4AjxtHB4IjrlQ1qXsD7VJt/scQ7ewVpgFAFdDzeAs4Fdhh/pOjWLLAjg==
X-Received: by 2002:a05:6214:1cb:: with SMTP id c11mr1225044qvt.47.1627495260103;
        Wed, 28 Jul 2021 11:01:00 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id r5sm223341qtm.75.2021.07.28.11.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:00:59 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] arm64: dts: rockchip: add rk356x gmac1 node
Date:   Wed, 28 Jul 2021 14:00:30 -0400
Message-Id: <20210728180034.717953-5-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728180034.717953-1-pgwipeout@gmail.com>
References: <20210728180034.717953-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gmac1 controller to the rk356x device tree.
This is the controller common to both the rk3568 and rk3566.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 47 ++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index c2aa7aeec58d..fbd9f1c366ff 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -344,6 +344,53 @@ sdmmc2: mmc@fe000000 {
 		status = "disabled";
 	};
 
+	gmac1: ethernet@fe010000 {
+		compatible = "rockchip,rk3568-gmac", "snps,dwmac-4.20a";
+		reg = <0x0 0xfe010000 0x0 0x10000>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "macirq", "eth_wake_irq";
+		clocks = <&cru SCLK_GMAC1>, <&cru SCLK_GMAC1_RX_TX>,
+			 <&cru SCLK_GMAC1_RX_TX>, <&cru CLK_MAC1_REFOUT>,
+			 <&cru ACLK_GMAC1>, <&cru PCLK_GMAC1>,
+			 <&cru SCLK_GMAC1_RX_TX>, <&cru CLK_GMAC1_PTP_REF>;
+		clock-names = "stmmaceth", "mac_clk_rx",
+			      "mac_clk_tx", "clk_mac_refout",
+			      "aclk_mac", "pclk_mac",
+			      "clk_mac_speed", "ptp_ref";
+		resets = <&cru SRST_A_GMAC1>;
+		reset-names = "stmmaceth";
+		rockchip,grf = <&grf>;
+		snps,mixed-burst;
+		snps,tso;
+		snps,axi-config = <&gmac1_stmmac_axi_setup>;
+		snps,mtl-rx-config = <&gmac1_mtl_rx_setup>;
+		snps,mtl-tx-config = <&gmac1_mtl_tx_setup>;
+		status = "disabled";
+
+		mdio1: mdio {
+			compatible = "snps,dwmac-mdio";
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+		};
+
+		gmac1_stmmac_axi_setup: stmmac-axi-config {
+			snps,wr_osr_lmt = <4>;
+			snps,rd_osr_lmt = <8>;
+			snps,blen = <0 0 0 0 16 8 4>;
+		};
+
+		gmac1_mtl_rx_setup: rx-queues-config {
+			snps,rx-queues-to-use = <1>;
+			queue0 {};
+		};
+
+		gmac1_mtl_tx_setup: tx-queues-config {
+			snps,tx-queues-to-use = <1>;
+			queue0 {};
+		};
+	};
+
 	qos_gpu: qos@fe128000 {
 		compatible = "rockchip,rk3568-qos", "syscon";
 		reg = <0x0 0xfe128000 0x0 0x20>;
-- 
2.25.1

