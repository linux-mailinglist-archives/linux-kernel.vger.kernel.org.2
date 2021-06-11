Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE703A3ECE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhFKJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:14:45 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:53867 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhFKJOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:14:44 -0400
Received: by mail-wm1-f43.google.com with SMTP id b205so2984498wmb.3;
        Fri, 11 Jun 2021 02:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7JY//B99DNoLLjgXO7WYK3oUumq/NbdPAMSrBSy1rE=;
        b=ji9nBoVzSNkdEoW0nLtDN28arisxrU+3RJTiQg3XvfEfifd5NUxVwS4PrW7rHkvsFA
         1E4CJDktYpKD2ol03kGhM+48Cn4JIL5HIf12H5FcWW6AP/7bcpel43PrAJF7Kx0j2gD6
         QWUR7Za/0M2ZhEYFfc9la++dbH+peIDbXUkBYqcMyxJGp1z7FP8eMvKr3WAnBhYw75Gk
         kKGdwDMeEQm9eDCZOOEjqYCTCKbU4Lj59LUZBT0/bUAE7QURbR9O8rkyZs1bX/2t+cic
         iEq1ucnZbZn19Nvfn+pPKkxsEyBH05A4lK97E53GkdLFExsCAnDWVtiSX5Mq3kNOAqpY
         b5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7JY//B99DNoLLjgXO7WYK3oUumq/NbdPAMSrBSy1rE=;
        b=U7eL/Xv1KygjDiLkasHYxmNiUYZDUD9rqekwMY017BmlINnAxbF72gPIr290IUJhJJ
         RTq5q4B7rkHrzk/pVFlPAFu20D89gqbTwePyUir76Y/Iwl59XsW1etX5WqYx8rs+zV1o
         vqABc7gJbFIUC5OA9XSopgTH8Q+ky/8R/P9d4obEuT8+qfvvc2sjdqL3XlmRhCaj+l5C
         HRAAMU9tfYILz9opU9liRGZFdBaeUomGXZTFdV7f+4kpfiUJndFrp+1wwr9wXJqmCQmH
         1jXF1tKUR/dUC0QLAkPN8G9OfQ0RITQQp2EVeo6f6ZnVf2X+sN5YbBau9WFXuTWXcWVx
         qGlw==
X-Gm-Message-State: AOAM532SGurGzN1o9rhfStzS4+dveQfpOCRWDa81KyMXE0b/3HYrbb02
        SwRx8bltUrGor/c/kjD29PfF3xHSPik=
X-Google-Smtp-Source: ABdhPJxHioZvrmg1B9mynbBoAhk0G9PhXpCfeyQxpkJMlf5qwq5PH+VkvK5OeqXb7ELJfqUS09vgVw==
X-Received: by 2002:a1c:b087:: with SMTP id z129mr18833615wme.67.1623402697651;
        Fri, 11 Jun 2021 02:11:37 -0700 (PDT)
Received: from localhost.localdomain ([188.24.178.25])
        by smtp.gmail.com with ESMTPSA id l13sm6667737wrz.34.2021.06.11.02.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 02:11:37 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: owl-s500-roseapplepi: Add ethernet support
Date:   Fri, 11 Jun 2021 12:11:33 +0300
Message-Id: <d0e1fbf81984127f0352eb740c7129424b5e40f9.1623401998.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623401998.git.cristian.ciocaltea@gmail.com>
References: <cover.1623401998.git.cristian.ciocaltea@gmail.com>
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
 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
index b8c5db2344aa..eb555f385283 100644
--- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -225,6 +225,27 @@ bias1-pinconf {
 			bias-pull-down;
 		};
 	};
+
+	ethernet_pins: ethernet-pins {
+		eth_rmii-pinmux {
+			groups = "rmii_txd0_mfp", "rmii_txd1_mfp",
+				 "rmii_rxd0_mfp", "rmii_rxd1_mfp",
+				 "rmii_txen_mfp", "rmii_rxen_mfp",
+				 "rmii_crs_dv_mfp", "rmii_ref_clk_mfp";
+			function = "eth_rmii";
+		};
+
+		phy_clk-pinmux {
+			groups = "clko_25m_mfp";
+			function = "clko_25m";
+		};
+
+		ref_clk-pinconf {
+			groups = "rmii_ref_clk_drv";
+			drive-strength = <2>;
+		};
+
+	};
 };
 
 /* uSD */
@@ -241,6 +262,30 @@ &mmc0 {
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

