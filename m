Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B790E35FA61
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhDNSLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbhDNSKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:10:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C17C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:10:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id lt13so1834748pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mI3v9C6yt88wS1LOwc+lCFsWHWVb8SG6Vub87KGmR58=;
        b=B3hrTTPLVyE/N8boQ+fUoZnC4axz4x0q8T4PUrXOm4hzoFHF1sQ1aCqlDtkkjVg0rI
         n/dBPmkx/FZL4Ah3ASElJuCt3NwIgLN1M61TR86whK4hzADm/IK//67/SZc3lWocqdYd
         zcJwSgUvp1zaqMNL16hudoiYYZLr17faZs/KQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mI3v9C6yt88wS1LOwc+lCFsWHWVb8SG6Vub87KGmR58=;
        b=LfZt8uSBp+eJh9uyQWx8sx9HvJAVG3xvQHQ5WNiLcIP2ixXWwPWM3t3TI6dPIJapk3
         BSv+fPQL6Zs4OZXHJDBfLZPxJ/8W65Q7xqPoFddhE/u+CpQApDfEw8XRn2wLOo4nmZGc
         56w2wmOnhzvjrNcMWy8aEJoPV/3PVm+UWDNCtCmFeUg8nG5mkp+MYHO69ggq1J21SAG5
         QRFOVr1k3MVEknbB65bnhwE5WMfCZRXBtgWM9Y5YWQH3Kpago1iMMsxYZJB8JW8W5Alr
         /SuVAFV+mXd8twmHBFa6kouoJWjSeyCPltwH9BlF44HRZqQkrr/IfAuWnG6Hv2YpxdXl
         n1iQ==
X-Gm-Message-State: AOAM531RV5dZjIVTPoQCAObc2L2FN8vRYVVlZq0glL4AlEai8apd/ANN
        7cXU8CBG/v94mPHsTRY92aa1MQ==
X-Google-Smtp-Source: ABdhPJyoC5OqM9JR8Y4VvGkxSm8nglCKaVoCJG3w0pq+uPHsx3z/VZP09coiwWhunb2zt4H5egESzA==
X-Received: by 2002:a17:903:114:b029:eb:3963:9d1a with SMTP id y20-20020a1709030114b02900eb39639d1amr8564248plc.79.1618423833013;
        Wed, 14 Apr 2021 11:10:33 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:9c75:7205:3ec1:5280])
        by smtp.gmail.com with UTF8SMTPSA id a9sm104421pfo.186.2021.04.14.11.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 11:10:32 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v1] arm64: dts: qcom: sc7180: coachz: Add thermal config for skin temperature
Date:   Wed, 14 Apr 2021 11:10:26 -0700
Message-Id: <20210414111007.v1.1.I1a438604a79025307f177347d45815987b105cb5@changeid>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ADC and thermal monitor configuration for skin temperature,
plus a thermal zone that monitors the skin temperature and uses
the big cores as cooling devices.

CoachZ rev1 is stuffed with an incompatible thermistor for the
skin temperature, disable the thermal zone for rev1 to avoid
the use of bogus temperature values.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 .../dts/qcom/sc7180-trogdor-coachz-r1.dts     |  9 +++
 .../boot/dts/qcom/sc7180-trogdor-coachz.dtsi  | 63 +++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
index 86619f6c1134..80bdc4d5b523 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dts
@@ -14,6 +14,15 @@ / {
 	compatible = "google,coachz-rev1", "qcom,sc7180";
 };
 
+/*
+ * CoachZ rev1 is stuffed with a 47k NTC as thermistor for skin temperature,
+ * which currently is not supported by the PM6150 ADC driver. Disable the
+ * skin temperature thermal zone to avoid using bogus temperature values.
+ */
+&skin_temp_thermal {
+	status = "disabled";
+};
+
 &tlmm {
 	gpio-line-names = "HUB_RST_L",
 			  "AP_RAM_ID0",
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index e2ffe71c2d52..cabe5d6b981b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -25,6 +25,50 @@ adau7002: audio-codec-1 {
 		IOVDD-supply = <&pp1800_l15a>;
 		#sound-dai-cells = <0>;
 	};
+
+	thermal-zones {
+		skin_temp_thermal: skin-temp-thermal {
+			polling-delay-passive = <250>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm6150_adc_tm 1>;
+			sustainable-power = <814>;
+
+			trips {
+				skin_temp_alert0: trip-point0 {
+					temperature = <42000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				skin_temp_alert1: trip-point1 {
+					temperature = <45000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				skin-temp-crit {
+					temperature = <60000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&skin_temp_alert0>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&skin_temp_alert1>;
+					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
 };
 
 &ap_spi_fp {
@@ -77,6 +121,25 @@ &panel {
 	compatible = "boe,nv110wtm-n61";
 };
 
+&pm6150_adc {
+	skin-temp-thermistor@4e {
+		reg = <ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time = <200>;
+	};
+};
+
+&pm6150_adc_tm {
+	status = "okay";
+
+	skin-temp-thermistor@1 {
+		reg = <1>;
+		io-channels = <&pm6150_adc ADC5_AMUX_THM2_100K_PU>;
+		qcom,ratiometric;
+		qcom,hw-settle-time-us = <200>;
+	};
+};
+
 &pp3300_dx_edp {
 	gpio = <&tlmm 67 GPIO_ACTIVE_HIGH>;
 };
-- 
2.31.1.295.g9ea45b61b8-goog

