Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F90A345DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhCWMIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:08:55 -0400
Received: from foss.arm.com ([217.140.110.172]:45242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhCWMHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:07:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B75E106F;
        Tue, 23 Mar 2021 05:07:42 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 795323F719;
        Tue, 23 Mar 2021 05:07:40 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, anshuman.khandual@arm.com, maz@kernel.org,
        catalin.marinas@arm.com, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v5 19/19] dts: bindings: Document device tree bindings for Arm TRBE
Date:   Tue, 23 Mar 2021 12:06:47 +0000
Message-Id: <20210323120647.454211-20-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210323120647.454211-1-suzuki.poulose@arm.com>
References: <20210323120647.454211-1-suzuki.poulose@arm.com>
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
index 3454ed1011c8..fbe863456ed1 100644
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

