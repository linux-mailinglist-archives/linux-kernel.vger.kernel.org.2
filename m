Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9AF3FF9D3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343752AbhICFDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:03:08 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:46764 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233523AbhICFCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:21 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1830RqT6011272;
        Thu, 2 Sep 2021 22:01:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=bk5WgA20RjDXOFQnDuisiZsQbzB7rL5njRj9beyV8dY=;
 b=moun/VtnZad2ovoGI+IcLTmWyrwd24uxCW+4k/PrWaNUYwvFQh7o+FhWn3/zcIrZqRYX
 ztRplKQU/OhtTUbRgcpd2sIUiTzdCKRnaPDc+yJAC44IOjtJBKyXjd8AAw9UqSIPzuoT
 f8ZnghAwWGfXKmEHwbZEQITx0t3G9w8Coi+0wbJqWH8L/ZIZKjWMAjJguQ3wR7FEozJR
 NHJ6GYKX8CJbgFHErfRNbILL1Tl7e3aMuOnEqpMnatR8t59z1i+nENgka3IvMz50aE4o
 JaN1oXypt1kecOogAzsyUM+k5wFc22mbUzEXSrEk839LDVm7Qp0SeAZ7AbOlKK7xdWLF 7w== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3atdvyek23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJU5NsGvRSNm+njEQoA9vvJB77MNnEk+cREyADzMlEPcswx5P5OpFMAtBdHpsxzO75l63FYd3tlLqfZS1cM8tl7kPC7fOAc99anlYVyp1czUKfaL6llqXjJ8tsEv57N6//yFbk/am2B4N8TGuL7c40sPkopPgD+988sdMVCSewXW3DA1kmGK5Yldyimfo+mH+/Q7i1gsO0jl1nQI2cEYRCKLL6RmiU7nsdLkTZBWIRHCBJJHfV2gSPOGATYRx6dEFSCi3p7Ta4pVDbVWdrttqbksLEo3gjPS6nT9nlzcKqJ5tPVBbQolLZ5025aP1sqqBcyNII9wLUN6T9ro7EdWZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=bk5WgA20RjDXOFQnDuisiZsQbzB7rL5njRj9beyV8dY=;
 b=Rg5NogOhLVriqyiAGkD8EBYX6CSUfCgWTRu2tKLm87Hc0k9L/8eNsoRk1jkKm5gG+WAJTnQM4JP8YE7fCyH2E2ATHRl6PvnivTWqGoZk2S0GmgypprmLi3IcYhS4lhv2lv9vLDhQfvUAKxFJAI6v+H5KIqm225TlPF/dDe23K5egaEyRA86o+ix6XeQp94DQTNgodXtnIA5h1ljAalyF/ynABrW9PbrnhHYNMRcBHEdqvE00Bniyc0GS7tKb3n8klkrSXI1fx5qAPGd3YD0usHXrcDG5w+titZJVknIFcareRkvsAvgidnWHIj3N7uWBPlT01BUUOqIImyBwFcU2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bk5WgA20RjDXOFQnDuisiZsQbzB7rL5njRj9beyV8dY=;
 b=Wv5YJWxtGPB1/xQRRqoiMgXxxD8pR3u7b/r9jW2EqI+RoF/8a9c6LcaTwo2UFJNJ7dE3wU8gsUOwoRTy4Sr2r9xnNS4WybrYT2frh3Ss+Q/1+Zak26alvXvLcms/BTR3yGqqsH1vxkPP10NovYncBk+E3uXe6QK8vLm8Gqbks00=
