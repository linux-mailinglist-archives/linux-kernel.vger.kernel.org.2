Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1FA44039E8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351475AbhIHMcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:32:10 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:20166 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349303AbhIHMbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:06 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886dhab030393;
        Wed, 8 Sep 2021 05:29:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=4p4ewXSAbTo7clJ5MIUI4D882km/tnayrAuocFraYJ8=;
 b=muYqYaYL+SrpagmMxdyGxbaDd+xqI31ENnLMZUbNqikJk8WXHhpRJ/mSgvQqPIh4CF75
 9Dfnv7wSKsks3AovrefhMQHr6M5oqFGGBJt9BXNHd5huUkwmH2Bg6GzG79VRPLTb4XNo
 kZAUZAXuz4vTFb0JLEDZ6mdjoGv7ftj9wdSCKG4La/Dfj1xhgB/R95oDHta28CwPzX3Z
 2NzK5ppZ43XaDFC3LUzDW7USxGO4swCCwSNaU+iJt+yCgE4d4j6wvqdNVF0ic6K0sDfE
 MNbOUNn6hR5r30voCgX0Hc/xvpqLZkmvGiXMyNng+evVR2VnjZkEgFnurJ9ayl7tzySS Iw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3axcn5b0xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrScdwVF552v/zdXxwKemBsjSSJ6988OaxUrtereJeEcgm7UW0MYGYCgTbHYG48vE7YKH0FVYO3EmaK+MJSm91UMj+RtEvBwdVbwAnWmwcioMC9VxdjSZnFqcHB+ENbOuFpJI4jqLE3RD8yx28r/xFGb4fu0606eksae7eghqfNjmd0xpPpD64PDLJbVmAEbNi4bOfW3okaUvT6ByAmhRHmZD90YP7KaNwv7EfH0X4SgJU17hoHZN3T+dG1DQKh1BlK8a1zKqbgzPDQ0nuKD4Q516xt1Qa1kSwkxYe1TvIyz2u3TA/uun/kzEP8WssqEdpMT6LCcQK5rvERNg0azFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=4p4ewXSAbTo7clJ5MIUI4D882km/tnayrAuocFraYJ8=;
 b=h6bL++CQYOolkRlR3UZZnK3O6wXTBT+DvXzu+f75Cb+gaNEeAqC1resVjHrBWBToK3QYHy27pBcD3A8sFd2vfMuDiPe6BvHp2IYLexhpjGQ9G5CHd0F8HAa0AfEYkn7JhKNkTR6rWct7unnviatC7pF0I3Ad3ObKE2wYGO5VEvzojDaMmcle2XOHSPIIUDNl+T20IyVmlda7Kfg88omso/MkPZ+CEE6t+h/c4QKBUydVu2Qt1aC5HpbrpO8SXArRm7S7lhc1v//ZAGwl2XVrIM6BMEOFF9M7gH6J8rZrs578Ey/CrjBAikZfNq2a9PnWzOrnTHyJFzt61bskUWM05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4p4ewXSAbTo7clJ5MIUI4D882km/tnayrAuocFraYJ8=;
 b=ykCY+AwrGFnJ4mFGfXn7ydFS1JMia2IB68W5pmQlhKnXnRkCGBjyJU1xUdr2JV8y8DkCaDNpZLm4hEmx5aB89hNJYv7FkcZb0rxhr0GdfJjcahFex6w5cEkYaJzIJfgTmZkf1Cn98S7DWjwn94BM6S0RgsmPQ5sR+FmahJwO2RM=
Received: from MW4PR03CA0332.namprd03.prod.outlook.com (2603:10b6:303:dc::7)
 by MN2PR07MB6143.namprd07.prod.outlook.com (2603:10b6:208:10e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.24; Wed, 8 Sep
 2021 12:29:42 +0000
Received: from MW2NAM12FT046.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::31) by MW4PR03CA0332.outlook.office365.com
 (2603:10b6:303:dc::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT046.mail.protection.outlook.com (10.13.181.244) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:41 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9U026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:40 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 14:29:33 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 8 Sep 2021 14:29:33 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:33 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTXOZ010309;
        Wed, 8 Sep 2021 14:29:33 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTXtE010308;
        Wed, 8 Sep 2021 14:29:33 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 10/15] phy: cadence: Sierra: Update single link PCIe register configuration
