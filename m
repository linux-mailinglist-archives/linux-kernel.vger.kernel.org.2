Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A96D41F2DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355270AbhJARSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354960AbhJARSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:18:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC68C061775;
        Fri,  1 Oct 2021 10:16:40 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ba1so37294076edb.4;
        Fri, 01 Oct 2021 10:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VpzMzVA/7NS9EjmqL9D8W4mi42UY9oZ3H5iMtM5xjds=;
        b=qae9nErc5IQ+5p/SV0ZKLuHq3j6ozUhNtpNZYRcNNl7tMzk86Gc2Xk3muCb/52/JMW
         /qwaUDCEVPQ+NpZEuanfdfps4DhLRBPTzCw/hT8e3cmZQsCqrOuJEaQSY8uL0ClbCXJR
         cv1OIAwyaDA0uQPFs1ZlX8/0Cmx8XZ+CqXjJofarOmp2bsr+4mi6SOc7EZwnCp9XQJA7
         mV/VTjv/L4GP1ba/CRSZy9LSkDtfykoQWcL6TzPWC4d0prsanxqN15INinrOjnujRZim
         lMz+MY1Q+jV/4j8pgRnXK/ybEWn1qSgP+O6J9CPsJwQ0jjFCo4lYGeY0Fqh0QUwO744/
         1Y6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VpzMzVA/7NS9EjmqL9D8W4mi42UY9oZ3H5iMtM5xjds=;
        b=mZ7P2cc+kRXpxuY7IQbljinCZs2j7zvR5w70oDiCbWaU/lu9mHVjIhq8yQhnarF9w1
         04N/TEsgqnQiwJ00rMdRBw0y1yO4FlO8dxwg7dkbrc4+NwfmNa4aMm4GN7UWYXaKS5VQ
         AmypGaOz9clPlLyRYVjp9IPHzmE/7GoiPXG+Rvvb+66Xdu/0MMn6WKOMwGgA+XjIE6wd
         uNhA+ZOzRneudU3nOdVsqkxNF4ydAkPsW8CjMGxF+Uv2NZfaU/S+VVv9+Zc4uoa2yflE
         VfyKzTqJnpwzjdzqfZpoVj9Lafz+OCZxUlZXFm/DDDgHrXxbElMwDG603cGGow2f+1ll
         fPGw==
X-Gm-Message-State: AOAM531sUntonjNxzcR1CFyj8Ey1YxX0E0n5O6hVWiAyKJMHSHhxygIi
        H9WI03JX11n+ex3JUhLWYWo=
X-Google-Smtp-Source: ABdhPJy8rgscJ7SMxXBHuEIAT3eSdmvgYEFAp54PH2+fChoR/Nd0zg5fhuqadxDh6Dq/eNK08n/taA==
X-Received: by 2002:a17:906:b19:: with SMTP id u25mr447724ejg.36.1633108598527;
        Fri, 01 Oct 2021 10:16:38 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id h10sm3588130edf.85.2021.10.01.10.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:16:38 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/4] arm64: dts: rockchip: add i2s1 on rk356x
Date:   Fri,  1 Oct 2021 19:15:30 +0200
Message-Id: <20211001171531.178775-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211001171531.178775-1-frattaroli.nicolas@gmail.com>
References: <20211001171531.178775-1-frattaroli.nicolas@gmail.com>
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

