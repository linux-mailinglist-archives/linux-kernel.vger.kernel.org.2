Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD8E3E4CDC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 21:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236054AbhHITQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 15:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbhHITQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 15:16:32 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30A0C061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 12:16:11 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id c6so9147719qtv.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 12:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uRDZmyuq4axbYzHmiE0iOEImexM18sedZH7tLrs/dF0=;
        b=RyPkY8wsR357mYKU94l07YIoW5mMyDlM65dUaySXh+5pQxuey/rLJISydLl3d4PC3m
         J92PQ4OfZygbBDTu7TNcZPwWg+cfknKPsjbQNevYbZLeLPK3uCRi3oXQDbB92W0AJrg2
         UCS58rbfFGydfCLsx0RRvFHGwKZ2psqjkCZRrhlA6VMzWunH9YV9Y8Y64UgboCfAlLFs
         MvxfyYNyD/JK5SiWZ1JmRIiy7f2B+MN1zHdUBR+lzay3vPftLl58wFY3GmeiGfy+zb3W
         t2ix5Y+K8FwXITROTkZgfys+3HND2DQPPzNmWLs7hjOpGwkt8e8XWhImLRe3jEjWOIR0
         GV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uRDZmyuq4axbYzHmiE0iOEImexM18sedZH7tLrs/dF0=;
        b=aiIlFcW8gOpHdxvFQ9FEQ8jXb2lHMaD1WGcD8LwAg4iyIZx7tgFyvIR3QDvjHnF0g/
         aCJ1RYJmUZL/t3c/Bn60Y7Nb8xDSgr1pP+IlB01V+/R4u/1jOAJgFWUa81i9aM/mECnF
         jpnB+lCrBTtiOyv8X61DGoILuX8ljzm6vx/QY5Avo9eMwTfBQdkfVnbgbSjB4Y0yvlPC
         5oq6VPEM2U3rSsZN16Tt4ZM2ifiAqUvBz/akdO1UgkSm6m36PXC1M0ZxukZzgnR+3o9u
         f6v4jZZHVbMNpHhYLbD21YNUN8GycLf2lm8r24lFYzAPQqrVL9ZdLOovnxHPm0jsvVYu
         nuZg==
X-Gm-Message-State: AOAM530NCypFOOLXwF/yKY8A3zY9f0zoRA1sYMfUnjWRhZOsQ4SDvwI6
        NGAd/pb/3XUgY1UJlng1Hb+EYQ==
X-Google-Smtp-Source: ABdhPJy4EgtTS5uDMgBaKUSLduB3HPDHZqpcu0jSUO5XCeRCyNlLkiTKjNDel1pIi3ANsLdT+eFwjg==
X-Received: by 2002:ac8:588f:: with SMTP id t15mr21584134qta.367.1628536570810;
        Mon, 09 Aug 2021 12:16:10 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id n14sm7303398qti.47.2021.08.09.12.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 12:16:10 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     steev@kali.org, tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [Patch v5 4/6] arm64: dts: qcom: sdm45: Add support for LMh node
Date:   Mon,  9 Aug 2021 15:16:02 -0400
Message-Id: <20210809191605.3742979-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210809191605.3742979-1-thara.gopinath@linaro.org>
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LMh nodes for cpu cluster0 and cpu cluster1. Also add interrupt
support in cpufreq node to capture the LMh interrupt and let the scheduler
know of the max frequency throttling.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---

v4->v5: 
	- Renamed dt binding property qcom,lmh-cpu to cpus as per
	  Rob Herring's review comments.
	- Changed LMh reg space size from the wierd size 0x401 to 0x400.

v3->v4:
	- Changed dt property qcom,lmh-cpu-id to qcom,lmh-cpu and made it
	  a phandle pointing to the cpu node instead of a number as per
	  Rob Herring's review comments.
	- Added suffix -millicelsius to all temperature properties as per
	  Rob Herring's review comments.

v2->v3:
	- Changed the LMh low and high trip to 94500 and 95000 mC from
	  74500 and 75000 mC. This was a bug that got introduced in v2.
v1->v2:
	- Dropped dt property qcom,support-lmh as per Bjorn's review comments.
	- Changed lmh compatible from generic to platform specific.
	- Introduced properties specifying arm, low and high temp thresholds for LMh
	  as per Daniel's suggestion.

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 0a86fe71a66d..d90c896cbac8 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -3646,6 +3646,30 @@ swm: swm@c85 {
 			};
 		};
 
+		lmh_cluster1: lmh@17d70800 {
+			compatible = "qcom,sdm845-lmh";
+			reg = <0 0x17d70800 0 0x400>;
+			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+			cpus = <&CPU4>;
+			qcom,lmh-temp-arm-millicelsius = <65000>;
+			qcom,lmh-temp-low-millicelsius = <94500>;
+			qcom,lmh-temp-high-millicelsius = <95000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
+		lmh_cluster0: lmh@17d78800 {
+			compatible = "qcom,sdm845-lmh";
+			reg = <0 0x17d78800 0 0x400>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+			cpus = <&CPU0>;
+			qcom,lmh-temp-arm-millicelsius = <65000>;
+			qcom,lmh-temp-low-millicelsius = <94500>;
+			qcom,lmh-temp-high-millicelsius = <95000>;
+			interrupt-controller;
+			#interrupt-cells = <1>;
+		};
+
 		sound: sound {
 		};
 
@@ -4911,6 +4935,8 @@ cpufreq_hw: cpufreq@17d43000 {
 			reg = <0 0x17d43000 0 0x1400>, <0 0x17d45800 0 0x1400>;
 			reg-names = "freq-domain0", "freq-domain1";
 
+			interrupts-extended = <&lmh_cluster0 0>, <&lmh_cluster1 0>;
+
 			clocks = <&rpmhcc RPMH_CXO_CLK>, <&gcc GPLL0>;
 			clock-names = "xo", "alternate";
 
-- 
2.25.1

