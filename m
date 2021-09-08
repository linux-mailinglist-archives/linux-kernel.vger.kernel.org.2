Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B234039E9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351805AbhIHMcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:32:12 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:35280 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349274AbhIHMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:06 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886de6Z016948;
        Wed, 8 Sep 2021 05:29:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=0Kr5e0fTDOUkLGW5uyGtdM2SN1Iq4/EJcuPrvlBreAY=;
 b=Pa7Tm4pHZm+/NVEvteSwBNxvepGJwE472iLiBrvJey4Fg7lGryWiVWDTZbcx/3fyAaQg
 xPmVInYJ9dl+v7n7q94BudlfuN6h7sERnG3EJ4YufEM+pg7WG8tDo5eezOT9DISej0RK
 VwQ+/FNmo6qkStQnWb7la0TeHe3OHt/zavumfE8RHrW5UsPbXNBsvwlSXotcROVjEUhN
 47pUktTlN1Wq2nIOf4PGcFKVIU+nhQBpvJ/bQpzOHkH2UI/jvO0tyRH+lMc3/NMLaixM
 DFKxXY8B2ImUwgxwYagz+i1/o17huVYYO7txKe3fvB7mtDJApRixVSGPpRrh4ZZ9UIfV 3A== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3axcp9k486-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrUg/zcajv3kloFJREXfglseAjudlQEsZ8NuqITXwRFfpCyc2/S/A2z+jXV+bJTXxRwfDObKz4y9oWIFaR3s9+kW4BgUvyW+QEWPc1JMpRZA+j876iUIb+zpDHTlT6aUYkA4f/KjHjEihFuWOKPEAbdYN/mUDPWxXNSAz9WnAWAX1tbI4kWe7Jcb09EULfNLSA8tir+9dPRhy3KXINnCBAJhGbqiTKR7Bl7L1hxCxLev2ZbEYYzaB4BrwgtmNN8rGQw7aSoQgIm5TTFuL1AMmJChInBTDR/G64RZcTI7BvfNCfptwSI0S1BJS/ZOnc2s2wxPj3jC+T7EKbXmvH6gMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0Kr5e0fTDOUkLGW5uyGtdM2SN1Iq4/EJcuPrvlBreAY=;
 b=JwBeFzJz6RAXjMMCdIhO2yVdiHlREZohCE+AXAK74Na0godSetwEnQ5LNaU/XEkp/MQvqLmG7MM5BEib9ZPHLrpilap0AMREBFcqvlsnw7XBi1MR1NgMn1L6G7U+My608kDW38rpeOnlv7gfZglqBTQJ/fuR4kE0D4qfruRDP6SShZXcunVES4//nHDy1AD1nHiWtG+9ArIc4x5R2fVTkqSU66uhtIavIr3dGIdtSLsaIhcpbPkvmEcPDf7DOIUhbVbBtnbZzMM+rUUWdslo0BMBogujd9DZg4zzBVrJV5mfgiYz9TnvIsGIP0mZdaUmk2IGg3aeQEZSh1lRpe91XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Kr5e0fTDOUkLGW5uyGtdM2SN1Iq4/EJcuPrvlBreAY=;
 b=vlxziPs5RC1zzr31RGCgz9YZJ9wb2jFNbOURMY+xSvJ4zx8vOgDq2VKzVwL63RQ5xVV12SS+y7giOuC5J9vFMC8vsGiMgoO0daR1sWbbYg7wyBj9bCNVBAxHaFg1Y8qck5n8V+WrzruIMPCUOQozOMgysAvfLcHIQ5glwQvVmWQ=
