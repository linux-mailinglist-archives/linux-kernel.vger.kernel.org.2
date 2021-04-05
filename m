Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E331435458D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242739AbhDEQo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:44:28 -0400
Received: from foss.arm.com ([217.140.110.172]:56150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242697AbhDEQoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:44:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 164AA31B;
        Mon,  5 Apr 2021 09:44:05 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CE523F694;
        Mon,  5 Apr 2021 09:44:03 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     maz@kernel.org, mathieu.poirier@linaro.org
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, anshuman.khandual@arm.com,
        mike.leach@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, leo.yan@linaro.org, robh@kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v6 20/20] dts: bindings: Document device tree bindings for Arm TRBE
Date:   Mon,  5 Apr 2021 17:43:07 +0100
Message-Id: <20210405164307.1720226-21-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210405164307.1720226-1-suzuki.poulose@arm.com>
References: <20210405164307.1720226-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the device tree bindings for Trace Buffer Extension (TRBE).

Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../devicetree/bindings/arm/trbe.yaml         | 49 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml

diff --git a/Documentation/devicetree/bindings/arm/trbe.yaml b/Documentation/devicetree/bindings/arm/trbe.yaml
new file mode 100644
index 000000000000..4402d7bfd1fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/trbe.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+# Copyright 2021, Arm Ltd
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/arm/trbe.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: ARM Trace Buffer Extensions
+
+maintainers:
+  - Anshuman Khandual <anshuman.khandual@arm.com>
+
+description: |
+  Arm Trace Buffer Extension (TRBE) is a per CPU component
+  for storing trace generated on the CPU to memory. It is
+  accessed via CPU system registers. The software can verify
+  if it is permitted to use the component by checking the
+  TRBIDR register.
+
+properties:
+  $nodename:
+    const: "trbe"
+  compatible:
+    items:
+      - const: arm,trace-buffer-extension
+
+  interrupts:
+    description: |
+       Exactly 1 PPI must be listed. For heterogeneous systems where
+       TRBE is only supported on a subset of the CPUs, please consult
+       the arm,gic-v3 binding for details on describing a PPI partition.
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+examples:
+
+  - |
+   #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+   trbe {
+     compatible = "arm,trace-buffer-extension";
+     interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
+   };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 2a20a36c724a..471d04bb2d5e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1762,6 +1762,7 @@ F:	Documentation/devicetree/bindings/arm/coresight-cpu-debug.txt
 F:	Documentation/devicetree/bindings/arm/coresight-cti.yaml
 F:	Documentation/devicetree/bindings/arm/coresight.txt
 F:	Documentation/devicetree/bindings/arm/ete.yaml
+F:	Documentation/devicetree/bindings/arm/trbe.yaml
 F:	Documentation/trace/coresight/*
 F:	drivers/hwtracing/coresight/*
 F:	include/dt-bindings/arm/coresight-cti-dt.h
-- 
2.24.1

