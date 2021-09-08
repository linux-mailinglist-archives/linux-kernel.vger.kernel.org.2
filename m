Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC204039E1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351612AbhIHMbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:31:45 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:39462 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349005AbhIHMbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:02 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886da2B016872;
        Wed, 8 Sep 2021 05:29:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=uqIgky/rbQuIkkOs6iK63hUpt+kph4GnPEZB8fzM014=;
 b=mX4o1/qVJeubaxqU6d4yJivpvzMCqNiS2n9Ex/A9O1OSDIDXeCJRc6Hh8oCcZSwxNkON
 z6AVmU0gn2X/R6t8bqt5nW1SCbd6l72xvL06ckYcwE9A6/3pEscKptXdy+Jj067lWlbb
 moyakHXvj48t7/kGUAboHTSs2+Wm/t8b65jty+CPGhoLVBRAxlv4YEUG7fAi6W8D50DB
 rXxFphNytfucUkcREqQFE4GrI/NasSuI+Q1AvUDWpOqGcv296zEjcx0imfXIwlBODLGO
 CAsmWDXplGbx6mkM4/yRT2RSdqEbFTtGFtyqfDQ7oHNq05odEiSyx9/0aNM1W8urMEuF Uw== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3axcp9k480-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Njl3DuQ1D+unOnnGevtM19MwaycIKGqeU1UdyZWfiLEP90/96LlzE1XU99RXATiVQ1hQNPd5E2PNcz9jShNMbeGCz6glEfMVYYMZU791Kos/7LMTlZ2w94f4TRsTMAxVoWIaxz4bvbbL2p5mKE3zDhrRaWcdWw3TFCrjuHf+tXmzPnOSRHnEvD9oRYolwFwILVoUWJkhPHk9iARKW0iTx4m2/LM83gF53tW6lJQ9ppCSndz8DIezmAU+pWBW93ty9WkT8jADt8x3lVQan3vZPegXzpY9/j63ay7xBodWlWBBcJBr0aEzlCmUz8kpfIpCq5GeYqnWFC1PrioIW6WAoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uqIgky/rbQuIkkOs6iK63hUpt+kph4GnPEZB8fzM014=;
 b=GCMuKXm73Eqv5V+r3NS9V0bQnP+onijwUlnFyI4GsvxFG5VBNO498jCchyHufV8ZAFnvGZNxb/02fpjs4mqRWzaZMtnsnzfqYUYTeL8Jlx/WDmEvP9JxROvGWjcbm1+KeBK7tYiykVMxVG4Elwl5F6rXGSS6S00FQSPHom9Y5gMFPMAaqkSoG8W2dT2OGPWsm/kcZWpBmGxy6+EHOrR+McrTkaYu+QJXG6TCTaYTvOvNZrdQXROoUgVxG1O1QNUrGHh2SuRKUGjjsWe8gWip0+4UqHb1GnQiDEOqU2LUj6QM6cqvpGq+vhnKXWTwAYlf3fhiNTM9G09i+h6MT2qnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqIgky/rbQuIkkOs6iK63hUpt+kph4GnPEZB8fzM014=;
 b=KdbNe4NGkqttkFP4afXNyhENcg0NDLAsI5vgE//ZNGqyW2aGSf7mWdiyvPD/FTf9VHiY6hCR9tUlfjYGdZTNZ4ov3qJ08+QWtTkMJM+xutQUekRLeXDT34LbpWsWZT9cAa0fHzc3whEw/9LvI9g9DOOQpyrhqwqQfSk706Imgjs=
