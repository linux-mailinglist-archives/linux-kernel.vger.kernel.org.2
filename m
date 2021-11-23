Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72E045B02E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 00:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240535AbhKWXbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 18:31:16 -0500
Received: from mail-db8eur05on2054.outbound.protection.outlook.com ([40.107.20.54]:38633
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240547AbhKWXbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 18:31:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SC6fEBhSh5F/NwppxyQ+0C2s0QjJsaEi3TCcV8A28q6rZw3/YsfgsltODKxxoJ2Ms/zBZDf3gWVBusmmxf30YI3NWI/dYsbkDYO2wf8fUctYzY6DGt6yZPyP0bCrWPNXi03Me73+We5JsmHt1nP0JpOPDhu8QOLbiM/1LDHTrqi4PhM+Kf07dGCLuf04Xmk5vnZX0JVa1fIv3S6SzNRXpwAq4PUDlT3p1QBr1O6MWJp1aT6J7pnv2yvSJjDN9Z3VjPWpP6wNTH4cskJOJZQgeLo4+Sb+VQe8tiJZJ+Qwq37zBT/W0EAN6PgUQPGSYT4xlAd5Q2wiK+pEND1xBSjNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plLS628fdNlCnMD2zpSEDdBiwQB/ZdWY3mYmxd0eiiw=;
 b=B6700GJQbUX8DDrAgrow+jHfSn0FgMwS1JgJU6BO4XdM/mbus4W4HYy3oiLi2JsYpwJ8+fQjI4FRFBQ2cipk9hS7VLr5i0qQlnqFcfu0Vl3vVB16sie3K5F4tdE19wiHZG/JLmMnS7LKzvIQTFlyN5Uf1pa5pyhz+hh9EYgMWTs/UwF8UdO+JDCsMH51bb6VF2URjcNUNa+RdukPWg5PFh6DiLG/dNzRh6Ra1SMpiErlv9i2g45m/pjndoAzNWEyCSD3d6VuF/O3jBrvIWmrKAYx0ZDMwH0HJ/nFj/k+1li0uSXEnmfjH4XX5BW2Zxu2l3xiNq9l6gu04Wy3DtxsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plLS628fdNlCnMD2zpSEDdBiwQB/ZdWY3mYmxd0eiiw=;
 b=K3VQAT1Mq9rGkRI6yAo6ojcYu90XSOWwi0yR34rOzhK0Zf6yc3cssHE6VpIH3ed+QVQcvJGbw1qtOjzdVwCaHNUGMoYxN5CjHyK5iqRax2s4hl6TzioFAZ6lfz0LlKoJIQXE1t6kS1uyEpoG5VEWtA3JRQKaPtXp9P+g5GVONks=
Received: from AM0PR02CA0140.eurprd02.prod.outlook.com (2603:10a6:20b:28d::7)
 by AM0PR10MB3617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Tue, 23 Nov
 2021 23:27:56 +0000
Received: from AM5EUR02FT016.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:20b:28d:cafe::74) by AM0PR02CA0140.outlook.office365.com
 (2603:10a6:20b:28d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Tue, 23 Nov 2021 23:27:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 193.240.239.45) smtp.mailfrom=diasemi.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 diasemi.com discourages use of 193.240.239.45 as permitted sender)
