Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFC9437B4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhJVRF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:05:26 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:62662 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231618AbhJVRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:22 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEgLoV012879;
        Fri, 22 Oct 2021 10:02:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TPcgxzMf0ZBvtJz/tlHuf2xI84b4LiRt2eVmxt46vOY=;
 b=E1Ad4swnO/CyoEXWQKpwb3BuFmCcPTo8cjVeBAFlQWGa4DCCPpm01oD0xqAH3zJQ4Ryu
 Oi6FGvlADd0myfOC1WD/rsn8zi2Z+9r5Kh6fdeii4xrnwmRD3bC8fG4QLgJqaS4BDRNV
 vACFCap7kVrDcZwK4aswp98x1EsBXNfEk8+rU3x2zpPEJiODTUXbQgj5ZURDQdzoGCHU
 gbnc5Gjv8HHay2gviCUHgyYRR6fpftHIMrSzr7Myrsoq2ZuW8IQ/GTuvGknGokXY+Cn8
 17hgCe656bOAyXnmEruEUFUJg8xd5MebPIq8RxeMUACKx80zwxaKvRdbcKsOltkovkg6 Cw== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3buya2resb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UxoiHij8VOLPahv6nIWGR+EdsjCuIm1ILzS1acFt3Pqbpjw+rsXxZaLAmDlJdnC5pK6OWjyGxFnPB+Hr9Pf3u8ItlCEw4vEygIqQU4jKSPCZtmGF/w9U5H3UIW1QU/RMdSF2NbXInJCHxqsYikJDkHXFP2jfrx5i3Jud7QNwtRmTiRbvra6v6q/VJIMqps70lesM55kunvQ9h0bF3o61ZqOFrVIIcBCa0kBTswxmuv2QsbfheAk3RU/VjSq2C2wHeUJGCVWjkfXRXFoTNucZuDkA0V/MXF/C7a4raWDgX9jqpPNNOmX91DvF+I1phE/Mdpw768fjmkmtvxBS1qE9aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPcgxzMf0ZBvtJz/tlHuf2xI84b4LiRt2eVmxt46vOY=;
 b=dZP1KOcOC8YaITbgNDnLk7Bbt6QmASuIHgPyHxO0V3Dc6DXYKsUmRE8GAPM92qw54Vqpw08rZ5I8YPlTsMRranwMiGWwBmL9/r5gFtX18Mq7FfVwVE6TBJsNuctyKy557zH5wy2gdRzWKEcRahG/5hVzN0d2pb13a6++p4aviEtrDTIuzFzBxB80SVmu/dneJlkoi70fi1C+DlOxF4VsidoAjUjqOla78CWsdy6gDk6xZYJJV0DEQePTYGtUuHCR6y6fWKkt0ZgvBxLPhMmNusuArOtF/iKGC8SOELRPT2dCn6y0tmt31bqwPT53LymXkY7M8gZ9/Y4k9eImlT67Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPcgxzMf0ZBvtJz/tlHuf2xI84b4LiRt2eVmxt46vOY=;
 b=GbbnXc9HozvIKsxzFZhgjbwhK12JumwoCI6Jp/1OxVpOCIURUpw3SJSpyFLo+FdqC5SDMjS74y1jg2vGPBeH8+6rfR3QwrOvY5Z3RDKB6ewJXW8ryGypuz2+KWRMPzcQY3nLIWV9ufpWYU68c4AbEsnsVcBClX7bXh3CB15lwfE=
Received: from MW3PR06CA0020.namprd06.prod.outlook.com (2603:10b6:303:2a::25)
 by BY5PR07MB7016.namprd07.prod.outlook.com (2603:10b6:a03:1ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 17:02:48 +0000
Received: from MW2NAM12FT048.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::d8) by MW3PR06CA0020.outlook.office365.com
 (2603:10b6:303:2a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT048.mail.protection.outlook.com (10.13.180.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNG008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:47 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 19:02:38 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Oct 2021 19:02:38 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2caS018890;
        Fri, 22 Oct 2021 19:02:38 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2c0s018889;
        Fri, 22 Oct 2021 19:02:38 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 01/15] phy: cadence: Sierra: Use of_device_get_match_data() to get driver data
Date:   Fri, 22 Oct 2021 19:02:22 +0200
Message-ID: <20211022170236.18839-2-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2013aa4-d9bf-4344-837a-08d9957dc641
X-MS-TrafficTypeDiagnostic: BY5PR07MB7016:
X-Microsoft-Antispam-PRVS: <BY5PR07MB70161B9C8913ADC57F299A3FC5809@BY5PR07MB7016.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YLD2ojj7aHd4a5wfj/iuWJNcuMP1jFKnWaVGzCrbdsozGsWAYOpmvGV10qPwe2mPM0dNOrHZ/mx6TzPRpj5ZfQOyrVKKMaDVNy1blFNuXHLCppobXK+bIOHlNdRWLrzcbX3IE2f/bHM71672UftGmXtujFNI+OsyNcZoZYsdObDzCMukU//VhsGMiUqs0PjlnlMe3GIwUWE6FFV4GTzfj/HaUgLopiSosk3GphMEUBGtjhPNi+hqWw9FuP5K14JNrp+RkJ/TrUlTbqUN+Hw3es94Tooewm1s/KjVVW1bQPO8lVOOpHtSkBC2y79Bl00Y1QU8Z14hsKjcMJnVtiiDtikx0GUDDKomubzEFG5Du9xw4tbzLguyBStBHkCsIvXZvmiBY/Bym1z4SFgzrVOum1qZsgUVLWAYjnCzQoK565PEC5GT0QZjuz//wCvOM7Yzl001/Dzf8hy+kdv8+/kWF3rC9anYj1UhSCqciQdV3Lhqwmk3pj274lYuZLsOscyPLUowt40KtQUy9Q4GxBOBzVNr+I0SD9M8SAMBo4E0i/ywNAqfV5sV54465+H0dp/0hi3FEcFaw69UIL6wbmN/SQiI4a+Q9q4k4ymN4FC92J3qRce/cfheADiS3KUlOC0+zsTPw/gHX/SEmbEbVyA08kEHfi8o7tZDifoSiTWdCisIjPdMH/lWDzbkWeK6aHT8pANOpkImDKMcgxOowBKeX8HTvOG0Oh+UyqdSUQh14f8=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(186003)(1076003)(70206006)(508600001)(5660300002)(4326008)(6666004)(47076005)(26005)(426003)(36756003)(336012)(70586007)(356005)(7636003)(2616005)(2906002)(82310400003)(8676002)(42186006)(110136005)(36906005)(54906003)(36860700001)(83380400001)(316002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:47.8669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2013aa4-d9bf-4344-837a-08d9957dc641
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT048.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7016
X-Proofpoint-GUID: s8Y5w0VHMM1qSiJJVOP91JGfcqDf0jcF
X-Proofpoint-ORIG-GUID: s8Y5w0VHMM1qSiJJVOP91JGfcqDf0jcF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_04,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use of_device_get_match_data() to get driver data instead of boilerplate
code.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
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

