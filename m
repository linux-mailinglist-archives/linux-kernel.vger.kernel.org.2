Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C569430D54A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbhBCIeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:34:06 -0500
Received: from mail-am6eur05on2096.outbound.protection.outlook.com ([40.107.22.96]:3297
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232445AbhBCIeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:34:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioeB6Z98SZ4sE0+mFl2CSJMipH+NkU8m3xO/PngH3ImB1wIaXLaYDf6i4aKkx80/a2uSYlMDo6U5c9O+6K69EZNfRwiJ5OD1CvGfrQBIxe5W12CTlqb2Bf30jSF5G+5VwUddyVIoObbi0Kui2assq1dzWFDvyOfVRa4A/ccYp4Y+NalNa1SAQ+UhHJ1r2X3CB4gHgW87uM7SdLAlHYvihE6dht7SaePyvR9WoAall4LQfeiY503OS9ck10NLu/y36h6YDiXVLtYm5YCUaNnIQGND+jO9ZktyAkbRhlNP+bWVCYdjXE1jdmQMxuldzxACG8haUal28LHasjIo49ySzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIQ5aVc8j6wPONhR97VooRWUuupFHz58Mznm6W7U2P0=;
 b=Op/4FglAGIIciMPEJjybsrRsvGKiBJA/YUtImeC/6jbdsGGbwh2a5OYRZ1c1u9TVrdKzXwVqUxWHY2zgA2dtzOirephoiZ7LZlC/c6OoEkts+XoKFu57eLtae4TV51+HNXKeTlb/jbDOv24RUqxWAY9R8iDCbC6CURNTFZKEBxrCFwyp59ciiuYXFiYO/ih3gr7CFCEtBrLKHOYzWdlF2e9Bfx/rdRv0YcfiKYiAfqHOtOgovWKK8FW95y0mLQSaFpi2cvTRduMEkbKfwTOcoRkhaUxE/BAJ3ncEOn2UKyCRwRdHkREmMuxgNEXMvwdbGqUT+sfq2gpd3fL1qiVF1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 62.153.209.162) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=schleissheimer.de; dmarc=none action=none
 header.from=schleissheimer.de; dkim=fail (no key for signature)
 header.d=schleissheimer.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=schleissheimer.onmicrosoft.com; s=selector1-schleissheimer-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fIQ5aVc8j6wPONhR97VooRWUuupFHz58Mznm6W7U2P0=;
 b=CXax+oitaiFPJx0YyTVzghFpUHrBAYrR4hDy8AEyODEj0rupePp3P5NJo34p/xnQpZWIbcvJoV+SZH9wc2d0EYs0WpjINS8seQeyQHi/snnGMlazRkjqZdLdtAfO7fJVR6W0thZoy7yQd4DEom9sJ5/OAuSvdGm0K8eZGND3ZQo=
Received: from DB6PR07CA0119.eurprd07.prod.outlook.com (2603:10a6:6:2c::33) by
 DB9P190MB1353.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16; Wed, 3 Feb 2021 08:33:12 +0000
Received: from DB3EUR04FT018.eop-eur04.prod.protection.outlook.com
 (2603:10a6:6:2c:cafe::f5) by DB6PR07CA0119.outlook.office365.com
 (2603:10a6:6:2c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.13 via Frontend
 Transport; Wed, 3 Feb 2021 08:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 62.153.209.162)
 smtp.mailfrom=schleissheimer.de; vger.kernel.org; dkim=fail (no key for
 signature) header.d=schleissheimer.de;vger.kernel.org; dmarc=none action=none
 header.from=schleissheimer.de;
Received-SPF: Fail (protection.outlook.com: domain of schleissheimer.de does
 not designate 62.153.209.162 as permitted sender)
 receiver=protection.outlook.com; client-ip=62.153.209.162;
 helo=mail.schleissheimer.de;
