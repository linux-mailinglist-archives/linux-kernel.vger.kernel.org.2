Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9B03FF9CE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbhICFCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:02:42 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:1830 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233358AbhICFCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:20 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 182NR44d011814;
        Thu, 2 Sep 2021 22:01:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=tJtYKtNa3Fe2TI4Sez7Y34iukTiR0gj2KRltAejTDnY=;
 b=rDP0yAjvaJOmB/EUDr5C5n8A3zBY2b9+t4qArb1PcaoTrciKtJnlkU9bOo0SCVEXaPgw
 Mlrlfp9iC9+kYRKy2DlwGn3qz4U6Au/HMiqCTebSRDo+hLmf+WCGOpLiLKDjgVfyu8c2
 fQwjjX1xvKXrA7XSyCrBgLg8vWHSg8YvGDYBCUGFnV7ybnBnvV0EWJK2mB6Y7YwIOn9D
 CZKbC0xYmAfcq4cje3GvII03ZKuU+rLH5TRvYmbekjIW+kmOqK3y2tnnDxu9ZUPOWJKx
 YdTsoo9BJ+/Vz0ZvUxvpfQ3j/oYNeMVE8axy7VVDIaDJiPiRJ8D1sYrQnN/Le7DoR6EP Iw== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2042.outbound.protection.outlook.com [104.47.51.42])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3au8a18u3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2ph2aImpLHAXL7H1N2KSihFvQQ8z3QynAjC4gJ7jUVPWI/2fAoZXbD63xoK6R6HekQL6nEBqEscvvYkzqG7WXxgtBiyCbCFFTI8eUDV9xy61W8wQLqWlLirMFc0Creee4vf9+V5/8SkwV0O0DzqCZLt40x+OBmWHF91zf3CvyILglyHDepWNa/1XmgXYhpdn9ZymQ63cqCEs9doy4S8EAUlrq7xyAAbKD7eNdpJEBWBYTQfJBe35xI8mW7CtJm5MXi6SkUPOVzCTo5Fh1R0H17UJLwdlm/hIMLWpFI+2wBAF8H5tfcLNi9CFBu+HmrLAkon9BMm3wQLzNi8ULwK4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJtYKtNa3Fe2TI4Sez7Y34iukTiR0gj2KRltAejTDnY=;
 b=N1A8JK+W2Onw34pYtuiPiyAvP/bndh1bDLnYxqQhkYbG8+gMq5uvHVuUykZuUDBDkrULn+U3g9dDbYu1s/FwQta9H558lGSUc0CLfGA2L+tB0NKl4qIr3gdIpwLizz6tDE8kAztRm2by13HiPVTZQ/qGL3DlrwthHDp9MBpvyTI4sDEP4B3o4tDueu1YHOvZKbpKhlEg4wf/rFhPA9zItINSCpp7oRzqguoMMYSbK48uRL+HwPVRQLiAXmyZog7nvEDBW+enEdwidoAep92pHfQ2/zOnMMI8+D8UbNQUs7gkj+sBti6vL39/C8BoPTFtJAEN2K7un2iLzEDm8Yt3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJtYKtNa3Fe2TI4Sez7Y34iukTiR0gj2KRltAejTDnY=;
 b=cwIPZxIoForGSkJtAGR9XdYPtuaGIy4G0GlnvSB+k3VOl68kbtX6qxfMqFl3appTXkU7SEQ8Rv5aP9VyCTlNELDF0Z7NL4f7vfYDAwpej88LMuB8m8zg41kzcMNWf4N065nGDjnS+B7Z8Ow4SnKQ20cNKTrtE/v4+39g2Db87XU=
Received: from BN9P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::19)
 by BYAPR07MB6823.namprd07.prod.outlook.com (2603:10b6:a03:128::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 3 Sep
 2021 05:01:02 +0000
Received: from BN8NAM12FT033.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::64) by BN9P221CA0014.outlook.office365.com
 (2603:10b6:408:10a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend
 Transport; Fri, 3 Sep 2021 05:01:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT033.mail.protection.outlook.com (10.13.182.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:01:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ufX020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:01:00 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:56 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350uLL025697;
        Fri, 3 Sep 2021 07:00:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350uQv025696;
        Fri, 3 Sep 2021 07:00:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 07/14] phy: cadence: Sierra: Check cmn_ready assertion during PHY power on
Date:   Fri, 3 Sep 2021 07:00:47 +0200
Message-ID: <20210903050054.25627-8-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210903050054.25627-1-sjakhade@cadence.com>
References: <20210903050054.25627-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e72b6b78-6ac6-4761-ed63-08d96e97d37a
X-MS-TrafficTypeDiagnostic: BYAPR07MB6823:
X-Microsoft-Antispam-PRVS: <BYAPR07MB6823C99E7A6C699D9B17464BC5CF9@BYAPR07MB6823.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kgyuRY4VMTD7FT467Wn/PgGC/bOiGEnJWrPM93+/zAFgMMKFMlV1EbkH/ZULTKCaeBTkReKThlwSMtzX1w0heuaSctPYw4+2POXL1Edy+am1Pdb+d0k6rr7PJwXXy88dd+QB9JmXiikr9vYpcVRe6h5EQSSomQJun3oaM+plNHNiGd5tD7JGkxoCKkYrRrQYK2lUPE4uGjhgTnENCnX6nhaW/OBR05u5FDE44dAKRbzqBXU3zeiO0nNVtgqyBr+UbY8H6qXQnQStbq0SfvWLY5O2UP7ryym5+jEaTBS8cZiVtyXaYHqJOTUTANp/s/Dkc15KlBnqH5usmL6kJUOxdooc2g6q0YKpSxvpj5yBFMt1iO1C7oFt+LUkNT93YOiViwRj2JhZ3Etxc/2MOXUPVs6Exo0UjXSLZDpex8tvQpDxsiuysRU0isyvQQQXW6BQawnp2x0K2zTgbhTQz/aHPZ/uKuJmMGp20ur6hSyCh9nu0b7N984ZoZ9wS/ZRbal2Zn0j467XicGHkMZ0cjxN3/vsLgHkX+a5abud6PjWDF+0rA7zjkweLMIlBeBTxWZqpwBIkAz7DNbC2I7+TEALZeuzmDB18xKwGziCseiYjNg1v0QUPrqHRViW7UwsV4OxBN2MrTaVRSaJK9U56rE8FM2IvR3bUpjiLNWao2a5QOhk8ch27FM/7kXFM9Bd4yYV2QYtjL2pc0RtgZNxMghthc530gNYVT4xvuceuAr4dCE=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(36092001)(46966006)(36840700001)(478600001)(2616005)(36906005)(186003)(86362001)(82740400003)(42186006)(82310400003)(36756003)(110136005)(6666004)(1076003)(83380400001)(26005)(336012)(70206006)(426003)(7636003)(316002)(2906002)(36860700001)(5660300002)(54906003)(356005)(8676002)(8936002)(70586007)(47076005)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:01:01.5522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e72b6b78-6ac6-4761-ed63-08d96e97d37a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT033.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6823
X-Proofpoint-ORIG-GUID: Zdl6EB1fUYMoXAnatXhVW2gGu4ov3Ls-
X-Proofpoint-GUID: Zdl6EB1fUYMoXAnatXhVW2gGu4ov3Ls-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_01,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if PMA cmn_ready is set indicating the startup process is complete.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 45 ++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 4e27886e4b7f..e10ef4ecd6c7 100644
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

