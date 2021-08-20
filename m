Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61533F33C8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 20:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbhHTS3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 14:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237743AbhHTS32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 14:29:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAD0C061575;
        Fri, 20 Aug 2021 11:28:50 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id b15so21886602ejg.10;
        Fri, 20 Aug 2021 11:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cENZLLHwvvAfM8Bz4wGMWapvwPbQelm5zUSRTGsu2cU=;
        b=YgqbJh+/0L5gXYDdr+o23/i/axG68ZmUx2va6Gy2WACDnZuoLfS06sWobv5qmAW0+w
         gdNZcsJP4LTQcH/jlmzkOLrAQcOdBUFc5bfZfOgLKg7RTCWosWyMoktYcy7ldD/d22nW
         hmZc+cMQEILYYtKDZN7miPZrEnQux3BUCBWZE9CVhKIvCTg/CfAgP2Hl8UkJhiWOsGML
         l0rwFF41lh2UNkpQ88tntyR9agKqQshOWKHe1e9DxszUf1oIX7iwWcrzT3nwt9493zUD
         fUqpZkhHIlHUXGVOMrFpITF/gCohkf/MtKUbP44+9G8/+b/lsS/4gr//Ovr0KifatsWV
         sA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cENZLLHwvvAfM8Bz4wGMWapvwPbQelm5zUSRTGsu2cU=;
        b=S6IikTjzyKpOrTQIXLMxOEVvvJilDjOIH09M7BrHY0ISqE1GdtHJZs4guZJrR92PnG
         Ob/Gq7525i3BMWYx3gHjRfLZ9/M4FIUPp5L8Bd4ia7FM+0DAbMp0gFFJ8ldrzLWhNVTM
         jjRYOhby5MZNJb6xd3tL4bImtPHXHlWx9Z1cSUgVcBujNd90Mdw8vhIKEg/AcjA+pC6+
         okdOM1B98T6jyenQgD5sWEjbOyGpN+oyRro7xWPbGtYcRJGnkDK2X6acSIrZ0vXN+7If
         JB1Og+7z+v2YX/1jcaPWcH31OVhDNI4r3bk6kKnF3qUouVPHDNP2DyX1c4Oxt4o/Xean
         Bq9Q==
X-Gm-Message-State: AOAM533en86zdsVq6dwqqI8r/qV9WNvTf8V4XWzZ1jsc1Hu043I0qaA0
        /zSff7eD2d6DDcd+EIyNk9c=
X-Google-Smtp-Source: ABdhPJzzDAmM7MkDVx9k6BD8jNsrHQmaI3IcXGRpV0WTAguxnyM2hdb4BYvVc3cMI6DcD4ojJXY7Hw==
X-Received: by 2002:a17:906:3854:: with SMTP id w20mr22731050ejc.537.1629484128360;
        Fri, 20 Aug 2021 11:28:48 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id n10sm3255724ejk.86.2021.08.20.11.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 11:28:47 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: rockchip: add i2s1 on rk356x
Date:   Fri, 20 Aug 2021 20:27:30 +0200
Message-Id: <20210820182731.29370-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210820182731.29370-1-frattaroli.nicolas@gmail.com>
References: <20210820182731.29370-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the necessary device tree node on rk3566 and rk3568
to enable the I2S1 TDM audio controller.

I2S0 has not been added, as it is connected to HDMI and there is
no way to test that it's working without a functioning video
clock (read: VOP2 driver).

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 26 ++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 13b185e1dc5f..fce760996a64 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -559,6 +559,32 @@ sdhci: mmc@fe310000 {
 		status = "disabled";
 	};
 
+	i2s1_8ch: i2s@fe410000 {
+		compatible = "rockchip,rk3568-i2s-tdm";
+		reg = <0x0 0xfe410000 0x0 0x1000>;
+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+		assigned-clocks = <&cru CLK_I2S1_8CH_TX_SRC>, <&cru CLK_I2S1_8CH_RX_SRC>;
+		assigned-clock-rates = <1188000000>, <1188000000>;
+		clocks = <&cru MCLK_I2S1_8CH_TX>, <&cru MCLK_I2S1_8CH_RX>,
+		<&cru HCLK_I2S1_8CH>;
+		clock-names = "mclk_tx", "mclk_rx", "hclk";
+		dmas = <&dmac1 3>, <&dmac1 2>;
+		dma-names = "rx", "tx";
+		resets = <&cru SRST_M_I2S1_8CH_TX>, <&cru SRST_M_I2S1_8CH_RX>;
+		reset-names = "tx-m", "rx-m";
+		rockchip,cru = <&cru>;
+		rockchip,grf = <&grf>;
+		#sound-dai-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&i2s1m0_sclktx &i2s1m0_sclkrx
+			     &i2s1m0_lrcktx &i2s1m0_lrckrx
+			     &i2s1m0_sdi0   &i2s1m0_sdi1
+			     &i2s1m0_sdi2   &i2s1m0_sdi3
+			     &i2s1m0_sdo0   &i2s1m0_sdo1
+			     &i2s1m0_sdo2   &i2s1m0_sdo3>;
+		status = "disabled";
+	};
+
 	dmac0: dmac@fe530000 {
 		compatible = "arm,pl330", "arm,primecell";
 		reg = <0x0 0xfe530000 0x0 0x4000>;
-- 
2.32.0

