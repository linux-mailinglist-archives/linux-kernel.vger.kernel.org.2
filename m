Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2761B410F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 07:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbhITFKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 01:10:14 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:8634 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231137AbhITFKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 01:10:13 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18K1TNkU010303;
        Sun, 19 Sep 2021 22:08:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=N8BXQyihx3ZPy28i2j87pJHPDtWuE2pahUxiG0X94l4=;
 b=B+1H3Sm84egFhhqELvSWDukAB7HRzq3zElvD9rJ2QjQ6sgLSKHI7JW1j6/ekop+Gm0nE
 d3DALCua28bV0KF94Kj6O+3q2YIPSpxplQnhA3z8o6vHMWwZOvdEVbpD/O3OfjzFdChE
 AmhuomMHrzAsEa6frduwk7klxLaCNj0291eSb9W70uf6AHT5Cuk4SY2SVSCOFbsfzBh7
 qrSOW5YM+CCdtrNOe13svsVduiIIFx1clzOVOdj3xQOMe3MHwkNs/WZfZen+Zym7B/7i
 m6cAKYg219fOXTtpk1QFKDs+SqVP42cy5TiShNy2Y6uC0nWbsO3sfm50U1IwYl9d3Bkg SA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 3b6gp7rdyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 19 Sep 2021 22:08:33 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 19 Sep
 2021 22:08:31 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 19 Sep 2021 22:08:29 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v4 1/4] dt-bindings: perf: marvell: cn10k ddr performance monitor
Date:   Mon, 20 Sep 2021 10:38:20 +0530
Message-ID: <20210920050823.10853-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210920050823.10853-1-bbhushan2@marvell.com>
References: <20210920050823.10853-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: TwBqF9Gbv3E8tLKBvaRGYx-_L9HPqwDo
X-Proofpoint-ORIG-GUID: TwBqF9Gbv3E8tLKBvaRGYx-_L9HPqwDo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-20_01,2021-09-17_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell CN10k DDR
performance monitor unit.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v3->v4:
 - Added Rob Herring reviewed-by
 
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

