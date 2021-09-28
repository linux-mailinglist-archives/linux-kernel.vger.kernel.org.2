Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA5A41A546
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 04:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhI1CWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 22:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238701AbhI1CWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 22:22:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3C6C061770
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 19:20:30 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id n18so19579241pgm.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 19:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KEllPcS5Xq9Pyinz9uhBulFqCz5TInIHturtjFlsWfM=;
        b=T87rTQzEU62NuU3FOhvPREGW7/nPgaG5Bzo+GXN2I0O/jz2fHahkOXybbH4MdRKvCP
         WJEjY8UZ7c3qBpCP7kfotW2esh3XCYpDqtX+BxtU/rBeUaUMgJO7N6DBYuhBoG4deGjt
         qGFLAJW3fjE1vFb5YF3JySkjjDRQew9M5nF6lE+Q/o7SBJuhhJv93Jzw3snGguRos0dO
         RsIXhZdioVhosWYH4Ov0asxioE4XHit85mCroKr3NYGgNBij1/tw49ogg3VmoeD8EcwU
         ZL4Zl9FytxEunl+sr8hsbQKXEsUYYKtJvzESv/tkQZf1mLLWSYo5ylP0QezLY2wle8b9
         sq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KEllPcS5Xq9Pyinz9uhBulFqCz5TInIHturtjFlsWfM=;
        b=1oSGPZwmaD3JX5dNTsxcCNhwQcksPso4r/UpD/d3CNAiK4CemjuHEQ3R0xAqy/ttdW
         r1t2y3B442rVyNdzkNTmiL1VTHBYfolzj1vnvY5HGDS+5izJmylJGE4HPXTPYocOthyq
         Efsp5iUuV8QWm8qjLLhnxInB7RwrJ9oQ2o5fFHxRuG2DyVfAMG32mGeyGZUuVddjYuGW
         b/pPuG+6HIWRsZp4xyn8Jhg1z/tKPf8iu0Sycr7Pi8Qyfaf2l+Pc72H7RglB8U0bVvuQ
         zyeNBPd8QU6WuCu1I9ndbrYIVEfFBJjJB0kGf37tzNn5nAz9xxsa9I4PDx6gv/ZS49cI
         e7bg==
X-Gm-Message-State: AOAM531vXO9yBb+394EhC7LMqLwI5IrSO6vWaEgw9Sd5uVNqMgBbnnIt
        cbYxTjL5eIcONARj/1mut+WERw==
X-Google-Smtp-Source: ABdhPJy4QvjIvE5bquuYcb7fMbqGz4cZlG5kaauiiTmBYpbUf2ig1Y5Xi+Wqm45331UsVXUZzzKj+Q==
X-Received: by 2002:a62:4d42:0:b0:44b:3078:7387 with SMTP id a63-20020a624d42000000b0044b30787387mr2859388pfb.27.1632795630041;
        Mon, 27 Sep 2021 19:20:30 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id u12sm19178729pgi.21.2021.09.27.19.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:20:29 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Jami Kettunen <jamipkettunen@gmail.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 3/3] arm64: dts: qcom: Add missing vdd-supply for QUSB2 PHY
Date:   Tue, 28 Sep 2021 10:20:02 +0800
Message-Id: <20210928022002.26286-4-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210928022002.26286-1-shawn.guo@linaro.org>
References: <20210928022002.26286-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QUSB2 PHY requires vdd-supply for digital circuit operation.  Add it for
platforms that miss it.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi           | 2 ++
 arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi | 1 +
 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi        | 1 +
 arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi   | 1 +
 4 files changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
index 51e17094d7b1..d9826ce27e50 100644
--- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
@@ -230,6 +230,7 @@
 &hsusb_phy1 {
 	status = "okay";
 
+	vdd-supply = <&vreg_l28a_0p925>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
 	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
 };
@@ -237,6 +238,7 @@
 &hsusb_phy2 {
 	status = "okay";
 
+	vdd-supply = <&vreg_l28a_0p925>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
 	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index 507396c4d23b..61ea6d4ef8ac 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -184,6 +184,7 @@
 &hsusb_phy1 {
 	status = "okay";
 
+	vdd-supply = <&pm8994_l28>;
 	vdda-pll-supply = <&pm8994_l12>;
 	vdda-phy-dpdm-supply = <&pm8994_l24>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
index 125d7923d713..4f823974559b 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
@@ -102,6 +102,7 @@
 &qusb2phy {
 	status = "okay";
 
+	vdd-supply = <&vreg_l1a_0p875>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
 	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
index 0f5c7828a901..243f4ee5da8c 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-oneplus-common.dtsi
@@ -260,6 +260,7 @@
 &qusb2phy {
 	status = "okay";
 
+	vdd-supply = <&vreg_l1a_0p875>;
 	vdda-pll-supply = <&vreg_l12a_1p8>;
 	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
 };
-- 
2.17.1

