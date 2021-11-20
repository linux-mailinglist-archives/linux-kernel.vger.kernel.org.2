Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D0C457DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 13:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbhKTMXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 07:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhKTMXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 07:23:35 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810FBC061574;
        Sat, 20 Nov 2021 04:20:32 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id v23so16375288iom.12;
        Sat, 20 Nov 2021 04:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7v/1LM3YhmWD/58/4APk/JcjWa5gVRYO7ANhdBBhJfg=;
        b=PDCnAlWpIt9M30Q0uyMNd88iWm9OhFqoMU9EWjaj7ZzaTmwevgAcXlG1iO967cTHdY
         spbBR8jSg2fNhAsKfCc4M3SS/pco1JGp6u6b856JU5vZyZVqrMFv+YGTKwKydWfFvGK2
         fBlgp2oXEwkrJ1ooXutrugu32VQ4haykxwfuf8W+P+7gp+W995iXV3sYvNCLFv4Blel6
         xrjXnwEU/UDApVQTxOANPApSA4mbc5h9ItqEeFpg6KO8ib6CJd7KEzqYTHPMXysdCFsG
         c2xQl8Z0bcKnW4xYkJw+e283JnT6qWBNnDWPWmGF/xAfFIIsHqUrvHz0fDWKS5XBXy0C
         aiSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7v/1LM3YhmWD/58/4APk/JcjWa5gVRYO7ANhdBBhJfg=;
        b=D/oNyAVVVIyY1+7ZnH2IAfm8XgAZS1AJR8vOBYXrbX5XOBCqGJpEjiUlN0ZSjqmDr6
         4qtOn3D6RN0XBLD5LR3tmGdbBinsothuLkLjkz5qsxFTGeRSHUckcWD8VF2P/H3dTXlP
         lrbl75E1KN8L++0fbZfyD2OjTSnhXsN6KF1ZzVPVaC20scP8WgCB/3bRfe0LkAjy6gk8
         +MEHWlNRwX5A+r/9Zgq71D52rO0knM7Wyj0mxTLqWosGoZpcRSTDlu3SInO08bpHwejC
         a0aFShHohfsrBz+4lJammnKnLbn3DWi7dsjBWcsqxtKfYoVmOP3YHgrR605DpkuSH8/+
         A6sQ==
X-Gm-Message-State: AOAM530s907PFg6EVaAwkqKPwy/Ayaw8XxMYjOb+qXxxvoz1ta/+OYKs
        dJI2JUfJ75GsZ82vtuHTu92DQ3AiNxGtKQ==
X-Google-Smtp-Source: ABdhPJydtOs5bKEne0N8GnBoZk4fVBejd/LHjHgM8gk9qXKfda1TOLYm7na4JnA3vOpq5okd3wUxig==
X-Received: by 2002:a02:ba8b:: with SMTP id g11mr34245775jao.128.1637410830037;
        Sat, 20 Nov 2021 04:20:30 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:48a3:a74f:1d99:b7f])
        by smtp.gmail.com with ESMTPSA id n12sm1984259ilk.80.2021.11.20.04.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 04:20:29 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        shawnguo@kernel.org, linux-kernel@vger.kernel.org,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>
Subject: [RESEND PATCH V5] dt-bindings: soc: imx: Add binding doc for spba bus
Date:   Sat, 20 Nov 2021 06:20:22 -0600
Message-Id: <20211120122022.1052768-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding doc for fsl,spba-bus.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
new file mode 100644
index 000000000000..e9f77ecae3d3
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/fsl,spba-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Shared Peripherals Bus Interface
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+description: |
+  A simple bus enabling access to shared peripherals.
+
+  The "spba-bus" follows the "simple-bus" set of properties, as
+  specified in the Devicetree Specification.  It is an extension of
+  "simple-bus" because the SDMA controller uses this compatible flag to
+  determine which peripherals are available to it and the range over which
+  the SDMA can access.  There are no special clocks for the bus, because
+  the SDMA controller itself has its interrupt, and clock assignments.
+
+select:
+  properties:
+    compatible:
+      contains:
+        const: fsl,spba-bus
+  required:
+    - compatible
+
+properties:
+  $nodename:
+    pattern: "^bus(@[0-9a-f]+)?$"
+
+  compatible:
+    items:
+      - const: fsl,spba-bus
+      - const: simple-bus
+
+  '#address-cells':
+    enum: [ 1, 2 ]
+
+  '#size-cells':
+    enum: [ 1, 2 ]
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+required:
+  - compatible
+  - '#address-cells'
+  - '#size-cells'
+  - reg
+  - ranges
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    bus@30000000 {
+        compatible = "fsl,spba-bus", "simple-bus";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x30000000 0x100000>;
+        ranges;
+    };
-- 
2.32.0

