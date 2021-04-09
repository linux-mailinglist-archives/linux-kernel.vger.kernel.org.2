Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FFE3594B0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbhDIFfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:35:25 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:15850 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233320AbhDIFfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:35:04 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395XZjV028235;
        Thu, 8 Apr 2021 22:34:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=Yi4BgR5ZdjdzqOYSTWM/bOmvJiTe+RaCZtrssR8paCo=;
 b=YdlcBTSg1ZlLOpCZSCz1qbV49b7OYg0qhg0NufSoopzB64w9sN1/od4v+cbFBvz1XVDt
 JyCKlornp4KYUPQ/8+RRCx6K4OdC3K2IIdQ//sXBmJ488G2p1fWujSp+yXafh9KFrN8s
 srdWhEufyzzZRN0BPSbBLlqg9K9hThIQne5bEf92svI4qfif9+8ShGim0OsbnQTYfU6X
 KLzWjkeoGYQJ6BMjgO7q1Klt7sLt+pxKOdY7uac/rXbMAA39ldvS/fgyQ+2vSL2PPS3p
 RqEpSupJqn7isIJpM2COa8Iwz5W4lLRdUlXcois7uaBC0gIunYtwv2y48QBeDFc1RuwN nQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37t6ns1sqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n0ALR1yUFVHkC9DEGQ+amz7PnbJIbsl9thO0CSJXw+AiBJwOfOgyEYEsmJqcALlv5cQz0bwves7u28lJBy44dju3wF+cRLBpwX/7Co5B+EM+mK/CeOKsyW8VhI8pnKd0o6ytv0Qb9vPzPyYl4scJfCN9uoXiZwgzUUSw/qsjUnragbbJCKMoj/bzJalDtCVA5bEWi6OU2Q4Fx1qjSAiT+3C7Ni4Cd7qDdiAVmVVRUL4kKvwLfhD42yZnnrpR509CjHOtesZYORtu/O8A65wtg43+DJoNNKSQLujR2MiZClM6pHdOvS+0bbr4Rn2hapnX+EOxIY/VUi0ybkb2ums3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi4BgR5ZdjdzqOYSTWM/bOmvJiTe+RaCZtrssR8paCo=;
 b=gsHnqdViiR46nyIw4E22PE+zzR9W1+BUkBDoK7waxTXytvycc1wz2U8JF3lDeVz9y0LbSn8yNZfgjuqyyj1VNyR4L+U2EI7ecltJQUm/2B9rIm0pjp75u07McSnh/5u5w7s+ITe/LxPLaHu0rFOVS0JnyB32nyPij6eBg2mWVdGWKsiwQsgjS0nfwnDEfK7OjYWPlwG2fRUDuo3v2ZJLSFJyT5pp3H/Kg9tWv9mgtYVFYvFsrAlKavAVeBisQE3YdfHEJ/otIgeGTS6/vrlIfG4UqI9pshxe+QOPUA6DflBMxJ6hKLQ34U39V5nr0VmzY9eK3qDRktVEqAobnzmjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi4BgR5ZdjdzqOYSTWM/bOmvJiTe+RaCZtrssR8paCo=;
 b=6v/M6Bpy/jJCwRA8eF4X0ly9oYiUG4JWy8kG01rEPBvYSnwqNbsnN9mfBiCsA7JO0tjQNvWWFGPJ/7gACD27T/2ftwYg8U1eX2YPeSYC8Y+sg/FR4Hp66JUV+NPjawZiP806LxxcSRZZOW4YZ9heyiOL1dYXd47Pb5mh0etVJ0M=
