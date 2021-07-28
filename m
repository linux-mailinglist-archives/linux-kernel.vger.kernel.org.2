Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A8E3D9166
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbhG1O4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:56:08 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:13482 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237412AbhG1Ozc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:55:32 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SEqw9R023163;
        Wed, 28 Jul 2021 07:55:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=gyy1H4+KJAE2iMZG59gvHIUOH1t9y+RhAYRoy01slZg=;
 b=Ow9cvjQuvWp3g0iVdvP0KNgCHVMciN7Nbnime5r4uvnxFLu2avvzka4mwoFRx71Aq1/2
 MfxRGid8KJaFtCqZCw/KdwYPMWq4uMuVY5Wzn5rlC5aGFYLetHlaucCwlWKiPNQkppgd
 FAgettTKI0kjzqau+KVXDhc/0lTw0W+b/9vEjrJV90pTKcBpx1gsVLSrafN/QwGvJRh4
 pcxotRYRvrZnwQXPmSVNr14Lg7V525lCG08yqUHV+rx9LQdKIf/1E19bPqEgJ60HjQJk
 TgIPZR5RSD4RqbTVj4bvfYFxy+WDO2sO3cBQpRscAEBCp1gUha87GJUZ+/c2lAYEGP8t mQ== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3a235vfvks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 07:55:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0QZHy+nRlrWAL4JCvDDtSemleRhjV7oR+ehzXfeCAFELkEPawFLT2MdhLuS+BrHPGOp933VGjiwbhVT5YcaHJ+TBMiJSntN+LeWgY+Tv0tyT3Ps+pBWYhRaCS7mLPLcNb2vpKCgmSGtPACf1TjVXKX0oPa2IvtL1/8oFBGf1PsC8wq1oyr13XofczojjvHimtPEil/e3RUrxxRPEDuslnN6dLclCVnHj+v2+jPsAyiDSF0vY50630wkDw1/KMwvoEUbBSSc4JHK+QE1+6Pa3VHrxaIien5yfu6+Vx30aCo1Ak8K2iCHb4SqdtpJGit88tnRIaPnurvxspIaBVafAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyy1H4+KJAE2iMZG59gvHIUOH1t9y+RhAYRoy01slZg=;
 b=Qo/v5j9VYgJ4owYUTBuLDdSI9P3TmBZ/UnytS6YNgo0oCMQb4qXdejCcaMl2mMUzTJuGeiLm1WW9O9HpGXUn4DitOe3IqmJbfSixrVa4xjW5niydaYruaZggjhrN88YeYD0XV5RsYUwTISt+AIen5/CKgSLH6hvMtnD4EdoYQ4i7ur4WPuo4qUyJrRkbR6k6cUgeFkjPqCG6KUV7sK/3C2CAhypQ6LoewVZbFARt9tbjsXC5AqVe71YJZbN5Sw9Ry4TCTyaUGBirXglkzdVqdPHhlqr4qCmH5uMCv4k11QRuPwXk1LL0ztqCo8VGh6RvofcXMV9XiZqMaEfI8e6oUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyy1H4+KJAE2iMZG59gvHIUOH1t9y+RhAYRoy01slZg=;
 b=cEr48Lk+c+2ZsoKBkyNqyXom79l7v7STVJBmqHIvdVMRecL6zRMiHXWeJB+6BDh9LiPAmmR5dKDNHTPXg/ij6JMSda5+CbPKVxJ3NAjh32JHDRRXjcOaAs12/0CdkZykaOmCvI9E3z9ldcnvOJS0/mKt4w32n9MVJI9L4R3OQIY=
Received: from BN1PR14CA0030.namprd14.prod.outlook.com (2603:10b6:408:e3::35)
 by DM6PR07MB7340.namprd07.prod.outlook.com (2603:10b6:5:21d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 14:55:02 +0000
Received: from BN8NAM12FT028.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::51) by BN1PR14CA0030.outlook.office365.com
 (2603:10b6:408:e3::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Wed, 28 Jul 2021 14:55:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT028.mail.protection.outlook.com (10.13.183.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.7 via Frontend Transport; Wed, 28 Jul 2021 14:55:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 16SEsvrq095664
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 07:54:59 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 16:54:56 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 28 Jul 2021 16:54:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 16SEsuVZ016528;
        Wed, 28 Jul 2021 16:54:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 16SEsuET016521;
        Wed, 28 Jul 2021 16:54:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v3 2/9] phy: cadence-torrent: Reorder few functions to remove function declarations
Date:   Wed, 28 Jul 2021 16:54:47 +0200
Message-ID: <20210728145454.15945-3-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210728145454.15945-1-sjakhade@cadence.com>
References: <20210728145454.15945-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abac393d-b431-4a4a-9b97-08d951d7ad16
X-MS-TrafficTypeDiagnostic: DM6PR07MB7340:
X-Microsoft-Antispam-PRVS: <DM6PR07MB7340B5A2ECC714C216A2B3A2C5EA9@DM6PR07MB7340.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnOYnR7UZESQHPxB7kfwj4zRNfXxz+u4K8sVbNy7qziobZDus4pP3kdujZMN6NykOf/rQqSJMaiUuZ86stvPL9RGOoADiGQ715SuFC2zRDwNo2xBZ/ehSXvoaPYLmWtvgxU6+Kh+p2Gsu+4L3unAgKz1mNnJB5eBbm3qUPW+ebbX+H5D6D2IR3RJrx62eJWAW9n5306AClkoFLQqYINzF2B3m7ZrzXwxGMF069RwhzX//8uHXmvkN2qoyXKe7f9yhob3xB7GbHeiP0TWAoJai7xiAgUJt5P/iBZRrTsUY+0YUOgWSW2Qha5umgUHMS9ELBFGJbtHcyhmrP6gvhKx4kCa2YxSGJcGRG/pOrwysmI0+GkPVExq2sMONIYDygLSPKERYl80KJUQSQ5AzTNESbsUJBG7mDJVSmhH4oPNwlDeJXjvZG5bdsCw5FdlhHSh7hOjwKWC6+I4vvFgV3Wi4HIqTwtBeu/Z4P8/P/j/k8+fdzBSZXYCqIO/05IIa3Rsp1MohdDmJ6vaWN/kCO51KdJF+/aL4Hzvgm42lvIOqqsl7AjKCHD4qVwpiILS8lOJSRGw2PHszHqL3kNpZIZzs/I9M5uCMOiGfiNkiDpOlo9AA5DW67J02qN3JVMLy2hcSOZb2OQydG7HglLgEicp3F+Z41PbPojq1wKjxHv5cljZTQGr/XIxQ5ESUAWV5iJacAIpOMz1XWrFXKzs+RXXw861Om82JT5qqVVF1ksGLZR12+PhXytFSzHxCthAHeQwSl5D638bV7KjaSLZG1FbhC5vDadA+DkCihY724Cu2zk=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(6666004)(316002)(70586007)(8936002)(36860700001)(86362001)(356005)(42186006)(26005)(30864003)(36756003)(70206006)(83380400001)(2906002)(110136005)(426003)(508600001)(47076005)(1076003)(5660300002)(82310400003)(186003)(336012)(81166007)(4326008)(54906003)(8676002)(2616005)(36900700001)(2101003)(579004)(559001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 14:55:01.1515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abac393d-b431-4a4a-9b97-08d951d7ad16
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT028.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7340
X-Proofpoint-ORIG-GUID: VytzxLetc9FWc9vAzE-brwp1lUt4ov9s
X-Proofpoint-GUID: VytzxLetc9FWc9vAzE-brwp1lUt4ov9s
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_08:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0 mlxlogscore=999
 spamscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107280083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder some functions to avoid function declarations.
No functional change.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 1937 ++++++++++-----------
 1 file changed, 953 insertions(+), 984 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index ff647669f1a3..4b2d6d3eace9 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -333,57 +333,6 @@ struct cdns_torrent_derived_refclk {
 #define to_cdns_torrent_derived_refclk(_hw)	\
 			container_of(_hw, struct cdns_torrent_derived_refclk, hw)
 
-static int cdns_torrent_phy_init(struct phy *phy);
-static int cdns_torrent_dp_init(struct phy *phy);
-static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy,
-			       u32 num_lanes);
-static
-int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy);
-static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
-				    struct cdns_torrent_inst *inst);
-static
-void cdns_torrent_dp_pma_cmn_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy);
-static
-void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
-					     u32 rate, bool ssc);
-static
-void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy);
-static
-void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
-					   u32 rate, bool ssc);
-static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
-					 unsigned int lane);
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
-
 struct cdns_reg_pairs {
 	u32 val;
 	u32 off;
@@ -615,444 +564,607 @@ static const struct coefficients vltg_coeff[4][4] = {
 	}
 };
 
