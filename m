Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B39437B69
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 19:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhJVRGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 13:06:17 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:35662 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233617AbhJVRFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 13:05:31 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19MEgLoX012879;
        Fri, 22 Oct 2021 10:02:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=lJ9APA/34eI5B9CvFGyKfrTut9E+AyzRIvFFkYvjYaI=;
 b=WK+AJ+8GSsC9jv3gPaDSSovJ4ZgLAV3qr7VlQIAXFzuLu/BPi4VGJBVoB/84NtdPgJK3
 qxVnVwVsi8+L81sZkfWBA2iA1PzLVp+KItZlK9L97u9P8o2cZ+FYVBUU1NzKjMMHSaAR
 DRc7iqjXU+R8Mj5ak1NR37umV7CyERk+VIboi8XvwjliZgcJPV4zinjIWp3+EEajXf05
 9TMuJ498AzDrTDPvYobmsRV8QCq/nhNnAuBLjair06z2VpSh8RChzkk8US9vdfMbDmTL
 tzWQ2T6t098KutfYTFNpKm/PqpNEjkM8dUo8d/130voWbfrWjYm85bniGyEipoVDC2D6 ig== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3buya2resn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Oct 2021 10:02:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmQxkk6HUz8Cxbus/VVePRrNL7/K+HtAGi1F2HaRyDJryzT38Qvx48eYzofXvcMgMTW+gdToWkMS7K6xo7aSgbLNM1iLNWeDqQCav3sjdWiVfdWnKDRy0rfjiEUf+6aHaWjqpzZrLTDE5HIq5euzN0LGxXU26cNwxQOd6r877btGtIjCH7zk1XXAnzw95k8CC3pzQk2+WqLxLZPpy6/KSpAdcXvm/+VvI2VtADj60D2zGWTmeEdCRnc6dRhyVm86Z5S9FVgYQ1/6yEdX7FWo55aO6cNRNel7zynbr+Ad0+61B8iBrSbsOLjuxsuv2FBOwmpYbKhIXG0AscAsc+XlKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ9APA/34eI5B9CvFGyKfrTut9E+AyzRIvFFkYvjYaI=;
 b=KbVdevJWbqNvSUL/3t6G0In3wWoX0+l1yzWQQAMsXzmlcu3CS5K/vrkN7oUm535nQlImoRAm/8t62U/VtHpb1fB+UZgUIuCH6a0jb+dvWP+DrqrBW+PxH6+qwr4/qzjKZIcZe0/YVPhjwofeFRkI0ozujIDXZAR1cvfSk7X/z6ORj/HoXdxCRTBZVoAEyZZLmMoVpBP0F7zXQ/hZWsgLR527CHNm0jVO22I/0e7LH/Q8tOOaEngnOzlIogaxX/kQBF1/5KwjewZe8U/Wy1Pxoga4aviIex5nZiRcxWvvP8AIIEU7xgi2bDLvannl2oc281pmkoltfTLxjlu8Gqbtqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ9APA/34eI5B9CvFGyKfrTut9E+AyzRIvFFkYvjYaI=;
 b=nasjcWWJRUTo8Lc/+baaXr6acQrfPlpXbfOVMeAIdJ7m7wqhTcstQQYxhX3huuAFfvfFAefWaf4OvQq01RC/ZKbvvmdXc3nto/gY8X+gxWGbwY5eprOrM4oZU4Q3dg0icxMuDMEgwVsb8vO2tHzvAQclBu7KsHKGUjI8/KK4qvk=
