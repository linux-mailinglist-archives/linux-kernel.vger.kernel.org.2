Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44C83B095B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhFVPnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:43:05 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:39402 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232376AbhFVPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:42:40 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MFWPA0031503;
        Tue, 22 Jun 2021 08:40:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=6myjQfJdV9OxdJ52Wxoohu8K6mg4KFN5NsaK5ZhQlhs=;
 b=DLOAt0qQgGSvcox53KkJa/o5eYBrq4E58OOCOCC1uRQpBMkFivjbWHpqFABqr7guWm/d
 CgcCqYj5/f8s2TRnxOscMZmFY2Zfbcr6j9lzq6PJ03/kIMHc8VZuW25oMXnoiHu0IWMY
 chrIciHWDw8zYq8F1V3+jbm1hzoLloYpGv8oXbAsq8PbIxOw0Kq3lNHqlziiVG2Z/JCk
 JTkXwVPBTjBu4Vkw4gh6z4ia3r+GTtEsOXzTb8gch2Qt1YHmG7uD854X0G033unKMzOw
 vW0/ZUfMzW/AZ7Y8BwlZkV+nRR5OjTkp3BldyRorSMZ6lQfVLoiMhCdy0OFjYDdOYuds 3w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-0014ca01.pphosted.com with ESMTP id 39apms59u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 08:40:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwN1Jx535lmrRLQBiuKb+7PmPhds6RxNCj7BjzgLcc0YyNw1ODmekXkBAfRfTPsWkKNaRh9Zg5+U8iIJFdaUVlkZKnXZQkzHX+UjUXjPGO6AWNLnEPpQOcHSBpN9IL44sEAe5uTPYheF7FzTXsS6JHY/4Z7X91aPUgfr0Las5OpNUeEmfFXMUZLCdhxEXUtARXOYM8mI2vQALe6U/u9WXLHWkCXwGpGI0h/nlXH/SNQn/KhtC2kV6oG49S3XYpK28Lav00RGNgIGiJ7iyao/V5Paeef/7jk+/iBbPsSkwqVpYyqt6yJo7CnE6QaYbth6F1+X2nhoqSWxcIMSuEe+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6myjQfJdV9OxdJ52Wxoohu8K6mg4KFN5NsaK5ZhQlhs=;
 b=QJGMSaKlqiosg8vnLdfdzrhC3cf4XcjijT//BMMGtztw3ExjLQgomMmgJtlMA9FM5mP0jiikGjvANxHKTXFzPxZkiVWsTQuzOOkssYByQvEKEdN5Y+H+tV6+DOxkjbFfUYHWOSioqTgyUO6msnM9dQW6RUb2u4zNufCzJ7WfAkCuoIDfsAjTCYIOaV7JQm1tQpJoCJtVY6FUN2X/cpewx/LMC3ynH/MjXqMo7GoH4sjHod7tXeHhHy3zOdpaDhV07q+PYL1JgnVcs0eNKSbPcR9nnfvt7Xdekj6yx+t994HnZ3bJM46RCw+s3CTV55SrQLH1XCqNzdNQgEuH9XuTBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6myjQfJdV9OxdJ52Wxoohu8K6mg4KFN5NsaK5ZhQlhs=;
 b=uFrukoeSYxtKL3fqHq7vOsW+1tQdxBmESg1f06ea1DhjlaZFrgzmCNY0brgr0XkLs5bUpy0SsCMoXtxzj0KkzNCj1iHqRJ/GhbIbVTSrjPtMea/5ZP+ndYSB52D4EPpA6aCoLL6hNWknlhcbkKgAesG7RvMUDslL5w3v7PV9sJ4=
