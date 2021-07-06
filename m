Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7264D3BC790
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 09:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhGFIA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:00:57 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:53676 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230255AbhGFIA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:00:56 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1667w3bD004229;
        Tue, 6 Jul 2021 07:58:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by mx0a-0064b401.pphosted.com with ESMTP id 39mjcfr0xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 07:58:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN6JGzo6SHJayd15j9UN40YkBwKH70QELJDX3tKTdkjgVEyWC2I1m2jE/yn0WxXdAaScBjJ0kOjhQ7qVqyLthyocUUjRxlUmORdZij7ZpqJnIAOd+BccK0xEUnDYbWK1igm5VLVmMHUGJS/OTtAncrbhDyq13UmJ8K5CvR2wO9sPZEgN8fSDnGlkVKBUITqwsX1vJBGN7J5wA0Q/JpkMRsdMQEFbVHL5NSHMmUae7Om2EY+FXZTx1QZXGbeAwEvdvniWIUhslZ5DPkqdOIY5sDXXka52x7Hf7QKvl8pZ4x2wVPoht1uhjRAulSAWaNu2DHGx/BaCYbcW1H1ZWghEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SArZnNb8qzGQgy4oSrJU+vLnxL0ElFHPEkTiUhvGRvE=;
 b=XnvMACsTTYeyV/UHXCc6066dOq3fkBRmvZcJ+t8fdWNN9KmVJDieVpWQT2V0bRkvqLUtfNY4PMAyzoSsGCT8xISlfLQpw0bQvJi2b2PYHJuKIe4avHHUoksMKe77GqXMYIdBtaNF8a+EaUnSh30gcnIv58uFIBDU9YIb+tvMS9qe4IY6/QksRbDwsHqVGpJGP1a4tKxvn9O/3PPgFFYrbInxHAu+ar4Kjmht1/Y867GwyxXS+oXfM1zeTr10Ckb65X4zx3M3ZA/nDBFmkoe28xAC/+m9R+EoxibG7GeBu38CG+ZITEOvUkIKKODh1NtVP2OinFnb0lXHJCsmBAH7KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SArZnNb8qzGQgy4oSrJU+vLnxL0ElFHPEkTiUhvGRvE=;
 b=b6Ya6IAtnQQ0ToTCs1oxywtwLcEmeA/CDzT5aSth6WSRWhAZc1ptX+meoGJCX6s7cRCwmuFOIu1LD10bJDG0+nFT8sQtXhOXfgIgtG8s6gmRrJBBM8HvhtzN+DofVaLzCVOmMB8aegyvN9yJ4v1/OpR28ym+Ih0dOcsv34nrL2c=
Authentication-Results: syzkaller.appspotmail.com; dkim=none (message not
 signed) header.d=none;syzkaller.appspotmail.com; dmarc=none action=none
 header.from=windriver.com;
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by BL0PR11MB3138.namprd11.prod.outlook.com (2603:10b6:208:7b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.31; Tue, 6 Jul
 2021 07:57:59 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::a140:b563:8725:5c2b]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::a140:b563:8725:5c2b%8]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 07:57:59 +0000
From:   qiang.zhang@windriver.com
To:     syzbot+0123a2b8f9e623d5b443@syzkaller.appspotmail.com,
        mgorman@techsingularity.net, akpm@linux-foundation.org,
        alobakin@pm.me, songmuchun@bytedance.com, wangqing@vivo.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/page_alloc: Fix sleeping function called in case of irqsdisable
