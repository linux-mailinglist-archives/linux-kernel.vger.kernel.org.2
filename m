Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37163594B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbhDIFfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:35:48 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:21248 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233344AbhDIFfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:35:11 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395Pdrl030122;
        Thu, 8 Apr 2021 22:34:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=mL6G7Smts08DNYnPWZJwf4BT0Jxd/8tE8c3PFgAtYNA=;
 b=sPF+z31+Yn7FOs4zIatjfngvSNGrS9XkIioQaH6bWADJylKUhPIobt+iBdkFLWP9woz1
 xI+iVgyOOYZMbjuc/CESzZIMqS2c30f0BJZUHm+m/NV0aNnzURRCkK8Z0ZnSrqLbpOQ6
 f3YSuHhYM0nOhrDLwMiM6WqoCy4E50JSOub/+rYYTDe2UCK55RWmH/ok2NqAU078mQyb
 6CzETguzRRKzbkkCOS5DghkkPR1sSWxwleDyvH480bUp1fPzokgYJJ7JyLuCjUxvruYN
 FLpsYfaynpighRJdL25PT0aYBThptnJDwBjJer9AOX6Z2aPTi1qYKeq4ScnfjOkFvJSJ sQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37rvb4ttj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqJV0NM3VgAReU22wzJgo2WZAQXw+i6+xJD4bLpGcnN5RaDUc5Cnn2+3Bfna4eqKLwywD92DPWSP+y7TXOs2FLyuAc2KT2J8BKyok+EebzV98NM1yU7vEwlsFES4Le0/595L5m206VqTIa2JWN5qn0hTbY8tJH6zwinGel8/9cGCmR6ey9HVG9cRnH62IZfNwdr8dazOZAmllTL1Juw8Ax0SBfsZpaQ2ySa1iBA8tob1AKTUf4h5o88KGpHHsZmJa/plADAfKOllhwZ/KcmBvlk8BZ0LfphBUivf8cckbyb0KMsb2hekLX6SpjfaMO49ALPLy99y3VNVZCoZRcil/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL6G7Smts08DNYnPWZJwf4BT0Jxd/8tE8c3PFgAtYNA=;
 b=eN/IDQ7+hLvskOkHMQyeYsnrDJ3MPocYugIR/os6Z4xOF+M8sB1teXUDLNUB7icG8/WhjZx9RFng85ovyC5XelkPC3xJQV/z9GlbMtW3+I6QJTkpRNG/fCp28kwuby0QABLuNz5xLhCmK73/b/Y7JlLezK9XpbNd34aOYzpd0SRnxeAHct5T5k6WScD6hdDOrrC/5alPvONZ+9Gj8Oy0DNwtOOdhr+NbzMJS8UZPWypHoTh1u/71jjev/SANv/dTPyLwPHP0r3FXAOj96a4nFU8ePIXJjESP3TYYpGniUUBuSYBdOTrQFRruNeGwwnlvkJq0ZYNvMNtU1zCcY+8LAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mL6G7Smts08DNYnPWZJwf4BT0Jxd/8tE8c3PFgAtYNA=;
 b=16kwfVSME7L5BnKOfnIRtHWlbGxfcPvx1zwYQuj3kkxGKYEACP0WlUiBFl8blGGzqs6/kr3dNS5/aFrgOUw5+9kWaEpu/NS6NsVezP0fwt5nouQv0zUSQHTuHn+Nkw/3LJMY66a0y0sKaqNdFK/A4p2T4FEeU+0fXiQOSYOZTuQ=
