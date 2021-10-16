Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F017043023F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 12:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244288AbhJPK5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 06:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244273AbhJPK4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 06:56:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2A0C061769;
        Sat, 16 Oct 2021 03:54:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t9so52391885lfd.1;
        Sat, 16 Oct 2021 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mlMdlKBxKYJqrC47Y5BkYGrC93FP3AcHRCKSFGPfaNk=;
        b=jal6pSrzEiKWtd3gwJbzAyVpbwT54fcFA0tyX+Z7NG8h1poK9FZy0NOagT8pyK92Jq
         yvCN1lmTEGOl7nXvRRC2BEAfTPYURqZVJQlGW9yaPd17VqZl85r0Kab8ZWOsSccxEG13
         /wQPBcx/4+pW4KZoATEEqcJL0bCgle21lfzv2YMl9DsDm1iLiwK3tBxKF7ls2bzKtLPY
         J4PHcnKkETud9wMVMZazarhv7vgtWHRdgLqCR6Hwf07W6k3dkXYcjFDbzFKzOB2tQcMB
         VRvS/AzEvpPoMOqLrq9RqFfk0DYcxrwtnvVXYD79ii14bUP4DiJL9gncGPij5GzdWkxs
         lPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlMdlKBxKYJqrC47Y5BkYGrC93FP3AcHRCKSFGPfaNk=;
        b=1QLgBmSCih09OyN/gzNxodMSMA+HtEE3w1wld+DpJ5VUkGpWhJWyvw/CWwMdWYxXWt
         ust/TQDkmv+cJAhApAGAkycTrLIErpHOGOR9ipbKoXJq2bGDz542YrybmSK/D3uqtaU1
         DxB5GnBR2ar9ILoGA2bG4XSw7FOzgPQRcM2/9tVEbNHJhHtwvIyKjFMyEW3WWQ+qV9R6
         xRNyhZSPWHENYp0ZPI06RJTu18PIF80rh6daine8dM6kQW2qcNcd0vqKHzwBIW39/yYw
         tz8aNF1/T7Pv4zuvRhzr6NO7c9cnB75yYcFJnvEgXL7s58+B5gdGxhSLU3JVxOyqwifO
         kH6g==
X-Gm-Message-State: AOAM531BKsbQZH6ScVkmxh6AIGfyIMy1WTN8pZGLJPFm2znRrUTHjjFA
        n/tk2Wt9wFadWIMMIv5txZg=
X-Google-Smtp-Source: ABdhPJxDd7IkXDDhRM+GlrOeQ0wUjy0PbUZHpC3Dk6SdPq8OdfcDc7aYIFIAv7CV7o/cMD23qGCxkA==
X-Received: by 2002:a2e:9c49:: with SMTP id t9mr19193186ljj.86.1634381683146;
        Sat, 16 Oct 2021 03:54:43 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id r3sm814224lfc.131.2021.10.16.03.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 03:54:42 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: rockchip: Add i2s1 on rk356x
Date:   Sat, 16 Oct 2021 12:53:52 +0200
Message-Id: <20211016105354.116513-4-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211016105354.116513-1-frattaroli.nicolas@gmail.com>
References: <20211016105354.116513-1-frattaroli.nicolas@gmail.com>
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
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index b721a34ffa8c..dbe0123e74e8 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -608,6 +608,31 @@ sdhci: mmc@fe310000 {
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
2.33.1

