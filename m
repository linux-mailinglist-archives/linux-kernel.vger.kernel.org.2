Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01F43B0961
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhFVPnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:43:18 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:2738 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232392AbhFVPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:42:40 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MFWNhV031488;
        Tue, 22 Jun 2021 08:40:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=zWtLASbhrYLOOI9z/E6vUOKWsxWY5gYSNAeKbG8jQB4=;
 b=bv/7ATDRTsnuAsDAAO5hPqNO407In5GMJfmVBOkQf1cqfe8XUSS8CoOuib+upLsNMxNz
 ajybLvPx3K4QY4rWA9fMK14/1bhGMuw2RsdFWp0Je9aJmxpgVGWj6OH3VB/c8qzPa1VN
 kziKlbIpEqVcIVxRi8I7q+0Smx8oY7qagVWPGBfXpfFeehmao5zerx3702SWqi6S7CcP
 LP1ptdU1a3g1DiXPAA043U5jqGSzAeZ0IPGBD7EjVASNdFAK2DA7V6BJDRjhfGunUsXi
 js0JDMcdMoEZyj/DWjwe81FFZfvRlFecVQ9H5lJfzXopvl1kQqL26Dw40PQIYW44SBjM tg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 39apms59uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 08:40:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GR9afyvSHI2CJ4B0o1thekqH6KsRZhMvl/pNsUY8L/rdVrCrwpnWAtkF5s5snUc6kMySZSf2E/qkdvv23CFFz5UaA5xGDOqfTUYKVRNvvqsqBRpBZ33FPuLloRH+vFh6girTxfs/erHPlJ4cykYvwXLgPD+fJ8afsFS1AAnGhXyA90Ni5uOhnIwJFWHgTge00Avb62W/yrXPZQEU1lkxWAG5TU5qDfUsPONot3SQYM+MgzGaOOn67rU4RXgl2nnNvQqVvUEGh5K0y4uaD3h9roodMDql5PRFMMDb6yvYvNZOi3+yjlclkFnvFEBUoOXrB53pg8laZno+mJT9brNWTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWtLASbhrYLOOI9z/E6vUOKWsxWY5gYSNAeKbG8jQB4=;
 b=OCkTlG1XXtAuaRfnBalIqtq/C5o5WB3YGkp402Tc/MXESIrngg+l0Gqrmzgmba9DthlRV6X9IXKlEzoO7O6cKCeOl7JBJxzazaQZZ8RBi7pEAo9hDbjBS3tRcjCIwXHyJ/0lPHULvL2N18dqNOzZ25GE5q7IySKWt+gqffbKgzhyOLd+aR2ifh06tAjhk65JE5tCh5sfvOaXT06UqC8+OtqH1vf+v2RWyB5nxF9TZAqmMUNdFPKli6doNCjzGDww+y1AJZvdUjxX/XmJwWkAt019dPDkBVlinAM6R4eLuKGFgbKERwFF/Lb/AZcZD74oYvGHmo+WxoHVXkVVhA1tHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWtLASbhrYLOOI9z/E6vUOKWsxWY5gYSNAeKbG8jQB4=;
 b=MEmLnYG6JRli0X3vnk6nB7mO+/5opiWQPx+N8pDI6yUctjRNLjPvT7/5brTmegHg5evLSHvplaV+PosgiFJkGYlqQGh7CSg5dk3923RQr62ZV1wKIi7xE6PUdt7QNxY9OKYQcVh6fXqdnVZK8wvDwcXyZWFdo8F1nvCpNK9NMCg=
