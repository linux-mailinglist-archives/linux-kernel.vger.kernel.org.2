Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B618400831
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 01:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350724AbhICXRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 19:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350682AbhICXRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 19:17:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C3DC061575;
        Fri,  3 Sep 2021 16:16:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i21so1111073ejd.2;
        Fri, 03 Sep 2021 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VpzMzVA/7NS9EjmqL9D8W4mi42UY9oZ3H5iMtM5xjds=;
        b=A4YSx25VKocwcflusol89X01AiH6ksf4xQonvz6/LMUpLJ33QY8b+hKkBKAFTs8AxK
         iCHv68o6LVLHE5BxA5XifNgHxgn7LAij99rO9kIQ2ps5GF9ooudU7v3F7bfc5g5PEaCN
         B0CLpXJi4exASWAnHnYdKpb88ZVMniX7phZHXMTxBnH2zV+mof7D3QlJYvuEQi6GTd9F
         BMU0KXGHbdqGV7BSdHI9eCr0pih0KnfLqRdZqpTButiCZ9jMw5Sl3XqLkJLQAclMDiUz
         HPa55o49qjMmpGVaqXnh/uBKFnABy8KNUr/bCoNPAskOyNixi9X+MShFJVizaKkPnHok
         OlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VpzMzVA/7NS9EjmqL9D8W4mi42UY9oZ3H5iMtM5xjds=;
        b=oJZskeOCsyUjKLpsr4+0CfvaRoGoZk5CNgC0R+wM7gQZ92Zw1KBLdHJ9ob6rDUA2HO
         LtofEl/BZGTnLtuKMGkDyTsydlIZlfDEXg2QuM65MS+ota3KU58j6aZYLWs0M8hs/Fm7
         nvHp2HmYNkgakbRTOBoP0UerLGlawsodeBNRbP39fwhW+OPBdP2En+NGF0BGWjUcLOtN
         j82huqaNDAzSnwGNQRm0vNi/3/80IMaa3bXsK5WNdeIOGd89GbUoqhkH6CxU6940c/o+
         1b6olvJ+v1l+K/Res7KG1udqq1/JYYZY7Ci+rcMbYlA9ifrS3ha7DqPdD9zMpqNwBDEe
         pFiA==
X-Gm-Message-State: AOAM530Q+jP4OXd9ZqQf2wrcHMBfFl+eNQvzr5T02NYkTWnWCXiSeKpM
        MabD0JpNLzEeh9aWRmupWng=
X-Google-Smtp-Source: ABdhPJzXQCrOFY8FeHwtsYm8H7piiUeruCZps5U7zKT0kOKo5bU4uhx7OuNsUqICaYsnfB7lgfPp2g==
X-Received: by 2002:a17:906:16c4:: with SMTP id t4mr1409139ejd.302.1630710995073;
        Fri, 03 Sep 2021 16:16:35 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id r11sm214068ejy.71.2021.09.03.16.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 16:16:34 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] arm64: dts: rockchip: add i2s1 on rk356x
Date:   Sat,  4 Sep 2021 01:15:35 +0200
Message-Id: <20210903231536.225540-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
References: <20210903231536.225540-1-frattaroli.nicolas@gmail.com>
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
index e42fbac6147b..a24f7160f6d4 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -564,6 +564,32 @@ sdhci: mmc@fe310000 {
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

