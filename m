Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B5640FE7A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 19:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbhIQRRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:17:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62283 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244936AbhIQRRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:17:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1631898987; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=M4DBHwmThDmwQVFAKJtW+brHb96jLrv1uHjhvN73azU=; b=aln0NCRsXR+aGTBVlBtdwCL+deF6+7wnMhpGK4EFtGtygn40N8E8oMojaB++Xt//TdZ8D71P
 WeWZo5YUw7VNNcaPrKejXMjNH4I2CVCglAEadV2wQxqpH/Z2QWVMHHWhj5GI9TIJc2B4Dmx7
 vsW2rdSdGSRZLR6V6a3Q8zSUpic=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6144cd63bd6681d8ed5b0134 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 17 Sep 2021 17:16:19
 GMT
Sender: pmaliset=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1EDAAC43618; Fri, 17 Sep 2021 17:16:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pmaliset-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmaliset)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F343C4360D;
        Fri, 17 Sep 2021 17:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9F343C4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Prasad Malisetty <pmaliset@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, swboyd@chromium.org, lorenzo.pieralisi@arm.com,
        svarbanov@mm-sol.com
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, mka@chromium.org, vbadigan@codeaurora.org,
        sallenki@codeaurora.org, manivannan.sadhasivam@linaro.org,
        Prasad Malisetty <pmaliset@codeaurora.org>
Subject: [PATCH v8 3/4] arm64: dts: qcom: sc7280: Add PCIe nodes for IDP board
Date:   Fri, 17 Sep 2021 22:45:46 +0530
Message-Id: <1631898947-27433-4-git-send-email-pmaliset@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1631898947-27433-1-git-send-email-pmaliset@codeaurora.org>
References: <1631898947-27433-1-git-send-email-pmaliset@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PCIe controller and PHY for sc7280 IDP board.
Add specific NVMe GPIO entries for SKU1 and SKU2 support.

Signed-off-by: Prasad Malisetty <pmaliset@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dts  |  4 ++++
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 40 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts |  4 ++++
 3 files changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 64fc22a..1a37b29 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -61,6 +61,10 @@
 	modem-init;
 };
 
+&nvme_ldo_enable_pin {
+	pins = "gpio19";
+};
+
 &pmk8350_vadc {
 	pmr735a_die_temp {
 		reg = <PMR735A_ADC7_DIE_TEMP>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 99f9ee5..ee00df0 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -199,6 +199,39 @@
 	modem-init;
 };
 
+&pcie1 {
+	status = "okay";
+
+	perst-gpio = <&tlmm 2 GPIO_ACTIVE_LOW>;
+	pinctrl-0 = <&pcie1_default_state &nvme_ldo_enable_pin>;
+};
+
+&pcie1_phy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l10c_0p8>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+};
+
+&pcie1_default_state {
+	reset-n {
+		pins = "gpio2";
+		function = "gpio";
+
+		drive-strength = <16>;
+		output-low;
+		bias-disable;
+	};
+
+	wake-n {
+		pins = "gpio3";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-pull-up;
+	};
+};
+
 &pmk8350_vadc {
 	pmk8350_die_temp {
 		reg = <PMK8350_ADC7_DIE_TEMP>;
@@ -343,3 +376,10 @@
 		bias-pull-up;
 	};
 };
+
+&tlmm {
+	nvme_ldo_enable_pin: nvme_ldo_enable_pin {
+		function = "gpio";
+		bias-pull-up;
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
index 1fc2add..dc0f0404 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
@@ -21,3 +21,7 @@
 		stdout-path = "serial0:115200n8";
 	};
 };
+
+&nvme_ldo_enable_pin {
+	pins = "gpio51";
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