Received: from mail.schleissheimer.de (62.153.209.162) by
 DB3EUR04FT018.mail.protection.outlook.com (10.152.25.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 3 Feb 2021 08:33:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=schleissheimer.de; s=dkim1;
        h=Message-Id:Date:Subject:Cc:To:From; bh=fIQ5aVc8j6wPONhR97VooRWUuupFHz58Mznm6W7U2P0=;
        b=AQnUeJvp/h/4GaDUE/R67rWnf/1ghIDQ3ZfkaIZBYaZI3o3DKoYS5797Jm3YAFDKkmjNP/nWmEe3d8iWVEHNZe1OJhDALjvmmlb045z24ztNytscqxPblRD9W0bFlrTLlJnzAORdhewISunHNH3WvGZ0osjrySd5Hl46HZIsNmg=;
Received: from [192.168.10.165] (port=41936 helo=contiredmine.schleissheimer.de)
        by mail.schleissheimer.de with esmtp (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <schuchmann@schleissheimer.de>)
        id 1l7Db0-0001iI-2v; Wed, 03 Feb 2021 09:33:06 +0100
X-CTCH-RefID: str=0001.0A782F21.601A5FC2.00F3,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
From:   Sven Schuchmann <schuchmann@schleissheimer.de>
To:     schuchmann@schleissheimer.de
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] leds: lp50xx: remove unused regulator
Date:   Wed,  3 Feb 2021 08:33:05 +0000
Message-Id: <20210203083305.2434-1-schuchmann@schleissheimer.de>
X-Mailer: git-send-email 2.17.1
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
MIME-Version: 1.0
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 29dd6ad1-3989-432a-fc7e-08d8c81e577f
X-MS-TrafficTypeDiagnostic: DB9P190MB1353:
X-Microsoft-Antispam-PRVS: <DB9P190MB1353830CCB9658A193B21ECDD8B49@DB9P190MB1353.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0CdFRQTZIqn4BXmQXL8A/13KCB13CXj6kaNvUAjytiaju6sc2/nJgy/n2Eb7vybrclLY+AX6Qk2bmCY+/UOGHcUTpKZ2piLhc/mc3vwhdn5ryadCbbV/xRnCX049s4KwmxDIgivvJuZUzZgcRxpKNW5ILRzzzo9bTKNyky1mAbL9Ey8yFiXw2hRn2v+iTHewzFFAGAkiW5MFh8HubsOuaL1UvgaoI2JR+jhQ6ywIrvaa+lM0l2Lz7KNZcrtAz+y88/irGDX5fQIX4DIlH9FRyDcZ0xdaGaYkwLzpPoWb/KmiWZPgLndkJ9ERUdUv8a1SOR8ZUsSW2Pv4Zu3GYJ7H8tUP+rGapqLh0GDpElJN6t8SIy0BObZlTUapFC+9pjCl20w0v/GKejH3HJ1kemyXzRdjsNt8VTumqNcveUjxPwtNKHjx25b0ydMLLXIsRkNu+cL4ve3AqAWuCAApVyQpuoL477RfbJY7gDvxuguWIx0pqdWRvE7zyFMXY9Ltq6VkSvnZ1gWee+eXF6MmkWGYCxARfmEKQs/6J6OQfugX6kqjjJa33sd2EFknX8zhCWkIImQQIfnYgoHwN/Fn8UtqJpQr6S6CZcg+gmumFf9KXuLLh1gTxnNcAqUz9ldsl/TTAXbEKrCOt7V7DSbX1kJP7efo5VvIE2TVkgo+T9Wclc=
X-Forefront-Antispam-Report: CIP:62.153.209.162;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.schleissheimer.de;PTR:mail.schleissheimer.de;CAT:NONE;SFS:(376002)(136003)(346002)(396003)(39830400003)(36840700001)(46966006)(316002)(426003)(5660300002)(356005)(34206002)(36756003)(37006003)(54906003)(83380400001)(82310400003)(478600001)(36860700001)(7696005)(26005)(186003)(7636003)(4744005)(4326008)(9786002)(336012)(8676002)(70206006)(8936002)(2616005)(7596003)(2906002)(47076005)(1076003)(70586007);DIR:OUT;SFP:1102;
X-OriginatorOrg: schleissheimer.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2021 08:33:11.4625
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dd6ad1-3989-432a-fc7e-08d8c81e577f
X-MS-Exchange-CrossTenant-Id: ba05321a-a007-44df-8805-c7e62d5887b5
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ba05321a-a007-44df-8805-c7e62d5887b5;Ip=[62.153.209.162];Helo=[mail.schleissheimer.de]
X-MS-Exchange-CrossTenant-AuthSource: DB3EUR04FT018.eop-eur04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1353
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator for vled-supply is unused in the driver.
It is just assigned from DT and disabled in lp50xx_remove.
So the code can be removed from the driver.

Part 1 updates the documentation
Part 2 removes the code

Signed-off-by: Sven Schuchmann <schuchmann@schleissheimer.de>

---
 Documentation/devicetree/bindings/leds/leds-lp50xx.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
index c192b5feadc7..c20a81d13bfd 100644
--- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
+++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
@@ -43,9 +43,6 @@ properties:
     maxItems: 1
     description: GPIO pin to enable/disable the device.
 
-  vled-supply:
-    description: LED supply.
-
   '#address-cells':
     const: 1
 
-- 
2.17.1

