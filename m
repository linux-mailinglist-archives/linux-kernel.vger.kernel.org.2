Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3BD398F94
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 18:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbhFBQII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 12:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbhFBQIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 12:08:07 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEF6C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 09:06:23 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e22so2611203pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 09:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bGVJ1fEqd+Kmtn4CZUiicvmSxzhYZxgsSiEwCJsJFPs=;
        b=gaKK+caiwwpAV1acAj90mEj+I+G3WF84YlHQoghHtaMb21r1BPmcOdmERodSw7gckN
         v+rrAMqvANdGQ9qsYyLdAMup2LVONj2nqhjUPhtvOzKSVIP7ROgIHsc4qy4Rq4IQQGo3
         cho/IKi31EFebhHza+L5urNVrf3jB6bn7CgVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bGVJ1fEqd+Kmtn4CZUiicvmSxzhYZxgsSiEwCJsJFPs=;
        b=HcCfmhFqVNl6VCBn2qKkXvff1HkZtyRHDtHzwflumRMMtCfkzKfVTUX8uQLjBmkV4B
         l5aCuKY7nDEHJns3K5FN7Z3YkglkHjY+g9WctXPbvF4cvCjdLDlcl/+gQrUfhT9IANHN
         yZb8G40XQsucvAmyqskqE/l/dAavAFaajhuvFvhWS48XgRj7BTBUZgV2NAFeY6+TLjKN
         lqLRvk5SQenTCya4Bn4w4eyE8xPICQFMX73DouhL+QcP1WxGg8DImF17E6YLQ6ApPChV
         hmKDpFjlNjNgDhhJDaruf4MHnXOUwg5mn8mVn60zfFA9/R79kBQBGVt2nhC49O5+Z/P1
         T+GA==
X-Gm-Message-State: AOAM5312ZNLSt82tzHaYMw8YcNGYLqiHny65wGzcIZYk9iZiZFSIWCHb
        USF2M58FqGZBV3EH6Pamqb4Q1A==
X-Google-Smtp-Source: ABdhPJyEAwrGnHc8J9VsjWkA60Q3J0sEYJly49WpAkjmIW6xj6PdM9vaVC+MXdKwGxM6v4qPP9MNcg==
X-Received: by 2002:aa7:9537:0:b029:2ea:2312:d2cb with SMTP id c23-20020aa795370000b02902ea2312d2cbmr3313322pfp.27.1622649983304;
        Wed, 02 Jun 2021 09:06:23 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d737:2805:1403:7c09])
        by smtp.gmail.com with UTF8SMTPSA id s6sm61385pjr.29.2021.06.02.09.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 09:06:22 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] arm64: dts: qcom: pm6150: Add thermal zone for PMIC on-die temperature
Date:   Wed,  2 Jun 2021 09:06:14 -0700
Message-Id: <20210602090525.1.Id4510e9e4baaa3f6c9fdd5cdf4d8606e63c262e3@changeid>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a thermal zone for the pm6150 on-die temperature. The system should
try to shut down orderly when the temperature reaches 95degC, otherwise
the PMIC will power off at 115degC.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 arch/arm64/boot/dts/qcom/pm6150.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 8ab4f1f78bbf..de7fb129f739 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -7,6 +7,30 @@
 #include <dt-bindings/spmi/spmi.h>
 #include <dt-bindings/thermal/thermal.h>
 
+/ {
+	thermal-zones {
+		pm6150_thermal: pm6150-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm6150_temp>;
+
+			trips {
+				pm6150_trip0: trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				pm6150_crit: pm6150-crit {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
 &spmi_bus {
 	pm6150_lsid0: pmic@0 {
 		compatible = "qcom,pm6150", "qcom,spmi-pmic";
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

