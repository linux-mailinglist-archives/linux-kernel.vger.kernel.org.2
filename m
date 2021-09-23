Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B344161AE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241917AbhIWPFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241891AbhIWPFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:05:35 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB8FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:04:04 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 97-20020a9d006a000000b00545420bff9eso8870968ota.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n99BUgoHnMCoEPxOhcp9LGegqDHiYuqfxJkhhRVvExs=;
        b=UTPrb+fiXjsf5mEl41UjIo1i3V3rhi3Z60Zm0dr+pCW/ysLFmtAiRlHYJT/VkE4W00
         jzhiytM2R2I6boM967PGJemYBW/U98w7W0E+0xSM5wUWHTp7o+YIWX6mfpUnMkVoUGmg
         6Q1yuMtq30crpVPM2zb0e1xGg5vmumw0EiK7tKzNBc3EdGaG/TQv96axydwVo/frVUhH
         utPCHtwWw5Git42T+3ZLKcAsFue6r6Mivx0kn/YepjXftgtnCm+8bj+TZPOASiLhnCdl
         /q3HdMyJtokd8cNi87F3mAoVC6ab3sNddTYEceEMs6WhGwjyHz14MJpE2KfODwezbrdj
         wHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n99BUgoHnMCoEPxOhcp9LGegqDHiYuqfxJkhhRVvExs=;
        b=7NIGujgFKznIheMzlcxjoDFr01nme9Rc8QhWi45r00aczjSkYXn6s5EqbfLHJQQ+Hw
         ffGP+gtFycNZLEVrSWvY/XEIuvPHhn37fqq5RqOllabtwTG0POCzt+Be0F5dBLq6T6Tc
         uHEypPwQBAxlhn3zQPfhAeq9jQyvf/L8JIuBVjEULWO4uFtoBnhpSanGE5+FzYTpaheJ
         MUicBsuHWV+byWySnR92Y3Libz3W9pH4XU3iD8WTRIzC0+RTaRf/KHwhmofaempi9Oq8
         XPEgvIs07xav4Jp9o0UTEvbaUgOvM9xWK1IQO5qTwy2Z1OoRWvEsvSRwLoq/Hu3pUjY7
         c60w==
X-Gm-Message-State: AOAM5324cT1m+vURLxxcAaHbZrVNAHqID78xXsntuuPnTm2BrOTfcEjJ
        BR3f1i9ZtmHix6yXd9F5j+BEfg==
X-Google-Smtp-Source: ABdhPJw2Ehvj6quxBELFlvg6Vn3bA7DsrbQr8GXGJ8MaKkvRxnHIOW7/C4X8MsAPrtNsjyXJLkpQqw==
X-Received: by 2002:a05:6830:1f11:: with SMTP id u17mr525356otg.151.1632409443530;
        Thu, 23 Sep 2021 08:04:03 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a11sm1329657oiw.36.2021.09.23.08.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 08:04:02 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sdm845: mtp: Add vadc channels
Date:   Thu, 23 Sep 2021 08:04:40 -0700
Message-Id: <20210923150440.2726049-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Downstream defines four ADC channels related to thermal sensors external
to the PM8998 and two channels for internal voltage measurements. Add
these to the upstream SDM845 MTP as well.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-mtp.dts | 34 +++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
index 52dd7a858231..28a2f5d46db7 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
@@ -10,6 +10,8 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include "sdm845.dtsi"
+#include "pm8998.dtsi"
+#include "pmi8998.dtsi"
 
 / {
 	model = "Qualcomm Technologies, Inc. SDM845 MTP";
@@ -469,6 +471,38 @@ &mss_pil {
 	firmware-name = "qcom/sdm845/mba.mbn", "qcom/sdm845/modem.mbn";
 };
 
+&pm8998_adc {
+	adc-chan@4c {
+		reg = <ADC5_XO_THERM_100K_PU>;
+		label = "xo_therm";
+	};
+
+	adc-chan@4d {
+		reg = <ADC5_AMUX_THM1_100K_PU>;
+		label = "msm_therm";
+	};
+
+	adc-chan@4f {
+		reg = <ADC5_AMUX_THM3_100K_PU>;
+		label = "pa_therm1";
+	};
+
+	adc-chan@51 {
+		reg = <ADC5_AMUX_THM5_100K_PU>;
+		label = "quiet_therm";
+	};
+
+	adc-chan@83 {
+		reg = <ADC5_VPH_PWR>;
+		label = "vph_pwr";
+	};
+
+	adc-chan@85 {
+		reg = <ADC5_VCOIN>;
+		label = "vcoin";
+	};
+};
+
 &qupv3_id_1 {
 	status = "okay";
 };
-- 
2.29.2

