Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D587939C2BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 23:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhFDVoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 17:44:07 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:42705 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbhFDVoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 17:44:06 -0400
Received: by mail-pl1-f169.google.com with SMTP id v13so5325131ple.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FRTAz18W2yGNyYNR8dDZqf+B1AtkXbQMPRX4spNG0Mg=;
        b=LK2VZKE5FLIWBZthe4Y38Mb6m98/BgqqbCOWi7Ubdy/Ek+C4WbJHlhKYbeYe6UQxcZ
         C/mHLRa9gNbtMGYfRBeposzrO8e9oVY+ylysVbFo2ATIIpqeuuiE1c+CasMWGktjhVEN
         X7v5jlWZim7LDPcebsie6pkpRKhZvT1OfZV2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FRTAz18W2yGNyYNR8dDZqf+B1AtkXbQMPRX4spNG0Mg=;
        b=GkYXKxxBQPCtqTWjoDcODuyon96WqZWd5DdHd+I5D6XtD84gY9ieYpSOuXBusT/TRc
         AusCh448W4xYlzinLjmMn7bRcyCB1YX+xDEM39JBS3BL0sV4vKZI6Um1kyiZ0KJi0Xrj
         8eTvqEjRxVySlXwngefTrLCFX23nIEO0axuty+sD9Nza9uEMRRMbavFdSTDWI9nOI3SC
         9p2t7aGwIGtqrb2D8MU+JWwjRcNbiP51xpqyPpQhrlMkWOo3qt305cdwB6SjhJAKOox/
         FYwWzKbTKqnx0p5JNS3dQvjB6VIkcYW4qlzx768kzBpr2idnWODjt62Vgf9ArZ5peUwF
         siaQ==
X-Gm-Message-State: AOAM530qfjjW/Shhr+za6Ucb+FDbcSx0+6wVxMj4jnDu9BVuoz11BKSr
        VTSzRmpOGIfriXxte0m0UtzEAw==
X-Google-Smtp-Source: ABdhPJwFCenDqnqPboArsYhnFAXbUX/nmgSc+sJSbkeUWyJ9KvQVWLGJa6y1ZWNK2nofAtBWy7/OLQ==
X-Received: by 2002:a17:90a:1982:: with SMTP id 2mr6625235pji.185.1622842879365;
        Fri, 04 Jun 2021 14:41:19 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:1cfa:4a0b:c513:8c09])
        by smtp.gmail.com with UTF8SMTPSA id j12sm2578017pgj.14.2021.06.04.14.41.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 14:41:19 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, Peter Chen <peter.chen@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v11 5/5] arm64: dts: qcom: sc7180-trogdor: Add nodes for onboard USB hub
Date:   Fri,  4 Jun 2021 14:41:01 -0700
Message-Id: <20210604144027.v11.5.Ie0d2c1214b767bb5551dd4cad38398bd40e4466f@changeid>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
In-Reply-To: <20210604214101.3363525-1-mka@chromium.org>
References: <20210604214101.3363525-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the onboard USB hub on trogdor devices. Remove the
'always-on' property from the hub regulator, since the regulator
is now managed by the onboard_usb_hub driver.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v11:
- rebased on qcom/arm64-for-5.14 (with the rest of the series)

Changes in v10:
- keep 'regulator-boot-on' property
- updated commit message

Changes in v9:
- none

Changes in v8:
- none

Changes in v7:
- rebased on qcom/arm64-for-5.13 (with the rest of the series)

Changes in v6:
- added 'companion-hub' entry to both USB devices
- added 'vdd-supply' also to hub@2

Changes in v5:
- patch added to the series

 .../boot/dts/qcom/sc7180-trogdor-lazor-r0.dts | 19 ++++++++-----------
 .../boot/dts/qcom/sc7180-trogdor-lazor-r1.dts | 12 +++++-------
 .../arm64/boot/dts/qcom/sc7180-trogdor-r1.dts | 19 ++++++++-----------
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 19 ++++++++++++++++++-
 4 files changed, 39 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
index 30e3e769d2b4..5fb8e12af1a0 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dts
@@ -14,17 +14,6 @@ / {
 	compatible = "google,lazor-rev0", "qcom,sc7180";
 };
 
-&pp3300_hub {
-	/* pp3300_l7c is used to power the USB hub */
-	/delete-property/regulator-always-on;
-	/delete-property/regulator-boot-on;
-};
-
-&pp3300_l7c {
-	regulator-always-on;
-	regulator-boot-on;
-};
-
 &sn65dsi86_out {
 	/*
 	 * Lane 0 was incorrectly mapped on the cable, but we've now decided
@@ -33,3 +22,11 @@ &sn65dsi86_out {
 	 */
 	lane-polarities = <1 0>;
 };
+
+&usb_hub_2_0 {
+	 vdd-supply = <&pp3300_l7c>;
+};
+
+&usb_hub_3_0 {
+	 vdd-supply = <&pp3300_l7c>;
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
index c2ef06367baf..1dae714250f5 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dts
@@ -14,13 +14,11 @@ / {
 	compatible = "google,lazor-rev1", "google,lazor-rev2", "qcom,sc7180";
 };
 
-&pp3300_hub {
-	/* pp3300_l7c is used to power the USB hub */
-	/delete-property/regulator-always-on;
-	/delete-property/regulator-boot-on;
+
+&usb_hub_2_0 {
+	 vdd-supply = <&pp3300_l7c>;
 };
 
-&pp3300_l7c {
-	regulator-always-on;
-	regulator-boot-on;
+&usb_hub_3_0 {
+	 vdd-supply = <&pp3300_l7c>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
index 2b522f9e0d8f..2f5263e3d1b9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dts
@@ -42,17 +42,6 @@ &panel {
 	compatible = "auo,b116xa01";
 };
 
-&pp3300_hub {
-	/* pp3300_l7c is used to power the USB hub */
-	/delete-property/regulator-always-on;
-	/delete-property/regulator-boot-on;
-};
-
-&pp3300_l7c {
-	regulator-always-on;
-	regulator-boot-on;
-};
-
 &sdhc_2 {
 	status = "okay";
 };
@@ -61,6 +50,14 @@ &trackpad {
 	interrupts = <58 IRQ_TYPE_EDGE_FALLING>;
 };
 
+&usb_hub_2_0 {
+	 vdd-supply = <&pp3300_l7c>;
+};
+
+&usb_hub_3_0 {
+	 vdd-supply = <&pp3300_l7c>;
+};
+
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &trackpad_int_1v8_odl {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index a4cbdc36c306..3345ca650a4c 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -202,7 +202,6 @@ pp3300_hub: pp3300-hub {
 		pinctrl-names = "default";
 		pinctrl-0 = <&en_pp3300_hub>;
 
-		regulator-always-on;
 		regulator-boot-on;
 
 		vin-supply = <&pp3300_a>;
@@ -903,6 +902,24 @@ &usb_1 {
 
 &usb_1_dwc3 {
 	dr_mode = "host";
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* 2.0 hub on port 1 */
+	usb_hub_2_0: hub@1 {
+		compatible = "usbbda,5411";
+		reg = <1>;
+		vdd-supply = <&pp3300_hub>;
+		companion-hub = <&usb_hub_3_0>;
+	};
+
+	/* 3.0 hub on port 2 */
+	usb_hub_3_0: hub@2 {
+		compatible = "usbbda,411";
+		reg = <2>;
+		vdd-supply = <&pp3300_hub>;
+		companion-hub = <&usb_hub_2_0>;
+	};
 };
 
 &usb_1_hsphy {
-- 
2.32.0.rc1.229.g3e70b5a671-goog

