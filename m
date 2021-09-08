Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828D24039E4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351541AbhIHMbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:31:55 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:13122 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349109AbhIHMbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:02 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886deXR016935;
        Wed, 8 Sep 2021 05:29:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=yqF7mKO3Hrt21qixd8fUfjDe3931vbHzUuAPth/6rSY=;
 b=ralp39otEFKvimjMxrVDBHMi6X1Qbhwg2cbXJtG+RIF8nY6LJ61xK8V0CpslPIhq8WJU
 HSwG1eJWc8IhsQl2A19bWsEiqSKEkxqfYUUM0osDs2rZzU+1DfNTFNUY0bmJcn52DLHD
 l2FoJjIQKZcFuXoVnqM9QY5fVKeO/mo2E+b2Me6XhGPHVgkmvYWZgdnE7T5Urj/VtQKa
 hB0+Ax0b5JKs6HpQ1IsjwcJeIebletwmy9k49SF5wHiU4Vrqf9KFlZ+ulaiAo5UmVSSb
 Nufo7NZDf5HoHDIvuG9ZqFfq7R3Mi/rkfooXzWypzjHToQbk/yOusrpiuE/gzc9dqQja 9g== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3axcp9k484-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikR2IB8nJqFQylolvcG+LZ9SDQ6Tv6SZMJl6b8QjdQSdZFef8ZvFmA1ltBihHrVKY9lUB3MRx+iZwPAAqR0iS0bKKMYHRHWn+8STnP1vCM4Lt11rM5bsC5uZ4zChwa33Kh6ueRQ3Ol7GySihKxqhItPCp+cGake2jyCUS1Z/DoST+evuMJ+oXHd1XbisqqgOJ1RCUAnxUqzNsCRnBLbAWLCWgoyUbvsOx+nlJA2fNhy8yBEt2B953HRFOkOAg2SBeSOOjdFRxHL/mTl28tN/ClVIKGjBR5e7xRLrgA3qwMWW3585fwxCHk0l86HK/qKxeQNP33XQJuotogSEdQZ9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yqF7mKO3Hrt21qixd8fUfjDe3931vbHzUuAPth/6rSY=;
 b=O/J7tlyvXWRGzxorYavQpsUNZUTSI6lnr+rP+dzxT4o3vOXx/gwkILiadqLdV0k8DGsqOzenQxdsK6Nn60UyNvsMzVJWtNz4Snx07kehfoJYQUkfI/cNAfe6gv828a+jHFDtzT/i1mdIZKPvUhfua4pmI9F0tBrG3r9IzJJ7xVodMCpK7FC9n/Tiq6hA1pflslGHMg2bbBNY/T8RkhxRQlbSLjEv6h0BelAcBaDhBZM4/F8/TWu3/+AanJmkxBs90iZ68cSIXUURcNmbTGzEGxwjjilWk0sCFJBhdlNsNIDYqrlsUlQJ4JkOE3ZxFYOcPiev04awBuvarbkNp7SEcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqF7mKO3Hrt21qixd8fUfjDe3931vbHzUuAPth/6rSY=;
 b=sFZeBSl7adsG0CKUXSVdkXmRj+wWinotzNKi07VILCjFB692qQLplkUa7igOfbEnBvOmzJAx7yYeo7DiMVc+gabmtwRzDt68xwh+XHjlvI9cpMqmXJzDGHn4cP66Gq5zjnZ5iLsbThf/2zFcpvkiRHx21MTB4ZEzKDjVQdwsEug=
