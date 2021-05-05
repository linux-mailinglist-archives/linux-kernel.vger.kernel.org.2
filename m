Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D659373530
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 08:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhEEG5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 02:57:06 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:16096 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhEEG5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 02:57:00 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 04 May 2021 23:56:04 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 04 May 2021 23:56:02 -0700
X-QCInternal: smtphost
Received: from c-skakit-linux.ap.qualcomm.com (HELO c-skakit-linux.qualcomm.com) ([10.242.51.242])
  by ironmsg02-blr.qualcomm.com with ESMTP; 05 May 2021 12:25:38 +0530
Received: by c-skakit-linux.qualcomm.com (Postfix, from userid 2344709)
        id 90D264845; Wed,  5 May 2021 12:25:37 +0530 (IST)
From:   satya priya <skakit@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     mka@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kgunda@codeaurora.org, satya priya <skakit@codeaurora.org>
Subject: [PATCH V4 1/8] arm64: dts: qcom: sm8350: Add label for thermal-zones node
Date:   Wed,  5 May 2021 12:25:19 +0530
Message-Id: <1620197726-23802-2-git-send-email-skakit@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620197726-23802-1-git-send-email-skakit@codeaurora.org>
References: <1620197726-23802-1-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add label "thermal_zones" for thermal-zones node.

Signed-off-by: satya priya <skakit@codeaurora.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index ed0b51b..47c6c0b 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1317,7 +1317,7 @@
 		};
 	};
 
-	thermal-zones {
+	thermal_zones: thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
 			polling-delay = <1000>;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

