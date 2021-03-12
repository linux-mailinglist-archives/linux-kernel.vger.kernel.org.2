Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D08E338932
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 10:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233545AbhCLJuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 04:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbhCLJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 04:49:31 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35DBC061574;
        Fri, 12 Mar 2021 01:49:30 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ci14so52021032ejc.7;
        Fri, 12 Mar 2021 01:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X/budyxfXl4/blczsR4CErrFNRt8Mt+0vRDmJ7OsswU=;
        b=DTUXasxiiyPWzO5i/r6wl92RXC3cTnOTVkZkkdKXtGLftgRNtLHi0p4MPibHqv6NGM
         IGRvo8X2vWTsdeBfmR1+bI6KziuRPMj59VyMFBjZVlAWcp315BBK/65H7ydyLAqbr/WN
         INpGUl1YVoSgVwxRdS6WgorR7uS5y+g52KSiJ1dbYls0gNI0eBq4hzecFBgr6TX8nxgt
         YYC1ETFJCxBOp0FhhzXqpZfaS7NPIovPzlOAvrDJ18zO+2dwG2jhEexAb/v510kj97rH
         CppvADkeuKdmb8GqWYQnc5IveZYXN2aOByfwoIGRsqlIQdEjKZows4r++zZYYeyMBKSG
         UR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X/budyxfXl4/blczsR4CErrFNRt8Mt+0vRDmJ7OsswU=;
        b=mFg+0CLnpk6FV/getAaYXweKNFzIyKoPr7onlDcnVIL3klhTLuMKUWYuN/piuVnHj1
         1/3Qs61uJTtKf0n7GYKS2fayYQLgEQKBdDMFfSjBVlF7CIqmzUpFRxTCZkMF1PSbMOCX
         1GjVxyezqorMjjF71prJNQDeQL+x1l28ILPOHRKsEWe1hWF/aBwMijx0OeJpMr4lG1KC
         Ay0nMbTPAsu0APUVeOkOW1aInpCTPc1i19YDGmiFVpaJh7Tkq2b/y7z4eLJjHe7DCERA
         9ur8etyjHf8ZihgtihTIVvDwlfPpCNBPTfjaId33X34Zj2nmtWPB2qDfPcbapQEiQgHY
         oZQw==
X-Gm-Message-State: AOAM533jHrTBwjosNxWv2+QxAYtoYzEdKvaE9FClqptVF87Vswp1cBnf
        6U0JmwILcs23etBSifdV/6LjYYlR3NI=
X-Google-Smtp-Source: ABdhPJwBCHXd+irZVwU78OBq1f2fMt8lJDb1A+a9jnR0h/nRr3R5KWj+8a6U+daEedXCDbpJM98l5g==
X-Received: by 2002:a17:907:76ed:: with SMTP id kg13mr7161715ejc.99.1615542569454;
        Fri, 12 Mar 2021 01:49:29 -0800 (PST)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id b22sm2610455edv.96.2021.03.12.01.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 01:49:28 -0800 (PST)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arm: dts: owl-s500-roseapplepi: Add ATC2603C PMIC
Date:   Fri, 12 Mar 2021 11:49:27 +0200
Message-Id: <2e0a2931ae3757f016948e7c78e8e54afa325ae0.1615538629.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node for ATC2603C PMIC and remove the 'fixed-3.1V'
dummy regulator used for the uSD supply.

Additionally, add 'SYSPWR' fixed regulator and provide cpu0 supply.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
---
Please note the patch depends on the ATC260x PMIC support which is queued
for merging in v5.13:

https://lore.kernel.org/lkml/cover.1611653995.git.cristian.ciocaltea@gmail.com/
https://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git/log/?h=for-mfd-next&qt=range&q=a38fd8748464831584a19438cbb3082b5a2dab15..eac013a0b7041f5cfc8feedf429a767675350102

 arch/arm/boot/dts/owl-s500-roseapplepi.dts | 132 ++++++++++++++++++++-
 1 file changed, 126 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/owl-s500-roseapplepi.dts b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
