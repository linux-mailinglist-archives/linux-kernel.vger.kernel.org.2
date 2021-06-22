Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF943B095F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhFVPnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:43:13 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:26028 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232356AbhFVPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:42:40 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MFWP9w031503;
        Tue, 22 Jun 2021 08:40:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=9erJHIq1mw1g8DNscJvdoSDc2ra9eEuu/mztlAIYTXY=;
 b=OlnMHiedJn5ju49NRNa4nFBl02FAaxFmWNFB5D0QdZLH3OncVCrns1he+OmUUEYmkKs6
 /NoJgg0UO5ofNFg3n/K4R1U02WPEy1FewAG2FI2GEqQD9KcLx8V8WurXubj1/fC5uxTb
 +X8oempPqyhZJDWACntCQpZ83TBYlwkQxTqCiVBmPhZy/YJDOiRYnb/3Ut2z9uzUsUNU
 OQ2em0Qz4yF0gzGgzYGpQ8jbos4oQ03epnZAkzjxQEIvrMlSnbnjE4NDupRpbaPvrvS/
 +0X3thPwRFg44lg2EEYXzRfhxvh+MihPK7D2y9op4srm2AOFr+L3+dX6Kaah5G1hI/V4 9Q== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2042.outbound.protection.outlook.com [104.47.57.42])
        by mx0a-0014ca01.pphosted.com with ESMTP id 39apms59u1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 08:40:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMFeFXibX0/aHphbEk1WpHALie3JnJb5Eptho2y+ImDZyHC/XFlyLcOJaB/iwsfIrnpYwwxTMUPM5rFwdStigYprm9AnpWBpS7KV68+4fmVgmzJFkopnU/3UkHaRioJ9rjZ146QqbTimB0rxSYCNasMd/AqEPJ7KkiBv0RVMw6oMnderV2BePW/c3/bcb/KKnj2WOQdga0mX5Dr04BKsxwjeAU3SAVhpTSHTdgqAqUZXm/iWUHaX0TSqEMjA9qHHgR8YVjOcsBW0dGc20+XvHYA6DlxtdeIAQ/gSRnjeXliMSmdbJHO3MHW/YLZ3FvBprMB9Oe68xwUIwOtWcCVD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9erJHIq1mw1g8DNscJvdoSDc2ra9eEuu/mztlAIYTXY=;
 b=K/VAnC0UkipNVwxommZ7AajX29GIGnvB38qyMopXLEslm0GpSNHPK7lRraBgzmJt5lFqPncZnym0tf0IsWjhmlq6T2C/WuIRVMaggw/i9tfvcrWcAySBmUqph6dy+8eCu4xSYnn+Ni4jWkTvKITul606iXziDkP9yZnlydBP4DDB/M22LgIwnm/HWusJE0RI1PwLMgqLh/6e/QuE6/i2B08PYIJJipuC+aWyD2eWKyn4wY2wmdUpOvsekz+pibNP3PfAO4PFAhehb5ZeYlvt+OQUAKnMljr1eLWG2gfjv7NLq/EDCUUxe8e1So3jErY4EOOYAmJPdjU8db2knY5J/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9erJHIq1mw1g8DNscJvdoSDc2ra9eEuu/mztlAIYTXY=;
 b=okFZZ5molv9nzGtPnvjafRlYGtB3z+iPO9Zc9UgywBV/9ni4oHWYUTja4F8juqYGOJVpIDv1kiWLsBgGqMHeClGXDNhOqWOtK9OBM7edc9sT04/NEuKUtKkmNQZefSpn5MYG5m5zycRSjIox5GQjj3iGm1lap1t0+OSKxPe1q7s=
