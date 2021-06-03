Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABA9239A417
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 17:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbhFCPPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 11:15:37 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:45582 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhFCPPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 11:15:35 -0400
Received: by mail-pg1-f180.google.com with SMTP id q15so5353865pgg.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SOz7E89GO3Tlt1UETlglRkdF1+fg4j4ELIuMgr0ZBk8=;
        b=DioCg1gEzdC+P2iIV7lBStmKSH55GVSy3MLea9WvF2E88cXD21eBObuZ/qfR0TZRfr
         8c1HR+/lmhgpqzX1ruzsPtSW/6n+4fXI+dJiGmNSV2KQSpU+Bohp1ouHJ6m3d8GhIuom
         QlYDnSDRR35guvbkLtNwit1BoWqDvTQmrQ1p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SOz7E89GO3Tlt1UETlglRkdF1+fg4j4ELIuMgr0ZBk8=;
        b=rJMfNlYahdcH4KmnhgjotLPz71AVayC+Kpv/34Q+pmwKH/bhbAsh8L2phfYiuegl+b
         wvBi6YeaX7BXQavOB96zzy5YuY+jusFoCVKqm+p6+3g0hJbMxJC8Lcc5e1yIMmYzta3S
         26MWmYiLuypetgbbtDlALrIEJZWnEh/y4raBePvzo1wDWgpiohD7dMaP0XoRYA732VWr
         EgJ3pc2KhZyGHQtCs8U0TAcem3Vky24wsZedhE/PmPdx0EjqmBzDxMa1kV+rjsu1WK7U
         MWNWnIZL7ce4J/oxM7M4qUCqo9eCpW3ngWixh9c3sSVOTXmAUA80vqDEVIShFzEmIuhj
         M7cw==
X-Gm-Message-State: AOAM5338bThUigxAtIIDKrIWJt4x+c1RG25l4y2/d9g1AsOu0USSp/Vq
        uhNdHCI+V/RnO5YbQZ1eIw1K7A==
X-Google-Smtp-Source: ABdhPJyRIxzMB1dJJuGzR1hBSkiU18tcbJAKhuTSAqWm14EGEUPmzHPxxVPOf7TGbNbVrE6swQxSoQ==
X-Received: by 2002:a05:6a00:856:b029:28e:e5d2:9a62 with SMTP id q22-20020a056a000856b029028ee5d29a62mr234677pfk.17.1622733160794;
        Thu, 03 Jun 2021 08:12:40 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:d737:2805:1403:7c09])
        by smtp.gmail.com with UTF8SMTPSA id r10sm3190416pga.48.2021.06.03.08.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 08:12:40 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2] arm64: dts: qcom: pm6150: Add thermal zone for PMIC on-die temperature
Date:   Thu,  3 Jun 2021 08:12:34 -0700
Message-Id: <20210603081215.v2.1.Id4510e9e4baaa3f6c9fdd5cdf4d8606e63c262e3@changeid>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a thermal zone for the pm6150 on-die temperature. The system should
try to shut down orderly when the temperature reaches the critical trip
point at 115°C, otherwise the PMIC will perform a HW power off at 145°C.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- remove 'pm6150-' prefix from critical trip point
- updated commit message

 arch/arm64/boot/dts/qcom/pm6150.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 8ab4f1f78bbf..8a4972e6a24c 100644
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
+				pm6150_crit: crit {
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