Received: from DM5PR21CA0018.namprd21.prod.outlook.com (2603:10b6:3:ac::28) by
 SJ0PR07MB7549.namprd07.prod.outlook.com (2603:10b6:a03:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 9 Apr
 2021 05:34:24 +0000
Received: from DM6NAM12FT018.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:ac:cafe::ab) by DM5PR21CA0018.outlook.office365.com
 (2603:10b6:3:ac::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.3 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 DM6NAM12FT018.mail.protection.outlook.com (10.13.179.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:24 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5U032749
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 22:34:23 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:34:18 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:34:18 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YI18027831;
        Fri, 9 Apr 2021 07:34:18 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YIx8027830;
        Fri, 9 Apr 2021 07:34:18 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 02/14] phy: cadence-torrent: Reorder few functions to remove function declarations
Date:   Fri, 9 Apr 2021 07:34:04 +0200
Message-ID: <1617946456-27773-3-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 175fbc30-0e72-41f3-e49a-08d8fb192258
X-MS-TrafficTypeDiagnostic: SJ0PR07MB7549:
X-Microsoft-Antispam-PRVS: <SJ0PR07MB75492D5378C264181D2FD2EEC5739@SJ0PR07MB7549.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7qpwAKh00rT/GiC8bZbHnjECfzy4o+6whe8zeOE0B8nZIOUvf6Ci9xzJnYeb8NadGMxY2zGBs7k0yPOoz/y/YqUxNiknDH7gDi998meqHgyuV3QpHZ96zRU6GmYYpqUk3EgCxIM3cKxhJrG3YRB7CFHf21UR+RAipO3vHautDvrEkEPyGsi4DoN67vTFGC+uE0xI/JSsKy/xYESTEFyRk9GVWDoeWOM/aWFOszffkTSEv0P+DhXuw4m/AJlT2vLEvBv4lvzEatXlCX8jmkp1yFaEBU/FQnquH/Mwnet7PF2lLmLJmwZQagCNPAHK2Z/qKIMCri8kgShdsM3ShDSvqRZ2+J8ONmusBSobvd8BBEfjJq19L/oA/baubB8aZ4DJYihv8KWhpC9FVZWP4F65ly+RxBWOupwe8QDkhkMch5h1vRSQnBZle0T5QcaoTtdoTZjemvpdVog2NXpeJCxgFOTB6j1m739RLwCnLAZwFAV5mPFnvCTClQFsccS2Szwgypf7vgPShvc589/UeWBpe5YIWK5a7ZtfaSb0M0TInQ1YPoAhMLR0Et88S4xykY7tf19KgerxF1Qh64iC4/7qXgzQFUi00DzM+5XOxXvW37Uv2THEPGezLVdpXfGOgmKFuM1Agt4HBPDmeS7XkhUJRBzDR3Q7R4vjbWwHPS3Ix45tNqVx6FXPaFl1VbxRHlRyWQ3jB0jGTFRApU/FaWD+qA==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(36092001)(46966006)(36840700001)(86362001)(2906002)(4326008)(42186006)(70206006)(7636003)(186003)(356005)(26005)(54906003)(82310400003)(82740400003)(8676002)(110136005)(2616005)(316002)(47076005)(8936002)(36860700001)(83380400001)(336012)(478600001)(6666004)(36906005)(426003)(36756003)(30864003)(5660300002)(70586007)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:24.0371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 175fbc30-0e72-41f3-e49a-08d8fb192258
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT018.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7549
X-Proofpoint-ORIG-GUID: _5jNAdtifxHGIhX1LXb8oZzXK9fyhGYQ
X-Proofpoint-GUID: _5jNAdtifxHGIhX1LXb8oZzXK9fyhGYQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder some functions to avoid function declarations.
No functional change.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 474 +++++++++++-----------
 1 file changed, 229 insertions(+), 245 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index ff647669f1a3..6eeb753fbb78 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -333,12 +333,6 @@ struct cdns_torrent_derived_refclk {
 #define to_cdns_torrent_derived_refclk(_hw)	\
 			container_of(_hw, struct cdns_torrent_derived_refclk, hw)
 
-static int cdns_torrent_phy_init(struct phy *phy);
-static int cdns_torrent_dp_init(struct phy *phy);
-static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
-			       u32 num_lanes);
-static
-int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy);
 static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
 				    struct cdns_torrent_inst *inst);
 static
@@ -353,36 +347,6 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
 					   u32 rate, bool ssc);
 static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 					 unsigned int lane);