-/*
- * Enable or disable PLL for selected lanes.
- */
-static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
-				      struct phy_configure_opts_dp *dp,
-				      bool enable)
+static
+void cdns_torrent_dp_pma_cmn_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy)
 {
-	u32 rd_val;
-	u32 ret;
-	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
-
-	/*
-	 * Used to determine, which bits to check for or enable in
-	 * PHY_PMA_XCVR_PLLCLK_EN register.
-	 */
-	u32 pll_bits;
-	/* Used to enable or disable lanes. */
-	u32 pll_val;
-
-	/* Select values of registers and mask, depending on enabled lane
-	 * count.
-	 */
-	switch (dp->lanes) {
-	/* lane 0 */
-	case (1):
-		pll_bits = 0x00000001;
-		break;
-	/* lanes 0-1 */
-	case (2):
-		pll_bits = 0x00000003;
-		break;
-	/* lanes 0-3, all */
-	default:
-		pll_bits = 0x0000000F;
-		break;
-	}
-
-	if (enable)
-		pll_val = pll_bits;
-	else
-		pll_val = 0x00000000;
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
 
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, pll_val);
+	/* refclock registers - assumes 19.2 MHz refclock */
+	cdns_torrent_phy_write(regmap, CMN_SSM_BIAS_TMR, 0x0014);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLPRE_TMR, 0x0027);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLLOCK_TMR, 0x00A1);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLPRE_TMR, 0x0027);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLLOCK_TMR, 0x00A1);
+	cdns_torrent_phy_write(regmap, CMN_BGCAL_INIT_TMR, 0x0060);
+	cdns_torrent_phy_write(regmap, CMN_BGCAL_ITER_TMR, 0x0060);
+	cdns_torrent_phy_write(regmap, CMN_IBCAL_INIT_TMR, 0x0014);
+	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_INIT_TMR, 0x0018);
+	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_ITER_TMR, 0x0005);
+	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_INIT_TMR, 0x0018);
+	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_ITER_TMR, 0x0005);
+	cdns_torrent_phy_write(regmap, CMN_RXCAL_INIT_TMR, 0x0240);
+	cdns_torrent_phy_write(regmap, CMN_RXCAL_ITER_TMR, 0x0005);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_INIT_TMR, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_ITER_TMR, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_REFTIM_START, 0x000B);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_PLLCNT_START, 0x0137);
 
-	/* Wait for acknowledgment from PHY. */
-	ret = regmap_read_poll_timeout(regmap,
-				       PHY_PMA_XCVR_PLLCLK_EN_ACK,
-				       rd_val,
-				       (rd_val & pll_bits) == pll_val,
-				       0, POLL_TIMEOUT_US);
-	ndelay(100);
-	return ret;
+	/* PLL registers */
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_INIT_TMR, 0x00C0);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_INIT_TMR, 0x00C0);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_REFTIM_START, 0x0260);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_REFTIM_START, 0x0260);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
 }
 
 /*
- * Perform register operations related to setting link rate, once powerstate is
- * set and PLL disable request was processed.
+ * Set registers responsible for enabling and configuring SSC, with second and
+ * third register values provided by parameters.
  */
-static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
-					  struct phy_configure_opts_dp *dp)
+static
+void cdns_torrent_dp_enable_ssc_19_2mhz(struct cdns_torrent_phy *cdns_phy,
+					u32 ctrl2_val, u32 ctrl3_val)
 {
-	u32 ret;
-	u32 read_val;
-
-	/* Disable the cmn_pll0_en before re-programming the new data rate. */
-	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x0);
-
-	/*
-	 * Wait for PLL ready de-assertion.
-	 * For PLL0 - PHY_PMA_CMN_CTRL2[2] == 1
-	 */
-	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
-					     read_val,
-					     ((read_val >> 2) & 0x01) != 0,
-					     0, POLL_TIMEOUT_US);
-	if (ret)
-		return ret;
-	ndelay(200);
-
-	/* DP Rate Change - VCO Output settings. */
-	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ) {
-		/* PMA common configuration 19.2MHz */
-		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate,
-							dp->ssc);
-		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
-	} else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ) {
-		/* PMA common configuration 25MHz */
-		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate,
-						      dp->ssc);
-		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
-	}
-	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
-
-	/* Enable the cmn_pll0_en. */
-	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x3);
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
 
-	/*
-	 * Wait for PLL ready assertion.
-	 * For PLL0 - PHY_PMA_CMN_CTRL2[0] == 1
-	 */
-	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
-					     read_val,
-					     (read_val & 0x01) != 0,
-					     0, POLL_TIMEOUT_US);
-	return ret;
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl3_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl3_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0003);
 }
 
-/*
- * Verify, that parameters to configure PHY with are correct.
- */
-static int cdns_torrent_dp_verify_config(struct cdns_torrent_inst *inst,
-					 struct phy_configure_opts_dp *dp)
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
+					     u32 rate, bool ssc)
 {
-	u8 i;
-
-	/* If changing link rate was required, verify it's supported. */
-	if (dp->set_rate) {
-		switch (dp->link_rate) {
-		case 1620:
-		case 2160:
-		case 2430:
-		case 2700:
-		case 3240:
-		case 4320:
-		case 5400:
-		case 8100:
-			/* valid bit rate */
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
 
-	/* Verify lane count. */
-	switch (dp->lanes) {
-	case 1:
-	case 2:
-	case 4:
-		/* valid lane count. */
+	/* Assumes 19.2 MHz refclock */
+	switch (rate) {
+	/* Setting VCO for 10.8GHz */
+	case 2700:
+	case 5400:
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_INTDIV_M0, 0x0119);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_FRACDIVL_M0, 0x4000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_HIGH_THR_M0, 0x00BC);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PDIAG_PLL0_CTRL_M0, 0x0012);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_INTDIV_M0, 0x0119);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_FRACDIVL_M0, 0x4000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_HIGH_THR_M0, 0x00BC);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PDIAG_PLL1_CTRL_M0, 0x0012);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x033A,
+							   0x006A);
 		break;