Date:   Tue,  6 Jul 2021 15:57:54 +0800
Message-Id: <20210706075754.10726-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR0302CA0013.apcprd03.prod.outlook.com
 (2603:1096:202::23) To BL1PR11MB5478.namprd11.prod.outlook.com
 (2603:10b6:208:31d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK2PR0302CA0013.apcprd03.prod.outlook.com (2603:1096:202::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.8 via Frontend Transport; Tue, 6 Jul 2021 07:57:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1df76666-e0ce-41d0-7b93-08d94053c5c5
X-MS-TrafficTypeDiagnostic: BL0PR11MB3138:
X-Microsoft-Antispam-PRVS: <BL0PR11MB31387304A8AD4205E00B38DBFF1B9@BL0PR11MB3138.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PtkC//5Tk0ynh9mAPsor6dlEar21OlNn39sRgK5j8Rikmjc0HYPmgWUVvpG93W0Ni0EP+vEmr6PjrjDOIYRCQW5pEDF69KcG8oePt8B3AN2b3BLoctbtK6GhQvI985UsOqrZj29+JfEIZa1/eKQ1CxmWT3K/cIlt8enR7p+gPZI0qXOFDzx5xM6nCQpgoDgOflbjeGjczBB7Sem6Lo0biZvQzDaut/oPdccD3wjfCV25wxEcKRyr4awlNZOPCZLC0N0Eev3UJJjCo2Mgyv4V0jlbFwi/JpDyzyJfCJPGJL/wCF5ecsVxowY+trNY1BYpmXIOmNPimbPhy+AX7y7nVQxMFZCnzwRRQLqVgiZLmS6i5g9aT21orVtIs433hI3bucZ1xZK4vthqFn2XJZs+EgCOjt1ariHmqDDuCE42JNwceLwjKvbqzoTl+H6wRUX3+YTKoCl2YPiN0Abn6imTIebzyKkxj2uTWXmEJ360bj0YLgw2BYakqvzct7iosyj/O7osLBdxHR9oEqvjUs5EwfmJk3Snd1m8Q2YkTeqRq+VaGyPx3LwCk5x0uugsmv7Jtoi0kJVAGubp/xnomtxSD9NLXmiD2/cXn9YisS6fcEoU84j4R6AV/4JJyXeTLHyXTxRTybS5fbstsU0gkf3o8Kbb/OX3cULneCLvh6MROeEAksUyYb55JZoFTD7Zvw41JxErDzz2sBiPBHGVm7di4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39850400004)(2906002)(8936002)(316002)(52116002)(66556008)(66946007)(1076003)(6512007)(9686003)(66476007)(6486002)(956004)(6506007)(186003)(478600001)(5660300002)(26005)(16526019)(4326008)(38100700002)(8676002)(36756003)(83380400001)(38350700002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YRXaRy4r2CGFef56P3jgnZlxqzJMg2XAt3mrqTAGyClZAsPM6hrH7QOcHXMd?=
 =?us-ascii?Q?qC2lZHi6thRW0r9leBamBmk4uAqkTZSKEzvnJNB71sddVckpjibJXEwvWnGO?=
 =?us-ascii?Q?s6+niV47AfwcsPfYIRBHZTDTzJ1vs6JHLBuRceAx1h+VhYAPzrY3biMoF0/F?=
 =?us-ascii?Q?fz7dienGOsUTKh1sx8gm3yL1kaZJ3y3EU8gB5v7SK7op0nd3a3cNDB5mWGN0?=
 =?us-ascii?Q?K9RSDaKb5/6K1dOno/SpidtTxDjbKh6t3s/tgnnY9gFAKLin7et/L58LKWOh?=
 =?us-ascii?Q?CTNA0uldYI7IxQnVD7HRZq/Y66df9Nn1tL0MR7wuIC4QyrJUlej6Kr7Yyd3B?=
 =?us-ascii?Q?thwJfeps8PZLBavZ3PIp0gYFveN8qjzrEWVOiQuQs5jh4uBtwmdQMOKFIsL1?=
 =?us-ascii?Q?IKNbdhoJysTSuJEnbqlPIfehXhlJXKq0A6RpCzX1B/VzgvDKBBSJlFqXqCAq?=
 =?us-ascii?Q?PIEBPK5G2qLl1lThBDtdeiDSZyQwsfh4iw5oiqZb7x+c+XZLCkHqKnIy7mfD?=
 =?us-ascii?Q?G85OWAeKiJ0qjglIaAPViGNfgDBPxpxkthDn9HJERkx99LQ9XOmRYH6vXB2p?=
 =?us-ascii?Q?PpJm2wT82HbL60WIBK5dPuPzPqB+cQ/qnRCv7Y9KtzVfpOi8IgLW79RMPWa2?=
 =?us-ascii?Q?VpyTfTV0DN/H2gnDuIkR0TEaAIf9RCzE+dQT7jaGXJCSOt5cEEiXs5vwk/lQ?=
 =?us-ascii?Q?5S3qL8HeStcNMRB/VesniI0zTeCNagkqqthNu34B8TtiFW5STThWgfmsMilV?=
 =?us-ascii?Q?2JxJNYwQMAl6sa2t71rixWq6g0WiJSDxfG1mbCyCbFsZuea4ASyng3c8rWKx?=
 =?us-ascii?Q?UGukbk8Cj5NUSXWKoYTZSmLySFzxbX/AaOx05T4i7gE2ffAhDNlQua90ADFo?=
 =?us-ascii?Q?9E5/dQ0/pU35BvDYqzJFxyzFhXq+zHbBvSb/+uYIFgBk8TSv3n3o+s4ItkN0?=
 =?us-ascii?Q?Gy3nwzFU/l0XN+nHJtiW4gMF1Fsxmu5eNaiZVOkHYZuoRpeWiMWUYrC3uDC+?=
 =?us-ascii?Q?82PSHpVEHteWCJPMXDtlYIr7yrRv5GyAVA2Umf1bJu0GTbcfKwHl04JiJ6JA?=
 =?us-ascii?Q?shaV0vGwryaIdnAsnVHOgN6KVZoxp5dutLLF3RzXlRXLU3VHESUNTZ19WhAl?=
 =?us-ascii?Q?Yyn8rDTj/gCIANMuwZWvc8ujnonCgZS7+n8Mgjwajl4Wq1IqbBQaiB9tz8Yv?=
 =?us-ascii?Q?ZqyVhIt9CzZymcjDL0iep7YH1tAImF1pWVr8d4sLABeZTfXgOSb3q5Qnlbnf?=
 =?us-ascii?Q?PWmNcKTjWcwKx4T+5hl23dP1J3s2OhwFS0AFeplHolm/qXFseRnUvMY9q8de?=
 =?us-ascii?Q?maxLJ/8Z2+IExq8Hm+uxoWkh?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df76666-e0ce-41d0-7b93-08d94053c5c5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2021 07:57:59.6124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsX+LjpMmLWArcXR7T3VuY8wH5M4NIi6pIDvamytKxfWJQ5IZ2pvgnW4HFPbV+HW7KV3cW8CKcp6kLvf7AoJHV0AxnLr6dhmj8H4wbbSAuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3138
X-Proofpoint-GUID: ngRkXjjWGAHHN5lwSEdyCmKKzXmCdFP9
X-Proofpoint-ORIG-GUID: ngRkXjjWGAHHN5lwSEdyCmKKzXmCdFP9
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_02:2021-07-02,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1011 phishscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107060040
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

BUG: sleeping function called from invalid context at mm/page_alloc.c:5179
in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
.....
__dump_stack lib/dump_stack.c:79 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
 ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
 prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
 __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
 alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2147
 alloc_pages+0x238/0x2a0 mm/mempolicy.c:2270
 stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
 save_stack+0x15e/0x1e0 mm/page_owner.c:120
 __set_page_owner+0x50/0x290 mm/page_owner.c:181
 prep_new_page mm/page_alloc.c:2445 [inline]
 __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313
 alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]
 vm_area_alloc_pages mm/vmalloc.c:2775 [inline]
 __vmalloc_area_node mm/vmalloc.c:2845 [inline]
 __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947
 __vmalloc_node mm/vmalloc.c:2996 [inline]
 vzalloc+0x67/0x80 mm/vmalloc.c:3066

If the PAGE_OWNER is enabled, in __set_page_owner(), the pages will be
allocated to save calltrace info, due to the allocated action is executed
under irq disable(pagesets.lock be held), if the gfp variable contains
the flag that causes sleep, will trigger above information. the
prep_new_page() is not need to disable irq for protection, fix it through
enable irq before call prep_new_page().

Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the bulk page allocator")
Reported-by: syzbot+0123a2b8f9e623d5b443@syzkaller.appspotmail.com
Suggested-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 beacuse when acquire local_lock again, the current task may be run on another CPU,
 The @pcp and @pcp_list need to be reloaded.

 mm/page_alloc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d6e94cc8066c..9adbc0a20938 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5286,11 +5286,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
-	/* Attempt the batch allocation */
-	local_lock_irqsave(&pagesets.lock, flags);
-	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
-
 	while (nr_populated < nr_pages) {
 
 		/* Skip existing pages */
@@ -5299,14 +5294,23 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
+		/* Attempt the batch allocation */
+		local_lock_irqsave(&pagesets.lock, flags);
+		pcp = this_cpu_ptr(zone->per_cpu_pageset);
+		pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
+
 		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
 								pcp, pcp_list);
 		if (unlikely(!page)) {
 			/* Try and get at least one page */
 			if (!nr_populated)
 				goto failed_irq;
+
+			local_unlock_irqrestore(&pagesets.lock, flags);
 			break;
 		}
+
+		local_unlock_irqrestore(&pagesets.lock, flags);
 		nr_account++;
 
 		prep_new_page(page, 0, gfp, 0);
@@ -5317,8 +5321,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		nr_populated++;
 	}
 
-	local_unlock_irqrestore(&pagesets.lock, flags);
-
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
 	zone_statistics(ac.preferred_zoneref->zone, zone, nr_account);
 
-- 
2.17.1