Received: from DM5PR05CA0010.namprd05.prod.outlook.com (2603:10b6:3:d4::20) by
 BYAPR07MB6262.namprd07.prod.outlook.com (2603:10b6:a03:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 9 Apr
 2021 05:34:30 +0000
Received: from DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:d4:cafe::9e) by DM5PR05CA0010.outlook.office365.com
 (2603:10b6:3:d4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT050.mail.protection.outlook.com (10.13.178.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:30 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5f032749
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 22:34:29 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:34:20 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJVw027889;
        Fri, 9 Apr 2021 07:34:19 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YJvd027888;
        Fri, 9 Apr 2021 07:34:19 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 14/14] phy: cadence-torrent: Check PIPE mode PHY status to be ready for operation
Date:   Fri, 9 Apr 2021 07:34:16 +0200
Message-ID: <1617946456-27773-15-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21eecb2a-35d6-403c-4cf4-08d8fb19261f
X-MS-TrafficTypeDiagnostic: BYAPR07MB6262:
X-Microsoft-Antispam-PRVS: <BYAPR07MB6262C092313338E520F910ADC5739@BYAPR07MB6262.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: grgwd/4iLUwPo3jbipgboB8XPeG34Yt4rD5HuTYw1BnPYmPTXKm2mbgt7G9Gyd3yOrua/CU1yzQIpF5rLFTMvfoY1wcAaT0R1bLkWMNla3ay293eHH3uQiriQHUjHx3VcH541S0xDlHOF9MYnhKFvuPu/lxHbUebUcEV479QSQxoqxtgOEdIeu+HeKpUx6PeTesPusZZZszzyudm3VuW3BXOVKdPCz0TIoO5IflywI4oBI/5ngMcqJmPxb76nC0E9X59+1WFs5bMxfnRO/kirdmDr1jIWD3iL+jBd/chvwkUtq31a+oFsw+tvUOdSgcfOUUupqZRO1ClYQBdj/sE5+FWVH4vrwdDMKh0DDJHRWTPvZbpWs+ghCvirn4YJsLolxDsvEGieVkb1Lho32U2sps+nGRmGol5jLzhqQ81GbJMmGOiIHpcGJ7l59m5GExQifAJtZPUGCLJOd4jpi19Cik/+x5ufE9098eXKEav1LsNMSSRKPkIFH71fHwHeiaI1eNdAD1i99Z2ctYZI4+Ac+yTygPO93cggAqCNROZFe9Tu2IVWaB14lXSxvWi1GJhB4o3xxbHWMV+mSoi4W3TiOhY4Y25v/VnbCQWSRsHf47b5yX05Q2LIkWnc6yw9EM18RLMLOUnI23HKyafKmEgteWIs8uQAFXtaolzAeqv5C9eStIqQ5tRXMyp5F5FausjuRFbyHEkUq3p8FuvTAGoJg==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(36092001)(36840700001)(46966006)(36906005)(70586007)(6666004)(82740400003)(316002)(2616005)(42186006)(356005)(186003)(478600001)(7636003)(47076005)(26005)(8936002)(83380400001)(86362001)(5660300002)(82310400003)(36756003)(8676002)(336012)(110136005)(426003)(36860700001)(4326008)(70206006)(2906002)(54906003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:30.4275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21eecb2a-35d6-403c-4cf4-08d8fb19261f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6262
X-Proofpoint-ORIG-GUID: 5LuBGJLHQEvckAdRW72S-CYGPhGA9WDI
X-Proofpoint-GUID: 5LuBGJLHQEvckAdRW72S-CYGPhGA9WDI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104090040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PIPE PHY status is used to communicate the completion of several PHY
functions. Check if PHY is ready for operation while configured for
PIPE mode during startup.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 60 +++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 39145e56e061..42a1bdfd18d5 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -51,6 +51,10 @@
 #define TORRENT_PHY_PCS_COMMON_OFFSET(block_offset)	\
 				(0xC000 << (block_offset))
 
+#define TORRENT_PHY_PCS_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
+				((0xD000 << (block_offset)) +		\
+				(((ln) << 9) << (reg_offset)))
+
 #define TORRENT_PHY_PMA_COMMON_OFFSET(block_offset)	\
 				(0xE000 << (block_offset))
 
@@ -218,6 +222,9 @@
 #define PHY_PIPE_USB3_GEN2_POST_CFG0	0x0022U
 #define PHY_PIPE_USB3_GEN2_POST_CFG1	0x0023U
 
+/* PHY PCS lane registers */
+#define PHY_PCS_ISO_LINK_CTRL		0x000BU
+
 /* PHY PMA common registers */
 #define PHY_PMA_CMN_CTRL1		0x0000U
 #define PHY_PMA_CMN_CTRL2		0x0001U
@@ -242,6 +249,9 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
 static const struct reg_field phy_reset_ctrl =
 				REG_FIELD(PHY_RESET, 8, 8);
 
+static const struct reg_field phy_pcs_iso_link_ctrl_1 =
+				REG_FIELD(PHY_PCS_ISO_LINK_CTRL, 1, 1);
+
 static const struct reg_field phy_pipe_cmn_ctrl1_0 = REG_FIELD(PHY_PIPE_CMN_CTRL1, 0, 0);
 
 #define REFCLK_OUT_NUM_CMN_CONFIG	5
@@ -316,12 +326,14 @@ struct cdns_torrent_phy {
 	struct regmap *regmap_phy_pma_common_cdb;
 	struct regmap *regmap_tx_lane_cdb[MAX_NUM_LANES];
 	struct regmap *regmap_rx_lane_cdb[MAX_NUM_LANES];
+	struct regmap *regmap_phy_pcs_lane_cdb[MAX_NUM_LANES];
 	struct regmap *regmap_dptx_phy_reg;
 	struct regmap_field *phy_pll_cfg;
 	struct regmap_field *phy_pma_cmn_ctrl_1;
 	struct regmap_field *phy_pma_cmn_ctrl_2;
 	struct regmap_field *phy_pma_pll_raw_ctrl;
 	struct regmap_field *phy_reset_ctrl;
+	struct regmap_field *phy_pcs_iso_link_ctrl_1[MAX_NUM_LANES];
 	struct clk *clks[CDNS_TORRENT_REFCLK_DRIVER + 1];
 	struct clk_onecell_data clk_data;
 };
@@ -456,6 +468,22 @@ static const struct regmap_config cdns_torrent_common_cdb_config = {
 	.reg_read = cdns_regmap_read,
 };
 
+#define TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF(n) \
+{ \
+	.name = "torrent_phy_pcs_lane" n "_cdb", \
+	.reg_stride = 1, \
+	.fast_io = true, \
+	.reg_write = cdns_regmap_write, \
+	.reg_read = cdns_regmap_read, \
+}
+
+static const struct regmap_config cdns_torrent_phy_pcs_lane_cdb_config[] = {
+	TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF("0"),
+	TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF("1"),
+	TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF("2"),
+	TORRENT_PHY_PCS_LANE_CDB_REGMAP_CONF("3"),
+};
+
 static const struct regmap_config cdns_torrent_phy_pcs_cmn_cdb_config = {
 	.name = "torrent_phy_pcs_cmn_cdb",
 	.reg_stride = 1,
@@ -1546,6 +1574,16 @@ static int cdns_torrent_phy_on(struct phy *phy)
 		return ret;
 	}
 
+	if (inst->phy_type == TYPE_PCIE || inst->phy_type == TYPE_USB) {
+		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pcs_iso_link_ctrl_1[inst->mlane],
+						     read_val, !read_val, 1000,
+						     PLL_LOCK_TIMEOUT);
+		if (ret == -ETIMEDOUT) {
+			dev_err(cdns_phy->dev, "Timeout waiting for PHY status ready\n");
+			return ret;
+		}
+	}
+
 	mdelay(10);
 
 	return 0;
@@ -1822,6 +1860,7 @@ static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	struct device *dev = cdns_phy->dev;
 	struct regmap_field *field;
 	struct regmap *regmap;
+	int i;
 
 	regmap = cdns_phy->regmap_phy_pcs_common_cdb;
 	field = devm_regmap_field_alloc(dev, regmap, phy_pll_cfg);
@@ -1855,6 +1894,16 @@ static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	}
 	cdns_phy->phy_pma_pll_raw_ctrl = field;
 
