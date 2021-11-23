Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931C145A647
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbhKWPNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:13:00 -0500
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:39933
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232341AbhKWPM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:12:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpFmLcmXMt20GQ/C+PP8DT9XjE3GKvL2J7P45Dpq09ahuKQYvEsMF2MS8MUiEjBtKSB1sODw6g9I/pA/6c/K09+el2cATLok6Pc9UCe58A7gLcw7bhIPQovw0ICwzmUw2OQgAH5JHGyOpSFG944EZ2CevA+XD9D1zcVBf/I47dK0VYkbCiQWxDvsZ9TTyzLYt+CEC7xiNijE3AvbFKkXry+Q7zA/p3treLE9IquP6ewugZG5yso8TCvuXJgXL21mesVHVZ5f6+JoqZ7JCcONcb9ncDLlhCMMly4aZwFSbTfYW84Qh7IVMA8/lgqp7ErBz3YhUbcXj0eAMVvo3HASuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jorU0BSxqv32dirO9a3rJPX8L5oCusFdd6PVwILaB58=;
 b=eTHBGUokVhasy0xZ5yTPa24R1XyX0alSLnhXhugzCSBlj96hw/AfH4eDcqVFRwtxgG5Q8O7vQmBxXGwOVuEfe6BTaAOcYy/ssJiL85PDX2CkylgHmnjymv0IsuQqlUIRQNK4Tpj5gcLA9fFF5T83Fqaw7B/s71H6I64WAcCZ1wpmP9p8AcUlZdsiMsvD9OdehRKVf3yN1o9XbKs2HIw90a3AcjoqYpM44jiRH8UOwOYRxltt4r5RRz8nepNxEejGFtFXjnUECzf9zbxxcv9zpQnB5vAONxZ+a3s7Jxu6YeONNs3LDCI/I5ZtXG9GlXfW0C1DpXnrF/u2ispzQ33D3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jorU0BSxqv32dirO9a3rJPX8L5oCusFdd6PVwILaB58=;
 b=wagsCmamv0M2tjfpcF3+yq7u2ST3uvKf2TegOH4Up+/mB1yU5qYs1P9s6r5XUodRwE6LW/ISWzMCQf7/MMbJst0MRekuevT9/25vqChK9i+B9h0H41qrJ41LvlF9nKlgBZksofMF0OXMNnsoknjTVo1q/1Z22jrdiUMHrhzRTEM=
Received: from AM6P193CA0128.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::33)
 by AS8PR10MB5075.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:422::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 15:09:38 +0000
