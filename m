Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED73594BB
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 07:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbhDIFgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 01:36:02 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:24074 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233407AbhDIFfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 01:35:45 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1395XZ2S028234;
        Thu, 8 Apr 2021 22:34:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=KKD+eacX+QZs6bDTvBVmppcT33s1U0/oOF1oIMxZngM=;
 b=CAy+zQ0NqHi8XkEpsk0l5gblz/XKm2Pv+0TXpYQZIY4x75X0O/v17RkH/JnMkb+vnUa0
 rBlM4irfOHUFtUaWJH12OGk7/nXHkqGGTsbioiROEnqeXSBsNT9TozBdo96OthRkn5HA
 ZO+RpHK3yI8yNMCs2/dY3Jymz/e9Gel/zH89f91SmCyqeTjZaZmAkdFn3ceuwJBS0z5+
 76ZPMEGtf3NHn7t92Nnw82b+x9DPLVZL74QGi+axUT7EtmLmwDOBBNhMBUjBFVnFRMgP
 r3/z8liaiggYVdAKOPbMHpFBZna5MPOB5UA51Gbyd+BRwbpM1jBO98Ke+p9qOc9xunAa 8g== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37t6ns1srv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Apr 2021 22:34:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUIC8tySXeSRmK0Y2c8WeKd0GwfO4Bk8hpjFCveKLXSYK8ManqzCTqFO98KUzug7R+OEk4Kf4ny0Dtm19yoKPtmLJ7l7uVdT+DE+akiKda3p7L32AnYAayIc52HFBJ3G3Uj3ALorPiV2qLPX4NWpC8ny+rzBXzbhYMI1pB4Gg7EcO0bVVTpyYfHHz7c46SK2IRbLttYyz9UmH9y+5ujpfLA+Asl2I6KWr5SHWNIfIiunHNPwFRz+K0eeBoxB1NsWx4httX8RtkdfORzPs8plINxoNDDdB4+gB4ycoeNH++UojiB6V21/cp+0LQX+LtAtJ9+UC+sqpySpyamjfLTPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKD+eacX+QZs6bDTvBVmppcT33s1U0/oOF1oIMxZngM=;
 b=VDv1f/2hGhPDI8NFJ5cAzcpB+vy7dFaGe8z6Sr/XGG4C1k6L0cYxli6f9UiKI7YiamNF9z3VfsvfJZ98/NZyzC8BI/vIAnmDN0IkRBIMZUxz1hUmr/pvvrQxPpXHIC8r2ZjonjmAyjfHWGGpRDihnA5Se+iqu9X0vc6AL+iXLG2C1UHMukvDLNEkZOKKr1AtlNDazMMkXUBwy2aE1CeZxait2yIuQR6lDsYBFHVhfDN4OcsOanJ+igafmqz3Gq0vD4bhPiChY/P3agHyGf/QIZTdEeEH8kyjyqM0ATKpKcDYQZEFla0uCYzeWMFy59MKWUBaoxZMTGfqHy1eC3U/HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKD+eacX+QZs6bDTvBVmppcT33s1U0/oOF1oIMxZngM=;
 b=zR84qbbSY17D4DE+xj8QpJCIdEdm/46L9Usi8JGHX7Uf8EwJiQrtW5BuhRDGi0WzG+u3itmnxu+WVa4sRvRX9OjnKVqOBXUqxaV1LFsUbGXqRPmSWFBYA4SoywY74ADbnG6L/xD5pGy7KycmWRDp+XmV+wi2w9JAyfTbNYeUKB4=