-	default:
-		return -EINVAL;
-	}
-
-	/* Check against actual number of PHY's lanes. */
-	if (dp->lanes > inst->num_lanes)
-		return -EINVAL;
-
-	/*
-	 * If changing voltages is required, check swing and pre-emphasis
-	 * levels, per-lane.
-	 */
-	if (dp->set_voltages) {
-		/* Lane count verified previously. */
-		for (i = 0; i < dp->lanes; i++) {
-			if (dp->voltage[i] > 3 || dp->pre[i] > 3)
-				return -EINVAL;
+	/* Setting VCO for 9.72GHz */
+	case 1620:
+	case 2430:
+	case 3240:
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_INTDIV_M0, 0x01FA);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_FRACDIVL_M0, 0x4000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_HIGH_THR_M0, 0x0152);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_INTDIV_M0, 0x01FA);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_FRACDIVL_M0, 0x4000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_HIGH_THR_M0, 0x0152);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x05DD,
+							   0x0069);
+		break;
+	/* Setting VCO for 8.64GHz */
+	case 2160:
+	case 4320:
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_INTDIV_M0, 0x01C2);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_HIGH_THR_M0, 0x012C);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_INTDIV_M0, 0x01C2);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_HIGH_THR_M0, 0x012C);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x0536,
+							   0x0069);
+		break;
+	/* Setting VCO for 8.1GHz */
+	case 8100:
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_INTDIV_M0, 0x01A5);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_FRACDIVL_M0, 0xE000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_HIGH_THR_M0, 0x011A);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_INTDIV_M0, 0x01A5);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_FRACDIVL_M0, 0xE000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_HIGH_THR_M0, 0x011A);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x04D7,
+							   0x006A);
+		break;
+	}
 
-			/* Sum of voltage swing and pre-emphasis levels cannot
-			 * exceed 3.
-			 */
-			if (dp->voltage[i] + dp->pre[i] > 3)
-				return -EINVAL;
-		}
+	if (ssc) {
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x025E);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x025E);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
+	} else {
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0260);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0260);
+		/* Set reset register values to disable SSC */
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
 	}
 
-	return 0;
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_REFCNT_START, 0x0099);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x0099);
 }
 
-/* Set power state A0 and PLL clock enable to 0 on enabled lanes. */
-static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
-				       u32 num_lanes)
+static
+void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
 {
-	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
-	u32 pwr_state = cdns_torrent_dp_read(regmap,
-					     PHY_PMA_XCVR_POWER_STATE_REQ);
-	u32 pll_clk_en = cdns_torrent_dp_read(regmap,
-					      PHY_PMA_XCVR_PLLCLK_EN);
-
-	/* Lane 0 is always enabled. */
-	pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
-		       PHY_POWER_STATE_LN_0);
-	pll_clk_en &= ~0x01U;
-
-	if (num_lanes > 1) {
-		/* lane 1 */
-		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
-			       PHY_POWER_STATE_LN_1);
-		pll_clk_en &= ~(0x01U << 1);
-	}
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
 
-	if (num_lanes > 2) {
-		/* lanes 2 and 3 */
-		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
-			       PHY_POWER_STATE_LN_2);
-		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
-			       PHY_POWER_STATE_LN_3);
-		pll_clk_en &= ~(0x01U << 2);
-		pll_clk_en &= ~(0x01U << 3);
-	}
+	/* refclock registers - assumes 25 MHz refclock */
+	cdns_torrent_phy_write(regmap, CMN_SSM_BIAS_TMR, 0x0019);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLPRE_TMR, 0x0032);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLLOCK_TMR, 0x00D1);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLPRE_TMR, 0x0032);
+	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLLOCK_TMR, 0x00D1);
+	cdns_torrent_phy_write(regmap, CMN_BGCAL_INIT_TMR, 0x007D);
+	cdns_torrent_phy_write(regmap, CMN_BGCAL_ITER_TMR, 0x007D);
+	cdns_torrent_phy_write(regmap, CMN_IBCAL_INIT_TMR, 0x0019);
+	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_INIT_TMR, 0x001E);
+	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_INIT_TMR, 0x001E);
+	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(regmap, CMN_RXCAL_INIT_TMR, 0x02EE);
+	cdns_torrent_phy_write(regmap, CMN_RXCAL_ITER_TMR, 0x0006);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_INIT_TMR, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_ITER_TMR, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_REFTIM_START, 0x000E);
+	cdns_torrent_phy_write(regmap, CMN_SD_CAL_PLLCNT_START, 0x012B);
 
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, pwr_state);
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, pll_clk_en);
+	/* PLL registers */
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_INIT_TMR, 0x00FA);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_INIT_TMR, 0x00FA);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_REFTIM_START, 0x0317);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_REFTIM_START, 0x0317);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
 }
 
-/* Configure lane count as required. */
-static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
-				     struct phy_configure_opts_dp *dp)
+/*
+ * Set registers responsible for enabling and configuring SSC, with second
+ * register value provided by a parameter.
+ */
+static void cdns_torrent_dp_enable_ssc_25mhz(struct cdns_torrent_phy *cdns_phy,
+					     u32 ctrl2_val)
 {
-	u32 value;
-	u32 ret;
-	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
-	u8 lane_mask = (1 << dp->lanes) - 1;
-
-	value = cdns_torrent_dp_read(regmap, PHY_RESET);
-	/* clear pma_tx_elec_idle_ln_* bits. */
-	value &= ~PMA_TX_ELEC_IDLE_MASK;
-	/* Assert pma_tx_elec_idle_ln_* for disabled lanes. */
-	value |= ((~lane_mask) << PMA_TX_ELEC_IDLE_SHIFT) &
-		 PMA_TX_ELEC_IDLE_MASK;
-	cdns_torrent_dp_write(regmap, PHY_RESET, value);
-
-	/* reset the link by asserting phy_l00_reset_n low */
-	cdns_torrent_dp_write(regmap, PHY_RESET,
-			      value & (~PHY_L00_RESET_N_MASK));
-
-	/*
-	 * Assert lane reset on unused lanes and lane 0 so they remain in reset
-	 * and powered down when re-enabling the link
-	 */
-	value = (value & 0x0000FFF0) | (0x0000000E & lane_mask);
-	cdns_torrent_dp_write(regmap, PHY_RESET, value);
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
 
-	cdns_torrent_dp_set_a0_pll(cdns_phy, dp->lanes);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x007F);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0003);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x007F);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0003);
+}
 
-	/* release phy_l0*_reset_n based on used laneCount */
-	value = (value & 0x0000FFF0) | (0x0000000F & lane_mask);
-	cdns_torrent_dp_write(regmap, PHY_RESET, value);
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
+					   u32 rate, bool ssc)
+{
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
 
-	/* Wait, until PHY gets ready after releasing PHY reset signal. */
-	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
-	if (ret)
-		return ret;
-
-	ndelay(100);
+	/* Assumes 25 MHz refclock */
+	switch (rate) {
+	/* Setting VCO for 10.8GHz */
+	case 2700:
+	case 5400:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x01B0);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0120);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x01B0);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0120);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x0423);
+		break;
+	/* Setting VCO for 9.72GHz */
+	case 1620:
+	case 2430:
+	case 3240:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0184);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0xCCCD);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0104);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0184);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0xCCCD);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0104);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x03B9);
+		break;
+	/* Setting VCO for 8.64GHz */
+	case 2160:
+	case 4320:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0159);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x999A);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00E7);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0159);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x999A);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00E7);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x034F);
+		break;
+	/* Setting VCO for 8.1GHz */
+	case 8100:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0144);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00D8);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0144);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00D8);
+		if (ssc)
+			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x031A);
+		break;
+	}
 
