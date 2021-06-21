Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39B13AF884
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 00:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhFUWeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 18:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhFUWeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 18:34:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9E3C061767
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 15:31:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id x24so32692889lfr.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 15:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWkLC+6IHo1LkiZQZtpwJkfJ4H3Gk2cOkMI7a3h8YO8=;
        b=AHJoQMSyw2F26sqRP070Z2DonSPoTif5Q8B2lrDRcKW5F1+eFXYk4G946n7T7XovwA
         HWzV6sHthnzp2WCvluiMwRQVU7N3PtyOt3lBX6SgjbPvYtoo4fiMlBcMnKum4WwDaI+p
         mFwAxgmEFRw9yZ6eP43t1a+EfWr/ttIxBCOrWwMbwVSh45YzlalARMd5D6Rxu58jij/y
         SMxp+75C/iJgqwx3HpSkseiqqbXWRWiQzCbfEN4KONNn0+tzR0NjTnUF1Y9KVSqiuQAz
         cO3+Voo+knC88V8IQQ97O+xQkgTEf+SGHeruwkZ1mD9CYv9CvNlWMWyCFLPpV5J+m2+L
         +cVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWkLC+6IHo1LkiZQZtpwJkfJ4H3Gk2cOkMI7a3h8YO8=;
        b=DS95ncXdzfXznPnhxOUWgN35MK6GP4g9c9IwNJ3xBWpIPZ4qQdBMy5JP7DiAmry/L9
         TpSaSPotvuRxd03rMklsXL0j9jzmbvB9s1rl4pgrr5mwrIJ2rRD+09BVZrI0P3wx7P47
         RAjp+fZSRSiz4QyE5PbcGGQrMmBQ0rowq1ezh+edVHtqACt3ex6oS31VQgOhs6qdcRii
         A40JR+Jk8vzk7jBHtFS89Xo+psckEMq+3UM/R6+AA+x3uTHbjxEsNnrahFggRufMmtfc
         vUhrKs0rj8OWctgNtaxXauyA0WPyth6TxgkwvHLhgSSapm7FMQeQq+TK+zd6DxggJVO1
         bUKA==
X-Gm-Message-State: AOAM531vDu/ZFvCgvX9/Rr1RsYiatBGlwXqRtZZscCsTy7eSoMy/hJyR
        8amv9bnmcJ4lWVPNcuwQ5D7zEg==
X-Google-Smtp-Source: ABdhPJxNpj4TgpZnpnlnxK/ZfqRpJ5ypI+6K9fjZQ0FuhIKOSIAj00srWAvfDxSh7VPDODP1pi+Ikg==
X-Received: by 2002:a19:ad44:: with SMTP id s4mr363796lfd.563.1624314705160;
        Mon, 21 Jun 2021 15:31:45 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b10sm2516025ljf.72.2021.06.21.15.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:31:44 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/7] dt-bindings: regulator: qcom,qca6390: add binding for QCA6390 device
Date:   Tue, 22 Jun 2021 01:31:35 +0300
Message-Id: <20210621223141.1638189-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210621223141.1638189-1-dmitry.baryshkov@linaro.org>
References: <20210621223141.1638189-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm QCA6390/1 is a family of WiFi + Bluetooth SoCs, with BT part
being controlled through the UART and WiFi being present on PCIe bus.
Both blocks share common power sources. Add binding to describe power
sequencing required to power up this device.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../bindings/regulator/qcom,qca6390.yaml      | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/qcom,qca6390.yaml

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390.yaml
new file mode 100644
index 000000000000..35315c521041
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/regulator/qcom,qca6390.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm QCA6390 WiFi + Bluetoot SoC bindings
+
+maintainers:
+  - Andy Gross <agross@kernel.org>
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+description: |
+  This binding describes thes Qualcomm QCA6390 or QCA6391 power supplies and
+  enablement pins.
+
+properties:
+  compatible:
+    const: qcom,qca6390
+
+  vddaon-supply:
+    description:
+      0.95V always-on LDO power input
+
+  vddpmu-supply:
+    description:
+      0.95V LDO power input to PMU
+
+  vddrfa1-supply:
+    description:
+      0.95V LDO power input to RFA
+
+  vddrfa2-supply:
+    description:
+      1.25V LDO power input to RFA
+
+  vddrfa3-supply:
+    description:
+      2V LDO power input to RFA
+
+  vddpcie1-supply:
+    description:
+      1.25V LDO power input to PCIe part
+
+  vddpcie2-supply:
+    description:
+      2V LDO power input to PCIe part
+
+  vddio-supply:
+    description:
+      1.8V VIO input
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    qca6390: qca6390 {
+      compatible = "qcom,qca6390";
+
+      vddaon-supply = <&vreg_s6a_0p95>;
+      vddpmu-supply = <&vreg_s2f_0p95>;
+      vddrfa1-supply = <&vreg_s2f_0p95>;
+      vddrfa2-supply = <&vreg_s8c_1p3>;
+      vddrfa3-supply = <&vreg_s5a_1p9>;
+      vddpcie1-supply = <&vreg_s8c_1p3>;
+      vddpcie2-supply = <&vreg_s5a_1p9>;
+      vddio-supply = <&vreg_s4a_1p8>;
+    };
+...
-- 
2.30.2

