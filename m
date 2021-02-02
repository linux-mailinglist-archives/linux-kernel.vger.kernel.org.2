Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C730B633
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 05:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhBBEKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 23:10:25 -0500
Received: from mail-eopbgr1320085.outbound.protection.outlook.com ([40.107.132.85]:56468
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229872AbhBBEKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 23:10:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ox5MoBBaievz1d3KVN/RFg/ZSwV8Jb5cPBjoOjQ3iE/Iiuj2H+kfmCqDKHU7roqufqjgOIk5L19a1Qc3a6NexnJF4s0BlErxZFu5TOk0sViPh2jn3erAZWK6KS/LTptvDxJ4t9gebSuVGqjE+WRXybIM3Js/MC/p0COVRHow9zlZhIQkdM6s7jEtzDbpR5Ps8eRfKx49l4k5yU9NGfFEvNPHZfIub68mwSUihaVsNY40c1RQH9tI+YyCKgLDikJ3O2b/BR4KMESUxUwPpeOAd0q7V9qBmSr1RgI3hjwFCSiQzl/RhPSeupJMHbimURqYhD8kaVPfzycdHAy2XN5YZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBawwQiqz/m20dm8ibcShrzdfrWO8CUl6pt/Ba16emc=;
 b=SSzNriGtGQtWLZrT7pH+Wbta+Vxj7WQMcjjHWwXjNnGsIClD2Zcxw4Zq7loWeQBh8BjwWALeziiqXlvw8lplrY4igN6pqkcx84lxZhv6p403CszXOD0kSdpgMrwAUqfFUHjKAZUoK0XBwnFwD7iY9wjOaB1yPD9LjE2XYOpJE6xDgPrbWhPUF7tlF9B7zULYVY6zSd0PGZI4tdxVxh5MTwllCgFqUy3eVA+iG9ENSq4zjwBesy/iFS0j2buPbW0nt98Xti9aU/zcxMrg023PEn2cbvGkbT4DJ3pvjnsmOUteBRNvFPMQXTpVkDncozsX2cwtkQWMpdo9TYxygozeXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBawwQiqz/m20dm8ibcShrzdfrWO8CUl6pt/Ba16emc=;
 b=lt35/yrMJI1jNCy287cd6HAl8MWiVHd5JOxve/SUap4+rTxT218XUForhxE+NL8UvmOr6D0bHWvokUuHKrlHhT3rTVvC6zirgwK9gj/ZAz0f3mvJfni1OaIWDqxFXsN+6IujaY8mqEjyBtZnso7ZIsqybB1t1jd2CtmrRR1zzPE=
Authentication-Results: lists.sourceforge.net; dkim=none (message not signed)
 header.d=none;lists.sourceforge.net; dmarc=none action=none
 header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2699.apcprd02.prod.outlook.com (2603:1096:4:58::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.19; Tue, 2 Feb 2021 04:08:48 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3805.026; Tue, 2 Feb 2021
 04:08:48 +0000
From:   Huang Jianan <huangjianan@oppo.com>
To:     fuse-devel@lists.sourceforge.net
Cc:     huangjianan@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: avoid deadlock when write fuse inode
Date:   Tue,  2 Feb 2021 12:08:30 +0800
Message-Id: <20210202040830.26043-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by HKAPR04CA0012.apcprd04.prod.outlook.com (2603:1096:203:d0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Tue, 2 Feb 2021 04:08:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 261bbea5-c3f5-43c3-667f-08d8c7303de3
X-MS-TrafficTypeDiagnostic: SG2PR02MB2699:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB26998ADAC011F0F6EFA610BDC3B59@SG2PR02MB2699.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3f/Q2NxXBh/8qZCwUXzhSnBXZjqF4an3m0rTlVdXZF11gfZBD0P4Ttts2oduliBvHb3FNnYbvPKyAmZCV5t+9+5t/PbpiAlWa7QPfHBvHMnBNa3boQRWc503+67+CjLpTIopNziqez3ArYejBBiEGsXkqO+h5f0jsoPDKHS/bgzaoTNo+rryeiXD9COY8rcL4dJ9bqllzwKuDVIvZykma8pVNezJNjJGcwam4h5bNMXdK+chAiX2LEXHmJmcDJbN/Uu+pq/7+cBUT0rarl9KE6EGHZQQcKcQ35PX9BWsmPnRWIhto6W922Tiihnk7eC+DM4ZBnWFd9XyoKhdekN58WpIrSLq1BEXL0f8p3eFkaLZeRXGgHLt4ILO6ptBxTHPrbTv/jXQoWhA+P9kzGSNllywOlzQNwAJob9rcfpEwVfhs538D6KgW3SYIK4SYa9vyHwuvyDXGT8PPOgDGwNAmGt3FgL1lMaFab5P2aWC4B5gSHgYWTYvwIDCs/MpXm3A61DPU0xyA/EOW4+fJzUUEIdIq9SwT1cTN1L3Q33/W/EWFgFQS0dW+/Jsobyd0SO4Ar34DPQOxcHEY3ENYSWb6jNOY9ba3+PGBPOrC/RUKM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(1076003)(36756003)(316002)(16526019)(66946007)(8676002)(2616005)(6486002)(6512007)(66556008)(66476007)(5660300002)(69590400011)(956004)(52116002)(6916009)(478600001)(86362001)(26005)(6506007)(83380400001)(4326008)(2906002)(6666004)(8936002)(186003)(11606006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?D3u09ONUD2bj37q/GRGH03eROdPuffgJZTQpNxa13X0O7x4dsBN7jpp7FSCU?=
 =?us-ascii?Q?5yLLj9oNEGEtfnt5B21rDxe3oqk3EUyPh9mhcMPHr0MvkZJd5w7uJJ7SYwhZ?=
 =?us-ascii?Q?8g9IFGsTBwtnOpSSwiEQMg5FcvrLXInAMndE1agD1raSKKM96sh5uL/JtjO9?=
 =?us-ascii?Q?ZT2S34GPB3oAeMkPM1dhBvmn5IXtRl65EbdPbjamL+KDQSvmvugJjeQ+3u3U?=
 =?us-ascii?Q?Qe7OFteZDZay2rWYKp1rRAlFjmNpu5KPNuAmaZkf3uQKc0Mc6nn97ymvXxJT?=
 =?us-ascii?Q?t6L0THckRdjOXgkyMTSodKBqLF6Tp9TrndNngTUCiN2q8jgjxQtP2desNspb?=
 =?us-ascii?Q?YScI9EJ0jr+jEqHVK7Lm8mIrTdxvu11fw7spaGzCO7IS4XAHjPjBECXM7Sel?=
 =?us-ascii?Q?m86SuSnt7EBbqDQ16wHw4WrKAbDEm3nREf3iBoltACSxOTvGa/pYGHMUAdWt?=
 =?us-ascii?Q?+xFAHyFlJmDiMAgfM6UV4RFONQ3wS58FnMcImgslQE7vK2Bk1ZWN2+VIxz50?=
 =?us-ascii?Q?Zexci85sZ7FJzK2E1fkKKfHfA9I8aglSFTX89oTnKqoi0b5m2wCF9o/XRaK+?=
 =?us-ascii?Q?YsnZeMAwwFGDoNS+Zmg7J/ZmsWtWbZbWbUfi/HYNhF25kqKgtdY0U5eQ8IF1?=
 =?us-ascii?Q?deN7Q5AwECLRhK/BDGNRah0W/i/KwehspNtZW8qSx3aZpK7MBpZZR3hTpe7M?=
 =?us-ascii?Q?1ciOf6anCtPg2KJpx1fQ+xastbb+uvGuqo5MPc9ZWi6F7AIGod39bUq+cXzy?=
 =?us-ascii?Q?B0X4/hErl9MeO5VcJkhzyKLcpdZpCb+8HLSzspBVaW69482jivUTkrMmgnTj?=
 =?us-ascii?Q?Ad13x9Eq3U7Jcpi5pvbel1q7S7qS3b7n4XIbf/W7Bcxtmjhnn/TWMoffcBsh?=
 =?us-ascii?Q?fNxgl0He0PtrhNdLpK3XyGC6dv+zSj05511yDZAfCDTMCH3dcwRAsHoI1FUT?=
 =?us-ascii?Q?004jcR+baPnNvQRc538l01AwPSYPIN1a3QDc6rp0jbDVgAV1r9qdIqoJyWRb?=
 =?us-ascii?Q?Yhcv49KJMfXp/Z+CjPvCCWQpaXcG6FHZb95Avh8XIRshBJzH3taSBnYwTJnF?=
 =?us-ascii?Q?8oOKLpYe?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 261bbea5-c3f5-43c3-667f-08d8c7303de3
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2021 04:08:48.7913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: duwZ+JidszYs+EjUMR3nF0heFqgE2Ge6+SnTJ05yuLPz2THEpEcGkVyJcaYpFh9DPr8yW16q/8VXRHlFNpCvyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2699
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We found the following deadlock situations in low memory scenarios:
Thread A                         Thread B
- __writeback_single_inode
 - fuse_write_inode
  - fuse_simple_request
   - __fuse_request_send
    - request_wait_answer
                                 - fuse_dev_splice_read
                                  - fuse_copy_fill
                                   - __alloc_pages_direct_reclaim
                                    - do_shrink_slab
                                     - super_cache_scan
                                      - shrink_dentry_list
                                       - dentry_unlink_inode
                                        - iput_final
                                         - inode_wait_for_writeback

The request and inode processed by Thread A and B are the same, which
causes a deadlock. To avoid this, we remove the __GFP_FS flag when
allocating memory in fuse_copy_fill, so there will be no memory
reclaimation in super_cache_scan.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 588f8d1240aa..e580b9d04c25 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -721,7 +721,7 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			if (cs->nr_segs >= cs->pipe->max_usage)
 				return -EIO;
 
-			page = alloc_page(GFP_HIGHUSER);
+			page = alloc_page(GFP_HIGHUSER & ~__GFP_FS);
 			if (!page)
 				return -ENOMEM;
 
-- 
2.25.1

