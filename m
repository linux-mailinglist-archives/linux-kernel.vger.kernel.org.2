Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C604039DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348337AbhIHMbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:31:11 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:62648 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348699AbhIHMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:01 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886da7u016869;
        Wed, 8 Sep 2021 05:29:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=UNFDi+VfP3OT0OtHBJwsfpDaO+ySVlQg2KfC1zRMDE4=;
 b=kO8byl1vQDbaO+vCdUxnNiwiqNfmB4azT3vYPXs0Kq8Rys0aQDJiJIfwhJUftI+rzGXH
 rxEXlVvh/NoATcDPqY+6uKt2udIDVEKvde3jrzHaxuaHOUAJ18QcqkOwdhqJJPYEVVXM
 xa4Ua+Ui99kjzvZeqALHPj9oqq4yGi1+/wq/W4viipmE+4c69DGNMPiX7lOgoz/UZf1H
 c0nucmE7psYZgWZu+3seWMkItpV2c9bm0dl1ZSqOpO4hqDtaRTGGyhRROUmcG1VEoHk1
 c9MYihHrz9ueR79YC+EvnUQRuHjqHvtlua3gwJe1TWhieZ1MiY9PVtHjdkv810L8O/eM mQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3axcp9k47u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nCltmyyjBct/yvc9J9/yd/x+Tj2M4ilxxgVC19/Jx83E2ClwkVnq++temSwM5QVDvblFIchJficOhHDx52R9+6KKh3T+CXLtGXunX7vvWHb7mzgKhtxMkDTgUWazrsLRbhoB4f5AcEJn6y0nBRj/yPAx0ArhLu3xj4cIDG+bzFNygRG/2U/tEYvM4Js5YacyArv4EUJVcEKdbGClaeZpnkNEQupm5u9hFN4wGFVaBo7BKvpDYOlTY0chVT1sdQJWJGAwIoC2eSZkc04j+DGzMagfjeIhMqJomWQRzdqnGzxcc9TkwR01jGfqOe81fvCsDpTBIu1wQyLmThiLiaYebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=UNFDi+VfP3OT0OtHBJwsfpDaO+ySVlQg2KfC1zRMDE4=;
 b=cWQfRUIe1BwrWvgp3Exi8M6i32vPWyl8QRWm9CS8kiS8harDBirBEyD4yMRPbg+MFDYLp15l9IsNwohYQG/+OQdh7TUeNRyGF4BaQkf2gjdPsSmjJUXu7eCp9rXBstYyYuksQAYJDnTIgkDL7Ff6Ht/dAlkU+H8vkgkKCq4+KhMJyW0bHTBkUdVzYmFSsAhfaamsqhBwAgZp6r8iT2sc2U8OOwNRWmpO2pF6s6o7ihkPiAWzhPkbyagmmwVrHrkdswuEADKoX5ugWL2Ve+EbZEjPNDE3TG9qB6NuzkXXawT4SOZEzP8FaKfsUIR2GlzFNzSCJqNHeN2wRB8VwhiKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UNFDi+VfP3OT0OtHBJwsfpDaO+ySVlQg2KfC1zRMDE4=;
 b=koeA+9rR9deIgq2G+2rLbh61eIW461nQrVL6dgNICP4f8+D8jrkl0I+NSqpeeOu2HF4ielTYvAmThspi+suW32BiN/kXCW1BOFP5C7axoASmtVssiLJNdntUiQesUUC+lCbnluMHdcgAc5hmMkteI2SpwyAhsVTKTgVuJzEYUVU=
Received: from DM5PR21CA0067.namprd21.prod.outlook.com (2603:10b6:3:129::29)
 by BLAPR07MB7539.namprd07.prod.outlook.com (2603:10b6:208:296::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 12:29:38 +0000
Received: from DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::99) by DM5PR21CA0067.outlook.office365.com
 (2603:10b6:3:129::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.3 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT050.mail.protection.outlook.com (10.13.178.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9O026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:37 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 14:29:32 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTWeF010284;
        Wed, 8 Sep 2021 14:29:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTWZr010283;
        Wed, 8 Sep 2021 14:29:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 04/15] dt-bindings: phy: cadence-sierra: Add binding to specify SSC mode
Date:   Wed, 8 Sep 2021 14:29:19 +0200
Message-ID: <20210908122930.10224-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3129a48d-b193-40d9-f861-08d972c452f3
X-MS-TrafficTypeDiagnostic: BLAPR07MB7539:
X-Microsoft-Antispam-PRVS: <BLAPR07MB75399FB5056A476E7E829A58C5D49@BLAPR07MB7539.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wxj0sVdV8cRrT7DF2zbXD4YzdAOT5d4BF4Oo1+yfCfyIkNzAnJLN4zFafXaXsLp9D5HSMp5ngJaL8uBnfzFDSZgFu3OM6fJ4HMf7pgu+ujeUb5UMVZA4dS9DL5Da+wl6Z4alHN+YFdBD8WgcaZ8JEok0MKXLQ5kekvKPRM8jUPqTTswjPkp3Yhn4GurFdLNDZ1zaLxvcfdXDeISTFeDt3Z2uPX4sOz07R3h6lZcSY+XT4vRpF9oAOreyZQFlktxzDnaFVdsOi2JOt8u2WJSCL1iUzFOOMxUyXVtznhfno0f6JzubPbn6DHwuvwW9mJl+AynHybdxBL4QGHMsmvUaL64Qn+AIPpF4Gc9CBQWjXzKf15eFBv9YS5FvX0+V1KOGBpqLZH9CRTq3lmJ+MHj/6yOWFf6EGToHo3l+jZuGrjivs8gDC+QuBK3Nxks0cE0DJeRB6TkoQhkg7I0EVGU+tA+zB3tKqhhdnehGIcQkIUaSQ7l4i2MQQGXMtLf9KDs7IDAzZLELg6qK7lCJ2q8rF4fqYSjOojK4edxfbuhlHaXYC91dWFrK46zBom/QwomHVp3xx6QU6tYEm5lSuE6gAsbKtX4LiUStyhNBUWw9Z40qzqzb2R6uRvtJwVr3uRPelTXwDjb+pM44lFgVynCvzlkHcj4OWsayIwBt9M0FudHM5i3Z4zOZeGoGhVQGSc21IEdSnbGAn3JumzhwMX445O3g/eQWQsUMOGowGCIHLwY=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(36092001)(46966006)(36840700001)(4744005)(110136005)(54906003)(1076003)(42186006)(186003)(316002)(47076005)(70206006)(36906005)(70586007)(82740400003)(26005)(5660300002)(8936002)(2616005)(4326008)(356005)(36860700001)(336012)(2906002)(426003)(6666004)(82310400003)(86362001)(83380400001)(7636003)(8676002)(478600001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:37.9643
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3129a48d-b193-40d9-f861-08d972c452f3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7539
X-Proofpoint-GUID: vEu08IFaasSYuLgRwxNn9pJWe6EJNtQE
X-Proofpoint-ORIG-GUID: vEu08IFaasSYuLgRwxNn9pJWe6EJNtQE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to specify Spread Spectrum Clocking mode used.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
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