Received: from CO2PR06CA0062.namprd06.prod.outlook.com (2603:10b6:104:3::20)
 by SA0PR07MB7657.namprd07.prod.outlook.com (2603:10b6:806:bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 15:39:58 +0000
Received: from MW2NAM12FT040.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:3:cafe::71) by CO2PR06CA0062.outlook.office365.com
 (2603:10b6:104:3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Tue, 22 Jun 2021 15:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT040.mail.protection.outlook.com (10.13.180.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.10 via Frontend Transport; Tue, 22 Jun 2021 15:39:57 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 15MFdpjG219509
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 08:39:56 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 15MFdpBT002322;
        Tue, 22 Jun 2021 17:39:51 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 15MFdpiP002321;
        Tue, 22 Jun 2021 17:39:51 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v2 6/9] phy: cadence-torrent: Add PHY configuration for DP with 100MHz ref clock
Date:   Tue, 22 Jun 2021 17:39:46 +0200
Message-ID: <20210622153949.2215-7-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210622153949.2215-1-sjakhade@cadence.com>
References: <20210622153949.2215-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ec89af7d-51a9-40f1-d613-08d93593fd05
X-MS-TrafficTypeDiagnostic: SA0PR07MB7657:
X-Microsoft-Antispam-PRVS: <SA0PR07MB76579CB857A6F2C93AE69BF1C5099@SA0PR07MB7657.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DYoWNrxfvobh6DcF+MEivBAVnXf6Frusq7FIvQidn0Qh8Tv+l/0i6yKwLy3/FipQizR+kFhsmZALFeOHPK36gS9H7bPhBpLQPSJyYzfKF5duO74g+QKXgVF7/K6vF9OVTq2fpsj3EN6NcyE8+cmCSs+VapjXwjaxjZOUPm9FpLC/oGcIwHsbU2tE6rnDage0V4YviDsSD4tuUHewypgESriCUrDhbcyI70vpbH0lwotQbpfSDKSe4RW7rgvBQzbxun3Pz+ltn9V6ZReNQdNjtvogpgJhKraMO0se1V/+vHUZfeg0coTP2mJbEXHmCbt9sAKU1VO4hBYGoZhSr/Ewa+5gxZOQ4vv+PQReaCRqTXcPaoCLqyJQupAigUB5qqA98DNxz5XCxJqv9/3w7hEnnrZMquOlpm7FfXrE0w+xzFBQ4tAihj86Nq/XoAmwE3ObNfIMW9wKhxAen02ObQc78MI0vbKjgeXBoZnze7TGdXenZQZoiIPIIuzlJ+uY44wUfatiowz17eazQwlCY94K8uCqcBfeOTKXy/hvLY1GfoYy2jGUm1mrVvl3AoF/+r0s4OIKWSZoN9gN+85GCgBowNMqZ3cNfXwPsZFzVx864/3VTU7pE0LyIl51ofOJ+g7VxjzETzwjUkMCbj621rCerlijxXU9lIWP3E168UapzrswRPM7HRSLQ/k1jYGPfvo3NI+LCFUf9OstQHvUAEMKmfY534TQXzFxpyK+2KS5Gj4=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36092001)(46966006)(36840700001)(47076005)(42186006)(316002)(82740400003)(4326008)(54906003)(82310400003)(26005)(110136005)(36860700001)(2906002)(5660300002)(70206006)(83380400001)(1076003)(2616005)(426003)(186003)(356005)(81166007)(6666004)(36756003)(478600001)(8676002)(8936002)(70586007)(86362001)(336012)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 15:39:57.0588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec89af7d-51a9-40f1-d613-08d93593fd05
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT040.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR07MB7657
X-Proofpoint-ORIG-GUID: AP4HoDbY6RzyhKoZpSw9QIyrhtJbqGw_
X-Proofpoint-GUID: AP4HoDbY6RzyhKoZpSw9QIyrhtJbqGw_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_08:2021-06-22,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104190000 definitions=main-2106220097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY configuration registers for single link DP with 100MHz reference
clock and NO_SSC.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 162 ++++++++++++++++++++++
 1 file changed, 162 insertions(+)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index a6331927d775..69466481af26 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -103,6 +103,7 @@
 #define CMN_PLL0_FRACDIVH_M0		0x0092U
 #define CMN_PLL0_HIGH_THR_M0		0x0093U
 #define CMN_PLL0_DSM_DIAG_M0		0x0094U
