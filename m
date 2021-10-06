Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7514423DBD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238218AbhJFMcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:32:21 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:12249 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhJFMcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:32:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633523426; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=uJvnLdySlTcVVB0Llr+OLFyMVk36k6NYLRlJsJrnQxM=; b=bClNKCRaMQQmaaaE381MhOb3jUmQYVtGkXuQHg9epHBuYPz1Wb9CxqyO/MaQT8B7LFXnO0Fw
 feOYXbdc4P0dzWXA2TqYO2fgqqlph0TI6+rEKSxmg2RvzXFBIPl89f8DyTmVlCEWFk02DcgO
 KgIFoki6B56jCc4ZuFi1npHtjBA=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 615d96df03355859c815f333 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 06 Oct 2021 12:30:23
 GMT
Sender: bgodavar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06ED1C4338F; Wed,  6 Oct 2021 12:30:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from bgodavar-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 264C0C4360C;
        Wed,  6 Oct 2021 12:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 264C0C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, bjorn.andersson@linaro.org,
        johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        rjliao@codeaurora.org, pharish@codeaurora.org,
        abhishekpandit@chromium.org
Subject: [PATCH v1 2/2] arm64: dts: qcom: sc7280: update bluetooth node in SC7280 IDP2 board
Date:   Wed,  6 Oct 2021 18:00:03 +0530
Message-Id: <1633523403-32264-2-git-send-email-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1633523403-32264-1-git-send-email-bgodavar@codeaurora.org>
References: <1633523403-32264-1-git-send-email-bgodavar@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates bluetooth node in SC7280 IDP2 board.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7280-idp2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
index 1fc2add..5c8d54b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp2.dts
@@ -15,9 +15,15 @@
 
 	aliases {
 		serial0 = &uart5;
+		bluetooth0 = &bluetooth;
+		hsuart0 = &uart7;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
 };
+
+&bluetooth: wcn6750-bt {
+	vddio-supply = <&vreg_l18b_1p8>;
+};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

