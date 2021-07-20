Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2325F3CF384
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 06:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348045AbhGTEBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 00:01:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40181 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347722AbhGTD5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 23:57:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626755898; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=cpUIm3+j2CRpePwfmRiIipwJKPjEvhc8C6XVVmb5SB4=; b=B9+LGr6sVNBUO+eOZr/0VwZazob/3ImykLiIxxFs0ipDfzn5/VHf11o+a0XwZgaQQkcNcihp
 50Blv8V3ZIDNwMwvxH1TOCZb5+m7Vtq6dTmYwXQStYc1jSL0U6okMFfuYOQeiJBHsH0sfYeq
 iLdknh80yAqWuudDLs213nplTA4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60f653394815712f3a5eddf5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Jul 2021 04:38:17
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4FCC8C43217; Tue, 20 Jul 2021 04:38:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0E6BC43217;
        Tue, 20 Jul 2021 04:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0E6BC43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     mka@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     ulf.hansson@linaro.org, rjw@rjwysocki.net, agross@kernel.org,
        ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 08/13] arm64: dts: qcom: sm8150: Use QMP property to control load state
Date:   Tue, 20 Jul 2021 10:06:42 +0530
Message-Id: <1626755807-11865-9-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626755807-11865-1-git-send-email-sibis@codeaurora.org>
References: <1626755807-11865-1-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the Qualcomm Mailbox Protocol (QMP) property to control the load
state resources on SM8150 SoCs and drop deprecated power-domains exposed
by AOSS QMP node.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 612dda0fef43..7a040b74ef5a 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -6,7 +6,6 @@
 
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
@@ -1110,13 +1109,14 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&aoss_qmp AOSS_QMP_LS_SLPI>,
-					<&rpmhpd 3>,
+			power-domains = <&rpmhpd 3>,
 					<&rpmhpd 2>;
-			power-domain-names = "load_state", "lcx", "lmx";
+			power-domain-names = "lcx", "lmx";
 
 			memory-region = <&slpi_mem>;
 
+			qcom,qmp = <&aoss_qmp>;
+
 			qcom,smem-states = <&slpi_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
@@ -1560,13 +1560,14 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&aoss_qmp AOSS_QMP_LS_MODEM>,
-					<&rpmhpd 7>,
+			power-domains = <&rpmhpd 7>,
 					<&rpmhpd 0>;
-			power-domain-names = "load_state", "cx", "mss";
+			power-domain-names = "cx", "mss";
 
 			memory-region = <&mpss_mem>;
 
+			qcom,qmp = <&aoss_qmp>;
+
 			qcom,smem-states = <&modem_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
@@ -2186,12 +2187,12 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&aoss_qmp AOSS_QMP_LS_CDSP>,
-					<&rpmhpd 7>;
-			power-domain-names = "load_state", "cx";
+			power-domains = <&rpmhpd 7>;
 
 			memory-region = <&cdsp_mem>;
 
+			qcom,qmp = <&aoss_qmp>;
+
 			qcom,smem-states = <&cdsp_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
@@ -2415,7 +2416,6 @@
 			mboxes = <&apss_shared 0>;
 
 			#clock-cells = <0>;
-			#power-domain-cells = <1>;
 		};
 
 		tsens0: thermal-sensor@c263000 {
@@ -2562,12 +2562,12 @@
 			clocks = <&rpmhcc RPMH_CXO_CLK>;
 			clock-names = "xo";
 
-			power-domains = <&aoss_qmp AOSS_QMP_LS_LPASS>,
-					<&rpmhpd 7>;
-			power-domain-names = "load_state", "cx";
+			power-domains = <&rpmhpd 7>;
 
 			memory-region = <&adsp_mem>;
 
+			qcom,qmp = <&aoss_qmp>;
+
 			qcom,smem-states = <&adsp_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