Date:   Wed, 8 Sep 2021 14:29:25 +0200
Message-ID: <20210908122930.10224-11-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38ad75dd-f437-4e67-c4ab-08d972c45520
X-MS-TrafficTypeDiagnostic: MN2PR07MB6143:
X-Microsoft-Antispam-PRVS: <MN2PR07MB61438A52CC25A6A7D9D3D36CC5D49@MN2PR07MB6143.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7Y1P31ZvxQYeNAZKs+8qPqPBAF8m3m8uY+zfy15TbCN/DwowReuQxXvvlkThgWIVFxDN9Uirfueu0CWimS8v7hRmOIgmPSu09rx3yvQWSQt5f3/C3oYnH+EAhU9V9LO7udLYFGPTxRHo2YKDzWPWkVTMfjoy3Tv8rezTkhwq5FqIY8xNGr8w3BlSTsQjpkr5eUB4K8DETAB8jMsRetNf+a/d49aU02PXzMB0QrhEo2WENxbh7G7C1vkILBQkT2UryGLYYUpfBVzbMYEFozlp/dbRNB2KQyErLwkpj6WDcbQWANw6qdGkX2blW/oP/bxAhshqAQTPAJSBINpHaUM1qlpckVRBhhtsUINMsKX+zZUUqTH8XzZKHSQYBrxEk0jW1xoHKUChYi8RWpHNc6CFEDA7Tev1DxnG+WvmAAcPwxiemV8PlFngk2Hia6QcyB0jfbRH/is/5uClL+02Ef++cYw+rg8t9zGmoDfUgzA+S+NiftNbbHsQrwHZ6KPdbC38rjtJmNY4UUs4bFrknfFmpLponG6ME8SdPHCx3dyZYN10/GUe1BbYtZJzfm6Hrk6rzUPJOjA9Nvn54XBS57SQbCIT4fyhxevDBWKZH39lgNNA6RQEw1EvUiEHW92GzE3/Sn2P3g+IHdnQWnThCxbFX/l5V0kh9jZjS16hm05dBCXU6IG3Q2SNDVrNuL9z2+DN6fNlNhBvxIdffK82WJSl1o+oplBYwFbgRdUt1sh+6CE=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36092001)(36840700001)(46966006)(70586007)(86362001)(4326008)(2616005)(7636003)(356005)(82310400003)(426003)(336012)(110136005)(36756003)(47076005)(186003)(2906002)(1076003)(26005)(8676002)(82740400003)(83380400001)(54906003)(6666004)(8936002)(478600001)(19627235002)(316002)(30864003)(5660300002)(42186006)(70206006)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:41.6463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ad75dd-f437-4e67-c4ab-08d972c45520
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT046.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB6143
X-Proofpoint-ORIG-GUID: MJrzVxpeilNii3dFtl1IY0anXmHK7DCW
X-Proofpoint-GUID: MJrzVxpeilNii3dFtl1IY0anXmHK7DCW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add single link PCIe register configurations for no SSC and internal
SSC. Also, add missing PMA lane registers for external SSC.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 214 ++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index e84dfd8f168e..83dc025d77a8 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -36,7 +36,12 @@
 #define SIERRA_CMN_PLLLC_LOCK_CNTSTART_PREG		0x4B
 #define SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG		0x4F
 #define SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG		0x50
+#define SIERRA_CMN_PLLLC_DSMCORR_PREG			0x51
+#define SIERRA_CMN_PLLLC_SS_PREG			0x52
+#define SIERRA_CMN_PLLLC_SS_AMP_STEP_SIZE_PREG		0x53
+#define SIERRA_CMN_PLLLC_SSTWOPT_PREG			0x54
 #define SIERRA_CMN_PLLLC_SS_TIME_STEPSIZE_MODE_PREG	0x62
+#define SIERRA_CMN_PLLLC_LOCK_DELAY_CTRL_PREG		0x63
 #define SIERRA_CMN_REFRCV_PREG				0x98
 #define SIERRA_CMN_REFRCV1_PREG				0xB8
 #define SIERRA_CMN_PLLLC1_GEN_PREG			0xC2
@@ -52,6 +57,7 @@
 #define SIERRA_DET_STANDEC_E_PREG			0x004
 #define SIERRA_PSM_LANECAL_DLY_A1_RESETS_PREG		0x008
 #define SIERRA_PSM_A0IN_TMR_PREG			0x009
+#define SIERRA_PSM_A3IN_TMR_PREG			0x00C
 #define SIERRA_PSM_DIAG_PREG				0x015
 #define SIERRA_PSC_TX_A0_PREG				0x028
 #define SIERRA_PSC_TX_A1_PREG				0x029
