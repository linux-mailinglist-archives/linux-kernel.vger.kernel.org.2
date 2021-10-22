Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F02437B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbhJVRFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:05:46 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:28752 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233694AbhJVRFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:23 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEhB1u008069;
        Fri, 22 Oct 2021 10:02:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=5B9ve2mpCGnaBjtQAIGf5JYjG/1v1jS1oXk9hKYF0LI=;
 b=isEGS8Q0LH3ZrcweXPr0x6x11CkpE1yval31Bg9hpP6osjnnMTdQhK6jSMkdtxXZ4CKb
 dqe2IerxaBtYGdoy0wUAHKaMjGBrinZoZI1wj5CsDJHB/RtMJtqX642IJLPFKi0xF0+O
 UXzPq10krg05d5k/o4kqJEafrCF+9LJMKFG2JwX57BHjBOyvpbsBoMXrGmoHd62SsYWn
 kZ2CoO1+X6BAahYnM+HGxqpqtvQvVAED8LEChDyEt+pbIdQsGZOGHi/jjbC0A1suZoRL
 L6GU5SRw8vSpsmWxk/u3u7lo2ewtyQECVEv3QkfFZzn3GoQ+UX6U0iUlDAOVdUr2mD+D 4w== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3buxg0rm4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFwoTQ9zCCOj5L4a+i2rkiForjg6/rJnlwn/e172yShUqoOZ0DPxLovLr1gibSYCeMIpzCcUK+MZ3aGAu2ZYPkKTJumuQVUUAmipznB0YvMUqqc9tzSKDlQ/U9FjmhmP1Z4GR3pYCkJLQ0ayDYzwE64VOM94QSPf5gv+HV98W6L7jrJgIMLFpldjE9Ooi7GzRjrkwI6KtUZdcsRWgNQr1ukBXhLw0ChGFRc2p5pMJ+zCtlri6pwqdvXM7kFgkGC+bNn/4cFpPGERbcauv63QpLlRK8MFsXdqdo3TDdrSptUdqTEsuGpIesl630ICWeGzmxwfPNTBMrYb0y82aq8NPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B9ve2mpCGnaBjtQAIGf5JYjG/1v1jS1oXk9hKYF0LI=;
 b=NCFOUT/avPkJtQ+3RF+Ljvg9EfHNz7Cmh45Bu2kxDkE1qWQeL7qi2A0Memd1Dt+SjgaHY40Dxb2pGEh5CA2Yq2TvX+mGIwLDd34gYZYPxSNgBgnd7S+6qU1Jz3f9Pb+pfmplZNCChnmYdH6iphXIVhT0XkeiF/yojPUdE9albf1NWKxe6E1aoN6L5SzXTFQIhCL4tfM8pVs8Q2snwoZWoFUrja7N6nZqQwSI34WpMiDiRoLn0VHY2mPupa+8g8XUr6y48stgYxA88B5Qv0gwN/sKOebrY2azaHQ/Z9paOeIC0Uu+iiskRL4eeh/xLxbFI6DYt8iWb5Az4se73cwPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B9ve2mpCGnaBjtQAIGf5JYjG/1v1jS1oXk9hKYF0LI=;
 b=D/KBbp2pa7z+FdOJJpTuYZ6pjzORxfFJ7q44k6buLuKjh73k/0hzmoCisVEyvJypc/YVjFRIP1YwbpeEKKtjuv3Zh/FvptIOd980O/G+519AnXUKnF94WmgzXE7FosJumQTCB2kcyiVzRjqCPUXKtS18coBeLH+2eoJq2TP3jMg=