+#define CMN_PLL0_DSM_FBH_OVRD_M0	0x0095U
 #define CMN_PLL0_SS_CTRL1_M0		0x0098U
 #define CMN_PLL0_SS_CTRL2_M0            0x0099U
 #define CMN_PLL0_SS_CTRL3_M0            0x009AU
@@ -816,6 +817,89 @@ void cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(struct cdns_torrent_phy *cdns_phy,
 	cdns_torrent_phy_write(regmap, CMN_PLL1_LOCK_PLLCNT_START, 0x00C7);
 }
 
+static
+void cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(struct cdns_torrent_phy *cdns_phy,
+					    u32 rate, bool ssc)
+{
+	struct regmap *regmap = cdns_phy->regmap_common_cdb;
+
+	/* Assumes 100 MHz refclock */
+	switch (rate) {
+	/* Setting VCO for 10.8GHz */
+	case 2700:
+	case 5400:
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0028);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_FBH_OVRD_M0, 0x0022);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBH_OVRD_M0, 0x0022);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_FBL_OVRD_M0, 0x000C);
+		break;
+	/* Setting VCO for 9.72GHz */
+	case 1620:
+	case 2430:
+	case 3240:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0061);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0061);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x3333);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x3333);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0042);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0042);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		break;
+	/* Setting VCO for 8.64GHz */
+	case 2160:
+	case 4320:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0056);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0056);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVL_M0, 0x6666);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVL_M0, 0x6666);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x003A);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x003A);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		break;
+	/* Setting VCO for 8.1GHz */
+	case 8100:
+		cdns_torrent_phy_write(regmap, CMN_PLL0_DSM_DIAG_M0, 0x0004);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_DSM_DIAG_M0, 0x0004);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_PADJ_M0, 0x0509);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_PADJ_M0, 0x0509);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CP_IADJ_M0, 0x0F00);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CP_IADJ_M0, 0x0F00);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_FILT_PADJ_M0, 0x0F08);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_FILT_PADJ_M0, 0x0F08);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_INTDIV_M0, 0x0051);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_INTDIV_M0, 0x0051);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_FRACDIVH_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PLL0_HIGH_THR_M0, 0x0036);
+		cdns_torrent_phy_write(regmap, CMN_PLL1_HIGH_THR_M0, 0x0036);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL0_CTRL_M0, 0x0002);
+		cdns_torrent_phy_write(regmap, CMN_PDIAG_PLL1_CTRL_M0, 0x0002);
+		break;
+	}
+}
+
 /*
  * Enable or disable PLL for selected lanes.
  */
@@ -1056,6 +1140,10 @@ static int cdns_torrent_dp_configure_rate(struct cdns_torrent_phy *cdns_phy,
 	else if (cdns_phy->ref_clk_rate == CLK_25_MHZ)
 		/* PMA common configuration 25MHz */
 		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy, dp->link_rate, dp->ssc);
+	else if (cdns_phy->ref_clk_rate == CLK_100_MHZ)
+		/* PMA common configuration 100MHz */
+		cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(cdns_phy, dp->link_rate, dp->ssc);
+
 	cdns_torrent_dp_pma_cmn_rate(cdns_phy, dp->link_rate, dp->lanes);
 
 	/* Enable the cmn_pll0_en. */
