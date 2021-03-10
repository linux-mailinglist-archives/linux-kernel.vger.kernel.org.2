Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCF2D334398
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233376AbhCJQs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:48:29 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:42085 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233320AbhCJQsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:48:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615394890; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=r6TRjTpCRDb9yjUJxiphCJZipSbMlGWfC8pqUsCCPfA=; b=MGKeGzNzTlz2IqmQBAIo+Aocjzvk9oTGMXm3/i7vRl2dt3IuNVl+aBUc1fHqp6IvB5oNNXqg
 h38R/dlRC1yf0Mj7n1yi2wAnyb8i+l+xQfQlah5Ax52sDoPAzxgdNl5SJt8g87eHJ9ZaCdgI
 QDUs86Xsm7tKiaqmvf/gWtG+Qz8=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6048f82f0c7cf0f56c7db6aa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Mar 2021 16:47:43
 GMT
Sender: schowdhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0B0CEC43464; Wed, 10 Mar 2021 16:47:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-525.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: schowdhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 06F6FC433C6;
        Wed, 10 Mar 2021 16:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 06F6FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=schowdhu@codeaurora.org
From:   Souradeep Chowdhury <schowdhu@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        sibis@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>, vkoul@kernel.org,
        Souradeep Chowdhury <schowdhu@codeaurora.org>
Subject: [PATCH V1 1/6] dt-bindings: Added the yaml bindings for DCC
Date:   Wed, 10 Mar 2021 22:16:32 +0530
Message-Id: <e33318b1b216bb0cb0a854e8d9cdd18dd5faca97.1615393454.git.schowdhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1615393454.git.schowdhu@codeaurora.org>
References: <cover.1615393454.git.schowdhu@codeaurora.org>
In-Reply-To: <cover.1615393454.git.schowdhu@codeaurora.org>
References: <cover.1615393454.git.schowdhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for Data Capture and Compare(DCC) device tree bindings
in yaml format.

Signed-off-by: Souradeep Chowdhury <schowdhu@codeaurora.org>
---
 .../devicetree/bindings/arm/msm/qcom,dcc.yaml      | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
new file mode 100644
index 0000000..b8e9998
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/msm/qcom,dcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Data Capture and Compare
+
+maintainers:
+  - Souradeep Chowdhury <schowdhu@codeaurora.org>
+
+description: |
+    DCC (Data Capture and Compare) is a DMA engine which is used to save
+    configuration data or system memory contents during catastrophic failure
+    or SW trigger. DCC is used to capture and store data for debugging purpose
+
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,sm8150-dcc
+      - const: qcom,dcc
+
+  reg:
+    items:
+      - description: DCC base register region
+      - description: DCC RAM base register region
+
+  reg-names:
+    items:
+      - const: dcc-base
+      - const: dcc-ram-base
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+additionalProperties: false
+
+examples:
+  - |
+    dcc@10a2000{
+                compatible = "qcom,sm8150-dcc","qcom,dcc";
+                reg = <0x010a2000  0x1000>,
+                      <0x010ad000  0x2000>;
+                reg-names = "dcc-base", "dcc-ram-base";
+    };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

