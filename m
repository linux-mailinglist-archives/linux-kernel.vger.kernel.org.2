Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C046245A260
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 13:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbhKWMW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 07:22:56 -0500
Received: from mail-am6eur05on2061.outbound.protection.outlook.com ([40.107.22.61]:10120
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236398AbhKWMWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 07:22:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWBmfKkUvvxTyF9cOtxeFmaO2OFGDSSUzd6vaAwVfq04s2b5gwwIZsPpXMbQRPL0NWoZPsAeQfAip9y2DUwC5goPPIL6ZYS7jjKP6f05vG1EsszAsZDy4RQMmx4bS7R+tfiZRhDIINyUrtuvNJWYplTenBPqSw2c83VcTj4Qfvou0WuIgIzxhaTGgk38gz1Cu69LcZYpQYZhK278ol8zREF6J6f1RAzNXt+9VZXh+jrXvlaCRVSRhE5uVY94Nz0qg8cQSHIPiiFh4NNPX32WTMc09to+yJ4G0HHBn94dN7fejdchC5D31oJMRo6Ld6LUxCLLUkcAGDzktK4G+5OmMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GH/DKyrzOdyMd398k1rKybeIo9e8b1keFY/Yae1Qbe8=;
 b=cEM4PtGfFe6UVtx2YVaZfhZAxDZJ63y2IpH+s+M3Pz7DIBizA2U4KYK26vrfNCPfHA3vc9wUMjTqseNYU5mmebp3PYcSHa6Ey4PtF/P670eI2x7zGkw+SHw8Xzpc8n3q0H6qhIgyT07dxPURZixb9JSOde/G+ZzkwCz7HNWWcGKEAz3N7otC2SYaJ/X/pEcuImBbmwZ97Z4Gd8FfaD7ZwFv/tZ3bSvKxeNQCmrd6748cX5Or8+ST7b7h61QKyFCWFxy301SFntL2A1bhG//TAkt7uQLPUuo9Ry3xf7ZosqRCVKpoXYQtNO9b6Tncu2hnCcggLZ9qO5w01IRiTNHssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GH/DKyrzOdyMd398k1rKybeIo9e8b1keFY/Yae1Qbe8=;
 b=FH3v13dqZQzkmjPqrWoL8fJ7xwzfzJWoguriaoOkKYeuPqc4v7LSgukf58qCoon2sVOf4fcJrm0IMn74tJSN37KC0fpPwSvvkCCWhxCJ7U+Egca1rLVCFKWSfyv8qAWMK1Cpkxv3QTIVdTjzX4EgeaZ1ic1PlZkqjBZV8CuwAmM=
Received: from AS9PR06CA0023.eurprd06.prod.outlook.com (2603:10a6:20b:462::28)
 by AM6PR10MB2742.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 12:19:41 +0000
Received: from AM5EUR02FT029.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:462:cafe::78) by AS9PR06CA0023.outlook.office365.com
 (2603:10a6:20b:462::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend
 Transport; Tue, 23 Nov 2021 12:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT029.mail.protection.outlook.com (10.152.8.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.22 via Frontend Transport; Tue, 23 Nov 2021 12:19:40 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 23 Nov 2021 13:19:28 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 23 Nov 2021 13:19:27 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id D7627800080; Tue, 23 Nov 2021 12:19:27 +0000 (UTC)
Message-ID: <49e5f47c79c0fc1d2b52ffdf7f5872f0adfa5ba5.1637669927.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1637669927.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1637669927.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 23 Nov 2021 12:19:27 +0000
Subject: [PATCH 1/2] DA9121: add DA914x binding info
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83b30d2a-8ec7-4a3d-c600-08d9ae7b8668
X-MS-TrafficTypeDiagnostic: AM6PR10MB2742:
X-Microsoft-Antispam-PRVS: <AM6PR10MB274276573E318527A5909EF4CB609@AM6PR10MB2742.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gM17x7Aj4h5rTHQZhIQjjhDxk3AVEeNTS6esd5W27FYGoYatCU9WMgZdOc2xl4qEQeKIwvOZjIktqYJbJYbHGCCPqhZ1L6yU+hB3Uimy4Bwa9G/hqi1eSw8/xR2258wHCNY+ldkrKkUtIYoc4DKrdaUzgQ/lqq1sw96ag125FvuAkHB4MWKRH7/9+VL1CHCuV9y4r6DQdsDbmrkVq+9yBHk1vzpsKFvWcR6N4BHEvw/+KPKzYFvPOQZtYVLzy3tGR2iaW/5wR7uKiibA/8K3cIVQ9phwz++/gYY6hTHwP+JvN/88M2FdVdAgG3ZKfPG5Jh8oBQUJLcXk84e7IWcjRdphZ+Ocgs7a9IjE9kQ96p9v1s5lACUxe+lCBvSK572fkrARMsgdpmHYugoWZlo3TBf+EXbuZFSpZy5mfTGNqmwoySMvSnFDQD2xM861ebYQmZKE0GWPNSNlzh3DEHoX2M0cOEFHYoD2wlI/UYHUpXyp+ywrwln3C2L3C8SfqzC2BLofs9Jl9A4u7JGa85UFbz4v+V5J+Y96ThPtHvZxXS2MmQU9rTmOcxz/4BU0I9DuCtTdpbz0yAN/bkLwM32Cqe4QMDwTay2to4lNAS/CytV/9rg6kFG112NHhrPFvicRKINM3jDxoj3Uqw2zhg9CYi0m3BcD2erdTjOJLJ2SLZqxz74DNPwQrDaL5bdu955XRdHC00NpVozVbaHYMCtIvZqVXihSEOrBHxmCBIEIv6g=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(5660300002)(186003)(6266002)(70206006)(2906002)(110136005)(54906003)(4326008)(8936002)(508600001)(2616005)(316002)(36756003)(81166007)(356005)(83380400001)(70586007)(336012)(86362001)(426003)(42186006)(26005)(47076005)(107886003)(8676002)(36860700001)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 12:19:40.7940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b30d2a-8ec7-4a3d-c600-08d9ae7b8668
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT029.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2742
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 .../bindings/regulator/dlg,da9121.yaml        | 85 ++++++++++++-------
 1 file changed, 53 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index 228018c87bea..8441f630a84d 100644
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
-                               | DA9121    DA9122     DA9220    DA9217   DA9140
-                               | /DA9130   /DA9131    /DA9132
-    -----------------------------------------------------------------------------
-    Output current / channel   | 10000000   5000000   3000000   6000000  40000000
-    Output current / phase     |  5000000   5000000   3000000   3000000   9500000
-    -----------------------------------------------------------------------------
-    Min regulator-min-microvolt|   300000    300000    300000    300000    500000
-    Max regulator-max-microvolt|  1900000   1900000   1900000   1900000   1000000
-    Device hardware default    |  1000000   1000000   1000000   1000000   1000000
-    -----------------------------------------------------------------------------
-    Min regulator-min-microamp |  7000000   3500000   3500000   7000000  26000000
-    Max regulator-max-microamp | 20000000  10000000   6000000  12000000  78000000
-    Device hardware default    | 15000000   7500000   5500000  11000000  58000000
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
@@ -51,7 +63,8 @@ properties:
       - dlg,da9130
       - dlg,da9131
       - dlg,da9132
-      - dlg,da9140
+      - dlg,da9141
+      - dlg,da9142
 
   reg:
     maxItems: 1
@@ -70,26 +83,33 @@ properties:
 
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
@@ -98,6 +118,7 @@ properties:
 
           dlg,ripple-cancel:
             $ref: "/schemas/types.yaml#/definitions/uint32"
+            enum: [ 0, 1, 2, 3 ]
             description: |
               Defined in include/dt-bindings/regulator/dlg,da9121-regulator.h
               Only present on multi-channel devices (DA9122, DA9220, DA9131, DA9132)
-- 
2.25.1

