Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A62C32CC77
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbhCDGLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:11:10 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:8940 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234729AbhCDGK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:10:59 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1245tXCB026048;
        Wed, 3 Mar 2021 22:08:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=d4G0tTY7ZRZaox9AmEqwSZzLcgpuwuLOFa+0YkZeYqQ=;
 b=Opp4oNGd5ERrAcJcRbkBxjv0eWVNaQhKaAI8iiRiCKL0bB5QPf/Y87ieg0TIx5Bo1/lQ
 CL2G0WHeJ8bKwEGQGpLsV8veRhSzq+dK2ZwNnfWYOPI+sIjacr0CsYKOsdx86LgRZL32
 KMNp/gZr0S2hN7xbkiVj9IAk+nx6ngh1MOJT6l0h/qtwsHjGLJkr9QVgmH4QjupDg0i9
 KTP8lDsV+PzsWFOR9okV5k9NkJCCmY5M38JaoDJ92Vq62YppqY/d8L8CLQAFmcWKDssf
 b8kQ7ETl7Md3z1oW4dRQDjesTG1BCtsPhbWAZbs2zCuIjbtA7s6oF9OOajcMMXPz1MFF 0w== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0b-0014ca01.pphosted.com with ESMTP id 36yjj2r9er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 22:08:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V80pDCi2oPexORpodS4jScAEjeu0k1wHs9miczviRG7Ze0cAvv8Y5FhWMvRgmwMH7rFDc8SvEa07pBsLSZUdD32fhQVXACvw0rcbYfvCwsjXqHW7KRzwts+wwbSoZj8VH5/uEi9bvk6ZMBUiF/1Qw1dnmyOWizrHcDRoL1WLtFYdG3EavJZwnFcnwfeRUaRsKI6twH2dTL3W8BGu5JUkxM3DHF8kmjxmQokSOsox2J0wGVffnxeWPT+V1jA2XVsuOs1lloYYeqJpBOqSInRRkyi5jYLky9yPizBM6jlu+mco/kqVX/7nQA1QDsHI1MtpoQdjrvXTTuN2HUayTFvLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4G0tTY7ZRZaox9AmEqwSZzLcgpuwuLOFa+0YkZeYqQ=;
 b=l1JOElnXZtxpWUF4WWu8PCUBa0iqYtjwbczOzgAPUCO2MWny/NuojkpgdRtHL+nmZDx+EDOeKB+bVs2pEsxFn+2xhWVcYpU4G1p7DuCikRMNIXTTbYHPeBdVzdAes34oZEJWgu1H2GSMIrh47k21zz4qUQdjg2ZDRrkMF4TBfsNfz5TYpACmx/j7f4ABHWv9KIcjvCnhRLoG3PbaNQhmcJHuwKuurbqRKrJJMUUvTl3whDNmQ4QhiukKqD+cTpCdecpuek0urYgeCpDlNn9O0Q12Yh3T74yQRpTEa70Coh7c454QKNAqNEKN5erRdM1aejHa6zEz9PNojPjhFkwsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=cadence.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=cadence.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4G0tTY7ZRZaox9AmEqwSZzLcgpuwuLOFa+0YkZeYqQ=;
 b=3mlOo/+YYPxMZKT2la4cwrBXD4aFYSxmIxoSM9W7w5NOcc5YSllReUGdanKxfZ/Qtg980V6L7Bm42N0i/Nm1asDl9l/NLSH6sSWpv8HJMjpkTiqibNZAPFA8YAf56veef0WSdefHlBK5M1rna6tJqOCF2aWDdznWuhgBamUVN8A=