Received: from CO2PR05CA0104.namprd05.prod.outlook.com (2603:10b6:104:1::30)
 by DM6PR07MB4282.namprd07.prod.outlook.com (2603:10b6:5:c5::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16; Fri, 9 Apr
 2021 05:34:30 +0000
Received: from MW2NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::f1) by CO2PR05CA0104.outlook.office365.com
 (2603:10b6:104:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend
 Transport; Fri, 9 Apr 2021 05:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT019.mail.protection.outlook.com (10.13.180.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.6 via Frontend Transport; Fri, 9 Apr 2021 05:34:29 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJ5e032749
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Apr 2021 22:34:28 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 9 Apr 2021 07:34:19 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 1395YJCr027885;
        Fri, 9 Apr 2021 07:34:19 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 1395YJ0k027884;
        Fri, 9 Apr 2021 07:34:19 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 13/14] phy: cadence-torrent: Add debug information for PHY configuration
Date:   Fri, 9 Apr 2021 07:34:15 +0200
Message-ID: <1617946456-27773-14-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
References: <1617946456-27773-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29daca26-271b-4ed3-32f6-08d8fb19259d
X-MS-TrafficTypeDiagnostic: DM6PR07MB4282:
X-Microsoft-Antispam-PRVS: <DM6PR07MB428241933FE95DFCFBC977DFC5739@DM6PR07MB4282.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:107;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3zJje4q/fKmUEKolA+g6XZa9VqXScnDiNXSCgz1OEIL+AKrUxSt+EFDMQu439Djf9ptd9b55v+u40iaN74vb0K0L9LZ63e2mGmgOp/Rh/J/wH5UK6Hs+6HalF7rzmtiborCsoR9948myDt9u3c7ABQMjhU2l6EkxKIu8VNrALT3/21yTKshUDLMY8VFZU5xj+WaHDGhnecj23RjI8uZVtUfgRUOExA/Th1RmMnlDdEJOEBHp1xuQDIYtx5P6hGI872pZSuicel3G1HlgqyYxTjHE4NsAy3JAr6zPtPJmdxXK8Nmhu0m+enMtvwq45B2KHNlKhKSDbNEXwpVoEi4yj2t2hmQT7R3/d8kq7FnB0oTt/BgFUsR+HUAeiiE5Flez78O57IBW+zIDr3yRscZFq8zcMRmEU8ry/t48NUP6KT5veKgC1KL+deXnLM/Vu1vKstm/VAoou7wLQKB5cQYAyrfB4sxmPHQYBSo7nixZMt/0l5oEMuejAKAsOxx3+7aQ3x3TSBirls+XnTAh524ZCfCVPvIAGApDGRKgp6Vi3UlF5OX/T1MNdzWx98kMJEcOZT5cM0JDrVmwrDB6zzG/NaHcv+w8/u6rEU3euysD1riNWDA/ZsDjbMxkyVqVAsLY7eusG3dQ+ermLWcqB4Gu9yzK7Aime5QAY13YgU4oV2VPHrhIIA0Vn1PQfDVovGHrRoKGcQh0KwEl7dA+tZ4Lw==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(36092001)(46966006)(36840700001)(7636003)(356005)(6666004)(70586007)(2616005)(36756003)(336012)(426003)(5660300002)(86362001)(47076005)(82740400003)(2906002)(70206006)(478600001)(83380400001)(316002)(4326008)(54906003)(36906005)(110136005)(8676002)(36860700001)(186003)(26005)(82310400003)(8936002)(42186006)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 05:34:29.6198
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29daca26-271b-4ed3-32f6-08d8fb19259d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4282
X-Proofpoint-ORIG-GUID: fe0QoRPuNlILR8PE4kblAWf28k12Nl7H
X-Proofpoint-GUID: fe0QoRPuNlILR8PE4kblAWf28k12Nl7H
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

Display information in probe regarding PHY configuration parameters like
single link or multilink protocol information along with number of lanes
used for each protocol link.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 32 +++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index bf37569c6c51..39145e56e061 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -574,6 +574,24 @@ static const struct coefficients vltg_coeff[4][4] = {
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
@@ -2504,8 +2522,7 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 				init_dp_regmap++;
 			}
 
-			dev_info(dev, "%d lanes, max bit rate %d.%03d Gbps\n",
-				 cdns_phy->phys[node].num_lanes,
+			dev_info(dev, "DP max bit rate %d.%03d Gbps\n",
 				 cdns_phy->max_bit_rate / 1000,
 				 cdns_phy->max_bit_rate % 1000);
 
@@ -2539,6 +2556,17 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 		goto put_lnk_rst;
 	}
 
+	if (cdns_phy->nsubnodes > 1)
+		dev_info(dev, "%s (%d lanes) & %s (%d lanes)",
+			 cdns_torrent_get_phy_type(cdns_phy->phys[0].phy_type),
+			 cdns_phy->phys[0].num_lanes,
+			 cdns_torrent_get_phy_type(cdns_phy->phys[1].phy_type),
+			 cdns_phy->phys[1].num_lanes);
+	else
+		dev_info(dev, "%s (%d lanes)",
+			 cdns_torrent_get_phy_type(cdns_phy->phys[0].phy_type),
+			 cdns_phy->phys[0].num_lanes);
+
 	return 0;
 
 put_child:
-- 
2.26.1

