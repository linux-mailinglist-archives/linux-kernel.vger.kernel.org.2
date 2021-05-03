Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA30371760
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 17:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhECPCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 11:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhECPCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 11:02:04 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF455C061761;
        Mon,  3 May 2021 08:01:10 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p4so4378687pfo.3;
        Mon, 03 May 2021 08:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YzG6TYaBk4Qe9UbFXrh/j9QrDTmla6rvT2wheqgzLQs=;
        b=gNv0dT9iqEmA1FbX2ZnULrP0GwUvez39zyRMZtvZRoGxoTXvfIYG7xug/dwu27ruvv
         07GcoeS4p+Wjhw2ZXBDWwJBvJlxCH8DfsEu3mtxrl8uDcr/jiz+U2N9KgzQlQ0Yd+o2p
         UvHDSQGO/3uWY4Y5mv7ty0OzyBNPkfVdgzEuVZzryXipNjpqueXAm7eSa6cNfndkUr8s
         i8qDvM2GWGJR8uhSui4kUJsb2WoltKrFkMbnGNxo0tkGJeGHsQH5fAP3lqJI9OuNJ+95
         znoYwTT6N6dcRW7/2oQ/ZCorJSfBuky3wNKd8vaNczLsUQeHr/utmUjAasrCFCvT94Av
         TACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YzG6TYaBk4Qe9UbFXrh/j9QrDTmla6rvT2wheqgzLQs=;
        b=JZ0cN90aHy9wPcGpYgrc6Onobm+Ve0ai7i5QwkHKoVfbIqlKlQ/6Kb7U6XJkBWS79w
         4gLSZaO7Qvg/bvy2a5frfETu8gmFoesvZwIwlA4qH2sHU02kTlX4mKSQuabOBkCvPUci
         4zaWkslL61gF0kmzrwUjqJ2E2ZKiGABQjTEItA38ifx1JJ8CDnWqSL48C/XhVkkRy3E3
         YKOjjS3eUmWYTgo3REYRjpbtPJbj1Hyw8Qt7OmUMYoJaXsefoUBzK2MnEU11vAaTDUv0
         FK0psruNmTKn+lAwr5TlqTHn8FC3PCRJ/hld6PJGP9NlZFenYLjbMJBXBTF/O7vwJAtd
         nPKQ==
X-Gm-Message-State: AOAM532DPuHXxQztF2tfDA4A0k6WPvDYGmYiUINyMHyjuFdrCpsTKGLg
        dLs5LpGrOBC4eNiHbgLA5AOL/iVIg9M=
X-Google-Smtp-Source: ABdhPJwcFkN18aNRaGLRVRuH+apJNsXdOiZbqkCT0QVIRODxLq4T1QwXn1UM8TIy/L+SDchtZj7wcQ==
X-Received: by 2002:aa7:8097:0:b029:229:83ec:cac0 with SMTP id v23-20020aa780970000b029022983eccac0mr18926519pff.67.1620054069894;
        Mon, 03 May 2021 08:01:09 -0700 (PDT)
Received: from archl-on2.. ([103.51.75.154])
        by smtp.gmail.com with ESMTPSA id k38sm3593983pgi.73.2021.05.03.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 08:01:08 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCHv1 9/9] arm64: dts: amlogic: Add hdmi power domain for gxbb and gxl
Date:   Mon,  3 May 2021 14:54:42 +0000
Message-Id: <20210503145503.1477-10-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503145503.1477-1-linux.amoon@gmail.com>
References: <20210503145503.1477-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hdmi power domain id for hdmi on gxbb and gxl and gxm sbc
to enable hdmi power domain, via "pwrc" controller.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi          | 1 +
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi             | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts            | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts          | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts             | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi                | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi            | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi               | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts    | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts            | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts            | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts      | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts    | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts     | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts            | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts           | 1 +
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts             | 1 +
 18 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
index 2d7032f41e4b..272e54be0365 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
@@ -311,6 +311,7 @@ &hdmi_tx {
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
 	hdmi-supply = <&vcc5v>;
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index dafc841f7c16..c9f17174436f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -220,6 +220,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 	hdmi-supply = <&hdmi_5v>;
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 7273eed5292c..6b5330344b94 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -219,6 +219,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index f887bfb445fd..569b32f9e8e7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -222,6 +222,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 201596247fd9..344834f6c475 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -269,6 +269,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 	hdmi-supply = <&hdmi_p5v0>;
 };
 
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index e803a466fe4e..b747cdc6ede8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -132,6 +132,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 9b0b81f191f1..ae10bd4cb858 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -140,6 +140,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index a350fee1264d..609544efd742 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -161,6 +161,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
index 2d769203f671..f8cd86c13765 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
@@ -209,6 +209,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
index eb7f5a3fefd4..ec38ca9a6818 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts
@@ -136,6 +136,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
index b2ab05c22090..b0707382da30 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
@@ -95,6 +95,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 60feac0179c0..0266a14c428c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -116,6 +116,7 @@ &hdmi_tx {
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
 	hdmi-supply = <&hdmi_5v>;
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
index 93d8f8aff70d..bd3be5a2f4bf 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
@@ -224,6 +224,7 @@ &hdmi_tx {
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	hdmi-supply = <&vcc5v>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 82bfabfbd39c..8f6fdcf8466b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -229,6 +229,7 @@ &hdmi_tx {
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
 	hdmi-supply = <&hdmi_5v>;
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
index f1acca5c4434..5837114368b5 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts
@@ -127,6 +127,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
index 2602940c2077..b951cd767c30 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts
@@ -52,6 +52,7 @@ &hdmi_tx {
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
 	hdmi-supply = <&hdmi_5v>;
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 18a4b7a6c5df..64ccf599fc76 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -246,6 +246,7 @@ &hdmi_tx {
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
 	hdmi-supply = <&hdmi_5v>;
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index dfa7a37a1281..c64d1fcda299 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -121,6 +121,7 @@ &hdmi_tx {
 	status = "okay";
 	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
 	pinctrl-names = "default";
+	power-domains = <&pwrc PWRC_GXBB_HDMI_ID>;
 };
 
 &hdmi_tx_tmds_port {
-- 
2.31.1

