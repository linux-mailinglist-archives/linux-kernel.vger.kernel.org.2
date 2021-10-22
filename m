Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168C2437B66
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbhJVRGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:06:08 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:53032 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233711AbhJVRFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:25 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEGZhq028588;
        Fri, 22 Oct 2021 10:03:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TLuV1d95SXlzRwf2Jt8/PsQ9w45ubtPbcoD86nL/np0=;
 b=cyWMM27+PhO7XMVc7RtMAJHmKr8A8/U1DooGgeYMgdIyQJ1DxGdpE51jthPCD+YQqPto
 IBO9hPtHpvizCKpptJyxozPNk8g+yjitRmeBPJD8wVn38TecbBurtckUvnsmUkGAFWbl
 liteTc1bNeEDBBZdyJPyoIN5YavN8Ssd6XzchvLhsmqeS3UGvX4BAKzlAUVeukq/9gKL
 GHrw/65p+2wP5x/QakMvKFpXfTpNSF37snatM3w4RVsQlTIih+aEF+BrKqFKUKBwtXBy
 uqa45AXzSWPp1dJjTu+I2DgfYDiFNqlXf4gcqDfhh5dt19oCHBRFttacjv4E2SbELy/M 5Q== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3buxg0rm57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbkgYIpXCK3KM7FqTH32hVXaOz26WzoQ9HDyOQikLT5iU3NcPSCs5IIHPDB8UgFljfn35XFqe2xlUo5qmyInmLbA2h9uFErGofXxkHmj4MFZPLTW6+B5lS7GIVhLNrBOKn67GGgO2wlR58lxEy3upjdr34c9KuK347hmub7RJ4Yk7dLTj8AUPg4DeTRiNzwUpsR3pGjD0D9p+gOcSElSMlOPJf2oAf4kdYusHKGcGqPgmJnWzd2C178KeYPEfqaQTHuWppIE+1DBnI7eyPmW1BFBfNcWfqN+s4rCBl0R05epAflqUlmRU4I+WViSVZapCFOcbKEULObXXHciM0EZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLuV1d95SXlzRwf2Jt8/PsQ9w45ubtPbcoD86nL/np0=;
 b=MDiEYz2sC89urFZL045oE723vcacGpr3j1G0WpsjYzbNWtK6F4eed/7TwJd3Iqlb4IVUp+4S56zFNiaKImpm8tVz1rI5YgXwe+yc318Htmv/SMYwAnS7BHUN24HMsQvGTrw6JIE8E0Gb7dm6T6i3csV0QSBU5r7ztIqLzSeCakbKZX7n8Icx5d2iyn4qj8ea2crvwF+hnvelwqvvywB1Mq6aJPh2GiP9p3ma6J6mZiZOB4zzACAWsK3DOiCMIJMFsaOT/PKe5x6jbGImlkESmj7jUqJAcPlGjv4yVufnuS9HJjciEdGX+56lIeGPfBx0IT5o6ca02ehyYfrzPV7Nfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLuV1d95SXlzRwf2Jt8/PsQ9w45ubtPbcoD86nL/np0=;
 b=BGCURlKYlYzzVYT1+32AxSsjJkNX3hu0xgdL43pyLsV1GD90+mtyOIUbGaTMAd3sAu5wBJVHX9zh6qOsrMWp0Jn/6qrG6Gu/YTMbg2nJit7S+z1MM598yQo0MKGc349Mmn/dWMX0s38XhuiZOd2IFKUF8uQCyQiSqxLcBEDYM6k=
