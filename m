Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFEE945B02F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 00:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240559AbhKWXbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 18:31:19 -0500
Received: from mail-eopbgr40048.outbound.protection.outlook.com ([40.107.4.48]:15694
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234220AbhKWXbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:31:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyJvjUJMrwUVhmBJti/O2vSJyxE7mlNZvmIYa/FCMl683CC1Ja5kPR69LYWFQPtB45Q7f5lD85hFJLoJ961oEjtDOY59hYvI5Qm1WRLPm+AQWA89mtrTUx6rBYBiPIYfBrDWv1ddyoFhxeFW7Qkbb4AYM3m61LLp4usDjC+QqfX7VEB2a9l9OfxvEvM6qzzd2tvc0YCEtHX65prMxKZabEkQ0TSKktaV9MW8LfxUGAn1vh7Uf0ISV2P6bSiw7W2uBXQFFIWSE4OXKrvB4O8cEbdsQCXIoT4fnA8fds3b9cs5AEumURojuDQ5mXTJ/99tqwJwF7vyfR7vCxfVG9a7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqdBhUIk1F5BQUVXpcuYoLh+2cl1ZYLJnGVGFPPwwM0=;
 b=BTP705ElD1Y/Z6E8Up5KB/joU9PEvrFwrg2tJsK4lCDuAPO8AbYQ/XiP0dIZtu99qaUnJ35x94lcXL90XEm1yuaaxHFL5+Ar22iYiUyx1vK16Q4MNFtyTbqSnYDm4N99oNO+Fm2fQkWvOd9P4mDMbIbfzlldUvK+mJ1I2JKfdUf07VqLhj3FmAgI5uoU41Ua3vL2xtc/fqmw9mqXV+0bie2+8savcS/EmKwxC/Hjcb9IglvKHeDgXrCfeXJovsIOU7vr4QCVjd1QRHkNk1FEMZlnT/Cj2Thw06oq8yyS19Iu5uFzWZlcjmsp4CFxpVjy4ezcDwTVYYN7JITus9DvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqdBhUIk1F5BQUVXpcuYoLh+2cl1ZYLJnGVGFPPwwM0=;
 b=CU50I1OilAlWRYsr+9Ni1uXNIVYfVV0OxAAVcpIqZFV/GEHVbV3LstV7KIlwDnBeNfJEu5ed/opyQ6M7460o9XL50GaZ9jPKOYNaEmqqUqb0bTOcdW5apn+RK1QNK1YyxgRxkFHK1n15lHwV+9QKuumg/AwQv3pKbk/0ZsoeU1U=
Received: from AM0PR10CA0053.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::33)
 by AS1PR10MB5437.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 23:27:58 +0000
Received: from AM5EUR02FT041.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:150:cafe::8a) by AM0PR10CA0053.outlook.office365.com
 (2603:10a6:20b:150::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Tue, 23 Nov 2021 23:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT041.mail.protection.outlook.com (10.152.9.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.23 via Frontend Transport; Tue, 23 Nov 2021 23:27:57 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Nov 2021 00:27:57 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 24 Nov 2021 00:27:57 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 0AC2380007F; Tue, 23 Nov 2021 23:27:57 +0000 (UTC)
Message-ID: <32e300765a1e3889d804e81efa393d4a6fee93e2.1637709844.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 23 Nov 2021 23:27:57 +0000
Subject: [PATCH V3 2/3] dt-bindings: da9121: Add DA914x binding info
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ffdf9b5-10e5-4167-d3ad-08d9aed8e223
X-MS-TrafficTypeDiagnostic: AS1PR10MB5437:
X-Microsoft-Antispam-PRVS: <AS1PR10MB5437878AB9C6598BE4351C56CB609@AS1PR10MB5437.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wfQvaC+eYsREH3S3Pt2o8Ti00DbbWmah//hme1RGjK1isxPNk8RN/gLBQqIT9ylQi3dqHCmuys7oiDPS7rybSDhbgJEm8fpWW01Qz1BxDBu4fCEL71I8LJYtOSpWPq6XRegnaAzDp/rPzfT4xpyjsMLmcs5idA6qIo1pU5dotFsH/MPPdYF1pXeE3iN3ysJ+Tx4EW+3nXW3P6sL7r6YZ8o8kgbd6K5aXi/YWJo/AAtGbX3TsH07tpLQNdijkCB1WtpTUzuQ8CofCIuJYtYlq3kHzeCfxAZoQykdFchBRqqpTZE/0/TDGxT5ZaQhyQdXeO8WPlgcd9gAxdH/fT/LM+4zk0LOtcwGC7KumNhZCbE0oyGkGxZFi7ywfotxPpn2RPCPJYYy1a+tTlWob4DKHmlKjqQn+RpnqfUDXhfEubzgtAuB0JMVFx5vXcXirxwAHLirIUOEQVdML1PJQE2CmDYt13nkJRFEpssTAhaAwxBrODtHvDog55jCv36R5atr4Y89vh0rhlQaXR7tq624LpwSAR3xwBNoaLUHnrFF6RP2r79ucVl7l2uUbBj0n8NPpx2Aw0U7yWB84jDV6dNwCzd59/DdPOJYs/yzdGQ7DDcaZnKNPossfCPQjlt5rcj9zuG1JHM6bQ6nigB50B3/tbhx92hAWZu55JIgFaVpQvQc74JTP1nPE0vXKFrjIyskq8rF7x8aRxbPOz8EZHtkB6GYNDkNLUU1qhhmUEa9/gdo=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(83380400001)(81166007)(36756003)(356005)(316002)(8936002)(70206006)(110136005)(336012)(54906003)(508600001)(70586007)(42186006)(6266002)(4326008)(2906002)(2616005)(36860700001)(107886003)(426003)(82310400004)(5660300002)(86362001)(26005)(47076005)(186003)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 23:27:57.9343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ffdf9b5-10e5-4167-d3ad-08d9aed8e223
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT041.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5437
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 .../bindings/regulator/dlg,da9121.yaml        | 75 +++++++++++--------
 1 file changed, 44 insertions(+), 31 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index 0aee5fcd6093..24ace6e1e5ec 100644
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
@@ -69,26 +83,24 @@ properties:
 
   regulators:
     type: object
-    $ref: regulator.yaml#
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
+          Properties for a single BUCK regulator
 
         properties:
-          regulator-mode:
-            maxItems: 1
-            description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
+          regulator-name:
+            pattern: "^BUCK([1-2])$"
+            description: |
+              BUCK2 present in DA9122, DA9220, DA9131, DA9132 only
 
           regulator-initial-mode:
-            maxItems: 1
+            enum: [ 0, 1, 2, 3 ]
             description: Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
 
           enable-gpios:
@@ -97,6 +109,7 @@ properties:
 
           dlg,ripple-cancel:
             $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3 ]
             description: |
               Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
               Only present on multi-channel devices (DA9122, DA9220, DA9131, DA9132)
-- 
2.25.1