Received: from MWHPR22CA0042.namprd22.prod.outlook.com (2603:10b6:300:69::28)
 by BYAPR07MB5000.namprd07.prod.outlook.com (2603:10b6:a03:5b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Tue, 22 Jun
 2021 15:39:59 +0000
Received: from MW2NAM12FT057.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:69:cafe::6d) by MWHPR22CA0042.outlook.office365.com
 (2603:10b6:300:69::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Tue, 22 Jun 2021 15:39:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT057.mail.protection.outlook.com (10.13.181.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.10 via Frontend Transport; Tue, 22 Jun 2021 15:39:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 15MFdpjJ219509
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 08:39:58 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 15MFdp1w002326;
        Tue, 22 Jun 2021 17:39:51 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 15MFdpDt002325;
        Tue, 22 Jun 2021 17:39:51 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v2 7/9] phy: cadence-torrent: Add separate functions for reusable code
Date:   Tue, 22 Jun 2021 17:39:47 +0200
Message-ID: <20210622153949.2215-8-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210622153949.2215-1-sjakhade@cadence.com>
References: <20210622153949.2215-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bdacdab3-ce75-48e6-b66e-08d93593fe0c
X-MS-TrafficTypeDiagnostic: BYAPR07MB5000:
X-Microsoft-Antispam-PRVS: <BYAPR07MB5000ECD6E432F895FA4252ECC5099@BYAPR07MB5000.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fchAJwi1ahDW7vhhHJwO7NXNfml1csLwvT+Pm6ty5t2ps9eyQhLxIy4W3ww4WorVhxUUigKbqm2zpogEopBy9lIG+09v1TtAKA/1/gbYsZLcBd/6LeidAfKEA/2aJU7o0Hye4fF2tlSbMVVk4dkEF2roAtyEhvfXPu5hzQ9RP4SGYVT3KMr0+mDhNpHGlBm0seuAux5NtidCpYZhUyqBPTs9eeyn1+rRlIg80n9V7giTNes0YuB09T+pecnHmTvgnwKVkwkhBMxnlgBPhko+sigsxlmcKnigoFM5roqBiMO7zBVzanyTX6N7zNfd7LhZTmj1Q42nNr54oBGPF1zgpFFQuxdjDXa96qzYHlY0RKou9oo/huBcQOvWOUh6wA2abwrLK4hScQdXsSYg4bRNoVIgFA2HkqPXcte3xYCpL3t5ROCSO1lZfQRho0Dd0FDp8OrTWp783cBNYikOGcl7hN0ojDul4TnyAl9c7fmqO+9H4x6X1zs8z3Zib3LqYYB9IOm99J67euueQN8HsTUSMm4l7F8ZrgHdDLGPezsCrjgMsxMaoUZ0VlVjRsvFHxs8+ns1PqFkytalz9YiX2Yph0Yf9vNz6xZ6NMLHSn/SPP3n6Tuh0ahKRkgRkf9p0X/gq8yEwjhBD6CRODWqryIq2ThemaLx1e6KVnRPNAWbzqROahTq/Kdi7/cQgvzY/ZlO+PsT1vukhSp5FgWhjt5aXiKSfrfYG7AtlZiI2KzG65w=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(36092001)(36840700001)(46966006)(36860700001)(36756003)(356005)(83380400001)(82310400003)(47076005)(81166007)(86362001)(5660300002)(6666004)(70206006)(70586007)(1076003)(336012)(2906002)(426003)(110136005)(186003)(42186006)(316002)(8676002)(8936002)(4326008)(82740400003)(54906003)(478600001)(26005)(2616005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 15:39:58.7826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdacdab3-ce75-48e6-b66e-08d93593fe0c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT057.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5000
X-Proofpoint-ORIG-GUID: TpvDDf3GTlngKKYWbtAjLS9XzVGbxSrm
X-Proofpoint-GUID: TpvDDf3GTlngKKYWbtAjLS9XzVGbxSrm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_08:2021-06-22,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106220097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Torrent PHY driver currently supports single link DP configuration.
Prepare driver to support multilink DP configurations by adding
separate functions for common initialization sequence.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 53 +++++++++++++++--------
 1 file changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 69466481af26..e4dd8d1711a6 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1472,24 +1472,11 @@ static int cdns_torrent_phy_off(struct phy *phy)
 	return reset_control_assert(inst->lnk_rst);
 }
 
-static int cdns_torrent_dp_init(struct phy *phy)
+static void cdns_torrent_dp_common_init(struct cdns_torrent_phy *cdns_phy,
+					struct cdns_torrent_inst *inst)
 {
-	unsigned char lane_bits;
-	int ret;
-	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
-	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
-
-	switch (cdns_phy->ref_clk_rate) {
-	case CLK_19_2_MHZ:
-	case CLK_25_MHZ:
-	case CLK_100_MHZ:
-		/* Valid Ref Clock Rate */
-		break;
-	default:
-		dev_err(cdns_phy->dev, "Unsupported Ref Clock Rate\n");
-		return -EINVAL;
-	}
+	unsigned char lane_bits;
 
 	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
@@ -1510,8 +1497,10 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
 	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
 
-	/* PHY PMA registers configuration functions */
-	/* Initialize PHY with max supported link rate, without SSC. */
+	/*
+	 * PHY PMA registers configuration functions
+	 * Initialize PHY with max supported link rate, without SSC.
+	 */
 	if (cdns_phy->ref_clk_rate == CLK_19_2_MHZ)
 		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy,
 							cdns_phy->max_bit_rate,
@@ -1530,6 +1519,13 @@ static int cdns_torrent_dp_init(struct phy *phy)
 
 	/* take out of reset */
 	regmap_field_write(cdns_phy->phy_reset_ctrl, 0x1);
+}
+
+static int cdns_torrent_dp_start(struct cdns_torrent_phy *cdns_phy,
+				 struct cdns_torrent_inst *inst,
+				 struct phy *phy)
+{
+	int ret;
 
 	cdns_torrent_phy_on(phy);
 
@@ -1542,6 +1538,27 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return ret;
 }
 
+static int cdns_torrent_dp_init(struct phy *phy)
+{
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+
+	switch (cdns_phy->ref_clk_rate) {
+	case CLK_19_2_MHZ:
+	case CLK_25_MHZ:
+	case CLK_100_MHZ:
+		/* Valid Ref Clock Rate */
+		break;
+	default:
+		dev_err(cdns_phy->dev, "Unsupported Ref Clock Rate\n");
+		return -EINVAL;
+	}
+
+	cdns_torrent_dp_common_init(cdns_phy, inst);
+
+	return cdns_torrent_dp_start(cdns_phy, inst, phy);
+}
+
 static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
 {
 	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
-- 
2.26.1

