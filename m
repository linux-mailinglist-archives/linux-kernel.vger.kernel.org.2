Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619553FE960
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 08:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbhIBGjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 02:39:22 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:8918 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242445AbhIBGjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 02:39:08 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1820Qpau011828;
        Wed, 1 Sep 2021 23:38:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=V5BGAeTZSKbl+/fOH2bq6LyLi0s3uo/qRtc7+WmGfvU=;
 b=Tni8xLkjWji8rcZ9hx2TFXvr8HYkmoejxfB7vjwllomtv1TSldKWUvTjjIy1FJ+Gr/hx
 okPqTqLD5om+uwbLhm0Mr+bRLZRe0jxTuIrg1yVfixDCxpbLy5g91K2xuLEVXi0oB7t8
 mxv65TB6YzS+9a47XztumTyv8ZDK5Qt4WQ5BCdGrasXgRaFsWuEUo24EfKXQJlBw9uhH
 SGfwKeaEGW2ZdAR6bFBvwEOCX6jLQbiDmIBsN0AM2Ff/3izZGeU4wkNKdTaf9EtVEqAg
 leekBkYZUqXDfZusRIce7FSf/zS/zORu3Zo5qiglI+RTc6FRt0LiLMkjGJWNKgAXGpMO iQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3atdvya7dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Sep 2021 23:38:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b0ElTS+/xkap6EGElt0+4f6uRVj63yaV1GsHSoYdKPy3fcbqPWRp06KZLdCpy8mpvGVeN2xIF8+mGlL2bIW/s5b7vmh3NwZ2Stw57xOboR4uMtHzRFXV4wCNFcjKrOzQXJQyofHVE3ycXy96kxzcye0j9tFZWlny/BHMf4VIRRWCQneDS8YTOJ3aIPY49NBQZwv/Nt9PWaml32f337RyNK+eLuR79flfdz8bX21GCr2rVRXYKsYYRH3etUCtfGn/FkktnfIh9dI0aiSuOoKm2TGzPAIonMl6ehtnxbWumbL1LozYkushF9VnK1eZQZAe9OfjF/IV5cDtzU3WLuLcnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5BGAeTZSKbl+/fOH2bq6LyLi0s3uo/qRtc7+WmGfvU=;
 b=Ea7IwDk6iQ0mUpCuBCQYs6PY0iqn0Z8As4CsQlIj3UCD0Oet3Xg4ySD0ruvuyy0g3zYw3R4iknxlitzRpizYEPhoFI980XuYTpan31UClRCckfpsiZuWFOCNbOM9NBi7aNbf1X8veXQf5yyDfVdZIKex5pYPo1dFnlzdRW7RdzTZYNbaZ4QOo4uzmfQHFF6M9UZgwdtYY42A1LwFrRaa4rUSuyrCIwvRDyw9AMpp0C1AIqWJaty+M3HbiYeme188MNaa85OSr0G0inOyzN5bz2aOlq6crcAVvFK+R+fud7qHAOjjNDgtRAzZ6AS1RdxHqOU7LhAg9OiYFatNizXxSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5BGAeTZSKbl+/fOH2bq6LyLi0s3uo/qRtc7+WmGfvU=;
 b=fGRc2oQIdtCdXjWIwZOdO0YNBfiBOtk9cCuXfk7ol3oVbKWN5qFaFX8Oh08j0UbVRTLJU6n2yDjO9H0cpKOXyyaEc/saSG7fqNRWcakdrHgnOCNYqotE/QtZJcYZPqbzJETJxQMKHwE3OzixyJWWColN8ZUQd4psAf7IShU3nx0=