index ff91561ca99c..b8c5db2344aa 100644
--- a/arch/arm/boot/dts/owl-s500-roseapplepi.dts
+++ b/arch/arm/boot/dts/owl-s500-roseapplepi.dts
@@ -2,7 +2,7 @@
 /*
  * Roseapple Pi
  *
- * Copyright (C) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
+ * Copyright (C) 2020-2021 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
  */
 
 /dts-v1/;
@@ -27,20 +27,140 @@ memory@0 {
 		reg = <0x0 0x80000000>; /* 2GB */
 	};
 
-	/* Fixed regulator used in the absence of PMIC */
-	sd_vcc: sd-vcc {
+	syspwr: regulator-5v0 {
 		compatible = "regulator-fixed";
-		regulator-name = "fixed-3.1V";
-		regulator-min-microvolt = <3100000>;
-		regulator-max-microvolt = <3100000>;
+		regulator-name = "SYSPWR";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
 		regulator-always-on;
 	};
 };
 
+&cpu0 {
+	cpu0-supply = <&vdd_cpu>;
+};
+
 &i2c0 {
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
+
+	atc260x: pmic@65 {
+		compatible = "actions,atc2603c";
+		reg = <0x65>;
+		interrupt-parent = <&sirq>;
+		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+
+		reset-time-sec = <6>;
+
+		regulators {
+			compatible = "actions,atc2603c-regulator";
+
+			dcdc1-supply = <&syspwr>;
+			dcdc2-supply = <&syspwr>;
+			dcdc3-supply = <&syspwr>;
+			ldo1-supply = <&syspwr>;
+			ldo2-supply = <&syspwr>;
+			ldo3-supply = <&syspwr>;
+			ldo5-supply = <&syspwr>;
+			ldo6-supply = <&syspwr>;
+			ldo7-supply = <&syspwr>;
+			ldo8-supply = <&syspwr>;
+			ldo11-supply = <&syspwr>;
+			ldo12-supply = <&syspwr>;
+			switchldo1-supply = <&vcc>;
+
+			vdd_cpu: dcdc1 {
+				regulator-name = "VDD_CPU";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-always-on;
+			};
+
+			vddq: dcdc2 {
+				regulator-name = "VDDQ";
+				regulator-min-microvolt = <1300000>;
+				regulator-max-microvolt = <2150000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			vcc: dcdc3 {
+				regulator-name = "VCC";
+				regulator-min-microvolt = <2600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vcc_3v3: ldo1 {
+				regulator-name = "VCC_3V3";
+				regulator-min-microvolt = <2600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			avcc: ldo2 {
+				regulator-name = "AVCC";
+				regulator-min-microvolt = <2600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			vdd_1v8: ldo3 {
+				regulator-name = "VDD_1V8";
+				regulator-min-microvolt = <1500000>;
+				regulator-max-microvolt = <2000000>;
+				regulator-always-on;
+			};
+
+			vcc_3v1: ldo5 {
+				regulator-name = "VCC_3V1";
+				regulator-min-microvolt = <2600000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			avdd: ldo6 {
+				regulator-name = "AVDD";
+				regulator-min-microvolt = <700000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-always-on;
+			};
+
+			sens_1v8: ldo7 {
+				regulator-name = "SENS_1V8";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+			};
+
+			ldo8: ldo8 {
+				regulator-name = "LDO8";
+				regulator-min-microvolt = <2300000>;
+				regulator-max-microvolt = <3300000>;
+			};
+
+			svcc: ldo11 {
+				regulator-name = "SVCC";
+				regulator-min-microvolt = <2600000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+			};
+
+			rtc_vdd: ldo12 {
+				regulator-name = "RTC_VDD";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-always-on;
+			};
+
+			sd_vcc: switchldo1 {
+				regulator-name = "SD_VCC";
+				regulator-min-microvolt = <3000000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+		};
+	};
 };
 
 &i2c1 {
-- 
2.30.2