Received: from VE1EUR02FT013.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:85:cafe::e4) by AM6P193CA0128.outlook.office365.com
 (2603:10a6:209:85::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend
 Transport; Tue, 23 Nov 2021 15:09:38 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 VE1EUR02FT013.mail.protection.outlook.com (10.152.12.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.23 via Frontend Transport; Tue, 23 Nov 2021 15:09:37 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 23 Nov 2021 16:09:25 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 23 Nov 2021 16:09:25 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 1E73880007F; Tue, 23 Nov 2021 15:09:25 +0000 (UTC)
Message-ID: <d3f89b99dfc40ba459e20cd7203b88d18da72834.1637679551.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1637679551.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1637679551.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 23 Nov 2021 15:09:25 +0000
Subject: [PATCH V2 2/3] DA9121: add DA914x binding info
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b33ff75-109e-4358-f8ab-08d9ae93443a
X-MS-TrafficTypeDiagnostic: AS8PR10MB5075:
X-Microsoft-Antispam-PRVS: <AS8PR10MB507549FB522F5E294ADFBDA6CB609@AS8PR10MB5075.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wh/cLbcHjIn7Sp+ANGjtx2T3Dpx1KxuP5rLc3WLiDzpMVcMBHU2zqo8whxd133eyTRAZwOuwkdNWoKqpysBggJ/ZOn00y/8VQg4LnIfanjKmA67ITZanxq7WrP+7on9WAU5w9jOVa/g+uBxrLJRlwnlQtbrPR65QdPROz0UNFEDs9jNRIpVm2cTKZfWfEqICTaZ5R714wUNYDp9EVY6lydc3i2e6lji72SfD0+A2kEea0dUnj1NHZdBndNF/PAOxQ7eS+4MF94eET1tKb5CxBEP21KD3d6Y3g5ohx+avLLObKx4dOo1nnoQnI5Bc9fa9CY+YgSHKRd2yvbKagxcIeGAbDJ3VO4PXvToEfbZfYB1Sl0pi5GRQ4Ye4NgAjZBJYxOfWV4cOctL1lkyvoAN3pQ/nlvIjz8oicmm6WOdTsZF3SpAwBfvS6OY5PIa+C69/i1S2F+o40PDgUx5tg0XLSGh4STBq8h0lS1zfd+9t4XxGhbRdCp93xs43ZL8qRQc12zz3nvcZ3rDSukZHQyPrZ/ZNswmspQnahpRihD01LfVIxN/Hf4SXpOjgZXzFyVnJerx7gK2NF5e4w8qmo71pkh4/lxoyuGYhqsOGwF841pNEgYGYOtY4lK3iuNA/LPuJXqHcV5eAJB9UKPDRALjrjO+3Fk0DAb24lTQzt1NXLJ7zkxJMB18t6KDh/nD7U7MMdP1qrDZABDK9CaDnPcZqYIS7GjAaPinELlUkQ45OybI=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(2906002)(336012)(81166007)(356005)(83380400001)(508600001)(70206006)(5660300002)(70586007)(186003)(6266002)(36756003)(8936002)(4326008)(86362001)(2616005)(36860700001)(107886003)(47076005)(316002)(42186006)(110136005)(426003)(8676002)(26005)(54906003)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 15:09:37.7122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b33ff75-109e-4358-f8ab-08d9ae93443a
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT013.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 .../bindings/regulator/dlg,da9121.yaml        | 84 ++++++++++++-------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index 0aee5fcd6093..8441f630a84d 100644
--- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -17,27 +17,39 @@ description: |
   Dialog Semiconductor DA9130 Single-channel 10A double-phase buck converter
   Dialog Semiconductor DA9131 Double-channel  5A single-phase buck converter
   Dialog Semiconductor DA9132 Double-channel  3A single-phase buck converter
-
-  Current limits
-
-  This is PER PHASE, and the current limit setting in the devices reflect
-  that with a maximum 10A limit. Allowing for transients at/near double
-  the rated current, this translates across the device range to per
-  channel figures as so...
-
-                               | DA9121    DA9122     DA9220    DA9217
-                               | /DA9130   /DA9131    /DA9132
-    -------------------------------------------------------------------
-    Output current / channel   | 10000000   5000000   3000000   6000000
-    Output current / phase     |  5000000   5000000   3000000   3000000
-    -------------------------------------------------------------------
-    Min regulator-min-microvolt|   300000    300000    300000    300000
-    Max regulator-max-microvolt|  1900000   1900000   1900000   1900000
-    Device hardware default    |  1000000   1000000   1000000   1000000
-    -------------------------------------------------------------------
-    Min regulator-min-microamp |  7000000   3500000   3500000   7000000
-    Max regulator-max-microamp | 20000000  10000000   6000000  12000000
-    Device hardware default    | 15000000   7500000   5500000  11000000
+  Dialog Semiconductor DA9141 Single-channel 40A   quad-phase buck converter
+  Dialog Semiconductor DA9142 Single-channel 20A double-phase buck converter
+
+  Device parameter ranges
+
+  The current limits can be set to at/near double the rated current per channel
+  to allow for transient peaks.
+  Current limit changes when the output is enabled are not supported, as a
+  precaution against undefined behaviour.
+
+  |----------------------------------------------|
+  |               | range & reset default value  |
+  | Device        |------------------------------|
+  |               | microvolt    | microamp      |
+  |----------------------------------------------|
+  | DA9121/DA9130 | Min:  300000 | Min:  7000000 |
+  |               | Max: 1900000 | Max: 20000000 |
+  |----------------------------------------------|
+  | DA9121/DA9131 | Min:  300000 | Min:  3500000 |
+  |               | Max: 1900000 | Max: 10000000 |
+  |----------------------------------------------|
+  | DA9121/DA9131 | Min:  300000 | Min:  3500000 |
+  |               | Max: 1900000 | Max:  6000000 |
+  |----------------------------------------------|
+  | DA9217        | Min:  300000 | Min:  7000000 |
+  |               | Max: 1900000 | Max: 12000000 |
+  |----------------------------------------------|
+  | DA9141        | Min:  300000 | Min: 26000000 |
+  |               | Max: 1300000 | Max: 78000000 |
+  |----------------------------------------------|
+  | DA9142        | Min:  300000 | Min: 13000000 |
+  |               | Max: 1300000 | Max: 39000000 |
+  |----------------------------------------------|
 
 properties:
   $nodename:
@@ -51,6 +63,8 @@ properties:
       - dlg,da9130
       - dlg,da9131
       - dlg,da9132
+      - dlg,da9141
+      - dlg,da9142
 
   reg:
     maxItems: 1
@@ -69,26 +83,33 @@ properties:
 
   regulators:
     type: object
-    $ref: regulator.yaml#
+    maxItems: 2
     description: |
-      This node defines the settings for the BUCK. The content of the
-      sub-node is defined by the standard binding for regulators; see regulator.yaml.
-      The DA9121 regulator is bound using their names listed below
-      buck1 - BUCK1
-      buck2 - BUCK2       //DA9122, DA9220, DA9131, DA9132 only
+      List of regulators provided by the device
 
     patternProperties:
       "^buck([1-2])$":
         type: object
         $ref: regulator.yaml#
+        description: |
+          List of regulators provided by the device
+          This node defines the settings for the BUCK. The content of the
+          sub-node is defined by the standard binding for regulators; see regulator.yaml.
+          The DA9121 regulator is bound using their names listed below
+          buck1 - BUCK1
+          buck2 - BUCK2       //DA9122, DA9220, DA9131, DA9132 only
 
         properties:
-          regulator-mode:
-            maxItems: 1
-            description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
+          regulator-state-(standby|mem|disk):
+          type: object
+
+            properties:
+              regulator-mode:
+              enum: [ 0, 1, 2, 3 ]
+              description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
 
           regulator-initial-mode:
-            maxItems: 1
+            enum: [ 0, 1, 2, 3 ]
             description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
 
           enable-gpios:
@@ -97,6 +118,7 @@ properties:
 
           dlg,ripple-cancel:
             $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3 ]
             description: |
               Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
               Only present on multi-channel devices (DA9122, DA9220, DA9131, DA9132)
-- 
2.25.1

