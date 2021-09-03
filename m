Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90833FF9D4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbhICFDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:03:11 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:20026 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233506AbhICFCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:21 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1830iwdg011460;
        Thu, 2 Sep 2021 22:01:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=r23o/aGrRijkmjGgDmtQ7mE9DsyPCqVxJm8ZLWdJ7Y0=;
 b=jrwEbntY3E08AurbHB83H61Yo30dpbgiVG7+6lVyZUIvdNloQtceQUWgbaC8r+2hJTQ6
 aaoJTAO9UO5PfbJjAR0zXpmO8IYvYlbfrVH0K0QQg4nrl8uitHqP1+8fx5A7woheGSrH
 dVM+4Q0o4AnBp2dn/Kuca4N1hgI93it4rHP/ZgHZxWSyXdzMiiJjcj5ABhLXjyvip9Hx
 YenBMccmYjwFQC/XAyy5SpsSYIbQomv7fTM1orEOiOJbFA+vNbh3oie9hbwpcacwVG0F
 NQzMHikvevSJtgGB5xCvkHwcHdodtRgxOmq2y0pKOAqCxUHL3B0SXsBvyigmeDHmt9eo wQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3atdvyek27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mwir7mkDOahHAWdxckNbL8bpRcSnnDWtF2M+TH56bWthPJ2uak6XtOcBzQNL5W7oq1Q4zLTL81Ru//m1rkLb26Lbzc2Yr9ramrYaVi4neGOQluoL6qjnJRwMBa2M50nrSGYA6JZWVG7XySbwhTqLAjoVpICyxUgEOKyjN+bfd42Pro7DjJlC4mBCWnYFCf5Uad/SfkOf8XpBkf5JdEJvYXp6v4UMdVv23bc7yBGY8ybYLZJb156tJaCDJM1+DkANOiHQ2wzom9uGNtX2b3U8zkxzn3B/56NchVOCUa5bvI03MK9lakvg58QD41JcW25GauuRa9BYQ8wOHGD+e/DwOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=r23o/aGrRijkmjGgDmtQ7mE9DsyPCqVxJm8ZLWdJ7Y0=;
 b=dMRLpCqrkT/fjprrEvp3eCcGL6Sk/eaTlvVJxJedosmKNuzhylhHywfdnoSYqfBR61YPhzkgv7jB9sYDOINtA3BKrwCz4VWNtbsSK2YEZYmiBd/afTKp966Gtv9qSQlgmRrZtFxkxIczWTQo1mMm17KvWar4oQlv8NbXhXmud4D6/R4RECxd2nBruFdeHFWKq6t4C3oVi0TDlLiotEwscguc1nmwiB0mcq52/JM7IF5cDr3IbD29CMTctBObiQeZ5z8fRni/5fKwTKSDrGfrd5A7oeRVa9kwYNYaB7riLZr8rlQrTC+Jh38EDUyreYimL29BuQYuYbdgewyBa3s6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r23o/aGrRijkmjGgDmtQ7mE9DsyPCqVxJm8ZLWdJ7Y0=;
 b=7nLOsKmDp/idsrJTvU5AhNo3evlYwsD7iG49DWmHA1RHnkybpnEnXhxU8iWKlQB0+wyAUHIMjDL5/0NDeV7Dfz0KZjfYSCIUHLKv9eSl7I9BhI7PaGYsQlyJnLTSjL8XPDGLxN9dQOrRhwgF9UgYyXhkjUgajIFHkfeOl/8i8Ko=
Received: from DM5PR19CA0001.namprd19.prod.outlook.com (2603:10b6:3:151::11)
 by DM5PR07MB2923.namprd07.prod.outlook.com (2603:10b6:3:d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.21; Fri, 3 Sep 2021 05:01:02 +0000
Received: from DM6NAM12FT039.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::f9) by DM5PR19CA0001.outlook.office365.com
 (2603:10b6:3:151::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Fri, 3 Sep 2021 05:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT039.mail.protection.outlook.com (10.13.179.59) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:01:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ufY020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:01:01 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:56 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 07:00:55 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:55 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350tnf025673;
        Fri, 3 Sep 2021 07:00:55 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350tuB025672;
        Fri, 3 Sep 2021 07:00:55 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 01/14] phy: cadence: Sierra: Use of_device_get_match_data() to get driver data
