Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE19458A25
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 08:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbhKVHz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 02:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238823AbhKVHzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 02:55:25 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08B7C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 23:52:19 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id o14so13353088plg.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 23:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dK9zEp2h1X8SwfyxTZtmguOz2O9z0yJUdo63B+VYpso=;
        b=umAo5D+2UV+4x5kE4QckX7B4F9sgB8RfPP4GyVrp7t9hzzRVjSJ5J1zZF602Ff93p2
         4YIBB7gFRZYsRCG7AaC+VCegbF6ygVHsEiQKaIN9l/bu7ZOP23n5sCGS5hncNLKq5i2l
         dxJdLCBXtmkSxMRZs0BzOugmt5cC+Ph3vZru+dhJ4zpLu7uge7STIgBsBmNHNZqaATg/
         nEpSuJe0EVRHq8hOBisIfrxS3K8RzwHAaGNLyZfxVWx6lF0aBarZkWFyXwU6NJiqIc0N
         CvmSlP2nZfxtsvFhm4YrhRA2SugjppfqLB6AfekF+95bDOxGNtAh/33V5o45FgXXKRXm
         +q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dK9zEp2h1X8SwfyxTZtmguOz2O9z0yJUdo63B+VYpso=;
        b=fBpQ7jcjY674gM1r4xrJieyuU9WS1e2TnAvqIoyX2beBeAo91D602DTYfoEQkFNnoq
         OZktV+ICW8TSKAphpM7fuUehHTQkVUAlrqm/SD0psQMwtetVDCeO9UsF4FYwR//5oCgm
         or44egARjO0StYdi9mIdURobfXs0SXlTF0Qe8DN6WrkbYrEjHZKE3yq0jyKBqPKCtB7H
         bfIPkPRwCUykncN2cDPoc4JhYljKVDkByAJ9dbL5JwsNHm5WKnlZOw6V5CQl+anYmquQ
         d/QbDwvffr1oMM2eOXm9iXVDMF2oHov1T2GifrgySvEOH3WsFsz0sFJOuoOqVNCmuIoR
         etlA==
X-Gm-Message-State: AOAM532la+tsZcuhu2BsitPxqT4LtKrAW/S6M7s7HNIukg2d2qf8dZup
        Z/h4hTa23yEJL/bXMn71i2qYdg==
X-Google-Smtp-Source: ABdhPJzOzkVUPasMbPEzWH+74a3EZA1yfI/chduJykoH5tERH9V4O9VFmcSB8DLrHanymaNXpuPVfg==
X-Received: by 2002:a17:90b:3e81:: with SMTP id rj1mr29325587pjb.111.1637567539249;
        Sun, 21 Nov 2021 23:52:19 -0800 (PST)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id bf13sm6355961pjb.47.2021.11.21.23.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Nov 2021 23:52:19 -0800 (PST)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 1/2] dt-bindings: interrupt-controller: Add Qualcomm MPM support
Date:   Mon, 22 Nov 2021 15:52:06 +0800
Message-Id: <20211122075207.20114-2-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211122075207.20114-1-shawn.guo@linaro.org>
References: <20211122075207.20114-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It adds DT binding support for Qualcomm MPM interrupt controller.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../interrupt-controller/qcom,mpm.yaml        | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
new file mode 100644
index 000000000000..32db89543f42
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,mpm.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/qcom,mpm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcom MPM Interrupt Controller
+
+maintainers:
+  - Shawn Guo <shawn.guo@linaro.org>
+
+description:
+  Qualcomm Technologies Inc. SoCs based on the RPM architecture have a
+  MSM Power Manager (MPM) that is in always-on domain. In addition to managing
+  resources during sleep, the hardware also has an interrupt controller that
+  monitors the interrupts when the system is asleep, wakes up the APSS when
+  one of these interrupts occur and replays it to GIC interrupt controller
+  after GIC becomes operational.
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: qcom,qcm2290-mpm
+
+  reg:
+    maxItems: 1
+    description:
+      Specifies the base address and size of vMPM registers in RPM MSG RAM.
+
+  interrupts:
+    maxItems: 1
+    description:
+      Specify the IRQ used by RPM to wakeup APSS.
+
+  mboxes:
+    maxItems: 1
+    description:
+      Specify the mailbox used to notify RPM for writing vMPM registers.
+
+  interrupt-controller: true
+
+  '#interrupt-cells':
+    const: 3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - mboxes
+  - interrupt-controller
+  - '#interrupt-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mpm_intc: interrupt-controller@45f01b8 {
+        compatible = "qcom,qcm2290-mpm";
+        interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+        reg = <0x45f01b8 0x1000>;
+        mboxes = <&apcs_glb 1>;
+        interrupt-controller;
+        #interrupt-cells = <3>;
+        interrupt-parent = <&intc>;
+    };
-- 
2.17.1

