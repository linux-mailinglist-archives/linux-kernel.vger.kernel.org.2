Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 808243D9165
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbhG1O4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:56:05 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:11852 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237386AbhG1Oz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:55:28 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SEk9ZU024616;
        Wed, 28 Jul 2021 07:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=FHSq8I9Ogq2bFGvRGOBoL8+KZ04LStSOwep6EWfhZ04=;
 b=IJCKkWp8+ODNbLCJwiu8z4/TGDSUBiQmFQ30PoY+CXAy+rp9jOfZiuvo2nz50I6jnhmB
 gmY+hFuvCoqS5j0E/V0DUda4bbyFNbo9df5NncXfffDmwKpORcjaM4eQDc0em4II71Zw
 nSq8BxB0BCt25zqNuZlJVI3xq23+sKF6qJaOvLcWqsIjvi35YdsWwGyEtb50ZnVu+bF9
 SMBQ6JpTQtutGiG6/CBWRXHtumTV1VFNYWyTM6MKpYMznlzUEWEnN0Z9opplmS3/QSgA
 fElXDtzdz24ffp2I+94bLj+lxgrmHh2mfyILZuwdwqPyKUUyIJqkhFh/Ko7+ogeB2EHu fg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3a234aysby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 07:55:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+HE9AhSy6MQljZ5OJ0wIV0yxuKTh7oBWqQxsc67Q3nRZqp13g4OaFwvo7zhf39DdF/fbhWpdQ2qtiydPx/cBzVw3LEQaW5qxUUE8J9keslFGsflsAjEMtVpTQKhnhSgUPqT4L96QFhiVqje3TvWsHSdrMBGHv2mb56+1dTDnz5gr6kBa8WQC/tUN9B/5bPRn9uv83tT+WzGiC4ccHxmiU2fvYpgevM9xo3FqiamjBrNVrsW7DYUDcMWeBw6GZZtZ//nlTxH5rmHtv/f3KxW3tWAjEMgPUu8drAqYMOYImqVaSrBz4uKoEpcQjEGS3sLO1yyR2wPgr8oEC5cq9l3HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHSq8I9Ogq2bFGvRGOBoL8+KZ04LStSOwep6EWfhZ04=;
 b=RW8qUc0hWA+spV4fIQBM2RFqKyD6luEtg2OKdgS/IWjnCWGDw5+2psFlhqOaekH40AARK/vEwm3pMtFjOwU58ckQlacCJVj19qEQW8jpV6iOwThUwyPtq3QKl8Y4Rmo0/X8asu37iX563WB+QVkZUTIuhUaXE2T4EfSKv0QuEN7VWlVJ5PzMJk57A3s0LIaPNonoaBA0gVZbi1DVN5rw8XY8egmFFO40qfOOQSeCErAJ84krRDuNNuvJPf+mVdQPP5v6PmbzTBye4/jc/aQ8RIdCT9CsNdpA5mEWHLqrGWnXPO+svDy0m1zQC/iodn9+JicjN+/5s8YSvMGMCnJfxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 64.207.220.244) smtp.rcpttodomain=pengutronix.de
 smtp.mailfrom=cadence.com; dmarc=temperror action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHSq8I9Ogq2bFGvRGOBoL8+KZ04LStSOwep6EWfhZ04=;
 b=cjxGCvRNH1gQXG65iY/IA7FpjGQs+Z4GWkrY1xXFy+IDaUoFCPtCeCxYvnJWca+pRgRMCBN28+uIbRYKNcwT5afe689jTKJMoiPyA76xKO7zfcpjT3O967NNXQQ3M7kM+2lcGVbf1t3F9QAa01rn2iXFeoWAGUfpobZvNo4dReU=
Received: from BN9P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::24)
 by CY4PR07MB2776.namprd07.prod.outlook.com (2603:10b6:903:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Wed, 28 Jul
 2021 14:55:04 +0000
Received: from BN8NAM12FT030.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::83) by BN9P220CA0019.outlook.office365.com
 (2603:10b6:408:13e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend
 Transport; Wed, 28 Jul 2021 14:55:03 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 64.207.220.244) smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message
 not signed) header.d=none;pengutronix.de; dmarc=temperror action=none
 header.from=cadence.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cadence.com: DNS Timeout)
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT030.mail.protection.outlook.com (10.13.183.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.7 via Frontend Transport; Wed, 28 Jul 2021 14:55:02 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 16SEsvrs095664
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 07:55:00 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 16:54:57 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 28 Jul 2021 16:54:56 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 16SEsupl016537;
        Wed, 28 Jul 2021 16:54:56 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 16SEsulA016536;
        Wed, 28 Jul 2021 16:54:56 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v3 4/9] phy: cadence-torrent: Configure PHY registers as a function of input reference clock rate
