Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CCA437B62
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbhJVRF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:05:58 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:20484 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232149AbhJVRFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:24 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEhEBm008220;
        Fri, 22 Oct 2021 10:02:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=nHHG/fd1y/NzmY3x+TySyrEp6IBfQ+q7aMkuogKt180=;
 b=k7SXzNlV/ca4V7zxAFyfZYvHGXnWIS9CVZ3zzERNEwgRPrI1pszy8oA46piiNbZjHd2M
 dKmrbAetxnJEdMHahQNtj1GIyjQFPvuajZHvtzO0IlHvO2a2LLCls4UToEG3oE8y7zto
 AKO2N9bl2mbd8/0eLRPKyCvqkbd0LYoFp1S2JXL7dZh4Gt9yYtenCKzM+U0ckXYHdCfY
 HtqM8l8c9bKNURx/w7MK3tTVH1hfb7D5wLQZvCtKuzlyaLM25ZfNJbf7WVnSB/nt4bQU
 /fBub2Jfz2LZ/3TjE+SOWdc1HetZLNG6T0GoEqNMTa4pdLiNLmQ0fDA9gErQ5iTDofWZ Eg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3buxg0rm4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNioj8bpCMWC/bpeB1xqIK+HvNUrjNr1yudgtVUavCsS6XF3hcUewD0QqnFnyIx3RMLFnm2PelJhL5a4SsXVWLy4qBwOKAoIx7ueUmUI+J/CxZafO6MftaigUGdiZFEdmv2uk2+CN+yxGATfCAbme2cZey/7MijcyP6IoHdFKQhGHLqa+07j3lE4Htc8PQVbKuy5iebWd9ibuustHbFPUjupjGMalUWPHkeK1hG4P1ClBEVrcQln/UJqBzMCSws5I7gKa+EVYaD2mGoyE9sA2rbHerpduT7cbdV3ccxNhLXCk9gBxmZNcVtbcgtnGGudCFpyxtav01o5bRhcrZydqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHHG/fd1y/NzmY3x+TySyrEp6IBfQ+q7aMkuogKt180=;
 b=Z6nb1cJQW7s2puWMB+BOPO/GNO3taXB1ufLZo3tpf95vunXQepO3q/PrSyaxZBFcIcE8zsImQNeq/WjSySIgwMrqtb+NXsr22OyJxGdPaGikBdvoNnVkC9Rt1nfNi+39I2LUE9E3YAYhfmtLGGSoiwLbx3QgpEZih8OZWjO9vkFOK0PBE2dVGL0/r6HwQwvdQFSBFSCxTiLEPZ+V+6o5eyuNkOjwBRtH4DqBb/sMJxPu4Y25k3CrJKF+MifpVBdahYgBNrRfYhfaMu2t577PnuT7ABJiuemsBfiVlDBUJb0gXxIQyNtqOYx4FUbMfBRbZ5JnFNpq680B/hFaOnqIeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHHG/fd1y/NzmY3x+TySyrEp6IBfQ+q7aMkuogKt180=;
 b=FP1/z5TsGu0DkPp3HDnbpolzp3osAR3K2s+M4yEZv/Z8YRMFGo/16SLiVGqubop000JeVVGBEjx4uFLkTOgCdqDdttE18BNC5KbLbaTWER6GG/4i0USo7WjDWO0NI7YOALyxENNy/n0ySx7JAw2YmQVwmvjq2PRZHyHFsrcBue4=
Received: from MW4PR04CA0056.namprd04.prod.outlook.com (2603:10b6:303:6a::31)
 by MWHPR07MB2863.namprd07.prod.outlook.com (2603:10b6:300:1d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 22 Oct
 2021 17:02:53 +0000
Received: from MW2NAM12FT018.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::5d) by MW4PR04CA0056.outlook.office365.com
 (2603:10b6:303:6a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT018.mail.protection.outlook.com (10.13.180.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:53 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNQ008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:53 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2dDG018941;
        Fri, 22 Oct 2021 19:02:39 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2dcA018940;
        Fri, 22 Oct 2021 19:02:39 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 13/15] phy: cadence: Sierra: Add PCIe + QSGMII PHY multilink configuration
Date:   Fri, 22 Oct 2021 19:02:34 +0200
Message-ID: <20211022170236.18839-14-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eed43351-4f20-4a1f-c3ee-08d9957dc9ad
X-MS-TrafficTypeDiagnostic: MWHPR07MB2863:
X-Microsoft-Antispam-PRVS: <MWHPR07MB2863674D3766E3FF832E637DC5809@MWHPR07MB2863.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDtWMBSPuUI/yYYiJwKmglGVwvyQoHNtwfB0ax05/0RO2YuF6VP0kB5VJaM+YteBvQ5rq0g7vwVVLC/8fw546dhtCdaTIfKmW1RCY5jpkMxO4n1LwC+XDlN+51Lbhr1LDiQKAiE062KWZ5vZ62ZlP+vnb5Oy8DsbaxI8NH8j79Np2u3Y5smGBBJWh42TPcnOqmr9c8LBTTepmirGFK/HqCtkYESSlKdlMxDQPf1gCQZJt7eoWKINJlH8UBPoXaL/DAxgl8y+OXsNu2RVsNV8XWpGotPjv/16Hhe03MGhPtazI7WDsDuByTTP4xIaR+/+pouUZG+QFkoKxzaxWAAv3E4xLBGLWIMZkcDhyHQEBlLgmqJsbC+NUZnNoSvsS8o/KFrCy3/WWgz7W2jyoQKa7B0e3qwD8b0rKRsxNi06h0dZ82Rbv+LxOd4StEPeEJIVZmtv5ziejeeFDwmx98t+C4rUSMaIGRcqJLrmtk5gWTJKMJjMzHaYCCYTvSQ2qAAGlpR4gZwETvF9nXTRh+96kRVxf/cIXeQDxKfd7CYM81AfB4y+rBotYDnzn30zaTSyJ5DPJxmQHUw98s0Tk/nCGzrX27hrjr1993rbJSZ5evDTfiO/SifICdcwERF12ayktigijUg22QSV8ILA33wryGxeGETuTjVJeLYIUOx9nCJh/5Ma2PpCkXbZp+qy5FHi0CHLjeCJFgpcoZbxYIzXb00mz+USVt0bpUJoXSmTP0s=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(8676002)(110136005)(19627235002)(2616005)(70586007)(508600001)(5660300002)(1076003)(186003)(54906003)(336012)(26005)(356005)(426003)(86362001)(316002)(7636003)(4326008)(83380400001)(70206006)(6666004)(36906005)(36860700001)(82310400003)(47076005)(2906002)(8936002)(30864003)(36756003)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:53.6075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eed43351-4f20-4a1f-c3ee-08d9957dc9ad
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT018.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB2863
X-Proofpoint-GUID: YDA8NTvrDp6QnGz8AWO8LldhFnnB7PJM
X-Proofpoint-ORIG-GUID: YDA8NTvrDp6QnGz8AWO8LldhFnnB7PJM
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

Add register sequences for PCIe + QSGMII PHY multilink configuration.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 377 ++++++++++++++++++++++-
 1 file changed, 376 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index a39be67424a1..0deb627845b1 100644
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

