Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394543B71F8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhF2MWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbhF2MV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:21:59 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36078C061760;
        Tue, 29 Jun 2021 05:19:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s137so9395845pfc.4;
        Tue, 29 Jun 2021 05:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbbWX3kzjiR8qd3C6tMA1iMcCJEbQrwW1wisqFEE6eo=;
        b=CiwrAGbBBkL09wtznxor+hUawt4GMD+TAkpbAhW9CEWWlP9Ru2jLMxVNUPAvfBChCv
         rYDOPDhCo5wSXqKraUIZLSKSglwd8WEurGvSpIHkP/spzMrtsm0GSPE23P/TonQ52Z/4
         qNZCTzkIVPBTyj6O1mcJbB/0Xc47w00n4H/53wgV+SvHjINdH21anWu7snAwjeS0qHWX
         +UcZJEMaUyEKk3pnGwX8HPnFCJAR5kr9tiLGEFRs+qOKTfPhr7SS8mgmHrSdNaZN7kBV
         ZBGFIzQ3efamjm7nk8QP2gCZ3TXsb8T02S/1pdavlqdD5w+S4Q2iwN4ABMIKqHOIcNUs
         c4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LbbWX3kzjiR8qd3C6tMA1iMcCJEbQrwW1wisqFEE6eo=;
        b=TvdUGLl407ZbV9hLyKK81zsb5SqXYAgBCoP3Gl8aI0Karm4V1QphrmvguRcXDO6W04
         QkHz1IvN/a8GIWcdzCMt9FajFP9ieQNrk3zA2sG1DO9324u/vBNzqOtq1WDTOtWOze4j
         /roXLbpveGt0Z+KBGPOCgtR441kJ24lsGGhzRAdYhfXpZVO9K3OhtVncmslyDBKo/9bH
         MWN6yrlEKrt5G1Tvww/JvmnB91TsZwGuTQxxEeIauyADqN8AfA9qaWrEXZgMiBV+XDef
         u8WcWKxDc8jx/6XaWkI/+4/iGKykWOQBd1u2UiLfCvbWTRmyGpuLV7KxsGI05vNElUeX
         U5qA==
X-Gm-Message-State: AOAM531bd0l+RKK4u/3PQIKdJHwFLNZq2WXT76hch8sZ0vZJCbSqm8V/
        pc8wUafuX4yzWA71HfCeT/Y=
X-Google-Smtp-Source: ABdhPJwgEWD9yoqfctTRjncqD3b1L4F/TJFDXJAVBNMjtgkexqbPnBFFhHtf1MWe8URlnVLgjXJmSA==
X-Received: by 2002:a63:df0f:: with SMTP id u15mr327288pgg.57.1624969171830;
        Tue, 29 Jun 2021 05:19:31 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.37])
        by smtp.gmail.com with ESMTPSA id gg5sm8314730pjb.42.2021.06.29.05.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 05:19:31 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org
Subject: [PATCHv1] arm64: amlogic: Fix the pwm regulator supply property in node
Date:   Tue, 29 Jun 2021 12:18:47 +0000
Message-Id: <20210629121848.6527-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On enable CONFIG_REGULATOR_DEBUG=y we observer below debug logs.
Changes help link VDDCPU_A and VDDCPU_B pwm regulator to 12V regulator
supply instead of dummy regulator.

[    4.147196] VDDCPU_A: will resolve supply early: pwm
[    4.147216] pwm-regulator regulator-vddcpu-a: Looking up pwm-supply from device tree
[    4.147227] pwm-regulator regulator-vddcpu-a: Looking up pwm-supply property in node /regulator-vddcpu-a failed
[    4.147258] VDDCPU_A: supplied by regulator-dummy
[    4.147288] regulator-dummy: could not add device link regulator.12: -ENOENT
[    4.147353] VDDCPU_A: 721 <--> 1022 mV at 871 mV, enabled
[    4.152014] VDDCPU_B: will resolve supply early: pwm
[    4.152035] pwm-regulator regulator-vddcpu-b: Looking up pwm-supply from device tree
[    4.152047] pwm-regulator regulator-vddcpu-b: Looking up pwm-supply property in node /regulator-vddcpu-b failed
[    4.152079] VDDCPU_B: supplied by regulator-dummy
[    4.152108] regulator-dummy: could not add device link regulator.13: -ENOENT

Fixes: d14734a04a8a ("arm64: dts: meson-g12b-odroid-n2: enable DVFS")

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 344573e157a7..4f33820aba1f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -130,7 +130,7 @@ vddcpu_a: regulator-vddcpu-a {
 		regulator-min-microvolt = <721000>;
 		regulator-max-microvolt = <1022000>;
 
-		vin-supply = <&main_12v>;
+		pwm-supply = <&main_12v>;
 
 		pwms = <&pwm_ab 0 1250 0>;
 		pwm-dutycycle-range = <100 0>;
@@ -149,7 +149,7 @@ vddcpu_b: regulator-vddcpu-b {
 		regulator-min-microvolt = <721000>;
 		regulator-max-microvolt = <1022000>;
 
-		vin-supply = <&main_12v>;
+		pwm-supply = <&main_12v>;
 
 		pwms = <&pwm_AO_cd 1 1250 0>;
 		pwm-dutycycle-range = <100 0>;
-- 
2.31.1