@@ -1395,6 +1483,7 @@ static int cdns_torrent_dp_init(struct phy *phy)
 	switch (cdns_phy->ref_clk_rate) {
 	case CLK_19_2_MHZ:
 	case CLK_25_MHZ:
+	case CLK_100_MHZ:
 		/* Valid Ref Clock Rate */
 		break;
 	default:
@@ -1431,6 +1520,11 @@ static int cdns_torrent_dp_init(struct phy *phy)
 		cdns_torrent_dp_pma_cmn_vco_cfg_25mhz(cdns_phy,
 						      cdns_phy->max_bit_rate,
 						      false);
+	else if (cdns_phy->ref_clk_rate == CLK_100_MHZ)
+		cdns_torrent_dp_pma_cmn_vco_cfg_100mhz(cdns_phy,
+						       cdns_phy->max_bit_rate,
+						       false);
+
 	cdns_torrent_dp_pma_cmn_rate(cdns_phy, cdns_phy->max_bit_rate,
 				     inst->num_lanes);
 
@@ -2511,6 +2605,44 @@ static struct cdns_torrent_vals sl_dp_25_no_ssc_rx_ln_vals = {
 	.num_regs = ARRAY_SIZE(sl_dp_25_no_ssc_rx_ln_regs),
 };
 
+/* Single DP, 100 MHz Ref clk, no SSC */
+static struct cdns_reg_pairs sl_dp_100_no_ssc_cmn_regs[] = {
+	{0x0003, CMN_PLL0_VCOCAL_TCTRL},
+	{0x0003, CMN_PLL1_VCOCAL_TCTRL}
+};
+
+static struct cdns_reg_pairs sl_dp_100_no_ssc_tx_ln_regs[] = {
+	{0x00FB, TX_PSC_A0},
+	{0x04AA, TX_PSC_A2},
+	{0x04AA, TX_PSC_A3},
+	{0x000F, XCVR_DIAG_BIDI_CTRL}
+};
+
+static struct cdns_reg_pairs sl_dp_100_no_ssc_rx_ln_regs[] = {
+	{0x0000, RX_PSC_A0},
+	{0x0000, RX_PSC_A2},
+	{0x0000, RX_PSC_A3},
+	{0x0000, RX_PSC_CAL},
+	{0x0000, RX_REE_GCSM1_CTRL},
+	{0x0000, RX_REE_GCSM2_CTRL},
+	{0x0000, RX_REE_PERGCSM_CTRL}
+};
+
+static struct cdns_torrent_vals sl_dp_100_no_ssc_cmn_vals = {
+	.reg_pairs = sl_dp_100_no_ssc_cmn_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_100_no_ssc_cmn_regs),
+};
+
+static struct cdns_torrent_vals sl_dp_100_no_ssc_tx_ln_vals = {
+	.reg_pairs = sl_dp_100_no_ssc_tx_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_100_no_ssc_tx_ln_regs),
+};
+
+static struct cdns_torrent_vals sl_dp_100_no_ssc_rx_ln_vals = {
+	.reg_pairs = sl_dp_100_no_ssc_rx_ln_regs,
+	.num_regs = ARRAY_SIZE(sl_dp_100_no_ssc_rx_ln_regs),
+};
+
 /* USB and SGMII/QSGMII link configuration */
 static struct cdns_reg_pairs usb_sgmii_link_cmn_regs[] = {
 	{0x0002, PHY_PLL_CFG},
@@ -3450,6 +3582,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[CLK_100_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
+				},
+			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
 					[NO_SSC] = NULL,
@@ -3542,6 +3679,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[CLK_100_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
+				},
+			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
 					[NO_SSC] = NULL,
@@ -3634,6 +3776,11 @@ static const struct cdns_torrent_data cdns_map_torrent = {
 			},
 		},
 		[CLK_100_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
+				},
+			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
@@ -3917,6 +4064,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[CLK_100_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_cmn_vals,
+				},
+			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
 					[NO_SSC] = NULL,
@@ -4009,6 +4161,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[CLK_100_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_tx_ln_vals,
+				},
+			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
 					[NO_SSC] = NULL,
@@ -4101,6 +4258,11 @@ static const struct cdns_torrent_data ti_j721e_map_torrent = {
 			},
 		},
 		[CLK_100_MHZ] = {
+			[TYPE_DP] = {
+				[TYPE_NONE] = {
+					[NO_SSC] = &sl_dp_100_no_ssc_rx_ln_vals,
+				},
+			},
 			[TYPE_PCIE] = {
 				[TYPE_NONE] = {
 					[NO_SSC] = &pcie_100_no_ssc_rx_ln_vals,
-- 
2.26.1

