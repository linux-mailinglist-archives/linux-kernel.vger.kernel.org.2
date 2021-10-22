Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BE1437B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhJVRFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:05:23 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:47364 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232149AbhJVRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:22 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEgQ11012896;
        Fri, 22 Oct 2021 10:02:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=LxhFqcql4Dg9Uel4uwEVR1Th6ctjD9b+FSHFKo8jkCk=;
 b=FEzg+3aVWMsSz1iP1j2YwVOsgTpTi3ZjHmspVZnjxssdyS5+PL+iqDryKwM+xPrvqGB/
 N24AJEc3cTNxg7ftwTAwv2qv8EapTpi28KZAtz9WHOa72Ns9+LdbZmLIpsXvlUR6OlNr
 LLZB9p+1L97LvqgXc7mPmeGlhBt75SOgFxSOizUFwE3Thpo80fHCukvurJJ6VvwFGTw5
 Mg1QpIJNEfONi/IZuPfes4oNc41abMqlelDnw5XUK0QOsqGfhrWYAgaJ3QvYIy/ojj1I
 TzS3kjOQ/WqoOMx6lQx/rK6unhL+Hx63cAk6ZahE4r46w1EkAyeunEvZu1JEYU0aX4rn JQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3buya2resq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REZ0Zy8W5JOW0Gem6D5NuPqz5rWbGp51mCJ7ZpIVjr5yjUaAlfGrHx6CVp+DiJmk997fRcu1Nuz7KCN07O40EKk7FGLFyrU9kWyb3Q+zO/+TXqP+F6fF9nm22ua7O4YwE/AkZ8oAX9zMA4wBAknaOqkCBzClNo97mxiEpkVlZ8TTidcLbbnoES8JCrUk3keH1EF8O4JbvQnVIK98YaJR++dbBz5WfTcztUVnqyikrdyAGO+MfQuGL2Gq8fe36WPLE1B3gV8Qarx0nh+1ubDFJkA/A/sjOrhn+lEmOCOwCUyRErLaIPDf+LYQi4OfeHJK/Y5WOzDesPU3CJONXnI8Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxhFqcql4Dg9Uel4uwEVR1Th6ctjD9b+FSHFKo8jkCk=;
 b=WX7VqbBB9Fh8ezMRICbIzEmhY6WlOu1uReWB1UeBvrd03pi48ApzQCiCREkei03d8i74aIUdWCkWB9/pvh0wVn9cOWOmnkccbT/MdCAxQ6UoCXGewXJzwlKxBtrOXT5C+CDdqqkknRxUp9v5jSK6fdeHIPaOe3Lr9po0/jlMivpKyd8zeJ74wyQNIcsKu84sQQD8Pb7w2eHzbIoJm6oDqPg6K2PNOTWIFMSQODx1ZdQVVFHbo5+hLML7YLMt/B2g7b19OPV7NIjBZ+OCT+mwl3CM6dP3aK+AetlmIvixcdd1ijttOaBVq8+cuAPtRv4rr8EN4idd2jQX+Zh40f62Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxhFqcql4Dg9Uel4uwEVR1Th6ctjD9b+FSHFKo8jkCk=;
 b=0NYdr+JErzM2eTjSm81SGDH6p0oT7dEY83oE2zXGdkbAR1hCVHsTjzQXpS2Ykb167HQzH+GmQzE9/47/OQNlnpV8T/GVP8HzvNQaDO1dMPo16o2Y8D8mUWBrteUWsKv2SJrqGrboR6yZI46r7IWlqmoAtQIn9bQ8J6hCK1z8q8Y=
