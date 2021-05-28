Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C542B394216
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235643AbhE1Lpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:45:31 -0400
Received: from msg-2.mailo.com ([213.182.54.12]:59786 "EHLO msg-2.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230080AbhE1Lpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1622202230; bh=9F46d+D6PUZw4iBYp6wdpPgYDs/Z6g3cZyzLMyCuorQ=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=ESroWzDW2mGr7tgwcFQnIq+Eb5e1OXWb7bvAuUViOW2pi2aB54I7bDcBaDHShA+OE
         ptbF3CIc8cisgKrdEmMvIooI5W4wWZrOmNYT7lGTHM+LXgwsx7Fun5tw86t6xO6IAS
         /hxq96ce6SL/XTl3Q8eQDjs1un3Cq0H2mDnGp3Fg=
Received: by 192.168.90.14 [192.168.90.14] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Fri, 28 May 2021 13:43:50 +0200 (CEST)
X-EA-Auth: iF3NUtHNTTfqpVliJfCgyjzHXkJzdXaznTY8yvhAR8LNEKgCrFf7prSbm93bcfkQmLTCj+lYQrI/AP+fJz6gRBeIL9tpUD86xSmf0Kv9y1U=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH v1] arm64: dts: qcom: msm8916-alcatel-idol347: enable touchscreen
Date:   Fri, 28 May 2021 13:43:45 +0200
Message-Id: <20210528114345.543761-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the MStar msg2638 touchscreen.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index 540b1fa4b260..670bd1bebd73 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -45,6 +45,24 @@ &blsp1_uart2 {
 	status = "okay";
 };
 
+&blsp_i2c4 {
+	status = "okay";
+
+	touchscreen@26 {
+		compatible = "mstar,msg2638";
+		reg = <0x26>;
+		interrupt-parent = <&msmgpio>;
+		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&msmgpio 100 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_reset_default>;
+		vdd-supply = <&pm8916_l17>;
+		vddio-supply = <&pm8916_l5>;
+		touchscreen-size-x = <2048>;
+		touchscreen-size-y = <2048>;
+	};
+};
+
 &blsp_i2c5 {
 	status = "okay";
 
@@ -281,6 +299,14 @@ proximity_int_default: proximity-int-default {
 		bias-pull-up;
 	};
 
+	ts_int_reset_default: ts-int-reset-default {
+		pins = "gpio13", "gpio100";
+		function = "gpio";
+
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	usb_id_default: usb-id-default {
 		pins = "gpio69";
 		function = "gpio";
-- 
2.31.1



