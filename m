Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375583D9164
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbhG1O4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:56:02 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:54504 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237123AbhG1Oz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:55:26 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16SEk0Wr024330;
        Wed, 28 Jul 2021 07:55:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=zWtLASbhrYLOOI9z/E6vUOKWsxWY5gYSNAeKbG8jQB4=;
 b=P3GddK5Dcm+RaM7j9EF8WHk20fxamXevribAk4GAnKO9H2okUxcGQSuEom4lIJm+kPX7
 PSjHHrVYGTYVLo/AIMaJbz5T603rXlEjYhZXY0GG8B2zOI3OARM9HT0mJ5Z5Ek/VZX+b
 l+EVVNK+5hVbxViLUthI8/Q8jL9q5HYW25eIPkIqhpdxSgWA2FHyEigJcODX5P4Qt76T
 WdosoAPHJ3BKiFoO9PDDqqWJ3zIJ7NpKnxPrwGWuYo2hxdrArH9sPQADbNisx+fqoSqP
 U0KITMEbnKwGAGk3GEOKksxe+vxIpPrT2XQ7Nvb4aPQwKmYelRqSkSn22S9IehFPQHnk Vg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2045.outbound.protection.outlook.com [104.47.51.45])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3a234aysbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Jul 2021 07:55:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PomD1Rl0ujO+/GZ2wHyejsRofBtg5/p0jcgDBZoSJBnIIyLXNejc0N2uN8jL/gSjW2B9kyEhQHvr8gXkyzpcBK2PMPrh+AOYh/b5a8ZZ042WM0MT0I/hZulEr2qPv7fbHM/CddlDjG8MID40vw/R5ekWyDDzZDlmR6MNa+lAbOO5YwH8leqIb4/FUyLQdi7s+7YnVj+B77qwQbXwvJpXd4ynpChfgT3tvM0fAf5wBxdLDUj1waTxltHfjZtPUUw+uBuScXcUCgX+am//+w5r8reHR5WGQxU5I8jSd6XuWUWldstXk2+p8z4LVxnJw6ObSRYi1qW0pFaYbeOPOJ/2Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWtLASbhrYLOOI9z/E6vUOKWsxWY5gYSNAeKbG8jQB4=;
 b=b3zgtcvNOuz/hSXwe9csCmfcLBAtHyrGQxKoZZcVHWNa0YHYJSMtYfRCe8t+QY7HyaJOjHsFgqRyGDdkzDFOUUieoO1AU/Dk5aR/+90aEHnPoVDidvon3i6hBcetQF5/0pZWIsas52K8s3EiLn4GtMJkVgRJJuExQUPOeJkAi4dKziI7mji7nfoY2lSGLeDrwg8pe/pEhmwRKa/uIoOEdUra7BkM5TDR9ympSvQKetu2RvAk4/X0l1GssorCxWhuT9JF6dJd+aeHVdjjuMBtM4krHbcoFgJbBgUFR0IYJ2XHvsclzu2Rj7rWq+tRor6DnQuqMJqp4aSo5nDdR5aMBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWtLASbhrYLOOI9z/E6vUOKWsxWY5gYSNAeKbG8jQB4=;
 b=f5ecAWAPZgy9KW+xLuzGDVuj+f//Y0jJhPH0sdzU8HcqZ6gXrCczIBT5DPVK4ja9Vnoft0KRqAF7v/qyYq2bHoUjQnAFvfd1oqcwI4vCz+4o8IKMSL0udAKmRV++VXdgdtibfqv4AWLQ/n5tbRnK3SHv3HhCRRJAkH6dOKeyVrw=