-	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
 
-	ret = cdns_torrent_dp_run(cdns_phy, dp->lanes);
+	if (ssc) {
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0315);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0315);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
+	} else {
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0317);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0317);
+		/* Set reset register values to disable SSC */
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL2_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL3_M0, 0x0000);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0000);
+		cdns_torrent_phy_write(regmap,
+				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
+	}
 
-	return ret;
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_REFCNT_START, 0x00C7);
+	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
 }
 
-/* Configure link rate as required. */
-static int cdns_torrent_dp_set_rate(struct cdns_torrent_phy *cdns_phy,
-				    struct phy_configure_opts_dp *dp)
+static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
+					 unsigned int lane)
 {
-	u32 ret;
+	/* Per lane, refclock-dependent receiver detection setting */
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_RCVDET_ST_TMR, 0x0780);
+	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_RCVDET_ST_TMR, 0x09C4);
 
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
-					      POWERSTATE_A3);
-	if (ret)
-		return ret;
-	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, false);
-	if (ret)
-		return ret;
-	ndelay(200);
+	/* Writing Tx/Rx Power State Controllers registers */
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       TX_PSC_A0, 0x00FB);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       TX_PSC_A2, 0x04AA);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       TX_PSC_A3, 0x04AA);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_PSC_A0, 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_PSC_A2, 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_PSC_A3, 0x0000);
 
-	ret = cdns_torrent_dp_configure_rate(cdns_phy, dp);
-	if (ret)
-		return ret;
-	ndelay(200);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_PSC_CAL, 0x0000);
 
-	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, true);
-	if (ret)
-		return ret;
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
-					      POWERSTATE_A2);
-	if (ret)
-		return ret;
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
-					      POWERSTATE_A0);
-	if (ret)
-		return ret;
-	ndelay(900);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_REE_GCSM1_CTRL, 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_REE_GCSM2_CTRL, 0x0000);
+	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
+			       RX_REE_PERGCSM_CTRL, 0x0000);
 
-	return ret;
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       XCVR_DIAG_BIDI_CTRL, 0x000F);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       XCVR_DIAG_PLLDRC_CTRL, 0x0001);
+	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+			       XCVR_DIAG_HSCLK_SEL, 0x0000);
 }
 
-/* Configure voltage swing and pre-emphasis for all enabled lanes. */
-static void cdns_torrent_dp_set_voltages(struct cdns_torrent_phy *cdns_phy,
-					 struct phy_configure_opts_dp *dp)
+static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
+				    struct cdns_torrent_inst *inst)
 {
-	u8 lane;
-	u16 val;
-
-	for (lane = 0; lane < dp->lanes; lane++) {
-		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
-					    TX_DIAG_ACYA);
-		/*
-		 * Write 1 to register bit TX_DIAG_ACYA[0] to freeze the
-		 * current state of the analog TX driver.
-		 */
-		val |= TX_DIAG_ACYA_HBDC_MASK;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-				       TX_DIAG_ACYA, val);
+	unsigned int i;
 
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-				       TX_TXCC_CTRL, 0x08A4);
-		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].diag_tx_drv;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-				       DRV_DIAG_TX_DRV, val);
-		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].mgnfs_mult;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-				       TX_TXCC_MGNFS_MULT_000,
-				       val);
-		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].cpost_mult;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-				       TX_TXCC_CPOST_MULT_00,
-				       val);
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
+		/* PMA common configuration 19.2MHz */
+		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
+	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
+		/* PMA common configuration 25MHz */
+		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
 
-		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
-					    TX_DIAG_ACYA);
-		/*
-		 * Write 0 to register bit TX_DIAG_ACYA[0] to allow the state of
-		 * analog TX driver to reflect the new programmed one.
-		 */
-		val &= ~TX_DIAG_ACYA_HBDC_MASK;
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-				       TX_DIAG_ACYA, val);
-	}
-};
+	/* PMA lane configuration to deal with multi-link operation */
+	for (i = 0; i < inst->num_lanes; i++)
+		cdns_torrent_dp_pma_lane_cfg(cdns_phy, i);
+}
 
-static int cdns_torrent_dp_configure(struct phy *phy,
-				     union phy_configure_opts *opts)
+/*
+ * Enable or disable PLL for selected lanes.
+ */
+static int cdns_torrent_dp_set_pll_en(struct cdns_torrent_phy *cdns_phy,
+				      struct phy_configure_opts_dp *dp,
+				      bool enable)
 {
-	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
-	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
-	int ret;
-
-	ret = cdns_torrent_dp_verify_config(inst, &opts->dp);
-	if (ret) {
-		dev_err(&phy->dev, "invalid params for phy configure\n");
-		return ret;
-	}
+	u32 rd_val;
+	u32 ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
-	if (opts->dp.set_lanes) {
-		ret = cdns_torrent_dp_set_lanes(cdns_phy, &opts->dp);
-		if (ret) {
-			dev_err(&phy->dev, "cdns_torrent_dp_set_lanes failed\n");
-			return ret;
-		}
-	}
+	/*
+	 * Used to determine, which bits to check for or enable in
+	 * PHY_PMA_XCVR_PLLCLK_EN register.
+	 */
+	u32 pll_bits;
+	/* Used to enable or disable lanes. */
+	u32 pll_val;
 
-	if (opts->dp.set_rate) {
-		ret = cdns_torrent_dp_set_rate(cdns_phy, &opts->dp);
-		if (ret) {
-			dev_err(&phy->dev, "cdns_torrent_dp_set_rate failed\n");
-			return ret;
-		}
+	/* Select values of registers and mask, depending on enabled lane
+	 * count.
+	 */
+	switch (dp->lanes) {
+	/* lane 0 */
+	case (1):
+		pll_bits = 0x00000001;
+		break;
+	/* lanes 0-1 */
+	case (2):
+		pll_bits = 0x00000003;
+		break;
+	/* lanes 0-3, all */
+	default:
+		pll_bits = 0x0000000F;
+		break;
 	}
 
-	if (opts->dp.set_voltages)
-		cdns_torrent_dp_set_voltages(cdns_phy, &opts->dp);
+	if (enable)
+		pll_val = pll_bits;
+	else
+		pll_val = 0x00000000;
+
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, pll_val);
 
+	/* Wait for acknowledgment from PHY. */
+	ret = regmap_read_poll_timeout(regmap,
+				       PHY_PMA_XCVR_PLLCLK_EN_ACK,
+				       rd_val,
+				       (rd_val & pll_bits) == pll_val,
+				       0, POLL_TIMEOUT_US);
+	ndelay(100);
 	return ret;
 }
 
