Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2998E403977
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351647AbhIHMF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:05:58 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:61800 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351616AbhIHMFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:05:54 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1889r4fM000992;
        Wed, 8 Sep 2021 05:04:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=0GDP81HOhy8NDh4nKMkex8xLDckIM1Ua14J13VJZ7mk=;
 b=KW/8hnNN78LNAk2qI50noempgcKzZRgkZlDo2jj1CaLYFkcyVUykw0FcFDpeNcTyrL7I
 gKWsO3Xt8YDXRqzmkjF6Yyjjy6b1Pkh9yZK3KD2hlfk9L0wnKDAc9mZfSLft1W3Ae9BX
 lUxKJ/r7xDiSL/YE068sx1hytjCCvhMSiHHSyS2S3PVRjzWb8gEk3tFJwUILIsYV8xfq
 6reMG/3H7A/F/eoaQPuEl2JmfLtpYn/Wsli+DiYDmw2ceDgfy4vu8Y4bR6EMzaSP82Bl
 mOlz8PvmcQ+LlUtqMov9fmDndujVJhpUR1zUENCM+8b1IhCZxlw47vgLUR9xP6V9jIdh PA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3axtxc0d1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:04:39 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 8 Sep
 2021 05:04:37 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 8 Sep 2021 05:04:37 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 9E13F3F7095;
        Wed,  8 Sep 2021 05:04:34 -0700 (PDT)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <sgoutham@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: [PATCH v5 2/2] dt-bindings: perf: Add YAML schemas for Marvell CN10K LLC-TAD pmu bindings
Date:   Wed, 8 Sep 2021 17:34:25 +0530
Message-ID: <20210908120425.10084-3-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210908120425.10084-1-bbudiredla@marvell.com>
References: <20210908120425.10084-1-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 81MJZkQbH2mQjy9baK98PMyHk-NR8_Ro
X-Proofpoint-GUID: 81MJZkQbH2mQjy9baK98PMyHk-NR8_Ro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_05,2021-09-07_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Last-level-cache Tag-and-data
(LLC-TAD) unit PMU for Marvell CN10K SoCs.

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

