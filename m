Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961F63B0960
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhFVPnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:43:16 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:19916 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232394AbhFVPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:42:40 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MFWO67031493;
        Tue, 22 Jun 2021 08:40:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=rhlTvfevjQreEKcaaqCOKcwm+p5QqqK8zHxgI6UjiKI=;
 b=FRCr+nlnaAuEdKK4Sop11SKXrjlp9fc66kDmn8Vws/Exxohb1dNgQz3b2eNYKEkoeS8Z
 T6EWGMW+KuPyEvOP2k/p6Kd0SAZL/J6g0ndz/DV/2M5BoV3vooeao2z9qFLlaE4ut6Ji
 aJLnqGMtIjuYUCHGUYFNGlk5UxhbeG9EF8mm7ulL1XZyL0hCrnwK58FSQ2qA1WGQCWpg
 E2C5lKwy6hPebaAWC/18LVz7JdlHWv62X9CEZ1oJge/4RYLmwzsaaF2jTrXhlx90hPeO
 oR3AvRhZuNxbypb43o109I9REMO9Xk1jBgdGWDEHyTroun59brIRR6JZFzFngaZGTgZ6 Lg== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by mx0a-0014ca01.pphosted.com with ESMTP id 39apms59u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 08:40:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxVJ7IYbYrOIQ8MvEPmicTJfq3R2CWWZUHXveMhrQ28r36kZX7DI/mu5J1N5nb03hV/41ksWdhQ4Iy7jmhw8QySsHKmVlqRHtL0G4ymKO8CuaddniC8xAeTV/1WPFJmuPgHJck68+kC5dRDLLge1+lYaVA4G1pFMyUAievNyCMw24iS/OVOkshuihQcnlbDZQ0yg81qMhjOZIJGJOM8+A38P5+BEdN3mbQsmyf41FJF7zlk6Jika5uBPxZDuYzhSz8pYldKXNTTm/fR0/YpmiVPkAKrBtzJueJYFNawgxankMzjpCuYFNv19xgPSQOonKztE/hPnOLshGtccnXVsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhlTvfevjQreEKcaaqCOKcwm+p5QqqK8zHxgI6UjiKI=;
 b=V/T7zLJfVEBp9iG3RX3A/BC5e7QnkF5Gbr6BZta8mMxUYt+eUg+q0uHjb4XXJWsIjn/MHhQtx4c/KcJjd1MvZSzBMbiK3kS9Z/lW4Rr67BcP06g9/rq+FBNCgYB4E5m+Ky9N0ZQX4vrmIZBVRYjIeASgBSgCNy5xjRF7FLuM/CHH5eNjtFnsXawH7kyIch0GCMoFETRgdMnz5WQsKj0QPbub86midfPokQdBBDz0BEevwGohVRhHoHw6ewtLXj0ICFnFxcikzRpiSkj2Pixdp/fqAMcAvu5X7AZ+AWgAe09uqnfuIUeX4kgmVWRvDjIMoV/bH/GSqk5xlpixoABPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhlTvfevjQreEKcaaqCOKcwm+p5QqqK8zHxgI6UjiKI=;
 b=zIr+sBabjZqNRBZ3ID6xJ6RY81ECb00JW643d5FflJytE/mrUiHUhNMmLasN/kHZxGZMNBYrGVncRvFd6/MFl55rGWsyZNGRHlbqVf1WHu/MCTfzkjqx/PlSuuHUEONWSfpf1fAQ3g08njQZxjYvJ7EcyQc8sbpSNYXfJTxmJnw=
