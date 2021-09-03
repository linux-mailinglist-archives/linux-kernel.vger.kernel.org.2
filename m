Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE95C3FF9D1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236553AbhICFCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:02:49 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:11662 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233468AbhICFCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:21 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1830iwdi011460;
        Thu, 2 Sep 2021 22:01:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=yqF7mKO3Hrt21qixd8fUfjDe3931vbHzUuAPth/6rSY=;
 b=fwSOK18G0tYndShFoJyD5DYaZKCxVTHI31DviBQMHO/lhBsT24Kp3U1SYsTVE8wxMr9f
 e/CmYuNpBuO1zHKbvTK0sklkuYbiXYpmGBzcw3n4LXMTSISt5dA0o5aDvCfdV9ecKJq/
 B8V5wp/Muz3xhNOjxrS3sbY6foZiHHLfl+lMXOfZDyWm3jNp4Ddok8mz6dM1E2K3RLZ8
 sNMJXuN9Jnh9lbo2iTDT+x6+rVKBLslXJ7unFpv+vNJINpoUBp20WChIm71PuJs9pFmh
 dokqxuP7cpv80mSXNr8Eli93B3VUvDpjKa0RpsK/lIAZYGaauEL/6envoS94DN1csfG0 1A== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3atdvyek2q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1qsr1wm+ejAEKgBPjr0xYtSyisK6Gk3wDk+oReeIkehySqvr74Ml2HcipPT3S8RZWyQX7wSedWDMQzF4TRhB8KodqgqPQ2PYrAL8L+5nRIn0i7IUZRvBmfaZvvsG6bAjJGbjth2QmL9w7Uqpk8U25lbZCu3YDGvg+9W2IQfanjHE3Ct9cCytSv0185RGlf3AvTLBGz+LQeqKmIgYz2/GArp+zROdkLEEqNtl1pVAzFzeRopMlkYHGxFr/znFHptMx+hI9t7DlBrih6pdFrso8NU0dcEIXeXUgLq1Ykq614S+AER9RUJmjejYb0gP7HWN/kDnCpfNw+Ru0TD5DM9Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yqF7mKO3Hrt21qixd8fUfjDe3931vbHzUuAPth/6rSY=;
 b=MNtCUDC8lCiLbhRmAqTiyiorC8cg1/2BZOQGOicuRzvqcsMCX+bF+Ybe6XEOQMjQXz5uDzp1RMzSsf93f/cJJQCz26GSRV2v2KEhW1Fi34r1wKYurbqPwWgT2KTD4baxq4GqN18XdQrhTRmozaj9KX7P9tYFDdbzfJO4TyDScY/PUWOuRLd1fLBl89vLTkPW5Nrep8RDgmUQT4TC8zHqQ1g+7jPD6C0gHuHgsaczHLSJYw9CWKGpW+Ty20gaMwf86LJhFNhC+tE0Cs24WFb7hup6ZOWUBe5XmR2EqLflWpkV265EQM3Dsvh9CdHG9o/ZtQUHYzQZxls+IqCAXiZ0LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yqF7mKO3Hrt21qixd8fUfjDe3931vbHzUuAPth/6rSY=;
 b=QMZSMP+A1l/1w1k0KNcaNTcL/6Kbbiv4d5r9zrxl7q6z4Ftgukivs/9wyBscakStEyln0cvj5EyhJYqdSHgRxxpgzgc8eMRjRLeKgfIXEhlPP9u5KnrfYsh2j94ogfAR3kcA60E4BQCbhKvZEvsy+E0h10McfWb19jfo22lt+qU=
Received: from DM6PR02CA0109.namprd02.prod.outlook.com (2603:10b6:5:1b4::11)
 by BN8PR07MB6948.namprd07.prod.outlook.com (2603:10b6:408:78::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Fri, 3 Sep
 2021 05:01:05 +0000
Received: from DM6NAM12FT068.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::12) by DM6PR02CA0109.outlook.office365.com
 (2603:10b6:5:1b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Fri, 3 Sep 2021 05:01:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT068.mail.protection.outlook.com (10.13.179.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:01:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ufe020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:01:04 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu4.global.cadence.com (10.160.110.201) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:57 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu4.global.cadence.com (10.160.110.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350uxY025701;
        Fri, 3 Sep 2021 07:00:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350uTE025700;
        Fri, 3 Sep 2021 07:00:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 08/14] phy: cadence: Sierra: Check PIPE mode PHY status to be ready for operation
Date:   Fri, 3 Sep 2021 07:00:48 +0200
Message-ID: <20210903050054.25627-9-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210903050054.25627-1-sjakhade@cadence.com>
References: <20210903050054.25627-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2fd2d77-d118-4052-9729-08d96e97d5c7
X-MS-TrafficTypeDiagnostic: BN8PR07MB6948:
X-Microsoft-Antispam-PRVS: <BN8PR07MB69481F77E09B90AE4E09D99AC5CF9@BN8PR07MB6948.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kVQMSz0jKuybkhl3KILb3RjZ5jTmuy74iADEnlpaedReIKd+iGUwb4IzaQO3ta29RBY3jKrxoHxWoUlYV9G9ppWWtBeTTKTypYRherQohLOmbQVe6VMVsG6TGgZvzEgv5VSnP9uug/fSH+X+vayfdnYrJbWSXAMDEU4br51RNwHTsESJ19G/8e9skJ7AfsPNCqOVc1fGtQc55cxe6ZCC23hMBLtQatjNnZ/o5O63fzQvyJVShkP7lFtNu/4WvWrk/Zw+1obtMFroamF/wC2f/e0wDQUo6kL3I8MXqTLg0UAKd+RFKLsw3gXKB6obVjHnfgB67ER2zYUz6oDLyBIYLbxyUxOBNf8Johvid4cFKQAxoMaQX0/wW2PfP0NLj2pPjpapmafE77pYFM3CLsrrKHiP6LMk5uGufYcNkwsvr/T7f7iIVmJ/hOAZ5XcgsxYHIN5+egQeZlKySLDDCWQyDRR1b/7+kl6D2PUnrQAEZH5/6e0h0NYJE45OMZzOgZ5Dr2C21TR9p9+IMSy1zsUmjIA8ttnzThxJKlrI55RyHNCA0297uOUgBQ8a+cH2iTdVmT5dVWgejVVnQkifyCsvDquHqoBGagGVUdiNXsz63/s2YdqH9XOJtByKFspQ8RgaHe+FGUX2F61E/0yvb1bcPx1ySP9f21k3lEi1628DLhjNcmOCUS/ReB8imPolNjTvdjXgc8AortOlOswc9LND9Ck2mH7FlDc+GDhJ8PjAiwI=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(26005)(70586007)(1076003)(70206006)(336012)(5660300002)(2616005)(426003)(186003)(6666004)(508600001)(8676002)(356005)(110136005)(42186006)(36906005)(316002)(83380400001)(54906003)(47076005)(86362001)(36756003)(36860700001)(7636003)(82310400003)(4326008)(2906002)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:01:05.4510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fd2d77-d118-4052-9729-08d96e97d5c7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT068.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR07MB6948
X-Proofpoint-GUID: pRNxbmCYHgG_BZwiQip2N9GzMgooZHLv
X-Proofpoint-ORIG-GUID: pRNxbmCYHgG_BZwiQip2N9GzMgooZHLv
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

