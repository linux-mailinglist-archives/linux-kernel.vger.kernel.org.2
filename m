Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7BA39347F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 19:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236914AbhE0RGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 13:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbhE0RFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 13:05:54 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B21C061760;
        Thu, 27 May 2021 10:04:20 -0700 (PDT)
Received: from localhost.localdomain (83.6.168.54.neoplus.adsl.tpnet.pl [83.6.168.54])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 8682F1F583;
        Thu, 27 May 2021 19:04:17 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] arm64: dts: qcom: Add MSM8996v3.0 DTSI file
Date:   Thu, 27 May 2021 19:04:07 +0200
Message-Id: <20210527170409.667255-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527170409.667255-1-konrad.dybcio@somainline.org>
References: <20210527170409.667255-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an overlay for MSM8996v3.0, which is a pre-final revision
of the said SoC. It has some stark differences with regards to
GPU, or more specifically its power delivery path. Oh, and of
course a different msm-id.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
Changes since v1:

- Apply the OPP table by default when this tree is included
- Switch to BSD3
- Add missing newline at the end of the file

 arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi | 63 ++++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi b/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
new file mode 100644
index 000000000000..6eef231e86cc
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8996-v3.0.dtsi
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Konrad Dybcio <konrad.dybcio@somainline.org>
+ */
+
+#include "msm8996.dtsi"
+
+ / {
+	qcom,msm-id = <246 0x30000>;
+ };
+
+ /*
+  * This revision seems to have differ GPU CPR
+  * parameters, GPU frequencies and some differences
+  * when it comes to voltage delivery to.. once again
+  * the GPU. Funnily enough, it's simpler to make it an
+  * overlay on top of 3.1 (the final one) than vice versa.
+  * The differences will show here as more and more
+  * features get enabled upstream.
+  */
+
+gpu_opp_table_3_0: gpu-opp-table-30 {
+	compatible = "operating-points-v2";
+
+	opp-624000000 {
+		opp-hz = /bits/ 64 <624000000>;
+		opp-level = <7>;
+	};
+
+	opp-560000000 {
+		opp-hz = /bits/ 64 <560000000>;
+		opp-level = <6>;
+	};
+
+	opp-510000000 {
+		opp-hz = /bits/ 64 <510000000>;
+		opp-level = <5>;
+	};
+
+	opp-401800000 {
+		opp-hz = /bits/ 64 <401800000>;
+		opp-level = <4>;
+	};
+
+	opp-315000000 {
+		opp-hz = /bits/ 64 <315000000>;
+		opp-level = <3>;
+	};
+
+	opp-214000000 {
+		opp-hz = /bits/ 64 <214000000>;
+		opp-level = <3>;
+	};
+
+	opp-133000000 {
+		opp-hz = /bits/ 64 <133000000>;
+		opp-level = <3>;
+	};
+};
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table_3_0>;
+};
-- 
2.31.1