@@ -68,12 +74,15 @@
 #define SIERRA_CLKPATH_BIASTRIM_PREG			0x04B
 #define SIERRA_DFE_BIASTRIM_PREG			0x04C
 #define SIERRA_DRVCTRL_ATTEN_PREG			0x06A
+#define SIERRA_DRVCTRL_BOOST_PREG			0x06F
 #define SIERRA_CLKPATHCTRL_TMR_PREG			0x081
 #define SIERRA_RX_CREQ_FLTR_A_MODE3_PREG		0x085
 #define SIERRA_RX_CREQ_FLTR_A_MODE2_PREG		0x086
 #define SIERRA_RX_CREQ_FLTR_A_MODE1_PREG		0x087
 #define SIERRA_RX_CREQ_FLTR_A_MODE0_PREG		0x088
+#define SIERRA_CREQ_DCBIASATTEN_OVR_PREG		0x08C
 #define SIERRA_CREQ_CCLKDET_MODE01_PREG			0x08E
+#define SIERRA_RX_CTLE_CAL_PREG				0x08F
 #define SIERRA_RX_CTLE_MAINTENANCE_PREG			0x091
 #define SIERRA_CREQ_FSMCLK_SEL_PREG			0x092
 #define SIERRA_CREQ_EQ_CTRL_PREG			0x093
@@ -123,15 +132,27 @@
 #define SIERRA_DEQ_ALUT12				0x114
 #define SIERRA_DEQ_ALUT13				0x115
 #define SIERRA_DEQ_DFETAP_CTRL_PREG			0x128
+#define SIERRA_DEQ_DFETAP0				0x129
+#define SIERRA_DEQ_DFETAP1				0x12B
+#define SIERRA_DEQ_DFETAP2				0x12D
+#define SIERRA_DEQ_DFETAP3				0x12F
+#define SIERRA_DEQ_DFETAP4				0x131
 #define SIERRA_DFE_EN_1010_IGNORE_PREG			0x134
+#define SIERRA_DEQ_PRECUR_PREG				0x138
+#define SIERRA_DEQ_POSTCUR_PREG				0x140
+#define SIERRA_DEQ_POSTCUR_DECR_PREG			0x142
 #define SIERRA_DEQ_TAU_CTRL1_SLOW_MAINT_PREG		0x150
 #define SIERRA_DEQ_TAU_CTRL2_PREG			0x151
+#define SIERRA_DEQ_TAU_CTRL3_PREG			0x152
+#define SIERRA_DEQ_OPENEYE_CTRL_PREG			0x158
 #define SIERRA_DEQ_PICTRL_PREG				0x161
 #define SIERRA_CPICAL_TMRVAL_MODE1_PREG			0x170
 #define SIERRA_CPICAL_TMRVAL_MODE0_PREG			0x171
 #define SIERRA_CPICAL_PICNT_MODE1_PREG			0x174
 #define SIERRA_CPI_OUTBUF_RATESEL_PREG			0x17C
+#define SIERRA_CPI_TRIM_PREG				0x17F
 #define SIERRA_CPICAL_RES_STARTCODE_MODE23_PREG		0x183
+#define SIERRA_EPI_CTRL_PREG				0x187
 #define SIERRA_LFPSDET_SUPPORT_PREG			0x188
 #define SIERRA_LFPSFILT_NS_PREG				0x18A
 #define SIERRA_LFPSFILT_RD_PREG				0x18B
@@ -1162,6 +1183,146 @@ static struct cdns_sierra_vals pcie_phy_pcs_cmn_vals = {
 	.num_regs = ARRAY_SIZE(pcie_phy_pcs_cmn_regs),
 };
 
