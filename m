Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0543EEAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236573AbhHQKNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239243AbhHQKNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:13:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A59C061764;
        Tue, 17 Aug 2021 03:12:38 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id by4so30935004edb.0;
        Tue, 17 Aug 2021 03:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d2VQ1+1ilMFZsg6Zzub/scQE4lvZLEeXq1gSlLgcSKE=;
        b=nOg8owEeR84zqET1AanwCwo2tnJy9LFT4nol/ZNGj2oi5zMxpWMMsNcvatErleon7v
         8NDfKHT9PRl2uH3sFn7DnyNfp5Tq+qRLxfcvKYSrASJRXete2G8oszSmsUB4p8PjTRgw
         nI+li/WpRGKX4ZIuU+fpEaSGjhzFAG1rb7TDyVyqqqpVk2XvhpUKxF+1L7cna46Dkj+k
         0aJrQIg8l02WzQAQljx4G6wlhhskr3IMtz1IRgWAZBk+1+OsO4jvTyEmVjZ2+KMyF4wD
         9U47fHKOxgR9idE9XGASmAbEzLxqdv3oRsXRH129uTrCccz2xdvE6LiQkRb4MTLOauCf
         x0PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d2VQ1+1ilMFZsg6Zzub/scQE4lvZLEeXq1gSlLgcSKE=;
        b=iNi3iDkYo3wdL1EgOcYSkYmbvm1MJY3EUI+3CjFjnMApb8dQlUxNxoOhs1axiDn31F
         rqyhLqURY58eHmx0ImGzsaIs263fxc/LlYV1LXTl/ACjk8SdrGKXnTWEG+wZXwdrgUy/
         sZRR0NYbgY63m3epqFkEK0FGqxYr9eVI0Pa87hSL0moH5JYpyxiB9Uk3TdHOs3QMaVJE
         bhADxfcfemri83ng6RATCdg9Mg+BtK3vR5j741AJwOWwPW+2N9KtjdEg3TaMJIwO5s7O
         x9h2abEVgGGRlQrfGhnuiz3ocZvZzmPfs4Xvhbqi93iAKZnTms6DpOtsJIfb8H2ptrnP
         kaOw==
X-Gm-Message-State: AOAM533JxlhEXwp8cdLrAhCHk9tAs0Up3OPO8lfcJH6YjYLrb+KVVkzw
        4Y77KjInQZTzEA8e+U3RTv0=
X-Google-Smtp-Source: ABdhPJy47C3jj8L9PvfO8us2OumyDSsn8GWaDRijCH7fj2J4bPRQCv9moUt2p36O3wiwORsQa2/fgg==
X-Received: by 2002:a05:6402:36b:: with SMTP id s11mr3413272edw.235.1629195157643;
        Tue, 17 Aug 2021 03:12:37 -0700 (PDT)
Received: from localhost.localdomain ([185.213.155.232])
        by smtp.gmail.com with ESMTPSA id m6sm822920edq.22.2021.08.17.03.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 03:12:37 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: rockchip: add i2s1 on rk356x
Date:   Tue, 17 Aug 2021 12:11:18 +0200
Message-Id: <20210817101119.423853-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817101119.423853-1-frattaroli.nicolas@gmail.com>
References: <20210817101119.423853-1-frattaroli.nicolas@gmail.com>
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
index bef747fb1fe2..2cdb13f29bed 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -554,6 +554,32 @@ sdhci: mmc@fe310000 {
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
+		dmas = <&dmac1 2>, <&dmac1 3>;
+		dma-names = "tx", "rx";
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

