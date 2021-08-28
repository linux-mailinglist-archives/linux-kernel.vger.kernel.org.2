Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D56E3FA629
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 16:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhH1ODb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 10:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbhH1ODa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 10:03:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31694C0613D9;
        Sat, 28 Aug 2021 07:02:39 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id u3so20223388ejz.1;
        Sat, 28 Aug 2021 07:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyrOm7xpawJP+/ommIWD0ISWok2qoozg6cD1tMaZFAQ=;
        b=NDrqi0pnyBtaxic7U2vZv57APr6RKXS5EgGD7rDCG/23xL4GyGge2Ex/XFAb5TExTK
         R33oWBmooBhy1FQS9DAJTIYbi6Nki0gzBpDsgYPTdPRg06ZALAeXfplTWHfWmAdha77U
         gF4SQkk4kQ5wYyzhCGurEnzNVqHdUy/FZU0+qQIbYz47ExU1evoRIrVpgiIqN/VNO7LN
         gAhAuP1L0LH3wnfbq5wcSQv2D3XsyEiCAlNJmsSBj7JjT7OJzYPO00ymZN3F20HMaaZB
         7j7zjaD0uy2S6odf3FB9gAMYiHYbd9KyXgHsS+VkWmKFQUVwaHy+pHpm7kpi+wPfKCmU
         UNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyrOm7xpawJP+/ommIWD0ISWok2qoozg6cD1tMaZFAQ=;
        b=T8KX7AmgxyhQqjjjNDO/LHuJb0SIccTzkhUPW5Ud2x63aVMC2JP2XNw4a8Ngo0aQwy
         Cze1Z8A0fojhWhtxu7wU0dGj8BXgZUribkR29yQ41I4fxexTPRmMXC8vfBvzCyE3vdm0
         pdYka7NUisTF3cI4uBsfAuVIlgfXPgmqqDel/2wsgTsfeyn4QtwRTfmYXk9nt6q5ikt6
         fY9Fqw3iHuD5uFRx+m+ROUSaPBQIvuducYo/J+2JRykwenJZ3FATdjAeHBoYUVV6FfbW
         MHKY5I14h1LALCctzN24o69A0cIXpN+fjMWaZfvuYNTNz0BjafkPW+7c4KeuVctN1em4
         0BsQ==
X-Gm-Message-State: AOAM5314IzMulUXr4axmwoXqtDDB/Fy53PrwdxXLcw8/mxrGjD2tUKdb
        sx3SIU4FOm7pYIkVpxvZFk4=
X-Google-Smtp-Source: ABdhPJwqo8tWbX+5ybYyu3tB5S9rK0+kkjK/8nmzpCxt46RE0NK5Y/58dPTq9aFReCRqNM3y2mqEDg==
X-Received: by 2002:a17:906:fc7:: with SMTP id c7mr14814325ejk.333.1630159357831;
        Sat, 28 Aug 2021 07:02:37 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id cn16sm4953982edb.87.2021.08.28.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 07:02:37 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: rockchip: add i2s1 on rk356x
Date:   Sat, 28 Aug 2021 16:02:03 +0200
Message-Id: <20210828140205.21973-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210828140205.21973-1-frattaroli.nicolas@gmail.com>
References: <20210828140205.21973-1-frattaroli.nicolas@gmail.com>
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
2.33.0