-static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
-					 u32 rate, u32 num_lanes);
-static int cdns_torrent_dp_configure(struct phy *phy,
-				     union phy_configure_opts *opts);
-static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
-					   u32 num_lanes,
-					   enum phy_powerstate powerstate);
-static int cdns_torrent_phy_on(struct phy *phy);
-static int cdns_torrent_phy_off(struct phy *phy);
-
-static const struct phy_ops cdns_torrent_phy_ops = {
-	.init		= cdns_torrent_phy_init,
-	.configure	= cdns_torrent_dp_configure,
-	.power_on	= cdns_torrent_phy_on,
-	.power_off	= cdns_torrent_phy_off,
-	.owner		= THIS_MODULE,
-};
-
-static int cdns_torrent_noop_phy_on(struct phy *phy)
-{
-	/* Give 5ms to 10ms delay for the PIPE clock to be stable */
-	usleep_range(5000, 10000);
-
-	return 0;
-}
-
-static const struct phy_ops noop_ops = {
-	.power_on	= cdns_torrent_noop_phy_on,
-	.owner		= THIS_MODULE,
-};
 
 struct cdns_reg_pairs {
 	u32 val;
@@ -669,6 +633,164 @@ static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
 	return ret;
 }
 
+static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
+					   u32 num_lanes,
+					   enum phy_powerstate powerstate)
+{
+	/* Register value for power state for a single byte. */
+	u32 value_part;
+	u32 value;
+	u32 mask;
+	u32 read_val;
+	u32 ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+
+	switch (powerstate) {
+	case (POWERSTATE_A0):
+		value_part = 0x01U;
+		break;
+	case (POWERSTATE_A2):
+		value_part = 0x04U;
+		break;
+	default:
+		/* Powerstate A3 */
+		value_part = 0x08U;
+		break;
+	}
+
+	/* Select values of registers and mask, depending on enabled
+	 * lane count.
+	 */
+	switch (num_lanes) {
+	/* lane 0 */
+	case (1):
+		value = value_part;
+		mask = 0x0000003FU;
+		break;
+	/* lanes 0-1 */
+	case (2):
+		value = (value_part
+			 | (value_part << 8));
+		mask = 0x00003F3FU;
+		break;
+	/* lanes 0-3, all */
+	default:
+		value = (value_part
+			 | (value_part << 8)
+			 | (value_part << 16)
+			 | (value_part << 24));
+		mask = 0x3F3F3F3FU;
+		break;
+	}
+
+	/* Set power state A<n>. */
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, value);
+	/* Wait, until PHY acknowledges power state completion. */
+	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_POWER_STATE_ACK,
+				       read_val, (read_val & mask) == value, 0,
+				       POLL_TIMEOUT_US);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, 0x00000000);
+	ndelay(100);
+
+	return ret;
+}
+
+static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
+{
+	unsigned int read_val;
+	int ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+
+	/*
+	 * waiting for ACK of pma_xcvr_pllclk_en_ln_*, only for the
+	 * master lane
+	 */
+	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_PLLCLK_EN_ACK,
+				       read_val, read_val & 1,
+				       0, POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT) {
+		dev_err(cdns_phy->dev,
+			"timeout waiting for link PLL clock enable ack\n");
+		return ret;
+	}
+
+	ndelay(100);
+
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
+					      POWERSTATE_A2);
+	if (ret)
+		return ret;
+
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
+					      POWERSTATE_A0);
+
+	return ret;
+}
+
+static int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
+{
+	unsigned int reg;
+	int ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+
+	ret = regmap_read_poll_timeout(regmap, PHY_PMA_CMN_READY, reg,
+				       reg & 1, 0, POLL_TIMEOUT_US);
+	if (ret == -ETIMEDOUT) {
+		dev_err(cdns_phy->dev,
+			"timeout waiting for PMA common ready\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
+					 u32 rate, u32 num_lanes)
+{
+	unsigned int clk_sel_val = 0;
+	unsigned int hsclk_div_val = 0;
+	unsigned int i;
+
+	/* 16'h0000 for single DP link configuration */
+	regmap_field_write(cdns_phy->phy_pll_cfg, 0x0);
+
+	switch (rate) {
+	case 1620:
+		clk_sel_val = 0x0f01;
+		hsclk_div_val = 2;
+		break;
+	case 2160:
+	case 2430:
+	case 2700:
+		clk_sel_val = 0x0701;
+		hsclk_div_val = 1;
+		break;
+	case 3240:
+		clk_sel_val = 0x0b00;
+		hsclk_div_val = 2;
+		break;
+	case 4320:
+	case 5400:
+		clk_sel_val = 0x0301;
+		hsclk_div_val = 0;
+		break;
+	case 8100:
+		clk_sel_val = 0x0200;
+		hsclk_div_val = 0;
+		break;
+	}
+
+	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
+			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
+	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
+			       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
+
+	/* PMA lane configuration to deal with multi-link operation */
+	for (i = 0; i < num_lanes; i++)
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[i],
+				       XCVR_DIAG_HSCLK_DIV, hsclk_div_val);
+}
+
 /*
  * Perform register operations related to setting link rate, once powerstate is
  * set and PLL disable request was processed.
@@ -984,6 +1106,56 @@ static int cdns_torrent_dp_configure(struct phy *phy,
 	return ret;
 }
 
+static int cdns_torrent_phy_on(struct phy *phy)
+{
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	u32 read_val;
+	int ret;
+
+	if (cdns_phy->nsubnodes == 1) {
+		/* Take the PHY lane group out of reset */
+		reset_control_deassert(inst->lnk_rst);
+
+		/* Take the PHY out of reset */
+		ret = reset_control_deassert(cdns_phy->phy_rst);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Wait for cmn_ready assertion
+	 * PHY_PMA_CMN_CTRL1[0] == 1
+	 */
+	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_1,
+					     read_val, read_val, 1000,
+					     PLL_LOCK_TIMEOUT);
+	if (ret) {
+		dev_err(cdns_phy->dev, "Timeout waiting for CMN ready\n");
+		return ret;
+	}
+
+	mdelay(10);
+
+	return 0;
+}
+
+static int cdns_torrent_phy_off(struct phy *phy)
+{
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	int ret;
+
+	if (cdns_phy->nsubnodes != 1)
+		return 0;
+
+	ret = reset_control_assert(cdns_phy->phy_rst);
+	if (ret)
+		return ret;
+
+	return reset_control_assert(inst->lnk_rst);
+}
+
 static int cdns_torrent_dp_init(struct phy *phy)
 {
 	unsigned char lane_bits;
@@ -1051,24 +1223,6 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	return ret;
 }
 