Received: from DM3PR11CA0008.namprd11.prod.outlook.com (2603:10b6:0:54::18) by
 BN3PR07MB2705.namprd07.prod.outlook.com (2a01:111:e400:7bb2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 06:08:27 +0000
Received: from DM6NAM12FT031.eop-nam12.prod.protection.outlook.com
 (2603:10b6:0:54:cafe::1e) by DM3PR11CA0008.outlook.office365.com
 (2603:10b6:0:54::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 06:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; lists.infradead.org; dkim=none (message not
 signed) header.d=none;lists.infradead.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT031.mail.protection.outlook.com (10.13.179.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.9 via Frontend Transport; Thu, 4 Mar 2021 06:08:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 12468Jjr067409
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 3 Mar 2021 22:08:25 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 4 Mar 2021 07:08:18 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 4 Mar 2021 07:08:18 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 12468IkC032357;
        Thu, 4 Mar 2021 07:08:18 +0100
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 12468IcF032356;
        Thu, 4 Mar 2021 07:08:18 +0100
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <nsekhar@ti.com>,
        <lokeshvutla@ti.com>
Subject: [PATCH 4/4] phy: cadence-torrent: Update PCIe + USB config for correct PLL1 clock
Date:   Thu, 4 Mar 2021 07:08:16 +0100
Message-ID: <1614838096-32291-5-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1614838096-32291-1-git-send-email-sjakhade@cadence.com>
References: <1614838096-32291-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c9d4773-6afa-4883-4060-08d8ded3eca5
X-MS-TrafficTypeDiagnostic: BN3PR07MB2705:
X-Microsoft-Antispam-PRVS: <BN3PR07MB270581C8F10F6B318067B780C5979@BN3PR07MB2705.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GHS82TBMpzuLZDVmu3tROvzeN3HU3R1BzfGu54gbR+34aw4aA5DCkvvDVEPebOHDws5A0jJdTk94UzxtO9AQQfxCiIEmOhoj+ucMBAt25iDXc40j4ltM6X5BqWmCK9fSb8l9SGnMzJMYqKSF/3i32kZNiKkQ8IFFoa+VhO9Oz9V2/G/QF2CDws2Idzci9oPd/L0pR0jg3W2jku1wOIX01/Ef+EbOeQ97GVPaR3YgvesnSCJGYYDVzPi/zsWNMXnKUOMB4rsJ3zFrKxU0Q/7speMAk9sU7JxSsGi0SrCfbV68F3uoFNId1QVznCEohdQ/ezUOGUEruhnSmFnOKCZSAqSZ1zwgeEhcQGmUPr5w1o53PBmdbbqu1uvZpuAFOx+c2BhSCBTxgiwdVs3LB0rHfEpjOSjcrD9fNs85SKZUUqR3V8ovl7u6XtmspAU8PIX00pOyN8XfS0apzFub+iZlG1wKZGd8/+wKTVS19YD/lSdSeunAivYmk2kWOrngbx8Dz0hpsvO0rKekifctAGpdWQbkFoHy73PxC/45lahzevPxeXX531YNKnSZ8CQZKpo2FRStZB/VoKyOTiEwhuY+pn0xB9kOJ1q+xLrMVfp4oNUXEbZpCXk4zD3GTDPZNJOoNpRCqzfvpnvlR3eXM4hHOyNoTPTnKaG7TybSC4NCiz+eUNISFBpXknje8ktI6Y8xf6hk9WW+qXxkvab9hziRhQ==
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(36092001)(36840700001)(46966006)(82740400003)(2616005)(4326008)(82310400003)(110136005)(81166007)(26005)(36756003)(36906005)(70206006)(15650500001)(47076005)(42186006)(54906003)(426003)(8676002)(336012)(316002)(36860700001)(86362001)(8936002)(70586007)(5660300002)(2906002)(356005)(186003)(478600001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 06:08:26.1504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9d4773-6afa-4883-4060-08d8ded3eca5
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT031.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR07MB2705
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_01:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103040025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update PCIe + USB register sequences for correct PLL1 clock configuration.
Also, update sequences for other USB configurations with dependent changes.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 47 +++++++++++++++--------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index f78a6731c26a..b371795e66a2 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -2655,8 +2655,6 @@ static struct cdns_reg_pairs usb_100_int_ssc_cmn_regs[] = {
 	{0x0C5E, CMN_PLL1_VCOCAL_REFTIM_START},
 	{0x0C56, CMN_PLL0_VCOCAL_PLLCNT_START},
 	{0x0C56, CMN_PLL1_VCOCAL_PLLCNT_START},
-	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
-	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
 	{0x00C7, CMN_PLL0_LOCK_REFCNT_START},
 	{0x00C7, CMN_PLL1_LOCK_REFCNT_START},
 	{0x00C7, CMN_PLL0_LOCK_PLLCNT_START},
@@ -2664,7 +2662,9 @@ static struct cdns_reg_pairs usb_100_int_ssc_cmn_regs[] = {
 	{0x0005, CMN_PLL0_LOCK_PLLCNT_THR},
 	{0x0005, CMN_PLL1_LOCK_PLLCNT_THR},
 	{0x8200, CMN_CDIAG_CDB_PWRI_OVRD},
-	{0x8200, CMN_CDIAG_XCVRC_PWRI_OVRD}
+	{0x8200, CMN_CDIAG_XCVRC_PWRI_OVRD},
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
 };
 
 static struct cdns_torrent_vals usb_100_int_ssc_cmn_vals = {
@@ -2707,13 +2707,28 @@ static struct cdns_torrent_vals usb_phy_pcs_cmn_vals = {
 };
 
 /* USB 100 MHz Ref clk, no SSC */
-static struct cdns_reg_pairs usb_100_no_ssc_cmn_regs[] = {
+static struct cdns_reg_pairs sl_usb_100_no_ssc_cmn_regs[] = {
+	{0x0028, CMN_PDIAG_PLL1_CP_PADJ_M0},
+	{0x001E, CMN_PLL1_DSM_FBH_OVRD_M0},
+	{0x000C, CMN_PLL1_DSM_FBL_OVRD_M0},
 	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
 	{0x0003, CMN_PLL1_VCOCAL_TCTRL},
 	{0x8200, CMN_CDIAG_CDB_PWRI_OVRD},
 	{0x8200, CMN_CDIAG_XCVRC_PWRI_OVRD}
 };
 
+static struct cdns_torrent_vals sl_usb_100_no_ssc_cmn_vals = {
+	.reg_pairs = sl_usb_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_usb_100_no_ssc_cmn_regs),
+};
+
+static struct cdns_reg_pairs usb_100_no_ssc_cmn_regs[] = {
+	{0x8200, CMN_CDIAG_CDB_PWRI_OVRD},
+	{0x8200, CMN_CDIAG_XCVRC_PWRI_OVRD},
+	{0x007F, CMN_TXPUCAL_TUNE},
+	{0x007F, CMN_TXPDCAL_TUNE}
+};
+
 static struct cdns_reg_pairs usb_100_no_ssc_tx_ln_regs[] = {
 	{0x02FF, TX_PSC_A0},
 	{0x06AF, TX_PSC_A1},
@@ -3497,8 +3512,8 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
-				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 			},
 			[TYPE_PCIE] = {
@@ -3507,13 +3522,13 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 			},
 		},
@@ -3906,8 +3921,8 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 		},
 		[TYPE_USB] = {
 			[TYPE_NONE] = {
-				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 			},
 			[TYPE_PCIE] = {
@@ -3916,13 +3931,13 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 				[INTERNAL_SSC] = &usb_100_int_ssc_cmn_vals,
 			},
 			[TYPE_SGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 			},
 			[TYPE_QSGMII] = {
-				[NO_SSC] = &usb_100_no_ssc_cmn_vals,
-				[EXTERNAL_SSC] = &usb_100_no_ssc_cmn_vals,
+				[NO_SSC] = &sl_usb_100_no_ssc_cmn_vals,
+				[EXTERNAL_SSC] = &sl_usb_100_no_ssc_cmn_vals,
 				[INTERNAL_SSC] = &sl_usb_100_int_ssc_cmn_vals,
 			},
 		},
-- 
2.26.1

