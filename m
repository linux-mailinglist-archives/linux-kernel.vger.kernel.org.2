Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFF342EC49
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbhJOI3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:29:50 -0400
Received: from mail-eopbgr1320108.outbound.protection.outlook.com ([40.107.132.108]:20016
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230186AbhJOI3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:29:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4EmAMCJWG5wPxguuZxUgof3Wni7btJ9VQ/t8+c3pjAEMYx0RlHhGB7f/SPENATdRYwP2+5zyJ/Fln7qHYRGqnGCToqdXMNs5GjN9YmeB8BwuJ+Onc0M9DTlonloCCfBpL2YJRsFgFJHDmSYAaFg4EUb1bWy4luhNCbnMqPXu6r1qhD6gzwAzGxum2T3ZcYsiIKm3jRBrSX9YDGk5EWLGsTHAY4TJWQf90Yrx1P6/tGZCpwJRmslJxT7E5GyV2XcKLi7VbYD4HlVMAOyE05dL5V8+NWHkRY9os/nbi65EL8CHOGSbK0bswASPeG28Ul1YKpSYAKBXO2XrV0xFyzBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JH1VTdh1XPezlfmg+nh1omUPqvWP+PoiRk4MTQFaoM=;
 b=MDIJtBYryHpcCKmbay1T6h/nV5e0pkwAbx9B9QhXfr7IJJB0Vz8O3V1WkuzhZd6D8WL2c5Ozbf80uxK76szG/7H7vFwi83yfWS5h/Yoq7+wl3Nr2cdYB4iu/yeTV0+FQ1zY3xe15UUxMCfZxMPlZxrNlns922eHCBEmZLn2sIO7sXEfRrFvbyf8ZB65ZSJzGnfox/vm1/U3gIQdNFWM6GkqRuOK+sTIX1SqCWrahTyuc/+Y48svXqe65Yo1f49RQcFEBF5gLMzvEXwFpKGjXmzqUZxtx6xlm1JDtIPNpa5dz0o/7z58z/qdaMlLIuBAU5GCzSSEYrX3E8n8V3Yq2xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JH1VTdh1XPezlfmg+nh1omUPqvWP+PoiRk4MTQFaoM=;
 b=QAB5i2JNxQRSDR0CKLwFE7790o1RpIP2r5RwpA1U+smJlqMZxPbzb3JNKFuKqwyq3d6N85vVo2iOaLffidvOmpa8pAH8QHNCN14GsSJnlAweWZmx0rH2EU+EnXVohwl7Tb04Xxbq8nSZMQHhF3Ip+FFQ1gDpUlGXw/lDfiinvfU=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR0601MB1951.apcprd06.prod.outlook.com (2603:1096:3:7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Fri, 15 Oct 2021 08:27:39 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.017; Fri, 15 Oct 2021
 08:27:39 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] of/unittest: Add of_node_put() before return
Date:   Fri, 15 Oct 2021 04:26:58 -0400
Message-Id: <20211015082658.19005-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0068.apcprd04.prod.outlook.com
 (2603:1096:202:15::12) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (203.90.234.87) by HK2PR04CA0068.apcprd04.prod.outlook.com (2603:1096:202:15::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Fri, 15 Oct 2021 08:27:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ac9b53e-1280-4c44-86b0-08d98fb5a632
X-MS-TrafficTypeDiagnostic: SG2PR0601MB1951:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR0601MB19515F077F1B04A99918F44FABB99@SG2PR0601MB1951.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afZE3O9Xs2vgY2N7SrF9OMpsuA8NLbrQVkiK1rhs7bkALhUSsKioz93EJjz/eogsw86cv5dPdy6mRsKAbPvUUp6tuL7SY8v4HrCwndzlchr2qEwwJt/dqV9A8bxeT56pR2iuiLMpRvxErXSLWmztxpAQtDg2XsBfEIY489bmm2Nj5CMbnz0ysCZIRt1ltREVzkvIXOtasqnviJnv7YzvUWHzO+HujAeb+rBMBZVUxnOR0Rj75s27w1G5GE2q6gaSo5Rd0AkY/0zMtc5AZZVSdbYuyWIFr76a66NSY87v2fvAQCd3OgXj7Bd6aqRKTKSkB2wbBZr6d+i99ayD2BOL0HQJlyrkZ3k3QlgZ2fU53hSHlpIyR/QCKN2FCj2kusI3kUIitPBjzLz4qvT+a37KT/B21PtdKpZE5MaZFRxgH8ZdDyh5aI3qmgCS13lF2SduSIqV47dPSA1kzBHulxdAx9B0ZnUqF++zGtfE1n84f/3s0Nl3Jo8BJ0ITMth5hge/Q2qmqAdttqSbA42fNaswGXHHIMMFiNYFLJ3unW3ckgMcmukewBjsP7GV8HEMjQVhGxt9UYYbv70knsMwSlOebhkBvaa7lB9PZ7a7dJoIDbHjqdJA0q285JoeGH15SjSwR93dLqrxoLjslc4gtdrFlfWhM/ej7hEbK+Rm5kJePcVubJN8TXv8uJC68DVIOEqPdte91tZrmgmJTeHwma3JTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(186003)(4326008)(956004)(6666004)(508600001)(8936002)(66556008)(86362001)(8676002)(316002)(6486002)(1076003)(2616005)(83380400001)(6506007)(66946007)(52116002)(110136005)(38350700002)(6512007)(5660300002)(36756003)(4744005)(38100700002)(107886003)(26005)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TeHQjy6i9USfC7Y2BgWTKmkF0UfvQNdaDYAsuztcGEgxyHP65HDw/e492h87?=
 =?us-ascii?Q?rmU7qP+yib+0g5BcOXz0DiNry3YvCYGgO/8u/bwYxxS77Mc5mjwtVSvZf6WL?=
 =?us-ascii?Q?mDKL+odflhhfCwZzrwTJfoyZbAklOFMLok3JUMEqzxDHdWDxVvfOmrdemzTy?=
 =?us-ascii?Q?LHMbn2aSoRIzJn95l2iPnSKoa5+bMMtiSkGuHCCZKJ71YgqIjI9yiHkh16Xm?=
 =?us-ascii?Q?8ISnTxma50Ia78M1o2NZv9dre9Z+jinCNAN2jDerSz7Sg9sTyCyrdWLVCENK?=
 =?us-ascii?Q?BsaJCsIPiMavXYaKF4kBlFXtyzjOu8pSvHOuMiC/z5ERPu3pIlsNv4RN31tS?=
 =?us-ascii?Q?ebLBOddcasa5dApfaoaJ1uo12DERyH3CTfCftn56CzfcWWMHX+mBYjR9fWs3?=
 =?us-ascii?Q?2EQvGfBopyY9gYUfB2g1UX/a6wFKPjtz/M5pLz4L5SSYZqnwhzNlge6GKJCG?=
 =?us-ascii?Q?XEgFax3Pb1VSTahvOx93bOZdc/l4H09z3h7T7MyEj6FIoXy1yz4f+FcIAX29?=
 =?us-ascii?Q?htZE+7+ftHubXRRSc9qqQtn4YV6sNuvYQWFTQ2tTn6jI6RuHuI8A8/kXyyOa?=
 =?us-ascii?Q?6ivVNqUITNFvPcBg9cIAJpx1bYzgGnsWp9f7Bzq+V/DtqzE5rlyiIfdmEvn7?=
 =?us-ascii?Q?9FW3nj23Iqmy3oF+DF/355oObmyAN7Cffz16snfMZy8T/fAis4D4jWtgS/OT?=
 =?us-ascii?Q?fzTOnVZEjRhd1H9rxjUysUsc5LBjY5XSs4cd5++yY0be9/WGT6DvUpkl+r66?=
 =?us-ascii?Q?l04U+ctOHDgIMnbUx63btJt4ja2cO3eI7qHdEJtLO0kk4TCNry32LRYy40zm?=
 =?us-ascii?Q?Im5ahvwyhHdSR647gX7X+iMJkRKs54R6ZEi2MQOyyy9avDxWy3coQH2RGfNG?=
 =?us-ascii?Q?XzKq63mQGDbE1MFdle4KciU5DUdSeTc9kcAGU/pTeI3sjShZZ/IpFlIqApYN?=
 =?us-ascii?Q?wb8XooGjRV0HJ/aUdhnzPdpqH4ClrMMDluY+8SGQqWx9d4k0OQm5p7Id1Ui1?=
 =?us-ascii?Q?7PZaX41oZERU/xyxd4jt9j8og8k4hog/mGJs65O6AVxJhaI72ULqh4/l0WU4?=
 =?us-ascii?Q?4cuZz97Lc83c6+QRPoFrAGrnNvStgxZJbGsGqUllsoGbNI4KVN2ENOrhj/nG?=
 =?us-ascii?Q?BfsD4bd/DmlfVPm7IzH51llghzujc0JNAFHjdGhj3W0oVzb+NF04jb/I3auK?=
 =?us-ascii?Q?W+ZYS8Rcjdr7hCemPu0IdwVaN2JFzogGNZliPwNrj0sAaFfPf22xLyEk5vto?=
 =?us-ascii?Q?tdyyrpj0WxtKYqwv79YJLf8pFjfspI8NyG8uYUSkx/QqFPxdSLTMaKdscJWz?=
 =?us-ascii?Q?wR6vO9kDI14jFpO6Rq/6vLkV?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac9b53e-1280-4c44-86b0-08d98fb5a632
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 08:27:39.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 18ia7ymOnAkktX4yb8ZmevhF6vK+Ivjjq+GzZVT31yOIzlr1lkACKovMq5szshuliN5gCyxV3xtVCYbvssYlnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR0601MB1951
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/of/unittest.c:3091:1-23: WARNING: Function
for_each_child_of_node should have of_node_put() before return

Early exits from for_each_child_of_node should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/of/unittest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
index 8c056972a6dd..b8d2b669408a 100644
--- a/drivers/of/unittest.c
+++ b/drivers/of/unittest.c
@@ -3094,6 +3094,8 @@ static __init void of_unittest_overlay_high_level(void)
 			if (!strcmp(np->full_name, base_child->full_name)) {
 				unittest(0, "illegal node name in overlay_base %pOFn",
 					 np);
+				of_node_put(np);
+				of_node_put(base_child);
 				return;
 			}
 		}
-- 
2.20.1