-static int cdns_torrent_dp_init(struct phy *phy)
+static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
+					   u32 num_lanes,
+					   enum phy_powerstate powerstate)
 {
-	unsigned char lane_bits;
-	int ret;
-	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
-	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	/* Register value for power state for a single byte. */
+	u32 value_part;
+	u32 value;
+	u32 mask;
+	u32 read_val;
+	u32 ret;
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
-	switch (cdns_phy->ref_clk_rate) {
-	case REF_CLK_19_2MHZ:
-	case REF_CLK_25MHZ:
-		/* Valid Ref Clock Rate */
+	switch (powerstate) {
+	case (POWERSTATE_A0):
+		value_part = 0x01U;
+		break;
+	case (POWERSTATE_A2):
+		value_part = 0x04U;
 		break;
 	default:
-		dev_err(cdns_phy->dev, "Unsupported Ref Clock Rate\n");
-		return -EINVAL;
+		/* Powerstate A3 */
+		value_part = 0x08U;
+		break;
 	}
 
-	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
-
-	/* PHY PMA registers configuration function */
-	cdns_torrent_dp_pma_cfg(cdns_phy, inst);
-
-	/*
-	 * Set lines power state to A0
-	 * Set lines pll clk enable to 0
+	/* Select values of registers and mask, depending on enabled
+	 * lane count.
 	 */
-	cdns_torrent_dp_set_a0_pll(cdns_phy, inst->num_lanes);
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
 
-	/*
-	 * release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
-	 * used lanes
-	 */
-	lane_bits = (1 << inst->num_lanes) - 1;
-	cdns_torrent_dp_write(regmap, PHY_RESET,
-			      ((0xF & ~lane_bits) << 4) | (0xF & lane_bits));
+	/* Set power state A<n>. */
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, value);
+	/* Wait, until PHY acknowledges power state completion. */
+	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_POWER_STATE_ACK,
+				       read_val, (read_val & mask) == value, 0,
+				       POLL_TIMEOUT_US);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, 0x00000000);
+	ndelay(100);
 
-	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+	return ret;
+}
 
-	/* PHY PMA registers configuration functions */
-	/* Initialize PHY with max supported link rate, without SSC. */
-	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
-		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy,
-							cdns_phy->max_bit_rate,
-							false);
-	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
-		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy,
-						      cdns_phy->max_bit_rate,
-						      false);
-	cdns_torrent_dp_pma_cmn_rate(cdns_phy, cdns_phy->max_bit_rate,
-				     inst->num_lanes);
+static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
+{
+	unsigned int read_val;
+	int ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
-	/* take out of reset */
-	regmap_field_write(cdns_phy->phy_reset_ctrl, 0x1);
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
 
-	cdns_torrent_phy_on(phy);
+	ndelay(100);
 
-	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
+					      POWERSTATE_A2);
 	if (ret)
 		return ret;
 
-	ret = cdns_torrent_dp_run(cdns_phy, inst->num_lanes);
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
+					      POWERSTATE_A0);
 
 	return ret;
 }
 
-static
-int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
+static int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 {
 	unsigned int reg;
 	int ret;
@@ -1069,595 +1181,481 @@ int cdns_torrent_dp_wait_pma_cmn_ready(struct cdns_torrent_phy *cdns_phy)
 	return 0;
 }
 
-static void cdns_torrent_dp_pma_cfg(struct cdns_torrent_phy *cdns_phy,
-				    struct cdns_torrent_inst *inst)
+static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
+					 u32 rate, u32 num_lanes)
 {
+	unsigned int clk_sel_val = 0;
+	unsigned int hsclk_div_val = 0;
 	unsigned int i;
 
-	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
-		/* PMA common configuration 19.2MHz */
-		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
-	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
-		/* PMA common configuration 25MHz */
-		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
-
-	/* PMA lane configuration to deal with multi-link operation */
-	for (i = 0; i < inst->num_lanes; i++)
-		cdns_torrent_dp_pma_lane_cfg(cdns_phy, i);
-}
+	/* 16'h0000 for single DP link configuration */
+	regmap_field_write(cdns_phy->phy_pll_cfg, 0x0);
 
-static
-void cdns_torrent_dp_pma_cmn_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy)
-{
-	struct regmap *regmap = cdns_phy->regmap_common_cdb;
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
 
-	/* refclock registers - assumes 19.2 MHz refclock */
-	cdns_torrent_phy_write(regmap, CMN_SSM_BIAS_TMR, 0x0014);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLPRE_TMR, 0x0027);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLLOCK_TMR, 0x00A1);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLPRE_TMR, 0x0027);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLLOCK_TMR, 0x00A1);
-	cdns_torrent_phy_write(regmap, CMN_BGCAL_INIT_TMR, 0x0060);
-	cdns_torrent_phy_write(regmap, CMN_BGCAL_ITER_TMR, 0x0060);
-	cdns_torrent_phy_write(regmap, CMN_IBCAL_INIT_TMR, 0x0014);
-	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_INIT_TMR, 0x0018);
-	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_ITER_TMR, 0x0005);
-	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_INIT_TMR, 0x0018);
-	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_ITER_TMR, 0x0005);
-	cdns_torrent_phy_write(regmap, CMN_RXCAL_INIT_TMR, 0x0240);
-	cdns_torrent_phy_write(regmap, CMN_RXCAL_ITER_TMR, 0x0005);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_INIT_TMR, 0x0002);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_ITER_TMR, 0x0002);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_REFTIM_START, 0x000B);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_PLLCNT_START, 0x0137);
+	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
+			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
+	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
+			       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
 
-	/* PLL registers */
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_INIT_TMR, 0x00C0);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_INIT_TMR, 0x00C0);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_REFTIM_START, 0x0260);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_REFTIM_START, 0x0260);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
+	/* PMA lane configuration to deal with multi-link operation */
+	for (i = 0; i < num_lanes; i++)
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[i],
+				       XCVR_DIAG_HSCLK_DIV, hsclk_div_val);
 }
 
 /*
- * Set registers responsible for enabling and configuring SSC, with second and
- * third register values provided by parameters.
+ * Perform register operations related to setting link rate, once powerstate is
+ * set and PLL disable request was processed.
  */
-static
-void cdns_torrent_dp_enable_ssc_19_2mhz(struct cdns_torrent_phy *cdns_phy,
-					u32 ctrl2_val, u32 ctrl3_val)
-{
-	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
+					  struct phy_configure_opts_dp *dp)
+{
+	u32 ret;
+	u32 read_val;
 
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl3_val);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0003);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl3_val);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0003);
+	/* Disable the cmn_pll0_en before re-programming the new data rate. */
+	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x0);
+
+	/*
+	 * Wait for PLL ready de-assertion.
+	 * For PLL0 - PHY_PMA_CMN_CTRL2[2] == 1
+	 */
+	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+					     read_val,
+					     ((read_val >> 2) & 0x01) != 0,
+					     0, POLL_TIMEOUT_US);
+	if (ret)
+		return ret;
+	ndelay(200);
+
+	/* DP Rate Change - VCO Output settings. */
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ) {
+		/* PMA common configuration 19.2MHz */
+		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy, dp->link_rate,
+							dp->ssc);
+		cdns_torrent_dp_pma_cmn_cfg_19_2mhz(cdns_phy);
+	} else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ) {
+		/* PMA common configuration 25MHz */
+		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate,
+						      dp->ssc);
+		cdns_torrent_dp_pma_cmn_cfg_25mhz(cdns_phy);
+	}
+	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
+
+	/* Enable the cmn_pll0_en. */
+	regmap_field_write(cdns_phy->phy_pma_pll_raw_ctrl, 0x3);
+
+	/*
+	 * Wait for PLL ready assertion.
+	 * For PLL0 - PHY_PMA_CMN_CTRL2[0] == 1
+	 */
+	ret = regmap_field_read_poll_timeout(cdns_phy->phy_pma_cmn_ctrl_2,
+					     read_val,
+					     (read_val & 0x01) != 0,
+					     0, POLL_TIMEOUT_US);
+	return ret;
 }
 