+	for (i = 0; i < MAX_NUM_LANES; i++) {
+		regmap = cdns_phy->regmap_phy_pcs_lane_cdb[i];
+		field = devm_regmap_field_alloc(dev, regmap, phy_pcs_iso_link_ctrl_1);
+		if (IS_ERR(field)) {
+			dev_err(dev, "PHY_PCS_ISO_LINK_CTRL reg field init for ln %d failed\n", i);
+			return PTR_ERR(field);
+		}
+		cdns_phy->phy_pcs_iso_link_ctrl_1[i] = field;
+	}
+
 	return 0;
 }
 
@@ -1915,6 +1964,17 @@ static int cdns_torrent_regmap_init(struct cdns_torrent_phy *cdns_phy)
 			return PTR_ERR(regmap);
 		}
 		cdns_phy->regmap_rx_lane_cdb[i] = regmap;
+
+		block_offset = TORRENT_PHY_PCS_LANE_CDB_OFFSET(i, block_offset_shift,
+							       reg_offset_shift);
+		regmap = cdns_regmap_init(dev, sd_base, block_offset,
+					  reg_offset_shift,
+					  &cdns_torrent_phy_pcs_lane_cdb_config[i]);
+		if (IS_ERR(regmap)) {
+			dev_err(dev, "Failed to init PHY PCS lane CDB regmap\n");
+			return PTR_ERR(regmap);
+		}
+		cdns_phy->regmap_phy_pcs_lane_cdb[i] = regmap;
 	}
 
 	block_offset = TORRENT_COMMON_CDB_OFFSET;
-- 
2.26.1

