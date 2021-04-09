Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2328C3594B8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhDIFfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:35:55 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:21048 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233340AbhDIFfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:35:19 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395XZ2Q028234;
        Thu, 8 Apr 2021 22:34:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=NmTy89ysbbSOlWamiL+p+W+Fu+xpsucdEK7SobbFh/U=;
 b=hmoPC2IAfpcbMjRtQjMi1ha3Zr4L+ioXJZs4FdJLQ27uJl2bEAk3IUu5hXy6u9ZKA8jn
 nTfNhpcyRI1Afzi1EZ59Nk6RgL+Bl0e/vBDAeGZrtulgK8i8ksIfqHGeHcXwtovpBamY
 49eQ48sV7YgpNaHWQ8SAAlxZnvnnAynhzMrWqoBI9iU7JsZLEEAOVlWeDl9lWhdJ80nQ
 zH384c7vQZPYoziQPXYoSZWwiiKtzO8Rc+vvI7IaOHfQ+6No9UkxySs+G6BG7UXW/VoZ
 HNEzRVbQlVO6nRWecV09/A8yZWSYroH1GPGblAJeYB7ZXUbB0P7j0Y87NnD9n8+0JqJ/ 6w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37t6ns1sr0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4olNWJAgX+DybJNrj9Uqc0b1Gy8rr6r1QPvznTILgEsKIt02qIhlZ9mA3fbd+tk/HA/gBnXxGwTwNf5KeFSjIWRdR2pl3TfS+PqyHTy5UJKuNMWPLFbkk3ob2R7K+6T4geUR2By7yvmGGalPf+NJab02vWgdOirL5rJN+zpmWgIZBJ+LpCF1HMhCnpPZ7jRrk2uRjOxyDpgKAkUSRGc0tVnq3WJpTrD9N1AafrWv2Yw5GvhRDbVMnWQAiY3cZEKW9jhy5K/gUNdheTpPVbWpdHAgvs+16z3Gm5TKPB98vaJ7RiaujzJVtDsmEY5HBTu7vyu1ruK1QCxP4gCW2zG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmTy89ysbbSOlWamiL+p+W+Fu+xpsucdEK7SobbFh/U=;
 b=brR0XgC9GlYUS5e/e8jG6TF0L7fBWWBKRIF4fb0zbBqjSNMNWk+lvt7Z9pjZ3P9TN4fcfkrOeu/wzSltFWVXfDNAUOA++0cCrzADudLAN1yKRaYu+qpnxDU5kDLJipKapOVThBmeRMLvOAjRQ5mX1JQ9UQCeJKhVpQxPMlbBBB6pWN12g6Nm2fq7WnXGyG5GLjFJMSz+iUZBQJGGGhXD5sKuK35KZnU3mj6RD9ydGq34sJ/RXwEaBUWxGwTKMJzZFvoUd1ubYHPiz3o2IGw4wc84sL6yHIDsFeUCX7pbksS+sb5XLe3xhS7hOnF37wu7T9+kwivyH/wo8yJc8GQ8Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmTy89ysbbSOlWamiL+p+W+Fu+xpsucdEK7SobbFh/U=;
 b=F+bsYGd+coo9dKOmdOiwywvtrNhDEprQdl89TggphGG3XICHTWt3sgn1euSKuTKqJE1zjpiIE6GB+lmpGnVEe0wNg9q/2fLePTdE4T91YwifddFHkB+p3RLPV3Li2U6TOTrjIEqL05HlNdhkY4bcdv2nvTK8yZUVqal8HyBDE3s=
