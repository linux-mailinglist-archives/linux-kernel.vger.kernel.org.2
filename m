Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD3D32A5A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350871AbhCBM5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 07:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443611AbhCBMLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:11:43 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C936C061356;
        Tue,  2 Mar 2021 04:11:03 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id z11so30848292lfb.9;
        Tue, 02 Mar 2021 04:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5maEnFY9Zpzvtrt4gFbzNHegl8kGjroQ7s0Tf+aY64=;
        b=gjj5OmCGonaD5QSTA/EC3kn2dNDT6BCq8GhZykLKReSyh8ilQjNBLbSxM5mgT432Vz
         RsLRuYly0eyBUG2GBm+irxBNz5fKWFvldTZFj/td+GObNcRrq1RrRp40f5vcKHJhfCjU
         /yX6OLv1ekpz2UG40A/k1NZqD9prprTTfXUXZbfAZq+xlzCRJ+ArpKP/mQPjgYm7qpn5
         aFmERnjxK16BzdsKQGnbXMhqaUrxA1rLthAcHhBHjvomgSh834gMxLUei4RLX/EHiIvd
         53CnD8HnNkZXFM+MmZUsr1rUbg+XqIbrTIg4v+dvQ4BvLufpAN0YqUcdo1dKFf4Dyats
         D1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5maEnFY9Zpzvtrt4gFbzNHegl8kGjroQ7s0Tf+aY64=;
        b=L9QFvxQnd/PLKeR0JrrRqvfKaw5QjXfLI+GuFpDyMKrCOvF4nl8FtZuMuv5VDpukhT
         qc9WWAeN0En0PffgszWmQAGQ2IQPRWi291/V6EWoomWwAqKJnzBRxIIfJ7dTjsCYQq/D
         e/7e7tGKtvS5JBeCWP/vKfQKkSp90c6JXUKkdVA9gshk5fmXCry3qLsVbwGMZcHkoDAJ
         tHtbZ/LEfSn029v+mcagdFxZpI4i7JPiVata85KZdbt0EgTXrz2RgtvYe33GsFO+E+ZA
         SoRBBubtDGQdkQJpKjdgWVvzvMxfyIww9I/XZvXU6kB/rgE6/6/HVi+83F49vPLFPtbv
         Wchw==
X-Gm-Message-State: AOAM532mDFdE71aEcyWeHqI9eGVibpudF7dkS12ixQovKNdrC0VeEmXl
        VoSW1m3Qs0P0g+e1eZkCWtA=
X-Google-Smtp-Source: ABdhPJzoYTmzyhtYilkGEdR3qmL5HZtGTKgfU3TEeqyHOK36VbrbrXdT97hTl/Bm4C+PDAuAXsqy7Q==
X-Received: by 2002:a05:6512:130f:: with SMTP id x15mr12387608lfu.259.1614687061845;
        Tue, 02 Mar 2021 04:11:01 -0800 (PST)
Received: from localhost.localdomain (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.gmail.com with ESMTPSA id d21sm835097ljo.55.2021.03.02.04.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 04:11:01 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/14] ARM: tegra: ventana: Support CPU thermal throttling
Date:   Tue,  2 Mar 2021 15:09:51 +0300
Message-Id: <20210302121003.15058-3-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210302121003.15058-1-digetx@gmail.com>
References: <20210302121003.15058-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable CPU thermal throttling on Tegra20 Ventana board.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-ventana.dts | 41 +++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 02b94ed722d0..99a356c1ccec 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -2,6 +2,7 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/thermal/thermal.h>
 #include "tegra20.dtsi"
 #include "tegra20-cpu-opp.dtsi"
 #include "tegra20-cpu-opp-microvolt.dtsi"
@@ -528,9 +529,10 @@ ldo_rtc {
 			};
 		};
 
-		temperature-sensor@4c {
+		nct1008: temperature-sensor@4c {
 			compatible = "onnn,nct1008";
 			reg = <0x4c>;
+			#thermal-sensor-cells = <1>;
 		};
 	};
 
@@ -614,11 +616,13 @@ cpus {
 		cpu0: cpu@0 {
 			cpu-supply = <&vdd_cpu>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			cpu-supply = <&vdd_cpu>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 	};
 
@@ -716,4 +720,37 @@ sound {
 			 <&tegra_car TEGRA20_CLK_CDEV1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <1000>; /* milliseconds */
+			polling-delay = <5000>; /* milliseconds */
+
+			thermal-sensors = <&nct1008 1>;
+
+			trips {
+				trip0: cpu-alert0 {
+					/* start throttling at 50C */
+					temperature = <50000>;
+					hysteresis = <200>;
+					type = "passive";
+				};
+
+				trip1: cpu-crit {
+					/* shut down at 60C */
+					temperature = <60000>;
+					hysteresis = <2000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&trip0>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
 };
-- 
2.29.2