-static
-int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
-{
-	unsigned int reg;
-	int ret;
-	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
-
-	ret = regmap_read_poll_timeout(regmap, PHY_PMA_CMN_READY, reg,
-				       reg & 1, 0, POLL_TIMEOUT_US);
-	if (ret == -ETIMEDOUT) {
-		dev_err(cdns_phy->dev,
-			"timeout waiting for PMA common ready\n");
-		return -ETIMEDOUT;
-	}
-
-	return 0;
-}
-
 static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
 				    struct cdns_torrent_inst *inst)
 {
@@ -1478,53 +1632,6 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
 	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
 }
 
-static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
-					 u32 rate, u32 num_lanes)
-{
-	unsigned int clk_sel_val = 0;
-	unsigned int hsclk_div_val = 0;
-	unsigned int i;
-
-	/* 16'h0000 for single DP link configuration */
-	regmap_field_write(cdns_phy->phy_pll_cfg, 0x0);
-
-	switch (rate) {
-	case 1620:
-		clk_sel_val = 0x0f01;
-		hsclk_div_val = 2;
-		break;
-	case 2160:
-	case 2430:
-	case 2700:
-		clk_sel_val = 0x0701;
-		hsclk_div_val = 1;
-		break;
-	case 3240:
-		clk_sel_val = 0x0b00;
-		hsclk_div_val = 2;
-		break;
-	case 4320:
-	case 5400:
-		clk_sel_val = 0x0301;
-		hsclk_div_val = 0;
-		break;
-	case 8100:
-		clk_sel_val = 0x0200;
-		hsclk_div_val = 0;
-		break;
-	}
-
-	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
-			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
-	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
-			       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
-
-	/* PMA lane configuration to deal with multi-link operation */
-	for (i = 0; i < num_lanes; i++)
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[i],
-				       XCVR_DIAG_HSCLK_DIV, hsclk_div_val);
-}
-
 static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 					 unsigned int lane)
 {
@@ -1568,100 +1675,6 @@ static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
 			       XCVR_DIAG_HSCLK_SEL, 0x0000);
 }
 
