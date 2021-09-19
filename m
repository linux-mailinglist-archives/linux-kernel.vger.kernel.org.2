Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84C6410D52
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 22:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhISUb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 16:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhISUb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 16:31:26 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8149C061574;
        Sun, 19 Sep 2021 13:30:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m26so14334330pff.3;
        Sun, 19 Sep 2021 13:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hfIkUcLEpAlJWRlXvHOKy1ap9NrTUyjC7y9+3wsR1OA=;
        b=qTKnNrQcc1V082Uk593E1H8b2cbkKLLFeIqE1SAKBmZL1FearWgZKd5TlAy8wQiO7J
         a1qvKkQRDd0JBXotGo1yv+CgH4NNQx/92bIlS57U8jJtExjmq6EhHqKqi3wkpEQ7xob0
         qoW6KJeqtAP5LX2qph52tFIb0JAqtmbU3VuDJGu4ClZvrqe3F1YVSNvHrdfiVMZtaHHm
         HA5Ii8rXfQnvfF9roSsXLYPSoXkiIllnkeaeCHno6guVQ6RpK6oPU+Czs0aIxTBLr4Vu
         hAI07QOOvzouPMy5nIjs6y3GNG4n69CPuYvR8YYSiCeOhd1Tlc/B02eFoueZV/CeOtsx
         61ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hfIkUcLEpAlJWRlXvHOKy1ap9NrTUyjC7y9+3wsR1OA=;
        b=lM7rFhw+BzDKRTCPhEyCeKW9DSsir4PY8LYjMB7/khPsRZxr//36Yuqg0rXWgT1fDc
         zoFhprIfd9h32DthuRONg6bLHD2Xj7JQQORD78+77sYWbC5ZIp8HK5IB0CAook3PuoBG
         +6mYIWHzsWS3QhZn02ISXK9rwNJ7KqiGZYLSBsnSjRsz/UqonvwYEgBZzgrKnJRiZTBy
         r/D7drwk/pbdHMmxrUjQEXhMYb3GODXrz+cS3jxY120lWlvVMbiX6QELNNvHczikdXN3
         DUr0XUzfVTaCe9OcbiQdMCU2WmZUVicYjLILdLllMwT8FGX90Bdu65AOh448R5uTObMs
         S31Q==
X-Gm-Message-State: AOAM533XTCGnBHVumM88HYyTKsg5yAbeAdftWA8EOwd64nXkMdHGvIiz
        ie5JOMOly4u59Itj71Vmoncso8x4C7UK7A==
X-Google-Smtp-Source: ABdhPJz8GXPpRzOLEMzTHk8o9/QQIi5Ny/ABtxTMydIBJnTsucvYJiEEVzHX6rZM7gWppnYbbQUN5Q==
X-Received: by 2002:aa7:9d84:0:b0:447:c2f4:4a39 with SMTP id f4-20020aa79d84000000b00447c2f44a39mr397085pfq.86.1632083400348;
        Sun, 19 Sep 2021 13:30:00 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.29])
        by smtp.gmail.com with ESMTPSA id z11sm12663684pff.144.2021.09.19.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 13:29:59 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        devicetree@vger.kernel.org
Subject: [PATCHv2 3/3] arm64: dts: meson-sm1: Fix the pwm regulator supply properties
Date:   Sun, 19 Sep 2021 20:29:11 +0000
Message-Id: <20210919202918.3556-4-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919202918.3556-1-linux.amoon@gmail.com>
References: <20210919202918.3556-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enabling CONFIG_REGULATOR_DEBUG=y we observe below debug logs.
Changes help link VDDCPU pwm regulator to 12V regulator supply
instead of dummy regulator.

[   11.602281] pwm-regulator regulator-vddcpu: Looking up pwm-supply property
               in node /regulator-vddcpu failed
[   11.602344] VDDCPU: supplied by regulator-dummy
[   11.602365] regulator-dummy: could not add device link regulator.11: -ENOENT
[   11.602548] VDDCPU: 721 <--> 1022 mV at 1022 mV, enabled

Fixes: 88d537bc92ca ("arm64: dts: meson: convert meson-sm1-odroid-c4 to dtsi")
Fixes: 700ab8d83927 ("arm64: dts: khadas-vim3: add support for the SM1 based VIM3L")
Fixes: 3d9e76483049 ("arm64: dts: meson-sm1-sei610: enable DVFS")
Fixes: 976e920183e4 ("arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts")

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts  | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi      | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
index effaa138b5f9..212c6aa5a3b8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-bananapi-m5.dts
@@ -173,7 +173,7 @@ vddcpu: regulator-vddcpu {
 		regulator-min-microvolt = <690000>;
 		regulator-max-microvolt = <1050000>;

-		vin-supply = <&dc_in>;
+		pwm-supply = <&dc_in>;

 		pwms = <&pwm_AO_cd 1 1250 0>;
 		pwm-dutycycle-range = <100 0>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index f2c098143594..9c0b544e2209 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -24,7 +24,7 @@ vddcpu: regulator-vddcpu {
 		regulator-min-microvolt = <690000>;
 		regulator-max-microvolt = <1050000>;

-		vin-supply = <&vsys_3v3>;
+		pwm-supply = <&vsys_3v3>;

 		pwms = <&pwm_AO_cd 1 1250 0>;
 		pwm-dutycycle-range = <100 0>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
index fd0ad85c165b..f05bc9756393 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid.dtsi
@@ -116,7 +116,7 @@ vddcpu: regulator-vddcpu {
 		regulator-min-microvolt = <721000>;
 		regulator-max-microvolt = <1022000>;

-		vin-supply = <&main_12v>;
+		pwm-supply = <&main_12v>;

 		pwms = <&pwm_AO_cd 1 1250 0>;
 		pwm-dutycycle-range = <100 0>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 2194a778973f..427475846fc7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -185,7 +185,7 @@ vddcpu: regulator-vddcpu {
 		regulator-min-microvolt = <690000>;
 		regulator-max-microvolt = <1050000>;

-		vin-supply = <&dc_in>;
+		pwm-supply = <&dc_in>;

 		pwms = <&pwm_AO_cd 1 1500 0>;
 		pwm-dutycycle-range = <100 0>;
--
2.33.0

