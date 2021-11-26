Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF5D45F4CD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 19:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbhKZSpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 13:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbhKZSnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 13:43:15 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F38CC061A32
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:15:34 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a18so20374463wrn.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 10:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ahw/QenqQyKXJUA0nTYOkumXqWeROPUf/bI0w/XDAUc=;
        b=MIiRpXwFRLfny63efM06n6kJ2s1h+iNfMePA6PSjBY2bO0CwEzgQjZ5nzPf0bpS1y9
         jnSrUVXnfF/qkRj4evru5ggjjA1mgOtyPd1mnVDo9/QDAWeoXdI/1z0BbDqviGBBCD7+
         DY6Xiq7cs8KhuHaXVf4ib//0NTnpwtLzbmoMej4oisXfPp2dNXzzkIjEVOllX2K8GMxv
         j3Xk2XC181nNqYoO8fNqCPXOsMti4UbkJ2OM3FOKKD7EmY3M4Tsc4pUDEV4nk6mGf/qM
         1i7J0tXlgnHG5ZhS3ZosRy66L/UjMad/kGtQ24MEQiPyqkeQHGgJp79sOtovExkJ+QJG
         w3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ahw/QenqQyKXJUA0nTYOkumXqWeROPUf/bI0w/XDAUc=;
        b=HRK2xOhwfzNQyx1HkmZQXOlLAopoiJNBzyFyBewoS0aPXrI9Yz1n3xKqbIABuliDSE
         KVaDEe40jS03QzeOUn9lmwk48nUpFnE81Y0vZNdhhiMSJ2ugt72o8S26BoRjSviP0V6/
         Xu1gWHSjR8AzQJlnssKrSoGtJXQFXESxQ1YtsCboOS86XiE8w9j2g9vZJLFNiyRrt3LG
         1D2jKGYkUWgz/ygEVAzETN4OjCBZSjWiVAjunHNA8UY7FG0GOssJRjOk8khtstqvz0Ur
         aRIylmCW6YTIBoCL8vmKcDwB7zeujbDTvcz8DRlFOJTPiyXo+eV+f4g8avRvDWiK9Kre
         JLxQ==
X-Gm-Message-State: AOAM530WjfrfW5OEyFK5p1xf3aBIC+LtoyiMsJPKkKEPcvMaZnGyf/d6
        ipGKJWlXnEBT7lRr2l3fZwQHhw==
X-Google-Smtp-Source: ABdhPJz2UCPzO58at6onpT/w1UzbhZq/SyFPTenYXL7cuMCyaWnbsAnBNtmwL1aQxpesUsmSZfvB7Q==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr16199318wro.290.1637950532783;
        Fri, 26 Nov 2021 10:15:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:70b:e5b5:f868:20cf])
        by smtp.gmail.com with ESMTPSA id r83sm11744735wma.22.2021.11.26.10.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 10:15:31 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        ulf.hansson@linaro.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v2 2/5] arm64: dts: rockchip: Add powerzones definition for rock960
Date:   Fri, 26 Nov 2021 19:14:55 +0100
Message-Id: <20211126181500.3404129-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126181500.3404129-1-daniel.lezcano@linaro.org>
References: <20211126181500.3404129-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the powerzones description. This first step introduces the big,
the little and the gpu as a powerzone place.

Cc: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
   V1: Initial post
   V2:
     - Move description in the SoC dtsi specific file
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 25 ++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index d3cdf6f42a30..3c0dbc0cb2bc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -76,6 +76,8 @@ cpu_l0: cpu@0 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#powerzone-cells = <0>;
+			powerzone = <&PKG_PZ>;
 		};
 
 		cpu_l1: cpu@1 {
@@ -88,6 +90,8 @@ cpu_l1: cpu@1 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#powerzone-cells = <0>;
+			powerzone = <&PKG_PZ>;
 		};
 
 		cpu_l2: cpu@2 {
@@ -100,6 +104,8 @@ cpu_l2: cpu@2 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#powerzone-cells = <0>;
+			powerzone = <&PKG_PZ>;
 		};
 
 		cpu_l3: cpu@3 {
@@ -112,6 +118,8 @@ cpu_l3: cpu@3 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <100>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#powerzone-cells = <0>;
+			powerzone = <&PKG_PZ>;
 		};
 
 		cpu_b0: cpu@100 {
@@ -124,6 +132,8 @@ cpu_b0: cpu@100 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <436>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#powerzone-cells = <0>;
+			powerzone = <&PKG_PZ>;
 
 			thermal-idle {
 				#cooling-cells = <2>;
@@ -142,6 +152,8 @@ cpu_b1: cpu@101 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <436>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			#powerzone-cells = <0>;
+			powerzone = <&PKG_PZ>;
 
 			thermal-idle {
 				#cooling-cells = <2>;
@@ -791,6 +803,17 @@ spi5: spi@ff200000 {
 		status = "disabled";
 	};
 
+	powerzones {
+
+		PKG_PZ: pkg {
+			#powerzone-cells = <0>;
+                        powerzone = <&SOC_PZ>;
+		};
+
+		SOC_PZ: soc {
+		};
+	};
+
 	thermal_zones: thermal-zones {
 		cpu_thermal: cpu-thermal {
 			polling-delay-passive = <100>;
@@ -2027,6 +2050,8 @@ gpu: gpu@ff9a0000 {
 		clocks = <&cru ACLK_GPU>;
 		#cooling-cells = <2>;
 		power-domains = <&power RK3399_PD_GPU>;
+		#powerzone-cells = <0>;
+		powerzone = <&PKG_PZ>;
 		status = "disabled";
 	};
 
-- 
2.25.1

