Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE320324CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbhBYJdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:33:50 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:53909 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236411AbhBYJcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:32:12 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614245511; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=T+CeZNQ7m9bkkwM+MlmLyc3pTqN6FHhPW/lPjgnage8=; b=APAnSOxOPjohARzJLmWkJOLQRSwH9ggrtIuicLowrWLfAAzhDJ7Nspscmqot91wPFBJbsfjs
 u7zrh2WSlyFB4dt4EFL7nkZ7NMgkveE8/wcVWmQsQqjCwwhZEw5nOsymGmdQOLCTcuQNvsR7
 OhJjhiwUIIsOYCKcD5o+4VNFUCY=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60376e879a7cefa92ab7ff7f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Feb 2021 09:31:51
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5CF83C43467; Thu, 25 Feb 2021 09:31:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B84AEC433CA;
        Thu, 25 Feb 2021 09:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B84AEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     devicetree@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 8/9] arm64: dts: qcom: sc7280: Add AOSS QMP node
Date:   Thu, 25 Feb 2021 15:00:24 +0530
Message-Id: <463a45f2c3e4a91430c006fa1637c7f4f124185e.1614244789.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <cover.1614244789.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1614244789.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for the AOSS QMP on SC7280 SoC.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 65c1e0f2fb56..cbd567ccc04e 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/mailbox/qcom-ipcc.h>
+#include <dt-bindings/power/qcom-aoss-qmp.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -368,6 +369,19 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		aoss_qmp: qmp@c300000 {
+			compatible = "qcom,sc7280-aoss-qmp";
+			reg = <0 0x0c300000 0 0x100000>;
+			interrupts-extended = <&ipcc IPCC_CLIENT_AOP
+						     IPCC_MPROC_SIGNAL_GLINK_QMP
+						     IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&ipcc IPCC_CLIENT_AOP
+					IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+			#clock-cells = <0>;
+			#power-domain-cells = <1>;
+		};
+
 		spmi_bus: qcom,spmi@c440000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0 0x0c440000 0 0x1100>,
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

