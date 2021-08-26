Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C81C3F8E35
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243409AbhHZSwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:52:44 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:22914 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231453AbhHZSwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:52:42 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17QINCie019302;
        Thu, 26 Aug 2021 11:51:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=vCYRSw9OOLlC8iQvCfI1Tgr57YWhiJ8jUcQ3Izu2bR8=;
 b=h6vM1efUyHOdCDnUeHeUbDmge1aTbTPcWML21MqXwBRXUZi/cn3Uh4NRnDlTluNh/Z1s
 tpEUYoade8HfXXK+/j0W4oZzzKiKRm6ThP8DqJ8wR666WYxh4nxGjlFX0N6j8hqI4OT5
 oJ7znnPM0iGf+rHVpB7jZSxj7HSLUXaa8DfBorDUpBY3XcQhwXq8x9XivklD/ii8EC1H
 Khpysb8ra/ZM5cs0jH5MB3bZJMyZ3CSHkxACV3j55LJC4lALvpm2ahJbsU6Pz8cZq6CJ
 LZj4986s+36C7JTa+PjIaWthnxZmjE/o5aYb0dRBzJa1dzLwwT1U82DDTCaus7vCukfy 2A== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3anty6muym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Aug 2021 11:51:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USbHhPTx1Tyh2UZB6n/r8lH3l+dSPHftw9/IMiaVMG2sbtU+IAQK2YcgJ3XTJ7dsiSMysUNy5T5okC5XxeB2aYNvMhyELmhdlK66Jc8pJSQ0JIQH2oHSBDUvcUdtkjLiYMnc7k0mDcId0sxD4EsjlUKKYYhFFeokZB1iVYLFNjMplDrMPvbTLs0fM+9iB/+dO1VMF65aJ1I6jDOU51Wq7Sg8tWOLaS46zGvWDm73nLM3yTD3A/PRH3jkp221IwN8ZXrGn7wk2YnMc5oyZwOET9aXR0xxeRF5dFma8bo2yTcYyUwE9FE7upwnQXMIv8ej/uiTG+oc1nkDwQuvT2Cixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCYRSw9OOLlC8iQvCfI1Tgr57YWhiJ8jUcQ3Izu2bR8=;
 b=lqe7v1em5b6enWSVVkx4BRoyeXHd9qU7ckt1v+l8rvp+xJlt+NZ5OJUGWowZXNEHmu+fSYzZe2+hoGcSFWtuciOLqeRT0sIhKyLqKXquWgyEepwSmy7y45zkRnxmoKsdoOFgbaOzBMPLJzO1oVQaza0dgE+SWEpjiaoHYaEmnY2/vqSTofysG7zj7nrpLBW1AoHu/G3pAUzHtgbY6wtdRJeZZxoiUf9v0B5T2TigBcjlKkTGGB3NzVRE7UcW1cwFupvC9zm+7sxT+kV+bDn0f+ARbVvJXLytAtQvQu0ARhPcFLWNCeiRr+Y/hLn4TF3NIkA4s+wwoUJRNnVBLRrCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCYRSw9OOLlC8iQvCfI1Tgr57YWhiJ8jUcQ3Izu2bR8=;
 b=6skLmX4PZqzv5ThdWLuAbZAptGR0ciezRboIkmOikpgI/QWhiFAuf8PJTeN1dwG5mm7vuHYUMvGnM9Xhw25vtwjWTP1zDpg1yGcM3Ge/FTP6flAC0ziQ8c3WN4gS08oNflEqEd6QSAq6TsFCxl2NAN1tdjrnW1Ilppea1r2p/IU=