Received: from MW4PR03CA0015.namprd03.prod.outlook.com (2603:10b6:303:8f::20)
 by CH0PR07MB8962.namprd07.prod.outlook.com (2603:10b6:610:eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 2 Sep
 2021 06:38:05 +0000
Received: from MW2NAM12FT035.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::5c) by MW4PR03CA0015.outlook.office365.com
 (2603:10b6:303:8f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Thu, 2 Sep 2021 06:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT035.mail.protection.outlook.com (10.13.181.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Thu, 2 Sep 2021 06:38:03 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 1826c1RW184155
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 1 Sep 2021 23:38:03 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 08:38:00 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 1 Sep 2021 23:38:00 -0700
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 2 Sep 2021 08:38:00 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1826c0Ik009561;
        Thu, 2 Sep 2021 08:38:00 +0200
Received: (from dkangude@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1826c054009560;
        Thu, 2 Sep 2021 08:38:00 +0200
From:   Dhananjay Kangude <dkangude@cadence.com>
To:     <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <robh+dt@kernel.org>, <dkangude@cadence.com>, <vigneshr@ti.com>,
        <kishon@ti.com>
Subject: [PATCH v2] dt-bindings: ufshc: cdns: convert bindings for Cadence UFS host controller
Date:   Thu, 2 Sep 2021 08:37:54 +0200
Message-ID: <20210902063754.9509-2-dkangude@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210902063754.9509-1-dkangude@cadence.com>
References: <20210826185135.26599-2-dkangude@cadence.com>
 <20210902063754.9509-1-dkangude@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a758dd2f-27aa-414f-a364-08d96ddc376a
X-MS-TrafficTypeDiagnostic: CH0PR07MB8962:
X-Microsoft-Antispam-PRVS: <CH0PR07MB8962C9C49C18ED50B4F481E4CDCE9@CH0PR07MB8962.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S2XyDHO6NcNdzqhZWtz937EjXGWQwkINIyX+mALKteW7oZziqujXLdmENaKc8CIBEGXjRY2Flw/vsp0NQm9Fvl8yds7h7lbGUPgBCP3wHK21+GvHrrHP4pDh8RMuq9gI7sP8BsHNmUK7SnSZ2x2iZ4Y1ALRp2VshS0U1KJoAbDxslMGZq2P2eMf0HvvjhaOvqPvwFUyul+UIl1f+wCRhFpD1ljCX4wazI4kbVF+LPEwE3d0i5mbukGYZY8oV0zEVhl6lB756R7HU/noXIMI7sCFlcWjE++RHd3J3EySGSYemp5Wp49SAY9DlTms7wL0pudzix0jkF4hw1nlkWvxJwM5MYCxqP6qvlwv6d1u5+wYJ9FNLcRXpVszmN2aodL2sxrhMZdaxw5rM8ogVu+3XfXTMXS2s92/S3k1T+oL0+isNI+GZbsEl1ZZvYu+PZ3MwAx4GGbzyIm6Y0GFvmfezhDgXwgHN4vOpldQjAQ8ZALYF5gYXTHyg1SA2GEsAsOTaxUvwORp0sND9CgcmY8jnjqzGvvSAlheFrUB0vLIabnVCJpBYfQIjDErq6tUx+Zpobaaz0CcYbjPyhCNKJlGI0Q7cjXODGPR9Tk9epw0quH1LMClZ11hVoxIYe028pkywpFHLWtpvWA2DjhaA1KkBnsG3Bbq1dJDjo1GFjHYtNQ+dciqSXWXTM1hcQitWQvdSQqzOHnA0tgYIv6FqpnADzaM43FLWXM4/opSwnRh/toLOTFx9SN1zrL8OrPx1Wiu0IzCW5zH67V0a/t6VxMWc9Mk0ABUBe9kx4SFzdBgpiTSt7qnMlz8RWhrAerQTEEKXIYYdOQo4oCvBv32UNJqvcdP74+bYCITQGYrT9GOHdjA=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(316002)(2906002)(1076003)(70586007)(54906003)(36756003)(6916009)(5660300002)(8936002)(83380400001)(47076005)(6666004)(36860700001)(42186006)(2616005)(86362001)(186003)(336012)(81166007)(426003)(4326008)(8676002)(356005)(82310400003)(26005)(508600001)(966005)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 06:38:03.9074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a758dd2f-27aa-414f-a364-08d96ddc376a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT035.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR07MB8962
X-Proofpoint-GUID: HY-r-EwkI0UfvGZBEFpxjLTlH8t1R9MY
X-Proofpoint-ORIG-GUID: HY-r-EwkI0UfvGZBEFpxjLTlH8t1R9MY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-02_02,2021-09-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1.Converted bindings into yaml format for Cadence UFS host controller
2.Modified reference to cdns,ufshc.txt tp cdns,ufshc.yaml
3.Removed power,domain property from ti,j721e-ufs.yaml as it is not required

Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
---
 .../devicetree/bindings/ufs/cdns,ufshc.txt         |   32 --------
 .../devicetree/bindings/ufs/cdns,ufshc.yaml        |   80 ++++++++++++++++++++
 .../devicetree/bindings/ufs/ti,j721e-ufs.yaml      |    3 +-
 3 files changed, 81 insertions(+), 34 deletions(-)
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
diff --git a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
index 4d13e6b..b8f73dd 100644
--- a/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/ti,j721e-ufs.yaml
@@ -50,7 +50,7 @@ patternProperties:
     type: object
     description: |
       Cadence UFS controller node must be the child node. Refer
-      Documentation/devicetree/bindings/ufs/cdns,ufshc.txt for binding
+      Documentation/devicetree/bindings/ufs/cdns,ufshc.yaml for binding
       documentation of child node
 
 additionalProperties: false
@@ -81,7 +81,6 @@ examples:
                 reg = <0x0 0x4000 0x0 0x10000>;
                 interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
                 freq-table-hz = <19200000 19200000>;
-                power-domains = <&k3_pds 277>;
                 clocks = <&k3_clks 277 1>;
                 assigned-clocks = <&k3_clks 277 1>;
                 assigned-clock-parents = <&k3_clks 277 4>;
-- 
1.7.1

