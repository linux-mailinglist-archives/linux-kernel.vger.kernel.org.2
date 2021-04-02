Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17ADA3526CD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 09:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbhDBHCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 03:02:31 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:16327 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhDBHC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 03:02:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1617346946; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=bFz/V7mrQ5y/g1mvMR97iF/dgaTKxEHkvYcuH5Wz7m0=; b=GW4pibQqh88/dzvqu/ZHlngOXd4Z1onnd9XZFm+/f3UZoWhjY/vGlCW05a0a3bbYvRwflcXg
 o4t1mIJjqK4GZ0dH+R1fOlItkaFqH95dfd3vzQkG3SOis5YQhUUMIal0mn7pkqicQAfgiEpR
 icxbi3Ng7uPfZqg89hrApDn8LNw=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6066c1778166b7eff70fb32b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 02 Apr 2021 07:02:15
 GMT
Sender: manafm=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2887AC43461; Fri,  2 Apr 2021 07:02:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from codeaurora.org (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AC225C433CA;
        Fri,  2 Apr 2021 07:02:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AC225C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=manafm@codeaurora.org
From:   Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Meethalavalappu Pallikunhi <manafm@codeaurora.org>,
        Ram Chandrasekar <rkumbako@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        Akhil P Oommen <akhilpo@codeaurora.org>
Subject: [RFC PATCH 1/2] dt-bindings: soc: qcom: Add SDPM clock monitor driver documentation in yaml
Date:   Fri,  2 Apr 2021 12:29:06 +0530
Message-Id: <1617346747-8611-2-git-send-email-manafm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617346747-8611-1-git-send-email-manafm@codeaurora.org>
References: <1617346747-8611-1-git-send-email-manafm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add yaml documentation for SDPM clock monitor driver which will
register for clock rate change notification and writes the clock rate
into SDPM CSR register.

Signed-off-by: Ram Chandrasekar <rkumbako@codeaurora.org>
Signed-off-by: Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/qcom-sdpm.yaml    | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-sdpm.yaml

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom-sdpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom-sdpm.yaml
new file mode 100644
index 00000000..20df362
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom-sdpm.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/qcom/qcom-sdpm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Simple Digital Power Meter(SDPM) clock monitoring
+
+maintainers:
+  - Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
+  - Ram Chandrasekar <rkumbako@codeaurora.org>
+
+description: |
+
+  SDPM is used to monitor the operating frequency of different clocks and based
+  on operating levels of different clients, RDPM (Rail Digital Power Meter)
+  hardware estimates total power consumption of a shared railway. The SDPM
+  clock monitor driver will register with the clock framework for rate change
+  notification of different clocks. These clock rate will be updated to SDPM.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdpm
+
+  reg:
+    items:
+      - description: RDPM hardware base address
+
+  clocks:
+    items:
+    minItems: 1
+    maxItems: 8
+    description: Different clock source
+
+  clock-names:
+    items:
+    minItems: 1
+    maxItems: 8
+    description: Different clock source name
+
+  csr-id:
+    $ref: '/schemas/types.yaml#/definitions/uint32-array'
+    description: SDPM CSR IDs matching the clock order mentioned in the
+                 clocks property.
+    minItems: 1
+    maxItems: 8
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - csr-id
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,camcc-sc7280.h>
+    #include <dt-bindings/clock/qcom,gcc-sc7280.h>
+    cx_sdpm@634000 {
+        compatible = "qcom,sdpm";
+        reg = <0x634000 0x1000>;
+        clocks = <&clock_camcc CAM_CC_IPE_0_CLK_SRC>,
+                <&clock_gcc GCC_GP1_CLK_SRC>;
+        clock-names = "cam_cc_ipe", "gcc_gp1";
+        csr-id = <5 7>;
+    };
+...
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

