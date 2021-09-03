Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372CB3FF9C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhICFC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:02:26 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:4820 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232847AbhICFCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:02:20 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 182NR9oi011844;
        Thu, 2 Sep 2021 22:01:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=a6i4dMHOxB4UyRk0dA5AgBiPjjno9r9bCtqGLqula6M=;
 b=EXUpNW/TswoDdKHRAB8F0jp9AGTqpw3RfKGSXSi+m0LJBxl/ISstNtwPCBn8gfn9xzCi
 SDa/2V/KHwZo1IdDv6Uj9MysnMET9swOAjvnEGNr7ARFvZloLJLzMAqNISXlEp/ToJur
 j19sc/ySg/11Z4SpeqCmAhtPbebiy6e1picP+Sn/BB7cgc1DIfasDhBF5Ba7fdcktVrm
 B3oZ/+lmgWh1cZ5NkuH2X3FiR8IJO7fKaAg7aVcRIiBS8uEPk3QL2DG3iMZnOJtN3VmC
 lLyo2K53LiRDEY8gGHlSEn8ORCfLWjKql58wZbEimp0tKmGJNjq9nRwrkZ7hvqFYCRzp mQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3au8a18u3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 22:01:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLRmJ5AToRx0xQpJYNVV3pVw9coLOnnTThw/nqvWJrsD7sXHIpInbIHYPlQ8n+WWlPURkYE5vKW+PgnlBsagg0ltP1tUnoRQrpLSskDutY4knaUUPyQ9WJagKrSfrpPEDg1fztoTXhfdQTIbf76X55N4RCKCYSYbuUBQyzoxNEB/KI9h62jJmP5laQvFEmJDuHFI0Vuy1EVJbyk/TrG+4OxJNaS1rveS6Yc69YFewli02iaz/1XeptRvVTARWUksvGWGhOjkEvef9M3FY0FQkMgD6Y99HeJ6b1clU1DoQMUjZlA3EMdfXQs61MhvY/nNbTK0QAuRFIn97CYGUUVjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6i4dMHOxB4UyRk0dA5AgBiPjjno9r9bCtqGLqula6M=;
 b=KOTrHOO+n0zK+hppKvraIzK/6UfgbIF2s1zwuOxwr+HG+bWHNOe2oPZWzWylrK2yPX3nTnEvAjnVkCeU6Ser722/pSlLkheqEAqI/VgyHweGwHXhzjwQstmEfu9FSXkXDS68ylBYl9GElv8u6IpCB6bK3C40k6waG4eq4EQdaZasZbiqoobslstJUIsvlVZ6uQa5YoROkAMbSr3FUHXXL5XjXod4uvSLyXk/ki88ZY6Qz2x3MqwiauaTWsJ3I31PS8ldJG9216e3ODCotFz0LmRR7+HMwmvOcblpN3uA1mamk3NFj5SZ5unvqS1QnBtIWVRnbPAPgLMvL0aDoTfUfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6i4dMHOxB4UyRk0dA5AgBiPjjno9r9bCtqGLqula6M=;
 b=vcTqkZW5wyCRFtH5onfh8v+LDMJUFmAGwDpRRL0bjoF/G1CTQR9tpmwmlhNAusCa35u5IlQ4cxDghki/1mBUBbX0CeWBTcI+qD8Jml94sAVE81vEhqx4XEtAOqSb2UoAsk/QvPwgwDN1GFLumyF+rGiIMUP7vfBrbz+pokNVAnI=
Received: from MWHPR18CA0071.namprd18.prod.outlook.com (2603:10b6:300:39::33)
 by BN6PR07MB2788.namprd07.prod.outlook.com (2603:10b6:404:40::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Fri, 3 Sep
 2021 05:01:00 +0000
Received: from MW2NAM12FT030.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:39:cafe::c4) by MWHPR18CA0071.outlook.office365.com
 (2603:10b6:300:39::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend
 Transport; Fri, 3 Sep 2021 05:01:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT030.mail.protection.outlook.com (10.13.181.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.6 via Frontend Transport; Fri, 3 Sep 2021 05:00:59 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 18350ufU020399
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 22:00:58 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 3 Sep 2021 07:00:55 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 3 Sep 2021 07:00:55 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 18350t8l025685;
        Fri, 3 Sep 2021 07:00:55 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 18350tCj025684;
        Fri, 3 Sep 2021 07:00:55 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>, <lokeshvutla@ti.com>
Subject: [PATCH 04/14] phy: cadence: Sierra: Add support to get SSC type from device tree
Date:   Fri, 3 Sep 2021 07:00:44 +0200
Message-ID: <20210903050054.25627-5-sjakhade@cadence.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20210903050054.25627-1-sjakhade@cadence.com>
References: <20210903050054.25627-1-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0b6b0b0-2593-49eb-d825-08d96e97d247
X-MS-TrafficTypeDiagnostic: BN6PR07MB2788:
X-Microsoft-Antispam-PRVS: <BN6PR07MB27886604DF8CD1417CF69E46C5CF9@BN6PR07MB2788.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:206;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FAjRcmbj/+MU2XG56vMcptnQZhbpwBfV03A2Z3T7hLPu1F+b7DebV1ypkWIcR9I8K8JB8IiB66BQQYL5cWwtU+iCtqhA869jef9EhPAA3Sw1Rt2vOOOZRhlwI2MJSwWAa+HdObLfpjHCx/EiyJlam7vOntovej1s5o58DPi/ng0GjvOyJN/U3ykHilnY4Spxed6gyKDYhJ638ipNGdcm9x8rNiHR8pG2yHhShVudTwqmk7dOEBNFi9+Ama2NUPI3gIaNQbyUoWgHNY4rww1pQ8o0fFfP2MHem1XkE3ng6/FxjDQKxKX1OqBVS6mqAO6KT0qwrfeZjcpXvYLty2rmdZEj3vWSSpkxHgEEZzaXjYqY79iaRAKzUZfbeOLNZaEsB8aykTULIOp8fzY8NidojQDlDSNtdwq/I6TI9DawXN2Qn6Bx6STHcZBSeqgEP8vQpv2anHN7uIGMrwhD9X14xZqu4yT6Zm4slN0BmQFwwwAggBgr1UE0s8INf0a1u1Pa2pSbtzQl2R83eN2dumvJ7gxHqo1xQXNSWwRnAYy5RjZ0895wCzbexOE+T2AYqdBofNSGktMsyan33L27x6HEGPsBWNiv0RIjjDJ/oxYRT2t3i6EAK1/BD5YCsIUg1xzXgcWpU9cWZCyL6B9AepvK30mbTg7JGOrTjznRVPL91Htg+ejHUqgHMVhB7voEJqned4KyHdL7ZowWi+BKatj2i8iPp0W9Het0yj0o08UIlcQ=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(36092001)(46966006)(36840700001)(356005)(7636003)(8676002)(70206006)(82310400003)(8936002)(42186006)(2616005)(54906003)(186003)(336012)(316002)(86362001)(4326008)(70586007)(1076003)(5660300002)(426003)(36756003)(110136005)(47076005)(26005)(2906002)(83380400001)(36860700001)(6666004)(508600001)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 05:00:59.6126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0b6b0b0-2593-49eb-d825-08d96e97d247
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT030.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR07MB2788
X-Proofpoint-ORIG-GUID: zMGWfRFSvPzu1xoio6LOx3WQ6N_4c4g1
X-Proofpoint-GUID: zMGWfRFSvPzu1xoio6LOx3WQ6N_4c4g1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-03_01,2021-09-03_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030030
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

