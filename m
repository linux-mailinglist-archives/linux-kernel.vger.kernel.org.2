Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35E2B3F454A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 08:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhHWGw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 02:52:29 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:46186 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234817AbhHWGw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 02:52:27 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N0oCXn000661;
        Sun, 22 Aug 2021 23:51:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=uhS765bGkGKUc1/cTsPax6Gf0t+nUdYbcI3apoaImys=;
 b=fW4OQGCHS+wHm2ntDfrSoM9jtCXridzPJoRBT5tkC5yQjYwZUMLhZdTUiVXd/9voEWZ/
 l6gZLZLUr9Vrzr41mehEGB9LmbYDtg2C7xpqVfMgdDsGRKgoeZU5UkMNG0F/urWUXBVj
 6VwIR+8g0Y1KGl9jKjMJJ6N646flbLjxgRir1KhWJjew8BUIAp+O+ZuOC0T4aihqBLh/
 gNM893pvpmvnj2HXmaG2E/3qig5e/Zig0B43tRdZt/fpDk/l9s6wISfSEBVgWCqGCZMI
 DIMg3YB8N0rApYaPAOz2UCrQQjgrS7Slz9zaFk4DRAZZwGXG36qVYwFzlOBvPN62Vke2 yw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3am1fk0x7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 22 Aug 2021 23:51:34 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Sun, 22 Aug
 2021 23:51:32 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.23 via Frontend
 Transport; Sun, 22 Aug 2021 23:51:29 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v3 1/4] dt-bindings: perf: marvell: cn10k ddr performance monitor
Date:   Mon, 23 Aug 2021 12:21:18 +0530
Message-ID: <20210823065121.19494-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210823065121.19494-1-bbhushan2@marvell.com>
References: <20210823065121.19494-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: GtZ1MnaGX3EXI3tfrto4Wl312LGT-Mmn
X-Proofpoint-ORIG-GUID: GtZ1MnaGX3EXI3tfrto4Wl312LGT-Mmn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-23_02,2021-08-20_03,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell CN10k DDR
performance monitor unit.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v2->v3:
 - dt-binding, ddrcpmu@1 -> pmu@87e1c0000000

v1->v2:
 - DT binding changed to new DT Schema

 .../bindings/perf/marvell-cn10k-ddr.yaml      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
new file mode 100644
index 000000000000..a18dd0a8c43a
--- /dev/null
+++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/perf/marvell-cn10k-ddr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell CN10K DDR performance monitor
+
+maintainers:
+  - Bharat Bhushan <bbhushan2@marvell.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - marvell,cn10k-ddr-pmu
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pmu@87e1c0000000 {
+            compatible = "marvell,cn10k-ddr-pmu";
+            reg = <0x87e1 0xc0000000 0x0 0x10000>;
+        };
+    };
-- 
2.17.1