Date:   Fri, 3 Sep 2021 07:00:41 +0200
Message-ID: <20210903050054.25627-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210903050054.25627-1-sjakhade@cadence.com>
References: <20210903050054.25627-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 953e04ee-069a-417a-676f-08d96e97d3c3
X-MS-TrafficTypeDiagnostic: DM5PR07MB2923:
X-Microsoft-Antispam-PRVS: <DM5PR07MB29231073309C273268DD3580C5CF9@DM5PR07MB2923.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HbCF5fC2BlJJntKg81RQStdxmfYRdvCn/oEk4lxa5St/JiCLkVSp9Ux8R3v4VmW7ZN0RW6tjeIlcq7nPAMWdIwcF8MsNT8E32zUIZuUOMtcs0q36X9RqlsoQgxSSDKk6Qbrj+fn4mQHd5vNenhjpLYiRKJtrecs4YGmoMOMj5cQPw1iVFOr6Z6hmWbntpeqxoqnOZ6cj7BJw1IbX0CYZBq47onJsbKxomMF8tFvLXwRamPTdyg5LUIq6Z8+HJIOo87UAMTd2GbtsfiPkof9Wdh+ZRhIYFBlX+HNbcFjvvhwblpHnCILbvRZjQlbHy8wMFIAcIij5hlPkvRdAyyuYhznzIloELXmH1+fcR5NC5CxPP+iqZd62Tf0uBIaAsPVRovRwlM4J6m8+gEawHGDoxWhNMmAD+ZuflAfVlS22jjW+7j3qTModVNJRbQtOJQdwfOlhYVzCiUg+RnZEPe/zQOGgazpOOpocR8btezelND57WM87rtzM+arAViGTX58cyr2AdluEtxngd8yQvH1FC9UzFk6hU58zcocq8DzXZ2DnRe07WAEKZSushEhCA+u4pipg+K31wjOB53xKvnza/VChh1ZkkSGrKKyO0uk+uDPeZV4d/FjROmKL7HsXqDgi6fMIBff/goXa0Rb/GXIjrd0KA3HWEXX/z4Ur3DMukMm6I0Y6KdXLY1JSB2CGHU14kFGYOYc9s8HMLIN5UwHt/KdPooCSZt1EANLeFbN9d+o=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36092001)(46966006)(36840700001)(8676002)(54906003)(5660300002)(4326008)(8936002)(7636003)(110136005)(356005)(2616005)(82740400003)(36860700001)(83380400001)(336012)(36756003)(316002)(26005)(70206006)(426003)(1076003)(42186006)(478600001)(2906002)(70586007)(186003)(6666004)(47076005)(86362001)(82310400003)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:01:02.0691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 953e04ee-069a-417a-676f-08d96e97d3c3
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT039.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2923
X-Proofpoint-GUID: O39cnaYwUH5CYMzyntS2IWG96fhkiK0N
X-Proofpoint-ORIG-GUID: O39cnaYwUH5CYMzyntS2IWG96fhkiK0N
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

Use of_device_get_match_data() to get driver data instead of boilerplate
code.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index e93818e3991f..54d1c63932ac 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -253,7 +253,7 @@ struct cdns_regmap_cdb_context {
 struct cdns_sierra_phy {
 	struct device *dev;
 	struct regmap *regmap;
-	struct cdns_sierra_data *init_data;
+	const struct cdns_sierra_data *init_data;
 	struct cdns_sierra_inst phys[SIERRA_MAX_LANES];
 	struct reset_control *phy_rst;
 	struct reset_control *apb_rst;
@@ -595,8 +595,6 @@ static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 	return 0;
 }
 
-static const struct of_device_id cdns_sierra_id_table[];
-
 static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
 				       u32 block_offset, u8 reg_offset_shift,
 				       const struct regmap_config *config)
@@ -829,8 +827,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	struct cdns_sierra_phy *sp;
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
-	const struct of_device_id *match;
-	struct cdns_sierra_data *data;
+	const struct cdns_sierra_data *data;
 	unsigned int id_value;
 	int i, ret, node = 0;
 	void __iomem *base;
@@ -840,12 +837,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	/* Get init data for this PHY */
-	match = of_match_device(cdns_sierra_id_table, dev);
-	if (!match)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct cdns_sierra_data *)match->data;
-
 	sp = devm_kzalloc(dev, sizeof(*sp), GFP_KERNEL);
 	if (!sp)
 		return -ENOMEM;
-- 
2.26.1

