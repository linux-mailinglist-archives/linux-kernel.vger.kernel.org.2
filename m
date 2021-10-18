Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A777A430EA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhJREXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:23:07 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:46630 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230155AbhJREXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:23:01 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19I3nlim024744;
        Sun, 17 Oct 2021 21:20:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=trPuSdj6kFnRKGY5CydKkqwuG+Ck/LV1kAREVa4qrOE=;
 b=E53UOd20AwMdsRJk7OWTPSY6q1i0octbQ+xtNZ+WhfdvYy4W18wRb2B+JVXJgwg4J1hK
 mIbQwKwwvDE4dMROfBwZHILcL0OQZ7bhePKhZUz1ZQE5aHtT+TBTIG1AROga6r+qZqtN
 XcNuHqg0384yynJaGhB8lN/rDdTE0ZeJf2K7MSejmQz/0NPP8kKwjEGc67v0ImN3zLm/
 OXfdDcubIJxGvJI7ABCFBXvqZEgEoiE13egVd1gYa6xYs6O8edWY0cupKw3aDOZ/G6I6
 WB+2yN1lCnD5oxHTczgADj/48CUTIlBCf/aY6bvh4AI3t8XBfjvJ8oqzUWsZN8Vc1il6 Tw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 3bs1bug2n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 17 Oct 2021 21:20:28 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 17 Oct
 2021 21:20:26 -0700
Received: from bbhushan2.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 17 Oct 2021 21:20:23 -0700
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <robh+dt@kernel.org>,
        <bbudiredla@marvell.com>, <sgoutham@marvell.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bharat Bhushan <bbhushan2@marvell.com>
Subject: [PATCH v5 1/4] dt-bindings: perf: marvell: cn10k ddr performance monitor
Date:   Mon, 18 Oct 2021 09:50:12 +0530
Message-ID: <20211018042015.25151-2-bbhushan2@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211018042015.25151-1-bbhushan2@marvell.com>
References: <20211018042015.25151-1-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: _wxsKHqv6YjWQhfmoZL9IdZhozX_GF68
X-Proofpoint-ORIG-GUID: _wxsKHqv6YjWQhfmoZL9IdZhozX_GF68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-18_01,2021-10-14_02,2020-04-07_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the Marvell CN10k DDR
performance monitor unit.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4->v5:
 - No Change

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