-static
-void cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(struct cdns_torrent_phy *cdns_phy,
-					     u32 rate, bool ssc)
+/*
+ * Verify, that parameters to configure PHY with are correct.
+ */
+static int cdns_torrent_dp_verify_config(struct cdns_torrent_inst *inst,
+					 struct phy_configure_opts_dp *dp)
 {
-	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+	u8 i;
 
-	/* Assumes 19.2 MHz refclock */
-	switch (rate) {
-	/* Setting VCO for 10.8GHz */
-	case 2700:
-	case 5400:
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_INTDIV_M0, 0x0119);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_HIGH_THR_M0, 0x00BC);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL0_CTRL_M0, 0x0012);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_INTDIV_M0, 0x0119);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_HIGH_THR_M0, 0x00BC);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL1_CTRL_M0, 0x0012);
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x033A,
-							   0x006A);
-		break;
-	/* Setting VCO for 9.72GHz */
-	case 1620:
-	case 2430:
-	case 3240:
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_INTDIV_M0, 0x01FA);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_HIGH_THR_M0, 0x0152);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_INTDIV_M0, 0x01FA);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVL_M0, 0x4000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_HIGH_THR_M0, 0x0152);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x05DD,
-							   0x0069);
-		break;
-	/* Setting VCO for 8.64GHz */
-	case 2160:
-	case 4320:
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_INTDIV_M0, 0x01C2);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_HIGH_THR_M0, 0x012C);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_INTDIV_M0, 0x01C2);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_HIGH_THR_M0, 0x012C);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x0536,
-							   0x0069);
-		break;
-	/* Setting VCO for 8.1GHz */
-	case 8100:
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_INTDIV_M0, 0x01A5);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVL_M0, 0xE000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_HIGH_THR_M0, 0x011A);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_INTDIV_M0, 0x01A5);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVL_M0, 0xE000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_HIGH_THR_M0, 0x011A);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_19_2mhz(cdns_phy, 0x04D7,
-							   0x006A);
+	/* If changing link rate was required, verify it's supported. */
+	if (dp->set_rate) {
+		switch (dp->link_rate) {
+		case 1620:
+		case 2160:
+		case 2430:
+		case 2700:
+		case 3240:
+		case 4320:
+		case 5400:
+		case 8100:
+			/* valid bit rate */
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	/* Verify lane count. */
+	switch (dp->lanes) {
+	case 1:
+	case 2:
+	case 4:
+		/* valid lane count. */
 		break;
+	default:
+		return -EINVAL;
 	}
 
-	if (ssc) {
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x025E);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x025E);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
-	} else {
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0260);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0260);
-		/* Set reset register values to disable SSC */
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
+	/* Check against actual number of PHY's lanes. */
+	if (dp->lanes > inst->num_lanes)
+		return -EINVAL;
+
+	/*
+	 * If changing voltages is required, check swing and pre-emphasis
+	 * levels, per-lane.
+	 */
+	if (dp->set_voltages) {
+		/* Lane count verified previously. */
+		for (i = 0; i < dp->lanes; i++) {
+			if (dp->voltage[i] > 3 || dp->pre[i] > 3)
+				return -EINVAL;
+
+			/* Sum of voltage swing and pre-emphasis levels cannot
+			 * exceed 3.
+			 */
+			if (dp->voltage[i] + dp->pre[i] > 3)
+				return -EINVAL;
+		}
 	}
 
-	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x0099);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_START, 0x0099);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_REFCNT_START, 0x0099);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x0099);
+	return 0;
 }
 
-static
-void cdns_torrent_dp_pma_cmn_cfg_25mhz(struct cdns_torrent_phy *cdns_phy)
+/* Set power state A0 and PLL clock enable to 0 on enabled lanes. */
+static void cdns_torrent_dp_set_a0_pll(struct cdns_torrent_phy *cdns_phy,
+				       u32 num_lanes)
 {
-	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+	u32 pwr_state = cdns_torrent_dp_read(regmap,
+					     PHY_PMA_XCVR_POWER_STATE_REQ);
+	u32 pll_clk_en = cdns_torrent_dp_read(regmap,
+					      PHY_PMA_XCVR_PLLCLK_EN);
 
-	/* refclock registers - assumes 25 MHz refclock */
-	cdns_torrent_phy_write(regmap, CMN_SSM_BIAS_TMR, 0x0019);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLPRE_TMR, 0x0032);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM0_PLLLOCK_TMR, 0x00D1);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLPRE_TMR, 0x0032);
-	cdns_torrent_phy_write(regmap, CMN_PLLSM1_PLLLOCK_TMR, 0x00D1);
-	cdns_torrent_phy_write(regmap, CMN_BGCAL_INIT_TMR, 0x007D);
-	cdns_torrent_phy_write(regmap, CMN_BGCAL_ITER_TMR, 0x007D);
-	cdns_torrent_phy_write(regmap, CMN_IBCAL_INIT_TMR, 0x0019);
-	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_INIT_TMR, 0x001E);
-	cdns_torrent_phy_write(regmap, CMN_TXPUCAL_ITER_TMR, 0x0006);
-	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_INIT_TMR, 0x001E);
-	cdns_torrent_phy_write(regmap, CMN_TXPDCAL_ITER_TMR, 0x0006);
-	cdns_torrent_phy_write(regmap, CMN_RXCAL_INIT_TMR, 0x02EE);
-	cdns_torrent_phy_write(regmap, CMN_RXCAL_ITER_TMR, 0x0006);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_INIT_TMR, 0x0002);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_ITER_TMR, 0x0002);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_REFTIM_START, 0x000E);
-	cdns_torrent_phy_write(regmap, CMN_SD_CAL_PLLCNT_START, 0x012B);
+	/* Lane 0 is always enabled. */
+	pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
+		       PHY_POWER_STATE_LN_0);
+	pll_clk_en &= ~0x01U;
+
+	if (num_lanes > 1) {
+		/* lane 1 */
+		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
+			       PHY_POWER_STATE_LN_1);
+		pll_clk_en &= ~(0x01U << 1);
+	}
+
+	if (num_lanes > 2) {
+		/* lanes 2 and 3 */
+		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
+			       PHY_POWER_STATE_LN_2);
+		pwr_state &= ~(PMA_XCVR_POWER_STATE_REQ_LN_MASK <<
+			       PHY_POWER_STATE_LN_3);
+		pll_clk_en &= ~(0x01U << 2);
+		pll_clk_en &= ~(0x01U << 3);
+	}
+
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, pwr_state);
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, pll_clk_en);
+}
+
+/* Configure lane count as required. */
+static int cdns_torrent_dp_set_lanes(struct cdns_torrent_phy *cdns_phy,
+				     struct phy_configure_opts_dp *dp)
+{
+	u32 value;
+	u32 ret;
+	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+	u8 lane_mask = (1 << dp->lanes) - 1;
+
+	value = cdns_torrent_dp_read(regmap, PHY_RESET);
+	/* clear pma_tx_elec_idle_ln_* bits. */
+	value &= ~PMA_TX_ELEC_IDLE_MASK;
+	/* Assert pma_tx_elec_idle_ln_* for disabled lanes. */
+	value |= ((~lane_mask) << PMA_TX_ELEC_IDLE_SHIFT) &
+		 PMA_TX_ELEC_IDLE_MASK;
+	cdns_torrent_dp_write(regmap, PHY_RESET, value);
+
+	/* reset the link by asserting phy_l00_reset_n low */
+	cdns_torrent_dp_write(regmap, PHY_RESET,
+			      value & (~PHY_L00_RESET_N_MASK));
+
+	/*
+	 * Assert lane reset on unused lanes and lane 0 so they remain in reset
+	 * and powered down when re-enabling the link
+	 */
+	value = (value & 0x0000FFF0) | (0x0000000E & lane_mask);
+	cdns_torrent_dp_write(regmap, PHY_RESET, value);
+
+	cdns_torrent_dp_set_a0_pll(cdns_phy, dp->lanes);
+
+	/* release phy_l0*_reset_n based on used laneCount */
+	value = (value & 0x0000FFF0) | (0x0000000F & lane_mask);
+	cdns_torrent_dp_write(regmap, PHY_RESET, value);
+
+	/* Wait, until PHY gets ready after releasing PHY reset signal. */
+	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
+	if (ret)
+		return ret;
+
+	ndelay(100);
+
+	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
+
+	ret = cdns_torrent_dp_run(cdns_phy, dp->lanes);
+
+	return ret;
+}
+
+/* Configure link rate as required. */
+static int cdns_torrent_dp_set_rate(struct cdns_torrent_phy *cdns_phy,
+				    struct phy_configure_opts_dp *dp)
+{
+	u32 ret;
+
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+					      POWERSTATE_A3);
+	if (ret)
+		return ret;
+	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, false);
+	if (ret)
+		return ret;
+	ndelay(200);
+
+	ret = cdns_torrent_dp_configure_rate(cdns_phy, dp);
+	if (ret)
+		return ret;
+	ndelay(200);
 
