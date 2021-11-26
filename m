Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A706245F09C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378145AbhKZP0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353958AbhKZPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:24:44 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D8C0613F7;
        Fri, 26 Nov 2021 07:17:41 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id l16so19351615wrp.11;
        Fri, 26 Nov 2021 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7632Wp+Dnl5QiuckVe1VavN+ZTk/pekVUAmEmgU5JLo=;
        b=Bz7mbuRMPID17ZDmYvP0fKpqK4E//J2NOtGDfu3zmArWkioxBedFq9tyeQf7oQt/1L
         9dT1+bf6F99+vrxmbEEnfRtlV8sYHzwNZEbGDl+fsytlM4XmbiW8qX3bhF56h04/H7Ow
         s0rKgYJ+ZbsKZTtpk1geLawQ+rza4ttBfCunJzuvpBBkybBHZOxCjCnBWv6027REcKBL
         flIG77FUl/fyLy6dxA/Yf44nBiGcAFo+nlXBslHdox3dmH5ZsoVJVnWg258ixJXXPIqo
         jg08lMRWGQ1Sg9o4fDjpoqo2UVzNZAA1b4II29xWFbQFcyjwm8073ChwCbxPfMq9bFSG
         OuUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7632Wp+Dnl5QiuckVe1VavN+ZTk/pekVUAmEmgU5JLo=;
        b=A1O/b/jfGBPi+uwoibMp5s2XjzX7tJCaCcu5QpwnhglU/MZxbMehCkO/lAwfLR3NKy
         hCGJUiSdQ7tRdwzdL0dLeKI+l9drr9acV3yMMLxsQ2ImN9y84ZzLU7zUURLMtWu+oPwh
         Aln7OjKTmMuGl9OCkJzG7w+fXCBlOjUE7L1mHzsAzA4aV0mU9+MrnMdhEqBgcjY27qu1
         izOBvmT6KzA5+sUXPkuh4TyadRybzwjIjziEfIF0kiEtkZ0MEPdZXdl+ajhiRsHavCW4
         UqDUAQXJKf56KAudkLa6VfiPFThQokl9Zt5IiVin1RvWYXtpAU+9Nq3nXz55TfUO5bEF
         aGCw==
X-Gm-Message-State: AOAM532T+QIUWsH+T2CalV4Ozkz9Qq+5l9rwHyoG6127ApM+JLIoFNFs
        EBV45RtyquhIR434B/1TsA==
X-Google-Smtp-Source: ABdhPJyPQuWLOtmO9f5rmyG1TcI0nYS+8H+GshbbqOdr8H3ilv4rcJQTDjiQ243aHwGIHBgR+6ypVw==
X-Received: by 2002:a5d:480c:: with SMTP id l12mr14996630wrq.518.1637939860158;
        Fri, 26 Nov 2021 07:17:40 -0800 (PST)
Received: from alex-ThinkPad-E480.. (ip5b435a69.dynamic.kabel-deutschland.de. [91.67.90.105])
        by smtp.googlemail.com with ESMTPSA id k187sm12323496wme.0.2021.11.26.07.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 07:17:39 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 2/4] arm64: dts: rockchip: Add GPU node for rk3568
Date:   Fri, 26 Nov 2021 16:17:27 +0100
Message-Id: <20211126151729.1026566-3-knaerzche@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211126151729.1026566-1-knaerzche@gmail.com>
References: <20211126151729.1026566-1-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ezequiel Garcia <ezequiel@collabora.com>

Rockchip SoCs RK3566 and RK3568 have a Mali Gondul core
which is based on the Bifrost architecture. It has
one shader core and two execution engines.

Quoting the datasheet:

Mali-G52 1-Core-2EE
* Support 1600Mpix/s fill rate when 800MHz clock frequency
* Support 38.4GLOPs when 800MHz clock frequency

Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 50 ++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 46d9552f6028..3b314ccd6c94 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -125,6 +125,40 @@ opp-1800000000 {
 		};
 	};
 
+	gpu_opp_table: opp-table-1 {
+		compatible = "operating-points-v2";
+
+		opp-200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <825000>;
+		};
+
+		opp-300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <825000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <825000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <825000>;
+		};
+
+		opp-700000000 {
+			opp-hz = /bits/ 64 <700000000>;
+			opp-microvolt = <900000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1000000>;
+		};
+	};
+
 	firmware {
 		scmi: scmi {
 			compatible = "arm,scmi-smc";
@@ -386,6 +420,22 @@ power-domain@RK3568_PD_RKVENC {
 		};
 	};
 
+	gpu: gpu@fde60000 {
+		compatible = "rockchip,rk3568-mali", "arm,mali-bifrost";
+		reg = <0x0 0xfde60000 0x0 0x4000>;
+
+		interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "job", "mmu", "gpu";
+		clocks = <&scmi_clk 1>, <&cru CLK_GPU>;
+		clock-names = "core", "bus";
+		operating-points-v2 = <&gpu_opp_table>;
+		#cooling-cells = <2>;
+		power-domains = <&power RK3568_PD_GPU>;
+		status = "disabled";
+	};
+
 	sdmmc2: mmc@fe000000 {
 		compatible = "rockchip,rk3568-dw-mshc", "rockchip,rk3288-dw-mshc";
 		reg = <0x0 0xfe000000 0x0 0x4000>;
-- 
2.30.2

