Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6443737985F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 22:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbhEJU3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 16:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbhEJU3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 16:29:14 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57512C061574;
        Mon, 10 May 2021 13:28:09 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id v6so22409669ljj.5;
        Mon, 10 May 2021 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cyEy7fx6tg9GIuRKAR9/qzzC+Zpw0uxWP4sTNGqvf0Q=;
        b=esNzuBtXEO9AM8x5myNfTG1l18Q0JTQaGfd2mpM2autzv7ELRo/dHqcoWOdI9yrfgk
         iHM2tC7fSwdyRQm+emPenGl/33TS+o8P88SpDCGsJ8Mw+plnRvguD3QSNBgJ7pbx644W
         20IVO6iTTcbWmLP/LbuqX3PdKPgMBVqIDnIGKYoRHyUYmYdvlty0tbxRJVnXoT3DAfEP
         8we442FRk4/rIN8hS6pVN6VdA+cL398dRB60xhcVu4UG5X1/8WdJmxSu1wwbATGe9yDU
         o+QrsSegsp1SRGvxX+ce4yUVJ9tYF2c6ScCUisxgYpkVKdGbT53kK4GU8vbTpkcFyy6x
         G+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cyEy7fx6tg9GIuRKAR9/qzzC+Zpw0uxWP4sTNGqvf0Q=;
        b=LoQN5e2i7rrfcJWEJ982G5wHtoKJzJ1ZaFDAB6ztVkgYKHLl5EBUWgJNOYFAPIkyDH
         l5p85Jb3XLh4WUUMmh4g0SXv/ZEWRDDNVnGKaAuX9aJEIrzLtLrXETjQeeIOngDVFIj4
         8nYfKxfI/fijHiJhfZRd572fpVZYpz7ia4TXkjra1Ut7rxCwnF7cAv5m2yxHOlDh/WnI
         KVuNWMW9D9DdeVWXMG5ky652BhUSagFse/TabQ3Rh79F577kUO8JMXpnFB2dpGKDVUjr
         zgAKkHLy+tVZwXrSz0r4Y3SDTKnGkpV10uBFWezOboBFZ/Er6EfSvChpoJdtu4n3ez2V
         IFOg==
X-Gm-Message-State: AOAM531XIjfrcy6fG6cAm4UUiyvif2/zPdRq56/c2v1CPGooPij67TM9
        7MrtLUBROo9/e6UFdEu07qc=
X-Google-Smtp-Source: ABdhPJzJoTg9w4PqfoObGe53qGg0RXFs4yjVkI7Gr77pG/rTunTOW23pq1lDrdYvS+LGRNe43DVIcQ==
X-Received: by 2002:a05:651c:b12:: with SMTP id b18mr6136708ljr.24.1620678487917;
        Mon, 10 May 2021 13:28:07 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id z23sm2360662lfq.241.2021.05.10.13.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 13:28:07 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Agneli <poczt@protonmail.ch>, Paul Fertser <fercerpav@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 06/10] ARM: tegra: paz00: Add CPU thermal zone
Date:   Mon, 10 May 2021 23:25:56 +0300
Message-Id: <20210510202600.12156-7-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510202600.12156-1-digetx@gmail.com>
References: <20210510202600.12156-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add thermal zone with a passive cooling trip for CPU. Attach it to the
LM90 sensor which monitors CPU temperature. Now CPU frequencies will be
throttled once trip point is reached, preventing critical overheat.

Tested-by: Agneli <poczt@protonmail.ch>
Tested-by: Paul Fertser <fercerpav@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-paz00.dts | 42 +++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
index 63d62418d4b8..3180bff90756 100644
--- a/arch/arm/boot/dts/tegra20-paz00.dts
+++ b/arch/arm/boot/dts/tegra20-paz00.dts
@@ -2,6 +2,8 @@
 /dts-v1/;
 
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/thermal/thermal.h>
+
 #include "tegra20.dtsi"
 #include "tegra20-cpu-opp.dtsi"
 #include "tegra20-cpu-opp-microvolt.dtsi"
@@ -498,9 +500,10 @@ ldo_rtc {
 			};
 		};
 
-		adt7461@4c {
+		adt7461: temperature-sensor@4c {
 			compatible = "adi,adt7461";
 			reg = <0x4c>;
+			#thermal-sensor-cells = <1>;
 		};
 	};
 
@@ -655,11 +658,46 @@ cpus {
 		cpu0: cpu@0 {
 			cpu-supply = <&cpu_vdd_reg>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			cpu-supply = <&cpu_vdd_reg>;
 			operating-points-v2 = <&cpu0_opp_table>;
+			#cooling-cells = <2>;
+		};
+	};
+
+	thermal-zones {
+		cpu-thermal {
+			polling-delay-passive = <500>; /* milliseconds */
+			polling-delay = <1500>; /* milliseconds */
+
+			thermal-sensors = <&adt7461 1>;
+
+			trips {
+				trip0: cpu-alert0 {
+					/* start throttling at 80C */
+					temperature = <80000>;
+					hysteresis = <200>;
+					type = "passive";
+				};
+
+				trip1: cpu-crit {
+					/* shut down at 85C */
+					temperature = <85000>;
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
 		};
 	};
 };
-- 
2.30.2