-	/* PLL registers */
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_INIT_TMR, 0x00FA);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_INIT_TMR, 0x00FA);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_ITER_TMR, 0x0004);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_REFTIM_START, 0x0317);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_VCOCAL_TCTRL, 0x0003);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_REFTIM_START, 0x0317);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_VCOCAL_TCTRL, 0x0003);
+	ret = cdns_torrent_dp_set_pll_en(cdns_phy, dp, true);
+	if (ret)
+		return ret;
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+					      POWERSTATE_A2);
+	if (ret)
+		return ret;
+	ret = cdns_torrent_dp_set_power_state(cdns_phy, dp->lanes,
+					      POWERSTATE_A0);
+	if (ret)
+		return ret;
+	ndelay(900);
+
+	return ret;
 }
 
-/*
- * Set registers responsible for enabling and configuring SSC, with second
- * register value provided by a parameter.
- */
-static void cdns_torrent_dp_enable_ssc_25mhz(struct cdns_torrent_phy *cdns_phy,
-					     u32 ctrl2_val)
+/* Configure voltage swing and pre-emphasis for all enabled lanes. */
+static void cdns_torrent_dp_set_voltages(struct cdns_torrent_phy *cdns_phy,
+					 struct phy_configure_opts_dp *dp)
 {
-	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+	u8 lane;
+	u16 val;
 
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x007F);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0003);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0001);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, ctrl2_val);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x007F);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0003);
-}
+	for (lane = 0; lane < dp->lanes; lane++) {
+		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
+					    TX_DIAG_ACYA);
+		/*
+		 * Write 1 to register bit TX_DIAG_ACYA[0] to freeze the
+		 * current state of the analog TX driver.
+		 */
+		val |= TX_DIAG_ACYA_HBDC_MASK;
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_DIAG_ACYA, val);
 
-static
-void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
-					   u32 rate, bool ssc)
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_TXCC_CTRL, 0x08A4);
+		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].diag_tx_drv;
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       DRV_DIAG_TX_DRV, val);
+		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].mgnfs_mult;
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_TXCC_MGNFS_MULT_000,
+				       val);
+		val = vltg_coeff[dp->voltage[lane]][dp->pre[lane]].cpost_mult;
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_TXCC_CPOST_MULT_00,
+				       val);
+
+		val = cdns_torrent_phy_read(cdns_phy->regmap_tx_lane_cdb[lane],
+					    TX_DIAG_ACYA);
+		/*
+		 * Write 0 to register bit TX_DIAG_ACYA[0] to allow the state of
+		 * analog TX driver to reflect the new programmed one.
+		 */
+		val &= ~TX_DIAG_ACYA_HBDC_MASK;
+		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
+				       TX_DIAG_ACYA, val);
+	}
+};
+
+static int cdns_torrent_dp_configure(struct phy *phy,
+				     union phy_configure_opts *opts)
 {
-	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	int ret;
 
-	/* Assumes 25 MHz refclock */
-	switch (rate) {
-	/* Setting VCO for 10.8GHz */
-	case 2700:
-	case 5400:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x01B0);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0120);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x01B0);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0120);
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x0423);
-		break;
-	/* Setting VCO for 9.72GHz */
-	case 1620:
-	case 2430:
-	case 3240:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0184);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0xCCCD);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0104);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0184);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0xCCCD);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0104);
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x03B9);
-		break;
-	/* Setting VCO for 8.64GHz */
-	case 2160:
-	case 4320:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0159);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x999A);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00E7);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0159);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x999A);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00E7);
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x034F);
-		break;
-	/* Setting VCO for 8.1GHz */
-	case 8100:
-		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0144);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x00D8);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0144);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x00D8);
-		if (ssc)
-			cdns_torrent_dp_enable_ssc_25mhz(cdns_phy, 0x031A);
-		break;
+	ret = cdns_torrent_dp_verify_config(inst, &opts->dp);
+	if (ret) {
+		dev_err(&phy->dev, "invalid params for phy configure\n");
+		return ret;
 	}
 
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
-	cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+	if (opts->dp.set_lanes) {
+		ret = cdns_torrent_dp_set_lanes(cdns_phy, &opts->dp);
+		if (ret) {
+			dev_err(&phy->dev, "cdns_torrent_dp_set_lanes failed\n");
+			return ret;
+		}
+	}
 
-	if (ssc) {
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0315);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0005);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0315);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0005);
-	} else {
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_VCOCAL_PLLCNT_START, 0x0317);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_VCOCAL_PLLCNT_START, 0x0317);
-		/* Set reset register values to disable SSC */
-		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL0_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL0_LOCK_PLLCNT_THR, 0x0003);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL1_M0, 0x0002);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL2_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL3_M0, 0x0000);
-		cdns_torrent_phy_write(regmap, CMN_PLL1_SS_CTRL4_M0, 0x0000);
-		cdns_torrent_phy_write(regmap,
-				       CMN_PLL1_LOCK_PLLCNT_THR, 0x0003);
+	if (opts->dp.set_rate) {
+		ret = cdns_torrent_dp_set_rate(cdns_phy, &opts->dp);
+		if (ret) {
+			dev_err(&phy->dev, "cdns_torrent_dp_set_rate failed\n");
+			return ret;
+		}
 	}
 
-	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_REFCNT_START, 0x00C7);
-	cdns_torrent_phy_write(regmap, CMN_PLL0_LOCK_PLLCNT_START, 0x00C7);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_REFCNT_START, 0x00C7);
-	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
+	if (opts->dp.set_voltages)
+		cdns_torrent_dp_set_voltages(cdns_phy, &opts->dp);
+
+	return ret;
 }
 