Received: from MWHPR21CA0035.namprd21.prod.outlook.com (2603:10b6:300:129::21)
 by BL3PR07MB8884.namprd07.prod.outlook.com (2603:10b6:208:357::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.15; Fri, 22 Oct
 2021 17:02:49 +0000
Received: from MW2NAM12FT007.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::21) by MWHPR21CA0035.outlook.office365.com
 (2603:10b6:300:129::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.1 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT007.mail.protection.outlook.com (10.13.180.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNJ008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:49 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 19:02:38 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 22 Oct 2021 19:02:38 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Oct 2021 19:02:38 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2clS018902;
        Fri, 22 Oct 2021 19:02:38 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2cmP018901;
        Fri, 22 Oct 2021 19:02:38 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 04/15] dt-bindings: phy: cadence-sierra: Add binding to specify SSC mode
Date:   Fri, 22 Oct 2021 19:02:25 +0200
Message-ID: <20211022170236.18839-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e7c726f-13af-4378-2d92-08d9957dc740
X-MS-TrafficTypeDiagnostic: BL3PR07MB8884:
X-Microsoft-Antispam-PRVS: <BL3PR07MB888463987D23C79D9FD2A045C5809@BL3PR07MB8884.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIzNvrvmP2nKVUM+tJd8DlLw93j+0gbikKEaUCX5CcLHZhYTra5x/gQipuFVx3GxVxMn+EJ/uj+aFa9ErGf00Sdux9T0L3cXpavO2k2TcFM8vpgLg7ncfmwdnD7kpoWHLRhIeYkiAsDN1E40ka0J6gz6i+S0CN9hesNNWvTnCpoJoOsLKBTafPqEg5HwDEFiVvCUdbUPmeV5JdCMGLel+I5ZSlafGF2uAhva2sPegk7jom+uytDGBM9/q4dQfaB7lqhxyNRmTEJpDT/wrO+9Lf0odKptqjSSkgjFTsMyuzGMnz7/myJ/HA8rK+DygRQHH1sNP1Kk8NPWHpQv4fUIHcnQH1FoDdhQrBY5hwl6uckSqbI4q9G1A4RGVYKD+5h+720Xd7Vx/6F5V8DtwwkEKo4mMVY9dD0aCgc74vm3wev7co/vSTNduBzXi8N86tRHboFGHpQDkje5tR0znt0j3zZl8gfu5ugM93ON7YWH2buqd5Qxs2p9n7TMwxDq+xVkiLPN648F5UGTStzbXFr8xgtPQMhFMcBSttyOd/1geRX//XdPgalNhvNEAzOcP0sFNaWTmRBHlNQdKsilF9l2kTYJfwwjy1yzE6iIkBRJEhBNL7erFaH0qubUvrWPNUR+SgVl4Da0vYfp0JwWtPRhK/gUS8Z1JJt64bUMqOElemY/exTRDOVTsc3ilaTPSrDjSQFi+yJtf8FHd3GsX6ZLtvEUTU7rm8RWg0NT+nJrz6g=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(336012)(1076003)(47076005)(54906003)(110136005)(2906002)(36906005)(36756003)(70586007)(26005)(6666004)(4326008)(2616005)(316002)(426003)(70206006)(42186006)(8936002)(82310400003)(186003)(86362001)(356005)(508600001)(5660300002)(4744005)(8676002)(36860700001)(83380400001)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:49.5338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e7c726f-13af-4378-2d92-08d9957dc740
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT007.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR07MB8884
X-Proofpoint-GUID: lR4TAAjVBXlTYy6vskGii47hKvsbfjJx
X-Proofpoint-ORIG-GUID: lR4TAAjVBXlTYy6vskGii47hKvsbfjJx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_04,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1011 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to specify Spread Spectrum Clocking mode used.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/phy-cadence-sierra.yaml      | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
index e71b32c9c0d1..a9e227d8b076 100644
--- a/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-cadence-sierra.yaml
@@ -113,6 +113,15 @@ patternProperties:
         minimum: 1
         maximum: 16
 
+      cdns,ssc-mode:
+        description:
+          Specifies the Spread Spectrum Clocking mode used. It can be NO_SSC,
+          EXTERNAL_SSC or INTERNAL_SSC.
+          Refer include/dt-bindings/phy/phy-cadence.h for the constants to be used.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0, 1, 2]
+        default: 1
+
     required:
       - reg
       - resets
-- 
2.26.1

