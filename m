Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501BB3B4A68
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 00:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhFYWF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 18:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhFYWFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 18:05:54 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E65C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 15:03:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d12so825538pfj.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 15:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O4ese8Y4+WSHdRNE0+R9rpSzI0msBCg5RrtNbTiIqXM=;
        b=Cv064OjNvDCHlDf/LlWl/Wj6EQ0ckksJX0ePjELby3NYPebamCDitDYh5UOh6dNsHH
         rY3hm8o/JQMdIFFYR+3K8IOw6FyccFk2ZseFoAdyBTNppN3sTH1u0ckoDTFyyQde1K+1
         tZ8G36Rvynxree8SAW2lmKLbC1W3BXb38xvhknGkApAlMqzeJdxUzhE4ZHrkNdCQSKZp
         alsor1IFRdU4kwnMQmIBz9WhyvOkQrotoB0KxOsCnKB8BIVDWnLqlip+sI3SvLG6Bu7S
         uFTfYFb3CC+xcHOYMwkO0sZbnyfflZnSfiZFjC4xsb1XYhobJGQ0/5vuH83lYRNN1JUu
         Uz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O4ese8Y4+WSHdRNE0+R9rpSzI0msBCg5RrtNbTiIqXM=;
        b=gcUGhPy83XvcBKgiIlyzXtxtpXw+N4ed5OBIfs6yzz/V7ehp7K7A+eFKsrwYxsI9TY
         L/jRZzApcre8vn0ji+y37X7d635/EUKy4GK8Q1ZNB5a5mpKH0HpcKrHSqesR5MWZhf6r
         2GVYdpHYAu6rM+E7nsDBigWe9y1JZqdsBt1DPDePSlo6sM8gbgxgd26YpLpLI1aQdnvD
         c+YaIJw7Q/Zuwb7KhF6ZQNi6QXuXIzpZy+Ym8Yd4RuYXrx5OLDze6K039k9Ld8oP00yD
         p26p4OiPVeTie86yI4o+BQZmHZfrk+Y9+HxfcHSOzUcorbqDZERPCBVb5RjTURjNF3n+
         Tozg==
X-Gm-Message-State: AOAM532Bimx2zSEeZvw1958dwWVGKAyLYmeW+Y58+TlrMiVXxRfJiWQC
        uvKNe1K23GCUOK+bzsJS7yZABw==
X-Google-Smtp-Source: ABdhPJxe8S2kEQbTu6Z4fKxxr3Tm9HmzleVP6Kc8hVv16kFSf9Oc69fk4hi+1DqlmoQiTPdPp8Z/hA==
X-Received: by 2002:aa7:88d6:0:b029:300:6247:8141 with SMTP id k22-20020aa788d60000b029030062478141mr12351002pff.47.1624658612953;
        Fri, 25 Jun 2021 15:03:32 -0700 (PDT)
Received: from localhost.name ([122.177.20.255])
        by smtp.gmail.com with ESMTPSA id d9sm6374040pjx.13.2021.06.25.15.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 15:03:32 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, agross@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: Fix usb entries for SA8155p adp board
Date:   Sat, 26 Jun 2021 03:33:11 +0530
Message-Id: <20210625220311.527549-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625220311.527549-1-bhupesh.sharma@linaro.org>
References: <20210625220311.527549-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SA8155p adp board has two USB A-type receptacles called
USB-portB and USB-portC respectively.

While USB-portB is a USB High-Speed connector/interface, the
USB-portC one is a USB 3.1 Super-Speed connector/interface.

Also the USB-portB is used as the USB emergency
download port (for image download purposes).

Enable both the ports on the board in USB Host mode (since all
the USB interfaces are brought out to USB Type A
connectors).

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 60 ++++++++++++++++++++----
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 0da7a3b8d1bf..5ae2ddc65f7e 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -307,10 +307,6 @@ &qupv3_id_1 {
 	status = "okay";
 };
 
-&tlmm {
-	gpio-reserved-ranges = <0 4>;
-};
-
 &uart2 {
 	status = "okay";
 };
@@ -337,6 +333,16 @@ &ufs_mem_phy {
 	vdda-pll-max-microamp = <18300>;
 };
 
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "host";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2phy_ac_en1_default>;
+};
 
 &usb_1_hsphy {
 	status = "okay";
@@ -346,15 +352,51 @@ &usb_1_hsphy {
 };
 
 &usb_1_qmpphy {
+	status = "disabled";
+};
+
+&usb_2 {
 	status = "okay";
-	vdda-phy-supply = <&vreg_l8c_1p2>;
-	vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
 };
 
-&usb_1 {
+&usb_2_dwc3 {
+	dr_mode = "host";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb2phy_ac_en2_default>;
+};
+
+&usb_2_hsphy {
 	status = "okay";
+	vdda-pll-supply = <&vdd_usb_hs_core>;
+	vdda33-supply = <&vdda_usb_hs_3p1>;
+	vdda18-supply = <&vdda_usb_hs_1p8>;
 };
 
-&usb_1_dwc3 {
-	dr_mode = "peripheral";
+&usb_2_qmpphy {
+	status = "okay";
+	vdda-phy-supply = <&vreg_l8c_1p2>;
+	vdda-pll-supply = <&vdda_usb_ss_dp_core_1>;
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>;
+
+	usb2phy_ac_en1_default: usb2phy_ac_en1_default {
+		mux {
+			pins = "gpio113";
+			function = "usb2phy_ac";
+			bias-disable;
+			drive-strength = <2>;
+		};
+	};
+
+	usb2phy_ac_en2_default: usb2phy_ac_en2_default {
+		mux {
+			pins = "gpio123";
+			function = "usb2phy_ac";
+			bias-disable;
+			drive-strength = <2>;
+		};
+	};
 };
-- 
2.31.1