-static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
-					   u32 num_lanes,
-					   enum phy_powerstate powerstate)
-{
-	/* Register value for power state for a single byte. */
-	u32 value_part;
-	u32 value;
-	u32 mask;
-	u32 read_val;
-	u32 ret;
-	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
-
-	switch (powerstate) {
-	case (POWERSTATE_A0):
-		value_part = 0x01U;
-		break;
-	case (POWERSTATE_A2):
-		value_part = 0x04U;
-		break;
-	default:
-		/* Powerstate A3 */
-		value_part = 0x08U;
-		break;
-	}
-
-	/* Select values of registers and mask, depending on enabled
-	 * lane count.
-	 */
-	switch (num_lanes) {
-	/* lane 0 */
-	case (1):
-		value = value_part;
-		mask = 0x0000003FU;
-		break;
-	/* lanes 0-1 */
-	case (2):
-		value = (value_part
-			 | (value_part << 8));
-		mask = 0x00003F3FU;
-		break;
-	/* lanes 0-3, all */
-	default:
-		value = (value_part
-			 | (value_part << 8)
-			 | (value_part << 16)
-			 | (value_part << 24));
-		mask = 0x3F3F3F3FU;
-		break;
-	}
-
-	/* Set power state A<n>. */
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, value);
-	/* Wait, until PHY acknowledges power state completion. */
-	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_POWER_STATE_ACK,
-				       read_val, (read_val & mask) == value, 0,
-				       POLL_TIMEOUT_US);
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, 0x00000000);
-	ndelay(100);
-
-	return ret;
-}
-
-static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
-{
-	unsigned int read_val;
-	int ret;
-	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
-
-	/*
-	 * waiting for ACK of pma_xcvr_pllclk_en_ln_*, only for the
-	 * master lane
-	 */
-	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_PLLCLK_EN_ACK,
-				       read_val, read_val & 1,
-				       0, POLL_TIMEOUT_US);
-	if (ret == -ETIMEDOUT) {
-		dev_err(cdns_phy->dev,
-			"timeout waiting for link PLL clock enable ack\n");
-		return ret;
-	}
-
-	ndelay(100);
-
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
-					      POWERSTATE_A2);
-	if (ret)
-		return ret;
-
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
-					      POWERSTATE_A0);
-
-	return ret;
-}
-
 static int cdns_torrent_derived_refclk_enable(struct clk_hw *hw)
 {
 	struct cdns_torrent_derived_refclk *derived_refclk = to_cdns_torrent_derived_refclk(hw);
@@ -1764,56 +1777,6 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
 	return 0;
 }
 
-static int cdns_torrent_phy_on(struct phy *phy)
-{
-	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
-	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
-	u32 read_val;
-	int ret;
-
-	if (cdns_phy->nsubnodes == 1) {
-		/* Take the PHY lane group out of reset */
-		reset_control_deassert(inst->lnk_rst);
-
-		/* Take the PHY out of reset */
-		ret = reset_control_deassert(cdns_phy->phy_rst);
-		if (ret)
-			return ret;
-	}
-
-	/*
-	 * Wait for cmn_ready assertion
-	 * PHY_PMA_CMN_CTRL1[0] == 1
-	 */
-	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_1,
-					     read_val, read_val, 1000,
-					     PLL_LOCK_TIMEOUT);
-	if (ret) {
-		dev_err(cdns_phy->dev, "Timeout waiting for CMN ready\n");
-		return ret;
-	}
-
-	mdelay(10);
-
-	return 0;
-}
-
-static int cdns_torrent_phy_off(struct phy *phy)
-{
-	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
-	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
-	int ret;
-
-	if (cdns_phy->nsubnodes != 1)
-		return 0;
-
-	ret = reset_control_assert(cdns_phy->phy_rst);
-	if (ret)
-		return ret;
-
-	return reset_control_assert(inst->lnk_rst);
-}
-
 static struct regmap *cdns_regmap_init(struct device *dev, void __iomem *base,
 				       u32 block_offset,
 				       u8 reg_offset_shift,
@@ -2091,6 +2054,27 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	return 0;
 }
 
+static const struct phy_ops cdns_torrent_phy_ops = {
+	.init		= cdns_torrent_phy_init,
+	.configure	= cdns_torrent_dp_configure,
+	.power_on	= cdns_torrent_phy_on,
+	.power_off	= cdns_torrent_phy_off,
+	.owner		= THIS_MODULE,
+};
+
+static int cdns_torrent_noop_phy_on(struct phy *phy)
+{
+	/* Give 5ms to 10ms delay for the PIPE clock to be stable */
+	usleep_range(5000, 10000);
+
+	return 0;
+}
+
+static const struct phy_ops noop_ops = {
+	.power_on	= cdns_torrent_noop_phy_on,
+	.owner		= THIS_MODULE,
+};
+
 static
 int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 {
-- 
2.26.1

