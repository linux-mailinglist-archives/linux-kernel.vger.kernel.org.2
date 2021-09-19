Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ACD410D50
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 22:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhISUbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 16:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbhISUbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 16:31:16 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2F6C061574;
        Sun, 19 Sep 2021 13:29:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m26so14334075pff.3;
        Sun, 19 Sep 2021 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JzpZaRn8s17gz8hdOcowBcPP+A1zOX5vRaz564FsmJ0=;
        b=nbokdqW2NO/QctBqRLw05eYwij25GHtZvee97asZqoDzFH88t/A85gMntdYxuKfQ25
         3CXV48uzVbhk+MZ0o6vgW9E5sCaMObR0Has+viTu2SPQ2/1dIqpQbgn2FvSWJwO3CvAM
         TxtKa0JSHqosTSWsS4HQem/QM26P5k3mswV6/Czf6ozJUmh2wBzeL6qXnsIGOj/uFgZZ
         MKlLeq0AINf6grFh9vL88YiqxH48tf/XqNktmNNoti1PoKkccdjHTNoJyNAO9aiDD1ok
         Kx+BLtT0SE3/ppUEpOkGR1wXFqJD7rcJyYvNoCBN3YV/hN3Pc6WzIf5MGNO0/a5eF8yC
         17/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JzpZaRn8s17gz8hdOcowBcPP+A1zOX5vRaz564FsmJ0=;
        b=Pj18Ngbm6HZyMFKqFrJACHExWRXqpQ8SM8/H1ZvV5KxMrvQJsa+TvEgTTEUwVxAt+1
         Ugf2p6l/4B9+YDRUDbo02V6hd33WFQcM7iQ7T2km5cYvTWBjzNva4MKzbCHRh4/LdXeA
         2bSJWKj0wo2syTQI+yQQMkCw5nj4bP8ES66tTbmrZu0htujS2fYPjU0ZVxY1wx+CbDL3
         dueeudXESSqipfbKDV3f3hFAyoX1AspOQ3KCMgpiREiV6StPAC89EZsj6O8UuUEvtgQX
         XIYyMQIE2gxyd1mfHVffDt79NdKVY3NEqMhwUI6V0Vqr/MM5i3VZXXlwPY5pSIGgFDPm
         vXQQ==
X-Gm-Message-State: AOAM530sdepuqrJUiw9D0UriMihbKhHkIt41omivujCLEQpeLtFCUvKw
        dEvDQbdr6JUZUWJXOLJCfIw=
X-Google-Smtp-Source: ABdhPJygvideB8trEIk/iGCOisO2WPAxvyxpXD78sPwk/NZhzoNjhU43gXGqfrShtuBWvUpuZuujJw==
X-Received: by 2002:a63:4e65:: with SMTP id o37mr20655712pgl.202.1632083390037;
        Sun, 19 Sep 2021 13:29:50 -0700 (PDT)
Received: from archl-c2lm.. ([103.51.72.29])
        by smtp.gmail.com with ESMTPSA id z11sm12663684pff.144.2021.09.19.13.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 13:29:49 -0700 (PDT)
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
Subject: [PATCHv2 2/3] arm64: dts: meson-g12b: Fix the pwm regulator supply properties
Date:   Sun, 19 Sep 2021 20:29:10 +0000
Message-Id: <20210919202918.3556-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919202918.3556-1-linux.amoon@gmail.com>
References: <20210919202918.3556-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enabling CONFIG_REGULATOR_DEBUG=y we observer below debug logs.
Changes help link VDDCP_A and VDDCPU_B pwm regulator to 12V regulator
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

Fixes: c6d29c66e582 ("arm64: dts: meson-g12b-khadas-vim3: add initial device-tree")
Fixes: d14734a04a8a ("arm64: dts: meson-g12b-odroid-n2: enable DVFS")
Fixes: 3cb74db9b256 ("arm64: dts: meson: convert ugoos-am6 to common w400 dtsi")

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi   | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi        | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index f42cf4b8af2d..16dd409051b4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -18,7 +18,7 @@ vddcpu_a: regulator-vddcpu-a {
 		regulator-min-microvolt = <690000>;
 		regulator-max-microvolt = <1050000>;

-		vin-supply = <&dc_in>;
+		pwm-supply = <&dc_in>;

 		pwms = <&pwm_ab 0 1250 0>;
 		pwm-dutycycle-range = <100 0>;
@@ -37,7 +37,7 @@ vddcpu_b: regulator-vddcpu-b {
 		regulator-min-microvolt = <690000>;
 		regulator-max-microvolt = <1050000>;

-		vin-supply = <&vsys_3v3>;
+		pwm-supply = <&vsys_3v3>;

 		pwms = <&pwm_AO_cd 1 1250 0>;
 		pwm-dutycycle-range = <100 0>;
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
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
index feb088504740..b40d2c1002c9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-w400.dtsi
@@ -96,7 +96,7 @@ vddcpu_a: regulator-vddcpu-a {
 		regulator-min-microvolt = <721000>;
 		regulator-max-microvolt = <1022000>;

-		vin-supply = <&main_12v>;
+		pwm-supply = <&main_12v>;

 		pwms = <&pwm_ab 0 1250 0>;
 		pwm-dutycycle-range = <100 0>;
@@ -115,7 +115,7 @@ vddcpu_b: regulator-vddcpu-b {
 		regulator-min-microvolt = <721000>;
 		regulator-max-microvolt = <1022000>;

-		vin-supply = <&main_12v>;
+		pwm-supply = <&main_12v>;

 		pwms = <&pwm_AO_cd 1 1250 0>;
 		pwm-dutycycle-range = <100 0>;
--
2.33.0