Received: from BN8PR12CA0024.namprd12.prod.outlook.com (2603:10b6:408:60::37)
 by SN6PR07MB4752.namprd07.prod.outlook.com (2603:10b6:805:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Fri, 22 Oct
 2021 17:02:53 +0000
Received: from BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:60:cafe::c8) by BN8PR12CA0024.outlook.office365.com
 (2603:10b6:408:60::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT042.mail.protection.outlook.com (10.13.182.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNP008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:52 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 19:02:39 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Oct 2021 19:02:38 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2dph018918;
        Fri, 22 Oct 2021 19:02:39 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2cjM018917;
        Fri, 22 Oct 2021 19:02:38 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 08/15] phy: cadence: Sierra: Check cmn_ready assertion during PHY power on
Date:   Fri, 22 Oct 2021 19:02:29 +0200
Message-ID: <20211022170236.18839-9-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 22dffa39-cb78-46b0-aec6-08d9957dc983
X-MS-TrafficTypeDiagnostic: SN6PR07MB4752:
X-Microsoft-Antispam-PRVS: <SN6PR07MB475272517E6AF0CBA16CBF80C5809@SN6PR07MB4752.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IA5GM57CEGa3P2DJg6lM+TxD/zUh37ewtjfjSG47jQz6Py+z6IHOu+OAsUD7CL1lW9Qa341dLF7A7bOzPkCo0wWViKDw6HuJQIxlSveMTOtP0RR/9Cetg5EVjxAiFoLe+uV1XhQyZ9bXStTQjbcsB4jJtqHyG/Jv8uikZkxIsppsRtif8UtRd4CIo91d5TPKI0HkhiZg1gebDwQKoOvvHKFYnsbmdjSnjemWer0GfxjE4HAfdXQetO6uWSCqokjsQ7mCtfnAwIrN1PDrQgkJzAUroQaWJ1hhnkah2uiYrJwvQ5AQB5lkAmRWqB/HGvbiEjp8GEeiRNaaUqE6FL9z/NXW0Ordgh+fHP4oosRpyLGGkKsPN28ThzvF8AAJginthJ/aysgN2msvTxZMAjWrQBPvcOyiVAJlJeE9FPyF1FUHj/QXbM3T+ViBPWuD618x1B++z+GuyXHPPizFtqa1jc/KOb8gK7q7evVChI6wExiz+iQFgUofjY/N9kguZjEBiEjT2JFsjo8XdetVPQtY777KXeVQnTalhtAYlYKeuvxiUJJDuUUX2hNnYG/7fWlGJlkPp0F6U8SD9/gvWSi4GL8OFr96x68CSaQCfjTDCDduikgPgKWAYwY4nkEjwPIb25Pp8Hmv8yCirEWNJUkykO47QyAcxEEc2wTn6IIjCrxirBJtD8CVOEFjUe2d7v6Z56tXMbaTxhImDPmHJPY7kc3yr8vCaqLjDD1uznxdMs=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(82310400003)(2906002)(6666004)(47076005)(70586007)(5660300002)(1076003)(54906003)(86362001)(186003)(426003)(83380400001)(70206006)(36906005)(8676002)(36860700001)(356005)(508600001)(4326008)(7636003)(26005)(36756003)(110136005)(42186006)(8936002)(336012)(316002)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:53.2507
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22dffa39-cb78-46b0-aec6-08d9957dc983
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT042.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4752
X-Proofpoint-GUID: kmfLDDThdW62e-YYBPadhS0Cs6j8Ji9C
X-Proofpoint-ORIG-GUID: kmfLDDThdW62e-YYBPadhS0Cs6j8Ji9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_04,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110220099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if PMA cmn_ready is set indicating the startup process is complete.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 0bfd13843f2e..13176208e6d7 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -151,6 +151,11 @@
 #define SIERRA_PHY_PIPE_CMN_CTRL1			0x0
 #define SIERRA_PHY_PLL_CFG				0xe
 
+/* PHY PMA common registers */
+#define SIERRA_PHY_PMA_COMMON_OFFSET(block_offset)	\
+				     (0xE000 << (block_offset))
+#define SIERRA_PHY_PMA_CMN_CTRL				0x000
+
 #define SIERRA_MACRO_ID					0x00007364
 #define SIERRA_MAX_LANES				16
 #define PLL_LOCK_TIME					100000
@@ -172,6 +177,8 @@ static const struct reg_field macro_id_type =
 				REG_FIELD(SIERRA_MACRO_ID_REG, 0, 15);
 static const struct reg_field phy_pll_cfg_1 =
 				REG_FIELD(SIERRA_PHY_PLL_CFG, 1, 1);
+static const struct reg_field pma_cmn_ready =
+				REG_FIELD(SIERRA_PHY_PMA_CMN_CTRL, 0, 0);
 static const struct reg_field pllctrl_lock =
 				REG_FIELD(SIERRA_PLLCTRL_STATUS_PREG, 0, 0);
 
@@ -280,9 +287,11 @@ struct cdns_sierra_phy {
 	struct reset_control *apb_rst;
 	struct regmap *regmap_lane_cdb[SIERRA_MAX_LANES];
 	struct regmap *regmap_phy_pcs_common_cdb;
+	struct regmap *regmap_phy_pma_common_cdb;
 	struct regmap *regmap_common_cdb;
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
+	struct regmap_field *pma_cmn_ready;
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
 	struct regmap_field *cmn_refrcv_refclk_plllc1en_preg[SIERRA_NUM_CMN_PLLC];
 	struct regmap_field *cmn_refrcv_refclk_termen_preg[SIERRA_NUM_CMN_PLLC];
@@ -358,6 +367,14 @@ static const struct regmap_config cdns_sierra_phy_pcs_cmn_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
+static const struct regmap_config cdns_sierra_phy_pma_cmn_cdb_config = {
+	.name = "sierra_phy_pma_cmn_cdb",
+	.reg_stride = 1,
+	.fast_io = true,
+	.reg_write = cdns_regmap_write,
+	.reg_read = cdns_regmap_read,
+};
+
 static int cdns_sierra_phy_init(struct phy *gphy)
 {
 	struct cdns_sierra_inst *ins = phy_get_drvdata(gphy);
@@ -435,6 +452,17 @@ static int cdns_sierra_phy_on(struct phy *gphy)
 		return ret;
 	}
 
+	/*
+	 * Wait for cmn_ready assertion
+	 * PHY_PMA_CMN_CTRL[0] == 1
+	 */
+	ret = regmap_field_read_poll_timeout(sp->pma_cmn_ready, val, val,
+					     1000, PLL_LOCK_TIME);
+	if (ret) {
+		dev_err(dev, "Timeout waiting for CMN ready\n");
+		return ret;
+	}
+
 	ret = regmap_field_read_poll_timeout(sp->pllctrl_lock[ins->mlane],
 					     val, val, 1000, PLL_LOCK_TIME);
 	if (ret < 0)
@@ -712,6 +740,14 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 	}
 	sp->phy_pll_cfg_1 = field;
 
+	regmap = sp->regmap_phy_pma_common_cdb;
+	field = devm_regmap_field_alloc(dev, regmap, pma_cmn_ready);
+	if (IS_ERR(field)) {
+		dev_err(dev, "PHY_PMA_CMN_CTRL reg field init failed\n");
+		return PTR_ERR(field);
+	}
+	sp->pma_cmn_ready = field;
+
 	for (i = 0; i < SIERRA_MAX_LANES; i++) {
 		regmap = sp->regmap_lane_cdb[i];
 		field = devm_regmap_field_alloc(dev, regmap, pllctrl_lock);
@@ -765,6 +801,15 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	}
 	sp->regmap_phy_pcs_common_cdb = regmap;
 
+	block_offset = SIERRA_PHY_PMA_COMMON_OFFSET(block_offset_shift);
+	regmap = cdns_regmap_init(dev, base, block_offset, reg_offset_shift,
+				  &cdns_sierra_phy_pma_cmn_cdb_config);
+	if (IS_ERR(regmap)) {
+		dev_err(dev, "Failed to init PHY PMA common CDB regmap\n");
+		return PTR_ERR(regmap);
+	}
+	sp->regmap_phy_pma_common_cdb = regmap;
+
 	return 0;
 }
 
-- 
2.26.1

