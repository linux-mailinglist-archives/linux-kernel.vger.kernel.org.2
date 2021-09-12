Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46284407C30
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 09:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhILHan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 03:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhILHak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 03:30:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22542C061574;
        Sun, 12 Sep 2021 00:29:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b6so9379817wrh.10;
        Sun, 12 Sep 2021 00:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8XhEt4Fmunfa8NpIGRPQuJN1xu6qouTV5IkQcF+ghU=;
        b=cKXO0KuhajEgiGk1+uT4HTy5EyOwfRg/XscYGA04SmmiTfiwVzN5cb8yuTT+w1S/tc
         fHHVCQoE52EXSOh056ofPSHaNg327CEj2v3BkOpPgPl1R7Chrtp2BYKHp9YUrgB5WIWb
         pk1rOUYa0txYlOq9SCialmsGXlsZLqTHzD0vE8u5yh84Dnff4sRu/9b5J5z3igoVcpaR
         MvFo/IMAILvxNbVjxGT5PJApS40MYHBmcCYwEm/BSshsevBBOuMJjf1Py9eRcYaJE1q7
         qMgO97pF+3YnVuj7+wSwObrDEFuPuzoQskz+UmD4Du/e+odHpEFFLGK98DUkaPDhXDBL
         GSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8XhEt4Fmunfa8NpIGRPQuJN1xu6qouTV5IkQcF+ghU=;
        b=zjiIdJ37KTGI4V/VT/UbhOVYWO/FQBPhbYP040Te3MHPrDLd+crfCpKube+cdmUixw
         l2Bf4EW7+M4K6NxOAv4QI0I93BCqYqrZBIBGUUQ2J3790ecOwzT4OJX2Surhboh8wUBX
         eUtz6PiygvnfPVXw3rfX86uk9MAagZrMVP0IIcNuYXx7Qdl+8Komc7FmkehSJuvT6p0D
         vmjRnyyl5BLCKfsZsHIvdfeRWMioIpqItmRw8dLLI4lKldTmUHgG0ki46jNuzCMM/mDo
         HHSA6RF7VlfujIFzEhhXeoccPO3IZMOMfgM228vbY1KfgUV4Dc/trfAts6W1Sqdf5Wn+
         IC1Q==
X-Gm-Message-State: AOAM530kCykMI0EYrMYT66jjvIAhOLs5rz7uhMNqR+XG0L7D7N1D3BKD
        URXNDujQkYrmYtSJYyUV9mKbJxZu6eH/yg==
X-Google-Smtp-Source: ABdhPJw8j95ed8Tv5MAZwOMVe8G4B4HBMDkVEHQ3XC1PQKwL8HHqVAy8O8rZnTdOeGzxz6l+b1oylA==
X-Received: by 2002:adf:c109:: with SMTP id r9mr6361561wre.184.1631431764810;
        Sun, 12 Sep 2021 00:29:24 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id t18sm3584889wrp.97.2021.09.12.00.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 00:29:24 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 2/2] ARM: dts: sun8i: r40: Add I2S nodes
Date:   Sun, 12 Sep 2021 09:29:14 +0200
Message-Id: <20210912072914.398419-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210912072914.398419-1-jernej.skrabec@gmail.com>
References: <20210912072914.398419-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner R40 has 3 I2S controllers, compatible to those in H3. First
two are routed to pins, while third is used internally for HDMI audio.

Add nodes for all 3 I2S controllers.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 39 ++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 291f4784e86c..1d87fc0c24ee 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -736,6 +736,45 @@ ir1: ir@1c21c00 {
 			status = "disabled";
 		};
 
+		i2s0: i2s@1c22000 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-r40-i2s",
+				     "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22000 0x400>;
+			interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S0>, <&ccu CLK_I2S0>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S0>;
+			dmas = <&dma 3>, <&dma 3>;
+			dma-names = "rx", "tx";
+		};
+
+		i2s1: i2s@1c22400 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-r40-i2s",
+				     "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22400 0x400>;
+			interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S1>, <&ccu CLK_I2S1>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S1>;
+			dmas = <&dma 4>, <&dma 4>;
+			dma-names = "rx", "tx";
+		};
+
+		i2s2: i2s@1c22800 {
+			#sound-dai-cells = <0>;
+			compatible = "allwinner,sun8i-r40-i2s",
+				     "allwinner,sun8i-h3-i2s";
+			reg = <0x01c22800 0x400>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
+			clock-names = "apb", "mod";
+			resets = <&ccu RST_BUS_I2S2>;
+			dmas = <&dma 6>, <&dma 6>;
+			dma-names = "rx", "tx";
+		};
+
 		ths: thermal-sensor@1c24c00 {
 			compatible = "allwinner,sun8i-r40-ths";
 			reg = <0x01c24c00 0x100>;
-- 
2.33.0