Received: from MWHPR11CA0006.namprd11.prod.outlook.com (2603:10b6:301:1::16)
 by BL0PR07MB5041.namprd07.prod.outlook.com (2603:10b6:208:47::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Wed, 8 Sep
 2021 12:29:43 +0000
Received: from MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::64) by MWHPR11CA0006.outlook.office365.com
 (2603:10b6:301:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT050.mail.protection.outlook.com (10.13.180.241) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:42 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9W026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:41 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 14:29:33 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:33 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTXju010321;
        Wed, 8 Sep 2021 14:29:33 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTXNf010320;
        Wed, 8 Sep 2021 14:29:33 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY multilink configuration
Date:   Wed, 8 Sep 2021 14:29:28 +0200
Message-ID: <20210908122930.10224-14-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19b53ec2-d35f-4a56-eabe-08d972c455a5
X-MS-TrafficTypeDiagnostic: BL0PR07MB5041:
X-Microsoft-Antispam-PRVS: <BL0PR07MB50419B7C4CFEE5FDB8313B6FC5D49@BL0PR07MB5041.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mop9mYUv9ZE46V8p9M4J/SvP6QzuBlcXOaXdIzN7e5jHmj8Jl7AVs6B2UpIYOOx/ZL+gXrh4FaB4LPZ5yPk9wmWH3TJEKboHAq7YsiwSbXUFx4YJBUbZlBfVqUrvqcmiVNreo903mzqX9sC81W6+IryXdJyP921dIaND0hVAcSNMiKbLdOQp72XKyTkDBVaHrxydu+kVjS4DEbCX3xztdnMBwCJW33xR5hv/O6VME6yqhOdfV5wFZcwuGB2RsYTjozuMoIocE7tP2lUjmAixgC+uGT/p00YN/yBU+EPDr/NDZDko1mgSgydhbJl682LkCM3rt5mA/3fmkez0vkMwSkEb/q5g10f3T7bg9TLDhMRbWCTMMpSB9CJXXrNYF7+RJMGueZXFoRxDp5i+l9yELHDEWD2vSTasWBFeeGEVFtGk+uP8BBpdAT30VpICbBoyqZMfrYOvsY6EjBVg3djEtShDiY/Aya5/eVNIMRSx+ZkrLli5Q2XbxAbeZ4IRjrrPToLcehnGj2dPBb3VnEP3INecWDyWcm4vFL+NI2zRhrAY5CMAijp9Ykd15KA9aFLzVDFOgHo8Mq77AXgpM8sTRdfnl+zKO3gMOOgu2YHv6nvC2S79HOTsKrzL7rGU14CBqnVMw6Wb04D1T0xzYd9wQ1xXpg6BwcZ6hhaYenWUdXvKv5xCh+q1v6SIwC7WYsvlujxAVg+JdOvigeDMQQyhQ+B6xCGVKXijR2giTNS4xEk=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(36092001)(36840700001)(46966006)(82310400003)(42186006)(316002)(4326008)(47076005)(1076003)(36860700001)(478600001)(36906005)(70586007)(86362001)(70206006)(5660300002)(6666004)(8936002)(8676002)(26005)(186003)(82740400003)(30864003)(83380400001)(2906002)(426003)(2616005)(336012)(356005)(54906003)(110136005)(7636003)(36756003)(19627235002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:42.5179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b53ec2-d35f-4a56-eabe-08d972c455a5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT050.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB5041
X-Proofpoint-GUID: OuQFoLvgOdIhvb78e-J_O5YpYqwh0YOY
X-Proofpoint-ORIG-GUID: OuQFoLvgOdIhvb78e-J_O5YpYqwh0YOY
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

Add register sequences for PCIe + QSGMII PHY multilink configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 377 ++++++++++++++++++++++-
 1 file changed, 376 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index fe5b9a2e58df..9e9d26a9259d 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -45,6 +45,9 @@
 #define SIERRA_CMN_REFRCV_PREG				0x98
 #define SIERRA_CMN_REFRCV1_PREG				0xB8
 #define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
+#define SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG		0xCA
+#define SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG		0xD0
+#define SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG	0xE2
 
 #define SIERRA_LANE_CDB_OFFSET(ln, block_offset, reg_offset)	\
 				((0x4000 << (block_offset)) + \
@@ -59,6 +62,9 @@
 #define SIERRA_PSM_A0IN_TMR_PREG			0x009
 #define SIERRA_PSM_A3IN_TMR_PREG			0x00C
 #define SIERRA_PSM_DIAG_PREG				0x015
+#define SIERRA_PSC_LN_A3_PREG				0x023
+#define SIERRA_PSC_LN_A4_PREG				0x024
+#define SIERRA_PSC_LN_IDLE_PREG				0x026
 #define SIERRA_PSC_TX_A0_PREG				0x028
 #define SIERRA_PSC_TX_A1_PREG				0x029
 #define SIERRA_PSC_TX_A2_PREG				0x02A
@@ -68,6 +74,7 @@
 #define SIERRA_PSC_RX_A2_PREG				0x032
 #define SIERRA_PSC_RX_A3_PREG				0x033
 #define SIERRA_PLLCTRL_SUBRATE_PREG			0x03A
+#define SIERRA_PLLCTRL_GEN_A_PREG			0x03B
 #define SIERRA_PLLCTRL_GEN_D_PREG			0x03E
 #define SIERRA_PLLCTRL_CPGAIN_MODE_PREG			0x03F
 #define SIERRA_PLLCTRL_STATUS_PREG			0x044
@@ -150,6 +157,7 @@
 #define SIERRA_CPICAL_TMRVAL_MODE0_PREG			0x171
 #define SIERRA_CPICAL_PICNT_MODE1_PREG			0x174
 #define SIERRA_CPI_OUTBUF_RATESEL_PREG			0x17C
+#define SIERRA_CPI_RESBIAS_BIN_PREG			0x17E
 #define SIERRA_CPI_TRIM_PREG				0x17F
 #define SIERRA_CPICAL_RES_STARTCODE_MODE23_PREG		0x183
 #define SIERRA_EPI_CTRL_PREG				0x187
@@ -272,7 +280,8 @@ static u32 cdns_sierra_pll_mux_table[][SIERRA_NUM_CMN_PLLC_PARENTS] = {
 enum cdns_sierra_phy_type {
 	TYPE_NONE,
 	TYPE_PCIE,
-	TYPE_USB
+	TYPE_USB,
+	TYPE_QSGMII
 };
 
 enum cdns_sierra_ssc_mode {
@@ -807,6 +816,9 @@ static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 	case PHY_TYPE_USB3:
 		inst->phy_type = TYPE_USB;
 		break;
+	case PHY_TYPE_QSGMII:
+		inst->phy_type = TYPE_QSGMII;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1186,6 +1198,9 @@ static int cdns_sierra_phy_configure_multilink(struct cdns_sierra_phy *sp)
 					regmap_write(regmap, reg_pairs[j].off, reg_pairs[j].val);
 			}
 		}
+
+		if (phy_t1 == TYPE_QSGMII)
+			reset_control_deassert(sp->phys[node].lnk_rst);
 	}
 
 	/* Take the PHY out of reset */
@@ -1363,6 +1378,72 @@ static int cdns_sierra_phy_remove(struct platform_device *pdev)
 	return 0;
 }
 
+/* QSGMII PHY PMA lane configuration */
+static struct cdns_reg_pairs qsgmii_phy_pma_ln_regs[] = {
+	{0x9010, SIERRA_PHY_PMA_XCVR_CTRL}
+};
+
+static struct cdns_sierra_vals qsgmii_phy_pma_ln_vals = {
+	.reg_pairs = qsgmii_phy_pma_ln_regs,
+	.num_regs = ARRAY_SIZE(qsgmii_phy_pma_ln_regs),
+};
+
+/* QSGMII refclk 100MHz, 20b, opt1, No BW cal, no ssc, PLL LC1 */
+static const struct cdns_reg_pairs qsgmii_100_no_ssc_plllc1_cmn_regs[] = {
+	{0x2085, SIERRA_CMN_PLLLC1_LF_COEFF_MODE0_PREG},
+	{0x0000, SIERRA_CMN_PLLLC1_BWCAL_MODE0_PREG},
+	{0x0000, SIERRA_CMN_PLLLC1_SS_TIME_STEPSIZE_MODE_PREG}
+};
+
+static const struct cdns_reg_pairs qsgmii_100_no_ssc_plllc1_ln_regs[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x0252, SIERRA_DET_STANDEC_E_PREG},
+	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
+	{0x0FFE, SIERRA_PSC_RX_A0_PREG},
+	{0x0011, SIERRA_PLLCTRL_SUBRATE_PREG},
+	{0x0001, SIERRA_PLLCTRL_GEN_A_PREG},
+	{0x5233, SIERRA_PLLCTRL_CPGAIN_MODE_PREG},
+	{0x0000, SIERRA_DRVCTRL_ATTEN_PREG},
+	{0x0089, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x3C3C, SIERRA_CREQ_CCLKDET_MODE01_PREG},
+	{0x3222, SIERRA_CREQ_FSMCLK_SEL_PREG},
+	{0x0000, SIERRA_CREQ_EQ_CTRL_PREG},
+	{0x8422, SIERRA_CTLELUT_CTRL_PREG},
+	{0x4111, SIERRA_DFE_ECMP_RATESEL_PREG},
+	{0x4111, SIERRA_DFE_SMP_RATESEL_PREG},
+	{0x0002, SIERRA_DEQ_PHALIGN_CTRL},
+	{0x9595, SIERRA_DEQ_VGATUNE_CTRL_PREG},
+	{0x0186, SIERRA_DEQ_GLUT0},
+	{0x0186, SIERRA_DEQ_GLUT1},
+	{0x0186, SIERRA_DEQ_GLUT2},
+	{0x0186, SIERRA_DEQ_GLUT3},
+	{0x0186, SIERRA_DEQ_GLUT4},
+	{0x0861, SIERRA_DEQ_ALUT0},
+	{0x07E0, SIERRA_DEQ_ALUT1},
+	{0x079E, SIERRA_DEQ_ALUT2},
+	{0x071D, SIERRA_DEQ_ALUT3},
+	{0x03F5, SIERRA_DEQ_DFETAP_CTRL_PREG},
+	{0x0C01, SIERRA_DEQ_TAU_CTRL1_FAST_MAINT_PREG},
+	{0x3C40, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
+	{0x1C04, SIERRA_DEQ_TAU_CTRL2_PREG},
+	{0x0033, SIERRA_DEQ_PICTRL_PREG},
+	{0x0660, SIERRA_CPICAL_TMRVAL_MODE0_PREG},
+	{0x00D5, SIERRA_CPI_OUTBUF_RATESEL_PREG},
+	{0x0B6D, SIERRA_CPI_RESBIAS_BIN_PREG},
+	{0x0102, SIERRA_RXBUFFER_CTLECTRL_PREG},
+	{0x0002, SIERRA_RXBUFFER_RCDFECTRL_PREG}
+};
+
+static struct cdns_sierra_vals qsgmii_100_no_ssc_plllc1_cmn_vals = {
+	.reg_pairs = qsgmii_100_no_ssc_plllc1_cmn_regs,
+	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_plllc1_cmn_regs),
+};
+
+static struct cdns_sierra_vals qsgmii_100_no_ssc_plllc1_ln_vals = {
+	.reg_pairs = qsgmii_100_no_ssc_plllc1_ln_regs,
+	.num_regs = ARRAY_SIZE(qsgmii_100_no_ssc_plllc1_ln_regs),
+};
+
 /* PCIE PHY PCS common configuration */
 static struct cdns_reg_pairs pcie_phy_pcs_cmn_regs[] = {
 	{0x0430, SIERRA_PHY_PIPE_CMN_CTRL1}
@@ -1373,6 +1454,233 @@ static struct cdns_sierra_vals pcie_phy_pcs_cmn_vals = {
 	.num_regs = ARRAY_SIZE(pcie_phy_pcs_cmn_regs),
 };
 
+/* refclk100MHz_32b_PCIe_cmn_pll_no_ssc, pcie_links_using_plllc, pipe_bw_3 */
+static const struct cdns_reg_pairs pcie_100_no_ssc_plllc_cmn_regs[] = {
+	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
+	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG}
+};
+
+/*
+ * refclk100MHz_32b_PCIe_ln_no_ssc, multilink, using_plllc,
+ * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz
+ */
+static const struct cdns_reg_pairs ml_pcie_100_no_ssc_ln_regs[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
+	{0x0004, SIERRA_PSC_LN_A3_PREG},
+	{0x0004, SIERRA_PSC_LN_A4_PREG},
+	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
+	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
+	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
+	{0x8055, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
+	{0x80BB, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
+	{0x8351, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
+	{0x8349, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
+	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
+	{0x5624, SIERRA_DEQ_CONCUR_CTRL2_PREG},
+	{0x000F, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
+	{0x00FF, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
+	{0x4C4C, SIERRA_DEQ_ERRCMP_CTRL_PREG},
+	{0x02FA, SIERRA_DEQ_OFFSET_CTRL_PREG},
+	{0x02FA, SIERRA_DEQ_GAIN_CTRL_PREG},
+	{0x0041, SIERRA_DEQ_GLUT0},
+	{0x0082, SIERRA_DEQ_GLUT1},
+	{0x00C3, SIERRA_DEQ_GLUT2},
+	{0x0145, SIERRA_DEQ_GLUT3},
+	{0x0186, SIERRA_DEQ_GLUT4},
+	{0x09E7, SIERRA_DEQ_ALUT0},
+	{0x09A6, SIERRA_DEQ_ALUT1},
+	{0x0965, SIERRA_DEQ_ALUT2},
+	{0x08E3, SIERRA_DEQ_ALUT3},
+	{0x00FA, SIERRA_DEQ_DFETAP0},
+	{0x00FA, SIERRA_DEQ_DFETAP1},
+	{0x00FA, SIERRA_DEQ_DFETAP2},
+	{0x00FA, SIERRA_DEQ_DFETAP3},
+	{0x00FA, SIERRA_DEQ_DFETAP4},
+	{0x000F, SIERRA_DEQ_PRECUR_PREG},
+	{0x0280, SIERRA_DEQ_POSTCUR_PREG},
+	{0x8F00, SIERRA_DEQ_POSTCUR_DECR_PREG},
+	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
+	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
+	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
+	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x002B, SIERRA_CPI_TRIM_PREG},
+	{0x0003, SIERRA_EPI_CTRL_PREG},
+	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
+	{0x0004, SIERRA_RXBUFFER_CTLECTRL_PREG},
+	{0x2010, SIERRA_RXBUFFER_RCDFECTRL_PREG},
+	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
+};
+
+static struct cdns_sierra_vals pcie_100_no_ssc_plllc_cmn_vals = {
+	.reg_pairs = pcie_100_no_ssc_plllc_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_100_no_ssc_plllc_cmn_regs),
+};
+
+static struct cdns_sierra_vals ml_pcie_100_no_ssc_ln_vals = {
+	.reg_pairs = ml_pcie_100_no_ssc_ln_regs,
+	.num_regs = ARRAY_SIZE(ml_pcie_100_no_ssc_ln_regs),
+};
+
+/* refclk100MHz_32b_PCIe_cmn_pll_int_ssc, pcie_links_using_plllc, pipe_bw_3 */
+static const struct cdns_reg_pairs pcie_100_int_ssc_plllc_cmn_regs[] = {
+	{0x000E, SIERRA_CMN_PLLLC_MODE_PREG},
+	{0x4006, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
+	{0x4006, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
+	{0x0000, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
+	{0x0000, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG},
+	{0x0581, SIERRA_CMN_PLLLC_DSMCORR_PREG},
+	{0x7F80, SIERRA_CMN_PLLLC_SS_PREG},
+	{0x0041, SIERRA_CMN_PLLLC_SS_AMP_STEP_SIZE_PREG},
+	{0x0464, SIERRA_CMN_PLLLC_SSTWOPT_PREG},
+	{0x0D0D, SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG},
+	{0x0060, SIERRA_CMN_PLLLC_LOCK_DELAY_CTRL_PREG}
+};
+
+/*
+ * refclk100MHz_32b_PCIe_ln_int_ssc, multilink, using_plllc,
+ * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz
+ */
+static const struct cdns_reg_pairs ml_pcie_100_int_ssc_ln_regs[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
+	{0x0004, SIERRA_PSC_LN_A3_PREG},
+	{0x0004, SIERRA_PSC_LN_A4_PREG},
+	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
+	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
+	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
+	{0x813E, SIERRA_CLKPATHCTRL_TMR_PREG},
+	{0x8047, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
+	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
+	{0x033C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
+	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG},
+	{0x5624, SIERRA_DEQ_CONCUR_CTRL2_PREG},
+	{0x000F, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
+	{0x00FF, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
+	{0x4C4C, SIERRA_DEQ_ERRCMP_CTRL_PREG},
+	{0x02FA, SIERRA_DEQ_OFFSET_CTRL_PREG},
+	{0x02FA, SIERRA_DEQ_GAIN_CTRL_PREG},
+	{0x0041, SIERRA_DEQ_GLUT0},
+	{0x0082, SIERRA_DEQ_GLUT1},
+	{0x00C3, SIERRA_DEQ_GLUT2},
+	{0x0145, SIERRA_DEQ_GLUT3},
+	{0x0186, SIERRA_DEQ_GLUT4},
+	{0x09E7, SIERRA_DEQ_ALUT0},
+	{0x09A6, SIERRA_DEQ_ALUT1},
+	{0x0965, SIERRA_DEQ_ALUT2},
+	{0x08E3, SIERRA_DEQ_ALUT3},
+	{0x00FA, SIERRA_DEQ_DFETAP0},
+	{0x00FA, SIERRA_DEQ_DFETAP1},
+	{0x00FA, SIERRA_DEQ_DFETAP2},
+	{0x00FA, SIERRA_DEQ_DFETAP3},
+	{0x00FA, SIERRA_DEQ_DFETAP4},
+	{0x000F, SIERRA_DEQ_PRECUR_PREG},
+	{0x0280, SIERRA_DEQ_POSTCUR_PREG},
+	{0x8F00, SIERRA_DEQ_POSTCUR_DECR_PREG},
+	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
+	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
+	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
+	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x002B, SIERRA_CPI_TRIM_PREG},
+	{0x0003, SIERRA_EPI_CTRL_PREG},
+	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
+	{0x0004, SIERRA_RXBUFFER_CTLECTRL_PREG},
+	{0x2010, SIERRA_RXBUFFER_RCDFECTRL_PREG},
+	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
+};
+
+static struct cdns_sierra_vals pcie_100_int_ssc_plllc_cmn_vals = {
+	.reg_pairs = pcie_100_int_ssc_plllc_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_100_int_ssc_plllc_cmn_regs),
+};
+
+static struct cdns_sierra_vals ml_pcie_100_int_ssc_ln_vals = {
+	.reg_pairs = ml_pcie_100_int_ssc_ln_regs,
+	.num_regs = ARRAY_SIZE(ml_pcie_100_int_ssc_ln_regs),
+};
+
+/* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc, pcie_links_using_plllc, pipe_bw_3 */
+static const struct cdns_reg_pairs pcie_100_ext_ssc_plllc_cmn_regs[] = {
+	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
+	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG},
+	{0x1B1B, SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG}
+};
+
+/*
+ * refclk100MHz_32b_PCIe_ln_ext_ssc, multilink, using_plllc,
+ * cmn_pllcy_anaclk0_1Ghz, xcvr_pllclk_fullrt_500mhz
+ */
+static const struct cdns_reg_pairs ml_pcie_100_ext_ssc_ln_regs[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
+	{0x0004, SIERRA_PSC_LN_A3_PREG},
+	{0x0004, SIERRA_PSC_LN_A4_PREG},
+	{0x0004, SIERRA_PSC_LN_IDLE_PREG},
+	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
+	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
+	{0x813E, SIERRA_CLKPATHCTRL_TMR_PREG},
+	{0x8047, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
+	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
+	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
+	{0x033C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
+	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG},
+	{0x5624, SIERRA_DEQ_CONCUR_CTRL2_PREG},
+	{0x000F, SIERRA_DEQ_EPIPWR_CTRL2_PREG},
+	{0x00FF, SIERRA_DEQ_FAST_MAINT_CYCLES_PREG},
+	{0x4C4C, SIERRA_DEQ_ERRCMP_CTRL_PREG},
+	{0x02FA, SIERRA_DEQ_OFFSET_CTRL_PREG},
+	{0x02FA, SIERRA_DEQ_GAIN_CTRL_PREG},
+	{0x0041, SIERRA_DEQ_GLUT0},
+	{0x0082, SIERRA_DEQ_GLUT1},
+	{0x00C3, SIERRA_DEQ_GLUT2},
+	{0x0145, SIERRA_DEQ_GLUT3},
+	{0x0186, SIERRA_DEQ_GLUT4},
+	{0x09E7, SIERRA_DEQ_ALUT0},
+	{0x09A6, SIERRA_DEQ_ALUT1},
+	{0x0965, SIERRA_DEQ_ALUT2},
+	{0x08E3, SIERRA_DEQ_ALUT3},
+	{0x00FA, SIERRA_DEQ_DFETAP0},
+	{0x00FA, SIERRA_DEQ_DFETAP1},
+	{0x00FA, SIERRA_DEQ_DFETAP2},
+	{0x00FA, SIERRA_DEQ_DFETAP3},
+	{0x00FA, SIERRA_DEQ_DFETAP4},
+	{0x000F, SIERRA_DEQ_PRECUR_PREG},
+	{0x0280, SIERRA_DEQ_POSTCUR_PREG},
+	{0x8F00, SIERRA_DEQ_POSTCUR_DECR_PREG},
+	{0x3C0F, SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG},
+	{0x1C0C, SIERRA_DEQ_TAU_CTRL2_PREG},
+	{0x0100, SIERRA_DEQ_TAU_CTRL3_PREG},
+	{0x5E82, SIERRA_DEQ_OPENEYE_CTRL_PREG},
+	{0x002B, SIERRA_CPI_TRIM_PREG},
+	{0x0003, SIERRA_EPI_CTRL_PREG},
+	{0x803F, SIERRA_SDFILT_H2L_A_PREG},
+	{0x0004, SIERRA_RXBUFFER_CTLECTRL_PREG},
+	{0x2010, SIERRA_RXBUFFER_RCDFECTRL_PREG},
+	{0x4432, SIERRA_RXBUFFER_DFECTRL_PREG}
+};
+
+static struct cdns_sierra_vals pcie_100_ext_ssc_plllc_cmn_vals = {
+	.reg_pairs = pcie_100_ext_ssc_plllc_cmn_regs,
+	.num_regs = ARRAY_SIZE(pcie_100_ext_ssc_plllc_cmn_regs),
+};
+
+static struct cdns_sierra_vals ml_pcie_100_ext_ssc_ln_vals = {
+	.reg_pairs = ml_pcie_100_ext_ssc_ln_regs,
+	.num_regs = ARRAY_SIZE(ml_pcie_100_ext_ssc_ln_regs),
+};
+
 /* refclk100MHz_32b_PCIe_cmn_pll_no_ssc */
 static const struct cdns_reg_pairs cdns_pcie_cmn_regs_no_ssc[] = {
 	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
@@ -1710,6 +2018,11 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
 		},
 	},
 	.pma_cmn_vals = {
@@ -1719,12 +2032,24 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_plllc_cmn_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
 			},
 		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
+			},
+		},
 	},
 	.pma_ln_vals = {
 		[TYPE_PCIE] = {
@@ -1733,12 +2058,24 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &ml_pcie_100_no_ssc_ln_vals,
+				[EXTERNAL_SSC] = &ml_pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &ml_pcie_100_int_ssc_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
 			},
 		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
+			},
+		},
 	},
 };
 
@@ -1753,6 +2090,20 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+			},
+		},
+	},
+	.phy_pma_ln_vals = {
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_phy_pma_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_phy_pma_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_phy_pma_ln_vals,
+			},
 		},
 	},
 	.pma_cmn_vals = {
@@ -1762,12 +2113,24 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &pcie_100_no_ssc_plllc_cmn_vals,
+				[EXTERNAL_SSC] = &pcie_100_ext_ssc_plllc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_plllc_cmn_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_cmn_vals,
 			},
 		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_cmn_vals,
+			},
+		},
 	},
 	.pma_ln_vals = {
 		[TYPE_PCIE] = {
@@ -1776,12 +2139,24 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
 				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
+			[TYPE_QSGMII] = {
+				[NO_SSC] = &ml_pcie_100_no_ssc_ln_vals,
+				[EXTERNAL_SSC] = &ml_pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &ml_pcie_100_int_ssc_ln_vals,
+			},
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
 				[EXTERNAL_SSC] = &usb_100_ext_ssc_ln_vals,
 			},
 		},
+		[TYPE_QSGMII] = {
+			[TYPE_PCIE] = {
+				[NO_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
+				[EXTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
+				[INTERNAL_SSC] = &qsgmii_100_no_ssc_plllc1_ln_vals,
+			},
+		},
 	},
 };
 
-- 
2.26.1

