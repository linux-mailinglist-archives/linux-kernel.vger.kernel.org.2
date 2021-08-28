Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352113FA4D2
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 11:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhH1JqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 05:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhH1JqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:46:14 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7DBC061756;
        Sat, 28 Aug 2021 02:45:24 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lc21so19394044ejc.7;
        Sat, 28 Aug 2021 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVSThyxcJIxO6/MqLNa1RZ3VCG/V0uLT1hBIC06use0=;
        b=bN7jTAmnpL49pubBkgeXTD49jV39N0wtwwBoHDNZ+3geH6/XdVcvmVNVE+/KnAHEXn
         bfSOeO47eVnywNzYUtqUhrXMlTW70rNefh5tEA0KafAtkR7TiUUdn2Ff5/amcsMUaNRh
         +ITC3H2hbQNSW1ePJHJb1TZI30Dci4GSrqShfi9b4E7OzZb4KfJUdqwxqZQj7GqC5V1e
         7Q3Xl8XLTFugt0slsOxlXkv0IUdXsDl1FapbC7u1mp5bbgg00Vs+iixgZnJCxPY6NIlH
         RsHPxJ+yg9/INmCvqcviSH9P7e/49tfHWQDNCsnCGSyRcdABAqFj2yQfsXVorL5eD2pm
         JxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rVSThyxcJIxO6/MqLNa1RZ3VCG/V0uLT1hBIC06use0=;
        b=ryqW9SfG7N1WMEr0E5+r44D9nlAw5Cwy7miJWR8wit8SMg+sqq9LBU2Eqv/GGgwGAz
         NJvFrH330+KqXflqiSNJFiZgVTSCs3Ur0O2eECyKz3vY2xozg7pYFWkGSMOVdvBo7PQc
         mXSsNSDAVxTSdIB+eBJtY/QGJ9kxThZUXO9/19uz1oFM+ieKU0pE9agMU3V8j9A3ozeS
         gGdXAJ+awu3Ld0ngyqSN8ic5JgFUFXfkAN1TW61gyrWdf7kqfiJA8PdqOh7Z6KMPiHBz
         isnPKGG0CPdHhF+F21/yeGJ9nQtRFo54Nl7be+EmoXAUjDFBfGVuOxkPV+9yL9HSd5Fl
         C/jw==
X-Gm-Message-State: AOAM531z0sgkyip2u2PWOXzIncW7m8hhqSuz0TIOXY8NHvRI9t0eeYcs
        mbNchd4FNsctZSuR7QgbKYM=
X-Google-Smtp-Source: ABdhPJwWxk63rPsUGH0JQ+4pj/rJeLjbpyQKsxXZ5WOrFnxl9QL/oOy1HaO4X7kUOAecSCdz6u6Y9g==
X-Received: by 2002:a17:906:7095:: with SMTP id b21mr14704691ejk.131.1630143922661;
        Sat, 28 Aug 2021 02:45:22 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q18sm4017076ejc.84.2021.08.28.02.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 02:45:22 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: rename opp-table node names
Date:   Sat, 28 Aug 2021 11:45:12 +0200
Message-Id: <20210828094512.26862-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the conversion to YAML of the Operating Performance Points(OPP)
binding the operating-points-v2 property expects the nodename to have
the '^opp-table(-[a-z0-9]+)?$' format, so rename all Rockchip ARM dts
opp-table node names.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/opp/opp-v2.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3188.dtsi | 2 +-
 arch/arm/boot/dts/rk3229.dtsi | 2 +-
 arch/arm/boot/dts/rk322x.dtsi | 2 +-
 arch/arm/boot/dts/rk3288.dtsi | 4 ++--
 arch/arm/boot/dts/rv1108.dtsi | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 2c606494b..d6a946a2a 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -54,7 +54,7 @@
 		};
 	};
 
-	cpu0_opp_table: opp_table0 {
+	cpu0_opp_table: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
diff --git a/arch/arm/boot/dts/rk3229.dtsi b/arch/arm/boot/dts/rk3229.dtsi
index cb7d3fad8..c340fb30e 100644
--- a/arch/arm/boot/dts/rk3229.dtsi
+++ b/arch/arm/boot/dts/rk3229.dtsi
@@ -10,7 +10,7 @@
 
 	/delete-node/ opp-table0;
 
-	cpu0_opp_table: opp_table0 {
+	cpu0_opp_table: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 75af99c76..4021e92e0 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -68,7 +68,7 @@
 		};
 	};
 
-	cpu0_opp_table: opp_table0 {
+	cpu0_opp_table: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 4dcdcf17c..1ded2aabe 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -100,7 +100,7 @@
 		};
 	};
 
-	cpu_opp_table: cpu-opp-table {
+	cpu_opp_table: opp-table-0 {
 		compatible = "operating-points-v2";
 		opp-shared;
 
@@ -1278,7 +1278,7 @@
 		status = "disabled";
 	};
 
-	gpu_opp_table: gpu-opp-table {
+	gpu_opp_table: opp-table-1 {
 		compatible = "operating-points-v2";
 
 		opp-100000000 {
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 24d56849a..7d96a0d02 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -40,7 +40,7 @@
 		};
 	};
 
-	cpu_opp_table: opp_table {
+	cpu_opp_table: opp-table-0 {
 		compatible = "operating-points-v2";
 
 		opp-408000000 {
-- 
2.20.1

