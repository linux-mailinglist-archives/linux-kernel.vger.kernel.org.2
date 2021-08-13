Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A403EB445
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 12:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240211AbhHMKsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 06:48:14 -0400
Received: from mail-eopbgr1320044.outbound.protection.outlook.com ([40.107.132.44]:28384
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239606AbhHMKsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 06:48:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2QWPPkFpm5/M9w7H1Er9Zo/mY29E0qUuhWep1Sk62XNJSjHU7PLY2oP4tIKFNVC82HAGjadUnmPFVKx4Gk3T5TjoM8D7JJR54EeSp9/7yzG5pJao+rGhqTjjjELfw041urNKqBfX2bYiQ3Wftb2p1P+LFfQMomaVXK3l0eXtmWcz6ZjaFf2oVdg/O53xpMbxquVaJIUjcQliEsQ3KqHL1qeXnJvv5n40iT80Vr6yvFuXeeZPr3o866NGWI01LQLrMIQdk28uFhSClo2JgWfM9s1XJHiGyeaRwbVglx7W7bGZbzN9t1RJBfq4m1iGDsYnsY3rC5/xnw/ZCwDiVQh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb3oIBPmc95q2VNFNekS+qea1GU/5ROCxQSsm+7ESNc=;
 b=aLcsXtW0RKtXGCkV3TyVnKLApjKnHS1kWufFAUn3cwvumODVNCVDW20xRpvzEEZYG6Ak7AJUzvZ/eABE78+Tx1nd4kO9M2ZFJdzV/z4NvjtUtp9jyU/oI5JayOm7/aSckEMLe1rVxJigeVG9cTI1KtQ/T+YSvBkIomYvX4YRSs3vhJjWzavrNTPJJ7i5/RlKI7A9VnxAsyp2a0FAWjQv77FmJ4Xuv9m/Oow8oJzo7tjRZrEfv1u7SF9SVWvIxqdT63T+9fxKozmusfqdXDd5gFCUvOVB4FGZOQvzv+qFs7WBwIEbgrCcbZkNp2fZCZAAarrSUm33io+pVw/2CfxBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb3oIBPmc95q2VNFNekS+qea1GU/5ROCxQSsm+7ESNc=;
 b=hbkKVuuid1FfSBvxt6qwpKFl4pyISX0heSQpp2cho/6WxiN4E0ka22XoNhdCNSLQ7cOoEnvndfdk66bF4fmb+Un3sUWXGBtsXoNb+WR5QzGSUN3SHtfaXzvXdKQnfETeLFWs9BLr1TBY20uOPbj/hN+eH1qDtimL0senDVDOfaQ=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oppo.com;
Received: from HK0PR02MB3154.apcprd02.prod.outlook.com (2603:1096:203:6b::15)
 by HK2PR0201MB2225.apcprd02.prod.outlook.com (2603:1096:202:7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 13 Aug
 2021 10:47:42 +0000
Received: from HK0PR02MB3154.apcprd02.prod.outlook.com
 ([fe80::3594:f84c:ac41:bd48]) by HK0PR02MB3154.apcprd02.prod.outlook.com
 ([fe80::3594:f84c:ac41:bd48%5]) with mapi id 15.20.4415.017; Fri, 13 Aug 2021
 10:47:42 +0000
From:   liuhailong <liuhailong@oppo.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liuhailong <liuhailong@oppo.com>
Subject: [PATCH] mm: add kernel_misc_reclaimable in show_free_areas
Date:   Fri, 13 Aug 2021 18:47:25 +0800
Message-Id: <20210813104725.4562-1-liuhailong@oppo.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR03CA0015.apcprd03.prod.outlook.com
 (2603:1096:203:c8::20) To HK0PR02MB3154.apcprd02.prod.outlook.com
 (2603:1096:203:6b::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from PE80250894.adc.com (58.252.5.72) by HKAPR03CA0015.apcprd03.prod.outlook.com (2603:1096:203:c8::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.9 via Frontend Transport; Fri, 13 Aug 2021 10:47:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7db5d4c2-2988-45bc-117a-08d95e47c692
X-MS-TrafficTypeDiagnostic: HK2PR0201MB2225:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HK2PR0201MB22258669A92C21CB68BF9F8DAFFA9@HK2PR0201MB2225.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:52;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LRPg3kujtRHpQ8Y5f5xXlH+wptaWljWHxVI1iPkpGoTWuO/214uyIBLCM4XhqoJysnOX2DEZZ2Dxn/y/ARyaMYWM/AncuY7f1Aq2JfyPgZDdHknm1TmgUe7pzuNxwj3s7NuKcmXOTU7Mc42Q6EO1Kl2EIEu+uQ1gg40WCGHkQ207+G6W6zVrIDAyypYzL6xLNl5U6INm+oD1R7QR8hkEofHEwTaG7WSpT37wEy8d1UpXqZrViHkGFKjjRp5vzAviS3/Otin4ia+neTfK3ZP4sFTCXdL5QCmYsf4r4BysGKuM43eHoy/X4jJ5Y1C2lHgA/FzYm5Aa06g0evNo/54LDr6HCymvbQ1NDbq8SgCg8QQ7Drtz9/bm91LI+I4sTMymB8pmHf+Alopbra7zi/78ur7BtT6qecL604NkCD5RnqYhMcs8DYh/Nt5CosMcCBTfiD5AecKiyLxMAOzOgfgMpcQEJaILb5a2ixj4Xft1UZnW8IuFefRnXjLShkzQ8wzeaJiSWBH7Vv0wLFZej4ZKY2d73aCrPq7fSOz0Vsc8Ouwj8Wxvgrf9r+21lt5/Vhlt93Xfo0Md0Z4nvoP+OBQhvCe9fmSdieRbUWjofUlxylbOWzeN7xeWzbqDDjS0Yvcm7bJUbWQQws0IznPYwjNbFDk6u1PbmrU7vYPZ7E5RaYV3mGjt1wVwq55Qtf82bHV+PqGlEFfs374m07l9L3z51BCuy/VhwlMIfOaiaygrdy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR02MB3154.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(6506007)(6486002)(38100700002)(38350700002)(4326008)(66556008)(66476007)(66946007)(316002)(8676002)(6512007)(26005)(107886003)(186003)(956004)(36756003)(6666004)(86362001)(52116002)(8936002)(2906002)(5660300002)(478600001)(2616005)(1076003)(6916009)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9w+GQYhYivZU0ba0lwre/e5ksD9y6BLPOI6TyOtLFD+QMtLz0msQXmSHHBjB?=
 =?us-ascii?Q?3WCDez1XNuw5Ws7I+SxsdPBF4DlLRpNOWyGQ8eLnNe7rxZrya7izEN2khx8N?=
 =?us-ascii?Q?BCCsqAh8QdkKP1LEwfxqwMHXjVtzlD7qE/1x7OOST89N7IcMhd/Mg3g6xsgp?=
 =?us-ascii?Q?xyJqCUE/F7UBx5TboSVxcCyNsUe0gVxqn1dvqJyQjzsOeI7mDxkQ38Rfcg6j?=
 =?us-ascii?Q?7KDeuEF9bor8NDIlcrjrcWFClFzTGJDVGniA3xN8ZzvMLydNCSdwmLnVhy+j?=
 =?us-ascii?Q?XrW7cLLx0rzx1Mub5Fe86YgN2vciCu6G1dRTxTAPx2WJM3ZSiP4kKmaFsR2j?=
 =?us-ascii?Q?EipGUM64sFjqTE9IaPWResLTM9u+tBs0Bhpqk998y33cQgEFqIAReeMK8kSb?=
 =?us-ascii?Q?7q2HgJatotAAUdXOa7EuaUYrZc8RIybsGK+xjCb2XoSWguEUlmKiHTykFuJb?=
 =?us-ascii?Q?Xl5jTaiKI4pmj34l+TmXnBN5gKqW3t8HRtMIYETd2dP0xk3YqmxBJxn4tMOl?=
 =?us-ascii?Q?lv2YjVywhvAOcFEoobNYnp6H/2p1LdAGJdBG1kdUAVupC1hMcPk/1biOxFWn?=
 =?us-ascii?Q?I5BF82zHg6d5ezXbLaVyfOuAaGRdEA6ls2hC0GAgQFSCrR05FPckVp008Czs?=
 =?us-ascii?Q?JRWMpNu/BhzfWFvzAyla2i44MAcSGxJ9lW9Qh5L/HyqJvxtXkcuPUzsla/Lv?=
 =?us-ascii?Q?Yp7sJYyJPrYoUGXiH9f2yHqiNfIB7mf1ITdV7soDTIIPKw6D7O5arc/MTCml?=
 =?us-ascii?Q?i2c2hsfa9iEifIT4469ln4MrN3IoDDbOOAgxVGFw7baZg9GxvN2VvwKTCqot?=
 =?us-ascii?Q?PigmI3+7qCJmi+eUNLTA8BKGhe8tinQVJ6GAyuw93pes3mdyUz/qqFPGdNT6?=
 =?us-ascii?Q?mtsRGCbeyhZZvLRbj+YZtkKePJh6CtmW6zGU9yCfSoZZwA2Hen8KoJhTpYMf?=
 =?us-ascii?Q?MrSffJmzy+U8ovafSzxFh59CpKtE6WkgK2ihpHeE9dPnsGhL8m6rGLaSB/do?=
 =?us-ascii?Q?71nQGcQrfeg4EJuxZp0fWIe8/riscFEypNKjTBuqzE5+bsVBDjoiozx2o3Jn?=
 =?us-ascii?Q?EjYQgnmWO/gDcUMAXd4msYs1NpbZhqrEPFBkanP1tOnx98h+bBbatbaVkMDQ?=
 =?us-ascii?Q?h5xaUkmfakgnH8pIS5GMaS6FAgLKU5ZHKMAtzKAjiOL715gkUYno220P+7Mh?=
 =?us-ascii?Q?uPYXrpa1Q1eKpAJ17H00usnloktHs9YMBXNNblYnztSgE6JdLsNIWZNG0gyM?=
 =?us-ascii?Q?A/7jcyuMvaEEzeWdRlqFr/JNAVfxogpdREf6jOKoyi/g+8wVjroNANw1Ku9w?=
 =?us-ascii?Q?CUzPmWZsLseZkr439kH88Dfu?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db5d4c2-2988-45bc-117a-08d95e47c692
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB3154.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 10:47:42.2043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Imp9nSVBqvKzT4V9n57lAD/oWWa4tmsJQee4qQrjV+KDCIV9FFzAkvaAlV+n8PI9rVMjyLYPNIG6/mdIXk91hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR0201MB2225
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

print NR_KERNEL_MISC_RECLAIMABLE stat from show_free_areas
to check whether shrinker work correctly and current mem usage.

Signed-off-by: liuhailong <liuhailong@oppo.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 856b175c15a4..0eb29a56f349 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5904,6 +5904,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		" unevictable:%lu dirty:%lu writeback:%lu\n"
 		" slab_reclaimable:%lu slab_unreclaimable:%lu\n"
 		" mapped:%lu shmem:%lu pagetables:%lu bounce:%lu\n"
+		" kernel_misc_reclaimable:%lu\n"
 		" free:%lu free_pcp:%lu free_cma:%lu\n",
 		global_node_page_state(NR_ACTIVE_ANON),
 		global_node_page_state(NR_INACTIVE_ANON),
@@ -5920,6 +5921,7 @@ void show_free_areas(unsigned int filter, nodemask_t *nodemask)
 		global_node_page_state(NR_SHMEM),
 		global_node_page_state(NR_PAGETABLE),
 		global_zone_page_state(NR_BOUNCE),
+		global_node_page_state(NR_KERNEL_MISC_RECLAIMABLE),
 		global_zone_page_state(NR_FREE_PAGES),
 		free_pcp,
 		global_zone_page_state(NR_FREE_CMA_PAGES));
-- 
2.17.1

