Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 321273B375A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbhFXTvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:51:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38403 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232759AbhFXTvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:51:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624564161; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=U3oyy9Wy1/W3yM/7R55rDsV8ZZWtSfsaxO4axT11yWo=; b=pyFD35BYlylBFJIn4s3uRDAPhR4T3lHt8JKo9L/3EoavxeRKxa26PEUmGXbTDtFQrRQHiWxL
 O1BhG9Zg6RHGuKhcoUbXODC4S3qpzEfNea5i2PFTC8MXXZyOsNNLVkyFFl4+xfGYAsrsT4/T
 +Z8M2nn+Jawf9EW1ON0aYMz2Hic=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 60d4e1b106ea41c941264ea5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 19:49:05
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 070B1C4323A; Thu, 24 Jun 2021 19:49:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9F3DBC4360C;
        Thu, 24 Jun 2021 19:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F3DBC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     bjorn.andersson@linaro.org, robh+dt@kernel.org, will@kernel.org,
        saiprakash.ranjan@codeaurora.org
Cc:     ohad@wizery.com, agross@kernel.org, mathieu.poirier@linaro.org,
        robin.murphy@arm.com, joro@8bytes.org, p.zabel@pengutronix.de,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, evgreen@chromium.org,
        dianders@chromium.org, swboyd@chromium.org,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 7/9] arm64: dts: qcom: sc7280: Add nodes to boot modem
Date:   Fri, 25 Jun 2021 01:17:36 +0530
Message-Id: <1624564058-24095-8-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624564058-24095-1-git-send-email-sibis@codeaurora.org>
References: <1624564058-24095-1-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add miscellaneous nodes to boot the modem and support post-mortem debug
on SC7280 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 5ed7a511bfc9..3fb6a6ef39f8 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -547,6 +547,11 @@
 			#hwlock-cells = <1>;
 		};
 
+		tcsr_regs: syscon@1fc0000 {
+			compatible = "syscon";
+			reg = <0 0x01fc0000 0 0x30000>;
+		};
+
 		lpasscc: lpasscc@3000000 {
 			compatible = "qcom,sc7280-lpasscc";
 			reg = <0 0x03000000 0 0x40>,
@@ -1219,6 +1224,21 @@
 			};
 		};
 
+		imem@146aa000 {
+			compatible = "syscon", "simple-mfd";
+			reg = <0 0x146aa000 0 0x2000>;
+
+			#address-cells = <2>;
+			#size-cells = <2>;
+
+			ranges = <0 0x0 0 0x146aa000 0 0x2000>;
+
+			pil-reloc@94c {
+				compatible = "qcom,pil-reloc-info";
+				reg = <0 0x94c 0 0xc8>;
+			};
+		};
+
 		apps_smmu: iommu@15000000 {
 			compatible = "qcom,sc7280-smmu-500", "arm,mmu-500";
 			reg = <0 0x15000000 0 0x100000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

