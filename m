Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E323594AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhDIFfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:35:21 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:35020 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233312AbhDIFfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:35:02 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395PpuT030900;
        Thu, 8 Apr 2021 22:34:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=gRbm1qYwk77AKC3YnVh2nvkJTJ5u8alNqftV1zZW6IU=;
 b=hclO/unHNQj+tC/IP7BrtyiRlYri6/Lsl1PqLAcO02aDoK2oFRbNpSIXWduC6x29drGm
 bstxSezpiUSzE+NA+89gWJGKa2Ms4/dwsIzftzfrACJPY5+hPh2zpQfAl9LnVNhXj/IK
 2UFgNL7vweZ+jIRv3eaSCIJeg05QQ0NLg8woMWK+FMzO97PDpRLChl7Ig5Sp1pXv1Hpr
 EJf+l5CQJvMYiQx/ftfqwNODQbVHCuT9NFiFVcaL3z26JMF9hFy3oKM0FhMabVZPJAOD
 hbnDILwCmW808dy9H9boP2gu7VLn4BtOHGwAHX4LgChI3SpYU2vDbhQp+ODEXI7aaGqp VQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0b-0014ca01.pphosted.com with ESMTP id 37rvb4tthm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5da1USgEhSVVBBuy8tGVkk5sCQBijIrLgaGaepiBfT+324XR7AjigSNhXMd+ct7UeW1YLFYCeMC//ikRVtUlJuPVwgLEfkIiheVIpOfzzNJaXAqSxXLJxfVXWagaHT1+hBNMLzgzSnkGzMPV2GglS6duAceDf4SVOi3pBDqvSVqw8jbBXhJ8LddXssxzEXb1Z5MsqbUYqz3eniyRYrqxhhyRhGqDZli1Z+acBQ+rAhdQTNhk17iga4r8zDfp+MOneRxNMaGV55hnBDPYHj1LJSH3AHptjcPGbRyQDLJQwm1mwYZe0y8+h16Ot91gGIuEKNdaZcKKodTN+dSa2DxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRbm1qYwk77AKC3YnVh2nvkJTJ5u8alNqftV1zZW6IU=;
 b=TyIM0m3DEEy9IiYtssR+SSB/ZAbUYU8Td+QZN05xReld/xjMehKY1CxgE8tdpaX+x9g4Bm460EIIXDLsVq2ZIcuu/edWv8i1QEOlUDNQujxAleFNVvcNWNElauICb0cTG6J5hoKkuyDI/P8+cPjugW36Jur+ZWASkU4dElpkKe7mXrnRQ0zT7vxfETNv8zJxFQvahEQ1HnLhxn9EyluoLhKiMJfFSpa4oKJ9el1ZMLTiwTSMPa8QPOmwQiLDjRnASlyvfEsGlalRmJ8jrATzm6LaKMedj5q3yZj7gKe9hmxoUvNQcy87cb7+sI1Ho6IpyGAqTS3PB2LA9F9Xx9Kfgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRbm1qYwk77AKC3YnVh2nvkJTJ5u8alNqftV1zZW6IU=;
 b=ZFdSJcUBuihYxXGyTsgHSqc0zzvr59iw+fXnoz/Np7SzfvYNyDO98xd1vXlJTS3vZ+HlsXU8NjvA7RCOhc+1HAkletYPUgsBGq0DaMQ+HhIiIvihBFJCo+Yt4ZYwuZmC4HgzARe1ACwuS912+BOB0ULbipNUimG7ZouSk/sri+k=
Received: from MW4PR03CA0095.namprd03.prod.outlook.com (2603:10b6:303:b7::10)
 by DM6PR07MB5148.namprd07.prod.outlook.com (2603:10b6:5:42::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 9 Apr
 2021 05:34:27 +0000
Received: from MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::71) by MW4PR03CA0095.outlook.office365.com
 (2603:10b6:303:b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.19 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT021.mail.protection.outlook.com (10.13.180.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:26 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5Y032749
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 22:34:25 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ2L027860;
        Fri, 9 Apr 2021 07:34:19 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YJJq027859;
        Fri, 9 Apr 2021 07:34:19 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 08/14] phy: cadence-torrent: Add PHY configuration for DP with 100MHz ref clock
Date:   Fri, 9 Apr 2021 07:34:10 +0200
Message-ID: <1617946456-27773-9-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 020db7d6-63b5-4767-fe64-08d8fb192389
X-MS-TrafficTypeDiagnostic: DM6PR07MB5148:
X-Microsoft-Antispam-PRVS: <DM6PR07MB51489E8D7C9FC7F0F3F6EA65C5739@DM6PR07MB5148.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYovUKXoUi2BBJrjoAo8VkkfOcBkfHg6Q1o7BVeWLT4enh7Y9HP94MrXeNp1dqBGnfbNrcG/OKdqkkGJTJ35UcQknyyBSmT9oIpo3dYkrWlpNEVhMj34Dc8jf1J5PIq+BoQJwZfJfDn0XPnyXapREX/4jEHPLb0A1heDXVHw0MKkmeYzgyOsxXhQn9dvNof7xda3Basrwt5eMV3FvkepCS2+/h6k//5UueXlEvvaanmo7CZZaopcZWS3ijigtjo5I7oDEYXKbxjusRxJB+2kpOl0mQ47zkh3RiqdtMve6LecJ1mUAaH1ZrIjD9fy6vffFV/kJt0CRprAO/f89IY0IERPnctAAHcccIdCmlnKHQBbKIVVIEEOlZrJTUOJSw4saipplBxkHxXShvOZcAZc1DyM9sD8sCOn9dUAzrmTqNznuZN1XvW8i/FgKIvSAa4x26CSqlbplVc8fPvWwkyqCVPlhW5kX1P9wHMH6UgL5dADb1g4HEH4QgtYIikcRVxMLNfX9jnMiTaV2rXcJBRxeXcMm9lEkKJzNPJv+3zh+ArY57f0n5VgP5xbIKl2bNaiOEzLCVibDpLmgM4B0hFZywSlWStgOW+H6InHsoKWmscgsyVtpJVaojaoqPEygJB4Dq/mB1E+llIcxSGbWf0szEtVQbeoABF5JC5VqkBpVMPjlQqU+YwUlP81Uj5Z0XuJZkI1CtlRf3K5ta9Ei7AjMg==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39860400002)(36092001)(46966006)(36840700001)(83380400001)(82740400003)(7636003)(4326008)(110136005)(2616005)(36756003)(356005)(70206006)(82310400003)(54906003)(47076005)(426003)(316002)(336012)(5660300002)(8936002)(26005)(86362001)(186003)(36906005)(8676002)(2906002)(6666004)(70586007)(478600001)(42186006)(36860700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:26.1385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020db7d6-63b5-4767-fe64-08d8fb192389
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5148
X-Proofpoint-ORIG-GUID: kzYy70IBFBtfVhgZweSjiDfmR50iBHLi
X-Proofpoint-GUID: kzYy70IBFBtfVhgZweSjiDfmR50iBHLi
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_03:2021-04-08,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104090040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PHY configuration registers for DP with 100MHz ref clock and NO_SSC.

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