Received: from CO2PR04CA0146.namprd04.prod.outlook.com (2603:10b6:104::24) by
 CH2PR07MB6693.namprd07.prod.outlook.com (2603:10b6:610:28::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.21; Tue, 22 Jun 2021 15:40:00 +0000
Received: from MW2NAM12FT007.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::d4) by CO2PR04CA0146.outlook.office365.com
 (2603:10b6:104::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend
 Transport; Tue, 22 Jun 2021 15:40:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT007.mail.protection.outlook.com (10.13.180.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.10 via Frontend Transport; Tue, 22 Jun 2021 15:39:58 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 15MFdpjI219509
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 08:39:57 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 22 Jun 2021 17:39:51 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 15MFdpO0002330;
        Tue, 22 Jun 2021 17:39:51 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 15MFdpKT002329;
        Tue, 22 Jun 2021 17:39:51 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v2 8/9] phy: cadence-torrent: Add debug information for PHY configuration
Date:   Tue, 22 Jun 2021 17:39:48 +0200
Message-ID: <20210622153949.2215-9-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210622153949.2215-1-sjakhade@cadence.com>
References: <20210622153949.2215-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1178886-33da-4d29-c33b-08d93593fdcd
X-MS-TrafficTypeDiagnostic: CH2PR07MB6693:
X-Microsoft-Antispam-PRVS: <CH2PR07MB66935ED0FB813111D4FC97F0C5099@CH2PR07MB6693.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwOGepxjNwreQbhe/lauQjNuZtw1YU4IIKUbVtKKsezgKAMe57WgHYWPSVV7VgfaQ3OBrPxd2fUerltDnNvNGVh7I4MoVJ93mivnCbXE26QenfdSDHt+Rmk+jGIDt0HdjIKuVZXkiNu3S5RyXJexq1lYtZVFPhG7vicKa3ndUR1CINrItbjtRUYDoNQQVNmSVLxrAM6biCAQ6oHzhnSMW5Z0tzViG8Kcji3eRPJtRPvG2RfjOMRKppKvsSHWlcBW+OwIDKT73UDs5lUBOf334PEEMTaedhBzqadltjVZkMklK+YJGJe4SxSSu5l2C8aNTDtkIkRmDr+ioqRpmQKCRH5z0m5PucN5mcLkfYNehtnBd4z0ewcBVJbAn9pBy1YQ4LiJNgDVsWTsxqAyLtJ7Pxuiqu8BjtCQGjFowB2NUyFrbhaWEwZVxS9PtJNgBXoGlMSuYT7/rneXboLysbMMl5MTFGjtnnr/WJYH/hX5BYXaqKo7Bmv+6nVgoyEsaSAjfl8MwLuN1QHO4F9ZFDETrjjnds9UsiuipJhYtgZ202Iv/93D5boYVuUYxf+oWkuOSNKGns796qTJa8JC4bv7P43mRi0fngWhW5ycB1AR5cPCuHdAkHwz3L/LPT/Z9ozBUFBuC4tUU65CkptblSTExCDvfGJA6tAawqv++8EzqCDzSHey5VYRYn+WJgy5eAj7JHyreo/i2EQ3t0rvOZFDuPtvlyM6ebJS1DgWsst2bB8=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(4326008)(70586007)(83380400001)(82310400003)(498600001)(8676002)(110136005)(5660300002)(1076003)(186003)(26005)(356005)(81166007)(2906002)(70206006)(42186006)(54906003)(8936002)(426003)(2616005)(86362001)(36756003)(6666004)(47076005)(36860700001)(336012)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 15:39:58.3681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1178886-33da-4d29-c33b-08d93593fdcd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT007.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR07MB6693
X-Proofpoint-ORIG-GUID: FpqcfBYi7l2fCuZXtveN7sYOOFkEjjXz
X-Proofpoint-GUID: FpqcfBYi7l2fCuZXtveN7sYOOFkEjjXz
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

Add debug information in probe regarding PHY configuration parameters
like single link or multilink protocol along with number of lanes
used for each protocol link.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 36 ++++++++++++++++++++---
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index e4dd8d1711a6..4024db052cf9 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -573,6 +573,24 @@ static const struct coefficients vltg_coeff[4][4] = {
 	}
 };
 
+static const char *cdns_torrent_get_phy_type(enum cdns_torrent_phy_type phy_type)
+{
+	switch (phy_type) {
+	case TYPE_DP:
+		return "DisplayPort";
+	case TYPE_PCIE:
+		return "PCIe";
+	case TYPE_SGMII:
+		return "SGMII";
+	case TYPE_QSGMII:
+		return "QSGMII";
+	case TYPE_USB:
+		return "USB";
+	default:
+		return "None";
+	}
+}
+
 /*
  * Set registers responsible for enabling and configuring SSC, with second and
  * third register values provided by parameters.
@@ -2392,10 +2410,9 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 				init_dp_regmap++;
 			}
 
-			dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
-				 cdns_phy->phys[node].num_lanes,
-				 cdns_phy->max_bit_rate / 1000,
-				 cdns_phy->max_bit_rate % 1000);
+			dev_dbg(dev, "DP max bit rate %d.%03d Gbps\n",
+				cdns_phy->max_bit_rate / 1000,
+				cdns_phy->max_bit_rate % 1000);
 
 			gphy->attrs.bus_width = cdns_phy->phys[node].num_lanes;
 			gphy->attrs.max_link_rate = cdns_phy->max_bit_rate;
@@ -2427,6 +2444,17 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		goto put_lnk_rst;
 	}
 
+	if (cdns_phy->nsubnodes > 1)
+		dev_dbg(dev, "Multi-link: %s (%d lanes) & %s (%d lanes)",
+			cdns_torrent_get_phy_type(cdns_phy->phys[0].phy_type),
+			cdns_phy->phys[0].num_lanes,
+			cdns_torrent_get_phy_type(cdns_phy->phys[1].phy_type),
+			cdns_phy->phys[1].num_lanes);
+	else
+		dev_dbg(dev, "Single link: %s (%d lanes)",
+			cdns_torrent_get_phy_type(cdns_phy->phys[0].phy_type),
+			cdns_phy->phys[0].num_lanes);
+
 	return 0;
 
 put_child:
-- 
2.26.1