Received: from MWHPR13CA0016.namprd13.prod.outlook.com (2603:10b6:300:16::26)
 by DM6PR07MB6602.namprd07.prod.outlook.com (2603:10b6:5:1cd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 9 Apr
 2021 05:34:24 +0000
Received: from MW2NAM12FT055.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::47) by MWHPR13CA0016.outlook.office365.com
 (2603:10b6:300:16::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT055.mail.protection.outlook.com (10.13.180.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:24 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5V032749
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 22:34:23 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YIcn027844;
        Fri, 9 Apr 2021 07:34:18 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YIhP027843;
        Fri, 9 Apr 2021 07:34:18 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 04/14] phy: cadence-torrent: Select register configuration based on PHY reference clock
Date:   Fri, 9 Apr 2021 07:34:06 +0200
Message-ID: <1617946456-27773-5-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1b7ad72-2475-4c1a-8fa4-08d8fb192288
X-MS-TrafficTypeDiagnostic: DM6PR07MB6602:
X-Microsoft-Antispam-PRVS: <DM6PR07MB66028B4FEBE90334FB4E9898C5739@DM6PR07MB6602.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:519;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mjvq6w/iK+3h5HTdp6VY1KI/YESuvuEm7GOIGiQAfdo4BnMKXOs+6TQYurxb6y99uWoYc1QajwpleEF8QtIRlzrGo1t6FZkqmDDHSOXOX20xNYqcps7yCUaoZvGwDotbF4n3V99mGsWjYbQf8rlv6+d1xp8hlym2ExNqsaozDHtB2S1rBdj6V91Io6fyw5fnl5Fco3RC/2el98uedfR9NzN//W5tUAat9xZzqd7V3QbZUkndpeeo9W8+EDTt1B4SEYpDXfndI/ZPUGwIZ/caCC4WkRssYJP67ay7dh1aME3bPY6Tsy+D/oep/Qu4Xo+ZqyCVdnLdB9DB2G15MAYBsnin77MhuRlpE5YA0Bg7XwB0MwYZdgP7Zue6LDby41YIsHYAAYY0xTfo9q7d9xRt80eUKvjQYCUMyNe+8Z7M0ux7w22MlPcgB9tXx55TqK9UYbrWRSr2B98SCoY8qwrbeIj641/ARt6y0KmnYkNIW2Bdo79079QbY/BPXTbvR7/7gYKDUcEiL6/Z585bPVzX2pM/nLGTR/4wt8G0VUoiUhZX1vg+kvJfUJPQ3T/JaxMrD7eofbGM+HHvrHFk9ClVoZ0aZ6npd8ioG0l7iAW6Z4GGdMiCz3goMm3ELI+D0jmKjUqes9u/0kSAtAiXuNLnk52a92uZZ7325PHgL6Wiv228zEcqCVMlfghTY/UgQ39D7gxvBbEp/smdWrRkK8QOUw==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36092001)(36840700001)(46966006)(478600001)(42186006)(70586007)(70206006)(110136005)(54906003)(36860700001)(47076005)(8676002)(4326008)(7636003)(336012)(26005)(5660300002)(2616005)(2906002)(8936002)(82310400003)(82740400003)(186003)(426003)(36906005)(316002)(356005)(83380400001)(6666004)(30864003)(86362001)(36756003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:24.4274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b7ad72-2475-4c1a-8fa4-08d8fb192288
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT055.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6602
X-Proofpoint-ORIG-GUID: lnRRp7B8yFt_Vhx-IoMgDUViT2OMAPzT
X-Proofpoint-GUID: lnRRp7B8yFt_Vhx-IoMgDUViT2OMAPzT
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

Add PHY input reference clock frequency as a new dimension to select proper
register configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 830 +++++++++++-----------
 1 file changed, 422 insertions(+), 408 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index 252920ea7fdf..39a26a1a4c51 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -375,12 +375,12 @@ struct cdns_torrent_data {
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
@@ -1958,6 +1958,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	struct cdns_torrent_phy *cdns_phy = dev_get_drvdata(phy->dev.parent);
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	struct cdns_torrent_inst *inst = phy_get_drvdata(phy);
 	enum cdns_torrent_phy_type phy_type = inst->phy_type;
@@ -2023,7 +2024,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA common registers configurations */
-	cmn_vals = init_data->cmn_vals[phy_type][TYPE_NONE][ssc];
+	cmn_vals = init_data->cmn_vals[ref_clk][phy_type][TYPE_NONE][ssc];
 	if (cmn_vals) {
 		reg_pairs = cmn_vals->reg_pairs;
 		num_regs = cmn_vals->num_regs;
@@ -2034,7 +2035,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA TX lane registers configurations */
-	tx_ln_vals = init_data->tx_ln_vals[phy_type][TYPE_NONE][ssc];
+	tx_ln_vals = init_data->tx_ln_vals[ref_clk][phy_type][TYPE_NONE][ssc];
 	if (tx_ln_vals) {
 		reg_pairs = tx_ln_vals->reg_pairs;
 		num_regs = tx_ln_vals->num_regs;
@@ -2047,7 +2048,7 @@ static int cdns_torrent_phy_init(struct phy *phy)
 	}
 
 	/* PMA RX lane registers configurations */
-	rx_ln_vals = init_data->rx_ln_vals[phy_type][TYPE_NONE][ssc];
+	rx_ln_vals = init_data->rx_ln_vals[ref_clk][phy_type][TYPE_NONE][ssc];
 	if (rx_ln_vals) {
 		reg_pairs = rx_ln_vals->reg_pairs;
 		num_regs = rx_ln_vals->num_regs;
@@ -2088,6 +2089,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 {
 	const struct cdns_torrent_data *init_data = cdns_phy->init_data;
 	struct cdns_torrent_vals *cmn_vals, *tx_ln_vals, *rx_ln_vals;
+	enum cdns_torrent_ref_clk ref_clk = cdns_phy->ref_clk_rate;
 	struct cdns_torrent_vals *link_cmn_vals, *xcvr_diag_vals;
 	enum cdns_torrent_phy_type phy_t1, phy_t2, tmp_phy_type;
 	struct cdns_torrent_vals *pcs_cmn_vals;
@@ -2176,7 +2178,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PMA common registers configurations */
-		cmn_vals = init_data->cmn_vals[phy_t1][phy_t2][ssc];
+		cmn_vals = init_data->cmn_vals[ref_clk][phy_t1][phy_t2][ssc];
 		if (cmn_vals) {
 			reg_pairs = cmn_vals->reg_pairs;
 			num_regs = cmn_vals->num_regs;
@@ -2187,7 +2189,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PMA TX lane registers configurations */
-		tx_ln_vals = init_data->tx_ln_vals[phy_t1][phy_t2][ssc];
+		tx_ln_vals = init_data->tx_ln_vals[ref_clk][phy_t1][phy_t2][ssc];
 		if (tx_ln_vals) {
 			reg_pairs = tx_ln_vals->reg_pairs;
 			num_regs = tx_ln_vals->num_regs;
@@ -2200,7 +2202,7 @@ int cdns_torrent_phy_configure_multilink(struct cdns_torrent_phy *cdns_phy)
 		}
 
 		/* PMA RX lane registers configurations */
-		rx_ln_vals = init_data->rx_ln_vals[phy_t1][phy_t2][ssc];
+		rx_ln_vals = init_data->rx_ln_vals[ref_clk][phy_t1][phy_t2][ssc];
 		if (rx_ln_vals) {
 			reg_pairs = rx_ln_vals->reg_pairs;
 			num_regs = rx_ln_vals->num_regs;
@@ -3496,230 +3498,236 @@ static const struct cdns_torrent_data cdns_map_torrent = {
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
@@ -3905,230 +3913,236 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
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

