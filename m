Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16FF44FDF5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 05:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbhKOEi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 23:38:57 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:23566 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230319AbhKOEiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 23:38:23 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AF1t28O014999;
        Sun, 14 Nov 2021 20:35:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=sapoluduHjOGMwDz/WKzgkpSHkqvEQagjvWzUJ2+kUk=;
 b=Ai7nNAjRE/NeJYX0ifusPIM7DqLcO1wdqskn5NE/4Mt6+2sle6UQ3iT1mBuwYiffgHEM
 LNjz/0Foxo/Pv4VehsigHSLF3GWQtawD42rhBzcppih46Oos+Y6PbZIImwVRNSIqndOB
 pCm5R9fJLH0E1IMCWJElbaZzU37z6Nf5wFPPNJcY6S5hSNRjKvxpVK8kwqvxPUHTxmh4
 pubgqCMoBOVoC6ne73ETiBPbgxLpSqh1FEqfeRwct2IWxTeg9Z+zfRZbLzu741G43GeS
 7WSxr+t/Fn/3HDUu3u2P8NcP/MaBLUL4CikQlPsAE4L0rUrqnfFh7Bhq5ebfs+j/fxHc VQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3cbea8gf2c-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 14 Nov 2021 20:35:21 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 14 Nov
 2021 20:35:20 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 14 Nov 2021 20:35:19 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 628853F7075;
        Sun, 14 Nov 2021 20:35:17 -0800 (PST)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbhushan2@marvell.com>, <sgoutham@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: [PATCH v7 2/2] dt-bindings: perf: Add YAML schemas for Marvell CN10K LLC-TAD pmu bindings
Date:   Mon, 15 Nov 2021 10:05:06 +0530
Message-ID: <20211115043506.6679-3-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115043506.6679-1-bbudiredla@marvell.com>
References: <20211115043506.6679-1-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: RauBKABmIo5qatrMMKTMIUyk32Ukw38X
X-Proofpoint-ORIG-GUID: RauBKABmIo5qatrMMKTMIUyk32Ukw38X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_03,2021-11-12_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Last-level-cache Tag-and-data
(LLC-TAD) unit PMU for Marvell CN10K SoCs.

Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
---
 .../bindings/perf/marvell-cn10k-tad.yaml      | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
new file mode 100644
index 000000000000..362142252667
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/marvell-cn10k-tad.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell CN10K LLC-TAD performance monitor
+
+maintainers:
+  - Bhaskara Budiredla <bbudiredla@marvell.com>
+
+description: |
+  The Tag-and-Data units (TADs) maintain coherence and contain CN10K
+  shared on-chip last level cache (LLC). The tad pmu measures the
+  performance of last-level cache. Each tad pmu supports up to eight
+  counters.
+
+  The DT setup comprises of number of tad blocks, the sizes of pmu
+  regions, tad blocks and overall base address of the HW.
+
+properties:
+  compatible:
+    const: marvell,cn10k-tad-pmu
+
+  reg:
+    maxItems: 1
+
+  marvell,tad-cnt:
+    description: specifies the number of tads on the soc
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  marvell,tad-page-size:
+    description: specifies the size of each tad page
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  marvell,tad-pmu-page-size:
+    description: specifies the size of page that the pmu uses
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - marvell,tad-cnt
+  - marvell,tad-page-size
+  - marvell,tad-pmu-page-size
+
+additionalProperties: false
+
+examples:
+  - |
+
+    tad {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        tad_pmu@80000000 {
+            compatible = "marvell,cn10k-tad-pmu";
+            reg = <0x87e2 0x80000000 0x0 0x1000>;
+            marvell,tad-cnt = <1>;
+            marvell,tad-page-size = <0x1000>;
+            marvell,tad-pmu-page-size = <0x1000>;
+        };
+    };
-- 
2.17.1

