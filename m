Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9BD53392B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 17:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhCLQHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 11:07:15 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:58369 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231733AbhCLQGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 11:06:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615565211; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1fa9TcQTQL8TJbWX12zWVHusT+gCDcQWwGmndbfVq3E=; b=gSONDCcp+tGDvUUVOJ1j7yN/m7/U4lzyThYj9PbHI02+ra1Tpum9W7XKOTEYvi42UJD5uOy4
 xzvUqbxUS/23ogPl5yr+zZ5C8J+88fItn59gs1d5QCxUnW5fuO0RiGTcxVW6Az4Kat0TmMdz
 Z1yz1EIXoIZIl1REecHVSBmqro4=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 604b919ae3fca7d0a68758c3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Mar 2021 16:06:50
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 683E4C43463; Fri, 12 Mar 2021 16:06:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6EEE8C433C6;
        Fri, 12 Mar 2021 16:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6EEE8C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=srivasam@codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH v5 2/2] arm64: dts: qcom: Add sound node for sc7180-trogdor-coachz
Date:   Fri, 12 Mar 2021 21:36:22 +0530
Message-Id: <20210312160622.24165-3-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210312160622.24165-1-srivasam@codeaurora.org>
References: <20210312160622.24165-1-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a trgodor variant, required to have sound node variable
for coachz specific platform.

Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 4ad520f00485..7eaad739b6f9 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -89,6 +89,16 @@ &sn65dsi86_out {
 	data-lanes = <0 1 2 3>;
 };
 
+&sound {
+	compatible = "google,sc7180-coachz";
+	model = "sc7180-adau7002-max98357a";
+	audio-routing = "PDM_DAT", "DMIC";
+};
+
+&multimedia0_codec {
+	sound-dai = <&adau7002>;
+};
+
 /* PINCTRL - modifications to sc7180-trogdor.dtsi */
 
 &en_pp3300_dx_edp {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