Received: from BN6PR19CA0065.namprd19.prod.outlook.com (2603:10b6:404:e3::27)
 by BYAPR07MB5848.namprd07.prod.outlook.com (2603:10b6:a03:13d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 17:02:50 +0000
Received: from BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:e3:cafe::67) by BN6PR19CA0065.outlook.office365.com
 (2603:10b6:404:e3::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Fri, 22 Oct 2021 17:02:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT068.mail.protection.outlook.com (10.13.182.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4649.8 via Frontend Transport; Fri, 22 Oct 2021 17:02:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2iNI008564
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Oct 2021 10:02:48 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Oct 2021 19:02:38 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 22 Oct 2021 19:02:38 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 19MH2cJL018906;
        Fri, 22 Oct 2021 19:02:38 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 19MH2c20018905;
        Fri, 22 Oct 2021 19:02:38 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <a-govindraju@ti.com>
Subject: [PATCH v3 05/15] phy: cadence: Sierra: Add support to get SSC type from device tree
Date:   Fri, 22 Oct 2021 19:02:26 +0200
Message-ID: <20211022170236.18839-6-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20211022170236.18839-1-sjakhade@cadence.com>
References: <20211022170236.18839-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9b94849-f9be-46cd-c7dd-08d9957dc719
X-MS-TrafficTypeDiagnostic: BYAPR07MB5848:
X-Microsoft-Antispam-PRVS: <BYAPR07MB58486B9BF8110D7D6CC95B56C5809@BYAPR07MB5848.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E9W3WRsmItjBZioYQEzF9wiarB79KhRfl+4IreVuHYCBXf5lFQWnWTNaWNs2lHmkP6g4PAqpW67fpkAb1jpOScqtg1LwSSEFhDhEN3Hjs0u2rvrS7B+0KHVyCYa7dX8zqRALOsMh+RStApFKr2SS6tXTVEUshy7G1Mrr9ixgw9mMrLvlVtBAm3Goc6LTUHB8CwGsi5A5cw63KmWO3ep7GeD56c4AacE+wUkAt+x8BeypiU1SzqIfxlpZUhmv9oD4eRF9/JGlVhjuNJ0O/CXBQ1594hAA9nzeEgUq9X9U9VB6V9NJpznzUqJaZiCEOZ4wyiTDwVvm+Iyro9NvavuDmTLGw8t7uxLec/hYpMTAM2ziZ6qXjq7g7pR0iJzfaFqxq3Bov1Xcxcb1qe+tVVf/naqXkfOmdJC3mWhxDffNlUnQUlVG6w88Un12NTyT5Nudw8gLswhpxds0csStamkEmeSAWjJzjb+hj3xaG2hVKzl+DQdgEDHEaNlKZbxCUlSF09+uSa/9wfYtY9GjqCLbbksunQHQtTSoq3VkEjHYCZLQUNrDi7s4LQzFDvTcF1wdVrldVr8nGksv9M7yOG+7NJmOpJGwKpkvZ9g5tz6KRFA4Yt4oPSjYf1fFRd6QoCOIgCfUes52ujyzZU1YLmZB9c5WY5x86PO4617LgKTCKptZ7jr2aqJ+FWvU115jiYAAkzeyaeq4YDbdK8vlDexm20bfFmHh9mw4w78unDLhnTA=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(508600001)(8936002)(8676002)(7636003)(356005)(5660300002)(54906003)(2616005)(36860700001)(2906002)(47076005)(36756003)(82310400003)(26005)(6666004)(336012)(1076003)(426003)(36906005)(186003)(4326008)(70586007)(86362001)(83380400001)(42186006)(70206006)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 17:02:49.1972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b94849-f9be-46cd-c7dd-08d9957dc719
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT068.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5848
X-Proofpoint-GUID: w4QcrTSJa9q0K_KP9pRBk3zXBiGgxH5A
X-Proofpoint-ORIG-GUID: w4QcrTSJa9q0K_KP9pRBk3zXBiGgxH5A
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

Add support to get SSC type from DT.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Reviewed-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index c82ac6716f5e..4674328574f5 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -238,6 +238,7 @@ struct cdns_sierra_inst {
 	u32 num_lanes;
 	u32 mlane;
 	struct reset_control *lnk_rst;
+	enum cdns_sierra_ssc_mode ssc_mode;
 };
 
 struct cdns_reg_pairs {
@@ -360,7 +361,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	const struct cdns_sierra_data *init_data = phy->init_data;
 	struct cdns_sierra_vals *pma_cmn_vals, *pma_ln_vals;
 	enum cdns_sierra_phy_type phy_type = ins->phy_type;
-	enum cdns_sierra_ssc_mode ssc = EXTERNAL_SSC;
+	enum cdns_sierra_ssc_mode ssc = ins->ssc_mode;
 	const struct cdns_reg_pairs *reg_pairs;
 	struct regmap *regmap;
 	u32 num_regs;
@@ -623,6 +624,9 @@ static int cdns_sierra_get_optional(struct cdns_sierra_inst *inst,
 		return -EINVAL;
 	}
 
+	inst->ssc_mode = EXTERNAL_SSC;
+	of_property_read_u32(child, "cdns,ssc-mode", &inst->ssc_mode);
+
 	return 0;
 }
 
-- 
2.26.1

