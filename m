Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC42F4039DF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 14:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351527AbhIHMbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 08:31:31 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:8530 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1348910AbhIHMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 08:31:01 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 1886da7t016869;
        Wed, 8 Sep 2021 05:29:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=a6i4dMHOxB4UyRk0dA5AgBiPjjno9r9bCtqGLqula6M=;
 b=kLWEMXtn+vHnEC6lKntYpy1qB40Un5zCqeGMzp92WtgZo0sT4imUdmFUO9lDeRzw2nog
 EWo92tA490BzSmVkSP5ndQUIZuYts7p4f3alOfZcfypM89X5O53FUkJUZgZ1u6vj4j8j
 FFHQQUmqb23dW1JDF1BaevhHlobrQqP3oGUMfserU+szdzvhY3SqYB5Lgq5YT72SalCM
 P+a8pRwHQybNtLI620/LuNoXI8pnmGLlRx4Qny6WaHyv8n7QsQDb+jebE6FATxZQJ1OY
 wvByf/uYwPu2pUpReqIlkRfregQaPn6g6sMacxAUmQyLZlTAMaM74GM9fV71T/0H+CbE Qw== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0b-0014ca01.pphosted.com with ESMTP id 3axcp9k47t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Sep 2021 05:29:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjCOb69/k8zvYS+1T4ssPQZ1y4QpYz8BLCFSR0U5UBORs9pAXGVYNk7lEgkiwJAjSR7/eoHq6eEBk9o5GG7Ky2JIJBqkBentPYoVhCCjLJ2jIER5B6A/2mLxEytBx1pQ7QQexXCbzwaF8d9H7u5L9Pm0IVwuUlklOI6IM+QgvRZ0pp8GImmLoNVsXO9NeLerShGksLK2sirsPqlTRReAwmEVzi0vf9w8vsdStd+KgqiCQqfrT7+Z1Cr78hUyDE/7yC4plsXyMYZ8oUd/YAk2ToKD0RUli6V2spnuYCNCEVvkh9dZ86kDGP+uPQpkaWyukzgLeURGeg668M2wZYZHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=a6i4dMHOxB4UyRk0dA5AgBiPjjno9r9bCtqGLqula6M=;
 b=bfEquEZK+/ub5qZmAN0IZ+Qgh4C+nFM+1LUziMojzMSFjUqrrqhqht/pmePzU+gdR4POXFzOw687n8RQ+8qDQvpF7MSpoE+3fppY+jn9J1JSXmjEKg4QA7aoAybXO5Kkz/Zswl5V5KIROC8rmbMl7C3lEgOWmZJgHv95Q7voj6RnQbjBfxjdtnKbI1vXVfTkSLVm2YOioxVinpnMQ/URWZCEKlHkc7X8M1iFc8Td4uA1GYJkPrmqLX9XLnlQGLpdV1hPjvtMSn4ov5vr5tAliw057DvSoFx4+5wzn5Cgple69YelC6B7S8Zqtkt4IzYYizYz8rmMIytjeX27rt3Sjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6i4dMHOxB4UyRk0dA5AgBiPjjno9r9bCtqGLqula6M=;
 b=R5/2znWWDrlxpssUKzoo1J/foESnrtOtr4kAK5jaQnAD2m9TjOEvkzPLzjb9nOsFYL+qO3oyzADziDd4e05HkinCLqH+KvyvwDPWmFu8figq0Rf5lf6Sx9a3uDz6W/UrelUGw04D9QTkyQgCFozhf4DnFIPEa+F8FzVIAkSk1P4=
Received: from MWHPR21CA0025.namprd21.prod.outlook.com (2603:10b6:300:129::11)
 by MN2PR07MB5920.namprd07.prod.outlook.com (2603:10b6:208:aa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 12:29:38 +0000
Received: from MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::15) by MWHPR21CA0025.outlook.office365.com
 (2603:10b6:300:129::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.3 via Frontend
 Transport; Wed, 8 Sep 2021 12:29:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT021.mail.protection.outlook.com (10.13.180.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Wed, 8 Sep 2021 12:29:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTX9M026939
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Sep 2021 05:29:36 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Wed, 8 Sep 2021 14:29:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 188CTWxA010288;
        Wed, 8 Sep 2021 14:29:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 188CTWxx010287;
        Wed, 8 Sep 2021 14:29:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>,
        <a-govindraju@ti.com>
Subject: [PATCH v2 05/15] phy: cadence: Sierra: Add support to get SSC type from device tree
Date:   Wed, 8 Sep 2021 14:29:20 +0200
Message-ID: <20210908122930.10224-6-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210908122930.10224-1-sjakhade@cadence.com>
References: <20210908122930.10224-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bd53d6e-154f-48c2-decb-08d972c45275
X-MS-TrafficTypeDiagnostic: MN2PR07MB5920:
X-Microsoft-Antispam-PRVS: <MN2PR07MB5920D6866FD801E4AE7907F8C5D49@MN2PR07MB5920.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rlNCsWRv9yGM9FCprkHGyNKxc1ObVUYEDxUxgT7eiPBhiUAz0N3qhCjaWib13oFQOyRLkrePl4Vi0tywxYqbMcl7XHlCSDk9CQN9bvqSTgvWlxODcjY9yg2Y2kCObXNWIMnfL8LaCz/jyCb63gyC64O+WlhqIlvevToIBL0mnTOHbzP0iW10p/T87pCdBm4p8iaGnRYjy9DiI1kaXa3VQijmlSJO81+ZCJvtKxNK37t58XwX0O9DGOeQ/dX/XtlLHKKtP09CLRUPLvlP1pauwkoIAgyV1JEIpgezLLaMPKx3yt10jVhADba7MHnoBVR8wnXNGK0LssGrt8sNksDfDz5bBGx07baCz9kkgp0cOdjS69q3f2fnUIYXFA4U1KG3dZF5ZW6MrLqLf/KVAoPgjzj2OLSKm91/3OLtLQwu6EuIJxwrslxroUj5CjRxHj6DLqHNUJMLQzXaPEwf97lNbIVtAhn3lWX4ba/EtmojcJEEwJaVzAQFnyGuXw5uvvu8i6Rq3LesMVr33Rq+KwLJuthw8kXX+20QM2C/y+twlxDD1OZqtVHmr+k/7XxYiDVvHg0ngqJLLrKX4rxvrnV0NFF7t8oN40Z0MDoSctPxLN2GiLJDnhe+Lt0H4gqL9wy542yFQT+lR+FIwlB4mcnS9Fd2fS5tAeVFRwtOOMUipwgfLF1jjEURoVIyikIuu3anXFrvwQigBMMgLav31R9R82W2Lr1i9xQcM1d6/hXJipk=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(376002)(396003)(36092001)(36840700001)(46966006)(426003)(2906002)(2616005)(47076005)(36860700001)(8676002)(86362001)(82310400003)(83380400001)(478600001)(336012)(316002)(42186006)(110136005)(4326008)(82740400003)(7636003)(54906003)(186003)(36756003)(26005)(356005)(70586007)(70206006)(8936002)(6666004)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 12:29:37.1699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd53d6e-154f-48c2-decb-08d972c45275
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT021.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB5920
X-Proofpoint-GUID: 6kQnyNtqOG5czOKbJZDw8IadQKcRgAdl
X-Proofpoint-ORIG-GUID: 6kQnyNtqOG5czOKbJZDw8IadQKcRgAdl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-08_06,2021-09-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to get SSC type from DT.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index 7e0f36dabc95..31e5d428dc03 100644
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

