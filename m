Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5129E3BF9D4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhGHMJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbhGHMJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:09:46 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A7FC061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 05:07:04 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id j184so5356885qkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 05:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQigZ31K//ojQpU2CgPxfETTC1keDSy5ChKl/mBuEPc=;
        b=L66cHNHo+i3NRBBDo1LjUaNJUq+ctcE2mc0hZVN6s/bIOIdiKvVZNtrHek4Jph6ruu
         i7UQyHjstzVCEaOV6dLNPNX8Cxck9xzaVH6tRGSvu3kPm0NzzdsPc+TIxqqIz+U7TmDG
         ZjY27WUGm0EOzrudOqSusu6UMkTlnZ1T9o8S2b/4TZZKgV4X6TX+j74BbPydJ4rDKk00
         wUbHwSBLH6HrEKwjaLmVkc2dAImmYnYn99/HtNNnGcXnvvyezrBaHyGTtcYE4hkUm5zp
         fCLDp9s92Ie6bA5A/p/r9sZEOAd+6Eho8CQk0C8kebEbNXToM8P+AwuzEJL8on6+zNX7
         VLhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQigZ31K//ojQpU2CgPxfETTC1keDSy5ChKl/mBuEPc=;
        b=R/3slG6Pre/5m+0cvESs4Buw97WcyqDQquGyg7RPYE+h9YtQGOl9Ovxjszw77NnLz/
         R0a3ERNUYiPGOtWO/nFUremag6jOEh/TqtrNbsV5+kCewzqiTcAe4Ox3mpM3WDWO/GWM
         EDL5vq2MOByR28NCB3kt+1a1/8fHQ5yOQ7kR/5LaF4bLPn+QLuSFiM4Dv7v7JYw0HW9v
         0qQk3R9x+Cmh3vpAs+08rDy+A6zafwhADYogSdQvJWMfMRhjdn9Qk+a48cUEBuHZy7b4
         ZsmwZgMG7iRMlF+oE4wnP7nIVRhj8H/aHn+Hy6i8cUGGcfKW1FIi0DXHDRHhgHDjTweT
         N/eA==
X-Gm-Message-State: AOAM533Bx1vm44n/UsLhYfd4utC1UCe/L/W1TW1V6iu+VDj0XjHrF2lp
        V0f4Vqc3K6DYWVM3NM45wHMj5g==
X-Google-Smtp-Source: ABdhPJy5C5v62Ra0cr8//8lURsSg9ZFvzFDflfgvITU+J/qi6fc/dO90JlZurBhQ7NAWcJGFTE+D7Q==
X-Received: by 2002:a05:620a:1402:: with SMTP id d2mr19803733qkj.86.1625746023680;
        Thu, 08 Jul 2021 05:07:03 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id i2sm912541qko.43.2021.07.08.05.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jul 2021 05:07:03 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org
Cc:     tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [Patch v3 6/6] dt-bindings: thermal: Add dt binding for QCOM LMh
Date:   Thu,  8 Jul 2021 08:06:56 -0400
Message-Id: <20210708120656.663851-7-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210708120656.663851-1-thara.gopinath@linaro.org>
References: <20210708120656.663851-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt binding documentation to describe Qualcomm
Limits Management Hardware node.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 .../devicetree/bindings/thermal/qcom-lmh.yaml | 100 ++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
new file mode 100644
index 000000000000..7f62bd3d543d
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright 2021 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/qcom-lmh.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Limits Management Hardware(LMh)
+
+maintainers:
+  - Thara Gopinath <thara.gopinath@linaro.org>
+
+description:
+  Limits Management Hardware(LMh) is a hardware infrastructure on some
+  Qualcomm SoCs that can enforce temperature and current limits as
+  programmed by software for certain IPs like CPU.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm845-lmh
+
+  reg:
+    items:
+      - description: core registers
+
+  interrupts:
+    maxItems: 1
+
+  '#interrupt-cells':
+    const: 1
+
+  interrupt-controller: true
+
+  qcom,lmh-cpu-id:
+    description:
+      CPU id of the first cpu in the LMh cluster
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  qcom,lmh-temperature-arm:
+    description:
+      An integer expressing temperature threshold in millicelsius at which
+      the LMh thermal FSM is engaged.
+    $ref: /schemas/types.yaml#/definitions/int32
+
+  qcom,lmh-temperature-low:
+    description:
+      An integer expressing temperature threshold in millicelsius at which
+      the LMh thermal FSM is engaged.
+    $ref: /schemas/types.yaml#/definitions/int32
+
+  qcom,lmh-temperature-high:
+    description:
+      An integer expressing temperature threshold in millicelsius at which
+      the LMh thermal FSM is engaged.
+    $ref: /schemas/types.yaml#/definitions/int32
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - #interrupt-cells
+  - interrupt-controller
+  - qcom,lmh-cpu-id
+  - qcom,lmh-temperature-arm
+  - qcom,lmh-temperature-low
+  - qcom,lmh-temperature-high
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interconnect/qcom,sdm845.h>
+
+    lmh_cluster1: lmh@17d70800 {
+      compatible = "qcom,sdm845-lmh";
+      reg = <0 0x17d70800 0 0x401>;
+      interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+      qcom,lmh-cpu-id = <0x4>;
+      qcom,lmh-temperature-arm = <65000>;
+      qcom,lmh-temperature-low = <94500>;
+      qcom,lmh-temperature-high = <95000>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+    };
+  - |
+    lmh_cluster0: lmh@17d78800 {
+      compatible = "qcom,sdm845-lmh";
+      reg = <0 0x17d78800 0 0x401>;
+      interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+      qcom,lmh-cpu-id = <0x0>;
+      qcom,lmh-temperature-arm = <65000>;
+      qcom,lmh-temperature-low = <94500>;
+      qcom,lmh-temperature-high = <95000>;
+      interrupt-controller;
+      #interrupt-cells = <1>;
+    };
+  - |
-- 
2.25.1

