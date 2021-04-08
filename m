Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B1358ABC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 19:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhDHRF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhDHRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 13:05:26 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E3FC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 10:05:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso3539622pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aEvUk+4RWmRs7+anXOJcYXF+5/SqZAT4E83Z4Y0Mxhw=;
        b=cY894oX0l5yGF8xq8wA4enwi7hsDoD/52Puo7/vHdGfiY1dMWqEahF+bwfanND/VvZ
         ClVfGPZEK1yVVb6VhI33IgT6/vVzLhsorKCrIxvZRkXjxtLoKo/CQkvRcbQurb5ZIHFV
         63N5KeZ68h9I4oIW/tV3PEX6DtzYgHPMMIleHIXeh+2m5HS6LG9gVNMZF5cbvOrddOHD
         42Er5eqr4bBemv2uTeuppDQEIunoXqg4sTnSE8Sz1MRzUNeanO1IHyMcxhtR7IRMC99A
         hn9WI+SMu/EqUW1ZoC4gED/Fu7anq9pKBFt986xMXaUmyDUiYokyVMJEZBWO89W86JFB
         q6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aEvUk+4RWmRs7+anXOJcYXF+5/SqZAT4E83Z4Y0Mxhw=;
        b=awll7qNN4vIjgbi0v/pi9i6Wo/LtYbu3QE6RpACwO0W2PGGETAKT8HlnVFWy53KTU4
         YMzWNzdAsXrQQCEqdwYgm7HABXYr69e+5Pkey+0b6oiP0EXWztqBUqfVEiie5Da3/R3J
         L7EtJIOSYYngNqbj/o2KeGU2PMgf1TCfiZlTC8aGn062hnT67NV0GEnZC1YovUisfi1x
         YNYCBbDq6eu2T8w0kTWze2yabqfktD86Rv4wui/w3x99/7fGq6jLBPKZ8/9W7DUU3g+v
         /E/2Q+91pkp9ICKb4tNYE7sPUQCH0VHBoZKMLqUsq5N3qZLUMVpmEIsx/hss/Wej08AO
         VHOw==
X-Gm-Message-State: AOAM5315KUDoyfyNS0Tk85kVYrPh6kNUIY6Nwa68r4CQCIGM9Vnltilt
        z6IZLuFumb5QFvq6Ssbw83opkvDIzpKB
X-Google-Smtp-Source: ABdhPJx+OgKHmRgRR4xp+qsv7pd8V8aPB2Y/KMBQYusYWcDBOksxbQXfyqZ3wtMB5/Rzx4PFrb2Cvw==
X-Received: by 2002:a17:902:b7c5:b029:e8:fdfa:4e0 with SMTP id v5-20020a170902b7c5b02900e8fdfa04e0mr8675184plz.35.1617901514676;
        Thu, 08 Apr 2021 10:05:14 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.191])
        by smtp.gmail.com with ESMTPSA id y194sm65183pfb.21.2021.04.08.10.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 10:05:14 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 02/15] ARM: dts: qcom: sdx55: Add support for APCS block
Date:   Thu,  8 Apr 2021 22:34:44 +0530
Message-Id: <20210408170457.91409-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
References: <20210408170457.91409-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The APCS block on SDX55 acts as a mailbox controller and also provides
clock output for the Cortex A7 CPU.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 41c90f598359..8112a5283ce2 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -360,6 +360,15 @@ a7pll: clock@17808000 {
 			#clock-cells = <0>;
 		};
 
+		apcs: mailbox@17810000 {
+			compatible = "qcom,sdx55-apcs-gcc", "syscon";
+			reg = <0x17810000 0x2000>;
+			#mbox-cells = <1>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>, <&a7pll>, <&gcc GPLL0>;
+			clock-names = "ref", "pll", "aux";
+			#clock-cells = <0>;
+		};
+
 		watchdog@17817000 {
 			compatible = "qcom,apss-wdt-sdx55", "qcom,kpss-wdt";
 			reg = <0x17817000 0x1000>;
-- 
2.25.1

