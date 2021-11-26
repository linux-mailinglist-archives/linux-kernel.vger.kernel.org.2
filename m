Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0251D45EEDC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 14:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244037AbhKZNNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 08:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239863AbhKZNLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 08:11:30 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6740EC0613A1;
        Fri, 26 Nov 2021 04:27:43 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c4so18279377wrd.9;
        Fri, 26 Nov 2021 04:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qpRX64CMZm7Y2DuIQVIacG4FzI2CVJ1lZz7XcJCtr/M=;
        b=Xe0HTRFAKWYlwKHjVNF6MVgVq6pLaQR69L3+XDI3z+uemkV6pqmuCsvNH6D6kKNcz9
         tLg8dKqw580qpJtTHj7HnkWRsvfJ+1fkL41tAghkH+FcVOBlYli7+z/vaoZGnIy12/jJ
         M9Lh6fxr/mSk4Y4q9uWLZfxp3+fSOvX/+7n0f9T+XRN3PoWNlKLaBn7+R0QeiDw61Hbh
         qJSKNN9QiW+Q0t9fPgx3BJWoKo0nLEtP3NnPp2W5p/YeH0jX9gklOWkfUeVIvnUaYrtA
         geDUwudxhz/vY+VG4gT39hsc68HZz76sQg4haT+5icN3uZPBWakajFSv4MVyE/OsaN4Z
         YwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qpRX64CMZm7Y2DuIQVIacG4FzI2CVJ1lZz7XcJCtr/M=;
        b=3c7AWNWfdqtM9aLoRLOh2NBmJq7q7WT8/EBdAnWRkqntFvefesoEX7wy0qWw4q3qb0
         ww52NZP+M1wbdELaT9GLShZZLH9VWg5oSzL4hDiPa//bZa+pYXp3OakmznLzTFiQSOH1
         c/R1NaCrqiWvLEwcYSoRAJafblJ0Qz+Vay9kq8eLeQBDuV6cutChD+C+VBeQ5nb9+Htd
         M3cwTNFTirZB54pBdcZnJ4fkg86mBmhKByo5l72c9nOVd6P/Z94KBTAMJaGCs59KR4Oy
         Yx2logdhs9kDe0fAH/ZhKTX2W8EpN2U/h6m2ovIH9TV0iTzAfTO4tCic0QKarn3mgitN
         Fhjw==
X-Gm-Message-State: AOAM531LGykr/zDo+TDuYbdo8/BAATw5RRjhAwDRL5al0uJn4sFIq8h1
        sSroQubAfXpgT+cyQOwVeLQ=
X-Google-Smtp-Source: ABdhPJzLW9aNvXs7gU42/3ZNC9XsorhlsdH6U6QbAS3Jp0sD6qxKrzrq/5jk9UIx1Fai2zKDeURPlQ==
X-Received: by 2002:adf:e501:: with SMTP id j1mr13286411wrm.516.1637929662097;
        Fri, 26 Nov 2021 04:27:42 -0800 (PST)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id l7sm6821130wry.86.2021.11.26.04.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 04:27:41 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: rockchip: rk356x: Add HDMI audio nodes
Date:   Fri, 26 Nov 2021 13:27:17 +0100
Message-Id: <20211126122718.631506-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126122718.631506-1-frattaroli.nicolas@gmail.com>
References: <20211126122718.631506-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the i2s0 node and an hdmi-sound sound device to the
rk356x device tree. On the rk356[68], the i2s0 controller is
connected to HDMI audio.

Tested-by: Michael Riesch <michael.riesch@wolfvision.net>
Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---

Changes in v2:
 - reordered nodes to conform
 - reordered properties to conform
 - add Michael Riesch's Tested-by

 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 3c09cf6d4c37..aafb622dfa83 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -174,6 +174,22 @@ scmi_clk: protocol@14 {
 		};
 	};
 
+	hdmi_sound: hdmi-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "HDMI";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,mclk-fs = <256>;
+		status = "disabled";
+
+		simple-audio-card,codec {
+			sound-dai = <&hdmi>;
+		};
+
+		simple-audio-card,cpu {
+			sound-dai = <&i2s0_8ch>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a55-pmu";
 		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>,
@@ -789,6 +805,23 @@ spdif: spdif@fe460000 {
 		status = "disabled";
 	};
 
+	i2s0_8ch: i2s@fe400000 {
+		compatible = "rockchip,rk3568-i2s-tdm";
+		reg = <0x0 0xfe400000 0x0 0x1000>;
+		interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
+		assigned-clocks = <&cru CLK_I2S0_8CH_TX_SRC>, <&cru CLK_I2S0_8CH_RX_SRC>;
+		assigned-clock-rates = <1188000000>, <1188000000>;
+		clocks = <&cru MCLK_I2S0_8CH_TX>, <&cru MCLK_I2S0_8CH_RX>, <&cru HCLK_I2S0_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		dmas = <&dmac1 0>;
+		dma-names = "tx";
+		resets = <&cru SRST_M_I2S0_8CH_TX>, <&cru SRST_M_I2S0_8CH_RX>;
+		reset-names = "tx-m", "rx-m";
+		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
+		status = "disabled";
+	};
+
 	i2s1_8ch: i2s@fe410000 {
 		compatible = "rockchip,rk3568-i2s-tdm";
 		reg = <0x0 0xfe410000 0x0 0x1000>;
-- 
2.34.0

