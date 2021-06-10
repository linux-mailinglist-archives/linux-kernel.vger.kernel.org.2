Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496CB3A3575
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 23:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbhFJVL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 17:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhFJVLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 17:11:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE08C0617A6;
        Thu, 10 Jun 2021 14:09:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ce15so1274172ejb.4;
        Thu, 10 Jun 2021 14:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3DSsWL8igEPr3XsSaRV6tsgY1sxYBksVy0aJLHD4Dpg=;
        b=Lk8u8mOjmOFP5ph4LrY0UIoPaa7SPLhQB7jsRExRrHmZ4npjYhr79H4TdvmT1oA1pC
         3u7Crot1msu7y5Vmqvnv1v7+zf8Vn3pF+gsuFX87waBJK4PtyiIB/RbQq5xwNttzRWMC
         Ml8qVzjwe+fhHUuYbk6IeUO4wvvY9fy220zVyRois1AZKrN/9b3RREp/hRsiat0O5tyA
         zVQKOJzN47n9T9D9ZanMonUdsAsdF+2m9K0y+N4vRJUwBpJrSQpa17zVgLETU5nMl4yO
         74k7QTTYmuwLy9X7F4hxLZxdZWEVh0rOay22iqurDlpW9kayRKFwwqMEkjlqQObNwVPQ
         TjMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3DSsWL8igEPr3XsSaRV6tsgY1sxYBksVy0aJLHD4Dpg=;
        b=En9KLU6UAOb6B8f5XYAtIavxHOSaE6h0xnAmR4vRCz+gRSMyrEV6xOHtwJHG09vpfj
         or5OSdr09hXcxy+P+27CWqlLUdpMZQwvqZeIXHrnpQHRYLtSnHfXpw6lDM1P72LRDq0H
         PKTSKbHSkeVl5w5lVnpfBjysSTwxP20nZVADwMAHinFhG3b7snJ1bO/EpuChODwr+aBA
         pBbj5qQWAUsRLAsRd9RbGW9r4wNr/FtMynlB8ruqr2HgtZZ9/WcG2W24E2BY/NXQpBee
         j0DuJGEhOKMt/zqOCUk98a867JnIjVLYi90YbUEnNtWGEQeRbPQyfYBCSAZvurGvKbbm
         NCIQ==
X-Gm-Message-State: AOAM533XOQhpS0CARWNFzY8nMBjI9t1UKUDwAq+MoIns1kkXPspRAGn/
        Idv3uEuFuEc1qHyOqrLLBE4djdI1zB8=
X-Google-Smtp-Source: ABdhPJxD8ATFqrWNRiGeKpNXhq+ubzKZHpzB1hfOXuOifAIySR95ieYsL01BQyAVhZQ+pSpq/Lemxg==
X-Received: by 2002:a17:906:5407:: with SMTP id q7mr473466ejo.158.1623359366982;
        Thu, 10 Jun 2021 14:09:26 -0700 (PDT)
Received: from localhost.localdomain ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id c18sm1836294edt.97.2021.06.10.14.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 14:09:26 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: owl-s500-roseapplepi: Add ethernet support
Date:   Fri, 11 Jun 2021 00:09:22 +0300
Message-Id: <632e12c445ced7f10e6d7240162484ae5afc148e.1623358117.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623358117.git.cristian.ciocaltea@gmail.com>
References: <cover.1623358117.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl configuration for enabling the Ethernet MAC on RoseapplePi
SBC. Additionally, provide the necessary properties for the generic S500
ethernet node in order to setup PHY and MDIO.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
index b8c5db2344aa..bffabc7eaa50 100644
--- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -225,6 +225,38 @@ bias1-pinconf {
 			bias-pull-down;
 		};
 	};
+
+	ethernet_pins: ethernet-pins {
+		txd01-pinmux {
+			groups = "rmii_txd0_mfp", "rmii_txd1_mfp";
+			function = "eth_rmii";
+		};
+
+		rxd01-pinmux {
+			groups = "rmii_rxd0_mfp", "rmii_rxd1_mfp";
+			function = "eth_rmii";
+		};
+
+		txen_rxer-pinmux {
+			groups = "rmii_txen_mfp", "rmii_rxen_mfp";
+			function = "eth_rmii";
+		};
+
+		crs_dv_ref_clk-pinmux {
+			groups = "rmii_crs_dv_mfp", "rmii_ref_clk_mfp";
+			function = "eth_rmii";
+		};
+
+		ref_clk-pinconf {
+			groups = "rmii_ref_clk_drv";
+			drive-strength = <2>;
+		};
+
+		phy_clk-pinmux {
+			groups = "clko_25m_mfp";
+			function = "clko_25m";
+		};
+	};
 };
 
 /* uSD */
@@ -241,6 +273,30 @@ &mmc0 {
 	vqmmc-supply = <&sd_vcc>;
 };
 
+&ethernet {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet_pins>;
+	phy-mode = "rmii";
+	phy-handle = <&eth_phy>;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reset-gpios = <&pinctrl 88 GPIO_ACTIVE_LOW>; /* GPIOC24 */
+		reset-delay-us = <10000>;
+		reset-post-delay-us = <150000>;
+
+		eth_phy: ethernet-phy@3 {
+			reg = <0x3>;
+			max-speed = <100>;
+			interrupt-parent = <&sirq>;
+			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		};
+	};
+};
+
 &twd_timer {
 	status = "okay";
 };
-- 
2.32.0

