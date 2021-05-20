Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BECB338A0AF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 11:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhETJTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 05:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhETJTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 05:19:53 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F2AC061574;
        Thu, 20 May 2021 02:18:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id u21so24085721ejo.13;
        Thu, 20 May 2021 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+rOdv3KCbiUqd8c0X4RWj5P62xfZFWST/dV9i1ux5cU=;
        b=rViVNkW33eI09Q16b9eoNOV7URSgw7l1JyZaIpZi5hSs1Ws1YCcu8vrnrOiWJ+AKz9
         sAHS8ho3n+vvdPBqeYaViZj9WDy//M8yZAHFyTnXs9aASvQ1cfE+wP0IephC8JK1KDU8
         +Cb0VmpoUAt3PxD6zvfjPkGeVN3Q9L9OmtYZex9TGaPtfpvGg/wjYD7KXtwnpsoKWtIi
         MU4JBUJdKPll7+nbn9NbCjsgTbgS4Ao/ZIjbokoiAHMV3RArlZHIbOCG81uewniq9RJH
         CIlRVadEzj6tkNlBTMd6LhFAhkJexIwVU0HHRzUpqkk28c6mGV8SVUqdIZMC/4Ytq/jP
         WyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+rOdv3KCbiUqd8c0X4RWj5P62xfZFWST/dV9i1ux5cU=;
        b=ppBl9KsIo4OAITujluKBGUExecJWFAng5DI9Z3oOXp8YHe2v3HiQ0YtM+V+BYZY7mf
         4D27jd9ZOkXSANhJwjy5eUzGXS9Hpu6nP5oWKBb0C5DIcd2tYIHSCM2SNVo7AglUeAxN
         WrcXw9MtZ7ixwwiCTNPV83/nKd6McIxPvAMI5Zti3xvuvJ0nVvgqKvECnLEGL1O2eocX
         jXcyUAiGinuC4BPVNshJwBTkBlu1E7WXZr1OcfNfR7nWTviyI2swqD/dsLaFaGzdpu2r
         ISJYefLcP6dj5wt3PwkptxwIYHKs1jkUVqceJ7sc8Lg52MxDX/TN7M1+osrXIAxiQc5p
         onEQ==
X-Gm-Message-State: AOAM530wKtznaQxt/L6ep0L2FmoEL2rP/VZOkT8p3FUM3zbtzAhcrD19
        qul3KACDgNYuHCCn3Rz2sL4=
X-Google-Smtp-Source: ABdhPJyLPLLmdyBirFVZH929Ha5LVQZZMccLL7QdF84RzeWpqUovUNhhouA4eTKFHHQouKxrBE2vYA==
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr3802773ejc.292.1621502310300;
        Thu, 20 May 2021 02:18:30 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id n8sm1069746ejl.0.2021.05.20.02.18.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 May 2021 02:18:29 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] ARM: dts: rockchip: move mmc aliases to board dts on rk3066/rk3188
Date:   Thu, 20 May 2021 11:18:22 +0200
Message-Id: <20210520091822.28491-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Arnd Bergmann, the newly added mmc aliases
should be board specific, so move them from the general dtsi
to the individual boards.

Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts   | 5 +++++
 arch/arm/boot/dts/rk3066a-marsboard.dts  | 4 ++++
 arch/arm/boot/dts/rk3066a-mk808.dts      | 5 +++++
 arch/arm/boot/dts/rk3066a-rayeager.dts   | 6 ++++++
 arch/arm/boot/dts/rk3188-bqedison2qc.dts | 6 ++++++
 arch/arm/boot/dts/rk3188-px3-evb.dts     | 5 +++++
 arch/arm/boot/dts/rk3188-radxarock.dts   | 4 ++++
 arch/arm/boot/dts/rk3xxx.dtsi            | 3 ---
 8 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index eba7a1344..390aa33cd 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -12,6 +12,11 @@
 	model = "bq Curie 2";
 	compatible = "mundoreader,bq-curie2", "rockchip,rk3066a";
 
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+	};
+
 	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
index 6b121658d..a66d915aa 100644
--- a/arch/arm/boot/dts/rk3066a-marsboard.dts
+++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
@@ -10,6 +10,10 @@
 	model = "MarsBoard RK3066";
 	compatible = "haoyu,marsboard-rk3066", "rockchip,rk3066a";
 
+	aliases {
+		mmc0 = &mmc0;
+	};
+
 	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
diff --git a/arch/arm/boot/dts/rk3066a-mk808.dts b/arch/arm/boot/dts/rk3066a-mk808.dts
index 5fe74c097..a90729f6c 100644
--- a/arch/arm/boot/dts/rk3066a-mk808.dts
+++ b/arch/arm/boot/dts/rk3066a-mk808.dts
@@ -10,6 +10,11 @@
 	model = "Rikomagic MK808";
 	compatible = "rikomagic,mk808", "rockchip,rk3066a";
 
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
index a73e8900c..12b2e59ae 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
@@ -11,6 +11,12 @@
 	model = "Rayeager PX2";
 	compatible = "chipspark,rayeager-px2", "rockchip,rk3066a";
 
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mmc2 = &emmc;
+	};
+
 	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x40000000>;
diff --git a/arch/arm/boot/dts/rk3188-bqedison2qc.dts b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
index 66a0ff196..85d3fce01 100644
--- a/arch/arm/boot/dts/rk3188-bqedison2qc.dts
+++ b/arch/arm/boot/dts/rk3188-bqedison2qc.dts
@@ -13,6 +13,12 @@
 	model = "BQ Edison2 Quad-Core";
 	compatible = "mundoreader,bq-edison2qc", "rockchip,rk3188";
 
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &mmc1;
+		mmc2 = &emmc;
+	};
+
 	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x80000000>;
diff --git a/arch/arm/boot/dts/rk3188-px3-evb.dts b/arch/arm/boot/dts/rk3188-px3-evb.dts
index c32e1d441..39c60426c 100644
--- a/arch/arm/boot/dts/rk3188-px3-evb.dts
+++ b/arch/arm/boot/dts/rk3188-px3-evb.dts
@@ -11,6 +11,11 @@
 	model = "Rockchip PX3-EVB";
 	compatible = "rockchip,px3-evb", "rockchip,px3", "rockchip,rk3188";
 
+	aliases {
+		mmc0 = &mmc0;
+		mmc1 = &emmc;
+	};
+
 	chosen {
 		stdout-path = "serial2:115200n8";
 	};
diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index b0fef82c0..36c0945f4 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -11,6 +11,10 @@
 	model = "Radxa Rock";
 	compatible = "radxa,rock", "rockchip,rk3188";
 
+	aliases {
+		mmc0 = &mmc0;
+	};
+
 	memory@60000000 {
 		device_type = "memory";
 		reg = <0x60000000 0x80000000>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index d473552e8..f9bbc2424 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -21,9 +21,6 @@
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
-		mshc0 = &emmc;
-		mshc1 = &mmc0;
-		mshc2 = &mmc1;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
-- 
2.11.0