Received: from MW4PR03CA0206.namprd03.prod.outlook.com (2603:10b6:303:b8::31)
 by SJ0PR07MB7518.namprd07.prod.outlook.com (2603:10b6:a03:289::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 05:01:00 +0000
Received: from MW2NAM12FT055.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:b8:cafe::f9) by MW4PR03CA0206.outlook.office365.com
 (2603:10b6:303:b8::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21 via Frontend
 Transport; Fri, 3 Sep 2021 05:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT055.mail.protection.outlook.com (10.13.180.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:01:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ufV020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:00:59 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:56 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 07:00:55 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:55 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ti1025681;
        Fri, 3 Sep 2021 07:00:55 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350tqV025680;
        Fri, 3 Sep 2021 07:00:55 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 03/14] dt-bindings: phy: cadence-sierra: Add binding to specify SSC mode
Date:   Fri, 3 Sep 2021 07:00:43 +0200
Message-ID: <20210903050054.25627-4-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210903050054.25627-1-sjakhade@cadence.com>
References: <20210903050054.25627-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eadf7a78-29f6-4237-86da-08d96e97d2ab
X-MS-TrafficTypeDiagnostic: SJ0PR07MB7518:
X-Microsoft-Antispam-PRVS: <SJ0PR07MB7518EDA6E50E909C0655F12AC5CF9@SJ0PR07MB7518.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nZtzFYT4psWB/AhLhO3itKegA6TBUxZXC1pIZ8GsCvPnHtOE6KAsCazAJAYECYKzCY4Pp7BCOEjVIE4JsgZUKxd9YugiJUlBBNYhA3fxyKJ5VUYYAvDBWOIWZA5loNLnc5Ura5QkwA8nRse7+HW/1a8qtSCokfk3rig1T6L7dcxboTTuRUTcVEneMbUBx0GLApMcqRcomnvpJUJzEfee8uurOIMVK4IzgIWT4AYn0Z9CrBftFOKetp4F1eXEx1dmXvpO+Z6VG182Yj5vnmU1amtn/DEDEYQ9Tr721IgIufh5FdQqxlwd/yrTp1a73TjYfHiFTxyzR5Joe/l6/4XvLghmIs/DGY/55aACC5VE83XuDdVdbPXRyGlUIey4t6mxCdF2pdfNIdW2KH7B3G1mz8CtcgbPrzzBseaS0kfPDjLjr+wVuLni4+i28KCvgU6Oh12ZnvBnso+ki5XyZ+mOpQEZgXQxUlsVqmwYZ4k9Uo16FbV3l5BmsCdctZxRX2DTftgD0f+NcdD6n10UielW7cKxVxG+a/EPYxSMWqe/Bk4VNOFSgGi5BexRMYCUMZhzN1VFv2IJYmIdHDehX/JoUjp92cIKKmT7Udt8sEeQk+KLHHvC3gWRNWURxozsjzZAZxQRdSBHo9egbLRP+CP1M0yi2m5tLQYNn3Z8z02iXYqStOWPFyHsDEc/jqsl5bTGEqQuecGTG17MRGtom2CKLDAUBdb7J3xMKwBnVKopSs=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(36092001)(46966006)(36840700001)(54906003)(70206006)(70586007)(1076003)(4326008)(478600001)(82740400003)(110136005)(8936002)(36756003)(36860700001)(8676002)(5660300002)(6666004)(316002)(2616005)(42186006)(36906005)(2906002)(83380400001)(86362001)(7636003)(186003)(336012)(426003)(26005)(356005)(47076005)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:01:00.2649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eadf7a78-29f6-4237-86da-08d96e97d2ab
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT055.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7518
X-Proofpoint-GUID: A2Wl041MID01ssG13cyypqM8n4daYVKj
X-Proofpoint-ORIG-GUID: A2Wl041MID01ssG13cyypqM8n4daYVKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_01,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109030030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to specify Spread Spectrum Clocking mode used.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 .../devicetree/bindings/phy/phy-cadence-sierra.yaml      | 9 +++++++++
 include/dt-bindings/phy/phy-cadence.h                    | 4 ++++
 2 files changed, 13 insertions(+)

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
diff --git a/include/dt-bindings/phy/phy-cadence.h b/include/dt-bindings/phy/phy-cadence.h
index 4652bcb86265..0122c6067b17 100644
--- a/include/dt-bindings/phy/phy-cadence.h
+++ b/include/dt-bindings/phy/phy-cadence.h
@@ -17,4 +17,8 @@
 #define CDNS_SIERRA_PLL_CMNLC		0
 #define CDNS_SIERRA_PLL_CMNLC1		1
 
+#define SIERRA_SERDES_NO_SSC		0
+#define SIERRA_SERDES_EXTERNAL_SSC	1
+#define SIERRA_SERDES_INTERNAL_SSC	2
+
 #endif /* _DT_BINDINGS_CADENCE_SERDES_H */
-- 
2.26.1