Received: from DM6PR06CA0071.namprd06.prod.outlook.com (2603:10b6:5:54::48) by
 BL3PR07MB8955.namprd07.prod.outlook.com (2603:10b6:208:33a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.25; Wed, 8 Sep
 2021 12:29:40 +0000
Received: from DM6NAM12FT033.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::64) by DM6PR06CA0071.outlook.office365.com
 (2603:10b6:5:54::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT033.mail.protection.outlook.com (10.13.179.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:36 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9L026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:35 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTWl6010280;
        Wed, 8 Sep 2021 14:29:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTW9L010279;
        Wed, 8 Sep 2021 14:29:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 03/15] dt-bindings: phy: cadence-torrent: Rename SSC macros to use generic names
Date:   Wed, 8 Sep 2021 14:29:18 +0200
Message-ID: <20210908122930.10224-4-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b143d85a-9a78-4ecb-b86c-08d972c45245
X-MS-TrafficTypeDiagnostic: BL3PR07MB8955:
X-Microsoft-Antispam-PRVS: <BL3PR07MB8955110CDA27879531872EEFC5D49@BL3PR07MB8955.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8yCzMdebdjPlvtx5QyS+bDAY1WUWB7SdyW6/ifa/cb4z/Z0Rab0IAQ19IZFRg033S44/drAN7Om6i5S/AzSZN7jiGfzYaHH5w5cm5sCtRW4GIcYaUaGXkOOf3QZ3CqVAMlvpkAvDkEcniAYUG37HJJzNTefprp/E2QZpkFOD0vqD9/MuLroBLn01EMuCdMBkMz7S7Kczv3pGs8Xy7TznvWLfUju6byIg5sChGjJGFt5sem3gQFJcxeKxIqFU1WpBod9FZFaIJl4WuyKZ5C9WB2jY7+5wG3qvYHvmLdSFB+TBVwVtbxe3vAOgnZP8pdP9HmnOTZaC1Ahfym+Qbu8b9KF5lTH8zyxwf5EgJn2oDyK3j43muUXG+CnMB8TXxu3NNaGvyz6zt5KgopuUDFdeD2EjeFoLFvehU+tE97x62X0x+wJgMQ7C9WEP4A64ZHiTxoc/83GN+wI6XN6xl2pVVx4JaVeV+EJnEB5WBzdh93O1ztf85nG36vhd+icBLxg7o/a4STwm9TsopyaLezCwx4qJJWM49IiK95ToyT53lTmVao8QJlxK9F7gG/SDiPnyybX9UQdmXoTXGpv9wMbSsZKW5FY1g78pwrtlfMVG1TIUiT/d+3U6GT34VzLUzyd0NGUBt3gNbMU0yhsXycR3AD7lVSOdGkqYVBmBTrAq5MarPG2VuOoSrHBIqBfw98NoGboEmlbEWU20B0UATHNrYMOt3FHhuOt+yN4SVd3jW4ktEluKGnPLn15Y2JjhGxkt
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(36092001)(36840700001)(46966006)(2616005)(82740400003)(316002)(83380400001)(86362001)(186003)(70206006)(26005)(356005)(8676002)(36860700001)(42186006)(8936002)(336012)(54906003)(110136005)(7636003)(47076005)(1076003)(2906002)(5660300002)(70586007)(6666004)(478600001)(82310400003)(4326008)(36756003)(426003)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:36.8223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b143d85a-9a78-4ecb-b86c-08d972c45245
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT033.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR07MB8955
X-Proofpoint-GUID: tov-EPriBHnISyWTZcCqC0viPKFwE4ef
X-Proofpoint-ORIG-GUID: tov-EPriBHnISyWTZcCqC0viPKFwE4ef
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=833 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename SSC macros to use generic names instead of PHY specific names,
so that they can be used to specify SSC modes for both Torrent and
Sierra. Renaming the macros should not affect the things as these are
not being used in any DTS file yet.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-torrent.yaml      | 4 ++--
 include/dt-bindings/phy/phy-cadence.h                     | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
index bd9ae11c9994..2fec9e54ad0e 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
@@ -202,7 +202,7 @@ examples:
                 #phy-cells = <0>;
                 cdns,phy-type = <PHY_TYPE_PCIE>;
                 cdns,num-lanes = <2>;
-                cdns,ssc-mode = <TORRENT_SERDES_NO_SSC>;
+                cdns,ssc-mode = <CDNS_SERDES_NO_SSC>;
             };
 
             phy@2 {
@@ -211,7 +211,7 @@ examples:
                 #phy-cells = <0>;
                 cdns,phy-type = <PHY_TYPE_SGMII>;
                 cdns,num-lanes = <1>;
-                cdns,ssc-mode = <TORRENT_SERDES_NO_SSC>;
+                cdns,ssc-mode = <CDNS_SERDES_NO_SSC>;
             };
         };
     };
diff --git a/include/dt-bindings/phy/phy-cadence.h b/include/dt-bindings/phy/phy-cadence.h
index 4652bcb86265..abc4ff81aa7b 100644
--- a/include/dt-bindings/phy/phy-cadence.h
+++ b/include/dt-bindings/phy/phy-cadence.h
@@ -6,11 +6,11 @@
 #ifndef _DT_BINDINGS_CADENCE_SERDES_H
 #define _DT_BINDINGS_CADENCE_SERDES_H
 
-/* Torrent */
-#define TORRENT_SERDES_NO_SSC		0
-#define TORRENT_SERDES_EXTERNAL_SSC	1
-#define TORRENT_SERDES_INTERNAL_SSC	2
+#define CDNS_SERDES_NO_SSC		0
+#define CDNS_SERDES_EXTERNAL_SSC	1
+#define CDNS_SERDES_INTERNAL_SSC	2
 
+/* Torrent */
 #define CDNS_TORRENT_REFCLK_DRIVER      0
 
 /* Sierra */
-- 
2.26.1

