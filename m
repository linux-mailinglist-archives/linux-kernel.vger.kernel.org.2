Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B913D0B10
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235986AbhGUIRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:17:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:27902 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236094AbhGUIBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:01:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626856912; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=sBv07ym0z1fgIZhufKkOU2OFsgSqqjV2ddPjUlQxfaU=; b=FseZ8RChDDjtbCTS8F8WGiaR1JI+3txS8fW1nDb8vIzHlgsXay1+VEH3VRPIbQwbdWShGgCU
 YyFGH1NOWEG+eRtopXOJ8FaVuAcx+YmuzObb5Hb/k/uKZptQA2PzYAB88/bc2IGLp7C1NxKg
 h3VfSCJP3UHxtw60COBgDKd1+hc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60f7ddcfe31d882d18c96e33 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 21 Jul 2021 08:41:51
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 79630C43144; Wed, 21 Jul 2021 08:41:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from hyd-lnxbld210.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F0C0C4338A;
        Wed, 21 Jul 2021 08:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F0C0C4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=srivasam@codeaurora.org
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        srinivas.kandagatla@linaro.org, dianders@chromium.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     V Sujith Kumar Reddy <vsujithk@codeaurora.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Subject: [PATCH v5 2/2] arm64: dts: qcom: sc7180-trogdor: Add lpass dai link for HDMI
Date:   Wed, 21 Jul 2021 14:11:26 +0530
Message-Id: <20210721084126.14035-3-srivasam@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210721084126.14035-1-srivasam@codeaurora.org>
References: <20210721084126.14035-1-srivasam@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: V Sujith Kumar Reddy <vsujithk@codeaurora.org>

Add dai link in sc7180-trogdor.dtsi for supporting audio over DP

Signed-off-by: V Sujith Kumar Reddy <vsujithk@codeaurora.org>
Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 31bf7c698b8f..a4cb9ee567ff 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -288,6 +288,7 @@ sound: sound {
 			"Headphone Jack", "HPOL",
 			"Headphone Jack", "HPOR";
 
+		#sound-dai-cells = <0>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -314,6 +315,18 @@ sound_multimedia1_codec: codec {
 				sound-dai = <&max98357a>;
 			};
 		};
+
+		dai-link@2 {
+			link-name = "MultiMedia2";
+			reg = <2>;
+			cpu {
+				sound-dai = <&lpass_cpu 2>;
+			};
+
+			codec {
+				sound-dai = <&mdss_dp>;
+			};
+		};
 	};
 };
 
@@ -768,6 +781,10 @@ secondary_mi2s: mi2s@1 {
 		reg = <MI2S_SECONDARY>;
 		qcom,playback-sd-lines = <0>;
 	};
+
+	hdmi-primary@0 {
+		reg = <LPASS_DP_RX>;
+	};
 };
 
 &mdp {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