Received: from MWHPR22CA0069.namprd22.prod.outlook.com (2603:10b6:300:12a::31)
 by DM6PR07MB6299.namprd07.prod.outlook.com (2603:10b6:5:153::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 15:40:00 +0000
Received: from MW2NAM12FT066.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::78) by MWHPR22CA0069.outlook.office365.com
 (2603:10b6:300:12a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Tue, 22 Jun 2021 15:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT066.mail.protection.outlook.com (10.13.181.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.10 via Frontend Transport; Tue, 22 Jun 2021 15:39:59 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 15MFdpjK219509
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
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 15MFdpBq002334;
        Tue, 22 Jun 2021 17:39:51 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 15MFdpCI002333;
        Tue, 22 Jun 2021 17:39:51 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v2 9/9] phy: cadence-torrent: Check PIPE mode PHY status to be ready for operation
Date:   Tue, 22 Jun 2021 17:39:49 +0200
Message-ID: <20210622153949.2215-10-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210622153949.2215-1-sjakhade@cadence.com>
References: <20210622153949.2215-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4409e5e1-225b-4a1c-dc0f-08d93593fe72
X-MS-TrafficTypeDiagnostic: DM6PR07MB6299:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6299B6B513F0D5538466A087C5099@DM6PR07MB6299.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5zG+5hWlXyqkRZqAZiFH50jUE05VnRxK14RMTkgOdDgO6i45AQlMtPodVMXdUogpD6vEs/KLZiCpCmAtxTb8qR13jdWtK/uJrqvUnWw2EDfTyJ3FWlS1RwAafUOBl8CYvVQk7CYwG8/5QLX51jhH8HDgGlPy2I1dyZzIOEg/hMPPTYdMIn7RC3SucsTRNsEBpHVMeQlP0uJN1DBgJen+C2TgPPQS111aONpZ1G5AqmZsh+KQAIYF2YqXGLAFXzPuFVKfuSu0iwpHbXZLh53gk0TZGuNzOlKroOjUBm9F7Fzhvo5QEHyBwqyvkEHXyMtyhQlsS5YPCVAQ6xOF+5CVhL/dxMEMr+ap/xi6k9z+/RFzQ5HxluoJGCuGuiBbTq6sQkZO3q8boSLGhKJ+oRxZHjYVj5OSBcyqx45Gb9olWmV2HPVSSuUTluWzwAv8jd2COmozbSDquSPOFmG5SLxbYMdIwj/o0MpOMgP/DcwuoeY4MMP83271MId2i2jDp9XK1wEskY6P18wlbFmAGwnjaLht09QcBqo7iB/gYtdjvF8I7lCYV9V51jKVZ7Y7aEUCCYyZznPJvDLME2VyHdcftS9VwQ4PA5a35lndlXK9IQflwYsT7J/wL8gyz9rAAoPrZmawhQd3zM88dl2cNztYU2YOI821hJv+r6MMwvvXYXX6jzdm3UFxwhItGXBGFa7xNp/sVo7ZH5haUlTxz/vYgYRhUj3NSzgJhW/LB5sl5JI=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(36092001)(36840700001)(46966006)(82740400003)(4326008)(5660300002)(316002)(42186006)(26005)(8676002)(110136005)(36756003)(82310400003)(54906003)(36860700001)(8936002)(83380400001)(356005)(1076003)(81166007)(47076005)(2906002)(336012)(478600001)(186003)(2616005)(70206006)(86362001)(70586007)(426003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 15:39:59.4511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4409e5e1-225b-4a1c-dc0f-08d93593fe72
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT066.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6299
X-Proofpoint-ORIG-GUID: 3UNKeuygTuNAhD2KJWHFyQRN1FueP13_
X-Proofpoint-GUID: 3UNKeuygTuNAhD2KJWHFyQRN1FueP13_
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

PIPE PHY status is used to communicate the completion of several PHY
functions. Check if PHY is ready for operation while configured for
PIPE mode during startup.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 60 ++++++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 4024db052cf9..070a1b320d5c 100644
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
 
@@ -223,6 +227,9 @@
 #define PHY_PIPE_USB3_GEN2_POST_CFG0	0x0022U
 #define PHY_PIPE_USB3_GEN2_POST_CFG1	0x0023U
 
+/* PHY PCS lane registers */
+#define PHY_PCS_ISO_LINK_CTRL		0x000BU
+
 /* PHY PMA common registers */
 #define PHY_PMA_CMN_CTRL1		0x0000U
 #define PHY_PMA_CMN_CTRL2		0x0001U
@@ -247,6 +254,9 @@ static const struct reg_field phy_pma_pll_raw_ctrl =
 static const struct reg_field phy_reset_ctrl =
 				REG_FIELD(PHY_RESET, 8, 8);
 
+static const struct reg_field phy_pcs_iso_link_ctrl_1 =
+				REG_FIELD(PHY_PCS_ISO_LINK_CTRL, 1, 1);
+
 static const struct reg_field phy_pipe_cmn_ctrl1_0 = REG_FIELD(PHY_PIPE_CMN_CTRL1, 0, 0);
 
 #define REFCLK_OUT_NUM_CMN_CONFIG	5
@@ -315,12 +325,14 @@ struct cdns_torrent_phy {
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
@@ -455,6 +467,22 @@ static const struct regmap_config cdns_torrent_common_cdb_config = {
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
@@ -1469,7 +1497,15 @@ static int cdns_torrent_phy_on(struct phy *phy)
 		return ret;
 	}
 
-	mdelay(10);
+	if (inst->phy_type == TYPE_PCIE || inst->phy_type == TYPE_USB) {
+		ret = regmap_field_read_poll_timeout(cdns_phy->phy_pcs_iso_link_ctrl_1[inst->mlane],
+						     read_val, !read_val, 1000,
+						     PLL_LOCK_TIMEOUT);
+		if (ret == -ETIMEDOUT) {
+			dev_err(cdns_phy->dev, "Timeout waiting for PHY status ready\n");
+			return ret;
+		}
+	}
 
 	return 0;
 }
@@ -1719,6 +1755,7 @@ static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
 	struct device *dev = cdns_phy->dev;
 	struct regmap_field *field;
 	struct regmap *regmap;
+	int i;
 
 	regmap = cdns_phy->regmap_phy_pcs_common_cdb;
 	field = devm_regmap_field_alloc(dev, regmap, phy_pll_cfg);
@@ -1752,6 +1789,16 @@ static int cdns_torrent_regfield_init(struct cdns_torrent_phy *cdns_phy)
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
 
@@ -1812,6 +1859,17 @@ static int cdns_torrent_regmap_init(struct cdns_torrent_phy *cdns_phy)
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