Received: from mailrelay1.diasemi.com (193.240.239.45) by
 AM5EUR02FT016.mail.protection.outlook.com (10.152.8.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.22 via Frontend Transport; Tue, 23 Nov 2021 23:27:56 +0000
Received: from nbsrvex-01v.diasemi.com (10.1.17.243) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Nov 2021 00:27:56 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 24 Nov 2021 00:27:56 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 04F6080007F; Tue, 23 Nov 2021 23:27:56 +0000 (UTC)
Message-ID: <2e5f602d3fba02691f6113884a57a894a697ba0e.1637709844.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1637709844.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 23 Nov 2021 23:27:56 +0000
Subject: [PATCH V3 1/3] dt-bindings: da9121: Remove erroneous compatible from
 binding
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35155f34-6b48-4c4b-85dd-08d9aed8e143
X-MS-TrafficTypeDiagnostic: AM0PR10MB3617:
X-Microsoft-Antispam-PRVS: <AM0PR10MB36176E4DBE769AD367E7362DCB609@AM0PR10MB3617.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P9NIsQLnNGazw38E2hJXSKd+PwnycoZTXJiqzg4KRM+WcA8tsm0BREZRVQOs49wwkkzKb/kvm/0h6tjrvp6oaKTJJ5l6aStYTD6L6XeJ6H2r/JlkP0hm2xSjJqDCRkG8cungp2WUMLf6NrvPzSHZv0XJqTergN1ACB4VXxNPTCVh2CvPIeHimORLxrdiGLql74wNAC7Py7A8EqAQVq8S1y+ZrlhQqmwqIanrTXAJjN+Vf14qMVapsxj6oK5hnTlovGq15gcjxfIrZgThEKyWA9y8NDyh8g4YhBil4JdZyGUFUcZ87VZe2chnMCH1wIb9cjd2s2PvX0T6NxpduYKkX7Y8O+pgNvNlR1EGtVSYSC4vDArV5BW/E39UGNutBh8s7jWL0WIuuZ5zBptAIW/UGhxCnlT7KmsFDnKaRG9bVoG2V0cU/gAkBwS764miR2cVKLbVXcGQ9dV2Ma5jyT7lACS/u/JjCvHc0dY5xghs+mFQQsapUkvtGrFFRMpjjz4ixaJrvO5A/4DpFDTkut2IV/nnu6Lzv9OAOIviCwaEG6CgQ2+Aq5xIaZebfyoJGrVD+UNN2yOZ7AEsinPh2hCgciCtyGjBWpxFoUjwgCTqGGz1MAYZc4ebCTGmgepa13xqxkdcZV8UdIRG5uXeWf+nuUVpsW4ZhvczeqUX+7Rh+Yt9ByGuv4CQiwh/9OQYLQd2SnggRrky0F27MYPX+33urKEgpboNegSoseXTQ0mAWLc=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8676002)(107886003)(508600001)(186003)(81166007)(86362001)(47076005)(2906002)(8936002)(4326008)(426003)(336012)(83380400001)(356005)(70586007)(70206006)(36756003)(54906003)(42186006)(316002)(82310400004)(36860700001)(5660300002)(6266002)(26005)(110136005)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 23:27:56.4643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35155f34-6b48-4c4b-85dd-08d9aed8e143
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT016.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3617
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Adam Ward <Adam.Ward.opensource@diasemi.com>
---
 .../bindings/regulator/dlg,da9121.yaml        | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
index 228018c87bea..0aee5fcd6093 100644
--- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
+++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
@@ -25,19 +25,19 @@ description: |
   the rated current, this translates across the device range to per
   channel figures as so...
 
-                               | DA9121    DA9122     DA9220    DA9217   DA9140
+                               | DA9121    DA9122     DA9220    DA9217
                                | /DA9130   /DA9131    /DA9132
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
+    -------------------------------------------------------------------
+    Output current / channel   | 10000000   5000000   3000000   6000000
+    Output current / phase     |  5000000   5000000   3000000   3000000
+    -------------------------------------------------------------------
+    Min regulator-min-microvolt|   300000    300000    300000    300000
+    Max regulator-max-microvolt|  1900000   1900000   1900000   1900000
+    Device hardware default    |  1000000   1000000   1000000   1000000
+    -------------------------------------------------------------------
+    Min regulator-min-microamp |  7000000   3500000   3500000   7000000
+    Max regulator-max-microamp | 20000000  10000000   6000000  12000000
+    Device hardware default    | 15000000   7500000   5500000  11000000
 
 properties:
   $nodename:
@@ -51,7 +51,6 @@ properties:
       - dlg,da9130
       - dlg,da9131
       - dlg,da9132
-      - dlg,da9140
 
   reg:
     maxItems: 1
-- 
2.25.1

