Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7713C3F1110
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236216AbhHSDFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:05:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:61154 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236345AbhHSDE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:04:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629342261; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=AkPF77TfnBlbCAmJyFs5YSGCqIL5NMY9uQzUMArE0Kk=; b=IYh4KnynAVGsr/v4mAfIlSBMo5r/J/hAC+ushQ6LHSle5nZ9IurMSOIMP2Y6SyYnXCYE0UTz
 rN70oV8Cw3pt/hQMfSr0juj0ffU9MqX4g98qS1DjhfLU5XyQhbFel0CpNtbQFtUcNFaFPxcw
 QWD/KGrZm1O7nlP+zahYQQ/CGqA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 611dca2cf746c298d9ee2a5f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 19 Aug 2021 03:04:12
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1D9A6C43635; Thu, 19 Aug 2021 03:04:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 43D50C4360C;
        Thu, 19 Aug 2021 03:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 43D50C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     mka@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     ulf.hansson@linaro.org, rjw@rjwysocki.net, agross@kernel.org,
        ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v5 10/13] arm64: dts: qcom: sm8350: Use QMP property to control load state
Date:   Thu, 19 Aug 2021 08:32:13 +0530
Message-Id: <1629342136-3667-11-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629342136-3667-1-git-send-email-sibis@codeaurora.org>
References: <1629342136-3667-1-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the Qualcomm Mailbox Protocol (QMP) property to control the load
state resources on SM8350 SoCs and drop deprecated power-domains exposed
by AOSS QMP node.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index e91cd8a5e535..6c83cd52a279 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -8,7 +8,6 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interconnect/qcom,sm8350.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
-#include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/thermal/thermal.h>
@@ -726,15 +725,16 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&aoss_qmp AOSS_QMP_LS_MODEM>,
-					<&rpmhpd 0>,
+			power-domains = <&rpmhpd 0>,
 					<&rpmhpd 12>;
-			power-domain-names = "load_state", "cx", "mss";
+			power-domain-names = "cx", "mss";
 
 			interconnects = <&mc_virt MASTER_LLCC &mc_virt SLAVE_EBI1>;
 
 			memory-region = <&pil_modem_mem>;
 
+			qcom,qmp = <&aoss_qmp>;
+
 			qcom,smem-states = <&smp2p_modem_out 0>;
 			qcom,smem-state-names = "stop";
 
@@ -794,7 +794,6 @@
 			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
 
 			#clock-cells = <0>;
-			#power-domain-cells = <1>;
 		};
 
 		spmi_bus: spmi@c440000 {
@@ -1107,13 +1106,14 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&aoss_qmp AOSS_QMP_LS_SLPI>,
-					<&rpmhpd 4>,
+			power-domains = <&rpmhpd 4>,
 					<&rpmhpd 5>;
-			power-domain-names = "load_state", "lcx", "lmx";
+			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&pil_slpi_mem>;
 
+			qcom,qmp = <&aoss_qmp>;
+
 			qcom,smem-states = <&smp2p_slpi_out 0>;
 			qcom,smem-state-names = "stop";
 
@@ -1147,15 +1147,16 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&aoss_qmp AOSS_QMP_LS_CDSP>,
-					<&rpmhpd 0>,
+			power-domains = <&rpmhpd 0>,
 					<&rpmhpd 10>;
-			power-domain-names = "load_state", "cx", "mxc";
+			power-domain-names = "cx", "mxc";
 
 			interconnects = <&compute_noc MASTER_CDSP_PROC &mc_virt SLAVE_EBI1>;
 
 			memory-region = <&pil_cdsp_mem>;
 
+			qcom,qmp = <&aoss_qmp>;
+
 			qcom,smem-states = <&smp2p_cdsp_out 0>;
 			qcom,smem-state-names = "stop";
 
@@ -1381,13 +1382,14 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&aoss_qmp AOSS_QMP_LS_LPASS>,
-					<&rpmhpd 4>,
+			power-domains = <&rpmhpd 4>,
 					<&rpmhpd 5>;
-			power-domain-names = "load_state", "lcx", "lmx";
+			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&pil_adsp_mem>;
 
+			qcom,qmp = <&aoss_qmp>;
+
 			qcom,smem-states = <&smp2p_adsp_out 0>;
 			qcom,smem-state-names = "stop";
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

