Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE3C3EA9A7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbhHLRnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:43:02 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:16404 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236584AbhHLRnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:43:00 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17CHeLup002904;
        Thu, 12 Aug 2021 10:42:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=27km6BLaqTM88ajb5evxxkzs+BLoc/l1AZ4ZPx1/DFU=;
 b=jRHhJI+BQV9wup7+JxZK2b7nhzUd8l7I1o8Ga/ve9Dk/F4OYZc396DqrVaBnRf42gMtP
 QUyxdenxCyIEeja61AOW+Y/NMHcYhe2wD6bZjmC3FuiXkMHx5tYDoskOh6HHYlEXXHLz
 v89eWsHq4/VE176Q4KAXxFfK/97H7VpQPEc01FWjw3QqE9hhMCwZ9eyRQi5tdmaFPw+j
 vQxfbiR19imxqWTH56vnHhrK0WMfdJmAPsYzJRnjeOcT96M2ijU2/va6XCK26h4DcXLr
 ZR02sfto3Zsczm2dGso41AiI74QJ7nw1QPWzKhdbVjpRcdeulpVPEaDu9UddxOcNWV20 1g== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3acc8gdqyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Aug 2021 10:42:23 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 12 Aug
 2021 10:42:21 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Thu, 12 Aug 2021 10:42:21 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id EDF1B3F7041;
        Thu, 12 Aug 2021 10:42:18 -0700 (PDT)
From:   Bhaskara Budiredla <bbudiredla@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <sgoutham@marvell.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Subject: [PATCH 2/2] dt-bindings: perf: Add YAML schemas for Marvell CN10K LLC-TAD pmu bindings
Date:   Thu, 12 Aug 2021 23:12:09 +0530
Message-ID: <20210812174209.1970-3-bbudiredla@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210812174209.1970-1-bbudiredla@marvell.com>
References: <20210812174209.1970-1-bbudiredla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: FQ2EqYeWtfakl0bctM45vN-p1aw-8An7
X-Proofpoint-ORIG-GUID: FQ2EqYeWtfakl0bctM45vN-p1aw-8An7
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-12_05:2021-08-12,2021-08-12 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for Last-level-cache Tag-and-data
(LLC-TAD) unit PMU for Marvell CN10K SoCs.

Signed-off-by: Bhaskara Budiredla <bbudiredla@marvell.com>
---
 .../bindings/perf/marvell-cn10k-tad.yaml      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
new file mode 100644
index 000000000000..f66c5c31ecd8
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-tad.yaml
@@ -0,0 +1,45 @@
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
+    tad_pmu@0x87e280000000 {
+        compatible = "marvell,cn10k-tad-pmu";
+        tad-cnt = <1>;
+        tad-page-size = <0x1000>;
+        tad-pmu-page-size = <0x1000>;
+        reg = <0x87e2 0x80000000 0x0 0x1000>;
+    };
-- 
2.17.1