Received: from BN9P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::19)
 by SA1PR07MB8387.namprd07.prod.outlook.com (2603:10b6:806:1ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 17:02:56 +0000
Received: from BN8NAM12FT034.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::a2) by BN9P221CA0014.outlook.office365.com
 (2603:10b6:408:10a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT034.mail.protection.outlook.com (10.13.183.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNU008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:55 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 19:02:38 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Oct 2021 19:02:38 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2cwH018914;
        Fri, 22 Oct 2021 19:02:38 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2cbv018913;
        Fri, 22 Oct 2021 19:02:38 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 07/15] phy: cadence: Sierra: Add PHY PCS common register configurations
Date:   Fri, 22 Oct 2021 19:02:28 +0200
Message-ID: <20211022170236.18839-8-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca3a99bd-1a79-4580-7779-08d9957dcb3e
X-MS-TrafficTypeDiagnostic: SA1PR07MB8387:
X-Microsoft-Antispam-PRVS: <SA1PR07MB83879B121E1335EC6EA19CBAC5809@SA1PR07MB8387.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:741;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+dlq0MWF1ZGTC4Lz9KGhIzK7BIJKvpbywv6BrRk1z/uts6C1yIhJ2ZV1EFZXgJ5WYKomPuLOFr0/6vlcQcCCl2cv5+C3SfoJ07ghuCI0/lT7OJDAvKwWPumd4twDo6WoJ9EIwY4pFAcGmiu6f0nuntkOHcKjj/fo8XNB5oxo5VkQsgClDkoglHdjVwdcrW0fApB5oBZJ+9Tb5x+nAT0doB6JLH8ttqRY7DVJ1CAGGUo+weDP2vcsdHVMpDsidPkBbQwKmt1OWF1v9E8x96s7IZSyZeIeOg+/4fwdAEoIgif+wD037aHPV2IV5+jzpnII8cKepd926MqvabkK21hDfo03AXnFOSDdrOYKQNxxvz/ZhPtB5qfPFmGS3RKVr/99NGU/Kq/9pcG/ta9iBvvZfXZmHrClDgVN1bLfM0SLiEWrieJkTNRvj4Up/G+uNzqNPK9AnhG+YmxVQkEgmge5H2rI6b6589w8tGGWCMLRhdvCLU8Ym8bSRmDo92idvK5M8oSEWEfGnlaa4Eh1FH+kd9NN7mUZPbexxQfBFuhNcj4qz1q85pdSvaJH4Jb1TymI4i3wC7JIp+9L/4VyC2If6V1atZoqFvxzrjedqT0O3dFhc3mealtIU1O91CkNx3WGowaT5sOyIwTS2Wwjjh0lMu07JM/cszA3+1SaMmeoZ8/0MPTlUjPwQIUzFe7UzAvhUEa8sIGGtIzqx3tWtE5u143f1WUHDjm3OMRz/x6pAM=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(1076003)(83380400001)(316002)(82310400003)(36906005)(36756003)(508600001)(42186006)(110136005)(70586007)(26005)(70206006)(8936002)(19627235002)(186003)(8676002)(426003)(4326008)(2906002)(356005)(7636003)(36860700001)(47076005)(6666004)(54906003)(5660300002)(2616005)(86362001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:56.1545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3a99bd-1a79-4580-7779-08d9957dcb3e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT034.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR07MB8387
X-Proofpoint-GUID: 6iBlLUj1IKmvVzZXbbb8Y6tHiPJhRvgJ
X-Proofpoint-ORIG-GUID: 6iBlLUj1IKmvVzZXbbb8Y6tHiPJhRvgJ
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

Add PHY PCS common register configuration sequences for single link.
Update single link PCIe register sequence accordingly.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 38 ++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 9f2b8aefee9c..0bfd13843f2e 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -148,6 +148,7 @@
 /* PHY PCS common registers */
 #define SIERRA_PHY_PCS_COMMON_OFFSET(block_offset)	\
 				     (0xc000 << (block_offset))
+#define SIERRA_PHY_PIPE_CMN_CTRL1			0x0
 #define SIERRA_PHY_PLL_CFG				0xe
 
 #define SIERRA_MACRO_ID					0x00007364
@@ -256,6 +257,8 @@ struct cdns_sierra_data {
 	u32 id_value;
 	u8 block_offset_shift;
 	u8 reg_offset_shift;
+	struct cdns_sierra_vals *pcs_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
+					     [NUM_SSC_MODE];
 	struct cdns_sierra_vals *pma_cmn_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
 					     [NUM_SSC_MODE];
 	struct cdns_sierra_vals *pma_ln_vals[NUM_PHY_TYPE][NUM_PHY_TYPE]
@@ -364,6 +367,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	enum cdns_sierra_phy_type phy_type = ins->phy_type;
 	enum cdns_sierra_ssc_mode ssc = ins->ssc_mode;
 	const struct cdns_reg_pairs *reg_pairs;
+	struct cdns_sierra_vals *pcs_cmn_vals;
 	struct regmap *regmap;
 	u32 num_regs;
 	int i, j;
@@ -375,6 +379,16 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
 	clk_set_rate(phy->input_clks[CMN_REFCLK1_DIG_DIV], 25000000);
 
+	/* PHY PCS common registers configurations */
+	pcs_cmn_vals = init_data->pcs_cmn_vals[phy_type][TYPE_NONE][ssc];
+	if (pcs_cmn_vals) {
+		reg_pairs = pcs_cmn_vals->reg_pairs;
+		num_regs = pcs_cmn_vals->num_regs;
+		regmap = phy->regmap_phy_pcs_common_cdb;
+		for (i = 0; i < num_regs; i++)
+			regmap_write(regmap, reg_pairs[i].off, reg_pairs[i].val);
+	}
+
 	/* PMA common registers configurations */
 	pma_cmn_vals = init_data->pma_cmn_vals[phy_type][TYPE_NONE][ssc];
 	if (pma_cmn_vals) {
@@ -1022,6 +1036,16 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* PCIE PHY PCS common configuration */
+static struct cdns_reg_pairs pcie_phy_pcs_cmn_regs[] = {
+	{0x0430, SIERRA_PHY_PIPE_CMN_CTRL1}
+};
+
+static struct cdns_sierra_vals pcie_phy_pcs_cmn_vals = {
+	.reg_pairs = pcie_phy_pcs_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_phy_pcs_cmn_regs),
+};
+
 /* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc */
 static const struct cdns_reg_pairs cdns_pcie_cmn_regs_ext_ssc[] = {
 	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
@@ -1173,6 +1197,13 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 	.id_value = SIERRA_MACRO_ID,
 	.block_offset_shift = 0x2,
 	.reg_offset_shift = 0x2,
+	.pcs_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
+		},
+	},
 	.pma_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
@@ -1203,6 +1234,13 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 	.id_value = SIERRA_MACRO_ID,
 	.block_offset_shift = 0x0,
 	.reg_offset_shift = 0x1,
+	.pcs_cmn_vals = {
+		[TYPE_PCIE] = {
+			[TYPE_NONE] = {
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
+		},
+	},
 	.pma_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
-- 
2.26.1