Received: from MWHPR15CA0026.namprd15.prod.outlook.com (2603:10b6:300:ad::12)
 by SN6PR07MB4493.namprd07.prod.outlook.com (2603:10b6:805:61::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 12:29:41 +0000
Received: from MW2NAM12FT017.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::a5) by MWHPR15CA0026.outlook.office365.com
 (2603:10b6:300:ad::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT017.mail.protection.outlook.com (10.13.180.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:40 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9S026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:39 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 14:29:33 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 14:29:33 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:33 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTXhK010305;
        Wed, 8 Sep 2021 14:29:33 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTXsn010304;
        Wed, 8 Sep 2021 14:29:33 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 09/15] phy: cadence: Sierra: Check PIPE mode PHY status to be ready for operation
Date:   Wed, 8 Sep 2021 14:29:24 +0200
Message-ID: <20210908122930.10224-10-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e31b25f-3b1d-40f8-280c-08d972c45473
X-MS-TrafficTypeDiagnostic: SN6PR07MB4493:
X-Microsoft-Antispam-PRVS: <SN6PR07MB4493F458796C20CF0530E202C5D49@SN6PR07MB4493.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3k4asr4sIFPD4jkstRJlYa6PpcmvD9lsk6temS++gFytwcLi8WFTRgKCKQtaTBh0HX+GNBBkStvWUtVl6HEnXnB5Oh15bhQRQC5XeF6CxtFsS9H9F/mrP58TmNK+7d18MGZ9yLGp9uNOxjcFZrWf4o0ga6ACMndBlh8OIEBOZU6ZDpRz0fO69ReX4LarzWhaCRpcUBPe56pJT52zdNbkihlvOC0OtBE0kKg9sxra+ctDyTcgpv7kIE3MCsY8p26m7PYGGWQM6bf9LfCzPXT0OOcniEeNgRo2KzZduKHOxdyfeCy1o7TSOFKGj/7PVYsmL9vykiU8MCafL/Tc5FtvbToVgAGwCO22+5o4uKKga29TUQE16fWCvYUINREDjK27U7TqGx+fBysHmtD45HT4yCyXvVB8yqSWLMOO2c2DHKnw7YvfXS//cFJfohMCa6TiR3X05zD+0bFBMiv0fAUpDKpmL8kfnSrtnvADtaTnPUx49LYHSwTel+GnEbU49UIhDRDbSozyQQ4N1vT2QDb/yfo0qH8QSnrBKvhZPXP4GNh7MVw/BgeC/pVk6pfsOG16mOFogNJBJ5aBPgt5lHc+XvH5RonjwoM3ddTqZBYCp/rhZ4AXO1Qxb+Xhy4+YnImMF1Ad8aBph5yENUoRavEMpyileCAij+xB9G+F+4OBTCc47S+QGgbvW5BLb9eCPjIq05BfA1T7mRljj5+B8xtL+LR+M8PKgcYN0sHh/Qy84Tc=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(36092001)(36840700001)(46966006)(83380400001)(110136005)(54906003)(36860700001)(8936002)(186003)(426003)(4326008)(8676002)(36756003)(82310400003)(2616005)(336012)(5660300002)(478600001)(86362001)(26005)(1076003)(47076005)(70586007)(356005)(2906002)(7636003)(42186006)(6666004)(70206006)(316002)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:40.5045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e31b25f-3b1d-40f8-280c-08d972c45473
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT017.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4493
X-Proofpoint-GUID: 2iwpWqoICLGouPZutvj66LJXyl-KeVMe
X-Proofpoint-ORIG-GUID: 2iwpWqoICLGouPZutvj66LJXyl-KeVMe
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

PIPE phy status is used to communicate the completion of several PHY
functions. Check if PHY is ready for operation while configured for
PIPE mode during startup.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 73 +++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index e10ef4ecd6c7..e84dfd8f168e 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -151,6 +151,13 @@
 #define SIERRA_PHY_PIPE_CMN_CTRL1			0x0
 #define SIERRA_PHY_PLL_CFG				0xe
 
+/* PHY PCS lane registers */
+#define SIERRA_PHY_PCS_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
+				       ((0xD000 << (block_offset)) +	\
+				       (((ln) << 8) << (reg_offset)))
+
+#define SIERRA_PHY_ISO_LINK_CTRL			0xB
+
 /* PHY PMA common registers */
 #define SIERRA_PHY_PMA_COMMON_OFFSET(block_offset)	\
 				     (0xE000 << (block_offset))
@@ -181,6 +188,8 @@ static const struct reg_field pma_cmn_ready =
 				REG_FIELD(SIERRA_PHY_PMA_CMN_CTRL, 0, 0);
 static const struct reg_field pllctrl_lock =
 				REG_FIELD(SIERRA_PLLCTRL_STATUS_PREG, 0, 0);
+static const struct reg_field phy_iso_link_ctrl_1 =
+				REG_FIELD(SIERRA_PHY_ISO_LINK_CTRL, 1, 1);
 
 static const char * const clk_names[] = {
 	[CDNS_SIERRA_PLL_CMNLC] = "pll_cmnlc",
@@ -287,12 +296,14 @@ struct cdns_sierra_phy {
 	struct reset_control *apb_rst;
 	struct regmap *regmap_lane_cdb[SIERRA_MAX_LANES];
 	struct regmap *regmap_phy_pcs_common_cdb;
+	struct regmap *regmap_phy_pcs_lane_cdb[SIERRA_MAX_LANES];
 	struct regmap *regmap_phy_pma_common_cdb;
 	struct regmap *regmap_common_cdb;
 	struct regmap_field *macro_id_type;
 	struct regmap_field *phy_pll_cfg_1;
 	struct regmap_field *pma_cmn_ready;
 	struct regmap_field *pllctrl_lock[SIERRA_MAX_LANES];
+	struct regmap_field *phy_iso_link_ctrl_1[SIERRA_MAX_LANES];
 	struct regmap_field *cmn_refrcv_refclk_plllc1en_preg[SIERRA_NUM_CMN_PLLC];
 	struct regmap_field *cmn_refrcv_refclk_termen_preg[SIERRA_NUM_CMN_PLLC];
 	struct regmap_field *cmn_plllc_pfdclk1_sel_preg[SIERRA_NUM_CMN_PLLC];
@@ -367,6 +378,34 @@ static const struct regmap_config cdns_sierra_phy_pcs_cmn_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
+#define SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF(n) \
+{ \
+	.name = "sierra_phy_pcs_lane" n "_cdb", \
+	.reg_stride = 1, \
+	.fast_io = true, \
+	.reg_write = cdns_regmap_write, \
+	.reg_read = cdns_regmap_read, \
+}
+
+static const struct regmap_config cdns_sierra_phy_pcs_lane_cdb_config[] = {
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("0"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("1"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("2"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("3"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("4"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("5"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("6"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("7"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("8"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("9"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("10"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("11"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("12"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("13"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("14"),
+	SIERRA_PHY_PCS_LANE_CDB_REGMAP_CONF("15"),
+};
+
 static const struct regmap_config cdns_sierra_phy_pma_cmn_cdb_config = {
 	.name = "sierra_phy_pma_cmn_cdb",
 	.reg_stride = 1,
@@ -452,6 +491,15 @@ static int cdns_sierra_phy_on(struct phy *gphy)
 		return ret;
 	}
 
+	if (ins->phy_type == TYPE_PCIE || ins->phy_type == TYPE_USB) {
+		ret = regmap_field_read_poll_timeout(sp->phy_iso_link_ctrl_1[ins->mlane],
+						     val, !val, 1000, PLL_LOCK_TIME);
+		if (ret) {
+			dev_err(dev, "Timeout waiting for PHY status ready\n");
+			return ret;
+		}
+	}
+
 	/*
 	 * Wait for cmn_ready assertion
 	 * PHY_PMA_CMN_CTRL[0] == 1
@@ -755,7 +803,17 @@ static int cdns_regfield_init(struct cdns_sierra_phy *sp)
 			dev_err(dev, "P%d_ENABLE reg field init failed\n", i);
 			return PTR_ERR(field);
 		}
-		sp->pllctrl_lock[i] =  field;
+		sp->pllctrl_lock[i] = field;
+	}
+
+	for (i = 0; i < SIERRA_MAX_LANES; i++) {
+		regmap = sp->regmap_phy_pcs_lane_cdb[i];
+		field = devm_regmap_field_alloc(dev, regmap, phy_iso_link_ctrl_1);
+		if (IS_ERR(field)) {
+			dev_err(dev, "PHY_ISO_LINK_CTRL reg field init for lane %d failed\n", i);
+			return PTR_ERR(field);
+		}
+		sp->phy_iso_link_ctrl_1[i] = field;
 	}
 
 	return 0;
@@ -801,6 +859,19 @@ static int cdns_regmap_init_blocks(struct cdns_sierra_phy *sp,
 	}
 	sp->regmap_phy_pcs_common_cdb = regmap;
 
+	for (i = 0; i < SIERRA_MAX_LANES; i++) {
+		block_offset = SIERRA_PHY_PCS_LANE_CDB_OFFSET(i, block_offset_shift,
+							      reg_offset_shift);
+		regmap = cdns_regmap_init(dev, base, block_offset,
+					  reg_offset_shift,
+					  &cdns_sierra_phy_pcs_lane_cdb_config[i]);
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "Failed to init PHY PCS lane CDB regmap\n");
+			return PTR_ERR(regmap);
+		}
+		sp->regmap_phy_pcs_lane_cdb[i] = regmap;
+	}
+
 	block_offset = SIERRA_PHY_PMA_COMMON_OFFSET(block_offset_shift);
 	regmap = cdns_regmap_init(dev, base, block_offset, reg_offset_shift,
 				  &cdns_sierra_phy_pma_cmn_cdb_config);
-- 
2.26.1