Received: from BN6PR13CA0056.namprd13.prod.outlook.com (2603:10b6:404:11::18)
 by BY5PR07MB7188.namprd07.prod.outlook.com (2603:10b6:a03:203::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 14:55:06 +0000
Received: from BN8NAM12FT047.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::e0) by BN6PR13CA0056.outlook.office365.com
 (2603:10b6:404:11::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend
 Transport; Wed, 28 Jul 2021 14:55:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT047.mail.protection.outlook.com (10.13.183.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.7 via Frontend Transport; Wed, 28 Jul 2021 14:55:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 16SEsvrx095664
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Wed, 28 Jul 2021 07:55:03 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Jul 2021 16:54:57 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 28 Jul 2021 16:54:57 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 16SEsvLf016553;
        Wed, 28 Jul 2021 16:54:57 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 16SEsv1d016552;
        Wed, 28 Jul 2021 16:54:57 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <p.zabel@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH v3 8/9] phy: cadence-torrent: Add debug information for PHY configuration
Date:   Wed, 28 Jul 2021 16:54:53 +0200
Message-ID: <20210728145454.15945-9-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210728145454.15945-1-sjakhade@cadence.com>
References: <20210728145454.15945-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06339e6f-c0d5-41c2-3965-08d951d7af8b
X-MS-TrafficTypeDiagnostic: BY5PR07MB7188:
X-Microsoft-Antispam-PRVS: <BY5PR07MB7188ED97E40618AD9469CF8AC5EA9@BY5PR07MB7188.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5+NmXmOg4Li6b0fsiP80GIM56q19EqDY25TafeKQOAkYuWY7RR6xqDyUDEBPxlARb+/yr+cOA9kE8aEaqAE0djnz8lRywP3Dy5pdNV9eg9P3ZtwzxDR/3Hg3QcqS7AxzjZX1mnK5MFp5m/a5N80VuLZgF9/j0ax1rKfsy9+ZFTNTlGej6tvfUiSIt5QgQlBGd5Ar/fngI50T+arlR/Pt2awL2jgJuJEYobOaFJgVK6sQ8WxvOtaY2uUxVnjxptjkE/8/FwD9c+If0vdRRE82bHsfOVPbDwhX76RooNWcLcmHRX6pXES0SlsLXXObehtL4+dYMOgmsH/vYtTDyD5xrhzQtvPusYIS4vHIYNCl/xwogdngB29MXSW7c3cOO0nQNha2O65vz9D7cM5LsaVEBzWjcbUFVaOOP9IF2Z1YJLnlQWbkkal+EUDGK/6jD/mU7LEu0eJJchVrfycO/oNvnKAAVCpzNYMcvPADE4wPw6AzIou2+xYcjToxX2bC+QRhivMZUYjj5TrgHCp/HbGVY58+RyWDZ/x/p8spVQkDW/kgqNxccMtM5A4z3kIQpuLnalVRC+4sAEzYyZWPvaxvvom91rcr2JnTTKfthsIRx3aFGIGOub3kqv7CSwBzZxWVkUEc/x4QpCFAZApClhbOxlLT17p+LkRlJBBofUI+YhjiJhM9APnuDLiuucJuUdIG0VlVUezdW6Kue/XN5xeLaEsQh476mDRhAXnpFFtW5L0AIValsZcOkBdFtIOPHKugPxkN4gNYV1Zwmr+3lVmn46VpT2u3ki1S8t33kvmeyE=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(36092001)(36840700001)(46966006)(8676002)(81166007)(70586007)(70206006)(47076005)(2616005)(426003)(8936002)(5660300002)(186003)(82740400003)(478600001)(2906002)(86362001)(26005)(6666004)(82310400003)(336012)(356005)(4326008)(36860700001)(36756003)(83380400001)(54906003)(110136005)(1076003)(42186006)(316002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 14:55:05.2112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06339e6f-c0d5-41c2-3965-08d951d7af8b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT047.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR07MB7188
X-Proofpoint-ORIG-GUID: OM9ka-dyD3VA4NnsbMWflwtid43__Jcj
X-Proofpoint-GUID: OM9ka-dyD3VA4NnsbMWflwtid43__Jcj
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-28_08:2021-07-27,2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2107280082
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