Received: from DM6PR07CA0089.namprd07.prod.outlook.com (2603:10b6:5:337::22)
 by DM5PR07MB3547.namprd07.prod.outlook.com (2603:10b6:4:68::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19; Thu, 26 Aug
 2021 18:51:42 +0000
Received: from DM6NAM12FT032.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::b5) by DM6PR07CA0089.outlook.office365.com
 (2603:10b6:5:337::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Thu, 26 Aug 2021 18:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT032.mail.protection.outlook.com (10.13.178.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.8 via Frontend Transport; Thu, 26 Aug 2021 18:51:42 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 17QIpeAa011555
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 11:51:41 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 26 Aug 2021 20:51:39 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 26 Aug 2021 20:51:39 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 17QIpdT5026647;
        Thu, 26 Aug 2021 20:51:39 +0200
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 17QIpdXj026646;
        Thu, 26 Aug 2021 20:51:39 +0200
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <robh+dt@kernel.org>, <dkangude@cadence.com>, <vigneshr@ti.com>,
        <kishon@ti.com>
Subject: [PATCH v1] dt-bindings: ufshc: cdns: convert bindings for Cadence UFS host controller
Date:   Thu, 26 Aug 2021 20:51:35 +0200
Message-ID: <20210826185135.26599-2-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210826185135.26599-1-dkangude@cadence.com>
References: <20210826185135.26599-1-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e672e7d-9f77-4555-ace4-08d968c28b75
X-MS-TrafficTypeDiagnostic: DM5PR07MB3547:
X-Microsoft-Antispam-PRVS: <DM5PR07MB3547808BC5EC889CEDAFC6FACDC79@DM5PR07MB3547.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kvHBSzvCwWfIWw28t5MGc57o08R+d5+3sEIEDEb2FL0gTkIoE4Yz9R0TGJIkQ1H1XntJ8RbStwHjxkeBfzqZdF0agoPp6uMqadukKifToJZ5Vhyexycrtzew1VcFxHtwanxsUC/NrXcJihK59gLWWsUppyjhFuZr+pNTcpPGspMyPvfPo20FLEp1dItBJxrO5WLyEZV2FmgJTG4wuU6mG/YucimhUyYELeZ2lLKF62udoGL636rfiHsw26BgP3XRje8RKmN0J1MRFCejckLs/vYDRmDGaKUZ33I6RMpGS4/R560cJ1h23lnMi+HScthPUFL+eXdIXmnL8R//mvpcVzXnFnabG9XhQ70V3DCc13ZaUHbeS/ym0aWat9IwGtM0nubnO2E2Edxsp+tZPS3wpJE0AQ662gcw89F1DxV9uA2LVnC5HvLGjsd5jrJz9JExHRMteIBR4fqDGP9GA+7kAuya0m82MOSHqykylqkPN/9KyO/WFfqF90EhMkweuYQ2AgfRw80XNWvg9cUV3Pnv5LBlt27lbHS5XztlIFjM3LL1R94RzHu53OwZUXOlt81FlmWuj8wVrWBTgH6U5OL7dou6OlxIy8CsmuA6oQxXkE5uQoXyvPqH/l2cdFkPlNTJf74GqkoPhTe8IoUXBRduQ7XzBeKvUh0EKiU+ESxDbDBANEfzocfSPXaOQVfGacMCM8Kuvw+LpZDvXb/gAEm0FvfTc4lGRTMyechlV8HMwSeorXWV7QvSJqqD72H2sVtqDYG4YutmvKFhY1q8Dt+WZyV/x6gOiaHApcGZGraK5rCYjOWvbte5xl7KI9XfHtmj
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(36092001)(46966006)(36840700001)(36860700001)(82310400003)(83380400001)(47076005)(6916009)(356005)(336012)(70206006)(7636003)(70586007)(86362001)(36756003)(82740400003)(36906005)(6666004)(54906003)(8936002)(4326008)(5660300002)(316002)(478600001)(8676002)(1076003)(26005)(42186006)(2906002)(426003)(2616005)(966005)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 18:51:42.1475
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e672e7d-9f77-4555-ace4-08d968c28b75
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT032.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3547
X-Proofpoint-GUID: nfzEKx7cYZeC5aBbhNFdBx9lBy5hQkGb
X-Proofpoint-ORIG-GUID: nfzEKx7cYZeC5aBbhNFdBx9lBy5hQkGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-26_05,2021-08-26_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108260104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Converted bindings into yaml format for Cadence UFS host controller

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
---
 .../devicetree/bindings/ufs/cdns,ufshc.txt         |   32 --------
 .../devicetree/bindings/ufs/cdns,ufshc.yaml        |   80 ++++++++++++++++++++
 2 files changed, 80 insertions(+), 32 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
 create mode 100644 Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml

diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt b/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
deleted file mode 100644
index 02347b0..0000000
--- a/Documentation/devicetree/bindings/ufs/cdns,ufshc.txt
+++ /dev/null
@@ -1,32 +0,0 @@
-* Cadence Universal Flash Storage (UFS) Controller
-
-UFS nodes are defined to describe on-chip UFS host controllers.
-Each UFS controller instance should have its own node.
-Please see the ufshcd-pltfrm.txt for a list of all available properties.
-
-Required properties:
-- compatible	: Compatible list, contains one of the following controllers:
-			"cdns,ufshc" - Generic CDNS HCI,
-			"cdns,ufshc-m31-16nm" - CDNS UFS HC + M31 16nm PHY
-		  complemented with the JEDEC version:
-			"jedec,ufs-2.0"
-
-- reg		: Address and length of the UFS register set.
-- interrupts	: One interrupt mapping.
-- freq-table-hz	: Clock frequency table.
-		  See the ufshcd-pltfrm.txt for details.
-- clocks	: List of phandle and clock specifier pairs.
-- clock-names	: List of clock input name strings sorted in the same
-		  order as the clocks property. "core_clk" is mandatory.
-		  Depending on a type of a PHY,
-		  the "phy_clk" clock can also be added, if needed.
-
-Example:
-	ufs@fd030000 {
-		compatible = "cdns,ufshc", "jedec,ufs-2.0";
-		reg = <0xfd030000 0x10000>;
-		interrupts = <0 1 IRQ_TYPE_LEVEL_HIGH>;
-		freq-table-hz = <0 0>, <0 0>;
-		clocks = <&ufs_core_clk>, <&ufs_phy_clk>;
-		clock-names = "core_clk", "phy_clk";
-	};
diff --git a/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml b/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
new file mode 100644
index 0000000..4509ae0
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ufs/cdns,ufshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence Universal Flash Storage (UFS) Controller
+
+maintainers:
+  - Dhananjay Kangude <dkangude@cadence.com>
+
+description:
+  UFS nodes are defined to describe on-chip Cadence UFS host controllers.
+  Each UFS controller instance should have its own node.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - cdns,ufshc
+              - cdns,ufshc-m31-16nm
+          - const: jedec,ufs-2.0
+      - items:
+          - const: jedec,ufs-2.0
+
+  reg:
+    items:
+      - description: UFS controller register set
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    items:
+      - description: Description of core_clk
+      - description: Description of phy_clk
+      - description: Description of ref_clk
+
+  clock-names:
+    minItems: 1
+    items:
+      - const: core_clk
+      - const: phy_clk
+      - const: ref_clk
+
+  freq-table-hz:
+    $ref: /schemas/types.yaml#/definitions/uint64-matrix
+    description:
+      Clock frequency table.
+      See the ufshcd-pltfrm.txt for details.
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - freq-table-hz
+  - clocks
+  - clock-names
+
+additionalProperties: false
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    ufs: ufs@fd030000 {
+         compatible = "cdns,ufshc", "jedec,ufs-2.0";
+         reg = <0xfd030000 0x10000>;
+         interrupts = <0 1 IRQ_TYPE_LEVEL_HIGH>;
+         freq-table-hz = <0 0>;
+         clocks = <&ufs_core_clk>;
+         clock-names = "core_clk";
+    };
+
-- 
1.7.1

