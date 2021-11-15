Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D98451C78
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356678AbhKPASe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355255AbhKOXkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 18:40:36 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00F9C079784
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 14:39:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso425287wms.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 14:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1Q/HjMArhtuo02k7GLWNGyyYtLRk3Myme+ovH1z6fU=;
        b=PEfOiTKP+Ylx9gPfmeoZbPpmRoDTdZ5k3Y5pHJ9YT3x/7TNaqQsRWxF9L5LXjXFMuj
         w9J5DT+c8y89hmQbVzCPkLRngSIH0DRV7yzw1mhKT14qjGJuaabKLtktsJq+9ASFdC0L
         ii1QYQtw6SRaC9MiarBNQccxtuk1tWhgKuLM5EsfQGCkiR0pTC2HCbH3KZPWA2PS5CwA
         Pm1Ix2vSGPvg+h74aRgn8t1tzvMR428li1HYIh9TWqfzyPv/ullPbPVRyJJZ19lG+HUQ
         oHoMpXvfvdstTvMku5358jc5z83HizW3tANdiY4VyghC7lEB+zIMI34Y9rzbFysECIGy
         ojpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u1Q/HjMArhtuo02k7GLWNGyyYtLRk3Myme+ovH1z6fU=;
        b=GuVxyfDm0N6vrBDsFAnHan5W2WSXoHlgaUw5J8HbksQ2z/XGKOCQ8tpp/O9TS6aOgR
         O/ZlHV0RFSw504wkKOjtr7K7yWfFtOdewTiDvdU0VAnICBLq07HL3b6XJG8CM5ZMz6lo
         TjHIxEYPtPAQWEoLE8NW4NU80QSXey6hytaJl5WuH3ObA6JCRP402/V6+L0ADAmjJhTN
         RwRiFj4nB3CDYYW8piOThprJuiUq1HfqGdq4ZWuUxD38yD7TXRfHxWxoou6jBHWZD8dX
         RxfaQcMJIEH50tMkb6oXZKX5+hidVvGggU8DvkSuFPIGOB/wVCn3bSI/UTWINk8W74w3
         GSsA==
X-Gm-Message-State: AOAM533cnxxGYtzy6iA85ajkLoHS2mlC5I8Z5St4SAwKM/FFqeR8E/iv
        DbRdaT7K6C0Oi9RBTfAHsLNIeA==
X-Google-Smtp-Source: ABdhPJwJBTDYj5Rw+l1DFBHc9DfHj93owjNwFh60jkhJpWvTQAA/IYJGKMoDM5vrNj1Ysdk/kbmatg==
X-Received: by 2002:a05:600c:4e01:: with SMTP id b1mr2183672wmq.109.1637015987142;
        Mon, 15 Nov 2021 14:39:47 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:6870:334:c3a9:fed2])
        by smtp.gmail.com with ESMTPSA id n129sm533731wmn.36.2021.11.15.14.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 14:39:46 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     robh@kernel.org, arnd@kernel.org
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: [RFC] DT: bindings: Powerzone new bindings
Date:   Mon, 15 Nov 2021 23:39:11 +0100
Message-Id: <20211115223911.982330-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proposed bindings are describing a powerzone, a power capping
capable place to act on and where we can read the power
consumption. The powerzone semantic is also found on the Intel
platform with the RAPL register.

The powerzone can also represent a group of children powerzones, hence
the description can result on a hierarchy.

The description gives the power constraint dependencies to apply on a
specific group of logically or physically aggregated devices. They do
not represent the physical location or the power domains of the SoC
even if the description could be similar.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/power/power-zone.yaml | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/power-zone.yaml

diff --git a/Documentation/devicetree/bindings/power/power-zone.yaml b/Documentation/devicetree/bindings/power/power-zone.yaml
new file mode 100644
index 000000000000..b19ea399bd5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/power-zone.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/power-zone.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Power zones description
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@linaro.org>
+
+description: |+
+
+  A System on Chip contains a multitude of active components and each
+  of them is a source of heat. Even if a temperature sensor is not
+  present, a source of heat can be controlled by acting on the
+  consumed power via different techniques.
+
+  A powerzone describes a component or a group of components where we
+  can control the maximum power consumption. For instance, a group of
+  CPUs via the performance domain, a LCD screen via the brightness,
+  etc ...
+
+  Different components when they are used together can significantly
+  increase the overall temperature, so the description needs to
+  reflect this dependency in order to assign a power budget for a
+  group of powerzones.
+
+  This description is done via a hierarchy and the DT reflects it. It
+  does not represent the physical location or a topology, eg. on a
+  big.Little system, the little CPUs may not be represented as they do
+  not contribute significantly to the heat, however the GPU can be
+  tied with the big CPUs as they usually have a connection for
+  multimedia or game workloads.
+    
+properties:
+  $nodename:
+    const: powerzones
+    description:
+      A description
+
+  compatible:
+    const: powerzones
+
+  "#powerzone-cells":
+    description:
+      Number of cells in powerzone specifier. Typically 0 for nodes
+      representing but it can be any number in the future to describe
+      parameters of the powerzone.
+
+  powerzone:
+    description:
+      A phandle to a parent powerzone. If no powerzone attribute is set, the
+      described powerzone is the topmost in the hierarchy.
+
+required:
+  - compatible
+
+
+additionalProperties: true
+
+examples:
+  - |
+    POWERZONES: powerzones {
+      compatible = "powerzones";
+
+      SOC_PZ: soc {
+      };
+
+      PKG_PZ: pkg {
+        #powerzone-cells = <0>;
+        powerzone = <&SOC_PZ>;
+      };
+
+      BIG_PZ: big {
+        #powerzone-cells = <0>;
+        powerzone = <&PKG_PZ>;
+      };
+
+      GPU_PZ: gpu {
+        #powerzone-cells = <0>;
+        powerzone = <&PKG_PZ>;
+      };
+
+      MULTIMEDIA_PZ: multimedia {
+        #powerzone-cells = <0>;
+        powerzone = <&SOC_PZ>;
+      };
+    };
+
+  - |
+    A57_0: big@0 {
+      compatible = "arm,cortex-a57";
+      reg = <0x0 0x0>;
+      device_type = "cpu";
+      #powerzone-cells = <0>;
+      powerzone = <&BIG_PZ>;
+    };
+
+    A57_1: big@1 {
+      compatible = "arm,cortex-a57";
+      reg = <0x0 0x0>;
+      device_type = "cpu";
+      #powerzone-cells = <0>;
+      powerzone = <&BIG_PZ>;
+    };
+
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpu@ffe40000 {
+      compatible = "amlogic,meson-g12a-mali", "arm,mali-bifrost";
+      reg = <0xffe40000 0x10000>;
+      interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
+             <GIC_SPI 161 IRQ_TYPE_LEVEL_HIGH>,
+             <GIC_SPI 162 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "job", "mmu", "gpu";
+      clocks = <&clk 1>;
+      #powerzone-cells = <0>;
+      powerzone = <&GPU_PZ>;
+    };
+...
-- 
2.25.1

