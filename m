Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6F13FDE33
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245651AbhIAPCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:02:35 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:3410 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S245533AbhIAPC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:02:29 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181Ecpes026817;
        Wed, 1 Sep 2021 08:01:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=/zieIevQOzfCiGyZGvzZj0apgtfc4Zl0b4Xtn8N58qg=;
 b=k3sZAx2XROtIjgs20Yzzm5rVxzVWrIaclvXtd8HrlwApogOK9ZaHyKNXuwUXBSIVTigv
 9p5VGMca9okphQoldgxt8A2j4tvK0Vt5kMHlzbcHX9s+Q2g61DYmaziyfN/ssUp20WPm
 1wc7hLoJ/L10hfFmAkQuCdKQWzjjebSF9hHqTzxUkxg4PLeyxQiYddbHOaAEhlSzS/HX
 Rh6KKzXonBGuE4P9Gn1JK+oSXWTX8xwwn9Z3XXOk3PsdPLSFj+s3GlJ7Fx2tTuC5A60Z
 8L0h7Qfy7cxCO8npmHyasWCuSEKuopKft7aTNUMnHBQIEnJb+3Togui18qggTy0GQBTo dA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 3at34ptaaw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 08:01:23 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 1 Sep
 2021 08:01:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 1 Sep 2021 08:01:22 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 3906E3F7097;
        Wed,  1 Sep 2021 08:01:17 -0700 (PDT)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <sgoutham@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: [PATCH v4 2/2] dt-bindings: perf: Add YAML schemas for Marvell CN10K LLC-TAD pmu bindings
Date:   Wed, 1 Sep 2021 20:31:05 +0530
Message-ID: <20210901150105.18863-3-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210901150105.18863-1-bbudiredla@marvell.com>
References: <20210901150105.18863-1-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -fhQ1kOIWMXl00W9beeuAJ3HWElNoQ-v
X-Proofpoint-GUID: -fhQ1kOIWMXl00W9beeuAJ3HWElNoQ-v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-01_05,2021-09-01_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Last-level-cache Tag-and-data
(LLC-TAD) unit PMU for Marvell CN10K SoCs.

Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
---
 .../bindings/perf/marvell-cn10k-tad.yaml      | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
new file mode 100644
index 000000000000..18e9499f2df8
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
@@ -0,0 +1,60 @@
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
+  tad-cnt:
+    maxItems: 1
+
+  tad-page-size:
+    maxItems: 1
+
+  tad-pmu-page-size:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - tad-cnt
+  - tad-page-size
+  - tad-pmu-page-size
+  - reg
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
+            tad-cnt = <1>;
+            tad-page-size = <0x1000>;
+            tad-pmu-page-size = <0x1000>;
+            reg = <0x87e2 0x80000000 0x0 0x1000>;
+        };
+    };
-- 
2.17.1

