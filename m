Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632C3437B67
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234021AbhJVRGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:06:10 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:38808 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233721AbhJVRF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:26 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEgQ13012896;
        Fri, 22 Oct 2021 10:02:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=TAFnHh/GnRl6A449G9Sz3vHV4YhKmXiqqN0hUP9aG5w=;
 b=d3cehnwqOtkGns3jUpkP73W74CtIgbgd1XWEi4p3h2XCfc+IGlx0M8HThSXwsLxwDO0t
 IZVRJY1pUI/MTMcgz0CihZ/LSq4uctEWbNagnGug2rXc9FHmtvwGp2S5mOLgNO6zOoft
 KvdMHfdbd+IyEjF7wpCHytfmP5wwT+zq2gpj/oO3lZIssJE8jlKCoU2XanTMcd5RxvVL
 cdFIwJdPofB/9Y5fZiAZCOcw28l3SExuy94mG/n3zYEANPCE7Poz1h/CpkOGpb7pPhjR
 ZktutDoWk+1dSnySI9k+Bq70VY3zRSBm2ZYkxe8TBLSnKAM6sW2D/wHMKNHgOPJoXlbS tQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3buya2ret5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kox2Cwey1fojURVrCt65DEm/g6P00ZhFjcsrtutA3v7vKMBJw6c9pBfNyaKdvLtOaqKb7qG//dpDdSeXFg2Yzvj/TnB/U0yph3e4dmzht/maW5nhRY2Qkbuvqr46LKFyj3u7d/9sTH0kNkeS07Rv6hZFWWXTO81huBNmYWAOVsN+MCw8PzjZyVl1A14fNEdsxChRnI1e/Jdi0/qNS7etU0b5DPrUOuByY8EKQOdaj0WNlIdJJaiUwYWyP3/BR779QKN92h2FMpaQCDSpQPT/m3wYoimbIXZVwUNTE28CXdSAwewcpdEY/eZWT+V11Y8FAQUE4ewqMGc+7GA13f1Amg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAFnHh/GnRl6A449G9Sz3vHV4YhKmXiqqN0hUP9aG5w=;
 b=nuf/xdsPjOjrQ8BoRfNMEZjKMezXRUWH4n9p5wEd6YIAbgKtlx7XeoWtiyXDFxR6PRAgUczB7QwJnBEErd95TnpfhyM4E39cO+AP0EyoCRBRAq9qWleb3deCievpMP4PgUPUZT2QenRIi8K2jXVH68zT0ZufA/hdxtTL9KN1yq0bGF4btcn6LxmOYN1z+AIuJQxfa9Kc6D2VJ3dSWBAQMhfjvQQ7toY8zfV/Bqy+x5dHSXEkpjM8kl7H4552uh4JMS3YIjSl4HG+HLz88OM9MrP1MgZXzQR8GR3qG0bh2Dvcwwn2nERsYw9/urxTaR/9+DVxca7CNIBSQUrkfVEl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAFnHh/GnRl6A449G9Sz3vHV4YhKmXiqqN0hUP9aG5w=;
 b=ax1RuwdTykzFbIk9G2ghRGyAtmeitIIuZHPnNmbaoOYPrbUBLQeTQwWLQAU7FJz4iKepTKcObbhiQN9Btw7+KXtB3PSgqwgTQErvyXkvcN3r3TiNuTuVcsYNOr4oxXb1SPX9phi7zN8iRkiy4Mh35R1OXNxih2AE95BwKUO1xJ4=
Received: from BN6PR16CA0004.namprd16.prod.outlook.com (2603:10b6:404:f5::14)
 by BL0PR07MB3922.namprd07.prod.outlook.com (2603:10b6:207:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 17:02:54 +0000
Received: from BN8NAM12FT037.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:f5:cafe::82) by BN6PR16CA0004.outlook.office365.com
 (2603:10b6:404:f5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT037.mail.protection.outlook.com (10.13.182.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNR008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:53 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu5.global.cadence.com (10.160.110.202) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 19:02:39 +0200
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu5.global.cadence.com (10.160.110.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Oct 2021 19:02:39 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2dqB018929;
        Fri, 22 Oct 2021 19:02:39 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2dHl018928;
        Fri, 22 Oct 2021 19:02:39 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 10/15] phy: cadence: Sierra: Update single link PCIe register configuration
Date:   Fri, 22 Oct 2021 19:02:31 +0200
Message-ID: <20211022170236.18839-11-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06a8951f-e6ab-48b5-85d3-08d9957dca3c
X-MS-TrafficTypeDiagnostic: BL0PR07MB3922:
X-Microsoft-Antispam-PRVS: <BL0PR07MB3922F05BB951B789D4797E97C5809@BL0PR07MB3922.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:454;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acwPEaxRcjSjAe9s/DEsjMSsp7PS7afSjI7IxYy5H4q9kEWSRvA0NE9gc+jibrcosfdW/BrXcUAJeNVz6OWyVT99oWobyevzvnkweee8UhOvhuiAWK+gjGzfBh3AYCpUOfsoRu93jZ0d356vASNvXr4A4vkAsOATs0+WNkGGQiwF00BcRu8oSaDNFW//c25DXZvfcOcGwsnVx5Ve0bvuYbUKTl9CQsEosRwm2EJ9LePnpjs+F9argaLBoXIdhXuIUducLkY8X/J6swOP590hEX2TIhfdfXgIskCbEBN8oTRV/O2XNxBUTyer5QPFogaKTzUC+y2vBpoN/9/IuAGiuqjgWxHhA6uYJUe8m+mbpyQD0JvTvo8a9/8K2x6NuE2PEuq7BSo8jdfJMJ7aWsg3DkawQEsnf66KCFEOrzCve3mXvOz+nxKH4v1l7/m+VuJoxvwCGgJPNvniIoOEfn5VHEZJ406gmyxrtai41fL7maaxGFXz9ov5/5jWoJFaOO/JGvtsfOynb2E5axpY/NqdN2z7IkEpNkAfSqGtIAkblFb+4MtjgyOgH9CKVXFbHPO2u6MacBdsgZgRDDw14AtEouswf0z16ltsxPfsoaOHIZAAHN5laA6rIND23fj74I9CGyb2xilbWiYiRIAZY5NwHO4O8CpAqHwKl53hkmlcx8f3SM2jxb7ZTedU24E0DRXVVZjYSPdea+YWeVT5gEscUQsFdWzdKf4ls4fZtChb6EQ=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(36840700001)(46966006)(1076003)(336012)(30864003)(426003)(36860700001)(36906005)(186003)(2616005)(42186006)(70586007)(6666004)(19627235002)(54906003)(83380400001)(4326008)(316002)(70206006)(86362001)(26005)(2906002)(110136005)(8676002)(508600001)(8936002)(7636003)(356005)(47076005)(5660300002)(36756003)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:54.4571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a8951f-e6ab-48b5-85d3-08d9957dca3c
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT037.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR07MB3922
X-Proofpoint-GUID: UFvptjfTlwkoO12VDQX_UWbBYmzyv8qz
X-Proofpoint-ORIG-GUID: UFvptjfTlwkoO12VDQX_UWbBYmzyv8qz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-22_04,2021-10-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110220098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add single link PCIe register configurations for no SSC and internal
SSC. Also, add missing PMA lane registers for external SSC.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 214 ++++++++++++++++++++++-
 1 file changed, 213 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 59458388a855..728abd14aa79 100644
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