-static void cdns_torrent_dp_pma_cmn_rate(struct cdns_torrent_phy *cdns_phy,
-					 u32 rate, u32 num_lanes)
+static int cdns_torrent_phy_on(struct phy *phy)
 {
-	unsigned int clk_sel_val = 0;
-	unsigned int hsclk_div_val = 0;
-	unsigned int i;
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	u32 read_val;
+	int ret;
 
-	/* 16'h0000 for single DP link configuration */
-	regmap_field_write(cdns_phy->phy_pll_cfg, 0x0);
+	if (cdns_phy->nsubnodes == 1) {
+		/* Take the PHY lane group out of reset */
+		reset_control_deassert(inst->lnk_rst);
 
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
 	}
 
-	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
-			       CMN_PDIAG_PLL0_CLK_SEL_M0, clk_sel_val);
-	cdns_torrent_phy_write(cdns_phy->regmap_common_cdb,
-			       CMN_PDIAG_PLL1_CLK_SEL_M0, clk_sel_val);
+	mdelay(10);
 
-	/* PMA lane configuration to deal with multi-link operation */
-	for (i = 0; i < num_lanes; i++)
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[i],
-				       XCVR_DIAG_HSCLK_DIV, hsclk_div_val);
+	return 0;
 }
 
-static void cdns_torrent_dp_pma_lane_cfg(struct cdns_torrent_phy *cdns_phy,
-					 unsigned int lane)
+static int cdns_torrent_phy_off(struct phy *phy)
 {
-	/* Per lane, refclock-dependent receiver detection setting */
-	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-				       TX_RCVDET_ST_TMR, 0x0780);
-	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
-		cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-				       TX_RCVDET_ST_TMR, 0x09C4);
-
-	/* Writing Tx/Rx Power State Controllers registers */
-	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-			       TX_PSC_A0, 0x00FB);
-	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-			       TX_PSC_A2, 0x04AA);
-	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-			       TX_PSC_A3, 0x04AA);
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_PSC_A0, 0x0000);
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_PSC_A2, 0x0000);
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_PSC_A3, 0x0000);
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
+	int ret;
 
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_PSC_CAL, 0x0000);
+	if (cdns_phy->nsubnodes != 1)
+		return 0;
 
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_REE_GCSM1_CTRL, 0x0000);
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_REE_GCSM2_CTRL, 0x0000);
-	cdns_torrent_phy_write(cdns_phy->regmap_rx_lane_cdb[lane],
-			       RX_REE_PERGCSM_CTRL, 0x0000);
+	ret = reset_control_assert(cdns_phy->phy_rst);
+	if (ret)
+		return ret;
 
-	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-			       XCVR_DIAG_BIDI_CTRL, 0x000F);
-	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-			       XCVR_DIAG_PLLDRC_CTRL, 0x0001);
-	cdns_torrent_phy_write(cdns_phy->regmap_tx_lane_cdb[lane],
-			       XCVR_DIAG_HSCLK_SEL, 0x0000);
+	return reset_control_assert(inst->lnk_rst);
 }
 
-static int cdns_torrent_dp_set_power_state(struct cdns_torrent_phy *cdns_phy,
-					   u32 num_lanes,
-					   enum phy_powerstate powerstate)
+static int cdns_torrent_dp_init(struct phy *phy)
 {
-	/* Register value for power state for a single byte. */
-	u32 value_part;
-	u32 value;
-	u32 mask;
-	u32 read_val;
-	u32 ret;
+	unsigned char lane_bits;
+	int ret;
+	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
+	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
 
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
+	switch (cdns_phy->ref_clk_rate) {
+	case REF_CLK_19_2MHZ:
+	case REF_CLK_25MHZ:
+		/* Valid Ref Clock Rate */
 		break;
-	/* lanes 0-3, all */
 	default:
-		value = (value_part
-			 | (value_part << 8)
-			 | (value_part << 16)
-			 | (value_part << 24));
-		mask = 0x3F3F3F3FU;
-		break;
+		dev_err(cdns_phy->dev, "Unsupported Ref Clock Rate\n");
+		return -EINVAL;
 	}
 
-	/* Set power state A<n>. */
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, value);
-	/* Wait, until PHY acknowledges power state completion. */
-	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_POWER_STATE_ACK,
-				       read_val, (read_val & mask) == value, 0,
-				       POLL_TIMEOUT_US);
-	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_POWER_STATE_REQ, 0x00000000);
-	ndelay(100);
+	cdns_torrent_dp_write(regmap, PHY_AUX_CTRL, 0x0003); /* enable AUX */
 
-	return ret;
-}
+	/* PHY PMA registers configuration function */
+	cdns_torrent_dp_pma_cfg(cdns_phy, inst);
 
-static int cdns_torrent_dp_run(struct cdns_torrent_phy *cdns_phy, u32 num_lanes)
-{
-	unsigned int read_val;
-	int ret;
-	struct regmap *regmap = cdns_phy->regmap_dptx_phy_reg;
+	/*
+	 * Set lines power state to A0
+	 * Set lines pll clk enable to 0
+	 */
+	cdns_torrent_dp_set_a0_pll(cdns_phy, inst->num_lanes);
 
 	/*
-	 * waiting for ACK of pma_xcvr_pllclk_en_ln_*, only for the
-	 * master lane
+	 * release phy_l0*_reset_n and pma_tx_elec_idle_ln_* based on
+	 * used lanes
 	 */
-	ret = regmap_read_poll_timeout(regmap, PHY_PMA_XCVR_PLLCLK_EN_ACK,
-				       read_val, read_val & 1,
-				       0, POLL_TIMEOUT_US);
-	if (ret == -ETIMEDOUT) {
-		dev_err(cdns_phy->dev,
-			"timeout waiting for link PLL clock enable ack\n");
-		return ret;
-	}
+	lane_bits = (1 << inst->num_lanes) - 1;
+	cdns_torrent_dp_write(regmap, PHY_RESET,
+			      ((0xF & ~lane_bits) << 4) | (0xF & lane_bits));
 
-	ndelay(100);
+	/* release pma_xcvr_pllclk_en_ln_*, only for the master lane */
+	cdns_torrent_dp_write(regmap, PHY_PMA_XCVR_PLLCLK_EN, 0x0001);
 
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
-					      POWERSTATE_A2);
+	/* PHY PMA registers configuration functions */
+	/* Initialize PHY with max supported link rate, without SSC. */
+	if (cdns_phy->ref_clk_rate == REF_CLK_19_2MHZ)
+		cdns_torrent_dp_pma_cmn_vco_cfg_19_2mhz(cdns_phy,
+							cdns_phy->max_bit_rate,
+							false);
+	else if (cdns_phy->ref_clk_rate == REF_CLK_25MHZ)
+		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy,
+						      cdns_phy->max_bit_rate,
+						      false);
+	cdns_torrent_dp_pma_cmn_rate(cdns_phy, cdns_phy->max_bit_rate,
+				     inst->num_lanes);
+
+	/* take out of reset */
+	regmap_field_write(cdns_phy->phy_reset_ctrl, 0x1);
+
+	cdns_torrent_phy_on(phy);
+
+	ret = cdns_torrent_dp_wait_pma_cmn_ready(cdns_phy);
 	if (ret)
 		return ret;
 
-	ret = cdns_torrent_dp_set_power_state(cdns_phy, num_lanes,
-					      POWERSTATE_A0);
+	ret = cdns_torrent_dp_run(cdns_phy, inst->num_lanes);
 
 	return ret;
 }
@@ -1764,56 +1762,6 @@ static int cdns_torrent_derived_refclk_register(struct cdns_torrent_phy *cdns_ph
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
@@ -2091,6 +2039,27 @@ static int cdns_torrent_phy_init(struct phy *phy)
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