+/* refclk100MHz_32b_PCIe_cmn_pll_no_ssc */
+static const struct cdns_reg_pairs cdns_pcie_cmn_regs_no_ssc[] = {
+	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
+	{0x2105, SIERRA_CMN_PLLLC_LF_COEFF_MODE0_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE1_PREG},
+	{0x8A06, SIERRA_CMN_PLLLC_BWCAL_MODE0_PREG}
+};
+
+/* refclk100MHz_32b_PCIe_ln_no_ssc */
+static const struct cdns_reg_pairs cdns_pcie_ln_regs_no_ssc[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
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
+static struct cdns_sierra_vals pcie_100_no_ssc_cmn_vals = {
+	.reg_pairs = cdns_pcie_cmn_regs_no_ssc,
+	.num_regs = ARRAY_SIZE(cdns_pcie_cmn_regs_no_ssc),
+};
+
+static struct cdns_sierra_vals pcie_100_no_ssc_ln_vals = {
+	.reg_pairs = cdns_pcie_ln_regs_no_ssc,
+	.num_regs = ARRAY_SIZE(cdns_pcie_ln_regs_no_ssc),
+};
+
+/* refclk100MHz_32b_PCIe_cmn_pll_int_ssc */
+static const struct cdns_reg_pairs cdns_pcie_cmn_regs_int_ssc[] = {
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
+/* refclk100MHz_32b_PCIe_ln_int_ssc */
+static const struct cdns_reg_pairs cdns_pcie_ln_regs_int_ssc[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
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
+static struct cdns_sierra_vals pcie_100_int_ssc_cmn_vals = {
+	.reg_pairs = cdns_pcie_cmn_regs_int_ssc,
+	.num_regs = ARRAY_SIZE(cdns_pcie_cmn_regs_int_ssc),
+};
+
+static struct cdns_sierra_vals pcie_100_int_ssc_ln_vals = {
+	.reg_pairs = cdns_pcie_ln_regs_int_ssc,
+	.num_regs = ARRAY_SIZE(cdns_pcie_ln_regs_int_ssc),
+};
+
 /* refclk100MHz_32b_PCIe_cmn_pll_ext_ssc */
 static const struct cdns_reg_pairs cdns_pcie_cmn_regs_ext_ssc[] = {
 	{0x2106, SIERRA_CMN_PLLLC_LF_COEFF_MODE1_PREG},
@@ -1173,13 +1334,52 @@ static const struct cdns_reg_pairs cdns_pcie_cmn_regs_ext_ssc[] = {
 
 /* refclk100MHz_32b_PCIe_ln_ext_ssc */
 static const struct cdns_reg_pairs cdns_pcie_ln_regs_ext_ssc[] = {
+	{0xFC08, SIERRA_DET_STANDEC_A_PREG},
+	{0x001D, SIERRA_PSM_A3IN_TMR_PREG},
+	{0x1555, SIERRA_DFE_BIASTRIM_PREG},
+	{0x9703, SIERRA_DRVCTRL_BOOST_PREG},
 	{0x813E, SIERRA_CLKPATHCTRL_TMR_PREG},
 	{0x8047, SIERRA_RX_CREQ_FLTR_A_MODE3_PREG},
 	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE2_PREG},
 	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE1_PREG},
 	{0x808F, SIERRA_RX_CREQ_FLTR_A_MODE0_PREG},
+	{0x0002, SIERRA_CREQ_DCBIASATTEN_OVR_PREG},
+	{0x9800, SIERRA_RX_CTLE_CAL_PREG},
 	{0x033C, SIERRA_RX_CTLE_MAINTENANCE_PREG},
-	{0x44CC, SIERRA_CREQ_EQ_OPEN_EYE_THRESH_PREG}
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
 };
 
 static struct cdns_sierra_vals pcie_100_ext_ssc_cmn_vals = {
@@ -1316,14 +1516,18 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 	.pcs_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 			},
 		},
 	},
 	.pma_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
 		},
 		[TYPE_USB] = {
@@ -1335,7 +1539,9 @@ static const struct cdns_sierra_data cdns_map_sierra = {
 	.pma_ln_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_100_no_ssc_ln_vals,
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
 		},
 		[TYPE_USB] = {
@@ -1353,14 +1559,18 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 	.pcs_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_phy_pcs_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
+				[INTERNAL_SSC] = &pcie_phy_pcs_cmn_vals,
 			},
 		},
 	},
 	.pma_cmn_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_100_no_ssc_cmn_vals,
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_cmn_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_cmn_vals,
 			},
 		},
 		[TYPE_USB] = {
@@ -1372,7 +1582,9 @@ static const struct cdns_sierra_data cdns_ti_map_sierra = {
 	.pma_ln_vals = {
 		[TYPE_PCIE] = {
 			[TYPE_NONE] = {
+				[NO_SSC] = &pcie_100_no_ssc_ln_vals,
 				[EXTERNAL_SSC] = &pcie_100_ext_ssc_ln_vals,
+				[INTERNAL_SSC] = &pcie_100_int_ssc_ln_vals,
 			},
 		},
 		[TYPE_USB] = {
-- 
2.26.1

