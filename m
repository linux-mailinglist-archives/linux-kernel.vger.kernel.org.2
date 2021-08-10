Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4281E3E5747
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbhHJJnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:43:53 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:13132 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237358AbhHJJnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:43:51 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A9evHR020623;
        Tue, 10 Aug 2021 02:43:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=m/Kttqx7tptrwgdTWJLLkEv6oj3pULXzpL11xkNv8DY=;
 b=jRl4JjlknELbQCC0qJEIabWiMjkr9G6+P0qXw3dHDYEKNLTQv8br7Kg4mCH88bN+F4px
 eiQHE0XuTCE2LT6lPKorJwX63pRd5lu/BTYYR0gbIbYq+w6H/lkwTev6PC8y/epEfNRx
 f9Cee8GolA8NF5opchEYjqq5IPr+CWWMttUQppaPw2DxiyrcSGEOsHuxMM4zYZ2cxFxe
 G4EIV1PVuqz5fZe0+jbrcAzk8dynTM+3/DNnoqBqzTxcfgm5mUhFcMmKpGSv9FMmuDIx
 772TzcKFhOig8bVWVz9Rr5hct39B9iV+fcPZTCw305nPbNnZh/wlPEvov+SzJF6P6yYM uA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 3aaxfkmbx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 02:43:20 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 10 Aug
 2021 02:43:18 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Tue, 10 Aug 2021 02:43:15 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v2 1/4] dt-bindings: perf: marvell: cn10k ddr performance monitor
Date:   Tue, 10 Aug 2021 15:13:04 +0530
Message-ID: <20210810094307.29595-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210810094307.29595-1-bbhushan2@marvell.com>
References: <20210810094307.29595-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: H1JZiQiWGPzi7JBDKa9tzIMonBBP2JNw
X-Proofpoint-GUID: H1JZiQiWGPzi7JBDKa9tzIMonBBP2JNw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_03:2021-08-06,2021-08-10 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell CN10k DDR
performance monitor unit.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
---
v1->v2:
 - DT binding changed to new DT Schema

 .../bindings/perf/marvell-cn10k-ddr.yaml      | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml

diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
new file mode 100644
index 000000000000..2a335444cf53
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
+        ddrcpmu@1 {
+            compatible = "marvell,cn10k-ddr-pmu";
+            reg = <0x87e1 0xc0000000 0x0 0x10000>;
+        };
+    };
-- 
2.17.1

