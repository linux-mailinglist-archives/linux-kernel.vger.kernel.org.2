Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9503F7E46
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 00:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhHYWPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 18:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhHYWPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 18:15:34 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5888C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:14:47 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id u25so1512685oiv.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9KfVIzSyARslEPzlWZ8hh6ldkUq9egIVeeue+74TGI=;
        b=ITzmM5liOlmDv1jNESayxrPaXDKEoynVgEb83OyUmfZqz/MihFr8TjWhFLuBD9Tf9U
         6jZPC2ebwpeWzbSS2Cja9vEQ724iMj9G8zNReBtFW8abTdzjLxggGO5fmimW8JQ8N5Qi
         2x/9hfwA2AVr0Xa6RhQPMH0xu8t2bB+olH2MVcQ98RRbB2D+0OFsDj4wDCytyKzFzWjB
         ZOkNlz2zasL+KTGjS4x712NRYoZ1JNxrX2oT7sB+/CLxKboTqq+PFgVvC/eIKLFpLdUg
         HRAhZ8/sP6srU4eotd9QdgI3i8xAwwFxigb7AWoeHGkq4WBZlw30Lb9+EB4CRadKqewe
         pXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9KfVIzSyARslEPzlWZ8hh6ldkUq9egIVeeue+74TGI=;
        b=SZb6JEZdeVA9ttVp+diAEyp4dCpN+wYw2jG4ouUVN2CXOU2/xBMOZEG11Gr26zhvW4
         17yahHQORO0RkeGUYMI5ONLkEzq5mA3sG6Jzfh6K9zgxTOQOrGFondudfswFaAn+Y0fG
         sNCBfF6h3VGqluSaWwHX1WOgordvN3ad0iU+FyhrkfSpDOAQs6jwsRYS/g1Z2xVP7x+x
         HX+8FtHIURSmHVBbNAf7tiXKwyBqNj3imrd0rEIpPc3shcJP6TgHtHd77VMGTJozy3fz
         C1fTVWVhGThlC0bGIbKItFHAM5A9qQMXdJToBX2RAG4+Wp5FsuD+mkJDItlSTDj1eQez
         SAIQ==
X-Gm-Message-State: AOAM530FLpZd1CwRLE0krr67EBvP1dYfjHNDk+msddBbbxRctbPvb4Hv
        G8WQpE5QXedqri7EaxIGGt9nmA==
X-Google-Smtp-Source: ABdhPJy2QRYWjpe68bSy5Bb2HgWYJp3XPgH6YequU/fxVvw+YKVQmaaE9aToPhLmY6gI4X53aK6qkA==
X-Received: by 2002:aca:bf84:: with SMTP id p126mr184869oif.154.1629929687080;
        Wed, 25 Aug 2021 15:14:47 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id i1sm235983oiy.25.2021.08.25.15.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 15:14:46 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert Foss <robert.foss@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8350: Add CPU topology and idle-states
Date:   Wed, 25 Aug 2021 15:16:00 -0700
Message-Id: <20210825221600.1498939-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add CPU topology and define the idle states for the silver and gold
cores as well as the cluster.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 141 +++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index c6e1febaee46..35e8935bc1fa 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -48,6 +48,8 @@ CPU0: cpu@0 {
 			enable-method = "psci";
 			next-level-cache = <&L2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD0>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_0: l2-cache {
 			      compatible = "cache";
@@ -65,6 +67,8 @@ CPU1: cpu@100 {
 			enable-method = "psci";
 			next-level-cache = <&L2_100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD1>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_100: l2-cache {
 			      compatible = "cache";
@@ -79,6 +83,8 @@ CPU2: cpu@200 {
 			enable-method = "psci";
 			next-level-cache = <&L2_200>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD2>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_200: l2-cache {
 			      compatible = "cache";
@@ -93,6 +99,8 @@ CPU3: cpu@300 {
 			enable-method = "psci";
 			next-level-cache = <&L2_300>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
+			power-domains = <&CPU_PD3>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_300: l2-cache {
 			      compatible = "cache";
@@ -107,6 +115,8 @@ CPU4: cpu@400 {
 			enable-method = "psci";
 			next-level-cache = <&L2_400>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD4>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_400: l2-cache {
 			      compatible = "cache";
@@ -121,6 +131,8 @@ CPU5: cpu@500 {
 			enable-method = "psci";
 			next-level-cache = <&L2_500>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD5>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_500: l2-cache {
 			      compatible = "cache";
@@ -136,6 +148,8 @@ CPU6: cpu@600 {
 			enable-method = "psci";
 			next-level-cache = <&L2_600>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
+			power-domains = <&CPU_PD6>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_600: l2-cache {
 			      compatible = "cache";
@@ -150,12 +164,86 @@ CPU7: cpu@700 {
 			enable-method = "psci";
 			next-level-cache = <&L2_700>;
 			qcom,freq-domain = <&cpufreq_hw 2>;
+			power-domains = <&CPU_PD7>;
+			power-domain-names = "psci";
 			#cooling-cells = <2>;
 			L2_700: l2-cache {
 			      compatible = "cache";
 			      next-level-cache = <&L3_0>;
 			};
 		};
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&CPU0>;
+				};
+
+				core1 {
+					cpu = <&CPU1>;
+				};
+
+				core2 {
+					cpu = <&CPU2>;
+				};
+
+				core3 {
+					cpu = <&CPU3>;
+				};
+
+				core4 {
+					cpu = <&CPU4>;
+				};
+
+				core5 {
+					cpu = <&CPU5>;
+				};
+
+				core6 {
+					cpu = <&CPU6>;
+				};
+
+				core7 {
+					cpu = <&CPU7>;
+				};
+			};
+		};
+
+		idle-states {
+			entry-method = "psci";
+
+			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "silver-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <355>;
+				exit-latency-us = <909>;
+				min-residency-us = <3934>;
+				local-timer-stop;
+			};
+
+			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+				compatible = "arm,idle-state";
+				idle-state-name = "gold-rail-power-collapse";
+				arm,psci-suspend-param = <0x40000004>;
+				entry-latency-us = <241>;
+				exit-latency-us = <1461>;
+				min-residency-us = <4488>;
+				local-timer-stop;
+			};
+		};
+
+		domain-idle-states {
+			CLUSTER_SLEEP_0: cluster-sleep-0 {
+				compatible = "domain-idle-state";
+				idle-state-name = "cluster-power-collapse";
+				arm,psci-suspend-param = <0x4100c344>;
+				entry-latency-us = <3263>;
+				exit-latency-us = <6562>;
+				min-residency-us = <9987>;
+				local-timer-stop;
+			};
+		};
 	};
 
 	firmware {
@@ -179,6 +267,59 @@ pmu {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+
+		CPU_PD0: cpu0 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD1: cpu1 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD2: cpu2 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD3: cpu3 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+		};
+
+		CPU_PD4: cpu4 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD5: cpu5 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD6: cpu6 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CPU_PD7: cpu7 {
+			#power-domain-cells = <0>;
+			power-domains = <&CLUSTER_PD>;
+			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+		};
+
+		CLUSTER_PD: cpu-cluster0 {
+			#power-domain-cells = <0>;
+			domain-idle-states = <&CLUSTER_SLEEP_0>;
+		};
 	};
 
 	reserved_memory: reserved-memory {
-- 
2.29.2