Date:   Wed, 28 Jul 2021 16:54:49 +0200
Message-ID: <20210728145454.15945-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210728145454.15945-1-sjakhade@cadence.com>
References: <20210728145454.15945-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2292b7b0-1318-4095-fc51-08d951d7adb1
X-MS-TrafficTypeDiagnostic: CY4PR07MB2776:
X-Microsoft-Antispam-PRVS: <CY4PR07MB27764E9767636161AEFF7270C5EA9@CY4PR07MB2776.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mJdedndWX4Y4NpAYjgF6aKx3HYcdQ6QxVbYdiFta/WSI8G7YqgZ8B9zctLzTFPm7Iq6Csk4o8HUUBTcUzU2n/obAEcuJKNeBNO6ruyA7bS5yM0c1M76fj4J5UfMe8slt8mphodoTQkZndk9I1NEiNULCCeo/lIQ460Mz2gjNJ18jGF+zUIBWdoUehOqwN+A0I3gAbi1trKC4+xsttL2eZnojMMRsx5a6ark88NSVOU+dbshkKI9g7deMRdL8gHY1oh0NpOlhJ5V7TLIKYTskUnJW/0K3AOZHR1UT0wqlWtyW5vMXcwkVZcR+dNhOELB4KJwOkhHUger+cAR90I+tB67BVnXpYeADFEeVd2to1XzUnUeFFtJkTiy6YAHweTioouHehmN4v9nnJnZzv9nC/J56ff0inFxmKDYjJnU5Bzsh7mkKa1NTvoeHRe6V3eBTKUv2LutBqgfCd8hjNDNH/IzvCWVqdkk/m8xbro7iydq5G2KtKuYHF/NjHDxrhQlu6j/i2vWauMauXqLzjQrYMndU0ehrrM44clbuYCXyqKPF4E0nvjQga/zNgs4yEE1yVMIJvJNRUjHkI2RLtVqP52v+UVZ/VuzZTudwbHryLxndMW63/Tg9MdX/dpj0k27hJ9uQybTAJah7rm5DBIDU3r0UxMcr1TnK12CeueP+z5CS3CXwqGEHYuYcGsNwIsSco7GaO4P4/OuE5HwAfmEccg+VQXahyovBcWe4flMIyoaYGUDRjA+++cqoekRNKLDMmgfgw9Aep0nLGxi1y2FMXOY5HtNvEbJ/O5b2IxXgF+A=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36092001)(36840700001)(46966006)(42186006)(36860700001)(316002)(110136005)(36756003)(2616005)(86362001)(1076003)(426003)(63370400001)(81166007)(63350400001)(47076005)(2906002)(83380400001)(82310400003)(478600001)(8676002)(6666004)(82740400003)(336012)(70586007)(54906003)(26005)(70206006)(8936002)(356005)(30864003)(5660300002)(186003)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 14:55:02.1468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2292b7b0-1318-4095-fc51-08d951d7adb1
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT030.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB2776
X-Proofpoint-ORIG-GUID: rBRPqw6eQtXSvhqN5ddpQXy3SQ36SfWk
X-Proofpoint-GUID: rBRPqw6eQtXSvhqN5ddpQXy3SQ36SfWk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_08:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107280082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Torrent PHY supports multiple serdes standards with different input
reference clock frequencies. PHY register values differ based on the
reference clock rate. Add PHY input reference clock frequency as a
new dimension to select proper register configuration. No functional
change is intended.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 830 +++++++++++-----------
 1 file changed, 422 insertions(+), 408 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index f746553c8089..86f05817704d 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -360,12 +360,12 @@ struct cdns_torrent_data {
 						[NUM_SSC_MODE];
 	struct cdns_torrent_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					      [NUM_SSC_MODE];
-	struct cdns_torrent_vals *cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-					  [NUM_SSC_MODE];
-	struct cdns_torrent_vals *tx_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-					    [NUM_SSC_MODE];
-	struct cdns_torrent_vals *rx_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
-					    [NUM_SSC_MODE];
+	struct cdns_torrent_vals *cmn_vals[NUM_REF_CLK][NUM_PHY_TYPE]
+					  [NUM_PHY_TYPE][NUM_SSC_MODE];
+	struct cdns_torrent_vals *tx_ln_vals[NUM_REF_CLK][NUM_PHY_TYPE]
+					    [NUM_PHY_TYPE][NUM_SSC_MODE];
+	struct cdns_torrent_vals *rx_ln_vals[NUM_REF_CLK][NUM_PHY_TYPE]
+					    [NUM_PHY_TYPE][NUM_SSC_MODE];
 };
 
 struct cdns_regmap_cdb_context {
@@ -1943,6 +1943,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	enum cdns_torrent_phy_type phy_type = inst->phy_type;
@@ -2008,7 +2009,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA common registers configurations */
-	cmn_vals = init_data->cmn_vals[phy_type][TYPE_NONE][ssc];
+	cmn_vals = init_data->cmn_vals[ref_clk][phy_type][TYPE_NONE][ssc];
 	if (cmn_vals) {
 		reg_pairs = cmn_vals->reg_pairs;
 		num_regs = cmn_vals->num_regs;
@@ -2019,7 +2020,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA TX lane registers configurations */
-	tx_ln_vals = init_data->tx_ln_vals[phy_type][TYPE_NONE][ssc];
+	tx_ln_vals = init_data->tx_ln_vals[ref_clk][phy_type][TYPE_NONE][ssc];
 	if (tx_ln_vals) {
 		reg_pairs = tx_ln_vals->reg_pairs;
 		num_regs = tx_ln_vals->num_regs;
@@ -2032,7 +2033,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA RX lane registers configurations */
-	rx_ln_vals = init_data->rx_ln_vals[phy_type][TYPE_NONE][ssc];
+	rx_ln_vals = init_data->rx_ln_vals[ref_clk][phy_type][TYPE_NONE][ssc];
 	if (rx_ln_vals) {
 		reg_pairs = rx_ln_vals->reg_pairs;
 		num_regs = rx_ln_vals->num_regs;
@@ -2073,6 +2074,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 {
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_phy_type phy_t1, phy_t2, tmp_phy_type;
 	struct cdns_torrent_vals *pcs_cmn_vals;
@@ -2161,7 +2163,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PMA common registers configurations */
-		cmn_vals = init_data->cmn_vals[phy_t1][phy_t2][ssc];
+		cmn_vals = init_data->cmn_vals[ref_clk][phy_t1][phy_t2][ssc];
 		if (cmn_vals) {
 			reg_pairs = cmn_vals->reg_pairs;
 			num_regs = cmn_vals->num_regs;
@@ -2172,7 +2174,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PMA TX lane registers configurations */
-		tx_ln_vals = init_data->tx_ln_vals[phy_t1][phy_t2][ssc];
+		tx_ln_vals = init_data->tx_ln_vals[ref_clk][phy_t1][phy_t2][ssc];
 		if (tx_ln_vals) {
 			reg_pairs = tx_ln_vals->reg_pairs;
 			num_regs = tx_ln_vals->num_regs;
@@ -2185,7 +2187,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PMA RX lane registers configurations */
-		rx_ln_vals = init_data->rx_ln_vals[phy_t1][phy_t2][ssc];
+		rx_ln_vals = init_data->rx_ln_vals[ref_clk][phy_t1][phy_t2][ssc];
 		if (rx_ln_vals) {
 			reg_pairs = rx_ln_vals->reg_pairs;
 			num_regs = rx_ln_vals->num_regs;
@@ -3481,230 +3483,236 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 		},
 	},
 	.cmn_vals = {
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+		[CLK_100_MHZ] = {
+			[TYPE_PCIE] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				},
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				},
 			},
 		},
 	},
 	.tx_ln_vals = {
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
+		[CLK_100_MHZ] = {
+			[TYPE_PCIE] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
+				[TYPE_NONE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_tx_ln_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_tx_ln_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
 			},
 		},
 	},
 	.rx_ln_vals = {
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+		[CLK_100_MHZ] = {
+			[TYPE_PCIE] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
 			},
 		},
 	},
@@ -3890,230 +3898,236 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 		},
 	},
 	.cmn_vals = {
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+		[CLK_100_MHZ] = {
+			[TYPE_PCIE] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = &sl_pcie_100_int_ssc_cmn_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				},
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_sgmii_100_no_ssc_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sgmii_100_int_ssc_cmn_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
+				},
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_cmn_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_qsgmii_100_no_ssc_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &qsgmii_100_int_ssc_cmn_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_cmn_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
-				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+					[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
+				},
 			},
 		},
 	},
 	.tx_ln_vals = {
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
+		[CLK_100_MHZ] = {
+			[TYPE_PCIE] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = NULL,
+					[EXTERNAL_SSC] = NULL,
+					[INTERNAL_SSC] = NULL,
+				},
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
+				[TYPE_NONE] = {
+					[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
+				[TYPE_NONE] = {
+					[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
+				},
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = NULL,
-				[EXTERNAL_SSC] = NULL,
-				[INTERNAL_SSC] = NULL,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &ti_sgmii_100_no_ssc_tx_ln_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &ti_qsgmii_100_no_ssc_tx_ln_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_tx_ln_vals,
+				},
 			},
 		},
 	},
 	.rx_ln_vals = {
-		[TYPE_PCIE] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+		[CLK_100_MHZ] = {
+			[TYPE_PCIE] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-			},
-		},
-		[TYPE_SGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_USB] = {
+					[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
+				},
 			},
 			[TYPE_USB] = {
-				[NO_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &sgmii_100_no_ssc_rx_ln_vals,
-			},
-		},
-		[TYPE_QSGMII] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_USB] = {
-				[NO_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &qsgmii_100_no_ssc_rx_ln_vals,
-			},
-		},
-		[TYPE_USB] = {
-			[TYPE_NONE] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_PCIE] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-			},
-			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
-				[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				[TYPE_NONE] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_PCIE] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_SGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
+				[TYPE_QSGMII] = {
+					[NO_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[EXTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+					[INTERNAL_SSC] = &usb_100_no_ssc_rx_ln_vals,
+				},
 			},
 		},
 	},
-- 
2.26.1

