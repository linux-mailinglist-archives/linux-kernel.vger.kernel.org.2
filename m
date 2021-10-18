Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D87E4322E2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbhJRPdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:33:40 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:41694 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232873AbhJRPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:33:37 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19ICZjlj024862;
        Mon, 18 Oct 2021 08:31:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=jy4TwJEBCPRMe5vulxhExR85LubWgOaHFQR5ZHIt5dI=;
 b=Yqx2wKO4sby1+Gkmo5EgnKIVQ5I//g/U8pfRnvb8FH5Vi2bL6LiKEEbkQaUMqV4Lk14s
 jiEMYSoor3xaDLtQfbzncFEm9cWmlNr/24lpyf2fJQt1oo/Ct7YCNsA31rgLonyppQVr
 UmkyRKyWAkrvOxh7oHQbIWbPsNsvHFaGnyCrw2wydMS1ja0vsjJwe5YyrvWMzEg/4WgZ
 Zs7TUH9U7fv9xgFmPj/a8i23hgBD4pdpwuhI1TscgQ42kIK2PXkw9cFeU50ShUM0PbeE
 Vu8/MRxPo+scNQiSKjnLV5bYKHClgNQqo4bLOQinJFSib0Tn3gg+id6EvB6W85ZSgvXD NA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bs1bujjkt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 18 Oct 2021 08:31:20 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 18 Oct
 2021 08:31:19 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 18 Oct 2021 08:31:19 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id C4A9D5E686D;
        Mon, 18 Oct 2021 08:31:16 -0700 (PDT)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbhushan2@marvell.com>, <sgoutham@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: [PATCH v6 2/2] dt-bindings: perf: Add YAML schemas for Marvell CN10K LLC-TAD pmu bindings
Date:   Mon, 18 Oct 2021 21:00:57 +0530
Message-ID: <20211018153057.23217-3-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211018153057.23217-1-bbudiredla@marvell.com>
References: <20211018153057.23217-1-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: GLOcLTou7Haztzxn9EEWOZ1183O8kbBt
X-Proofpoint-ORIG-GUID: GLOcLTou7Haztzxn9EEWOZ1183O8kbBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_07,2021-10-18_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Last-level-cache Tag-and-data
(LLC-TAD) unit PMU for Marvell CN10K SoCs.

Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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

