Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A645930EE10
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 09:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhBDIK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 03:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhBDIKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 03:10:24 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F23C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 00:09:44 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l18so1332661pji.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 00:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mbzglOInmCBEXi+RhAT4Ml3f+J7eG2WI0sIBzkLXfK0=;
        b=SZ3fQhEZi6dCMB7apBij9SlRLDenqp7RPeseE09ECbMTNx32BSzfp6j2xkAjThBubz
         X71vvESM4qpUsKIetZcjH8oVKxHRc6tIOMvcCcFqvDdh8w41zEzu1a7Q491f1mld2xK0
         SC2IxsAGzp5RuKelfRv0qCkpaJKBJiisG7Qc3IrOrTRbubkwB6PdHClePE3c1dncS4yP
         q0Q8WJhAl+GF0glkL48/U04GIIQwHeG+wALkCJrX4iE6I4Xf754hrSFzEb+/Dy9Qg5Qv
         d4WaYj9IEQraIvPO6KRE2JOYrodg/Q1ckGZUjH64spb83V7j7aNB0Sc1XRboPE8yUWEj
         z3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mbzglOInmCBEXi+RhAT4Ml3f+J7eG2WI0sIBzkLXfK0=;
        b=B+FbaG+N/uYYBaM09kTf52jeyWIVhRpAOaKmHb4OOMjtyd5cAOBBtk7adO+aeN0XH5
         q+/OfJDqkgZvuKXmDmwxwo5Z2boawYRSeEtX5WsoK1Anmq+dlmMz2zhI3entOFSIYR8B
         9OiE20Dm/dh1Vo/cY1z2I8goss7E80PflaSNEVqGpzzpYDUsEQXhmzE/pBq0xdZ/BUGR
         kO9sXD/u1jHLXsp8NUu2DWx22sAWnhfVWNIJUEVoaa0D3f/oc0tqJV674bsRX4J26eG3
         1iaUk3mXUhjIKf8ptHxGoqzp8iOBfBbIjXkaVF+KWDGm1LXHzGuRk8phUwkZbEkoKeiE
         72IA==
X-Gm-Message-State: AOAM532askZY3mFzqiGcaglq/qQmeeU7pLqOt2Hdn1ldGrzxvgiImQM1
        E/4kEpsiyBqox73hnRduuZabjg==
X-Google-Smtp-Source: ABdhPJx84IjwzzWpe79dKS1zQyZmeN9Puw8PDovhSQYM9e3FvitZrqHK6CyiqgES8SplFG48bg1KVg==
X-Received: by 2002:a17:902:ea0f:b029:de:5fd5:abb9 with SMTP id s15-20020a170902ea0fb02900de5fd5abb9mr6853830plg.46.1612426183934;
        Thu, 04 Feb 2021 00:09:43 -0800 (PST)
Received: from localhost.localdomain ([2405:201:6803:610b:1c6f:cebf:a887:dd42])
        by smtp.gmail.com with ESMTPSA id 9sm4698796pfy.110.2021.02.04.00.09.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Feb 2021 00:09:43 -0800 (PST)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, phone-devel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: qcom: sdm845-xiaomi-beryllium: Add DSI and panel bits
Date:   Thu,  4 Feb 2021 13:39:37 +0530
Message-Id: <1612426177-6611-1-git-send-email-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumit Semwal <sumit.semwal@linaro.org>

Enabling the Display panel for beryllium phone (Xiaomi
Pocophone F1) requires DSI labibb regulators and panel
dts nodes to be added. It is also required to keep some
of the regulators as always-on.

Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
v2: Rebased to mainline (v5.11-rc6) and fixed build warnings.

 .../boot/dts/qcom/sdm845-xiaomi-beryllium.dts      | 58 ++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index 86cbae63eaf7..034246b5c529 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -157,6 +157,14 @@
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l14a_1p88: ldo14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-boot-on;
+			regulator-always-on;
+		};
+
 		vreg_l17a_1p3: ldo17 {
 			regulator-min-microvolt = <1304000>;
 			regulator-max-microvolt = <1304000>;
@@ -191,6 +199,7 @@
 			regulator-min-microvolt = <1200000>;
 			regulator-max-microvolt = <1200000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-boot-on;
 		};
 	};
 };
@@ -200,6 +209,47 @@
 	firmware-name = "qcom/sdm845/cdsp.mdt";
 };
 
+&dsi0 {
+	status = "okay";
+	vdda-supply = <&vreg_l26a_1p2>;
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	ports {
+		port@1 {
+			endpoint {
+				remote-endpoint = <&tianma_nt36672a_in_0>;
+				data-lanes = <0 1 2 3>;
+			};
+		};
+	};
+
+	panel@0 {
+		compatible = "tianma,fhd-video";
+		reg = <0>;
+		vddi0-supply = <&vreg_l14a_1p88>;
+		vddpos-supply = <&lab>;
+		vddneg-supply = <&ibb>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+
+		port {
+			tianma_nt36672a_in_0: endpoint {
+				remote-endpoint = <&dsi0_out>;
+			};
+		};
+	};
+};
+
+&dsi0_phy {
+	status = "okay";
+	vdds-supply = <&vreg_l1a_0p875>;
+};
+
 &gcc {
 	protected-clocks = <GCC_QSPI_CORE_CLK>,
 			   <GCC_QSPI_CORE_CLK_SRC>,
@@ -215,6 +265,14 @@
 	};
 };
 
+&mdss {
+	status = "okay";
+};
+
+&mdss_mdp {
+	status = "okay";
+};
+
 &mss_pil {
 	status = "okay";
 	firmware-name = "qcom/sdm845/mba.mbn", "qcom/sdm845/modem.mdt";
-- 
2.7.4

