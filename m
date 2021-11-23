Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E9F45A641
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbhKWPMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:12:51 -0500
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:48070
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232814AbhKWPMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:12:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyX7OIBQRY3UIIGLMP+5MYU1r1e+AVPXmI9BTjngV8nbMHuOROMf2gvkmo9GwIYuqhLs+fHS2topEXgBjLk1Lc2LKMO5kfup5I+s7vbB/pw9j+2bxqyJD16tdXbO9cpiIbLna8BP/5Gavy/f7pfm0yH0v261jgOGbUrg72ou7XqoJTzCx8JUR2xOshkupd9CwIlCNwma7Ktj1vdsp4yx0mx5o2RedIR+HlKmAlWQivy3z5Ywd4/uD+rfn4rvbFlV9lnrtvFEcTyu6oKdAosEETge08//I0slJXMtLYwCpVNQknr5u3kMVBAZ+TU2nIkSGAmdPogomjEAX8zYMhzfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plLS628fdNlCnMD2zpSEDdBiwQB/ZdWY3mYmxd0eiiw=;
 b=PDOawtF377oAqKj/eXus0RwyltOvaC0svXlNuY/VmHb+QZwlCtz+psXlXQxmWaGUYvHv31a9YEr/QLxa0a+yVlv+joskic0Z3H61F/7xoP0SWA7D6M9Zbl0GvbdZK3Wyc87MAaeB/oMJp7Zgnp8izUoPvVp6aXIPFl80kh5F4+OM43NCXayAeDyeRpM2pHKh0ps0sBVjL86wjHLOjcByumI+aVxoak7n2yNTTnFfuCun5vYFp2ADXAPm+WPTfCrU8kH+KgW4T8IhR8Ixssspn2jI8YVjLMR/C2W8T2k1ngDr0uGj8OWRTH6N1D6JUtWEnd3EXz8Z8CoesWdcZcry5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 193.240.239.45) smtp.rcpttodomain=gmail.com smtp.mailfrom=diasemi.com;
 dmarc=none action=none header.from=diasemi.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plLS628fdNlCnMD2zpSEDdBiwQB/ZdWY3mYmxd0eiiw=;
 b=DLcxiPFpCKFOKfWfS93FQhnY5C5gybe47TLl5GSzXGhOOP9CvKT+zUbDSQjQmixSiG3+KACzjNHvq+WOG8QGwQkKJBdfDKZgOcUXMkkKXBZC2MjnMD0oRfYocjuw7GIhTy6ocHzJLGDM1Drd/6eH380d2U8tBMjxeKLyscMtVAQ=
Received: from AM6P193CA0120.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:85::25)
 by AS8PR10MB4999.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:404::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21; Tue, 23 Nov
 2021 15:09:37 +0000
Received: from VE1EUR02FT013.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:85:cafe::12) by AM6P193CA0120.outlook.office365.com
 (2603:10a6:209:85::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Tue, 23 Nov 2021 15:09:37 +0000
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
 15.1.2176.2; Tue, 23 Nov 2021 16:09:24 +0100
Received: from slsrvapps-01.diasemi.com (10.24.28.40) by
 nbsrvex-01v.diasemi.com (10.1.17.243) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 23 Nov 2021 16:09:24 +0100
Received: by slsrvapps-01.diasemi.com (Postfix, from userid 23378)
        id 1891180007F; Tue, 23 Nov 2021 15:09:24 +0000 (UTC)
Message-ID: <f261f4af46aa4fd4f1b44ddde8807afb0b1e756d.1637679551.git.Adam.Ward.opensource@diasemi.com>
In-Reply-To: <cover.1637679551.git.Adam.Ward.opensource@diasemi.com>
References: <cover.1637679551.git.Adam.Ward.opensource@diasemi.com>
From:   Adam Ward <Adam.Ward.opensource@diasemi.com>
Date:   Tue, 23 Nov 2021 15:09:24 +0000
Subject: [PATCH V2 1/3] DA9121: remove erroneous compatible from binding
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 794f1a7d-e794-438f-5616-08d9ae9343d1
X-MS-TrafficTypeDiagnostic: AS8PR10MB4999:
X-Microsoft-Antispam-PRVS: <AS8PR10MB4999929BAF291F4C793FE6C8CB609@AS8PR10MB4999.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:1775;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vXQr6LPb7HjiBhDhv2sRlISoNj6xfZWTEVMIuH/P0MlZ/HXhxuiZGezoNw/H8QkPZWQEBtuMWpaaG93ZtyfgVvwsTpOj10hCQO7IPs14GeCuJxoQ8DDe1JQiENkg+mo9PFpnNukagMSreobJN20OWsUMysKFBwNd1bfNMZa2befJUOJfFtoU1NHPOZV6fpShXWCTh8uEMdqSuDCalxCJtm3Jx4+FzhKlBkGE3hgb4WYnJshFXhPtk5Xx7TQszi3U9VyFeWolzgHnK+kCJ+VsCcKtMmrsUL/GO7+xGvxmPmKOHU0sTxXc8ZJfT5S9ePwX78+A01BHSy+dkKcI4jZjMvqWj/cv+atG2vv2cIGSvjlHLRecyOLcs9+WEGKVxueTwY0V83QS+draMSWFaY/SqKDse4TVfZfgHqWZWBmrbJl+tbz/apBL2S5FIi+t/cngOhUmH0BeG+YhMspC15pPjadNv7c8UJbVAFZrT3SeVfOkW02hFZYYB/oql7MyO7rmrvT/SUIzQNHiexqtJLIUGy9Xf9gISahATVbws7wIcPeSqaGfKXLpRvdFs+ZWgMJx8Id5L+JwoOePzCSmuE/He+kH7Z2Ho3AfniZioe3qVtqr35IIMj080sARF/m37IK4WbDYYMfHdlev4tQ3vvMN/kLxHyvv/i7BS+NWHtSn3o0/tZHdtKm5goF7Cg2idwKIkYotmylbfK2iBpcbwauIE+H2+9apJ63L3QJSXZkm8Yc=
X-Forefront-Antispam-Report: CIP:193.240.239.45;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay1.diasemi.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(4326008)(36860700001)(70206006)(107886003)(26005)(54906003)(8676002)(2616005)(426003)(6266002)(186003)(70586007)(5660300002)(356005)(36756003)(81166007)(2906002)(42186006)(86362001)(336012)(83380400001)(316002)(110136005)(508600001)(47076005)(82310400004)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 15:09:37.0200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 794f1a7d-e794-438f-5616-08d9ae9343d1
X-MS-Exchange-CrossTenant-Id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=511e3c0e-ee96-486e-a2ec-e272ffa37b7c;Ip=[193.240.239.45];Helo=[mailrelay1.diasemi.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT013.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4999
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

