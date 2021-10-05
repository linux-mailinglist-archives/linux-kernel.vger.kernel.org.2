Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5A421CEC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 05:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhJEDZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 23:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhJEDZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 23:25:42 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842B1C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 20:23:52 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so24206635otj.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 20:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y5RA2wJTON98WzYl53qPa7h0i0r9iGvauGseixrJrIc=;
        b=Aa9b5NPgFHKC4wB3EjIr3h4i/9hZDOyzf3Q8MLutzyZhY721rTJ5waSU/q9Su+JK33
         og9nWMM4s5u+KqiWHuaTJ+ukcchVJyTa8/BXLnUIz7OYeGvPSFGfSWqma9rtyO6FTneT
         kRKg2FwMXTJAmZP+7Ak2LFG9z0rh1mNfAsgaMwzkHbsf9R9IpKkrLaYIZ6sihDRmBiB/
         9708xNEs/b3f3QWdUCaYmztByqSLys6pQ6Yd0TWXC7px6c/omo6HKSPdjhMG7fEhkRkP
         zcDnsqnb3N4uWiNHfwEb6s25p86Ecw1SgoMflhn9uE77fItk9PJDCROIhG1bNMXhNoiY
         cgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5RA2wJTON98WzYl53qPa7h0i0r9iGvauGseixrJrIc=;
        b=37h/6rh7b/3S6NSoKfyMjN7m+H18dABT8Xs+yyKkfbFSJpqMdZtMup0lzl3VprDxpv
         hq5pI2ZHrvMwx9cR+1PuV5ZhXK4xGf+EdZIT3LrrVzj1ClotWHFo7OcLFMZ+FGQu9Wla
         fAG9mO7iaYWd/f3LJbkqy3mLjR6AltopAhNsOCi3orAsIXZBrlt6/BO2JNEFjjvQDiby
         yKiz+zOnl2kT0pL/a4J7fv7spadbBov6+b5LQ4GrtR1vxICK6BFSeCwHCyy8liGSM3xW
         m1a8qbSBN5vr7Pf2FXKNfFkNzdVu0ufOAso5ZAYwzTQdggmFv5YovYFG8ttHLxpqLrY7
         SOsg==
X-Gm-Message-State: AOAM532qv8dfUhwsLWnP4iGzB9/S0+WqSH8v7Gh6VKqIeDfUWNBCvDQ7
        UfwEHFRzVwG/9gsTUCQBXI9zAQ==
X-Google-Smtp-Source: ABdhPJySapr/1zE5LsF59a3kyVP11LwcxvnuRGHYCpStdsF4EQ0YZ2cV0VVp78WP2loqj+923JSnVA==
X-Received: by 2002:a05:6830:18f0:: with SMTP id d16mr12549396otf.63.1633404231873;
        Mon, 04 Oct 2021 20:23:51 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id j4sm3111955oia.56.2021.10.04.20.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 20:23:51 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] arm64: dts: qcom: pm8998: Add ADC Thermal Monitor node
Date:   Mon,  4 Oct 2021 20:25:30 -0700
Message-Id: <20211005032531.2251928-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211005032531.2251928-1-bjorn.andersson@linaro.org>
References: <20211005032531.2251928-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node for the ADC Thermal Monitor found in the PM8998 PMIC. This is
used to connect thermal zones with ADC channels.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

 arch/arm64/boot/dts/qcom/pm8998.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 6f5bb6b37ec2..d09f2954b6f9 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -84,6 +84,16 @@ adc-chan@6 {
 			};
 		};
 
+		pm8998_adc_tm: adc-tm@3400 {
+			compatible = "qcom,spmi-adc-tm-hc";
+			reg = <0x3400>;
+			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		rtc@6000 {
 			compatible = "qcom,pm8941-rtc";
 			reg = <0x6000>, <0x6100>;
-- 
2.29.2

